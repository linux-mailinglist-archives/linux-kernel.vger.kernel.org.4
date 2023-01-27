Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9340967F0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjA0V5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjA0V5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:57:02 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386EE303CD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:57:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jm10so6292678plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKzfgt+v7vR+OHj6BOXSVDAx4dpnw9L0NMMFFZQcv+U=;
        b=PQqsbW/89pCPZ3lw+99NVb1kKZ9MvTmb8gemTpHdNVxyUwmzgKDssqYcD1WRuFDcbQ
         KFPR+h216Ue38JAvpnMAzI3NB0ROrvdvKc2HWRymcaDlyqrzbKXYdRSCJ2qKXNlbrcYY
         tpopJYUqQXMFzCnwuTz9C2ump0JmwXbFF1elPn+QuAeYoaqvjd+57SgB/ylZ4rJC8BcK
         iXX7NzzihkKLqz1slSh3MM9I/GYcd94kO1lOekTcKY5PRe05OB57QtnsZl+vEexF3Hzq
         PC8bCG3mHR3gxbFYg6Qrv89vC1l/clIW/oQrwOEjwPFOD3uv3yTQUgHSnFqmCr58d04T
         VQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKzfgt+v7vR+OHj6BOXSVDAx4dpnw9L0NMMFFZQcv+U=;
        b=HOZULXfWTIhAktV8N/XNzkyrro5+YzYMmSXp6Hnj2hoaZWC9U0+1w2rNXnftEhz+6g
         kz4JmE30OENKXap9n+wjZ8uLTRj1Z+0GvJgpwLgMyLaB+YzwywUy+Vo+TuDRRHvYhwR2
         u72Fh6o+oW1roTziGNa1MjX/VADS59hP5mdteNg88kSZJREVJrUt8okuJHT5XKKN/7b+
         NOWBkuFf1BtYrxDtWnMdJ7BxcpWPakEXwVRviAFY/A9e4gjwPoQEa/xnNC3XB7RFO0CV
         shegCkEPzuv5OaeOcyGrhz4XBeS9gjwcsMDGtlb+0/r7948DbVMeH7oJPIwEPUl4K2u0
         92RQ==
X-Gm-Message-State: AO0yUKVG0bO82/Vk+gKAg1cB9JPPC1iBsYC5cQH4GquKvNdQw3r4DJqz
        ZjYYMjloHChV0VkCi7WomugL9Q==
X-Google-Smtp-Source: AK7set9YuQczNdM52Eo/zIBig84W3SqokoAEnqYzBBlTGPd6grRFSGVxa8u58cFLptL2CMStblTQTA==
X-Received: by 2002:a05:6a21:33aa:b0:b9:14e:184b with SMTP id yy42-20020a056a2133aa00b000b9014e184bmr175275pzb.3.1674856621468;
        Fri, 27 Jan 2023 13:57:01 -0800 (PST)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id l2-20020a63be02000000b004e25f1bb85csm298203pgf.54.2023.01.27.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:57:00 -0800 (PST)
Date:   Fri, 27 Jan 2023 13:56:56 -0800
From:   William McVicker <willmcvicker@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2] kbuild: do not automatically add -w option to modpost
Message-ID: <Y9RIqNnzkhfsm0dC@google.com>
References: <20230126022643.3664548-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126022643.3664548-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/2023, Masahiro Yamada wrote:
> When there is a missing input file (vmlinux.o or Module.symvers), you
> are likely to get a ton of unresolved symbols.
> 
> Currently, Kbuild automatically adds the -w option to allow module builds
> to continue with warnings instead of errors.
> 
> This may not be what the user expects because it is generally more useful
> to catch all possible issues at build time instead of at run time.
> 
> Let's not do what the user did not ask.
> 
> If you still want to build modules anyway, you can proceed by explicitly
> setting KBUILD_MODPOST_WARN=1. Since you may miss a real issue, you need
> to be aware of what you are doing.
> 
> Suggested-by: William McVicker <willmcvicker@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Fix the closing parenthesis
> 
>  scripts/Makefile.modpost | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 43343e13c542..0980c58d8afc 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -121,16 +121,14 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
>  
>  endif # ($(KBUILD_EXTMOD),)
>  
> -ifneq ($(missing-input),)
> -modpost-args += -w
> -endif
> -
>  quiet_cmd_modpost = MODPOST $@
>        cmd_modpost = \
>  	$(if $(missing-input), \
>  		echo >&2 "WARNING: $(missing-input) is missing."; \
>  		echo >&2 "         Modules may not have dependencies or modversions."; \
> -		echo >&2 "         You may get many unresolved symbol warnings.";) \
> +		echo >&2 "         You may get many unresolved symbol errors."; \
> +		echo >&2 "         You can set KBUILD_MODPOST_WARN=1 to turn errors into warning"; \
> +		echo >&2 "         if you want to proceed at your own risk.";) \
>  	$(MODPOST) $(modpost-args)
>  
>  targets += $(output-symdump)
> -- 
> 2.34.1
> 

Thanks for putting this together. I verified it's working as expected
for me. Feel free to add:

Tested-by: Will McVicker <willmcvicker@google.com>

Regards,
Will
