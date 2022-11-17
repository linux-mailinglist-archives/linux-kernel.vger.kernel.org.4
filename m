Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7162D92C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiKQLOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiKQLNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:13:38 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E2117A;
        Thu, 17 Nov 2022 03:13:30 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id k2so888680qkk.7;
        Thu, 17 Nov 2022 03:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhB2HStiiI/m0aRTs9w3oejsmvfYmBFRUtwPfZuMH2Q=;
        b=eXNlhKS9QorQr65id/IgsDCJVSktCNXogAGAiYdNne5TSoAbpK4LfNQ4Z0UiJWzc6K
         YIz//tMziU73EZ4MZYKr1ayDg+JtEX4cV9G7JtrpNmKEbKy2/5Zj/gvRgmnBWD15+eWr
         OfNRVAIU68A79kEky08bPCbMXqmcjPL9xTXQZtsyIJ2IZ5Oxe0YNiDD7iHNYk9BOMcFK
         +m7NbeZzZqnR8+Vp9XDMwqMd6f5uAq86NSHxTKqLeDlY/r9XJ2ggW1uZthv8ZkXI3BuK
         DCuP/NN/U+IxEB0W4Z5Dgfx6Sm89h2dqGkw+Z7D1znUPcMNvu5To6jYdxC3D6Bun3dyW
         rS5Q==
X-Gm-Message-State: ANoB5pmLzGnZErTJo02Ax62zYE8wi08zURniFEenLnCn2wTDlJiCcZVK
        x+eGKfIP050/PXrwAh01ElA7p1l174zktw==
X-Google-Smtp-Source: AA0mqf6+2chMoLGUcjsi/CmoSSTI++rjQ5fIiNH4p/uTZTfSu1L/1HHVyRVF5THF8v5r94cxj2xxrA==
X-Received: by 2002:a05:620a:1a02:b0:6fa:2d09:d2e5 with SMTP id bk2-20020a05620a1a0200b006fa2d09d2e5mr1134873qkb.609.1668683608878;
        Thu, 17 Nov 2022 03:13:28 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a284900b006f9ddaaf01esm240548qkp.102.2022.11.17.03.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:13:28 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id i131so1447750ybc.9;
        Thu, 17 Nov 2022 03:13:28 -0800 (PST)
X-Received: by 2002:a25:8249:0:b0:6dd:b521:a8f2 with SMTP id
 d9-20020a258249000000b006ddb521a8f2mr1489452ybn.380.1668683607938; Thu, 17
 Nov 2022 03:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221107175305.63975-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221107175305.63975-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 12:13:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgCdR8E+bgAprfSmL3S-1aY2R7frba9du-XfCeEV7T0g@mail.gmail.com>
Message-ID: <CAMuHMdWgCdR8E+bgAprfSmL3S-1aY2R7frba9du-XfCeEV7T0g@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] arm64: dts: renesas: r9a07g043[u]: Add IRQC node
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add IRQC node to R9A07G043 (RZ/G2UL) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> ---
> Note,
> - clocks and resets are differnt when compared to RZ/Five hence its added
>   in r9a07g043u.dtsi
> - We have additional interrupt on RZ/Five hence interrupts are added in
>   r9a07g043u.dtsi

Which additional interrupts?
Do you already have the r9a06g043f-variant ready, so we can compare?

> - clock-names is also added in r9a07g043u.dtsi to avoid dtbs_check warning

Why does this warn?

> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -538,6 +538,14 @@ pinctrl: pinctrl@11030000 {
>                                  <&cpg R9A07G043_GPIO_SPARE_RESETN>;
>                 };
>
> +               irqc: interrupt-controller@110a0000 {
> +                       #interrupt-cells = <2>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       reg = <0 0x110a0000 0 0x10000>;

The size of the "reg" property will be 0x20000 on RZ/Five, to cover the
extra [NIT]MSK registers, so I think this belongs in r9a07g043u.dtsi, too.

> +                       power-domains = <&cpg>;
> +               };
> +
>                 dmac: dma-controller@11820000 {
>                         compatible = "renesas,r9a07g043-dmac",
>                                      "renesas,rz-dmac";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
