Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7765A463
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiLaNAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiLaM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:33 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45ACF59F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so35149205lfv.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOBtY/5KLzv3pd6FD2rBqtPQmNoLaC+FYAfgDPpsDhk=;
        b=GCZSnJqWgbCvHjaI0qPUmLwqihW0u+qhzjVRcBkk3yYOQ4RhmRqc684PkuIKb3BpfM
         3FsA/RoCsGScNUsl7ALVoOyCP85EekcmqZBScTQQx5PQ3t0Pq/kArPFLeZkrM4X4/MOT
         qwj03lFCoKczQCF3rzVPrHPPTUVmCaRDliBKQOPIQfOco5tf7t/0r5NrN0LefQpGTw8T
         7+Yo/P+gzelwObklgrRZuuINxJ0vTgzUgLjmOQFD/RaFENhYDDvsvz5vShbF8OtTtdxQ
         qZVEMGG5axNTlNEhTaFVDnhhswIkjkA0CEKhVaHIPmIFjULIewgnpPb4RB2xOMT12r6i
         Wr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOBtY/5KLzv3pd6FD2rBqtPQmNoLaC+FYAfgDPpsDhk=;
        b=Hxy1Ao45LdihcrnDsip1QpCoImdcXcrvsnSF6YP2eEpI/O4lPsXABjJiPctwq3n62e
         BeWBoVyVAnOymCMKFC3Bo9C84UleyjngOUAZdOskkQT1Hw0QMeDeqmPE03Ln4K/AQjdX
         SzKBU6KHFqS6x5iDUM9FkFeQecueirXfA3XGWyKKV6KDjxmq2s+jHdumTQHEtxWhH8oP
         sLDcpKdJNSmxNMJf/iGcE3mWYRUhPToaLRepwH5fra05rGARRAMQiQfOeC4dZI7QgpDm
         9NrIyn+9FmV5uUICYg2MBlwAX+nqrMAJsmd6fMWurbbmbZB9Lm/4xmnkmUyZOeKSzvsb
         rUhQ==
X-Gm-Message-State: AFqh2kq0h5UflB+G6UpmXR0GoCRRl4ReMNofXdm+rs91+wWWDuRLc7fX
        9f+pUqrwEj4yEE/kI1AdLmplVg==
X-Google-Smtp-Source: AMrXdXtQ8mAEEtBkaOq60V5KxCv1v9MsfmZDQ8rYeiJj36mFeGiNgxjiKEhvF26b7GWjvUO3cLID8w==
X-Received: by 2002:a05:6512:2390:b0:4b5:649a:9105 with SMTP id c16-20020a056512239000b004b5649a9105mr12268434lfv.65.1672491570304;
        Sat, 31 Dec 2022 04:59:30 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] arm64: dts: qcom: sdm845: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:03 +0100
Message-Id: <20221231125911.437599-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
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

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 46 ++++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 154f5054a200..44bb3509df62 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2585,9 +2585,9 @@ ipa: ipa@1e40000 {
 
 			iommus = <&apps_smmu 0x720 0x0>,
 				 <&apps_smmu 0x722 0x0>;
-			reg = <0 0x1e40000 0 0x7000>,
-			      <0 0x1e47000 0 0x2000>,
-			      <0 0x1e04000 0 0x2c000>;
+			reg = <0 0x01e40000 0 0x7000>,
+			      <0 0x01e47000 0 0x2000>,
+			      <0 0x01e04000 0 0x2c000>;
 			reg-names = "ipa-reg",
 				    "ipa-shared",
 				    "gsi";
@@ -4237,16 +4237,16 @@ videocc: clock-controller@ab00000 {
 		camss: camss@a00000 {
 			compatible = "qcom,sdm845-camss";
 
-			reg = <0 0xacb3000 0 0x1000>,
-				<0 0xacba000 0 0x1000>,
-				<0 0xacc8000 0 0x1000>,
-				<0 0xac65000 0 0x1000>,
-				<0 0xac66000 0 0x1000>,
-				<0 0xac67000 0 0x1000>,
-				<0 0xac68000 0 0x1000>,
-				<0 0xacaf000 0 0x4000>,
-				<0 0xacb6000 0 0x4000>,
-				<0 0xacc4000 0 0x4000>;
+			reg = <0 0x0acb3000 0 0x1000>,
+				<0 0x0acba000 0 0x1000>,
+				<0 0x0acc8000 0 0x1000>,
+				<0 0x0ac65000 0 0x1000>,
+				<0 0x0ac66000 0 0x1000>,
+				<0 0x0ac67000 0 0x1000>,
+				<0 0x0ac68000 0 0x1000>,
+				<0 0x0acaf000 0 0x4000>,
+				<0 0x0acb6000 0 0x4000>,
+				<0 0x0acc4000 0 0x4000>;
 			reg-names = "csid0",
 				"csid1",
 				"csid2",
@@ -4575,11 +4575,11 @@ mdss_dp: displayport-controller@ae90000 {
 				status = "disabled";
 				compatible = "qcom,sdm845-dp";
 
-				reg = <0 0xae90000 0 0x200>,
-				      <0 0xae90200 0 0x200>,
-				      <0 0xae90400 0 0x600>,
-				      <0 0xae90a00 0 0x600>,
-				      <0 0xae91000 0 0x600>;
+				reg = <0 0x0ae90000 0 0x200>,
+				      <0 0x0ae90200 0 0x200>,
+				      <0 0x0ae90400 0 0x600>,
+				      <0 0x0ae90a00 0 0x600>,
+				      <0 0x0ae91000 0 0x600>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <12>;
@@ -4788,7 +4788,7 @@ dsi1_phy: phy@ae96400 {
 		gpu: gpu@5000000 {
 			compatible = "qcom,adreno-630.2", "qcom,adreno";
 
-			reg = <0 0x5000000 0 0x40000>, <0 0x509e000 0 0x10>;
+			reg = <0 0x05000000 0 0x40000>, <0 0x509e000 0 0x10>;
 			reg-names = "kgsl_3d0_reg_memory", "cx_mem";
 
 			/*
@@ -4858,7 +4858,7 @@ opp-257000000 {
 
 		adreno_smmu: iommu@5040000 {
 			compatible = "qcom,sdm845-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
-			reg = <0 0x5040000 0 0x10000>;
+			reg = <0 0x05040000 0 0x10000>;
 			#iommu-cells = <1>;
 			#global-interrupts = <2>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
@@ -4881,9 +4881,9 @@ adreno_smmu: iommu@5040000 {
 		gmu: gmu@506a000 {
 			compatible = "qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
 
-			reg = <0 0x506a000 0 0x30000>,
-			      <0 0xb280000 0 0x10000>,
-			      <0 0xb480000 0 0x10000>;
+			reg = <0 0x0506a000 0 0x30000>,
+			      <0 0x0b280000 0 0x10000>,
+			      <0 0x0b480000 0 0x10000>;
 			reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
 
 			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.39.0

