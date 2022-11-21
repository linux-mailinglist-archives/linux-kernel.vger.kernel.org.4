Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D1632AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKURTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiKURTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:19:21 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC17FF03;
        Mon, 21 Nov 2022 09:18:09 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 849AF6000B;
        Mon, 21 Nov 2022 17:18:02 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: [PATCH RFC v2 4/7] arm64: dts: allwinner: fix touchscreen reset GPIO polarity
Date:   Mon, 21 Nov 2022 18:17:21 +0100
Message-Id: <20221103-upstream-goodix-reset-v2-4-2c38fb03a300@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
References: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The reset line is active low for the Goodix touchscreen controller so
let's fix the polarity in the Device Tree node.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi          | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 8233582f62881..5fd581037d987 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -122,7 +122,7 @@ touchscreen@5d {
 		interrupt-parent = <&pio>;
 		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
 		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
-		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>;	/* CTP-RST: PH8 */
 		touchscreen-inverted-x;
 		touchscreen-inverted-y;
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 577f9e1d08a14..990f042f5a5b1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -45,7 +45,7 @@ touchscreen@5d {
 		interrupt-parent = <&pio>;
 		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
 		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
-		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>;	/* CTP-RST: PH11 */
 		touchscreen-inverted-x;
 		touchscreen-inverted-y;
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d9..97359cc7f13e2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -167,7 +167,7 @@ touchscreen@5d {
 		interrupt-parent = <&pio>;
 		interrupts = <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
 		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
 		AVDD28-supply = <&reg_ldo_io0>;
 		VDDIO-supply = <&reg_ldo_io0>;
 		touchscreen-size-x = <720>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 0a5607f73049e..c0eccc753e3f5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -189,7 +189,7 @@ touchscreen@5d {
 		interrupt-parent = <&pio>;
 		interrupts = <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
 		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
 		AVDD28-supply = <&reg_ldo_io1>;
 	};
 };

-- 
b4 0.10.1
