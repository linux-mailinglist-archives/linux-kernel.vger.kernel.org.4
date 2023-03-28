Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B486CBF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjC1Mnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjC1Mns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41F9ECF;
        Tue, 28 Mar 2023 05:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE9C961764;
        Tue, 28 Mar 2023 12:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55C2C4339C;
        Tue, 28 Mar 2023 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680007409;
        bh=o05r9h4SbLyiMBOmSHs01/zEhHQ6MFt93kq9kl342Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fm15YRSEEzzRt5CbfNMR4i8z9EsewiMDmbqRURxjXp57gFw508CvBJDCWpFKu+QGW
         SlMe3g3UMRSw+HhtCB+fExGeGniljesvCnH1QupfcSRRgPC5f/RtamZCb64aLyf7pY
         cL8C7jIAgoaGWEfv1as9kOn+rGnhjE28GTDQdhUqvAQfUyYVV8wY3UMCGGRCr8f3Fe
         i1hlecVVvTgjwgjXzUd1TDQRJOvmzxl/IZNtf6el4IO5ski1xY4jaL7/I3lzRFj0hn
         0D7fCQ5UfTGWZlu/AGYYU0gFa41QtDGDd9Y0eGyIzKDXa8nYI8n1dakTDZrT5C9ggQ
         oXAWrSrugHdIA==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port for USB0
Date:   Tue, 28 Mar 2023 15:43:15 +0300
Message-Id: <20230328124315.123778-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328124315.123778-1-rogerq@kernel.org>
References: <20230328124315.123778-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB0 is a Type-C port with dual data role and power sink.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      |  4 ++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 44 ++++++++++++++++++-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  4 --
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index b2ca19e3042e..a3c3609833fd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -225,3 +225,7 @@ ldo4_reg: ldo4 {
 		};
 	};
 };
+
+&usb0 {
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index cdc0858dd1b2..13fdaa9ce4e7 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -136,6 +136,35 @@ AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
 	};
 };
 
+&main_i2c0 {
+	typec_pd: tps6598x@3f {
+		compatible = "ti,tps6598x";
+		reg = <0x3f>;
+		interrupt-parent = <&exp1>;
+		interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "irq";
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usb_con_hs: endpoint {
+						remote-endpoint = <&usb0_hs_ep>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &main_i2c1 {
 	exp1: gpio@22 {
 		compatible = "ti,tca6424";
@@ -150,7 +179,7 @@ exp1: gpio@22 {
 				   "UART1_FET_BUF_EN", "WL_LT_EN",
 				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
 				   "CSI_GPIO2", "PRU_3V3_EN",
-				   "HDMI_INTn", "TEST_GPIO2",
+				   "HDMI_INTn", "PD_I2C_IRQ",
 				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
 				   "MCASP1_FET_SEL", "UART1_FET_SEL",
 				   "TSINT#", "IO_EXP_TEST_LED";
@@ -256,3 +285,16 @@ partition@3fc0000 {
 		};
 	};
 };
+
+&usb0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	usb-role-switch;
+
+	port@0 {
+		reg = <0>;
+		usb0_hs_ep: endpoint {
+		    remote-endpoint = <&usb_con_hs>;
+	       };
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 80e8b9b9a5f5..e3223088b90c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -264,10 +264,6 @@ &usbss1 {
 	ti,vbus-divider;
 };
 
-&usb0 {
-	dr_mode = "peripheral";
-};
-
 &usb1 {
 	dr_mode = "host";
 	pinctrl-names = "default";
-- 
2.34.1

