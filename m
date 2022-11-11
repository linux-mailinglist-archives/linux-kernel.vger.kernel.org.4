Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3488662592D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiKKLQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiKKLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:16:38 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8DE67120;
        Fri, 11 Nov 2022 03:16:37 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB6onVX025335;
        Fri, 11 Nov 2022 05:16:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=icIp/NpjApk70+qmEkD18al3Vm2GjOXV0BKAdaUyF0M=;
 b=Xu/i756ZE7Xfo/+Q8ysxJwlb1ILquXAIr6zxmaSmhu4sLG2w+54G/YsN14FZgujwkWrb
 6z6PUrAqJxL1Y9uH9dvjPykGhbuBg5qa3le/i0G9ZvwLXYy2iQaUnETTuw+kaXKLmaxr
 jM2pNB9WvRRM5ohZP5K2s4B1hLNK0ssbbzz3QAdoelqEaCkpCRX70XktZyITjwx3LJMx
 bVjY+vt6WC9Uxkk8fffeMsPUj7/69VSRUGGZx/Y9/mYMULSGiEEEBUqFTReqts5w48jt
 LOgnVoVtOY5BCMKndHjDbah83crFzfqQzvUAlHe0YsZgnXBdlJqNgfgnHySDUBSyih3b Og== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pgdud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 05:16:13 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 11 Nov
 2022 05:16:11 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Fri, 11 Nov 2022 05:16:11 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9CEAC46B;
        Fri, 11 Nov 2022 11:16:11 +0000 (UTC)
Date:   Fri, 11 Nov 2022 11:16:11 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <tglx@linutronix.de>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Message-ID: <20221111111611.GH10437@ediswmail.ad.cirrus.com>
References: <20221109165331.29332-10-rf@opensource.cirrus.com>
 <87mt8zutib.wl-maz@kernel.org>
 <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
 <86pmdvow5y.wl-maz@kernel.org>
 <ef60cbdb-f506-7bd6-a8e1-c92b6963a0f4@opensource.cirrus.com>
 <86k042q1uc.wl-maz@kernel.org>
 <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
 <87iljmve87.wl-maz@kernel.org>
 <Y21gwGDb5CFft0kp@sirena.org.uk>
 <87h6z5vs39.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h6z5vs39.wl-maz@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: WegBKVeC5O_swQWdvMTrub_2WzcCjjI3
X-Proofpoint-GUID: WegBKVeC5O_swQWdvMTrub_2WzcCjjI3
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 08:00:10AM +0000, Marc Zyngier wrote:
> On Thu, 10 Nov 2022 20:36:16 +0000,
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Nov 10, 2022 at 06:47:20PM +0000, Marc Zyngier wrote:

Apologies this ended up getting quite long. Cirrus has no trouble
changing how the IRQ driver works I just think we are struggling a
little to understand exactly what parts of the code need reworking
in what way, we appreciate your patience in helping us through.

> > > If you were implementing an actual interrupt controller driver, I'd
> > > take it without any question. The fact that this code mandates
> > > the use of its own homegrown API rules it out.

I think this is part of the crossed wires here, the code does not
mandate the use of its own home grown API, although it does
provide one. For example our CODECs often provide GPIO/IRQ
services for other devices such as say speaker amps attached
along side them.

Here is a DT example from one of my dev systems with GPIO1 on
cs47l35 (a madera CODEC) handling the IRQ for cs35l35 (a speaker
amp):

cs35l35_left: cs35l35@40 {
	compatible = "cirrus,cs35l35";
	reg = <0x40>;

	#sound-dai-cells = <1>;

	reset-gpios = <&axi_gpio0 0 0>;

	interrupt-parent = <&cs47l35>;
	interrupts = <57 0>;
};

No special code is required in the cs35l35 driver (it is fully
upstreamed sound/soc/codecs/cs35l35.c). So if we are missing some
actual interrupt controller API we need to be supporting that we
are not please point us at it and we will happily add support?

