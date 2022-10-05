Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0310B5F51C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJEJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJEJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:34:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B61FCC8;
        Wed,  5 Oct 2022 02:34:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98BBD66022E4;
        Wed,  5 Oct 2022 10:34:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664962449;
        bh=pRg0SkW5d5gHVASYVoiFL+t/7J8p0XFnGA9gDu1F/Lg=;
        h=From:To:Cc:Subject:Date:From;
        b=WJEbR58ZP3OCHhAFbRm6aXrr7djjEr+MKGpCNj5rEbflgnRDXMTgxtzqyoQXTEXyL
         XKRXZx9b04xz9104Pa9sLLxBp3oSEjV9K8GzBglt/aLjU2+FGMGx9I5ZJiHf1IgkSN
         oteWdNodt8bW7wZjkX9UDFRrceYaf+faRkS57UB70fq6TmfrZSR4wgtCPQt/Hzf6hE
         ki4yp+4lU7doa58WMzS1TPp1ir+TzZATOmoyGU5QEIgUOrQuTIA00r/z9C9YU/G16b
         M5VdOnISiqaK4TLS4Bx8Pjx9Mf4yPPJTEF5C81V/c3IBjsuIBL4wsFYQqI+Wqwc609
         oDEle3kRlmX+Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tinghan.shen@mediatek.com, seiya.wang@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8195: Fix CPUs capacity-dmips-mhz
Date:   Wed,  5 Oct 2022 11:34:03 +0200
Message-Id: <20221005093404.33102-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

The capacity-dmips-mhz parameter was miscalculated: this SoC runs
the first (Cortex-A55) cluster at a maximum of 2000MHz and the
second (Cortex-A78) cluster at a maximum of 3000MHz.

In order to calculate the right capacity-dmips-mhz, the following
test was performed:
1. CPUFREQ governor was set to 'performance' on both clusters
2. Ran dhrystone with 500000000 iterations for 10 times on each cluster
3. Calculate the mean result for each cluster
4. Calculate DMIPS/MHz: dmips_mhz = dmips_per_second / cpu_mhz
5. Scale results to 1024:
   result_c0 = (dmips_mhz_c0 - min_dmips_mhz(c0, c1)) /
               (max_dmips_mhz(c0, c1) - min_dmips_mhz(c0, c1)) * 1024

The mean results for this SoC are:
Cluster 0 (LITTLE): 11990400 Dhry/s
Cluster 1 (BIG): 59809036 Dhry/s

The calculated scaled results are:
Cluster 0: 307,934312801831 (rounded to 308)
Cluster 1: 1024

Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 905d1a90b406..0b85b5874a4f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -36,7 +36,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
-			capacity-dmips-mhz = <578>;
+			capacity-dmips-mhz = <308>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
@@ -49,7 +49,7 @@ cpu1: cpu@100 {
 			enable-method = "psci";
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
-			capacity-dmips-mhz = <578>;
+			capacity-dmips-mhz = <308>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
@@ -62,7 +62,7 @@ cpu2: cpu@200 {
 			enable-method = "psci";
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
-			capacity-dmips-mhz = <578>;
+			capacity-dmips-mhz = <308>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
@@ -75,7 +75,7 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
-			capacity-dmips-mhz = <578>;
+			capacity-dmips-mhz = <308>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
-- 
2.37.2

