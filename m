Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0221B67C8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbjAZKfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjAZKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:35:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BA86AF41;
        Thu, 26 Jan 2023 02:35:37 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16AC16602E6C;
        Thu, 26 Jan 2023 10:35:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674729336;
        bh=ewzG3bsZfarFS++4YljfNfR9eURvUZDK2OObKxm5aBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPUDNL9YCFo2GUu68Jkg79rx/u7sl2UPyeQWRtrcEgcgZFSum3AkkEc/cGPxA9KTt
         qLtFVCxSJnY6Z92KogNBIQ8sPavcXV1H21Mp+7c5QPDNiuj5mOtx+2UICa1cN0sAZG
         bJ5V7vUFSdvAeLvcLFI82gZEY/rE3cBicVUD9RzB1q+hFNDWDeVitgkrQp8T/d3y8R
         DlcKFDTA5KldK776lW1G+hbL5+jT8G8RSvnTv8qd8PoQQ3YqEWbfxiN5lhmHm9xOQc
         2nRGRwrRZnoeh0fH/Hn5bJ2faVtvSIfL1zCGbgjqFGyncibQ0+OO/FRuXBUgXlBM+e
         MBFeOYP7FtJ1A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        seiya.wang@mediatek.com, tinghan.shen@mediatek.com,
        allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/6] arm64: dts: mt8195: Change idle states names to reflect actual function
Date:   Thu, 26 Jan 2023 11:35:24 +0100
Message-Id: <20230126103526.417039-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126103526.417039-1-angelogioacchino.delregno@collabora.com>
References: <20230126103526.417039-1-angelogioacchino.delregno@collabora.com>
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

The names of the idle states are misleading being this a single cluster
SoC, a cluster-off idle state is impossible!

After some research in ATF, it emerged that the cpu-off state is in
reality putting CPUs in retention state, while the cluster-off one
is turning off the CPUs.

Summarizing renaming:
 - cpu-off -> cpu-retention
 - cluster-off -> cpu-off

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index f04f836d9a72..60ccf02b60bd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -38,7 +38,7 @@ cpu0: cpu@0 {
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <308>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -57,7 +57,7 @@ cpu1: cpu@100 {
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <308>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -76,7 +76,7 @@ cpu2: cpu@200 {
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <308>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -95,7 +95,7 @@ cpu3: cpu@300 {
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <308>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -114,7 +114,7 @@ cpu4: cpu@400 {
 			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -133,7 +133,7 @@ cpu5: cpu@500 {
 			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -152,7 +152,7 @@ cpu6: cpu@600 {
 			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -171,7 +171,7 @@ cpu7: cpu@700 {
 			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -221,7 +221,7 @@ core7 {
 		idle-states {
 			entry-method = "psci";
 
-			cpu_off_l: cpu-off-l {
+			cpu_ret_l: cpu-retention-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -230,7 +230,7 @@ cpu_off_l: cpu-off-l {
 				min-residency-us = <580>;
 			};
 
-			cpu_off_b: cpu-off-b {
+			cpu_ret_b: cpu-retention-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -239,7 +239,7 @@ cpu_off_b: cpu-off-b {
 				min-residency-us = <740>;
 			};
 
-			cluster_off_l: cluster-off-l {
+			cpu_off_l: cpu-off-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010002>;
 				local-timer-stop;
@@ -248,7 +248,7 @@ cluster_off_l: cluster-off-l {
 				min-residency-us = <840>;
 			};
 
-			cluster_off_b: cluster-off-b {
+			cpu_off_b: cpu-off-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010002>;
 				local-timer-stop;
-- 
2.39.0

