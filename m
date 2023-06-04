Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4157E721A3D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjFDVbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDVbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 17:31:05 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BBE9BD;
        Sun,  4 Jun 2023 14:31:01 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 71E1141D13A6;
        Sun,  4 Jun 2023 22:30:59 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Sun, 04 Jun 2023 22:30:59 +0100
Date:   Sun, 4 Jun 2023 22:30:59 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
Message-ID: <ZH0Ck794eem2DUdw@bart.dudau.co.uk>
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk>
 <20230529150833.526084-2-liviu@dudau.co.uk>
 <ZHTK+qG0xBWfn9gt@bart.dudau.co.uk>
 <cc70b28c-7bbe-0766-4a43-c0d7584e108a@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc70b28c-7bbe-0766-4a43-c0d7584e108a@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 03:06:08PM +0300, Arınç ÜNAL wrote:
> On 29.05.2023 18:55, Liviu Dudau wrote:
> > On Mon, May 29, 2023 at 04:08:32PM +0100, Liviu Dudau wrote:
> > > This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> > > a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
> 
> Do you mean MT7662 5GHz WiFi?

Actually it's MT76*1*3. Will fix for v3.

> 
> > > connected to the main SoC over PCIe.
> > > 
> > > The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
> > > improve routing bandwidth.
> 
> This is not always true, I'd prefer you remove this sentence from the patch
> log.

If your comment is about the statement not being always true in general, then
I agree. However for this device the port marked as WAN on HC220 v1 is the
second port on the switch and according to the DSA bindings docs only PHY0
or PHY4 can be connected to GMAC1, so I picked the one that worked (PHY4 did
not). More on that at the end of the email.

> 
> > > 
> > > The device uses NMBM over NAND, which is not currently supported in the
> > > mainline, so NAND node is skipped in this revision.
> > > 
> > > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> > > ---
> > >   arch/mips/boot/dts/ralink/Makefile            |   3 +-
> > >   .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 129 ++++++++++++++++++
> > >   2 files changed, 131 insertions(+), 1 deletion(-)
> > >   create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> > > 
> > > diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> > > index 11732b8c8163a..d27d7e8c700fe 100644
> > > --- a/arch/mips/boot/dts/ralink/Makefile
> > > +++ b/arch/mips/boot/dts/ralink/Makefile
> > > @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
> > >   dtb-$(CONFIG_SOC_MT7621) += \
> > >   	mt7621-gnubee-gb-pc1.dtb \
> > > -	mt7621-gnubee-gb-pc2.dtb
> > > +	mt7621-gnubee-gb-pc2.dtb \
> > > +	mt7621-tplink-hc220-g5-v1.dtb
> > >   obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
> > > diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> > > new file mode 100644
> > > index 0000000000000..f003ae615a58e
> > > --- /dev/null
> > > +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> > > @@ -0,0 +1,129 @@
> > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +/dts-v1/;
> > > +
> > > +#include "mt7621.dtsi"
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/input/input.h>
> > > +#include <dt-bindings/leds/common.h>
> > > +
> > > +/ {
> > > +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
> > > +	model = "TP-Link HC220 G5 v1";
> > > +
> > > +	memory@0 {
> > > +		device_type = "memory";
> > > +		reg = <0x0 0x0 0x0 0x8000000>;
> 
> What's going on here? Just do 'reg = <0x00000000 0x08000000>;'.
>

Right, hangover from 64bits world :) Will fix for v3.


> > > +	};
> > > +
> > > +	chosen {
> > > +		/* add 'earlycon=uart8260,mmio32,0x1e000c00' to
> 
> 8260?

Duh, I feel stupid. It's 8250 and (as you mention bellow) not needed to
enable early boot messages.

> 
> > > +		 * bootargs for early boot messages
> 
> Isn't just adding "earlycon" to bootargs enough?
> 
> > > +		 */
> > > +		bootargs = "console=ttyS0,115200";
> > > +	};
> > > +
> > > +	gpio-keys {
> > > +		compatible = "gpio-keys";
> > > +
> > > +		key-reset {
> > > +			label = "reset";
> > > +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
> > > +			linux,code = <KEY_RESTART>;
> > > +		};
> > > +
> > > +		key-wps {
> > > +			label = "wps";
> > > +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
> > > +			linux,code = <KEY_WPS_BUTTON>;
> > > +		};
> > > +	};
> > > +
> > > +	leds {
> > > +		compatible = "gpio-leds";
> > > +
> > > +		red {
> > > +			color = <LED_COLOR_ID_RED>;
> > > +			function = LED_FUNCTION_FAULT;
> > > +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
> > > +		};
> > > +
> > > +		green {
> > > +			color = <LED_COLOR_ID_GREEN>;
> > > +			function = LED_FUNCTION_POWER;
> > > +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> > > +			linux,default-trigger = "default-on";
> > > +		};
> > > +
> > > +		blue {
> > > +			color = <LED_COLOR_ID_BLUE>;
> > > +			function = LED_FUNCTION_WPS;
> > > +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> > > +		};
> > > +	};
> > > +
> > > +	resetc: reset-controller {
> > > +		compatible = "ralink,rt2880-reset";
> > > +		#reset-cells = <1>;
> > > +	};
> 
> We don't use this anymore.
>