So I think your objections are mostly regarding the
cs48l32_request_irq function (and friends) that are being
used by the other parts of the MFD.  I don't think it would be super
hard to remove these functions and move the IRQ into DT if that is
the preferred way.

> > ACPI gets to be a lot of fun here, it's just not idiomatic to describe
> > the internals of these devices in firmware there and a lot of the
> > systems shipping this stuff are targeted at other OSs and system
> > integrators are therefore not in the least worried about Linux
> > preferences.

I would echo Mark's statement that going the way of moving this
into DT/ACPI will actually likely necessitate the addition of a
lot of "board file" stuff in the future. If the part gets used in
any ACPI systems (granted support is not in yet but this is not a
super unlikely addition in the future for cs48l32) we will need to
support the laptops containing the part in Linux and the vendors are
extremely unlikely to put internal CODEC IRQs into the ACPI tables.

But that aside I guess my main question about this approach would
be what the DT binding would look like for the CODEC. Currently
our devices use a single DT node for the device. Again pulling a
Madera example from my dev setup, this is what the DT binding for
one of our CODECs currently looks vaguely like:

cs47l35: cs47l35@1 {
	compatible = "cirrus,cs47l35";
	reg = <0x1>;

	spi-max-frequency = <11000000>;

	interrupt-controller;
	#interrupt-cells = <2>;
	interrupt-parent = <&gpio0>;
	interrupts = <56 8>;

	gpio-controller;
	#gpio-cells = <2>;

	#sound-dai-cells = <1>;

	AVDD-supply = <&lochnagar_vdd1v8>;
	DBVDD1-supply = <&lochnagar_vdd1v8>;
	DBVDD2-supply = <&lochnagar_vdd1v8>;
	CPVDD1-supply = <&lochnagar_vdd1v8>;
	CPVDD2-supply = <&lochnagar_vddcore>;
	DCVDD-supply = <&lochnagar_vddcore>;
	SPKVDD-supply = <&wallvdd>;

	reset-gpios = <&lochnagar_pin 0 0>;

	clocks = <&lochnagar_clk LOCHNAGAR_CDC_MCLK1>, <&lochnagar_clk LOCHNAGAR_CDC_MCLK2>;
	clock-names = "mclk1", "mclk2";

	pinctrl-names = "default";
	pinctrl-0 = <&cs47l35_defaults>;
};

The interrupt-parent points at who our IRQ is connected to, and
we are an interrupt-controller so people can use our IRQs. I
think it is not currently supported to have more than a single
interrupt-parent for a device so with the current binding is it
actually possible for the device to refer to its own IRQs in DT?

An alternative approach would be to actually represent the MFD in
device tree, I think this would allow things to work and look
something like (totally not tested just for discussion):

cs47l35: cs47l35@1 {
	compatible = "cirrus,cs47l35";
	reg = <0x1>;

	spi-max-frequency = <11000000>;

	irq: madera-irq {
		compatible = "cirrus,madera-irq";

		interrupt-controller;
		#interrupt-cells = <2>;
		interrupt-parent = <&gpio0>;
		interrupts = <56 8>;
	};

	gpio: madera-gpio {
		compatible = "cirrus,madera-gpio";
		gpio-controller;
		#gpio-cells = <2>;
	};

	sound: madera-sound {
		compatible = "cirrus,cs47l35-sound";

		interrupt-parent = <&madera-irq>;
		interrupts = <55 0>, <56 0>;
		#sound-dai-cells = <1>;
	};
};

Historically I believe we have been discouraged (by upstream, not
from our customers) from explicitly representing the parts of the
MFD in device tree separately, as it was viewed that this is just
an external SPI CODEC and one node mapped much more logically to the
hardware, which is what DT should be describing. However, are you
saying this would be a preferrable approach from your side?  Or am
I missing some alternative solution?

Again thank you kindly for you time looking at this.

Thanks,
Charles
