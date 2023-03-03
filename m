Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E446A90A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCCF56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:57:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD730E3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 21:57:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ky4so1672373plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 21:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677823073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUTfS2+3FPzIzEJDDkoc98vj3x8t5RG7C1KzgJzPKKw=;
        b=MeRKq2f7POvdWPnz4p9BFZj3a0y1Y0kOVy/b7vaUsaZhLVWSWYLKtvndL6Ifp4bjTq
         MKslva0R3P7hXssGD8CBf2N9cap1JB8p5GKZ14eOhVAUz4BZOpVVy1gEA+/c1vuLB4k/
         8mRhtTMc9HRxTuu6aYi8ZPEBAA/eMIIRy8kdNo4i151Zu/fAxHHMgDZAyJdxQ6l2yHP4
         +Fl9i4ffBwinRN4KjYTQAH4JkxeCyVlaXHzII4SCPVueyTC9dZdDLSooxoZKxWAh/awV
         rWuCe/YJS2HdGTKpBBRD6LP0jDeWuW/dFDO8xxK3nOPKarNstu0AphhmvTp6QiM+tOog
         5+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677823073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUTfS2+3FPzIzEJDDkoc98vj3x8t5RG7C1KzgJzPKKw=;
        b=PIl4meiAGAPfvLOcqwAU8ucGB9VDPUnUI6M9rOP/u01fMQgna6x07f0z6SUWn3Qmay
         DUhUgl/XwelFITLyuzR6DckVTNE8EL+BmLGnP75tgFo1Utgk8WHwxRxjXb/rF0mGZd5D
         WW2E+pUimyoqleFZUilHp/KHppZoUelkboBE3yuwESKzK6irrdH2+FrUv5aZ6PU8OJId
         XBb8e3LK/SiXaCpRhjaIkZFjF1uDMuvZznq1joB+QEXYPgoFLDggOfwdGLrvmqzHPUss
         XdyA49ZIU++dwLd/la4j1HUtASGqqpFZJbhV/P4xUbftkod48hCMYXcL+VJFhHT0MmMJ
         uJJQ==
X-Gm-Message-State: AO0yUKV9crNvUiHXXfOQWcqVOWmrc6XR2qWCHgUWLoN6y3cDgi7jBqt5
        ngfAA0FvNQ1OD/fEaEvifpUSdFsDANA=
X-Google-Smtp-Source: AK7set+eR3bLDGqvYUGZfUNSTKUCHn5whGal/ExY95sZvlgVuGNAa5zOZuvBWTQDKY+qB7w+1B5tug==
X-Received: by 2002:a05:6a20:8408:b0:cd:47dc:829e with SMTP id c8-20020a056a20840800b000cd47dc829emr659752pzd.12.1677823073280;
        Thu, 02 Mar 2023 21:57:53 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k13-20020aa790cd000000b005d6999eec90sm671274pfk.120.2023.03.02.21.57.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Mar 2023 21:57:52 -0800 (PST)
Date:   Fri, 3 Mar 2023 14:04:05 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
Message-ID: <20230303140405.000035a6.zbestahu@gmail.com>
In-Reply-To: <20230303031418.64553-1-frank.li@vivo.com>
References: <20230303031418.64553-1-frank.li@vivo.com>
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

On Fri,  3 Mar 2023 11:14:18 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> They are used during the erofs module init phase. Let's mark it as
> __init like any other function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/erofs/decompressor_lzma.c | 2 +-
>  fs/erofs/pcpubuf.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
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

Update them in internal.h as well?

