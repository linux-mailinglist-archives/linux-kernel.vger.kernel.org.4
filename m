Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05B674D8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjGJOO0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjGJOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:14:23 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D9DF;
        Mon, 10 Jul 2023 07:14:22 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-579ef51428eso58731147b3.2;
        Mon, 10 Jul 2023 07:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688998462; x=1691590462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1SoVYt/eXkCUju2ZrXSBXhCNBA/PkoSDQudNUVgxBk=;
        b=c1z2zbn3OBnf/1vczT/XxCqWvTdV6D1lr+28xgEtUglq/HWORcK3Ay5Glgz3kZmc7u
         AMZhwSFZDTwA5ffhDrq/wTSkKnQBM2mjdhGzKoqFeCWgWBmnoxgTt8s2fB6cwUHfeEMM
         q7RREyFthliodB429vnFOFQQdCGNEr8MlFColV9u6Flj1oXAigJ1YCNBR1Ct7n5iyEvs
         2zFZsf39owNxjQnFUui12hapvNKI+ssX1h9tXwnu3RCwJFGxBfNmwYnAdJSFvlbFf3t6
         KcOs7vR+S2K///gCf9KNJKFCVfo91tUePGm+BhobVzoomoO6IENn/kntdHCMrs2579Xi
         B72A==
X-Gm-Message-State: ABy/qLZVvHZXedcftpeeIb3nf9ArFNJs9k98/rngljj79Oz+8smn9WlJ
        pxns3OJwblka1s16/OVBGlL1rxCUVxLnTA==
X-Google-Smtp-Source: APBJJlFh7o9jWx4DnSqYHfBCQNCZRRxzuJ4L+XjicDHfb+e/2TVk5hLjcP+XSDD6OCBzs5hCYY8f6Q==
X-Received: by 2002:a0d:e884:0:b0:56f:ff55:2b7d with SMTP id r126-20020a0de884000000b0056fff552b7dmr15566918ywe.17.1688998461736;
        Mon, 10 Jul 2023 07:14:21 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id p135-20020a0de68d000000b005707d7686ddsm3078088ywe.76.2023.07.10.07.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:14:21 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-57a6df91b1eso27582177b3.1;
        Mon, 10 Jul 2023 07:14:21 -0700 (PDT)
X-Received: by 2002:a25:68ca:0:b0:c85:a84:d87e with SMTP id
 d193-20020a2568ca000000b00c850a84d87emr2850225ybc.10.1688998461286; Mon, 10
 Jul 2023 07:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592217C4028606B67B39C6858629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8sXcHP2AYYLLONLLBDVctMb=fnU=D4+6hNoHGx5Dk2O3Q@mail.gmail.com> <OS0PR01MB592285AB361A6C25CEDC21F68629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592285AB361A6C25CEDC21F68629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 16:14:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoDVMczVRt98GgimZviAHWy3c=P84+nrKOpxtaLVc4RQ@mail.gmail.com>
Message-ID: <CAMuHMdVoDVMczVRt98GgimZviAHWy3c=P84+nrKOpxtaLVc4RQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Mon, Jul 3, 2023 at 4:13 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Monday, July 3, 2023 1:43 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> > <magnus.damm@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Linus Walleij
> > <linus.walleij@linaro.org>; linux-renesas-soc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-gpio@vger.kernel.org; Prabhakar Mahadev
> > Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: Re: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
> > RZG2L_GPIO_PORT_PACK() macro
> >
> > On Mon, Jul 3, 2023 at 12:42 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > -----Original Message-----
> > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: Friday, June 30, 2023 1:05 PM
> > > > To: Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> > > > <magnus.damm@gmail.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > <krzysztof.kozlowski+dt@linaro.org>; Linus Walleij
> > > > <linus.walleij@linaro.org>; linux-renesas-soc@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; linux-gpio@vger.kernel.org; Biju Das
> > > > <biju.das.jz@bp.renesas.com>; Prabhakar
> > > > <prabhakar.csengg@gmail.com>; Prabhakar Mahadev Lad
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Subject: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
> > > > RZG2L_GPIO_PORT_PACK() macro
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Currently we assume all the port pins are sequential ie always PX_0
> > > > to PX_n (n=1..7) exist, but on RZ/Five SoC we have additional pins
> > > > P19_1 to
> > > > P28_5 which have holes in them, for example only one pin on port19
> > > > is available and that is P19_1 and not P19_0.
> > > >
> > > > So to handle such cases include pinmap for each port which would
> > > > indicate the pin availability on each port. With this we also get
> > > > additional pin validation, for example on the RZ/G2L SOC P0 has two
> > > > pins
> > > > P0_1 and P0_0 but with DT/SYSFS could use the P0_2-P0_7.
> > > >
> > > > While at it, update rzg2l_validate_gpio_pin() to use the port pinmap
> > > > to validate the gpio pin.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 167
> > > > ++++++++++++------------
> > > >  1 file changed, 86 insertions(+), 81 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > index 9511d920565e..a0c2e585e765 100644
> > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > @@ -67,10 +67,12 @@
> > > >                                        PIN_CFG_FILCLKSEL)
> > > >
> > > >  /*
> > > > - * n indicates number of pins in the port, a is the register index
> > > > - * and f is pin configuration capabilities supported.
> > > > + * m indicates the bitmap of supported pins, n indicates number
> > > > + * of pins in the port, a is the register index and f is pin
> > > > + * configuration capabilities supported.
> > > >   */
> > > > -#define RZG2L_GPIO_PORT_PACK(n, a, f)        (((n) << 28) | ((a) <<
> > 20) |
> > > > (f))
> > > > +#define RZG2L_GPIO_PORT_PACK(m, n, a, f)     ((UL(m) << 32) |
> > (UL(n) << 28)
> > > > | ((a) << 20) | (f))
> > >
> > > I guess, you can still achieve RZG2L_GPIO_PORT_PACK(n, a, f) with
> > > ((UL(PINMAP(n)) << 32) | (UL(n) << 28) | ((a) << 20) | (f))
> > >
> > > #define PINMAP(n) GENMASK(n,0) ?? Then you don't need to modify
> > rzg2l_gpio_configs.
> > >
> > Good point, but this would work if port pins didn't have any holes.
> > For example on RZ/Five port P19 we have P19_1 pin only and P19_0 is not
> > available (and similarly for port P25 we have P25_1).
>
> Maybe introduce a helper macro to address this case.
>
> #define RZG2L_GPIO_PORT_PACK_WITH_HOLES(m, n, a, f) for these 2 cases

"sparse" is the terse term.

#define RZG2L_GPIO_PORT_PACK_SPARSE(m, a, f)
as "n" can be derived from "m"

> and use RZG2L_GPIO_PORT_PACK(n, a, f) for the one without holes.

Exactly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
