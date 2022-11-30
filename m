Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7720863D581
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiK3MXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiK3MXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:23:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A302BB2F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:23:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z4so26842621wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmOlYL+T1VcRv6GwjlbPVapzopZmzHsyfLnHJwg422g=;
        b=QCk0NxAgMjKoO4MZ8ZHi9965Dj+VVNgu8hf2o4ri7t0luu+dp/7ZqfpCMg1OtndLa9
         /n4esAFm2evvBeQ2rIcbRj3N2/ZbfyB9snQK4VMcjf6v2MWVXu/FqZ8K6KIE5vaX92i2
         SAWV+NFe1eeM5IwhUUSserYBOPfFirV/797GOGfnuiVVbdfptXSlH9/imQGR1pcm/B9n
         ahUhWS1wsi43AApK+CvetjVznIv7HLh1bMjbpmHwGu/MAXT8MUZiHbhePwqr5NOllh9T
         frJVR85URP7gEJpwCbppmqhwU8sszJ7UfRhZ/yG17wvAln9AHw4AyUdwYcHaFUent4Rv
         l78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmOlYL+T1VcRv6GwjlbPVapzopZmzHsyfLnHJwg422g=;
        b=AU+cUxjeqvJiTG3R7bOIEM+0wXVw4quCnm4ZjWvqa3j9S5EDTKxJVXMmRBJRwDw8tQ
         OGRFlnKMfWtAIvrRHa8AEsIM22daoBugCmqnLNo/0XF0diOjXSiibYVP91ZXdQs2AJM3
         4X6Viwj1NnW856+ff3ra4Dn7nUBtDDOJR6sV/NxqLIrrB6NwVRmFFktAP7ApAG3NoP6F
         P85DIcGrMi6QERSG1WcRtLZmyy3IE6RzZ9Aey2ue+zUsTqMzNVRpwVk8C/q5DTODu+Ra
         wDrhZj2tFNt4/XKnEH+r2INQJDvHESZ9H3H9LdD2WDi3ghMgXPX61ZjoytiFhHNe5V9J
         bX9A==
X-Gm-Message-State: ANoB5pmDO408Mv9YlyzGiajo3RbSMsiDPclJipwBkdbKqDyQFNjsAXrh
        OASYHV/Vf8QWHv13Asek+Wm+J+ChW7AusQ==
X-Google-Smtp-Source: AA0mqf50/mjoaNarDfeLyTKta3nb6bZmEZM+IvrC04UJESisouehFNwB7mVWUMM2IcSOwllHF4y3Ag==
X-Received: by 2002:a5d:456c:0:b0:236:7135:24da with SMTP id a12-20020a5d456c000000b00236713524damr37935677wrc.264.1669810995282;
        Wed, 30 Nov 2022 04:23:15 -0800 (PST)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id o35-20020a05600c512300b003a3442f1229sm5986073wms.29.2022.11.30.04.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 04:23:14 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:23:10 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 2/2] modpost: Include '.text.*' in TEXT_SECTIONS
Message-ID: <Y4dLLnc4LTX9UHaN@google.com>
References: <20221129190123.872394-1-nathan@kernel.org>
 <20221129190123.872394-3-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129190123.872394-3-nathan@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:01:23PM -0700, Nathan Chancellor wrote:
> Commit 6c730bfc894f ("modpost: handle -ffunction-sections") added
> ".text.*" to the OTHER_TEXT_SECTIONS macro to fix certain section
> mismatch warnings. Unfortunately, this makes it impossible for modpost
> to warn about section mismatchs with LTO, which implies
> '-ffunction-sections', as all functions are put in their own
> '.text.<func_name>' sections, which may still reference functions in
> sections they are not supposed to, such as __init.
> 
> Fix this by moving ".text.*" into TEXT_SECTIONS, so that configurations
> with '-ffunction-sections' will see warnings about mismatched sections.
> 
> Link: https://lore.kernel.org/Y39kI3MOtVI5BAnV@google.com/
> Reported-by: Vincent Donnefort <vdonnefort@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

Tested-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2c80da0220c3..c861beabc128 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -823,10 +823,10 @@ static void check_section(const char *modname, struct elf_info *elf,
>  #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
>  
>  #define DATA_SECTIONS ".data", ".data.rel"
> -#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
> +#define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
>  		".kprobes.text", ".cpuidle.text", ".noinstr.text"
>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
> -		".fixup", ".entry.text", ".exception.text", ".text.*", \
> +		".fixup", ".entry.text", ".exception.text", \
>  		".coldtext", ".softirqentry.text"
>  
>  #define INIT_SECTIONS      ".init.*"
> -- 
> 2.38.1
> 
