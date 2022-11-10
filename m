Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4E623913
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKJBoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJBoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:44:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 274BA275E2;
        Wed,  9 Nov 2022 17:44:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8B671FB;
        Wed,  9 Nov 2022 17:44:27 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AF633F703;
        Wed,  9 Nov 2022 17:44:20 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [RFC PATCH 0/2] pinctrl: sunxi: Introduce DT-based pinctrl builder 
Date:   Thu, 10 Nov 2022 01:42:53 +0000
Message-Id: <20221110014255.20711-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since the dawn of time every Allwinner SoC dumped a rather large table
of data into the kernel, to describe the mapping between the pinctrl
function name and its mux value, for each pin.

This series introduces code that avoids that (for new SoCs), by instead
reading that information directly from the devicetree. We have per-pin
group nodes there anyway, and were just missing the mux value.

Compared to my previous effort almost exactly five years ago [1], this
new version drops the idea of describing the pinctrl data entirely in
the DT, instead it still relies on driver provided information for that.
That is more flexible, since it allows to introduce quirks and special
handling more cleanly, at the cost of still requiring a separate driver
file for each SoC. However this file is now very small, and can be
easily written and reviewed. All that is needed is the number of pins
per bank, plus information about each bank's IRQ capability.
Patch 2/2 shows an example, for the yet unsupported Allwinner V5 SoC.

On the DT side all that would be needed is *one* extra property per
pin group to announce the mux value:

	uart0_pb_pins: uart0-pb-pins {
		pins = "PB9", "PB10";
		function = "uart0";
		pinmux = <2>;
	};

The new code works by providing a function that builds the former
mapping table *at runtime*, by using both the driver provided
information, plus traversing all children of the pinctrl DT node, to
find all pin groups needed. This table looks the same as what we
hardcoded so far, so can easily be digested by the existing sunxi
pinctrl driver.

Please have a look and tell me whether this new approach has a better
future than my previous attempt.

Cheers,
Andre

[1] https://patchwork.ozlabs.org/project/linux-gpio/cover/20171113012523.2328-1-andre.przywara@arm.com/


Andre Przywara (2):
  pinctrl: sunxi: allow reading mux values from DT
  pinctrl: sunxi: Add support for the Allwinner V5 pin controller

 drivers/pinctrl/sunxi/Kconfig            |   5 +
 drivers/pinctrl/sunxi/Makefile           |   2 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-v5.c |  52 ++++
 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c | 355 +++++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h    |   8 +
 5 files changed, 422 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-v5.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c

-- 
2.35.5

