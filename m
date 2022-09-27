Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2B5EC489
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiI0Ndg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiI0NdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:33:08 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FB7A765
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:31:39 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id cj27so5968100qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1CKcN6D6aMgyt4bAsIiGzyFXkbzqcxXEoHRgk38I1OE=;
        b=2CTelejSNyAc63K7peeK8HqKubhTE4ocxydSrD3sgKjjboKqmQUMGPPNcJICofOxum
         A+RJ9dFaTQ2DoIKHzTqGHr7/GJyXrej7KG6c5tWPlW5SqFXSdvqlZIvm02HKy5ud7QWs
         S48HvOiTefzGRijGgD/Wh34XtEr0HpKvOZFc+JAx3tHUYnrBVey5fhJImVwolWrjehjh
         Mw8Njj45/OU34uzlw9+dEaHFmJsTU9zshaFEEkr2ibJWA0Nh0CeH3zc1Eiltlxvt6n5t
         AXG0Ey1BV8dFgpBS4pQulsCSOSW1QWXt7C3OiNXgZmVY6xYhVPC3fzGZY4YXDl2kdhnm
         KEbg==
X-Gm-Message-State: ACrzQf2In6wmZS0tqq7cEQMiY6QQ5ItLCzIxDGut3TQu/7k9DPRbhRQM
        N6uLXAqmmNfMrsj1wbGBKKsGXYxTr5gK1A==
X-Google-Smtp-Source: AMsMyM4ujb9lO/KCRTaBGrlncylN5yuHfgY/q1//Gon7dPVHgr1aYFcQmuZBhjuATqgY9qCZvhkbXQ==
X-Received: by 2002:ac8:7d92:0:b0:35c:be77:5e2b with SMTP id c18-20020ac87d92000000b0035cbe775e2bmr22004043qtd.505.1664285498288;
        Tue, 27 Sep 2022 06:31:38 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id c27-20020ac86e9b000000b00346414a0ca1sm843141qtv.1.2022.09.27.06.31.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:31:37 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id f189so12184044yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:31:37 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr25214619ybx.543.1664285497039;
 Tue, 27 Sep 2022 06:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-6-arnd@kernel.org>
In-Reply-To: <20220818145616.3156379-6-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 15:31:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVL8TZ8vfdQT_9DA=JLX3O7YrP0v9AK87ALjmsvryZptw@mail.gmail.com>
Message-ID: <CAMuHMdVL8TZ8vfdQT_9DA=JLX3O7YrP0v9AK87ALjmsvryZptw@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: make ARCH_MULTIPLATFORM user-visible
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some options like CONFIG_DEBUG_UNCOMPRESS and CONFIG_CMDLINE_FORCE are
> fundamentally incompatible with portable kernels but are currently allowed
> in all configurations. Other options like XIP_KERNEL are essentially
> useless after the completion of the multiplatform conversion.
>
> Repurpose the existing CONFIG_ARCH_MULTIPLATFORM option to decide
> whether the resulting kernel image is meant to be portable or not,
> and using this to guard all of the known incompatible options.
>
> This is similar to how the RISC-V kernel handles the CONFIG_NONPORTABLE
> option (with the opposite polarity).
>
> A few references to CONFIG_ARCH_MULTIPLATFORM were left behind by
> earlier clanups and have to be removed now up.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1904,6 +1904,7 @@ config DEBUG_UART_8250_PALMCHIP
>
>  config DEBUG_UNCOMPRESS
>         bool "Enable decompressor debugging via DEBUG_LL output"
> +       depends on !ARCH_MULTIPLATFORM

Shouldn't DEBUG_LL itself depend on !ARCH_MULTIPLATFORM instead?

>         depends on !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
>         depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
>                      (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
