Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0936A6CAF3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjC0T4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjC0T4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:56:13 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524D30F5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:56:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z1so4391705iot.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679946972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH7WjDhRatoLIWeRekjA6Q2wRRz8ocWvRkg9eIDfK6c=;
        b=vJYbbHJrFCK00Ie+LZfdSJ9WynZk14oWpMucOHxrU6bOD8IT7ntctL/Q0eogZX5VaZ
         O9SWnHs9G5+ndrbv52VRN/ucw0o6tF05CJEpaH0KP8I9ofAwGet8Q63cfjuSaF/WTkb+
         jlFBhJV2QcM3p64P5NDe2s0ou5Iiv7UA27PbbcssQQ08d8FZqifn+Eu7WDhGTyglTLVf
         H1Lv12kUH2WMNtRShYzovz1EPso5uo7yH9J+/v6uIblj4c4qnwJqxJiBduahVQq4DbZ1
         XoAGx7+bRPc907ryBDLzPtRXhzikGVQiBmz6kmeKYXBnM90gZsyQHdqKyujb7K71oJ8a
         FQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH7WjDhRatoLIWeRekjA6Q2wRRz8ocWvRkg9eIDfK6c=;
        b=m4Vm3NKGiBFxEJwOriyhyVF7JSseDo+1k3vYqm93kuOK1l7KfYJQnrPgaiH9QQ/dSk
         hAS3oByezDfhQkeBhYoBot8bNKUROLI1cr2WK+H1ven0o2cmf/hthUfu7IFNUp4+x7AE
         jdDxZxRsVatbaFs0qt2R6ayMKt5xe7sCD1I2eXRDlatj7lO/5QWJyF+cINuPN+BN66+r
         FSZtPxeKCY/AeaL/UkUE1Sf6TxxKtD4AN9hx8RkfQo2o8+GFC/wZJSxhL/5qI/qAfWdJ
         OPQ55mfUX+XDhzj/WS9IAQjOV2enHr528CAWuuLJ3HzzgjaSDmn9vQKmVm5POMg5XH3g
         S0sg==
X-Gm-Message-State: AO0yUKVf1ypTMVQnI0PYi6zr/e1QFcu3dQanptvajTVU6wrAY7VD/7sz
        JyrAvcvkqC/kj7Q7aAhbXueSJg==
X-Google-Smtp-Source: AK7set9ogJLbgaIMGt7IdzPrW7LogdjWngrwM/15exNOolmnt0rboCdUPeqnHhkLOaXuZzBp51CH/g==
X-Received: by 2002:a5e:d601:0:b0:74c:a578:e3a0 with SMTP id w1-20020a5ed601000000b0074ca578e3a0mr8975492iom.5.1679946971841;
        Mon, 27 Mar 2023 12:56:11 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a18-20020a027a12000000b003e69be53404sm9011984jac.150.2023.03.27.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:56:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ARM: dts: qcom-sdx65: move status properties to end of nodes
Date:   Mon, 27 Mar 2023 14:56:05 -0500
Message-Id: <20230327195605.2854123-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327195605.2854123-1-elder@linaro.org>
References: <20230327195605.2854123-1-elder@linaro.org>
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
index 74671cc12c884..525dd8a1f6649 100644
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

