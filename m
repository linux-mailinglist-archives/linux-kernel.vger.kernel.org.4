Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E36C7ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjCXNcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCXNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718AD13DD1;
        Fri, 24 Mar 2023 06:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1520962AE2;
        Fri, 24 Mar 2023 13:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5B4C4339E;
        Fri, 24 Mar 2023 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679664721;
        bh=wvdaxhVUZXP2ZRN5FN1jyjGJf66FlAp1dzMNx8omUgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dI5wOby7+SLCBQjHxGxWg4aUAsvlsWT8pOoMXnzthg6BtBwZoWO4X3NLxeLY4JdQ1
         uxePXcPWZ/z26RYfVx1AjYG8RWoNTRNgcvwCYtWVBPtcK1McxI8POEMESl3NOjUUah
         B+UXnuXmaFLcIKePhb75spPKpF/dXLXh218kr0mD1PKRVnLl6IcNH0bvo0rFFoqmKQ
         asF3klXHFQ/0vq5m/iYVTcPaDvkhYAWxPzQdqCO7xSjVvgg7haPEUEkckH9K3Qh+98
         l4AH+xbtJt1i/rkUVvDM8+KJJEqeJM5z6Ne0sdKWhEuSeRrvGHw+p4CNw2Qz9rhJ4t
         xcNPQK6dxk5EQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port for USB0
Date:   Fri, 24 Mar 2023 15:31:50 +0200
Message-Id: <20230324133150.43224-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324133150.43224-1-rogerq@kernel.org>
References: <20230324133150.43224-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB0 is a Type-C port with dual data role and power sink.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index be027fad5f61..c80b12943881 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -315,6 +315,33 @@ &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+
+	tps6598x@3f {
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
 };
 
 &main_i2c1 {
@@ -336,7 +363,7 @@ exp1: gpio@22 {
 				   "UART1_FET_BUF_EN", "WL_LT_EN",
 				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
 				   "CSI_GPIO2", "PRU_3V3_EN",
-				   "HDMI_INTn", "TEST_GPIO2",
+				   "HDMI_INTn", "PD_I2C_IRQ",
 				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
 				   "MCASP1_FET_SEL", "UART1_FET_SEL",
 				   "TSINT#", "IO_EXP_TEST_LED";
@@ -486,7 +513,16 @@ &usbss1 {
 };
 
 &usb0 {
-	dr_mode = "peripheral";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	usb-role-switch;
+
+	port@0 {
+		reg = <0>;
+		usb0_hs_ep: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
 };
 
 &usb1 {
-- 
2.34.1

