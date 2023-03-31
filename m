Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E8F6D171F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCaGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaGEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:04:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7612BA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:04:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c4so3454268pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680242673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnq5zu1bFiAP4f0TH11pC6UpcZpEsYNIYEydKcUnmlM=;
        b=fvuKbD5+qaXRPuzfCvHzUd8xgCEwk8xJaeKItbh9uQKVYGx5XFRctlpiVkw/kLexd4
         ptsZjaBLlzYBwLShC+TzioS0FGxD2NWpZMCAB/jk0B0x1TphvpbdXkuKm+eUXVrgTJES
         5BrgNnnDQL/P+3B+I66NNEcZj4z9uxnk/6ugWSC+3MED+qf0X1PXS9RjXTolq8t6AD9r
         7sRuhX4GdSkeCTFBNctOmKVC1X2NzgL34j7G18406BSpZDSpHRfcY6p1Lcl8sWjdKhQn
         GzTkPsuAc2O2YlI22bqePnoRvzH9hbzgCNWEwGMi7sSoBj5tai42HySpCrTRn8keF3go
         aNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680242673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnq5zu1bFiAP4f0TH11pC6UpcZpEsYNIYEydKcUnmlM=;
        b=Z1qVO0cv1woLp6R5a4C15sZyDVOZa4vLZESxU/ZMQRnPuShO95to8zgKEmjgtoRqEm
         xZaDEK68lVMjFFWKKNP0Chct6DNN5tMAk/tmV66BZ2+sSg+aZgCoa2kOsoD2mn2KN6Uq
         EotJo0+dno7Bs100T9Lyp4Hy5le4geVXEN/SVEw5iUIshX2IQsVWpEZBWBrPCQfB15FK
         rWblcRRrq4hdW3mR3pwktGb5GdrpzBGQCydSiiS2kHtQYcv2E8L70JVsTcNPWWoHIl3O
         9n24dSxC1z+gcnDtxZ1fEcD1O7Pd3dOyPZtLWYXQHqAyfJjqPObrBfU/OSw6TmaWxBVX
         lXxA==
X-Gm-Message-State: AAQBX9eq1Dtzl7M/hgTGSiA+n6Zv1FmRLQoe3ake+gL1ZovtBYB71YKT
        whOk1CXXc6SAOOHz2yJfEPxnUog6wRI=
X-Google-Smtp-Source: AKy350aw96mfi1pNysToEbJwd3uwZrZxSTfSwJnRXOk1ePintMaHnL16QkUJ/IQYSlXCFgcjYDB40w==
X-Received: by 2002:a17:90b:1e49:b0:233:76bd:9faa with SMTP id pi9-20020a17090b1e4900b0023376bd9faamr29318409pjb.47.1680242673209;
        Thu, 30 Mar 2023 23:04:33 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a2e8a00b0023d1976cd34sm671080pjd.17.2023.03.30.23.04.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 23:04:33 -0700 (PDT)
Date:   Fri, 31 Mar 2023 14:11:24 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com
Subject: Re: [PATCH v2 2/8] erofs: rename init_inode_xattrs with erofs_
 prefix
Message-ID: <20230331141124.00006bcd.zbestahu@gmail.com>
In-Reply-To: <20230330082910.125374-3-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
        <20230330082910.125374-3-jefflexu@linux.alibaba.com>
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

On Thu, 30 Mar 2023 16:29:04 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Rename init_inode_xattrs() to erofs_init_inode_xattrs() without logic
> change.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/xattr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 9ccd57581bc7..dc36a0c0919c 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -29,7 +29,7 @@ struct xattr_iter {
>  	unsigned int ofs;
>  };
>  
> -static int init_inode_xattrs(struct inode *inode)
> +static int erofs_init_inode_xattrs(struct inode *inode)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
>  	struct xattr_iter it;
> @@ -405,7 +405,7 @@ int erofs_getxattr(struct inode *inode, int index,
>  	if (!name)
>  		return -EINVAL;
>  
> -	ret = init_inode_xattrs(inode);
> +	ret = erofs_init_inode_xattrs(inode);
>  	if (ret)
>  		return ret;
>  
> @@ -600,7 +600,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	int ret;
>  	struct listxattr_iter it;
>  
> -	ret = init_inode_xattrs(d_inode(dentry));
> +	ret = erofs_init_inode_xattrs(d_inode(dentry));
>  	if (ret == -ENOATTR)
>  		return 0;
>  	if (ret)

