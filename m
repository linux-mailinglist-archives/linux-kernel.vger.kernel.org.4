Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1B625653
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiKKJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiKKJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:12:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D70C6A77E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:12:33 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1otQ5J-00068J-BB; Fri, 11 Nov 2022 10:12:25 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1otQ5H-00059D-3v; Fri, 11 Nov 2022 10:12:23 +0100
Date:   Fri, 11 Nov 2022 10:12:23 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Subject: Re: [PATCH v3] ARM: dts: imx: e60k02: Add touchscreen
Message-ID: <20221111091223.if2ahwz67vkf72ba@pengutronix.de>
References: <20221108191543.1752080-1-andreas@kemnade.info>
 <20221109092350.2ke6sbgbcp3wpelc@pengutronix.de>
 <20221109124536.5154cb03@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109124536.5154cb03@aktux>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 22-11-09, Andreas Kemnade wrote:
> On Wed, 9 Nov 2022 10:23:50 +0100
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > Hi Andreas,
> > 
> > On 22-11-08, Andreas Kemnade wrote:
> > > Add the touchscreen now, since the driver is available.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v3: no phandles pointing from dtsi to dts  
> > 
> > Thanks for this change...
> > 
> > > Changes in v2: fix pinmux naming
> > > 
> > >  arch/arm/boot/dts/e60k02.dtsi              |  9 ++++++++-
> > >  arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 12 ++++++++++++
> > >  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 12 ++++++++++++
> > >  3 files changed, 32 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/e60k02.dtsi
> > > b/arch/arm/boot/dts/e60k02.dtsi index 935e2359f8df..99091db3ab2a
> > > 100644 --- a/arch/arm/boot/dts/e60k02.dtsi
> > > +++ b/arch/arm/boot/dts/e60k02.dtsi
> > > @@ -104,7 +104,14 @@ &i2c2 {
> > >  	clock-frequency = <100000>;
> > >  	status = "okay";
> > >  
> > > -	/* TODO: CYTTSP5 touch controller at 0x24 */
> > > +	cyttsp5: touchscreen@24 {
> > > +		compatible = "cypress,tt21000";
> > > +		reg = <0x24>;
> > > +		interrupt-parent = <&gpio5>;
> > > +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> > > +		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > > +		vdd-supply = <&ldo5_reg>;
> > > +	};  
> > 
> > but we still have a cross-reference to the .dtsi file here. Therefore
> > I said to move the interrupt/reset-gpio into the dts file too. I know
> > this is a kind of a nitpick but I really don't like such
> > cross-references.
> > 
> hmm. &gpio5 references to imx6sl[l].dtsi, not dts, so what is the
> problem here?

Sorry for the missunderstanding, I didn't mean the phandle. I mean the
mux setting which is done in the dts right? I'm just not a fan of
muxing pins in one file an using those 'assumptions' in others. Except
for platforms like the imx8mm-evk which is exactly the same hardware and
only differs in the RAM they used. But you have two different platforms
right?

Hope this clears some of the confusions.

> And we have this pattern all over the place.
> 
> What is different to the touchscreen that this pattern is not wanted
> here but
> accepted everywhere else? It is there for
>   - backlight
>   - irq of pmic
>   - reset/gpio-regulator of wifi
>   - leds
>   - keys
> 
> And you have also done some review work there.
> 
> Here I am caring a bit about readability since I have still to do
> maintenance work on this file, so I am a bit more concerned than that
> it a) just works and b) is being accepted upstream.
> 
> If it is not allowed to have common things in the e60k02.dtsi file, what
> about ditching that file alltogether and just have the two .dts files?
> 
> I personally prefer the v2 variant, but v3 is a compromise.
> 
> For comparison, the feature-complete version used by postmarketOS is
> here:
> https://github.com/akemnade/linux/blob/kobo/drm-merged-5.19/arch/arm/boot/dts/e60k02.dtsi
> 
> Regards,
> Andreas
> 
