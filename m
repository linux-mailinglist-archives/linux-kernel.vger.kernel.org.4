Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE964E18B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiLOTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiLOTEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:04:24 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C894AF18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:04:23 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NY1qn3Md5z1S4yj
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:04:21 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1671131060;
         x=1671995061; bh=PrT99Y4H8U/Twpk1I2ZzqnqQ2aZtGQ1pRlyCCwsyx1k=; b=
        E2/IRKWYenuyPp9w8yVViTmbnck7B6kayruIYKY/NOl+NjbdHRoK0knsmRuhGPHd
        3hN1e3J1yTcN+p0EAqNSzO2bUEKNYp+CAM6hlbdQuie8vdexAOXIbPa5133nh696
        5FhmmVR8n6hMBTLDKND55Vm7Ku0ruIVyyjRW1g7nDFQUJswEMcOWIKn1I1UkmoZP
        Va00GUof8ojPM23BI1wSWtqDBR3Nvh0n/NGts05Jjr2YzB26f0FsVRm23Sw9/Yhe
        fvqyPtC/j2i46AVXT/7+CqBOk3HTOMnLd9USoqfCF3SQ6Ma0BoxJ+kGa1piDshia
        p5da77aFHWTN+WopkSzAGQ==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kg0ew19EHxsn for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 14:04:20 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NY1qh6c8jz1S5Bt;
        Thu, 15 Dec 2022 14:04:16 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lux Aliaga <they@mint.lgbt>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Date:   Thu, 15 Dec 2022 16:04:02 -0300
Message-Id: <20221215190404.398788-2-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215190404.398788-1-they@mint.lgbt>
References: <20221215190404.398788-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a UFS host controller node and its corresponding PHY to
the sm6125 platform.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/q=
com/sm6125.dtsi
index 7e25a4f85594..b64c5bc1452f 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -508,6 +508,73 @@ sdhc_2: mmc@4784000 {
 			status =3D "disabled";
 		};
=20
+		ufs_mem_hc: ufs@4804000 {
+			compatible =3D "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
+			reg =3D <0x04804000 0x3000>, <0x04810000 0x8000>;
+			reg-names =3D "std", "ice";
+			interrupts =3D <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+			phys =3D <&ufs_mem_phy_lanes>;
+			phy-names =3D "ufsphy";
+			lanes-per-direction =3D <1>;
+			#reset-cells =3D <1>;
+			resets =3D <&gcc GCC_UFS_PHY_BCR>;
+			reset-names =3D "rst";
+
+			clock-names =3D "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "ice_core_clk";
+			clocks =3D <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+			freq-table-hz =3D <50000000 240000000>,
+					<0 0>,
+					<0 0>,
+					<37500000 150000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<75000000 300000000>;
+
+			non-removable;
+			status =3D "disabled";
+		};
+
+		ufs_mem_phy: phy@4807000 {
+			compatible =3D "qcom,sm6115-qmp-ufs-phy";
+			reg =3D <0x04807000 0x1c4>;
+
+			power-domains =3D <&gcc UFS_PHY_GDSC>;
+
+			clock-names =3D "ref", "ref_aux";
+			clocks =3D <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_C=
LK>;
+
+			resets =3D <&ufs_mem_hc 0>;
+			reset-names =3D "ufsphy";
+
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges;
+
+			status =3D "disabled";
+
+			ufs_mem_phy_lanes: lanes@4807400 {
+				reg =3D <0x4807400 0x098>,
+				      <0x4807600 0x130>,
+				      <0x4807c00 0x16c>;
+				#phy-cells =3D <0>;
+			};
+		};
+
 		usb3: usb@4ef8800 {
 			compatible =3D "qcom,sm6125-dwc3", "qcom,dwc3";
 			reg =3D <0x04ef8800 0x400>;
--=20
2.38.1

