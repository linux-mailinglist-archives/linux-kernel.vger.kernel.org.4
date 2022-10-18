Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6967C6024BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJRGrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJRGrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:47:31 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C41A59B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:47:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VSTSjO6_1666075645;
Received: from 30.221.130.77(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSTSjO6_1666075645)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 14:47:26 +0800
Message-ID: <537dcde9-864e-37d4-1898-2307d254c69d@linux.alibaba.com>
Date:   Tue, 18 Oct 2022 14:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH] erofs: use kmap_local_page() only for erofs_bread()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221018035536.114792-1-hsiangkao@linux.alibaba.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221018035536.114792-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/22 11:55 AM, Gao Xiang wrote:
> Convert all mapped erofs_bread() users to use kmap_local_page()
> instead of kmap() or kmap_atomic().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/erofs/data.c     | 8 ++------
>  fs/erofs/internal.h | 3 +--
>  fs/erofs/xattr.c    | 8 ++++----
>  fs/erofs/zmap.c     | 4 ++--
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fe8ac0e163f7..3873395173b5 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -13,9 +13,7 @@
>  void erofs_unmap_metabuf(struct erofs_buf *buf)
>  {
>  	if (buf->kmap_type == EROFS_KMAP)
> -		kunmap(buf->page);
> -	else if (buf->kmap_type == EROFS_KMAP_ATOMIC)
> -		kunmap_atomic(buf->base);
> +		kunmap_local(buf->page);
>  	buf->base = NULL;
>  	buf->kmap_type = EROFS_NO_KMAP;
>  }
> @@ -54,9 +52,7 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>  	}
>  	if (buf->kmap_type == EROFS_NO_KMAP) {
>  		if (type == EROFS_KMAP)
> -			buf->base = kmap(page);
> -		else if (type == EROFS_KMAP_ATOMIC)
> -			buf->base = kmap_atomic(page);
> +			buf->base = kmap_local_page(page);
>  		buf->kmap_type = type;
>  	} else if (buf->kmap_type != type) {
>  		DBG_BUGON(1);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1701df48c446..67dc8e177211 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -253,8 +253,7 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>  
>  enum erofs_kmap_type {
>  	EROFS_NO_KMAP,		/* don't map the buffer */
> -	EROFS_KMAP,		/* use kmap() to map the buffer */
> -	EROFS_KMAP_ATOMIC,	/* use kmap_atomic() to map the buffer */
> +	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
>  };
>  
>  struct erofs_buf {
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 8106bcb5a38d..a62fb8a3318a 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -148,7 +148,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
>  
>  	it->blkaddr += erofs_blknr(it->ofs);
>  	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
> -				       EROFS_KMAP_ATOMIC);
> +				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
>  		return PTR_ERR(it->kaddr);
>  	it->ofs = erofs_blkoff(it->ofs);
> @@ -174,7 +174,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>  	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
>  
>  	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
> -				       EROFS_KMAP_ATOMIC);
> +				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
>  		return PTR_ERR(it->kaddr);
>  	return vi->xattr_isize - xattr_header_sz;
> @@ -368,7 +368,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP_ATOMIC);
> +						  EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
>  		it->it.blkaddr = blkaddr;
> @@ -580,7 +580,7 @@ static int shared_listxattr(struct listxattr_iter *it)
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP_ATOMIC);
> +						  EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
>  		it->it.blkaddr = blkaddr;
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bb66927e3d0..749a5ac943f4 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -178,7 +178,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	unsigned int advise, type;
>  
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +				      erofs_blknr(pos), EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  
> @@ -416,7 +416,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  out:
>  	pos += lcn * (1 << amortizedshift);
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +				      erofs_blknr(pos), EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  	return unpack_compacted_index(m, amortizedshift, pos, lookahead);

-- 
Thanks,
Jingbo
