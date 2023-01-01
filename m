Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0CC65AAAE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 17:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAAQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjAAQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 11:36:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF25532C;
        Sun,  1 Jan 2023 08:36:29 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x37so20165940ljq.1;
        Sun, 01 Jan 2023 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VDOIdF6jfVA+QSwv3AkltpxovMYOPTVxEzdUgBODiIc=;
        b=Bzn9HHgJVW1JcR7AET//KiTdUhvcjmbDvzmdD31qgzzu+rqf89Cv/bKVCISo+Jyqci
         xTaKVAXX8SW1R51mntlnqsb3P+xidhYvEXqJn4Q2HEMH9ms9QZjHIv3jVCEx/epGXz39
         DvLYfhqqVL5Je1jxGqXbFjL1wqP65jWUY5DocZyHNTvmH63a5DJNiFZKlZKK2QkHJPsb
         mR49nS1kKczPZbq5QOROInWqKPJf7e+cRws9iDwkj6rd9/gUSE3Ig3XOku7qAQA1vJRF
         TyzzF8E2ekVpOJhcP5xQmX0wxsTH7+tm55eFkUem9LmH1cmpg307ZvycuUxchFS7WaaP
         aQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDOIdF6jfVA+QSwv3AkltpxovMYOPTVxEzdUgBODiIc=;
        b=BewAbY8f9oDpuEjsWhaq2Jl/P6AJpS6jsvRW7utPs+M6pasulHlkInLFDmp44zTh5k
         wMxZ1i2fVvyLYwqCdZYIp4DVCNpF+ywK8ZRNqDoboiPAnXyu7akq/orcr6E42/JNFpDq
         L/naUlFL/M08Ycn7yTbyQFyC8+70j/R4cC4BbJ0L80onu8bMHi1DOfsyFYtkKpaF4rem
         WLoRdxMeFzxhHevhVuUQASr97UD7tCi9rb0XqXTn4q+QepFo6HuijFlRB2Lfto0+SGTd
         SSfBuS4PVSYKr6yLAPlUP3dxm6aNnyy5pTrXGVKJW1xQHziXEBdgtQWLh04K1KQ7HYtN
         IpCg==
X-Gm-Message-State: AFqh2koc+j2SF5Vos4r/WSbNV1hJFisYCl5UZ+2NQEcsfQHxpQH3Zi9J
        FedF/+fum/UtCwgS7YWhjy0hNn8SZ9ZyRjRhD64=
X-Google-Smtp-Source: AMrXdXs1jHbCv/QVlb/8U438YtkXMteFS99n+Vhvk7XGMGflTc1lgAIzWoRcAzWAa+a3EqY+9bHTg1oSxKGKSUEXlxc=
X-Received: by 2002:a05:651c:247:b0:27f:bfaa:26e2 with SMTP id
 x7-20020a05651c024700b0027fbfaa26e2mr1907236ljn.364.1672590987866; Sun, 01
 Jan 2023 08:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20230101060709.208512-1-masahiroy@kernel.org>
In-Reply-To: <20230101060709.208512-1-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 1 Jan 2023 17:35:50 +0100
Message-ID: <CA+icZUW9MewkPJKwd4gA+pKADypseiCT0uYyVvFDTura7CzHog@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix single *.ko build
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 1, 2023 at 7:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The single *.ko build is broken since commit f65a486821cf ("kbuild:
> change module.order to list *.o instead of *.ko").
>

Happy new 2023,

will this go into kbuild.git#fixes?

Thanks.

Regards,
-Sedat-

> Fixes: f65a486821cf ("kbuild: change module.order to list *.o instead of *.ko")
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 7cfbf3d15466..a0536633cdf6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1989,7 +1989,7 @@ $(single-no-ko): $(build-dir)
>  # Remove MODORDER when done because it is not the real one.
>  PHONY += single_modules
>  single_modules: $(single-no-ko) modules_prepare
> -       $(Q){ $(foreach m, $(single-ko), echo $(extmod_prefix)$m;) } > $(MODORDER)
> +       $(Q){ $(foreach m, $(single-ko), echo $(extmod_prefix)$(m:%.ko=%.o);) } > $(MODORDER)
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
>  ifneq ($(KBUILD_MODPOST_NOFINAL),1)
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
> --
> 2.34.1
>
