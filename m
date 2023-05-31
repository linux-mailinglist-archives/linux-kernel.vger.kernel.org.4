Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0BC7177AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjEaHSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjEaHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:18:42 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107B183
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:18:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjwYf5-_1685517510;
Received: from 30.221.133.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjwYf5-_1685517510)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 15:18:31 +0800
Message-ID: <faf461c7-ab15-b5e3-664e-7773cac7386d@linux.alibaba.com>
Date:   Wed, 31 May 2023 15:18:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 5/5] erofs: use separate xattr parsers for
 listxattr/getxattr
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230531031330.3504-1-jefflexu@linux.alibaba.com>
 <20230531031330.3504-6-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230531031330.3504-6-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/31 11:13, Jingbo Xu wrote:
> There's a callback styled xattr parser, i.e. xattr_foreach(), which is
> shared among listxattr and getxattr.  Convert it to two separate xattr
> parsers for listxattr and getxattr.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 372 ++++++++++++++++++++---------------------------
>   1 file changed, 155 insertions(+), 217 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 074743e2b271..438fcf22b230 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -12,7 +12,7 @@ struct erofs_xattr_iter {
>   	struct erofs_buf buf;
>   	void *kaddr;
>   	erofs_blk_t blkaddr;
> -	unsigned int ofs;
> +	unsigned int ofs, next_ofs;
>   
>   	char *buffer;
>   	int buffer_size, buffer_ofs;
> @@ -141,183 +141,6 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>   	return ret;
>   }
>   
> -/*
> - * the general idea for these return values is
> - * if    0 is returned, go on processing the current xattr;
> - *       1 (> 0) is returned, skip this round to process the next xattr;
> - *    -err (< 0) is returned, an error (maybe ENOXATTR) occurred
> - *                            and need to be handled
> - */
> -struct xattr_iter_handlers {
> -	int (*entry)(struct erofs_xattr_iter *it, struct erofs_xattr_entry *entry);
> -	int (*name)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
> -		    unsigned int len);
> -	int (*alloc_buffer)(struct erofs_xattr_iter *it, unsigned int value_sz);
> -	void (*value)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
> -		      unsigned int len);
> -};
> -
> -/*
> - * Regardless of success or failure, `xattr_foreach' will end up with
> - * `ofs' pointing to the next xattr item rather than an arbitrary position.
> - */
> -static int xattr_foreach(struct erofs_xattr_iter *it,
> -			 const struct xattr_iter_handlers *op,
> -			 unsigned int *tlimit)
> -{
> -	struct erofs_xattr_entry entry;
> -	unsigned int value_sz, processed, slice;
> -	int err;
> -
> -	/* 0. fixup blkaddr, ofs, ipage */
> -	err = erofs_xattr_iter_fixup(it, false);
> -	if (err)
> -		return err;
> -
> -	/*
> -	 * 1. read xattr entry to the memory,
> -	 *    since we do EROFS_XATTR_ALIGN
> -	 *    therefore entry should be in the page
> -	 */
> -	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
> -	if (tlimit) {
> -		unsigned int entry_sz = erofs_xattr_entry_size(&entry);
> -
> -		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
> -		if (*tlimit < entry_sz) {
> -			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> -		}
> -		*tlimit -= entry_sz;
> -	}
> -
> -	it->ofs += sizeof(struct erofs_xattr_entry);
> -	value_sz = le16_to_cpu(entry.e_value_size);
> -
> -	/* handle entry */
> -	err = op->entry(it, &entry);
> -	if (err) {
> -		it->ofs += entry.e_name_len + value_sz;
> -		goto out;
> -	}
> -
> -	/* 2. handle xattr name (ofs will finally be at the end of name) */
> -	processed = 0;
> -
> -	while (processed < entry.e_name_len) {
> -		err = erofs_xattr_iter_fixup(it, true);
> -		if (err)
> -			goto out;
> -
> -		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
> -			      entry.e_name_len - processed);
> -
> -		/* handle name */
> -		err = op->name(it, processed, it->kaddr + it->ofs, slice);
> -		if (err) {
> -			it->ofs += entry.e_name_len - processed + value_sz;
> -			goto out;
> -		}
> -
> -		it->ofs += slice;
> -		processed += slice;
> -	}
> -
> -	/* 3. handle xattr value */
> -	processed = 0;
> -
> -	if (op->alloc_buffer) {
> -		err = op->alloc_buffer(it, value_sz);
> -		if (err) {
> -			it->ofs += value_sz;
> -			goto out;
> -		}
> -	}
> -
> -	while (processed < value_sz) {
> -		err = erofs_xattr_iter_fixup(it, true);
> -		if (err)
> -			goto out;
> -
> -		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
> -			      value_sz - processed);
> -		op->value(it, processed, it->kaddr + it->ofs, slice);
> -		it->ofs += slice;
> -		processed += slice;
> -	}
> -
> -out:
> -	/* xattrs should be 4-byte aligned (on-disk constraint) */
> -	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
> -	return err < 0 ? err : 0;
> -}
> -
> -static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
> -				       struct erofs_xattr_entry *entry)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(it->sb);
> -	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> -		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> -
> -	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> -		return -ENOATTR;
> -
> -	if (it->index != pf->prefix->base_index ||
> -	    it->name.len != entry->e_name_len + pf->infix_len)
> -		return -ENOATTR;
> -
> -	if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
> -		return -ENOATTR;
> -
> -	it->infix_len = pf->infix_len;
> -	return 0;
> -}
> -
> -static int xattr_entrymatch(struct erofs_xattr_iter *it,
> -			    struct erofs_xattr_entry *entry)
> -{
> -	/* should also match the infix for long name prefixes */
> -	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
> -		return erofs_xattr_long_entrymatch(it, entry);
> -
> -	if (it->index != entry->e_name_index ||
> -	    it->name.len != entry->e_name_len)
> -		return -ENOATTR;
> -	it->infix_len = 0;
> -	return 0;
> -}
> -
> -static int xattr_namematch(struct erofs_xattr_iter *it,
> -			   unsigned int processed, char *buf, unsigned int len)
> -{
> -	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
> -		return -ENOATTR;
> -	return 0;
> -}
> -
> -static int xattr_checkbuffer(struct erofs_xattr_iter *it,
> -			     unsigned int value_sz)
> -{
> -	int err = it->buffer_size < value_sz ? -ERANGE : 0;
> -
> -	it->buffer_ofs = value_sz;
> -	return !it->buffer ? 1 : err;
> -}
> -
> -static void xattr_copyvalue(struct erofs_xattr_iter *it,
> -			    unsigned int processed,
> -			    char *buf, unsigned int len)
> -{
> -	memcpy(it->buffer + processed, buf, len);
> -}
> -
> -static const struct xattr_iter_handlers find_xattr_handlers = {
> -	.entry = xattr_entrymatch,
> -	.name = xattr_namematch,
> -	.alloc_buffer = xattr_checkbuffer,
> -	.value = xattr_copyvalue
> -};
> -
>   static bool erofs_xattr_user_list(struct dentry *dentry)
>   {
>   	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
> @@ -370,20 +193,70 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
>   	NULL,
>   };
>   
> -static int xattr_entrylist(struct erofs_xattr_iter *it,
> -			   struct erofs_xattr_entry *entry)
> +typedef int (*erofs_xattr_body_handler)(struct erofs_xattr_iter *it,
> +		unsigned int processed, char *buf, unsigned int len);
> +
> +static int erofs_xattr_namematch(struct erofs_xattr_iter *it,
> +		unsigned int processed, char *buf, unsigned int len)
> +{
> +	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
> +		return -ENOATTR;
> +	return 0;
> +}
> +
> +static int erofs_xattr_copy(struct erofs_xattr_iter *it,
> +		unsigned int unused, char *buf, unsigned int len)
> +{
> +	memcpy(it->buffer + it->buffer_ofs, buf, len);
> +	it->buffer_ofs += len;
> +	return 0;
> +}
> +
> +static int erofs_xattr_body(struct erofs_xattr_iter *it, unsigned int len,
> +			    erofs_xattr_body_handler handler)


could we change erofs_xattr_body_handler into a bool (e.g.
bool copy_or_match)?

> +{
> +	unsigned int slice, processed = 0;
> +
> +	while (processed < len) {
> +		int err = erofs_xattr_iter_fixup(it, true);
> +		if (err)
> +			return err;
> +
> +		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
> +			      len - processed);
> +		err = handler(it, processed, it->kaddr + it->ofs, slice);

So that an indirect call could be avoided, as:

		if (copy_or_match) {
			memcpy(it->buffer + it->buffer_ofs, buf, len);
			it->buffer_ofs += len;
		} else if (memcmp(buf,
				it->name.name + it->infix_len + processed, len)) {
			return -ENOATTR;
		}

?

Thanks,
Gao Xiang
