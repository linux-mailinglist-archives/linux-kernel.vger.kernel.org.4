Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA1616B01
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiKBRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiKBRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:39:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564BB24096;
        Wed,  2 Nov 2022 10:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC87DB82420;
        Wed,  2 Nov 2022 17:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9045CC433D6;
        Wed,  2 Nov 2022 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667410732;
        bh=oLdI0UN3bIk1n9xDiM9bptnCKiq/HHUtln4OkDfO7F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D81gtj3g9EyA+4g0HtNJ9KHAJs1/JJBKtOQlMmt5JQzUB5f3pS7ZlqavsIz6Snk4h
         YMqHagmwxyfAttiwKzjNJSSBoaWTIY1Knlai/WVr6mSgxmHAfoOSXHwvAh8E+08+OH
         z1cuWQquzrH4G+sPohsIjqB4HWCEzwX221X8SF6eIYm+rhbXzImfjy+4A2mYURoBCT
         thDb7Oc1/8ilEfKPe5KNLBEi/AsLMNYonIAiAiDQXq1F7PZOf+o/G5RgSfKzGKqE6H
         pXi0b4Z7/60ym5xZ/dNS2b3bFYZU1KeRW4ukVWgnPInM/JG/8NIajhLVnqaVwvtIa/
         bIREuw0zGG0og==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv7 2/6] arm64: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node
Date:   Wed,  2 Nov 2022 12:38:39 -0500
Message-Id: <20221102173843.409039-2-dinguyen@kernel.org>
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
v5: add back reg_shift
v4: no change
v3: removed unnecessary property in "altr,sysmgr-syscon"
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi          | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 1 +
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 14c220d87807..55c5e1fdddc7 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -309,6 +309,7 @@ mmc: mmc@ff808000 {
 				 <&clkmgr STRATIX10_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
 			iommus = <&smmu 5>;
+			altr,sysmgr-syscon = <&sysmgr 0x28 4>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 48424e459f12..19e7284b4cd5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -105,6 +105,7 @@ &mmc {
 	cap-mmc-highspeed;
 	broken-cd;
 	bus-width = <4>;
+	clk-phase-sd-hs = <0>, <135>;
 };
 
 &osc1 {
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 7bbec8aafa62..849b46dd8098 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -313,6 +313,7 @@ mmc: mmc@ff808000 {
 				 <&clkmgr AGILEX_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
 			iommus = <&smmu 5>;
+			altr,sysmgr-syscon = <&sysmgr 0x28 4>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 26cd3c121757..07c3f8876613 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -83,6 +83,7 @@ &mmc {
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
+	clk-phase-sd-hs = <0>, <135>;
 };
 
 &osc1 {
diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index 62c66e52b656..08c088571270 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -74,6 +74,7 @@ &mmc {
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
+	clk-phase-sd-hs = <0>, <135>;
 };
 
 &osc1 {
-- 
2.25.1

