Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42546962FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjBNMD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBNMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:03:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E42412D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so1012129wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C27jNaFvJK+M0vw25i9A39Std5C4IsEHd8mY4O46UfE=;
        b=FaxP47BqE2DunqU52aaqFT/xCjcFLZOrXbXCzrtgnt0wNmEycYgipZ+Q6Jk0iFfYjM
         7WoHpA+khPvj5i9wxa6gg2JuhssappTJTMb+hxTNcV0ZyfOQ/Ti54bXltdc5swZpZB/0
         SdxBbv+WamshxkGcIPYNea+fn5hZ2RgEf5x9fMgm1VySZG17T6S34f9ATCGS/ubN5d0a
         PPgsuNZ7Fi1+uCoSrbmq9Kn9RVsKotGNUV0DB0DeKN0z0V268bVMD7G12DsPiCQIGQVU
         UTqFh9arvAd2MciqFac4BqpBfsgbDxAS50N2lIKMFwJEX7gUi2rj1fdtI1aS0hhzXG1W
         Adaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C27jNaFvJK+M0vw25i9A39Std5C4IsEHd8mY4O46UfE=;
        b=iw7ZIIRTiokQHWQF39WgReS1mQVgsq+vp+sTTxB8kQc3Lk2oA9h5XBsPm7LnbtdRHv
         LfJKyp/fgtBf2ay4QD7UvNSi+VCwzK8WCa7O/K9zFWP+0b1WYjLQwZrr+hIj7PzxbLXt
         9Gr6tvFwtiuuld0weq5PoFyB0DMfB5VAQS7iZL9w7RFXuMogidkCz3jtddhiEZeTrC54
         qWPT27lvK+N2PErZ0+Fffvb0f75irxfAvVjsDwKBieG7enG3jeunxp78otP1+5hgUtvB
         j0VC0vg5UMF1B6W28AJCUSmqjpeOSQ3NvagEiUPv7dqWBlQ/uSJHITPhpgKxL24aubXa
         51Dg==
X-Gm-Message-State: AO0yUKUirgMSuPG0U+VAaRzlfSmr6/QWoTTn0ex4VdwqjHuxtgy53krf
        +Rl8Vr9tiszvwYDXNx1zJonILQ==
X-Google-Smtp-Source: AK7set8Pp8sgXizFzg4FquFZYfCvWP9L6VvUfFIAZvkBA5AlHqUVh3GVvZt2e+qXrAReU07dtXzJjw==
X-Received: by 2002:a05:600c:c0b:b0:3df:e1cc:94ff with SMTP id fm11-20020a05600c0c0b00b003dfe1cc94ffmr1983759wmb.28.1676376182614;
        Tue, 14 Feb 2023 04:03:02 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b003dd1b00bd9asm18834846wms.32.2023.02.14.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 04:03:02 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH 2/5] arm64: dts: qcom: sm8450: Add the Inline Crypto Engine node
Date:   Tue, 14 Feb 2023 14:02:50 +0200
Message-Id: <20230214120253.1098426-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214120253.1098426-1-abel.vesa@linaro.org>
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop all values related to the ICE from the UFS HC node and add a
dedicated ICE node. Also enable it in HDK board dts.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 24 +++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index feef3837e4cd..de631deef1e8 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -461,6 +461,10 @@ lt9611_out: endpoint {
 	};
 };
 
+&ice {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1a744a33bcf4..34d569f6c239 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3989,9 +3989,8 @@ system-cache-controller@19200000 {
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0 0x01d84000 0 0x3000>,
-			      <0 0x01d88000 0 0x8000>;
-			reg-names = "std", "ice";
+			reg = <0 0x01d84000 0 0x3000>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -4015,8 +4014,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				"ref_clk",
 				"tx_lane0_sync_clk",
 				"rx_lane0_sync_clk",
-				"rx_lane1_sync_clk",
-				"ice_core_clk";
+				"rx_lane1_sync_clk";
 			clocks =
 				<&gcc GCC_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
@@ -4025,8 +4023,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&rpmhcc RPMH_CXO_CLK>,
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
-				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table-hz =
 				<75000000 300000000>,
 				<0 0>,
@@ -4035,8 +4032,17 @@ ufs_mem_hc: ufshc@1d84000 {
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+				<0 0>;
+			qcom,ice = <&ice>;
+
+			status = "disabled";
+		};
+
+		ice: inline-crypto-engine {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x01d88000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+
 			status = "disabled";
 		};
 
-- 
2.34.1

