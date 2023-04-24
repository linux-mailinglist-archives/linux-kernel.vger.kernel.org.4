Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637146D1626
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCaDwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaDwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:52:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428DCA36
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:52:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l7so19206990pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680234748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbLtiTUui/GO9MzLgYAsvMU2H4RFeH7VFLRx6yIXGH4=;
        b=HPt3oQON0ZAMW1dd/Qg35ryiVkB9YsMsecBBaCAFStKFXXH/cH1D8fhXlQKUalmiZs
         +6P1xR0rWeTTd9RaTKrUv4kZ+f6HJLRpGUmXKuzok+5pDbKwNR4nuRCRoa8aAy1HJr8H
         6iuErwr6lSM1w2tOTZSgSTz3XgETtXjIq+cmV6LpHB7oA1yiw9l9gwS5kRNvyOhBJPQk
         D5jF4a+1XVl3pRX5lQBvRGTudUWq467z0y5H1w2s3lNab9eVy0FceDWwQuT0zseDA2iA
         dj0UUcjLfQJEeLyd2lSsWM0q5Fxo+a7Hkj7jjii9/CLjgsv3Lqfe57LxQpdPpV571qRV
         djiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680234748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbLtiTUui/GO9MzLgYAsvMU2H4RFeH7VFLRx6yIXGH4=;
        b=n2/Vme+cxQtY+F+WzzH9JueIt5H21V2/+/hSvxBxIl3CUhsHGXT44DdmlHW5lHu0be
         Iysjm7PWWi7nt1OdCk/r1/U/GDv4jr+8vNrTPtqFYCpW7h93Mg30NfQv59KFcDe9SDE+
         L2bVY1rp/38vQJdXotn9O8PbDOWsTWK240gXUR4r9Lh8nhDyT4s+FVbocgwnPpSiZ+zi
         OEfmag/PUNPTMrArVdLzFc7hBrOiOwHLxpPRmn1Ck241ZRQpBwlVa3oQwBuYCDK1Mo3b
         OsysjQaXdz1P7fVhYIa4pISrm2YB6ak1Iqh4r2uv/SnLpAMcSMTt0pcAxEFN4QizuqSV
         NW2g==
X-Gm-Message-State: AAQBX9cu+KlaCoj9s5DfOlc/6MsZ7VSIRNlP357NGXDr2y7MOQyQkW2i
        d2GdURIRPJWw4hbPwWuSikI1hN3a7TA=
X-Google-Smtp-Source: AKy350YKUT4yjdblZ0/0t4aRzcUYRmnjB9FtxT6+tdVKrtUsad8NSOkzcVBlzmV+ZOeOwdpz/fD8kQ==
X-Received: by 2002:a05:6a20:7908:b0:dd:ff4f:b856 with SMTP id b8-20020a056a20790800b000ddff4fb856mr9713922pzg.26.1680234748553;
        Thu, 30 Mar 2023 20:52:28 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005a7c892b435sm639784pfn.25.2023.03.30.20.52.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 20:52:28 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:59:19 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH v2 1/8] erofs: move several xattr helpers into xattr.c
Message-ID: <20230331115919.0000002d.zbestahu@gmail.com>
In-Reply-To: <20230330082910.125374-2-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
        <20230330082910.125374-2-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 16:29:03 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Move xattrblock_addr() and xattrblock_offset() helpers into xattr.c,
> as they are not used outside of xattr.c.
> 
> inlinexattr_header_size() has only one caller, and thus make it inlined
> into the caller directly.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/xattr.c | 48 +++++++++++++++++++++++++++++-------------------
>  fs/erofs/xattr.h | 23 -----------------------
>  2 files changed, 29 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 459caa3cd65d..9ccd57581bc7 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -7,6 +7,19 @@
>  #include <linux/security.h>
>  #include "xattr.h"
>  
> +static inline erofs_blk_t erofs_xattr_blkaddr(struct super_block *sb,
> +					      unsigned int xattr_id)
> +{
> +	return EROFS_SB(sb)->xattr_blkaddr +
> +	       erofs_blknr(sb, xattr_id * sizeof(__u32));
> +}
> +
> +static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
> +					      unsigned int xattr_id)
> +{
> +	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
> +}
> +
>  struct xattr_iter {
>  	struct super_block *sb;
>  	struct erofs_buf buf;
> @@ -157,7 +170,8 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>  	struct erofs_inode *const vi = EROFS_I(inode);
>  	unsigned int xattr_header_sz, inline_xattr_ofs;
>  
> -	xattr_header_sz = inlinexattr_header_size(inode);
> +	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
> +			  sizeof(u32) * vi->xattr_shared_count;
>  	if (xattr_header_sz >= vi->xattr_isize) {
>  		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
>  		return -ENOATTR;
> @@ -351,20 +365,18 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
>  static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = inode->i_sb;
> -	unsigned int i;
> +	struct super_block *const sb = it->it.sb;
> +	unsigned int i, xsid;
>  	int ret = -ENOATTR;
>  
>  	for (i = 0; i < vi->xattr_shared_count; ++i) {
> -		erofs_blk_t blkaddr =
> -			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
> -
> -		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP);
> +		xsid = vi->xattr_shared_xattrs[i];
> +		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> +						  it->it.blkaddr, EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
> -		it->it.blkaddr = blkaddr;
>  
>  		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
>  		if (ret != -ENOATTR)
> @@ -562,20 +574,18 @@ static int shared_listxattr(struct listxattr_iter *it)
>  {
>  	struct inode *const inode = d_inode(it->dentry);
>  	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = inode->i_sb;
> -	unsigned int i;
> +	struct super_block *const sb = it->it.sb;
> +	unsigned int i, xsid;
>  	int ret = 0;
>  
>  	for (i = 0; i < vi->xattr_shared_count; ++i) {
> -		erofs_blk_t blkaddr =
> -			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
> -
> -		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP);
> +		xsid = vi->xattr_shared_xattrs[i];
> +		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> +						  it->it.blkaddr, EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
> -		it->it.blkaddr = blkaddr;
>  
>  		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
>  		if (ret)
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index f7a21aaa9755..a65158cba14f 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -13,29 +13,6 @@
>  /* Attribute not found */
>  #define ENOATTR         ENODATA
>  
> -static inline unsigned int inlinexattr_header_size(struct inode *inode)
> -{
> -	return sizeof(struct erofs_xattr_ibody_header) +
> -		sizeof(u32) * EROFS_I(inode)->xattr_shared_count;
> -}
> -
> -static inline erofs_blk_t xattrblock_addr(struct super_block *sb,
> -					  unsigned int xattr_id)
> -{
> -#ifdef CONFIG_EROFS_FS_XATTR
> -	return EROFS_SB(sb)->xattr_blkaddr +
> -		xattr_id * sizeof(__u32) / sb->s_blocksize;
> -#else
> -	return 0;
> -#endif
> -}
> -
> -static inline unsigned int xattrblock_offset(struct super_block *sb,
> -					     unsigned int xattr_id)
> -{
> -	return (xattr_id * sizeof(__u32)) % sb->s_blocksize;
> -}
> -
>  #ifdef CONFIG_EROFS_FS_XATTR
>  extern const struct xattr_handler erofs_xattr_user_handler;
>  extern const struct xattr_handler erofs_xattr_trusted_handler;

