Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611A2656B22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiL0NC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiL0NCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:02:25 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96A283;
        Tue, 27 Dec 2022 05:02:24 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id g7so10374551qts.1;
        Tue, 27 Dec 2022 05:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As9R9cHjsoEUKawysSraV8MPqyGDXYZgkaD+AH1/+1g=;
        b=l49dLBge3idM2ouN9VPuHDojZ7mnjTaCIaSq5vzSyPgFa+FWvz+ifCzlHX1zugpEmW
         RUohrHwOnZ1pJApJvnnw7/wKklzw0Jw+AfxsrfJ1fr2Y2ZraLZbX/exPVFRvsxD2l671
         2GvvmKUIcgiHtqjO5YjZ53x0E/iASjgg/LO9M7SBdF6Oh/SqAdmRnjsc03U0bxAGciIq
         5Co9nzT/xNYCd99sZ65AAc+xT7GH1JQ1kgCp9gH+XMy2IVvM2L7a4v/cQJOxnWPxCkZp
         8PpntSL/ePcmSs8Hn3VzXVXM3RvoYUdVqROVYQ4emZTh/eh/p6cYaN5AdGqXlaQ9jWWH
         K/kA==
X-Gm-Message-State: AFqh2kp8gaVBjLkzRNLNsnzeuWdJT7BTiNZHFEOtKrsz/0bQY8whRQiI
        +G+iYHqV8GHCoK++a21/17d5rfg/z/TAMw==
X-Google-Smtp-Source: AMrXdXubLtB1i6Xwjh9JlRo9jTjPcM8Eo4ecC5/xq1c03/ls2er3wIl54ipWrkrww9qua7FG71jGqw==
X-Received: by 2002:ac8:7285:0:b0:3a7:f599:d7f2 with SMTP id v5-20020ac87285000000b003a7f599d7f2mr28808053qto.51.1672146143578;
        Tue, 27 Dec 2022 05:02:23 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bn9-20020a05622a1dc900b003a7e38055c9sm8185956qtb.63.2022.12.27.05.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 05:02:23 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-43ea87d0797so183207617b3.5;
        Tue, 27 Dec 2022 05:02:22 -0800 (PST)
X-Received: by 2002:a05:690c:c02:b0:370:202b:f085 with SMTP id
 cl2-20020a05690c0c0200b00370202bf085mr1630998ywb.502.1672146142353; Tue, 27
 Dec 2022 05:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221221000242.340202-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221221000242.340202-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Dec 2022 14:02:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV1UAF0Pgk6omcLz6-kHLD6xnMFDN-UJ2ge_bhoD7rAcw@mail.gmail.com>
Message-ID: <CAMuHMdV1UAF0Pgk6omcLz6-kHLD6xnMFDN-UJ2ge_bhoD7rAcw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Dec 21, 2022 at 1:04 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ7 for ETH0 and
> ETH1 respectively.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
> @@ -6,6 +6,7 @@
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irqc-rzg2l.h>
>  #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
>
>  / {
> @@ -77,6 +78,8 @@ phy0: ethernet-phy@7 {
>                 compatible = "ethernet-phy-id0022.1640",
>                              "ethernet-phy-ieee802.3-c22";
>                 reg = <7>;
> +               interrupt-parent = <&irqc>;

Note that arch/riscv/boot/dts/renesas/r9a07g043f.dtsi does not have
the irqc node yet, so I cannot take this as-is.

> +               interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
>                 rxc-skew-psec = <2400>;
>                 txc-skew-psec = <2400>;
>                 rxdv-skew-psec = <0>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
