Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7925F62A10A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKOSGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKOSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:06:32 -0500
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C2305
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:06:30 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NBYyn3rHZzMqFk9;
        Tue, 15 Nov 2022 19:06:25 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NBYyl11H9zMppYF;
        Tue, 15 Nov 2022 19:06:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1668535585;
        bh=Ppwbtaour3/Jw/cgaDOFjnjF7G+KdfGQVdagBHehM/g=;
        h=From:To:Cc:Subject:Date:From;
        b=lt1lC9fQVWKV5ufGh4LiBh1eGcYTsK9YSrmV7QZRKqi8erKNY1aWKxRmeQpd8P9AX
         PaOpnGoBFZ8w8PEAtP8UJMRpVZasp+s2sIaPmZFY21+v8tyhXFqUnmXqmA3yV/gJUe
         8GmT1kNxgu/F494LF658bQB/L+IBwhXtuyLdcQS4=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: colibri-imx6ull: Enable dual-role switching
Date:   Tue, 15 Nov 2022 19:05:54 +0100
Message-Id: <20221115180554.73696-1-dev@pschenker.ch>
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
USB Host to USB Device and back. Make use of this GPIO by adding it
with usb-connector framework.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Switched from extcon-usb-gpio to usb-connector-gpio

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index a4429ba1f2ae..336ab2e0534c 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -24,6 +24,28 @@ backlight: backlight {
 		status = "disabled";
 	};
 
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_snvs_usbc_det>;
+		id-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / USBC_DET */
+		label = "USBC";
+		self-powered;
+		type = "micro";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				usb_dr_connector: endpoint {
+					remote-endpoint = <&usb1_drd_sw>;
+				};
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -280,6 +302,13 @@ &usbotg1 {
 	srp-disable;
 	hnp-disable;
 	adp-disable;
+	usb-role-switch;
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
 };
 
 /* Colibri USBH */
-- 
2.38.1

