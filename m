Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8985862F175
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiKRJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbiKRJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:39:51 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A32250D;
        Fri, 18 Nov 2022 01:39:50 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61A83AF4;
        Fri, 18 Nov 2022 10:39:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764389;
        bh=hmyLpab8VmHMSS3/2OG4UYDiDFK/Q8oMtYRnn8VQ7fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFH1LLo5i4J0HJ5cCTgvvqJeLnrXlevbdDgc3REixGzWWxLVBivl7Z/P5j869ghiO
         Wvnm97wdehUTHk1oH7sOfSUtszYHMWSh6ZXByrD6LKdgh8U/WXTYAhk3fCNTWu1RUJ
         PxRCZjAamHACoqCr3R0kABiAeEvaivPfphp+T5xk=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP example
Date:   Fri, 18 Nov 2022 18:39:19 +0900
Message-Id: <20221118093931.1284465-3-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add an example to the rockchip-isp1 DT binding that showcases usage of
the parallel input of the ISP, connected to the CSI-2 receiver internal
to the i.MX8MP.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
index 95cf945f7ac5..88d9bc378f79 100644
--- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
@@ -285,3 +285,75 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/clock/imx8mp-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/media/video-interfaces.h>
+    #include <dt-bindings/power/imx8mp-power.h>
+
+    parent2: parent {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        isp@32e10000 {
+            compatible = "fsl,imx8mp-isp";
+            reg = <0x32e10000 0x10000>;
+            interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>,
+                     <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
+                     <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
+            clock-names = "isp", "hclk", "aclk";
+            assigned-clocks = <&clk IMX8MP_CLK_MEDIA_ISP>;
+            assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>;
+            assigned-clock-rates = <500000000>;
+            power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_ISP>;
+            fsl,blk-ctrl = <&media_blk_ctrl 0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@1 {
+                    reg = <1>;
+                    isp0_in: endpoint {
+                        bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
+                        remote-endpoint = <&mipi_csi_0_out>;
+                    };
+                };
+            };
+        };
+
+        csi@32e40000 {
+            compatible = "fsl,imx8mp-mipi-csi2", "fsl,imx8mm-mipi-csi2";
+            reg = <0x32e40000 0x10000>;
+            interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+            clock-frequency = <500000000>;
+            clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
+                     <&clk IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT>,
+                     <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT>,
+                     <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>;
+            clock-names = "pclk", "wrap", "phy", "axi";
+            assigned-clocks = <&clk IMX8MP_CLK_MEDIA_CAM1_PIX>;
+            assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>;
+            assigned-clock-rates = <500000000>;
+            power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_MIPI_CSI2_1>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    mipi_csi_0_out: endpoint {
+                        remote-endpoint = <&isp0_in>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.35.1

