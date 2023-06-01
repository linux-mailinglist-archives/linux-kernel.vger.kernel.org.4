Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9693719166
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFADhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFADhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:37:07 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F28123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:37:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vk-pf-o_1685590621;
Received: from 30.97.48.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk-pf-o_1685590621)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 11:37:02 +0800
Message-ID: <8e69dcec-b038-4941-1157-8d80fd3f1afa@linux.alibaba.com>
Date:   Thu, 1 Jun 2023 11:37:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 6/6] erofs: use separate xattr parsers for
 listxattr/getxattr
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
 <20230601024347.108469-7-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230601024347.108469-7-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/1 10:43, Jingbo Xu wrote:
> There's a callback styled xattr parser, i.e. xattr_foreach(), which is
> shared among listxattr and getxattr.  Convert it to two separate xattr
> parsers for listxattr and getxattr.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---

...

> +static int erofs_xattr_body(struct erofs_xattr_iter *it,
> +			    unsigned int len, bool copy)

It might be better to call it as "erofs_xattr_handle_string".


>   {
> -	unsigned int base_index = entry->e_name_index;
> -	unsigned int prefix_len, infix_len = 0;
> +	unsigned int slice, processed = 0;
> +	void *buf;
> +	int err;
> +
> +	while (processed < len) {
> +		err = erofs_xattr_iter_fixup(it, true);
> +		if (err)
> +			return err;
> +
> +		buf = it->kaddr + it->ofs;
> +		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
> +			      len - processed);
> +		if (copy) {
> +			memcpy(it->buffer + it->buffer_ofs, buf, slice);
> +			it->buffer_ofs += slice;
> +		} else if (memcmp(it->name.name + it->infix_len + processed,
> +				  buf, slice)) {
> +			return -ENOATTR;
> +		}
> +		it->ofs += slice;
> +		processed += slice;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Wen returning 0 or ENOATTR, erofs_[list|get]xattr_foreach() will end up
> + * with `ofs' pointing to the next xattr item rather than an arbitrary position.
> + */
> +static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
> +{
> +	struct erofs_xattr_entry entry;
> +	unsigned int base_index, prefix_len, infix_len = 0;
>   	const char *prefix, *infix = NULL;
> +	int err;
>   
> -	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
> +	/* 1. handle xattr entry */
> +	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
> +	it->ofs += sizeof(struct erofs_xattr_entry);
> +	base_index = entry.e_name_index;
> +
> +	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
>   		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
>   		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> -			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> +			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
>   
>   		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> -			return 1;
> +			goto out;
>   		infix = pf->prefix->infix;
>   		infix_len = pf->infix_len;
>   		base_index = pf->prefix->base_index;
> @@ -392,53 +252,99 @@ static int xattr_entrylist(struct erofs_xattr_iter *it,
>   
>   	prefix = erofs_xattr_prefix(base_index, it->dentry);
>   	if (!prefix)
> -		return 1;
> +		goto out;
>   	prefix_len = strlen(prefix);
>   
>   	if (!it->buffer) {
> -		it->buffer_ofs += prefix_len + infix_len +
> -					entry->e_name_len + 1;
> -		return 1;
> +		it->buffer_ofs += prefix_len + infix_len + entry.e_name_len + 1;
> +		goto out;
>   	}
>   
>   	if (it->buffer_ofs + prefix_len + infix_len +
> -		+ entry->e_name_len + 1 > it->buffer_size)
> +		entry.e_name_len + 1 > it->buffer_size)
>   		return -ERANGE;
>   
>   	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
>   	memcpy(it->buffer + it->buffer_ofs + prefix_len, infix, infix_len);
>   	it->buffer_ofs += prefix_len + infix_len;
> -	return 0;
> -}
>   
> -static int xattr_namelist(struct erofs_xattr_iter *it,
> -			  unsigned int processed, char *buf, unsigned int len)
> -{
> -	memcpy(it->buffer + it->buffer_ofs, buf, len);
> -	it->buffer_ofs += len;
> +	/* 2. handle xattr name (err can't be ENOATTR) */
> +	err = erofs_xattr_body(it, entry.e_name_len, true);
> +	if (err)
> +		return err;
> +
> +	it->buffer[it->buffer_ofs++] = '\0';
> +	it->ofs += le16_to_cpu(entry.e_value_size);
> +	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
> +	return 0;
> +out:
> +	it->ofs = it->next_ofs;
>   	return 0;
>   }
>   
> -static int xattr_skipvalue(struct erofs_xattr_iter *it,
> -			   unsigned int value_sz)
> +static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
>   {
> -	it->buffer[it->buffer_ofs++] = '\0';
> -	return 1;
> -}
> +	struct erofs_xattr_entry entry;
> +	unsigned int value_sz;
> +	int err;
>   
> -static const struct xattr_iter_handlers list_xattr_handlers = {
> -	.entry = xattr_entrylist,
> -	.name = xattr_namelist,
> -	.alloc_buffer = xattr_skipvalue,
> -	.value = NULL
> -};
> +	/* 1. handle xattr entry */
> +	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
> +	it->ofs += sizeof(struct erofs_xattr_entry);
> +	value_sz = le16_to_cpu(entry.e_value_size);
> +
> +	err = -ENOATTR;
> +	/* should also match the infix for long name prefixes */
> +	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
> +		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
> +		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> +			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> +
> +		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> +			goto out;
> +
> +		if (it->index != pf->prefix->base_index ||
> +		    it->name.len != entry.e_name_len + pf->infix_len)
> +			goto out;
> +
> +		if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
> +			goto out;
> +
> +		it->infix_len = pf->infix_len;
> +	} else {
> +		if (it->index != entry.e_name_index ||
> +		    it->name.len != entry.e_name_len)
> +			goto out;

please use "} else if {" here

> +		it->infix_len = 0;
> +	}
> +

Thanks,
Gao Xiang
