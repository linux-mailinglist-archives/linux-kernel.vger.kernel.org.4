Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E615062B606
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiKPJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiKPJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:07:03 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BE2339A;
        Wed, 16 Nov 2022 01:06:56 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id o8so11507619qvw.5;
        Wed, 16 Nov 2022 01:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmZ/a6rCcRl77Zg9NUCks3KXP0Nym/qibrWauqUGkuQ=;
        b=mT4ZCYoUaE88FnnMMlvKmxGa18nqQdEl3xa2HzxH5svVrvY6jxGuLk2FZRbFseW17M
         qxJvRqPaabh1HVCHJezjbWs/dL0CBtawOKo6AC0OBEz7QyRagoruS8RhuldoX3y5jdyQ
         k4dUDywz684GPnpjkExucGfT08jeqGBOv7DIuEtc3uHYDgY8PpiG52TAbRevN95IzbnL
         BuzVHdqZqJxxLeyXLHiyKrHHRgkrq18IaN/f047cEKIslGIXkCN8j+JT80+LwIKSqo/T
         +5EvVcCFvDLPhi31dnhYO/W3n4+9hfW3dUwq62jQVXgL985K1QhIfkHkgaegTBdoOyjR
         mGbQ==
X-Gm-Message-State: ANoB5plwOGoR7eGP4x8mj7SL3ovBLTnr8KupbeiVZ3l5ZKE6vXNoysjX
        7YHo1ueDAAnubhecqxbtJaDcnMZGPYaPSg==
X-Google-Smtp-Source: AA0mqf6QrlDwTMAPZEJ1RPu3g8TrEv35e8ZWqXbb8Grz7f4WSdrfnd62CKYJqOEsZuCnpLLxbjjwSg==
X-Received: by 2002:ad4:43ea:0:b0:4bc:16a2:d4f5 with SMTP id f10-20020ad443ea000000b004bc16a2d4f5mr699504qvu.64.1668589615080;
        Wed, 16 Nov 2022 01:06:55 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id ez15-20020a05622a4c8f00b00398a7c860c2sm8586359qtb.4.2022.11.16.01.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:06:54 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id g127so20202449ybg.8;
        Wed, 16 Nov 2022 01:06:54 -0800 (PST)
X-Received: by 2002:a25:844b:0:b0:6de:6c43:3991 with SMTP id
 r11-20020a25844b000000b006de6c433991mr19216743ybm.604.1668589614165; Wed, 16
 Nov 2022 01:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221115105135.1180490-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWEnd1A3s6iPAqB_+78Q_Sx73XQBW5wU9Mtouw4EiOmJQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWEnd1A3s6iPAqB_+78Q_Sx73XQBW5wU9Mtouw4EiOmJQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Nov 2022 10:06:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQ1UAYsdOKpSbi8wUWBouT1z_W7Ko1ep2mkcq7iQm8jw@mail.gmail.com>
Message-ID: <CAMuHMdWQ1UAYsdOKpSbi8wUWBouT1z_W7Ko1ep2mkcq7iQm8jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: renesas: r9a07g043f/rzfive-smarc-som:
 Enable ADC/OPP/Thermal Zones/TSU
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
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

On Wed, Nov 16, 2022 at 10:03 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Nov 15, 2022 at 11:51 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable support for below blocks found on RZ/Five SMARC EVK SoC/SoM:
> > - ADC
> > - OPP
> > - Thermal Zones
> > - TSU
> >
> > Note, these blocks are enabled in RZ/G2UL SMARC SoM DTSI [0] hence
> > deleting these disabled nodes from RZ/Five SMARC SoM DTSI enables them
> > here too as we include [0] in RZ/Five SMARC SoM DTSI.
> >
> > [0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > @@ -16,13 +16,6 @@ aliases {
> >         chosen {
> >                 bootargs = "ignore_loglevel";
> >         };
> > -
> > -       /delete-node/opp-table-0;
> > -       /delete-node/thermal-zones;
> > -};
> > -
> > -&adc {
> > -       status = "disabled";
>
> I believe this is not sufficient to enable the ADC, as it is disabled
> by default?
> So this needs to set the status to "okay" and configure pin
> control, depending on SW_SW0_DEV_SEL, just like in
> arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?

Sorry, scrap that. grabbing my morning coffee *now*.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
