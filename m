Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC6715E70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjE3MEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjE3MEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:04:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95882FF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:04:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4s-0000DN-Ma; Tue, 30 May 2023 14:03:50 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4r-003rWz-Tu; Tue, 30 May 2023 14:03:49 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4o-00C3vp-Rw; Tue, 30 May 2023 14:03:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 10/15] ARM: dts: imx6dl: prtmvt: fix different USB related warnings
Date:   Tue, 30 May 2023 14:03:40 +0200
Message-Id: <20230530120345.2874900-11-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530120345.2874900-1-o.rempel@pengutronix.de>
References: <20230530120345.2874900-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix USB-related warnings in imx6dl prtmvt device tree by disabling
unused usbphynop1 and usbphynop2 USB PHYs and over-current detection
which is not supported on USB h1 port. This fixes the following warnings
with the current kernel:
usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests
usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive requests
imx_usb 2184200.usb: No over current polarity defined

By the way, fix over-current detection on usbotg port.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-prtmvt.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-prtmvt.dts b/arch/arm/boot/dts/imx6dl-prtmvt.dts
index 5f4fa796ca18..773a84a5739d 100644
--- a/arch/arm/boot/dts/imx6dl-prtmvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtmvt.dts
@@ -560,6 +560,7 @@ &usbh1 {
 	pinctrl-names = "default";
 	phy_type = "utmi";
 	dr_mode = "host";
+	disable-over-current;
 	status = "okay";
 };
 
@@ -569,10 +570,18 @@ &usbotg {
 	pinctrl-0 = <&pinctrl_usbotg>;
 	phy_type = "utmi";
 	dr_mode = "host";
-	disable-over-current;
+	over-current-active-low;
 	status = "okay";
 };
 
+&usbphynop1 {
+	status = "disabled";
+};
+
+&usbphynop2 {
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-- 
2.39.2

