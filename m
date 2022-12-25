Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80C5655DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLYQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:26:44 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07961114;
        Sun, 25 Dec 2022 08:26:41 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6CDB924E1EA;
        Mon, 26 Dec 2022 00:26:34 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Dec
 2022 00:26:34 +0800
Received: from [192.168.2.237] (113.72.145.114) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Dec
 2022 00:26:33 +0800
Message-ID: <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
Date:   Mon, 26 Dec 2022 00:26:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com> <Y6JB37Pd5TZoGMy4@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y6JB37Pd5TZoGMy4@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.114]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 23:14:39 +0000, Conor Dooley wrote:
> On Tue, Dec 20, 2022 at 08:50:50AM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Add bindings for the system clock and reset generator (SYSCRG) on the
> > JH7110 RISC-V SoC by StarFive Ltd.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  .../clock/starfive,jh7110-syscrg.yaml         |  80 +++++++
> >  MAINTAINERS                                   |   8 +-
> >  .../dt-bindings/clock/starfive,jh7110-crg.h   | 207 ++++++++++++++++++
> >  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
> >  4 files changed, 434 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> >  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
> >  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> > new file mode 100644
> > index 000000000000..ec81504dcb27
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/starfive,jh7110-syscrg.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: StarFive JH7110 System Clock and Reset Generator
> > +
> > +maintainers:
> > +  - Emil Renner Berthing <kernel@esmil.dk>
> > +
> > +properties:
> > +  compatible:
> > +    const: starfive,jh7110-syscrg
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Main Oscillator (24 MHz)
> > +      - description: GMAC1 RMII reference
> > +      - description: GMAC1 RGMII RX
> > +      - description: External I2S TX bit clock
> > +      - description: External I2S TX left/right channel clock
> > +      - description: External I2S RX bit clock
> > +      - description: External I2S RX left/right channel clock
> > +      - description: External TDM clock
> > +      - description: External audio master clock
> 
> So, from peeking at the clock driver & the dt - it looks like a bunch of
> these are not actually required?

These clocks are used as root clocks or optional parent clocks in clock tree.
Some of them are optional, but they are required if we want to describe the
complete clock tree of JH7110 SoC.

> I'd have ploughed through this, but having read Krzysztof's comments on
> the DTS I'm not sure that this binding is correct.
> https://lore.kernel.org/linux-riscv/20221220011247.35560-1-hal.feng@starfivetech.com/T/#mdf67621a2344dce801aa8015d4963593a2c28bcc
> 
> I *think* the DT is correct - the fixed clocks are all inputs from clock
> sources on the board and as such they are empty in soc.dtsi and are
> populated in board.dts?

Yes, the fixed clocks are all clock sources on the board and input to the SoC.

> 
> However, are they all actually required? In the driver I see:
> 	JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
> 		    JH7110_SYSCLK_GMAC1_RGMII_RXIN,
> 		    JH7110_SYSCLK_GMAC1_RMII_RTX),
> That macro is:
> #define JH71X0__MUX(_idx, _name, _nparents, ...) [_idx] = {			\
> 	.name = _name,								\
> 	.flags = 0,								\
> 	.max = ((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT,			\
> 	.parents = { __VA_ARGS__ },						\
> }
> 
> AFAICT, RMII reference feeds RMII_RTX & RGMII RX *is* RGMII_RXIN?
> Does that mean you need to populate only one of GMAC1 RMII reference
> and GMAC1 RMGII RX and the other is optional?

Yes, actually only one of them is chosen as the root clock
source of the clock "gmac1_rx".

> 
> What have I missed?
> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: osc
> > +      - const: gmac1_rmii_refin
> > +      - const: gmac1_rgmii_rxin
> > +      - const: i2stx_bclk_ext
> > +      - const: i2stx_lrck_ext
> > +      - const: i2srx_bclk_ext
> > +      - const: i2srx_lrck_ext
> > +      - const: tdm_ext
> > +      - const: mclk_ext
> 
> If all clocks are in fact required though, isn't this kinda pointless to
> have since we already know that the order is fixed from the "clocks"
> property?
> Krzk/Rob?

The clock-names are used to easily identify these clocks in the clock driver.

Best regards,
Hal
