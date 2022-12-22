Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4527654158
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiLVMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiLVMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:52:01 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66552528D;
        Thu, 22 Dec 2022 04:51:55 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id d13so1177621qvj.8;
        Thu, 22 Dec 2022 04:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GllrCyZoKpUhPvjdNIUyYRbhBs5yv+S16f965UWIIIk=;
        b=mJP8AwvM71nB0RMmI86l7K/8iUfGLRV2iRIOA3ODoaTpCW+8S6480mMUuIgXsQZy6V
         znnMctiYBtlaOpi2SyI8loTayrv6zvXuzDhtYFxbMDRk9nJQekhhjjFJrV4NbMB2ijv7
         aYvcHqYpoHSlfWNPe08c48dPmielh1AqwXrjLxbxemSpK6SB7RtaJUePuQ+8Y0bqRR4j
         hG+Ldbwhlapg9YP7b77PyhcgVE/h0Enmr9bvGFQYqRMyP5ul4MIrRDYMcvpHXFhbPC30
         Y9hwxWXi+bDrStOaQrSsljsbno8LfQ9ypDa2pkq2RvI25yiDFdzDx6jyFEB4tILf/lA0
         papQ==
X-Gm-Message-State: AFqh2kqKwuOKO2fZwo9cx+TZ4y/MWcpA2sDl/3Dfle5FfEqr4us9NiqA
        kIbAXs6yc37iWi7slJHktU7fFh8qIg9PpA==
X-Google-Smtp-Source: AMrXdXvHXFs6oSpnb3ysFIMAPBvFS/GtzyuWqQVcOIfsUylQG5Dz3sAsna6RFJVO/WiGOdYu0NMpvw==
X-Received: by 2002:a0c:ea22:0:b0:4bb:615d:4c4c with SMTP id t2-20020a0cea22000000b004bb615d4c4cmr7642560qvp.49.1671713514590;
        Thu, 22 Dec 2022 04:51:54 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id r17-20020ae9d611000000b00704c62638f4sm8597qkk.89.2022.12.22.04.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 04:51:54 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id e141so1840398ybh.3;
        Thu, 22 Dec 2022 04:51:53 -0800 (PST)
X-Received: by 2002:a25:d243:0:b0:702:90b4:2e24 with SMTP id
 j64-20020a25d243000000b0070290b42e24mr398540ybg.365.1671713513672; Thu, 22
 Dec 2022 04:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <86o7rxawhn.wl-maz@kernel.org> <CAMuHMdX++dbcsxyGRqiRzgukeU4aoAi3hDV5zyfH1s11dFba-A@mail.gmail.com>
 <CA+V-a8uRTPhQqtkQqUVtW=HE02YaW0oi=Os__OgtUgQVwWq+Mw@mail.gmail.com>
In-Reply-To: <CA+V-a8uRTPhQqtkQqUVtW=HE02YaW0oi=Os__OgtUgQVwWq+Mw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Dec 2022 13:51:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV0wKGk+EvTfCZJu0z_HYy7YaLLNya4z6=coASsbnkVBQ@mail.gmail.com>
Message-ID: <CAMuHMdV0wKGk+EvTfCZJu0z_HYy7YaLLNya4z6=coASsbnkVBQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] irqchip: irq-renesas-rzg2l: Add support for
 RZ/G2UL SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Dec 22, 2022 at 12:50 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Dec 21, 2022 at 12:18 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Dec 21, 2022 at 11:20 AM Marc Zyngier <maz@kernel.org> wrote:
> > > On Wed, 21 Dec 2022 00:02:37 +0000,
> > > Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > The IRQC block on RZ/G2UL SoC is almost identical to one found on the
> > > > RZ/G2L SoC the only difference being it can support BUS_ERR_INT for
> > > > which it has additional registers.
> > > >
> > > > This patch adds a new entry for "renesas,rzg2ul-irqc" compatible string
> > > > and now that we have interrupt-names property the driver code parses the
> > > > interrupts based on names and for backward compatibility we fallback to
> > > > parse interrupts based on index.
> > > >
> > > > For now we will be using rzg2l_irqc_init() as a callback for RZ/G2UL SoC
> > > > too and in future when the interrupt handler will be registered for
> > > > BUS_ERR_INT we will have to implement a new callback.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > > +/* Parse hierarchy domain interrupts ie only IRQ0-7 and TINT0-31 */
> > > > +static int rzg2l_irqc_parse_hierarchy_interrupts(struct rzg2l_irqc_priv *priv,
> > > > +                                              struct device_node *np)
> > > > +{
> > > > +     struct property *pp;
> > > >       unsigned int i;
> > > >       int ret;
> > > >
> > > > +     /*
> > > > +      * first check if interrupt-names property exists if so parse them by name
> > > > +      * or else parse them by index for backward compatibility.
> > > > +      */
> > > > +     pp = of_find_property(np, "interrupt-names", NULL);
> > > > +     if (pp) {
> > > > +             char *irq_name;
> > > > +
> > > > +             /* parse IRQ0-7 */
> > > > +             for (i = 0; i < IRQC_IRQ_COUNT; i++) {
> > > > +                     irq_name = kasprintf(GFP_KERNEL, "irq%d", i);
> >
> > %u
> >
> Ok.
>
> > > > +                     if (!irq_name)
> > > > +                             return -ENOMEM;
> > > > +
> > > > +                     ret = rzg2l_irqc_parse_interrupt_by_name_to_fwspec(priv, np, irq_name, i);
> > >
> > > Am I the only one that find it rather odd to construct a name from an
> > > index, only to get another index back?
> >
> > The issue is that there are two number ranges ("irq%u" and "tint%u"),
> > stored in a single interrupts property.
> >
> > An alternative solution would be to get rid of the "interrupt-names",
> > and use two separate prefixed interrupts properties instead, like is
> > common for e.g. gpios: "irq-interrupts" and "tint-interrupts".
> >
> Maybe I will read all the interrupts based on index only for all the
> SoCs and we still add interrupt-names in dt bindings with the
> dt_binding check we can make sure all the interrupts for each SoC
> exist in the DT and the driver still reads them based on index. Does
> that sound good?

Sure, sounds fine.

You can postpone parsing interrupt-names in the driver (until a new
SoC arrives that uses a different number of IRQ or TINT interrupts).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
