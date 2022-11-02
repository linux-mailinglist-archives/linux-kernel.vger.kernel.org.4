Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C321616688
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKBPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiKBPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:52:38 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A2C2AE35
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:52:35 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N2WcK0L8xzMqNZt;
        Wed,  2 Nov 2022 16:52:33 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4N2WcJ40DVzMpqBV;
        Wed,  2 Nov 2022 16:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1667404352;
        bh=hsmqP6LW9Hc8mmhziJ3amvKnlktfxLKv2Sastr0h7Mc=;
        h=From:To:Cc:Subject:Date:From;
        b=TQm8+MuVUwOG0FZujEOnW7Guwm64m8a1xGcEzqlHvLxisaRwxJuzqvTua50ZFeZ+X
         WaTLDPNoYxMGvittPp5RHg9Qxp6YowAa+4AbXgQ0O7bT+VF+dU5UR0okp58kB1PKra
         k1IgbmLnWIgyikD4GOCunTDajWVD1JyWv9QxjEUk=
From:   Philippe Schenker <dev@pschenker.ch>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: colibri-imx6ull: Enable dual-role switching
Date:   Wed,  2 Nov 2022 16:52:26 +0100
Message-Id: <20221102155226.51587-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

The Colibri standard provides a GPIO called USBC_DET to switch from
USB Host to USB Device and back. The Colibri iMX6ULL does have the SoC
ball USB_OTG1_VBUS connected in series with a capacitor to ground.

This means that we need to provide to the extcon framework VBUS and ID
events using the single GPIO we have. The Extcon USB GPIO driver does
use id-gpio also for VBUS event, as in our case where vbus-gpio is
absent.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 577a424b0e1d..feb1fcd9a684 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -24,6 +24,13 @@ backlight: backlight {
 		status = "okay";
 	};
 
+	extcon_usbc_det: usbc-det {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / USBC_DET */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_snvs_usbc_det>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -275,6 +282,7 @@ &uart5 {
 /* Colibri USBC */
 &usbotg1 {
 	dr_mode = "otg";
+	extcon = <&extcon_usbc_det>, <&extcon_usbc_det>;
 	srp-disable;
 	hnp-disable;
 	adp-disable;
-- 
2.38.1

