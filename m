Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02217745009
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGBSxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjGBSx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:53:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F5ACD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:52:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98df3dea907so440057566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323965; x=1690915965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ValAMvvW7bl+asxU+IEVVuNVd8PtfkHOrE7iQKr5VEQ=;
        b=GegptdCKBK4ks+1SEEtk7wBbjnbKg8gT8075KEIQ+BqAICgQuhkXEQEoLqkJzl/tyO
         yjNhADLhAO+LCtdjjdVn/bssVpZ5dz0vs1DM8Gp/N2n5rFGrERnbVcD436PWeD5P7wTy
         niLPD6FWIBT2Tu2U9zrUuGTifpS/q+HI4UJykHTd4JnfixfEjIoMhYtgjusaEUgvpSFt
         1sYlpdev1uCefGA0H/mJp8apUSsbDRvhSUzdMY5rnE9oRd04DOr6oZUk0jzMeNmXQEtO
         agFROlSAKG5yp2xF/vNS2b4sn0DUafaoq3+tBM2dNtb08HLXBNaaYagB60VC9C6F+88u
         9Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323965; x=1690915965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ValAMvvW7bl+asxU+IEVVuNVd8PtfkHOrE7iQKr5VEQ=;
        b=Ih2HFu14pQdFT+nvZ0Fv8H0YaXQcmNnG5flu2SDtRVfY5Sv2wezLjzIQ4xW3nHcqyE
         k93+EVMzQL1DNvkOjLVdXA4ssxvfQtdbDNUWHV4DzO/k73biat1oKpsmsFiGIwJD8h8E
         hlL2/U/ACe4gIfJkMF+/OmLXuS3a2BmjWnoCxMnOuwzOUMB/4D38XxUCvaakmDyz5kxV
         K5JUIYxdAUobHwRj7p9OXI/gNgsimm7Eh8t97Syk/57Ik69q5rTYDGfui505eFV8Ga//
         w/Uh0aO4wFeKSXvumhGfM63+6+K2HI/YuOu2tVx1UZfdgwwfEqe6GVeOhLOHGCUxOqHK
         6l6Q==
X-Gm-Message-State: AC+VfDw6yR1wgCPkZla/yQ1D7IWQCC6e4jKbc/Zsr0mEDMXNGRMMwHSC
        N2mFGnTyQS5fM+PbMKYMtysAXw==
X-Google-Smtp-Source: APBJJlEhFDRi0cZoTTkO/OfTnoN12inINwe6GfZI7o+exq2+VZ6gqTza7a/JIKKOM1Q0h0UpVuF7gg==
X-Received: by 2002:a17:906:4dcb:b0:96f:8439:6143 with SMTP id f11-20020a1709064dcb00b0096f84396143mr5905397ejw.40.1688323964907;
        Sun, 02 Jul 2023 11:52:44 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906069300b0099364d9f0e2sm838225ejb.98.2023.07.02.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:52:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: rockchip: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:52:42 +0200
Message-Id: <20230702185242.44421-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi           | 16 ++++++++--------
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts |  2 +-
 .../boot/dts/rockchip/rk3566-radxa-cm3-io.dts    |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 8332c8aaf49b..42ce78beb413 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -291,14 +291,14 @@ power-domain@PX30_PD_GMAC {
 			};
 			power-domain@PX30_PD_MMC_NAND {
 				reg = <PX30_PD_MMC_NAND>;
-				clocks =  <&cru HCLK_NANDC>,
-					  <&cru HCLK_EMMC>,
-					  <&cru HCLK_SDIO>,
-					  <&cru HCLK_SFC>,
-					  <&cru SCLK_EMMC>,
-					  <&cru SCLK_NANDC>,
-					  <&cru SCLK_SDIO>,
-					  <&cru SCLK_SFC>;
+				clocks = <&cru HCLK_NANDC>,
+					 <&cru HCLK_EMMC>,
+					 <&cru HCLK_SDIO>,
+					 <&cru HCLK_SFC>,
+					 <&cru SCLK_EMMC>,
+					 <&cru SCLK_NANDC>,
+					 <&cru SCLK_SDIO>,
+					 <&cru SCLK_SFC>;
 				pm_qos = <&qos_emmc>, <&qos_nand>,
 					 <&qos_sdio>, <&qos_sfc>;
 				#power-domain-cells = <0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
index 410cd3e5e7bc..322f3e809f15 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
@@ -239,7 +239,7 @@ &cpu3 {
 
 &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
-	assigned-clock-parents =  <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
 	phy-mode = "rgmii";
 	clock_in_out = "input";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts
index 5e4236af4fcb..1b1c67d5b1ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts
@@ -137,8 +137,8 @@ &hdmi_sound {
 
 &mdio1 {
 	rgmii_phy1: ethernet-phy@0 {
-		compatible="ethernet-phy-ieee802.3-c22";
-		reg= <0x0>;
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
 	};
 };
 
-- 
2.34.1