I've copied it from disassembled vendor device tree. Is this not needed
anymore for reset?

> > > +
> > > +	mtd {
> > > +		compatible = "mediatek,mt7622-nfc";
> > > +	};
> 
> What's this got to do with this device?

This is the NAND Flash Controller bindind. Left over from interrupted
development of the NAND support. Will remove for v3.

> 
> > > +};
> > > +
> > > +&i2c {
> > > +	status = "okay";
> > > +};
> 
> Why does this device need i2c?

It doesn't. I was curious if there was anything hanging on that bus so I've
enabled it to scan it. Will remove for v3.


> 
> > > +
> > > +&pcie {
> > > +	status = "okay";
> > > +};
> 
> Do both WiFi chips work by just enabling pcie? I was expecting 'compatible =
> "mediatek,mt76";' on pcie@0,0 and pcie@1,0.

Nothing else is needed and I can modprobe the mt7603e and mt7615e modules just
fine, with the devices becoming available one I put the appropriate firmware in
the right place.

> 
> > > +
> > > +&spi0 {
> > > +	status = "okay";
> > > +
> > > +	flash@0 {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		compatible = "jedec,spi-nor";
> > > +		reg = <0>;
> > > +		spi-max-frequency = <50000000>;
> > > +	};
> > > +};
> 
> I thought you said this device had NAND flash, not NOR.

Appologies, I will remove this for now as I haven't finished looking into
storage problem yet.

> 
> > > +
> > > +/* gmac1 connected to MT7530's phy0 */
> > > +&gmac1 {
> > > +	phy-handle = <&ethphy0>;
> > > +
> > > +	fixed-link {
> > > +		status = "disabled";
> > > +	};
> > > +};
> > > +
> > > +&mdio {
> > > +	/* MT7530's phy0 */
> > > +	ethphy0: ethernet-phy@0 {
> > > +		reg = <0>;
> > > +	};
> > > +};
> 
> Remove the two nodes above.

It would be nice if you can provide some explanation to some of your requests
so that I can learn more about this. This is my first time dipping my toes
on MIPS and MT7621 world, so I don't have that much experience and would like
to know more.

> 
> > > +
> > > +&switch0 {
> > > +	ports {
> > > +		/* phy0 is muxed to gmac1 */
> > > +		port@0 {
> > > +			status = "okay";
> > > +			label = "lan2";
> > > +		};
> > 
> > I've made the changes to look similar to the gnubee-gb-pc2, and things mostly
> > work, with the exception that I can mount an NFS root filesystem only on "lan2"
> > interface at boot time. All other interfaces (ports) hang forever waiting for
> > an DHCP response from my server. The only difference is where I plug in the
> > ethernet cable, no other change (not even a restart) on the server.
> 
> This sounds like a userspace configuration issue.

Which userspace? On the server side? I don't touch anything there, only
change the ethernet port where the cable is connected on the device and
reboot. It only works for "lan2".

If you're talking about userspace on the device, I don't agree as there is nothing
loaded there but the kernel, and it is trying to mount the NFS root.

I have to admit that I don't really understand how the whole MT7530 DSA is wired
inside this device. I mostly did trial and error and it is very possible that what
I've got were just half results that are more confusing that they should be. The
vendor device tree uses the old bindings and drivers, with the gsw node outside
of the ethernet one and also a mtk-hnat_v1 node that seems to bundle all ports
under one single MAC address, so it's hard to understand from there how things work.
I was trying to both enable NFS root and squeeze the maximum speed from the switch,
so I thought I need to enable gmac1 and use the PHYs of the switch to enable 2Gbps
routing. When I've tried PHY4 things didn't work, while with PHY0 I've got all the
connections to work (but only if I've used LAN2 as the initial connection to the
NFS server).

Now I've tried removing the two nodes as suggested and I can mount the NFS root over
any of the three physical connections, but the iperf3 speed is only about 512Mbits/sec
vs the 730Mbits/sec that I was getting with the GMAC1 enabled.

Anyway, none of this is relevant for the upstreaming of the device tree and I will
make the requested changes. Thanks for spending time reviewing the patches.

Best regards,
Liviu

> 
> Arınç

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!
