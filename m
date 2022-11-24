Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3A6376E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKXK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKXK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:56:07 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF833F1DB0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:56:04 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2AOAVTP2039626;
        Thu, 24 Nov 2022 18:31:29 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Nov
 2022 18:55:56 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] ARM: dts: aspeed: Add ACRY/AHBC device controller node
Date:   Thu, 24 Nov 2022 18:55:50 +0800
Message-ID: <20221124105552.1006549-3-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124105552.1006549-1-neal_liu@aspeedtech.com>
References: <20221124105552.1006549-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2AOAVTP2039626
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acry & ahbc node to device tree for AST2600.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 095cf8d03616..ad177799db0b 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -94,6 +94,11 @@ gic: interrupt-controller@40461000 {
 			    <0x40466000 0x2000>;
 			};
 
+		ahbc: bus@1e600000 {
+			compatible = "aspeed,ast2600-ahbc", "syscon";
+			reg = <0x1e600000 0x100>;
+		};
+
 		fmc: spi@1e620000 {
 			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
@@ -427,6 +432,14 @@ sbc: secure-boot-controller@1e6f2000 {
 				reg = <0x1e6f2000 0x1000>;
 			};
 
+			acry: crypto@1e6fa000 {
+				compatible = "aspeed,ast2600-acry";
+				reg = <0x1e6fa000 0x400>, <0x1e710000 0x1800>;
+				interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_RSACLK>;
+				aspeed,ahbc = <&ahbc>;
+			};
+
 			video: video@1e700000 {
 				compatible = "aspeed,ast2600-video-engine";
 				reg = <0x1e700000 0x1000>;
-- 
2.25.1

