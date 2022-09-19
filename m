Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C45BD49A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiISSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiISSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8211829;
        Mon, 19 Sep 2022 11:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CAE761F03;
        Mon, 19 Sep 2022 18:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F9C433C1;
        Mon, 19 Sep 2022 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663611208;
        bh=3OR7ur1Goc0Cu7bBced/Z2/Zs4WPniYPC7zTikqN1Hw=;
        h=From:To:Cc:Subject:Date:From;
        b=OGBaJIKEFeXto+AKd5riArnbQ6LmnG1vh2L3zUK9Ww/dVZt7LXUUu4cdJtkowYuj9
         AhE/c/nNs9vHHaaLB2nPkuvmZCMnd0E5CRL2ayhBabNLx0W4yiN+++MizbKs4QeqU7
         P3cN2PNycD5cv8sf7LjVrCYYnwv1pMZ/lXwll9O29Ssus4rVL+tDYYDjkTi6qSDw5x
         qxYPOHh5yapiCUyUZ3HYqMqZ31VbrcVk9T/YDEaJA+MGUdij6u3hGHgjYd6Pxxl1Bu
         aXhdKpkOOvazLwtgVcpxcrUXG6OwKou63ZQR3yMVenoKd7SMeEJuQPSygfIjkPtUg1
         16zi18lxky9Zg==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node
Date:   Mon, 19 Sep 2022 13:13:08 -0500
Message-Id: <20220919181309.286611-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi          | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 1 +
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 14c220d87807..a5d08920ac81 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -309,6 +309,7 @@ mmc: mmc@ff808000 {
 				 <&clkmgr STRATIX10_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
 			iommus = <&smmu 5>;
+			altr,sysmgr-syscon = <&sysmgr 0x28 0>;
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
index 7bbec8aafa62..6353f6a361f4 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -313,6 +313,7 @@ mmc: mmc@ff808000 {
 				 <&clkmgr AGILEX_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
 			iommus = <&smmu 5>;
+			altr,sysmgr-syscon = <&sysmgr 0x28 0>;
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

