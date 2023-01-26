Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9C67C8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbjAZKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbjAZKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:35:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A26C565;
        Thu, 26 Jan 2023 02:35:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C957D6602E6E;
        Thu, 26 Jan 2023 10:35:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674729337;
        bh=5G3lKYmabCCWJ0ClcZ1qdU2NYkJbDWfAMHVhV3swQrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWlikC9dJpMUomqbG+4kS6bsrepJPL0Xpy+LUnPnPHCxIISVJX0yqiE/nqnhxuY4R
         HsPWsWZZk7lUMWfyOLRRUfAVnp1qF6AxPacymnrQPlgpd9MFkSN2BfqEGWCoiYgtFs
         epSNECzNdXVb4J+ZmpmN8/57mWsZ41cnJBUAFirLlu7lDA/H7+daKpoYf3CbS1bE/d
         tzxn/V+XypyABKLs2hr77cOzWJZWnjqB7ih6MYpvqeWeSRQRtKhpCmqmd63ri/Qfbo
         VrfLUvShXES8FErpBanAyQ6NsVSE2zSWdFJ7/tpq5qOoIlRPQnCcRoTHAkskMxKVpP
         sJPaAxkXxvUFw==
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
Subject: [PATCH 5/6] arm64: dts: mt8186: Change idle states names to reflect actual function
Date:   Thu, 26 Jan 2023 11:35:25 +0100
Message-Id: <20230126103526.417039-6-angelogioacchino.delregno@collabora.com>
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
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 9e8daaa044dc..50fdb88bdc3d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -66,7 +66,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -84,7 +84,7 @@ cpu1: cpu@100 {
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -102,7 +102,7 @@ cpu2: cpu@200 {
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -120,7 +120,7 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -138,7 +138,7 @@ cpu4: cpu@400 {
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -156,7 +156,7 @@ cpu5: cpu@500 {
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
 			capacity-dmips-mhz = <382>;
-			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -174,7 +174,7 @@ cpu6: cpu@600 {
 			enable-method = "psci";
 			clock-frequency = <2050000000>;
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -192,7 +192,7 @@ cpu7: cpu@700 {
 			enable-method = "psci";
 			clock-frequency = <2050000000>;
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -206,7 +206,7 @@ cpu7: cpu@700 {
 		idle-states {
 			entry-method = "psci";
 
-			cpu_off_l: cpu-off-l {
+			cpu_ret_l: cpu-retention-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -215,7 +215,7 @@ cpu_off_l: cpu-off-l {
 				min-residency-us = <1600>;
 			};
 
-			cpu_off_b: cpu-off-b {
+			cpu_ret_b: cpu-retention-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -224,7 +224,7 @@ cpu_off_b: cpu-off-b {
 				min-residency-us = <1400>;
 			};
 
-			cluster_off_l: cluster-off-l {
+			cpu_off_l: cpu-off-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010001>;
 				local-timer-stop;
@@ -233,7 +233,7 @@ cluster_off_l: cluster-off-l {
 				min-residency-us = <2100>;
 			};
 
-			cluster_off_b: cluster-off-b {
+			cpu_off_b: cpu-off-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010001>;
 				local-timer-stop;
-- 
2.39.0

