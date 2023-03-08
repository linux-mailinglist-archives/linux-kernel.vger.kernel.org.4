Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763216B0795
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCHM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCHM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E860A90
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw28so65369087edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiCFcfPz4vPvuEH64Q/QQyo/8CvlqmI3Zu6iYxq1KAY=;
        b=oqywNHrY2LOFE44e/YQQOlG1p5zYNt1QY6CjHhLE+vDPnAzbiHJwnc6Uws5c3EF1kz
         qEPiumsMDFB8C/ZaOFu8GXTzyc7XuNF11mHhh1m5iVgjsVl5R3bv9CcejTFppwo9HNw1
         jOEneZQLuNiHvrCNob6aBiwOFLEVthdAQco2M9pkNlywsUO/BKCvhy7XvB66gWYXSnXT
         9K/529XmA4K/+l9xuTgWipqyD5as574EVbMxD/Cm1aAVyMDU9PxG6MyRxOELZj79Aaon
         RmvhB54+s8iKJRSzwlynGI3mSMzFsD+pVp9tZ+2sRUANZ+tuvPl5IAH29Z1yoi+ZPHbL
         LO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiCFcfPz4vPvuEH64Q/QQyo/8CvlqmI3Zu6iYxq1KAY=;
        b=VoezrUEtNgfxffXZ3VNe7GZFGZUGM9Jg77B+c0WndajCvgGcT01JS50+bbbEEOIgbW
         JoF12GSPyubVzk5jfy4/GgO2yjlESNGEeEJDYWRcecYaZGZnQdFwdFdNjh8/U5lDcadY
         1+P+Af3mLEbkHUBZOT266jNsKcl/H5FWeSebL969GPqdZYf7tQXbDr2NkWD702cppZML
         HdDbr4R3S1VTQs1+60ga1C+NnCiUXTDpOmfE3N3XfGiibK2hS9FwzNReFLDfNbBIjfSV
         KoC9JX86R1/vLbhYdNFeSUt05BlL9X9puuCkJExJSXiaVz6Q73STrnDSsC01zzd+c0ZV
         Mu1Q==
X-Gm-Message-State: AO0yUKWm5LTDJle5vNbLSdfcLdpcabj4gVGMV2jhdKbSyhkWeO33IYHe
        OunD39StFbIbO1yhihaPs3LXog==
X-Google-Smtp-Source: AK7set9MEhomBCqQEldq0RiKVhcfaK8V/xJLce5XBS7QVYO1ZYuFj0L6udIMtMoVVDwS4PpnOGEG3Q==
X-Received: by 2002:a17:907:cb85:b0:8af:a53a:189d with SMTP id un5-20020a170907cb8500b008afa53a189dmr19334950ejc.44.1678280349779;
        Wed, 08 Mar 2023 04:59:09 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/11] arm64: dts: qcom: drop incorrect cell-index from SPMI
Date:   Wed,  8 Mar 2023 13:58:56 +0100
Message-Id: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPMI controller (PMIC Arbiter)) does not use nor allow 'cell-index'
property:

  sm8150-microsoft-surface-duo.dtb: spmi@c440000: Unevaluated properties are not allowed ('cell-index' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. None
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 -
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 1 -
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sm6125.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 1 -
 8 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 62d05d740646..f769e63c955c 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -397,7 +397,6 @@ spmi_bus: spmi@200f000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		sdhc_1: mmc@7824900 {
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 2d360d05aa5e..712f80fc865c 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -809,7 +809,6 @@ spmi_bus: spmi@200f000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		sdhc_1: mmc@7824000 {
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 8bc1c59127e5..d78fe822b4c3 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1993,7 +1993,6 @@ spmi_bus: spmi@800f000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		usb3: usb@a8f8800 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 00932bcba12d..99ec844da32e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3279,7 +3279,6 @@ spmi_bus: spmi@c440000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		sram@146aa000 {
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 5827cda270a0..72d9a12b5e9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1189,7 +1189,6 @@ spmi_bus: spmi@800f000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		usb3: usb@a8f8800 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..dc43e438b64a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4924,7 +4924,6 @@ spmi_bus: spmi@c440000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		sram@146bf000 {
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 65033227718a..fd577eb705f8 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -1134,7 +1134,6 @@ spmi_bus: spmi@1c40000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		apps_smmu: iommu@c600000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 74c0527d6929..d565f56ec4d2 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3934,7 +3934,6 @@ spmi_bus: spmi@c440000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		apps_smmu: iommu@15000000 {
-- 
2.34.1

