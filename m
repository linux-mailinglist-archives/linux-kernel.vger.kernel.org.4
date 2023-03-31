Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9996D1731
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCaGRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCaGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:17:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E0191C3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:17:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7715553pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680243461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0wmzkuX4AN1JDHvFbUNTXSHQNONwj8XqGOw+tG4o8w=;
        b=aIAo7trAO5Z0jzs18Ea+faRyv7OXzGrSdUtTgXpTZct2tJU2RcNLuX5v47FqLoqRNF
         JEXO6LTM9XEMb/Y4Udbl9EFwKeD2bzDgQi+164YD8Qc4psuP2Nx9KK08/qsDo6HdwJyj
         JYYj1mUnXts23tSlAs1hhiXWKJVm8HVc/MPRctwQ+MUwwFEg/ImtVMEZm8FpMNjt3bZg
         EPQ6ZK0Tm209Z+JCigsuyhvv8X5s1MJ15YZA1NZCuzg4tK9N4EWJl6aaWmMQay6/KE4B
         pCZmszIgOsVkreFqOVqSgGXKvAqcwXKEi5P5FnYVa0lfs9Vhy7FzFfPEWOdXzYX3qY/k
         DSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680243461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0wmzkuX4AN1JDHvFbUNTXSHQNONwj8XqGOw+tG4o8w=;
        b=wGTQlpSgNCEwjaofgLwFWDsu2atlsRzGpiBnHuRGllqlz/WQJL6Xo3NJl+QqD/iyRG
         S36szyo5AbzKxszgegEAL1eHn7XY4k4WDjce07te7PsLdr1XHDS75akarFvlo1fuPjMe
         bliOZFisF3y2mTVROnT6HUkjRC6Gmk/UNnKOpyuPpLxIxX3gzBO7joQ2mrKbYGWbHhGP
         1U1sRjJ3pdYnVgr/DMkYhB8FQ4ytozScU4c1LF1JKhJLyrgrawDU7MSKX6LV7VmurUUJ
         ZDdnypQBqklVueDjGAGLR00ZaH050e4REh6+gMaJ4exT5mBH/7SgKJu3aG+upg5+huw8
         7QXg==
X-Gm-Message-State: AAQBX9fWpHQqey76lJl5Tuwir8z/9ac7d0nGeRSOcbsSbJXXn5mtoUZ4
        k/lC1Dm5ki9x9FiKwxCGpDg=
X-Google-Smtp-Source: AKy350bpN6OvAeFupLLjtd2p/lhCyQIeUgc6WUTJqfaNOwtNVstKDN4dl7mBXrL9iBvGNu6n461/Rw==
X-Received: by 2002:a05:6a20:65a1:b0:cc:5f8f:4f7a with SMTP id p33-20020a056a2065a100b000cc5f8f4f7amr9415779pzh.27.1680243460735;
        Thu, 30 Mar 2023 23:17:40 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062d35807d3asm888030pfw.28.2023.03.30.23.17.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 23:17:40 -0700 (PDT)
Date:   Fri, 31 Mar 2023 14:24:31 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH v2 3/8] erofs: simplify erofs_xattr_generic_get()
Message-ID: <20230331142431.00003145.zbestahu@gmail.com>
In-Reply-To: <20230330082910.125374-4-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
        <20230330082910.125374-4-jefflexu@linux.alibaba.com>
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

On Thu, 30 Mar 2023 16:29:05 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> erofs_xattr_generic_get() won't be called from xattr handlers other than
> user/trusted/security xattr handler, and thus there's no need of extra
> checking.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/xattr.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index dc36a0c0919c..d76b74ece2e5 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -432,20 +432,9 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>  				   struct dentry *unused, struct inode *inode,
>  				   const char *name, void *buffer, size_t size)
>  {
> -	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> -
> -	switch (handler->flags) {
> -	case EROFS_XATTR_INDEX_USER:
> -		if (!test_opt(&sbi->opt, XATTR_USER))
> -			return -EOPNOTSUPP;
> -		break;
> -	case EROFS_XATTR_INDEX_TRUSTED:
> -		break;
> -	case EROFS_XATTR_INDEX_SECURITY:
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	if (handler->flags == EROFS_XATTR_INDEX_USER &&
> +	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
> +		return -EOPNOTSUPP;
>  
>  	return erofs_getxattr(inode, handler->flags, name, buffer, size);
>  }

