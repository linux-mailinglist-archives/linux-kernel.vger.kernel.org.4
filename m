Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB679613550
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiJaMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiJaMHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:07:13 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F905590;
        Mon, 31 Oct 2022 05:07:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2FAFC80CD;
        Mon, 31 Oct 2022 11:57:43 +0000 (UTC)
Date:   Mon, 31 Oct 2022 14:07:10 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Georgi Vlaev <g-vlaev@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/3] Make TI dmtimer features more usable
Message-ID: <Y1+6bmuup36ZF3H9@atomide.com>
References: <20221031115613.56229-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031115613.56229-1-tony@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [221031 11:46]:
> I have only lightly tested this so far to make sure I get clock output on
> k3-am625-sk on TIMER_IO2 at user expansion connector pin 10.

For reference, I used something like the patch below to configure the timer2
for clock output.

Regards,

Tony

8< ---------------------
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -143,6 +143,25 @@ led-0 {
 			default-state = "off";
 		};
 	};
+
+	main_pwm2: dmtimer-main-pwm-2 {
+		pinctrl-0 = <&main_timer2_pins_default>;
+		pinctrl-names = "default";
+		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
+		ti,timers = <&main_timer2>;
+		interrupts-extended = <&main_timer2 2 IRQ_TYPE_EDGE_RISING>,
+				      <&main_timer2 1 IRQ_TYPE_EDGE_RISING>,
+				      <&main_timer2 0 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "compare", "overflow", "match";
+		clocks = <&main_timer2>;
+	};
+};
+
+&main_timer2 {
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	#clock-cells = <0>;
 };
 
 &main_pmx0 {
@@ -270,6 +289,13 @@ AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */
 		>;
 	};
 
+	main_timer2_pins_default: main-timer2-pins-default {
+		pinctrl-single,pins = <
+			/* (C15) PADCFG_CTRL_PADCONFIG118 0x000f41d8 TIMER_IO2 */
+			AM65X_IOPAD(0x1d8, PIN_OUTPUT, 2)
+		>;
+	};
+
 	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-pins-default {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
