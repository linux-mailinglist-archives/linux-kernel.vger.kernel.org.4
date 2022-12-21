Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF386530AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLUMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLUMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:18:25 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858722286;
        Wed, 21 Dec 2022 04:18:23 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id c7so13433180qtw.8;
        Wed, 21 Dec 2022 04:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CueWZDdtUyE7xl2cqeIjpr9vo6iP5PtwWLtYRbw5JYc=;
        b=5ow0joktPRyXwDSTmiB5keRAd9waHu4y4czA/Q5GeAW3KwcMujVJbfJWPsKo7CYLmF
         cUkrtGOqoxJRzxWC+szU/oVmJRylzX3ABR0m2GdCyo92x18gEpYjiTZ2MAGrBCKmesls
         b0+YBFjQjJRN6N6/N4mau9IrbWdrVdwFZP9cDRV+kjbo/fxfE5G9ztAEAHwae7zG5FPp
         d59blIQYvGg4pOt5ZfRHLyeBoSwmhkagUC3GKSqsRpAEwvfX5yi/yXBYmaAwuXJV23FP
         GFN1Hd8X7nnYKmvJ+DFQFlhLDDiBOZPSuq8q8yWu1asT72Pkf7Gvls1SP3GO77wcD8Sy
         oVzw==
X-Gm-Message-State: AFqh2krAXy3x+YkOfFXlbv3RIosQBD+ET5YzuT2v9SVp5doqrz1nqefG
        PzjpOHCTYCingc9JytXUl2nnKFNnvmvfhA==
X-Google-Smtp-Source: AMrXdXtXXuGs6+5MxY/UPCcVmhc3FoI6Xoejg30d3cl0cM7WbRMSplA6YGpX101uSNamZMQ5jhU8BA==
X-Received: by 2002:ac8:7c92:0:b0:3a7:eb36:5cb1 with SMTP id y18-20020ac87c92000000b003a7eb365cb1mr1684055qtv.36.1671625101776;
        Wed, 21 Dec 2022 04:18:21 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id bc6-20020a05622a1cc600b003a820f9fb70sm9144256qtb.36.2022.12.21.04.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 04:18:21 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id v126so16288605ybv.2;
        Wed, 21 Dec 2022 04:18:20 -0800 (PST)
X-Received: by 2002:a25:418b:0:b0:6f0:9ff5:1151 with SMTP id
 o133-20020a25418b000000b006f09ff51151mr123793yba.543.1671625100368; Wed, 21
 Dec 2022 04:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <86o7rxawhn.wl-maz@kernel.org>
In-Reply-To: <86o7rxawhn.wl-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Dec 2022 13:18:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX++dbcsxyGRqiRzgukeU4aoAi3hDV5zyfH1s11dFba-A@mail.gmail.com>
Message-ID: <CAMuHMdX++dbcsxyGRqiRzgukeU4aoAi3hDV5zyfH1s11dFba-A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] irqchip: irq-renesas-rzg2l: Add support for
 RZ/G2UL SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Dec 21, 2022 at 11:20 AM Marc Zyngier <maz@kernel.org> wrote:
> On Wed, 21 Dec 2022 00:02:37 +0000,
> Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The IRQC block on RZ/G2UL SoC is almost identical to one found on the
> > RZ/G2L SoC the only difference being it can support BUS_ERR_INT for
> > which it has additional registers.
> >
> > This patch adds a new entry for "renesas,rzg2ul-irqc" compatible string
> > and now that we have interrupt-names property the driver code parses the
> > interrupts based on names and for backward compatibility we fallback to
> > parse interrupts based on index.
> >
> > For now we will be using rzg2l_irqc_init() as a callback for RZ/G2UL SoC
> > too and in future when the interrupt handler will be registered for
> > BUS_ERR_INT we will have to implement a new callback.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > +/* Parse hierarchy domain interrupts ie only IRQ0-7 and TINT0-31 */
> > +static int rzg2l_irqc_parse_hierarchy_interrupts(struct rzg2l_irqc_priv *priv,
> > +                                              struct device_node *np)
> > +{
> > +     struct property *pp;
> >       unsigned int i;
> >       int ret;
> >
> > +     /*
> > +      * first check if interrupt-names property exists if so parse them by name
> > +      * or else parse them by index for backward compatibility.
> > +      */
> > +     pp = of_find_property(np, "interrupt-names", NULL);
> > +     if (pp) {
> > +             char *irq_name;
> > +
> > +             /* parse IRQ0-7 */
> > +             for (i = 0; i < IRQC_IRQ_COUNT; i++) {
> > +                     irq_name = kasprintf(GFP_KERNEL, "irq%d", i);

%u

> > +                     if (!irq_name)
> > +                             return -ENOMEM;
> > +
> > +                     ret = rzg2l_irqc_parse_interrupt_by_name_to_fwspec(priv, np, irq_name, i);
>
> Am I the only one that find it rather odd to construct a name from an
> index, only to get another index back?

The issue is that there are two number ranges ("irq%u" and "tint%u"),
stored in a single interrupts property.

An alternative solution would be to get rid of the "interrupt-names",
and use two separate prefixed interrupts properties instead, like is
common for e.g. gpios: "irq-interrupts" and "tint-interrupts".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
