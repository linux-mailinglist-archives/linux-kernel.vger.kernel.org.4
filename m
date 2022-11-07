Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF561ECBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiKGIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiKGISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:18:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A4F244;
        Mon,  7 Nov 2022 00:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FA1BB80E2D;
        Mon,  7 Nov 2022 08:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037A5C433D6;
        Mon,  7 Nov 2022 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809100;
        bh=j88niuCnMaWKRA1D9Tj+CFIRdasfCLQF6vaVFEFj1hY=;
        h=From:To:Cc:Subject:Date:From;
        b=l19TsNhTWnCAxWk0yNb9IdBjsFgTpEdeolXBRMeqA022OkA4/Ao0rFJKQBzG90Ihv
         6sbL3Py7nFZzNbqi7szpCLPJmwYPuRHp/Q3fAU3ohIPCS6jy6HyK1FeNBJ46IO4Ntk
         X9kLlHJLFFQ7deZMjokLmfJ9Jtxp756vSiopdCbC120vHqMyvPiiBngxeBPhRuIrd/
         DwtYHhq0UlimumfIN81WG56CEj/os2Qy3sDKY3MKWJfPhQk78WkVTC87KwcIExYA9L
         ZiTePZMjQeRV5udtRZSfYBhFb7KAoSZ/nLjDYug5MSwAOTtrvBeZP+YpLz6/9C47Vm
         QpOe6Hl0zCu/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orxKO-0004oF-8B; Mon, 07 Nov 2022 09:17:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix USB MP QMP PHY nodes
Date:   Mon,  7 Nov 2022 09:17:05 +0100
Message-Id: <20221107081705.18446-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
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

Update the USB MP QMP PHY nodes to match the new binding which
specifically includes the missing register regions (e.g. PCS_USB).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

The corresponding binding and driver fixes are now in linux-next so that
the devicetree can be updated. [1]

Note that there's yet no support for the multiport controller in
mainline.

Johan

[1] https://lore.kernel.org/lkml/20221028160435.26948-1-johan+linaro@kernel.org/


 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 62 ++++++++++----------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 1b309fa93484..506172206b8a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1090,70 +1090,56 @@ usb_2_hsphy3: phy@88ea000 {
 			status = "disabled";
 		};
 
-		usb_2_qmpphy0: phy-wrapper@88ef000 {
+		usb_2_qmpphy0: phy@88ef000 {
 			compatible = "qcom,sc8280xp-qmp-usb3-uni-phy";
-			reg = <0 0x088ef000 0 0x1c8>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			reg = <0 0x088ef000 0 0x2000>;
 
 			clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_USB3_MP0_CLKREF_CLK>,
-				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>;
-			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
+				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
+			clock-names = "aux", "ref_clk_src", "ref", "com_aux",
+				      "pipe";
 
 			resets = <&gcc GCC_USB3_UNIPHY_MP0_BCR>,
 				 <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>;
-			reset-names = "phy", "common";
+			reset-names = "phy", "phy_phy";
 
 			power-domains = <&gcc USB30_MP_GDSC>;
 
-			status = "disabled";
+			#clock-cells = <0>;
+			clock-output-names = "usb2_phy0_pipe_clk";
 
-			usb_2_ssphy0: phy@88efe00 {
-				reg = <0 0x088efe00 0 0x160>,
-				      <0 0x088f0000 0 0x1ec>,
-				      <0 0x088ef200 0 0x1f0>;
-				#phy-cells = <0>;
-				#clock-cells = <0>;
-				clocks = <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb2_phy0_pipe_clk";
-			};
+			#phy-cells = <0>;
+
+			status = "disabled";
 		};
 
-		usb_2_qmpphy1: phy-wrapper@88f1000 {
+		usb_2_qmpphy1: phy@88f1000 {
 			compatible = "qcom,sc8280xp-qmp-usb3-uni-phy";
-			reg = <0 0x088f1000 0 0x1c8>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			reg = <0 0x088f1000 0 0x2000>;
 
 			clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_USB3_MP1_CLKREF_CLK>,
-				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>;
-			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
+				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_MP_PHY_PIPE_1_CLK>;
+			clock-names = "aux", "ref_clk_src", "ref", "com_aux",
+				      "pipe";
 
 			resets = <&gcc GCC_USB3_UNIPHY_MP1_BCR>,
 				 <&gcc GCC_USB3UNIPHY_PHY_MP1_BCR>;
-			reset-names = "phy", "common";
+			reset-names = "phy", "phy_phy";
 
 			power-domains = <&gcc USB30_MP_GDSC>;
 
-			status = "disabled";
+			#clock-cells = <0>;
+			clock-output-names = "usb2_phy1_pipe_clk";
 
-			usb_2_ssphy1: phy@88f1e00 {
-				reg = <0 0x088f1e00 0 0x160>,
-				      <0 0x088f2000 0 0x1ec>,
-				      <0 0x088f1200 0 0x1f0>;
-				#phy-cells = <0>;
-				#clock-cells = <0>;
-				clocks = <&gcc GCC_USB3_MP_PHY_PIPE_1_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb2_phy1_pipe_clk";
-			};
+			#phy-cells = <0>;
+
+			status = "disabled";
 		};
 
 		remoteproc_adsp: remoteproc@3000000 {
-- 
2.37.4

