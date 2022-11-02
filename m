Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8E616AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiKBRjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKBRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563541E729;
        Wed,  2 Nov 2022 10:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F9661AF9;
        Wed,  2 Nov 2022 17:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C14C43141;
        Wed,  2 Nov 2022 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667410734;
        bh=Fbe89/u5hYuerS0IUMgE9aNX3engI+3rWO1QlQHBlZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvHK87X3Xh8LSAaG+w/bovqcRqKr/RGrVEbwPAQ8HT57OYil0vNHXaeqqlpGkQNar
         0RO+gQwgdne0m/+VWiBqev3iEozUVgdryIgHynTcurAbUroAZ/BnEZAfLYhMga/fIf
         JBWWVq686yeFnxZzA2uTxrzzjrkSXayE9afaZqBzDQKYXHina1moaJaFkmT05GC+g1
         DvvKQxkxz5Hx2xYJ9s7ms4024kTM+n0hOVdOfzYXcqNeeVOXF8QAtq4cG/az5gZIfQ
         Rj3B1UnvikVu7BiR33JWaElAbPW+fdJS8dOvUTMOHH3RkVzIzUqRp8HbulQ0HNG0GB
         ULeXa3Q5kKlCw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv7 3/6] arm: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node
Date:   Wed,  2 Nov 2022 12:38:40 -0500
Message-Id: <20221102173843.409039-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102173843.409039-1-dinguyen@kernel.org>
References: <20221102173843.409039-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdmmc controller's CIU(Card Interface Unit) clock's phase can be
adjusted through the register in the system manager. Add the binding
"altr,sysmgr-syscon" to the SDMMC node for the driver to access the
system manager. Add the "clk-phase-sd-hs" property in the SDMMC node to
designate the smpsel and drvsel properties for the CIU clock.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7: no changes
v6: no changes
v5: new
---
 arch/arm/boot/dts/socfpga.dtsi                     | 1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 1 +
 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi | 1 +
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  | 1 +
 arch/arm/boot/dts/socfpga_arria5.dtsi              | 1 +
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            | 1 +
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi        | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2459f3cd7dd9..604fc6e0c4ad 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -765,6 +765,7 @@ mmc: dwmmc0@ff704000 {
 			clocks = <&l4_mp_clk>, <&sdmmc_clk_divided>;
 			clock-names = "biu", "ciu";
 			resets = <&rst SDMMC_RESET>;
+			altr,sysmgr-syscon = <&sysmgr 0x108 3>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 4370e3cbbb4b..b6ebe207e2bc 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -666,6 +666,7 @@ mmc: dwmmc0@ff808000 {
 			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
 			clock-names = "biu", "ciu";
 			resets = <&rst SDMMC_RESET>;
+			altr,sysmgr-syscon = <&sysmgr 0x28 4>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
index ad7cd14de6b6..41f865c8c098 100644
--- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
@@ -73,6 +73,7 @@ &mmc {
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
+	clk-phase-sd-hs = <0>, <135>;
 };
 
 &osc1 {
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
index 64dc0799f3d7..d3969367f4b5 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -12,6 +12,7 @@ &mmc {
 	cap-mmc-highspeed;
 	broken-cd;
 	bus-width = <4>;
+	clk-phase-sd-hs = <0>, <135>;
 };
 
 &eccmgr {
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 22dbf07afcff..b531639ce7dc 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -23,6 +23,7 @@ mmc0: dwmmc0@ff704000 {
 			bus-width = <4>;
 			cap-mmc-highspeed;
 			cap-sd-highspeed;
+			clk-phase-sd-hs = <0>, <135>;
 		};
 
 		sysmgr@ffd08000 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 319a71e41ea4..a9d1ba66f1ff 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -23,6 +23,7 @@ mmc0: dwmmc0@ff704000 {
 			bus-width = <4>;
 			cap-mmc-highspeed;
 			cap-sd-highspeed;
+			clk-phase-sd-hs = <0>, <135>;
 		};
 
 		sysmgr@ffd08000 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
index bd92806ffc12..3b9daddf91cd 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
@@ -18,5 +18,6 @@ memory@0 {
 
 &mmc0 {	/* On-SoM eMMC */
 	bus-width = <8>;
+	clk-phase-sd-hs = <0>, <135>;
 	status = "okay";
 };
-- 
2.25.1

