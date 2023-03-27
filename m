Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F976CAE62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjC0TPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjC0TPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:15:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83528114
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d22so3320253iow.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679944548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NEkIpk/LEoId79ZUOQ1s4XlmlbZJpAqRfun/DpMKuI=;
        b=wnD4iHyEBTEx+ITbYa4t6wRAmgVItiIuX2miqj7yFZK+adKyzw52bAfWA3HizObG3K
         19sMWLOr/FFGaveF3BwS0+GVkDLrtmAEZpoLh2hPvPOvtFO1q+QC619HKKxl3Qg/8xeM
         9CTl+a3PNxycVmy2IRKHmX0+0wezKlnDMQUBl3PiO6sLs1qUvIo/K/rToMvJHHxKM2mM
         fN4KmDVKdx3W/btwfRWttJ2WmiRFiJB8haPuXiIvSI4M7XGUMyhYJNANeUd2F6cIqEOM
         ztLhUPP1JC77T1o0Ek/KyG30m20ZYnqj7lFRFZ0NvgHSHISSo/XpN1g9mELlg1Kt4fYU
         lSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NEkIpk/LEoId79ZUOQ1s4XlmlbZJpAqRfun/DpMKuI=;
        b=WFM4uDu2DUhM+GlWrZdovRRyCEpMOv21LME1G/UXIxQYGHtCCr9lXhlsTo+khRYBGm
         PGmLDravuz6u5qolbimxD9GLkCj10zK/12o2hnKVbm9MYV7jdIHpK/13jMgLLXoMFg26
         57tAI3NPMrkjuAaMTLfH+/wzYajGSwTkEJnoT+df/zhJqLvRxzoDBNF8704/4e7YgYmL
         r1MOs+QuNvxxQDOyoOhFAKZ2x/wwLtNA3VETwkOQvcm/Xv7XX2D4YzUuPo5fv+4/k8e0
         /De5a/24sluCwFzqXECbOYDPnIPAMJfdR6ipIA8gWCVZN2ZKX7iKzblQ6OKixHqDN6AZ
         h9zQ==
X-Gm-Message-State: AO0yUKVAxO0au85xOEKiRaWDWy+Zg/jDGTkPmSCNUqcORqMZs80YKifS
        pyU+MS6WXUk2j97QTmZ8X6Nkzw==
X-Google-Smtp-Source: AK7set9I4/ljS7nflIGziy/qyeSQONWljoFEB1oR7T0y4jrHLZl1M64MmqqoSF9kyk04xgMLuNVgbg==
X-Received: by 2002:a6b:a1a:0:b0:759:1e9e:6daa with SMTP id z26-20020a6b0a1a000000b007591e9e6daamr10235039ioi.10.1679944547876;
        Mon, 27 Mar 2023 12:15:47 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n13-20020a5e8c0d000000b0074555814e73sm3460548ioj.32.2023.03.27.12.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:15:47 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: qcom-sdx65: move status properties to end of nodes
Date:   Mon, 27 Mar 2023 14:15:42 -0500
Message-Id: <20230327191542.2765834-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327191542.2765834-1-elder@linaro.org>
References: <20230327191542.2765834-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move a few device tree "status" properties so that they are the last
specified property, in "qcom-sdx65-mtp.dts" and "qcom-sdx65.dtsi".
Note that properties must always be specified before sub-nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 6 +++---
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 72e25de0db5fc..57bc3b03d3aac 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -270,8 +270,8 @@ nand@0 {
 };
 
 &remoteproc_mpss {
-	status = "okay";
 	memory-region = <&mpss_adsp_mem>;
+	status = "okay";
 };
 
 &usb {
@@ -283,14 +283,14 @@ &usb_dwc3 {
 };
 
 &usb_hsphy {
-	status = "okay";
 	vdda-pll-supply = <&vreg_l4b_0p88>;
 	vdda33-supply = <&vreg_l10b_3p08>;
 	vdda18-supply = <&vreg_l5b_1p8>;
+	status = "okay";
 };
 
 &usb_qmpphy {
-	status = "okay";
 	vdda-phy-supply = <&vreg_l4b_0p88>;
 	vdda-pll-supply = <&vreg_l1b_1p2>;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index f35061e5b7fb8..2e1d008bccfd8 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -224,16 +224,15 @@ usb_hsphy: phy@ff4000 {
 				     "qcom,usb-snps-hs-7nm-phy";
 			reg = <0xff4000 0x120>;
 			#phy-cells = <0>;
-			status = "disabled";
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "ref";
 			resets = <&gcc GCC_QUSB2PHY_BCR>;
+			status = "disabled";
 		};
 
 		usb_qmpphy: phy@ff6000 {
 			compatible = "qcom,sdx65-qmp-usb3-uni-phy";
 			reg = <0x00ff6000 0x1c8>;
-			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -247,6 +246,8 @@ usb_qmpphy: phy@ff6000 {
 				 <&gcc GCC_USB3_PHY_BCR>;
 			reset-names = "phy", "common";
 
+			status = "disabled";
+
 			usb_ssphy: phy@ff6200 {
 				reg = <0x00ff6e00 0x160>,
 				      <0x00ff7000 0x1ec>,
@@ -394,7 +395,6 @@ mem_noc: interconnect@9680000 {
 		usb: usb@a6f8800 {
 			compatible = "qcom,sdx65-dwc3", "qcom,dwc3";
 			reg = <0x0a6f8800 0x400>;
-			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -424,6 +424,8 @@ usb: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_BCR>;
 
+			status = "disabled";
+
 			usb_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0x0a600000 0xcd00>;
-- 
2.34.1

