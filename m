Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12AE67C8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbjAZKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjAZKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:35:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCAF6C578;
        Thu, 26 Jan 2023 02:35:39 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 871386602E70;
        Thu, 26 Jan 2023 10:35:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674729338;
        bh=811mGtt7JeQpT1SuTm7rNcFj7Fd9S3mKqBcc7+C7qO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLEWxzAERpYLA71egOjO1LATE/G5//9XwW2RYijXWjLBe5kqhJ3/LtFQpMax9utRN
         qz8/Hv4oCO8+KLAbBReSaZ/B+VmF7Gz9YWHK+/KCNmEv+uTJ9Ks9Yf1HTZ1lQBLICO
         8BK5wVqph8zbM4odGWGIpXiZw0pfEJTVFK+9b/A3RumiYMFPLegMuYjc74AwKSEujX
         9NIN9hOr1GMELINFzyKxZOSdVxTl06G10xlvFF8SQxoimP/1pNMVBCHtddIJz9PTwh
         gpxyBVVO9E5kh0T/p/MUmD0CuHXQOZ+qAUo2DM+2SvrdHnxDoLZxWJ+fNuEEiQPtpw
         2U8HKU8f8jfjw==
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
Subject: [PATCH 6/6] arm64: dts: mt8192: Change idle states names to reflect actual function
Date:   Thu, 26 Jan 2023 11:35:26 +0100
Message-Id: <20230126103526.417039-7-angelogioacchino.delregno@collabora.com>
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
SoC, a cluster-sleep idle state is impossible!

After some research in ATF, it emerged that the cpu-sleep state is in
reality putting CPUs in retention state, while the cluster-sleep one
is turning off the CPUs.

Summarizing renaming:
 - cpu-sleep -> cpu-retention
 - cluster-sleep -> cpu-off

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index eb46cbadd310..87b91c8feaf9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -62,7 +62,7 @@ cpu0: cpu@0 {
 			reg = <0x000>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -79,7 +79,7 @@ cpu1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -96,7 +96,7 @@ cpu2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -113,7 +113,7 @@ cpu3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -130,7 +130,7 @@ cpu4: cpu@400 {
 			reg = <0x400>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -147,7 +147,7 @@ cpu5: cpu@500 {
 			reg = <0x500>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -164,7 +164,7 @@ cpu6: cpu@600 {
 			reg = <0x600>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -181,7 +181,7 @@ cpu7: cpu@700 {
 			reg = <0x700>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -250,7 +250,7 @@ l3_0: l3-cache {
 
 		idle-states {
 			entry-method = "psci";
-			cpu_sleep_l: cpu-sleep-l {
+			cpu_ret_l: cpu-retention-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -258,7 +258,7 @@ cpu_sleep_l: cpu-sleep-l {
 				exit-latency-us = <140>;
 				min-residency-us = <780>;
 			};
-			cpu_sleep_b: cpu-sleep-b {
+			cpu_ret_b: cpu-retention-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -266,7 +266,7 @@ cpu_sleep_b: cpu-sleep-b {
 				exit-latency-us = <145>;
 				min-residency-us = <720>;
 			};
-			cluster_sleep_l: cluster-sleep-l {
+			cpu_off_l: cpu-off-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010002>;
 				local-timer-stop;
@@ -274,7 +274,7 @@ cluster_sleep_l: cluster-sleep-l {
 				exit-latency-us = <155>;
 				min-residency-us = <860>;
 			};
-			cluster_sleep_b: cluster-sleep-b {
+			cpu_off_b: cpu-off-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010002>;
 				local-timer-stop;
-- 
2.39.0

