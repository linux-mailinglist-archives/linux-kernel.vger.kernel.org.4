Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747C464420A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiLFLYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiLFLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:23:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404D21258;
        Tue,  6 Dec 2022 03:23:41 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 542056602B80;
        Tue,  6 Dec 2022 11:23:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670325819;
        bh=h6nkSvmYgmO1NUiTtUIOSdVJ5+xRcYgOqZpZRIpVBIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsJHfqCoL4aa4oNImrCnUmK/JLhYSrigl9mN+TT4L5JgUPQHpzlP2EgvbQYxsqzbJ
         TOC+zgn4HqCJqttQYbJ11zYuh7KsmmPy7R/Mu3pQDuyDPo21XWyKIDZ13MntoIRR19
         R/Ex9pmZiOFE2hvmAuepWR4p95uCLbiIRuY6tjGc1mTL/0QtvZUXtrzy0Yvd1mdIK4
         gqJOsZabX5lOj5LeWfrc/+dqNN3N/kJnUBXIlzCkUEEOTijQZCKJjgA/PRbW3n/Lm0
         I/LXCul8tlaR1WObeBXbgonK0iS8Zl+YJUEIHyOjmeQA9Hz4ilVUhu0PekNfp45mu1
         vgNnjLd7cA4bQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/5] arm64: dts: mt6795: Add complete CPU caches information
Date:   Tue,  6 Dec 2022 12:23:30 +0100
Message-Id: <20221206112330.78431-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206112330.78431-1-angelogioacchino.delregno@collabora.com>
References: <20221206112330.78431-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SoC's AP subsystem has 8x Cortex-A53 CPUs, specifically,
four CPUs per cluster, with two CPU clusters.

Each CPU has:
 - A 32KB I-cache, 2-way set associative;
 - A 32KB D-cache, 4-way set associative.

Each cluster has a unified 1MB L2 cache, 16-way set associative.

With that in mind, add the appropriate properties needed to specify the
caches information for this SoC, which will now be correctly exported
to sysfs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index bb575837e4ce..b3fc76d837a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -40,6 +40,12 @@ cpu1: cpu@1 {
 			enable-method = "psci";
 			reg = <0x001>;
 			cci-control-port = <&cci_control2>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -49,6 +55,12 @@ cpu2: cpu@2 {
 			enable-method = "psci";
 			reg = <0x002>;
 			cci-control-port = <&cci_control2>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -58,6 +70,12 @@ cpu3: cpu@3 {
 			enable-method = "psci";
 			reg = <0x003>;
 			cci-control-port = <&cci_control2>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 		};
 
@@ -67,6 +85,12 @@ cpu4: cpu@100 {
 			enable-method = "psci";
 			reg = <0x100>;
 			cci-control-port = <&cci_control1>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -76,6 +100,12 @@ cpu5: cpu@101 {
 			enable-method = "psci";
 			reg = <0x101>;
 			cci-control-port = <&cci_control1>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -85,6 +115,12 @@ cpu6: cpu@102 {
 			enable-method = "psci";
 			reg = <0x102>;
 			cci-control-port = <&cci_control1>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -94,6 +130,12 @@ cpu7: cpu@103 {
 			enable-method = "psci";
 			reg = <0x103>;
 			cci-control-port = <&cci_control1>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_1>;
 		};
 
@@ -138,11 +180,19 @@ core3 {
 		l2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
 		};
 
 		l2_1: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
 		};
 	};
 
-- 
2.38.1

