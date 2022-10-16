Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EF15FFF2A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJPMaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJPMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:30:02 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 05:29:59 PDT
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C423EA2;
        Sun, 16 Oct 2022 05:29:59 -0700 (PDT)
Date:   Sun, 16 Oct 2022 07:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1665922451;
        bh=2wOu7XLm05TbSnVzXovoExNBJRMcjwL5pNnKx5LChU4=;
        h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
         Content-Disposition:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=iDF5srejuL3G3xjYYqQp8b9JnNwctI2HAu22mnf2OgBFHAfNdiXK5BmqNb+OfeeHB
         LMa3nos1VIdamua+ktoGNk3i9PF0sIKat3kud88V8F8HshOy8I0Gq+HdtbXj6sWkUM
         cF6UYcpEDrUrjHsF9tmDgGkKsOhiTeJd56ltjX8fbizqvmC1IySr9mKiyym27mWMT7
         OJEvi0OsPvJBY1UF8GzpkXjk6490HgpGPvopwKEjl5vwaP08Fk/KWlFM+dJFRc4kl+
         zdVcbijv2CdytHMdlx5JVAmuqxjDBF7IFrOnTlqMHKwZkHdg/2w7O3SAMffI4RkvnU
         WWaLYOm/Rwqww==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tony@atomide.com, haojian.zhuang@linaro.org,
        linus.walleij@linaro.org
Subject: pinconf-single: pinctrl-single,bias-pull{up,down} bits
 help/explanation
Message-ID: <20221016121406.co3qixzcbfke4ye7@proprietary-killer.gsrm.network>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

Working on setting up a dts for a new soc/board, along with the drivers
associated with it. The soc in question has four pinctrl/pinconf-single
blocks, which, as far as I can tell, use the exact same format for their
bitfields in the registers (could be one or more differ but that would
be an error of reading on my part).

The basic layout is thus, for each 32-bit field in the address space:

[31:11] reserved
[10:10] Level conversion rate control. The value 0 indicates a fast
        level conversion rate. The value 1 indicates a slow level
		conversion rate.
[9:9]	Pull-up resistor enable, active high.
[8:8]	Pull-down resistor enable, active high.
[7:4]   Drive capability.
[3:0]   Function select.

All of the registers are the same for bits [10:8]. Drive capability
given in several 'levels', which can have 4, 8, or 16 different values,
but that's not much of an issue. Given a specific register, iocfg_reg55,
and iocfg_reg56, which handles UART0_RXD and UART0_TXD, drive capability
values of 0-3 correspond to IO drive capablity IO_LEVEL1-4, respectively.
Their respective function select bits are:
0: GPIO5_4
1: UART0_RXD

and

0: GPIO5_5
1: UART0_TXD

Given a desire to mux this to uart0, I'd use the following dts/header snippet:

// header include/dt-bindings/pinctrl/hisi.h

/* iomg bit definition */
#define MUX_M0		0
#define MUX_M1		1
#define MUX_M2		2
#define MUX_M3		3
#define MUX_M4		4
#define MUX_M5		5
#define MUX_M6		6
#define MUX_M7		7

--- snip ---

// my additions
/* drive strength definition for hi3516dv300 */
#define IO_LEVEL_MASK	(15 << 4)
#define IO2_LEVEL1		(0 << 4)
#define IO2_LEVEL2		(1 << 4)
#define IO2_LEVEL3		(2 << 4)
#define IO2_LEVEL4		(3 << 4)

--- snip ---

// hi3516dv300-pinctrl.dtsi snippet
	pmx1: pinmux@111f0000 {
		compatible = "pinconf-single";
		reg = <0x111f0000 0x34>;
		#address-cells = <1>;
		#size-cells = <1>;
		#pinctrl-cells = <1>;
		#gpio-range-cells = <3>;
		ranges;

		pinctrl-single,register-width = <32>;
		pinctrl-single,function-mask = <7>;

		uart0_cfg_func: uart0_cfg_func {
			pinctrl-single,pins = <
				0x0010 MUX_M1 /* U21 UART0_RXD (iocfg_reg55)*/
				0x0014 MUX_M1 /* T20 UART0_TXD (iocfg_reg56)*/
			>;
			pinctrl-single,drive-strength = <
				IO2_LEVEL4 IO_LEVEL_MASK
			>;
		};
	};

All in all pretty simple.
What I'm having issue with is the pinctrl-single,bias-pull values. From
commit abe4e4675dfc62b7f2328e2c4bce8b5bdcdff7c0 I get a bit of it, and I
think I have it mostly figured out:

// <[input] [enabled] [disabled] [mask]>;
pinctrl-single,bias-pullup = <? 1 0 0x100>;
pinctrl-single,bias-pulldown = <? 1 0 0x200>;

using mask 0x100 to single out bit 8 and mask 0x200 to single out bit 9,
enable values being simple binary on/off. What I don't get is how the
input value is determined/calculated.

Aside from the above mentioned commit for the am335x-pocketbeagle.dts,
which uses a differing pullup control scheme, the only users I can find
in the tree are a handful of hisi socs which I don't have a datasheet
for to map their usage to register definitions and puzzle this out.

Hope someone can point out what I'm missing. I guarantee it'll be quite
obvious once it is but for the moment I'm stumped.

Regards,
Marty
