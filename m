Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7296531D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiLUNbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiLUNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:30:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182D612D26;
        Wed, 21 Dec 2022 05:30:55 -0800 (PST)
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 660126602CC3;
        Wed, 21 Dec 2022 13:30:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671629454;
        bh=P4PfjI9EJ2RCLo5y/aer3jrjHLf9fGYHXYTG8vmwc8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CusbS4bdDAuBv9h4nkqP/r+kfQDgisyuo517UvAwVgZSFN0V8G7V9J5a1OMp/YvU4
         w+5JFQxDaO4tbvkSO6uyUQJcLUtgjogeJEXNBvlpLZrJoWsSKBWMJclXRwN9EpQHJJ
         mTqxDw0wRXltA/MxP7LyD+hMPcaa6T4soGHx00BLaHaLRUAEh2BpWw7K8Lq87mO417
         4HUVkNZDRlObmaw+B8ybCExqs0GI6ZHc6Js34cXI2KIj4Cshmw5sJSoGQmC3Nu6yQD
         hnRkSg7BDQ6WLhSGLbozVFFdA/PjusNEEHv0wT7H9rOO4rDup2Fcs4sl4pOvnabuii
         p8eY12NvY4a+g==
Received: by beast.luon.net (Postfix, from userid 1000)
        id E95335EC483F; Wed, 21 Dec 2022 14:30:51 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     martyn.welch@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select
Date:   Wed, 21 Dec 2022 14:30:48 +0100
Message-Id: <20221221133051.1069480-2-sjoerd@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221133051.1069480-1-sjoerd@collabora.com>
References: <20221221133051.1069480-1-sjoerd@collabora.com>
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

From: Nitin Yadav <n-yadav@ti.com>

UHS Class U1 sd-card are not getting detected due to incorrect
OTAP/ITAP delay select values in linux. Update OTAP and ITAP
delay select values for various speed modes. For sdhci0, update
OTAP delay values for ddr52 & HS200 and add ITAP delay for legacy
& mmc-hs. For sdhci1 & sdhci2, update OTAP & ITAP delay select
recommended as in RIOT for various speed modes.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
[cherry-pick from vendor BSP]
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v2:
  - Rebase against linux-next 20221220

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 46 ++++++++++++------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 072903649d6e..466b94d1cee9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -501,8 +501,10 @@ sdhci0: mmc@fa10000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
-		ti,otap-del-sel-ddr52 = <0x9>;
-		ti,otap-del-sel-hs200 = <0x6>;
+		ti,otap-del-sel-ddr52 = <0x5>;
+		ti,otap-del-sel-hs200 = <0x5>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
 		status = "disabled";
 	};
 
@@ -514,17 +516,17 @@ sdhci1: mmc@fa00000 {
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
 		ti,trm-icp = <0x2>;
-		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0xf>;
-		ti,otap-del-sel-sdr25 = <0xf>;
-		ti,otap-del-sel-sdr50 = <0xc>;
-		ti,otap-del-sel-sdr104 = <0x6>;
-		ti,otap-del-sel-ddr50 = <0x9>;
-		ti,itap-del-sel-legacy = <0x0>;
-		ti,itap-del-sel-sd-hs = <0x0>;
-		ti,itap-del-sel-sdr12 = <0x0>;
-		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr12 = <0x0>;
+		ti,otap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr50 = <0x8>;
+		ti,otap-del-sel-sdr104 = <0x7>;
+		ti,otap-del-sel-ddr50 = <0x4>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-sd-hs = <0x1>;
+		ti,itap-del-sel-sdr12 = <0xa>;
+		ti,itap-del-sel-sdr25 = <0x1>;
 		ti,clkbuf-sel = <0x7>;
 		bus-width = <4>;
 		status = "disabled";
@@ -538,17 +540,17 @@ sdhci2: mmc@fa20000 {
 		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
 		clock-names = "clk_ahb", "clk_xin";
 		ti,trm-icp = <0x2>;
-		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0xf>;
-		ti,otap-del-sel-sdr25 = <0xf>;
-		ti,otap-del-sel-sdr50 = <0xc>;
-		ti,otap-del-sel-sdr104 = <0x6>;
-		ti,otap-del-sel-ddr50 = <0x9>;
-		ti,itap-del-sel-legacy = <0x0>;
-		ti,itap-del-sel-sd-hs = <0x0>;
-		ti,itap-del-sel-sdr12 = <0x0>;
-		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr12 = <0x0>;
+		ti,otap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr50 = <0x8>;
+		ti,otap-del-sel-sdr104 = <0x7>;
+		ti,otap-del-sel-ddr50 = <0x8>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-sd-hs = <0xa>;
+		ti,itap-del-sel-sdr12 = <0xa>;
+		ti,itap-del-sel-sdr25 = <0x1>;
 		ti,clkbuf-sel = <0x7>;
 		status = "disabled";
 	};
-- 
2.39.0

