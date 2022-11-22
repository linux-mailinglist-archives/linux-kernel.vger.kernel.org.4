Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4926337D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiKVJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKVJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:03:15 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF957B4BD;
        Tue, 22 Nov 2022 01:03:06 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1C08624E337;
        Tue, 22 Nov 2022 17:03:05 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 17:03:05 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 17:03:04 +0800
Message-ID: <b4afb821-f899-a2b6-46e1-a31b5e3f974e@starfivetech.com>
Date:   Tue, 22 Nov 2022 17:02:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 5/8] soc: sifive: ccache: Add StarFive JH7110 support
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-6-hal.feng@starfivetech.com> <Y3dwdXExRRltyp8A@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y3dwdXExRRltyp8A@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 19:45:57 +0800, Conor Dooley wrote:
> Hey Emil/Hal,
> 
> On Fri, Nov 18, 2022 at 09:17:11AM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > This adds support for the StarFive JH7110 SoC which also
> > features this SiFive cache controller.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  arch/riscv/Kconfig.socs            | 1 +
> >  drivers/soc/Makefile               | 2 +-
> >  drivers/soc/sifive/Kconfig         | 2 +-
> >  drivers/soc/sifive/sifive_ccache.c | 1 +
> >  4 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 69774bb362d6..5a40e05f8cab 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -22,6 +22,7 @@ config SOC_STARFIVE
> >  	bool "StarFive SoCs"
> >  	select PINCTRL
> >  	select RESET_CONTROLLER
> > +	select SIFIVE_CCACHE
> 
> Please no. I am trying to get rid of these selects + I cannot figure out
> why this driver is so important that you *need* to select it. Surely the
> SoC is useable without it> 
> Is this a hang over from your vendor tree that uses the driver to do
> non-coherent stuff for the jh7100?

I have tested that the board can successfully boot up without the cache
driver. The `select` can be removed for JH7110. @Emil, what do you think
of this?

> 
> >  	select SIFIVE_PLIC
> >  	help
> >  	  This enables support for StarFive SoC platform hardware.
> > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > index 69ba6508cf2c..534669840858 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -26,7 +26,7 @@ obj-y				+= qcom/
> >  obj-y				+= renesas/
> >  obj-y				+= rockchip/
> >  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
> > -obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
> > +obj-y				+= sifive/
> 
> This bit is fine.
> 
> >  obj-y				+= sunxi/
> >  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
> >  obj-y				+= ti/
> > diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> > index ed4c571f8771..e86870be34c9 100644
> > --- a/drivers/soc/sifive/Kconfig
> > +++ b/drivers/soc/sifive/Kconfig
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -if SOC_SIFIVE
> > +if SOC_SIFIVE || SOC_STARFIVE
> 
> As I suppose is this - but hardly scalable. I suppose it doesn't really
> matter.
> 
> >  config SIFIVE_CCACHE
> >  	bool "Sifive Composable Cache controller"
> > diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
> > index 1c171150e878..9489d1a90fbc 100644
> > --- a/drivers/soc/sifive/sifive_ccache.c
> > +++ b/drivers/soc/sifive/sifive_ccache.c
> > @@ -107,6 +107,7 @@ static const struct of_device_id sifive_ccache_ids[] = {
> >  	{ .compatible = "sifive,fu540-c000-ccache" },
> >  	{ .compatible = "sifive,fu740-c000-ccache" },
> >  	{ .compatible = "sifive,ccache0" },
> > +	{ .compatible = "starfive,jh7110-ccache" },
> 
> Per my second reply to the previous patch, I am not sure why you do not
> just have a fallback compatible in the binding/dt for the fu740 ccache
> since you appear to have identical configuration?

Yeah, I will use the compatible of fu740 and modify this patch.

Best regards,
Hal
