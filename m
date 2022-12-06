Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C264420B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiLFLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiLFLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:23:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0751FCD6;
        Tue,  6 Dec 2022 03:23:39 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F18F36602B11;
        Tue,  6 Dec 2022 11:23:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670325818;
        bh=rlTgEOFncee6fPGxGrdmPJK4iALNYJfpw5aOcS2FPzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI84tUNJ2OgxuFKyUIzMasbWPp2x5Gvjz71MPz5WLHgrr45NUIS3ZkaYJPU9r9nmn
         tyvLjCHa52c0d8hIvlGd/aAyUeE7epONddmSG+W201MlMM9sJrlHIQ/4G+wWvBG+yc
         Dhj+aYvpt1aRuXYXZrV1z+2FHquB2R7O7eDDO4xvtlH0EzvLKtT/0+ePpShU4MPNi6
         1V+g68BhgCE7uGuG+ueWHd8B7hVHlE6wbaazQ3BoL5NMI+S9gB4x0XqjiyuhgmYjI6
         TgcFVHcJL89VE2I7qWRPU0DXg/BTDRUHuPwiz9UhfYoiglXrmuZCwtUH942k9m+VUa
         UoYC7CAvWdaFA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/5] arm64: dts: mt8186: Add complete CPU caches information
Date:   Tue,  6 Dec 2022 12:23:28 +0100
Message-Id: <20221206112330.78431-4-angelogioacchino.delregno@collabora.com>
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

This SoC features two clusters composed of:
 - 6x Cortex A55: 32KB I-cache and 32KB D-cache, 4-way set associative,
                  per-cpu 128KB L2 cache, 4-way set associative;
 - 2x Cortex A76: 64KB I-cache and 64KB D-cache, 4-way set associative,
                  per-cpu 256KB L2 cache, 8-way set associative;
Moreover, the two clusters are sharing a DSU L3 cache with size 1MB,
16-way set associative.

With that in mind, add the appropriate properties needed to specify the
caches information for this SoC, which will now be correctly exported
to sysfs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4a2f7ad3c6f0..c4a80ce3124c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -69,6 +69,12 @@ cpu0: cpu@0 {
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
@@ -81,6 +87,12 @@ cpu1: cpu@100 {
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
@@ -93,6 +105,12 @@ cpu2: cpu@200 {
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
@@ -105,6 +123,12 @@ cpu3: cpu@300 {
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
@@ -117,6 +141,12 @@ cpu4: cpu@400 {
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
@@ -129,6 +159,12 @@ cpu5: cpu@500 {
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
@@ -141,6 +177,12 @@ cpu6: cpu@600 {
 			clock-frequency = <2050000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 		};
@@ -153,6 +195,12 @@ cpu7: cpu@700 {
 			clock-frequency = <2050000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 		};
@@ -200,18 +248,28 @@ cluster_off_b: cluster-off-b {
 		l2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 			next-level-cache = <&l3_0>;
 		};
 
 		l2_1: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-size = <262144>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 			next-level-cache = <&l3_0>;
 		};
 
 		l3_0: l3-cache {
 			compatible = "cache";
 			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
 		};
 	};
 
-- 
2.38.1

