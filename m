Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1EC5EC1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiI0MA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiI0MAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:00:25 -0400
X-Greylist: delayed 1646 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 05:00:21 PDT
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658FEB07D0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:00:20 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pa-00CJmi-S7
        for linux-kernel@vger.kernel.org; Tue, 27 Sep 2022 13:32:54 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pG-00CJjL-Em; Tue, 27 Sep 2022 13:32:34 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pF-0055tZ-VR; Tue, 27 Sep 2022 13:32:33 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: [PATCH v2 3/3] ARM: dts: en7523: Add SPI node
Date:   Tue, 27 Sep 2022 13:32:29 +0200
Message-Id: <20220927113229.1214224-4-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927113229.1214224-1-bert@biot.com>
References: <20220927113229.1214224-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an SPI node for the EN7523, so far only used for hooking up
the NAND boot flash.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/arm/boot/dts/en7523-evb.dts | 20 ++++++++++++++++++++
 arch/arm/boot/dts/en7523.dtsi    | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
index f23a25cce119..50ccd58b1672 100644
--- a/arch/arm/boot/dts/en7523-evb.dts
+++ b/arch/arm/boot/dts/en7523-evb.dts
@@ -26,6 +26,26 @@ memory@80000000 {
 	};
 };
 
+&spi0 {
+	nand: nand@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		nand-ecc-engine = <&nand>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x80000>;
+				read-only;
+			};
+		};
+	};
+};
+
 &gpio0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
index 7f839331a777..a0d0862005fb 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -201,4 +201,14 @@ pcie_intc1: interrupt-controller {
 			#interrupt-cells = <1>;
 		};
 	};
+
+	spi0: spi@1fa10000 {
+		compatible = "airoha,en7523-spi";
+		reg = <0x1fa10000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&scu EN7523_CLK_SPI>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
 };
-- 
2.25.1

