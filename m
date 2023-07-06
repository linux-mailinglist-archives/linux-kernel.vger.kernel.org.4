Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755A74A4D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjGFUVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFUVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:21:52 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3937E1996;
        Thu,  6 Jul 2023 13:21:50 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id DC821209B4;
        Thu,  6 Jul 2023 22:21:47 +0200 (CEST)
Date:   Thu, 6 Jul 2023 22:21:43 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Judith Mendez <jm@ti.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH 2/2] can: m_can: Add hrtimer to generate software
 interrupt
Message-ID: <ZKciVy4juK55OUrG@francesco-nb.int.toradex.com>
References: <20230705195356.866774-1-jm@ti.com>
 <20230705195356.866774-3-jm@ti.com>
 <20230706-unstopped-skedaddle-7168f2b12189-mkl@pengutronix.de>
 <0ba17779-9cd9-6cb2-a79c-6b14b73a42db@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba17779-9cd9-6cb2-a79c-6b14b73a42db@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 10:20:59AM -0500, Judith Mendez wrote:
> Hi Marc
> 
> On 7/6/23 2:25 AM, Marc Kleine-Budde wrote:
> > On 05.07.2023 14:53:56, Judith Mendez wrote:
> > > Introduce timer polling method to MCAN since some SoCs may not
> > > have M_CAN interrupt routed to A53 Linux and do not have
> > > interrupt property in device tree M_CAN node.
> > > 
> > > On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> > > routed to A53 Linux, instead they will use timer polling method.
> > > 
> > > Add an hrtimer to MCAN class device. Each MCAN will have its own
> > > hrtimer instantiated if there is no hardware interrupt found in
> > > device tree M_CAN node. The timer will generate a software
> > > interrupt every 1 ms. In hrtimer callback, we check if there is
> > > a transaction pending by reading a register, then process by
> > > calling the isr if there is.
> > > 
> > > Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Verdin AM62
> > > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > > Signed-off-by: Judith Mendez <jm@ti.com>
> > > ---

...

> > > diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> > > index 94dc82644113..76d11ce38220 100644
> > > --- a/drivers/net/can/m_can/m_can_platform.c
> > > +++ b/drivers/net/can/m_can/m_can_platform.c
> > > @@ -5,6 +5,7 @@
> > >   //
> > >   // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
> > > +#include <linux/hrtimer.h>
> > >   #include <linux/phy/phy.h>
> > >   #include <linux/platform_device.h>
> > > @@ -96,12 +97,28 @@ static int m_can_plat_probe(struct platform_device *pdev)
> > >   		goto probe_fail;
> > 
> > Please set "irq" to 0 during declaration.
> 
> During declaration of irq, it is already set to 0:
> 
> int irq, ret = 0;

The initialization here applies only to ret.

int irq = 0, ret = 0;

> > >   	addr = devm_platform_ioremap_resource_byname(pdev, "m_can");
> > > -	irq = platform_get_irq_byname(pdev, "int0");
> > > -	if (IS_ERR(addr) || irq < 0) {
> > > -		ret = -EINVAL;
> > > +	if (IS_ERR(addr)) {
> > > +		ret = PTR_ERR(addr);
> > >   		goto probe_fail;
> > >   	}
> > > +	if (device_property_present(mcan_class->dev, "interrupts") ||
> > > +	    device_property_present(mcan_class->dev, "interrupt-names")) {
> > > +		irq = platform_get_irq_byname(pdev, "int0");
> > > +		if (irq == -EPROBE_DEFER) {
> > > +			ret = -EPROBE_DEFER;
> > > +			goto probe_fail;
> > > +		}
> > > +		if (irq < 0) {
> > > +			ret = -EINVAL;
> > 
> > Please return the original error value.
> 
> The original value returned is -EINVAL:
> 
> -	if (IS_ERR(addr) || irq < 0) {
> -		ret = -EINVAL;
> 
> Perhaps I am missing something here?

if (irq < 0) {
	ret = irq;
	...
}

And you can also get rid of the explicit test for -EPROBE_DEFER this
way simplifying the code.

Francesco

