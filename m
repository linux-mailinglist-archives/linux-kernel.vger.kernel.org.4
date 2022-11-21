Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB30E632ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiKURTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiKURTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:19:15 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF71C43C;
        Mon, 21 Nov 2022 09:17:56 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 4825B60007;
        Mon, 21 Nov 2022 17:17:50 +0000 (UTC)
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
Subject: [PATCH RFC v2 2/7] ARM: dts: imx: fix touchscreen reset GPIO polarity
Date:   Mon, 21 Nov 2022 18:17:19 +0100
Message-Id: <20221103-upstream-goodix-reset-v2-2-2c38fb03a300@theobroma-systems.com>
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
 arch/arm/boot/dts/imx6q-kp.dtsi            | 2 +-
 arch/arm/boot/dts/imx6ul-kontron-bl-43.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
index 1ade0bff681d6..dae14aaf803a8 100644
--- a/arch/arm/boot/dts/imx6q-kp.dtsi
+++ b/arch/arm/boot/dts/imx6q-kp.dtsi
@@ -188,7 +188,7 @@ touchscreen@5d {
 		interrupt-parent = <&gpio1>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 		irq-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
 	};
 
 	ds1307: rtc@32 {
diff --git a/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
index 0c643706a158b..767ef5da76136 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
@@ -29,7 +29,7 @@ touchscreen@5d {
 		pinctrl-0 = <&pinctrl_cap_touch>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
-		reset-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
 		irq-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
 	};
 };

-- 
b4 0.10.1
