Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EF64741A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLHQVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLHQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:21:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC06FF01
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:21:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2040283pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrJ14ayLT7F+1zAXfd85zeuS9jwgRhVrcw7Y0+tLb6Y=;
        b=g8P4/eojTrI2HBCiA4zp/WCQXL2NPFnOjDEnV/senXcKqmtpvz8/sl35IibIlf56Xb
         ZynllzhNzGK/ud3dS9sa5QvNDOO/hi6CMtTwElRCKkJcwqr16oyYBna2FSFSeQmU9wko
         JEFCS20QBntq7LbVs0aCBuYQzFzL9J9+gjq70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrJ14ayLT7F+1zAXfd85zeuS9jwgRhVrcw7Y0+tLb6Y=;
        b=xMLEq620ESWiCtGUIF/3HZApGXaxB6W1uR9nNODXCt0l9NbXc/xUKipyTcjDjB6Dp1
         Bd30g1jrpOfAyoUbJ1gtG0lXToh+he/P7Ds2Y/a4Ab0gqGXpqxwX7+ahVAVRs5ueJ5CN
         SOSiry1eJS9/JhCq2nsMa4dobGrDm2QM1EGuVSJ0XlvPFm7Fnc2JpGX/ucdJKFsZVROP
         Y0tDstA+m5wYvx1eVzNLhCOUR2rnDczhEJ2sN+fmu1L+uzG7yw/wIMYHUQE1jzrB090L
         0t9lIudIdaBUJau1ntSbjL9/DxVwRJOh3WbRakAbs9St785ReteD7Dr5MWYnqpAjawtG
         uz7A==
X-Gm-Message-State: ANoB5plvFYXzUqEF4gfXrnMWEOQdQYNHvgzwhmgw7DdTV2p6IBv/KLF0
        0m9pibdVtpqql7WPk/70757G3A==
X-Google-Smtp-Source: AA0mqf7RMfVU6OSBfzQOkqOeCkx3TWMEkSgjK0ClXrEprodhsyI5WvH+XKjOP1ImKWPf16MmgfyfaA==
X-Received: by 2002:a17:90a:9f46:b0:219:b1db:f7e3 with SMTP id q6-20020a17090a9f4600b00219b1dbf7e3mr23917526pjv.64.1670516490729;
        Thu, 08 Dec 2022 08:21:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm7924158pjb.1.2022.12.08.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:21:30 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:21:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Message-ID: <202212080818.28476A4@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-3-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-3-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:35PM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> Basic tests to ensure that user/group/other execute bits cannot be
> changed after applying F_SEAL_EXEC to a memfd.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> Co-developed-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 129 ++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 94df2692e6e4..1d7e7b36bbdd 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -28,12 +28,44 @@
>  #define MFD_DEF_SIZE 8192
>  #define STACK_SIZE 65536
>  
> +#ifndef F_SEAL_EXEC
> +#define F_SEAL_EXEC	0x0020
> +#endif
> +
> +#ifndef MAX_PATH
> +#define MAX_PATH 256
> +#endif

I'd expect this to be named PATH_MAX, and it shouldn't need to have an
#ifdef? That's a regular POSIX define.

Otherwise, looks good. Though it'd be nice if this test use
kselftest_harness.h, but that's not your problem. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
