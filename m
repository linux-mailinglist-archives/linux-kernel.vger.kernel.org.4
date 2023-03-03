Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933ED6A91A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCCHX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:23:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852081206A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:23:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso1455145pju.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677828206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz93y4kdxoZ7hJ0xuk+CK0VVYtlFxJEX4hat/VAoNdY=;
        b=iEgegoUfCH7h7UUe0htn6FFMe69sN/kbKTOydrIbSpyZCHny8htDhEMx/TolXDY8Ut
         eZULpTs77c3wUmd6IgdgyIcGDTLjRKFCABl3XYZHkcvsfblTp9EIIKoDbJc4zczbhC7K
         nI+2FHbD5qn1NzjDJRgpBLTnk1WNgD465zGQOTPrL+ZgcRgFD+mKxMR6UM3DXu02Xz7z
         3Vy9Eu9ZKp8bUvrhltKqxGXQTjXLPh79OSlMXQq6ZZ2y9ZFdaUG3iZ971lCbfQs/Goy5
         715uw5scNmfQku3KxZM9NPjWYlSDPEFvgtnj1zzL+TXR7xMEmxHtGNQhltdg/PksrKCO
         qTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677828206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vz93y4kdxoZ7hJ0xuk+CK0VVYtlFxJEX4hat/VAoNdY=;
        b=ipQQMREF56rt3IAbfO6z48Dayy4Yu6KPS+0QAnsjvLtA/8UdXcvstiQwDRqbPI+2mh
         d+XuemJHkkudLWJX/6iMdhILLpxO4VHsPxUG5t9E9Tpqbynyq7zExkgRPclj9UhoMzv3
         cMm6EVJX3QDTWwtDaM7KDZOeWfTUlt1ZvVqKUe5A6PQp7fJeHZ0a5p64Jr3VGQ5gvleb
         kaPAgf5TkYlG6uQNAyVV7HZu3xxQohA/dCKMQPzm16WaDKtuNBiCcsB7Yb00Z85LFg+4
         bmkZgraMIm8xWIyXEB45KgUd3Gl3O+c95oc8bs2D5fn0SNMbqaA6ibahZv8PQbdZhGrY
         pZvA==
X-Gm-Message-State: AO0yUKVUmIwm9YDkwKu5hfRcclEZyZkb3IADpI1H2M0/2AXYioKEcSJW
        1P9Tt7VBBQvvHWNcF4ZBFkZbFq66rvw=
X-Google-Smtp-Source: AK7set/PWCb3lresdBiBxYXymbS5tJ9mgK/xRyTK0LSPSUmQw+aF9UUa67AoPSmg8Vlo3XATWSqasA==
X-Received: by 2002:a05:6a20:244f:b0:be:a604:c683 with SMTP id t15-20020a056a20244f00b000bea604c683mr1344425pzc.45.1677828205823;
        Thu, 02 Mar 2023 23:23:25 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 19-20020a631253000000b004fb171df68fsm824216pgs.7.2023.03.02.23.23.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Mar 2023 23:23:25 -0800 (PST)
Date:   Fri, 3 Mar 2023 15:29:37 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, huyue2@coolpad.com
Subject: Re: [PATCH v2] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
Message-ID: <20230303152937.0000571a.zbestahu@gmail.com>
In-Reply-To: <20230303063731.66760-1-frank.li@vivo.com>
References: <20230303063731.66760-1-frank.li@vivo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Mar 2023 14:37:31 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> They are used during the erofs module init phase. Let's mark it as
> __init like any other function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
> v2:
> -change in internal.h
>  fs/erofs/decompressor_lzma.c | 2 +-
>  fs/erofs/internal.h          | 4 ++--
>  fs/erofs/pcpubuf.c           | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 091fd5adf818..307b37f0b9f5 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
>  	}
>  }
>  
> -int z_erofs_lzma_init(void)
> +int __init z_erofs_lzma_init(void)
>  {
>  	unsigned int i;
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3f3561d37d1b..1db018f8c2e8 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -486,7 +486,7 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>  void *erofs_get_pcpubuf(unsigned int requiredpages);
>  void erofs_put_pcpubuf(void *ptr);
>  int erofs_pcpubuf_growsize(unsigned int nrpages);
> -void erofs_pcpubuf_init(void);
> +void __init erofs_pcpubuf_init(void);
>  void erofs_pcpubuf_exit(void);
>  
>  int erofs_register_sysfs(struct super_block *sb);
> @@ -545,7 +545,7 @@ static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP;
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> -int z_erofs_lzma_init(void);
> +int __init z_erofs_lzma_init(void);
>  void z_erofs_lzma_exit(void);
>  int z_erofs_load_lzma_config(struct super_block *sb,
>  			     struct erofs_super_block *dsb,
> diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
> index a2efd833d1b6..c7a4b1d77069 100644
> --- a/fs/erofs/pcpubuf.c
> +++ b/fs/erofs/pcpubuf.c
> @@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
>  	return ret;
>  }
>  
> -void erofs_pcpubuf_init(void)
> +void __init erofs_pcpubuf_init(void)
>  {
>  	int cpu;
>  

