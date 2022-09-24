Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49195E8DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiIXP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiIXP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:28:39 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE83AB04B;
        Sat, 24 Sep 2022 08:28:37 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EEBEA1C0009;
        Sat, 24 Sep 2022 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664033315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2jiKvigwNCrmpmoDDIe1Q9cf2ywCJuNmco8qe5Eb4w=;
        b=nfc1ufxLeKiEOuLgnK2kkWkWVZvY8MVc2hJtvoW7uyCTnn/yhPO2pOm6HSy5RsAvHq+GP4
        WBUEWwt1iU8nrNszVjWl1O+PedTg3p8ain3DwM//riPel6YRyqHKudJwjCILmx/+Phnppv
        Kj0dAnwGgS3NGLi5ppi7OPPqwkNXttqTxkCB0iRJ6JMr8425BgAYf3W0n/XLR20IKivWNd
        ZDQKg4x6dQxb7uREPb6zUYh0QrG9nQisZDtnvm4NXmxvab9UUT7X8trw8d8JXH54T8/FCB
        9GTLP6ESFgbI8hW2LAkr21KUwpT7gLB4kpDPxuhItxOB6Mqkg9cHoRBX8C9H7w==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v6 4/7] ARM: dts: sun8i: v3s: Add support for the ISP
Date:   Sat, 24 Sep 2022 17:28:17 +0200
Message-Id: <20220924152820.77149-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220924152820.77149-1-paul.kocialkowski@bootlin.com>
References: <20220924152820.77149-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3s (and related platforms) come with an instance of the A31 ISP.
Even though it is very close to the A31 ISP, it is not exactly
register-compatible and a dedicated compatible only is used as a
result.

Just like most other blocks of the camera pipeline, the ISP uses
the common CSI bus, module and ram clock as well as reset.

A port connection to the ISP is added to CSI0 for convenience since
CSI0 serves for MIPI CSI-2 interface support, which is likely to
receive raw data that will need to be processed by the ISP to produce
a final image.

The interconnects property is used to inherit the proper DMA offset.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 99966f11d061..a249b825cfe7 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -645,6 +645,14 @@ csi0_in_mipi_csi2: endpoint {
 						remote-endpoint = <&mipi_csi2_out_csi0>;
 					};
 				};
+
+				port@2 {
+					reg = <2>;
+
+					csi0_out_isp: endpoint {
+						remote-endpoint = <&isp_in_csi0>;
+					};
+				};
 			};
 		};
 
@@ -703,5 +711,32 @@ csi1: camera@1cb4000 {
 			resets = <&ccu RST_BUS_CSI>;
 			status = "disabled";
 		};
+
+		isp: isp@1cb8000 {
+			compatible = "allwinner,sun8i-v3s-isp";
+			reg = <0x01cb8000 0x1000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI1_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			interconnects = <&mbus 5>;
+			interconnect-names = "dma-mem";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					isp_in_csi0: endpoint {
+						remote-endpoint = <&csi0_out_isp>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.37.3

