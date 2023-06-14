Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45577715449
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjE3Dzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE3Dzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:55:45 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DFC94
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 20:55:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjrz2SU_1685418938;
Received: from 30.221.134.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vjrz2SU_1685418938)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 11:55:39 +0800
Message-ID: <7a466054-2e52-b04c-2490-ea2b509ad350@linux.alibaba.com>
Date:   Tue, 30 May 2023 11:55:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/5] erofs: unify xattr_iter structures
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
 <20230518024551.123990-3-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230518024551.123990-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/18 10:45, Jingbo Xu wrote:
> Unify xattr_iter/listxattr_iter/getxattr_iter structures into
> erofs_xattr_iter structure.
> 
> This is in preparation for the following further cleanup.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 172 ++++++++++++++++++++---------------------------
>   1 file changed, 72 insertions(+), 100 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index b79be2a556ba..1e44aa108134 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -20,16 +20,22 @@ static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
>   	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
>   }
>   
> -struct xattr_iter {
> +struct erofs_xattr_iter {
>   	struct super_block *sb;
>   	struct erofs_buf buf;
>   	void *kaddr;
> -
>   	erofs_blk_t blkaddr;
>   	unsigned int ofs;
> +
> +	char *buffer;
> +	int buffer_size, buffer_ofs;
> +
> +	int index, infix_len;
> +	struct qstr name;
> +	struct dentry *dentry;
>   };
>   
> -static inline int erofs_xattr_iter_fixup(struct xattr_iter *it)
> +static inline int erofs_xattr_iter_fixup(struct erofs_xattr_iter *it)
>   {
>   	if (it->ofs < it->sb->s_blocksize)
>   		return 0;
> @@ -42,7 +48,7 @@ static inline int erofs_xattr_iter_fixup(struct xattr_iter *it)
>   	return 0;
>   }
>   
> -static inline int erofs_xattr_iter_fixup_aligned(struct xattr_iter *it)
> +static inline int erofs_xattr_iter_fixup_aligned(struct erofs_xattr_iter *it)
>   {
>   	if (it->ofs > it->sb->s_blocksize) {
>   		DBG_BUGON(1);
> @@ -54,7 +60,7 @@ static inline int erofs_xattr_iter_fixup_aligned(struct xattr_iter *it)
>   static int erofs_init_inode_xattrs(struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct xattr_iter it;
> +	struct erofs_xattr_iter it;
>   	unsigned int i;
>   	struct erofs_xattr_ibody_header *ih;
>   	struct super_block *sb = inode->i_sb;
> @@ -157,15 +163,15 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>    *                            and need to be handled
>    */
>   struct xattr_iter_handlers {
> -	int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry *entry);
> -	int (*name)(struct xattr_iter *_it, unsigned int processed, char *buf,
> +	int (*entry)(struct erofs_xattr_iter *it, struct erofs_xattr_entry *entry);
> +	int (*name)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
>   		    unsigned int len);
> -	int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
> -	void (*value)(struct xattr_iter *_it, unsigned int processed, char *buf,
> +	int (*alloc_buffer)(struct erofs_xattr_iter *it, unsigned int value_sz);
> +	void (*value)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
>   		      unsigned int len);
>   };
>   
> -static int inline_xattr_iter_begin(struct xattr_iter *it,
> +static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
>   				   struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> @@ -193,7 +199,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>    * Regardless of success or failure, `xattr_foreach' will end up with
>    * `ofs' pointing to the next xattr item rather than an arbitrary position.
>    */
> -static int xattr_foreach(struct xattr_iter *it,
> +static int xattr_foreach(struct erofs_xattr_iter *it,
>   			 const struct xattr_iter_handlers *op,
>   			 unsigned int *tlimit)
>   {
> @@ -284,18 +290,10 @@ static int xattr_foreach(struct xattr_iter *it,
>   	return err < 0 ? err : 0;
>   }
>   
> -struct getxattr_iter {
> -	struct xattr_iter it;
> -
> -	char *buffer;
> -	int buffer_size, index, infix_len;
> -	struct qstr name;
> -};
> -
> -static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
> +static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
>   				       struct erofs_xattr_entry *entry)
>   {
> -	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
> +	struct erofs_sb_info *sbi = EROFS_SB(it->sb);
>   	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
>   		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
>   
> @@ -313,11 +311,9 @@ static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
>   	return 0;
>   }
>   
> -static int xattr_entrymatch(struct xattr_iter *_it,
> +static int xattr_entrymatch(struct erofs_xattr_iter *it,
>   			    struct erofs_xattr_entry *entry)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
> -
>   	/* should also match the infix for long name prefixes */
>   	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
>   		return erofs_xattr_long_entrymatch(it, entry);
> @@ -329,32 +325,27 @@ static int xattr_entrymatch(struct xattr_iter *_it,
>   	return 0;
>   }
>   
> -static int xattr_namematch(struct xattr_iter *_it,
> +static int xattr_namematch(struct erofs_xattr_iter *it,
>   			   unsigned int processed, char *buf, unsigned int len)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
> -
>   	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
>   		return -ENOATTR;
>   	return 0;
>   }
>   
> -static int xattr_checkbuffer(struct xattr_iter *_it,
> +static int xattr_checkbuffer(struct erofs_xattr_iter *it,
>   			     unsigned int value_sz)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
>   	int err = it->buffer_size < value_sz ? -ERANGE : 0;
>   
>   	it->buffer_size = value_sz;
>   	return !it->buffer ? 1 : err;
>   }
>   
> -static void xattr_copyvalue(struct xattr_iter *_it,
> +static void xattr_copyvalue(struct erofs_xattr_iter *it,
>   			    unsigned int processed,
>   			    char *buf, unsigned int len)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
> -
>   	memcpy(it->buffer + processed, buf, len);
>   }
>   
> @@ -365,41 +356,40 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
>   	.value = xattr_copyvalue
>   };
>   
> -static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
> +static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
>   {
>   	int ret;
>   	unsigned int remaining;
>   
> -	ret = inline_xattr_iter_begin(&it->it, inode);
> +	ret = inline_xattr_iter_begin(it, inode);
>   	if (ret < 0)
>   		return ret;
>   
>   	remaining = ret;
>   	while (remaining) {
> -		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
> +		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
>   		if (ret != -ENOATTR)
>   			break;
>   	}
>   	return ret ? ret : it->buffer_size;
>   }
>   
> -static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
> +static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = it->it.sb;
> +	struct super_block *const sb = it->sb;
>   	unsigned int i, xsid;
>   	int ret = -ENOATTR;
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> -						  it->it.blkaddr, EROFS_KMAP);
> -		if (IS_ERR(it->it.kaddr))
> -			return PTR_ERR(it->it.kaddr);
> -
> -		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
> +		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->kaddr = erofs_read_metabuf(&it->buf, sb, it->blkaddr, EROFS_KMAP);
> +		if (IS_ERR(it->kaddr))
> +			return PTR_ERR(it->kaddr);
> +
> +		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
>   		if (ret != -ENOATTR)
>   			break;
>   	}
> @@ -421,31 +411,30 @@ int erofs_getxattr(struct inode *inode, int index,
>   		   void *buffer, size_t buffer_size)
>   {
>   	int ret;
> -	struct getxattr_iter it;
> +	struct erofs_xattr_iter it;
>   
>   	if (!name)
>   		return -EINVAL;
> +	if (strlen(name) > EROFS_NAME_LEN)
> +		return -ERANGE;

duplicated calculation.

>   
>   	ret = erofs_init_inode_xattrs(inode);
>   	if (ret)
>   		return ret;
>   
> -	it.index = index;
> -	it.name.len = strlen(name);
> -	if (it.name.len > EROFS_NAME_LEN)
> -		return -ERANGE;
> -
> -	it.it.buf = __EROFS_BUF_INITIALIZER;
> -	it.name.name = name;
> -
> -	it.buffer = buffer;
> -	it.buffer_size = buffer_size;
> +	it = (struct erofs_xattr_iter) {
> +		.buf	     = __EROFS_BUF_INITIALIZER,
> +		.sb	     = inode->i_sb,
> +		.name	     = QSTR_INIT(name, strlen(name)),
> +		.index	     = index,
> +		.buffer	     = buffer,
> +		.buffer_size = buffer_size,
> +	};

No need to zero out the other fields like this?

>   
> -	it.it.sb = inode->i_sb;
>   	ret = inline_getxattr(inode, &it);
>   	if (ret == -ENOATTR)
>   		ret = shared_getxattr(inode, &it);
> -	erofs_put_metabuf(&it.it.buf);
> +	erofs_put_metabuf(&it.buf);
>   	return ret;
>   }
>   
> @@ -491,25 +480,15 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
>   	NULL,
>   };
>   
> -struct listxattr_iter {
> -	struct xattr_iter it;
> -
> -	struct dentry *dentry;
> -	char *buffer;
> -	int buffer_size, buffer_ofs;
> -};
> -
> -static int xattr_entrylist(struct xattr_iter *_it,
> +static int xattr_entrylist(struct erofs_xattr_iter *it,
>   			   struct erofs_xattr_entry *entry)
>   {
> -	struct listxattr_iter *it =
> -		container_of(_it, struct listxattr_iter, it);
>   	unsigned int base_index = entry->e_name_index;
>   	unsigned int prefix_len, infix_len = 0;
>   	const char *prefix, *infix = NULL;
>   
>   	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
> -		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
> +		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
>   		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
>   			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
>   
> @@ -541,23 +520,17 @@ static int xattr_entrylist(struct xattr_iter *_it,
>   	return 0;
>   }
>   
> -static int xattr_namelist(struct xattr_iter *_it,
> +static int xattr_namelist(struct erofs_xattr_iter *it,
>   			  unsigned int processed, char *buf, unsigned int len)
>   {
> -	struct listxattr_iter *it =
> -		container_of(_it, struct listxattr_iter, it);
> -
>   	memcpy(it->buffer + it->buffer_ofs, buf, len);
>   	it->buffer_ofs += len;
>   	return 0;
>   }
>   
> -static int xattr_skipvalue(struct xattr_iter *_it,
> +static int xattr_skipvalue(struct erofs_xattr_iter *it,
>   			   unsigned int value_sz)
>   {
> -	struct listxattr_iter *it =
> -		container_of(_it, struct listxattr_iter, it);
> -
>   	it->buffer[it->buffer_ofs++] = '\0';
>   	return 1;
>   }
> @@ -569,42 +542,41 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
>   	.value = NULL
>   };
>   
> -static int inline_listxattr(struct listxattr_iter *it)
> +static int inline_listxattr(struct erofs_xattr_iter *it)
>   {
>   	int ret;
>   	unsigned int remaining;
>   
> -	ret = inline_xattr_iter_begin(&it->it, d_inode(it->dentry));
> +	ret = inline_xattr_iter_begin(it, d_inode(it->dentry));
>   	if (ret < 0)
>   		return ret;
>   
>   	remaining = ret;
>   	while (remaining) {
> -		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
> +		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
>   		if (ret)
>   			break;
>   	}
>   	return ret ? ret : it->buffer_ofs;
>   }
>   
> -static int shared_listxattr(struct listxattr_iter *it)
> +static int shared_listxattr(struct erofs_xattr_iter *it)
>   {
>   	struct inode *const inode = d_inode(it->dentry);
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = it->it.sb;
> +	struct super_block *const sb = it->sb;
>   	unsigned int i, xsid;
>   	int ret = 0;
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> -						  it->it.blkaddr, EROFS_KMAP);
> -		if (IS_ERR(it->it.kaddr))
> -			return PTR_ERR(it->it.kaddr);
> -
> -		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
> +		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->kaddr = erofs_read_metabuf(&it->buf, sb, it->blkaddr, EROFS_KMAP);
> +		if (IS_ERR(it->kaddr))
> +			return PTR_ERR(it->kaddr);
> +
> +		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
>   		if (ret)
>   			break;
>   	}
> @@ -615,7 +587,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>   			char *buffer, size_t buffer_size)
>   {
>   	int ret;
> -	struct listxattr_iter it;
> +	struct erofs_xattr_iter it;
>   
>   	ret = erofs_init_inode_xattrs(d_inode(dentry));
>   	if (ret == -ENOATTR)
> @@ -623,18 +595,18 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>   	if (ret)
>   		return ret;
>   
> -	it.it.buf = __EROFS_BUF_INITIALIZER;
> -	it.dentry = dentry;
> -	it.buffer = buffer;
> -	it.buffer_size = buffer_size;
> -	it.buffer_ofs = 0;
> -
> -	it.it.sb = dentry->d_sb;
> +	it = (struct erofs_xattr_iter) {
> +		.buf	     = __EROFS_BUF_INITIALIZER,
> +		.sb	     = dentry->d_sb,
> +		.dentry	     = dentry,
> +		.buffer	     = buffer,
> +		.buffer_size = buffer_size,
> +	};

Same here.

Thanks,
Gao Xiang

>   
>   	ret = inline_listxattr(&it);
>   	if (ret >= 0 || ret == -ENOATTR)
>   		ret = shared_listxattr(&it);
> -	erofs_put_metabuf(&it.it.buf);
> +	erofs_put_metabuf(&it.buf);
>   	return ret;
>   }
>   
