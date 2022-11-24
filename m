Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDD637F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKXSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKXSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:43:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FA7F8840
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a7so2819763ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k+aoS4UuwYo0m81AUVMx1TIZkrsLmdIxsoe7vzM7Yo=;
        b=eTyYHGjUKEGVLe34c/jiZvrXxKM1NYrswOoO/rT1OMKfFp6wKIKzXYMNRLpVoP22qk
         Fu2xHI/pGVV9xXceXOFlN6dJyQpwvLoyKdF0jHG7spYk7h22bYpmbl82SZi3+vQSDvdP
         S8dv1OI8LfS57bmC0uT8Gd3lB4BcyHeXZbX3Xptt21qAV74/rmfrjcWYjv0dMtpfkD7c
         6nQxL7NmROhMb8cHemJbgmJdTO4KcikOeHaU3IQDvvgWu7e0fAXoL/izKce2lV0Yw8Gj
         7cqoKCiHBgFMoNj5JVJtQXucR7lDFLQCuPRX5kdwFKbUhHpwC0T1vTGFIqHdWPEHkgdu
         RLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k+aoS4UuwYo0m81AUVMx1TIZkrsLmdIxsoe7vzM7Yo=;
        b=dLgb0YZ8A4Wm3u3Q2BDeR1+pSc+d8pxXSBzCnh5dYxjCe5Ej6AhcadDgy20Of8bEWM
         fWTT5Fig3i/KbKq/Z0e6B0VVrQJoxAtm0ej9UU7sNtTPQQ43+9ZPYPjy5AVifmuOL1CX
         jSXln8vWQbBkY2qvxG2tnVbnjkW871A+hRdRceNsVqUheA8uTMI37yr3P6bKhaLzrrrW
         EkUkfLUH2534OIVoDI7jk+PeVlbEpIJi3OwSlU+f+nXq2mo4QJVDk/ZCpmcxALGthqw0
         zXiBLjA4E/2GoTR/KrK7VnNQqsAYJVXtbR2/kA2sEitRzf95/1ZJ+4b8S80+hStNK06k
         35pA==
X-Gm-Message-State: ANoB5pkxcOBq+gHrjGs7E9RQeqbgxff0QyFpeo6J62TfRoPRyvjdKxlj
        UYtPqR+BP1BFUyC2ndOM+cj4NA==
X-Google-Smtp-Source: AA0mqf7ST40eVXHzbHhAkr5UCvwS/dIjw46JpcI39THMqn+6MvyEahrNPphG7MN7msxyICWr6nP3VQ==
X-Received: by 2002:a2e:350d:0:b0:277:10b2:47e5 with SMTP id z13-20020a2e350d000000b0027710b247e5mr10583674ljz.502.1669315426794;
        Thu, 24 Nov 2022 10:43:46 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 03/15] arm64: dts: qcom: sc7180: align MPSS PAS node with bindings
Date:   Thu, 24 Nov 2022 19:43:21 +0100
Message-Id: <20221124184333.133911-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
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

The SC7180 MPSS/MSS remote processor can be brought to life using two
different bindings:
1. qcom,sc7180-mpss-pas - currently used in DTSI
2. qcom,sc7180-mss-pil

Move the properties related to qcom,sc7180-mss-pil (qcom,halt-regs,
qcom,spare-regs, resets, additional clocks and regs) to specific boards
using the PIL, to silence DT schema warnings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch.
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 20 +++-----------------
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 70fd9ff8dfa2..b27b5f0e2b6b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -370,8 +370,26 @@ &qupv3_id_1 {
 &remoteproc_mpss {
 	status = "okay";
 	compatible = "qcom,sc7180-mss-pil";
+	reg = <0 0x04080000 0 0x4040>, <0 0x04180000 0 0x48>;
+	reg-names = "qdsp6", "rmb";
+
+	clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+		 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+		 <&gcc GCC_MSS_NAV_AXI_CLK>,
+		 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+		 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+		 <&rpmhcc RPMH_CXO_CLK>;
+	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
+
 	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
 	memory-region = <&mba_mem &mpss_mem>;
+
+	resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+		 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+	reset-names = "mss_restart", "pdc_reset";
+
+	qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
+	qcom,spare-regs = <&tcsr_regs_2 0xb3e4>;
 };
 
 &sdhc_1 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 65601bea0797..d968fbce4b89 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -851,12 +851,30 @@ &qupv3_id_1 {
 &remoteproc_mpss {
 	status = "okay";
 	compatible = "qcom,sc7180-mss-pil";
+	reg = <0 0x04080000 0 0x4040>, <0 0x04180000 0 0x48>;
+	reg-names = "qdsp6", "rmb";
+
+	clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+		 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+		 <&gcc GCC_MSS_NAV_AXI_CLK>,
+		 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+		 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+		 <&rpmhcc RPMH_CXO_CLK>;
+	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
+
 	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
 	memory-region = <&mba_mem &mpss_mem>;
 
 	/* This gets overridden for SKUs with LTE support. */
 	firmware-name = "qcom/sc7180-trogdor/modem-nolte/mba.mbn",
 			"qcom/sc7180-trogdor/modem-nolte/qdsp6sw.mbn";
+
+	resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+		 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+	reset-names = "mss_restart", "pdc_reset";
+
+	qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
+	qcom,spare-regs = <&tcsr_regs_2 0xb3e4>;
 };
 
 &sdhc_1 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ea886cf08b4d..5be978c44c0d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1929,8 +1929,7 @@ pri_mi2s_mclk_active: pri-mi2s-mclk-active-state {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sc7180-mpss-pas";
-			reg = <0 0x04080000 0 0x4040>, <0 0x04180000 0 0x48>;
-			reg-names = "qdsp6", "rmb";
+			reg = <0 0x04080000 0 0x4040>;
 
 			interrupts-extended = <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
 					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -1941,14 +1940,8 @@ remoteproc_mpss: remoteproc@4080000 {
 			interrupt-names = "wdog", "fatal", "ready", "handover",
 					  "stop-ack", "shutdown-ack";
 
-			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
-				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
-				 <&gcc GCC_MSS_NAV_AXI_CLK>,
-				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
-				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "iface", "bus", "nav", "snoc_axi",
-				      "mnoc_axi", "xo";
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
 
 			power-domains = <&rpmhpd SC7180_CX>,
 					<&rpmhpd SC7180_MX>,
@@ -1962,13 +1955,6 @@ remoteproc_mpss: remoteproc@4080000 {
 			qcom,smem-states = <&modem_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
-				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
-			reset-names = "mss_restart", "pdc_reset";
-
-			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
-			qcom,spare-regs = <&tcsr_regs_2 0xb3e4>;
-
 			status = "disabled";
 
 			glink-edge {
-- 
2.34.1

