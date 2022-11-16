Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B562BEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiKPMvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiKPMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:51:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578132653
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:51:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1380856wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOWAJTGxhSL0kzCH0VY3KqRez3fd+24sQZ4yenpGyEQ=;
        b=g6Q+rbay9BJpPOEEEKnz7T2521ZOOmuBq9KNeyTLjAGMgjIdYgRtmWuzXoLRwZf46H
         zaNae2SONwU+XnkDrmd8e7fkI4dtUjqQvYNaZbbENgAMB9YQC+bk6JXzgdpMHsYi2MF/
         YMt7VHfT2FvbsWrT+Skft5/WucdM2rI253XJ9C+WQyBEZr2sbKBSrGfGyKpY73Xt6DTR
         Tl/iCmDkQMqknSYEYq9U1Z4IGSlLBcNULpGZr50ThmlLYeHQi4UB7ce1of5HWQOlhJvB
         q7Nmk7ZhDcsvIQLZaHc23ZRJOnlyqlw0Pb/rRzdVf7i6gwMnTDPI0Uv/CtkR1OeCnDYZ
         6StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOWAJTGxhSL0kzCH0VY3KqRez3fd+24sQZ4yenpGyEQ=;
        b=gL3PhzGTJ53l1eJkZRmYPw6YjdU1TvhhtgHDwP+ehROLBUe+H8aZq/BGQelJS9y9u5
         gYrKengmXi4hcoZAifTXVwSWAC7Lwhx4JEqBQYYVW/qWjG199okOrM5wf8D2qHkZQ1mo
         R/CIAkG+OwNBPnTUjUp6DoR7vw8UI2eXgzdzZCqttba2tlg4rJwDWZcawjwW3pXAonsJ
         kgZpvoClfyv5NC010C7Z+qr0R8s8jU85V8XDj+M7WdM4fx5QmRd5EjwqvkTjV5x3lJJr
         c/bEC3muJlC8/w/2rfWuWsgAy0qFyaMKzyt7XtF9LwWUe8WyC0libg5qU+RnruoEfCKp
         uGow==
X-Gm-Message-State: ANoB5plICnixT6syBQc2Q7oQxEDRli3sRy2uwMfjtCiPx/5OHcoq+KSt
        9Cc1y4H+Pj+jUX4bYj/CIb1APg==
X-Google-Smtp-Source: AA0mqf6YrPAUzRYEaAN56cmDPKqfBWKc2j8FnP/tKu9PVQ60qFgHgK7c6JDWN8e4a2F1naVI/X0R4w==
X-Received: by 2002:a05:600c:1d94:b0:3cf:7385:7621 with SMTP id p20-20020a05600c1d9400b003cf73857621mr2057220wms.62.1668603094819;
        Wed, 16 Nov 2022 04:51:34 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d16-20020a5d6450000000b0022cc0a2cbecsm15386776wrw.15.2022.11.16.04.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:51:34 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes
Date:   Wed, 16 Nov 2022 14:51:11 +0200
Message-Id: <20221116125112.2788318-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116125112.2788318-1-abel.vesa@linaro.org>
References: <20221116125112.2788318-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS host controller and PHY nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 76 ++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 07ba709ca35f..27ce382cb594 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1372,6 +1372,82 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		ufs_mem_phy: phy@1d80000 {
+			compatible = "qcom,sm8550-qmp-ufs-phy";
+			reg = <0x0 0x01d80000 0x0 0x200>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clock-names = "ref", "qref";
+			clocks = <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&tcsr TCSR_UFS_CLKREF_EN>;
+
+			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+			status = "disabled";
+
+			ufs_mem_phy_lanes: phy@1d80400 {
+				reg = <0x0 0x01d81000 0x0 0x134>,
+				      <0x0 0x01d81200 0x0 0x3d8>,
+				      <0x0 0x01d80400 0x0 0x258>,
+				      <0x0 0x01d81800 0x0 0x134>,
+				      <0x0 0x01d81a00 0x0 0x3d8>;
+				#phy-cells = <0>;
+			};
+		};
+
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sm8550-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x0 0x01d84000 0x0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			iommus = <&apps_smmu 0x60 0x0>;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
+
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk";
+			clocks =
+				<&gcc GCC_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_UFS_PHY_AHB_CLK>,
+				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				<&rpmhcc RPMH_LN_BB_CLK3>,
+				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<75000000 300000000>,
+				<100000000 403000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
-- 
2.34.1

