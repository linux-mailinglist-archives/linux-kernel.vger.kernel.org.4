Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9E64420F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiLFLX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiLFLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:23:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1810B66;
        Tue,  6 Dec 2022 03:23:39 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D3196602ADA;
        Tue,  6 Dec 2022 11:23:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670325817;
        bh=lO17/VleyNXgn9N/3LZMvXR6w59EZEPe9elRRz8H1Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BdcQBBpB7uwn4qOnYraSkpv3u0Rp+4xUnwnIUbUKeHhu7LssAJ5DJCM/iTCIm2Hz9
         7/6YVhx+kJQbpI0Yd18SBhBOWmXav4RkIJPS6ohsQBNnLOYAoa2xtX5c+bA66tWeNb
         7Q5mmtcKcYgbo5PihT7jMI3IapID34FEGhRX+6AxEQs/k5OnwFoKwnLJlLGTFLJhot
         pzyFZaVbO7tC/nrluuNezvh25jai0uXRiKRIF3JyrdnKARTC7z1njEmRSBl3sEbIcr
         UnQmuFm5cTZ9I8soWXtAP5ngp+V8Mm7zDTyFILMtpXLwY/r7nEar14Jmav80gxNPG+
         VZayvKqB5NSSw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/5] arm64: dts: mt8192: Add complete CPU caches information
Date:   Tue,  6 Dec 2022 12:23:27 +0100
Message-Id: <20221206112330.78431-3-angelogioacchino.delregno@collabora.com>
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
 - 4x Cortex A55: 32KB I-cache and 32KB D-cache, 4-way set associative,
                  per-cpu 128KB L2 cache, 4-way set associative;
 - 4x Cortex A76: 64KB I-cache and 64KB D-cache, 4-way set associative,
                  per-cpu 256KB L2 cache, 8-way set associative;
Moreover, the two clusters are sharing a DSU L3 cache with size 2MB,
16-way set associative.

With that in mind, add the appropriate properties needed to specify the
caches information for this SoC, which will now be correctly exported
to sysfs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 424fc89cc6f7..3b5d49bf174d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -54,6 +54,12 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -65,6 +71,12 @@ cpu1: cpu@100 {
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -76,6 +88,12 @@ cpu2: cpu@200 {
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -87,6 +105,12 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -98,6 +122,12 @@ cpu4: cpu@400 {
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -109,6 +139,12 @@ cpu5: cpu@500 {
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -120,6 +156,12 @@ cpu6: cpu@600 {
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -131,6 +173,12 @@ cpu7: cpu@700 {
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -170,18 +218,28 @@ core3 {
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
+			cache-size = <2097152>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-unified;
 		};
 
 		idle-states {
-- 
2.38.1

