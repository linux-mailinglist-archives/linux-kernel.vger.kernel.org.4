Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44356DC9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDJRLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDJRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:11:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844C2697
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:10:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso5042831pjp.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681146629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNoQs5qOgvjqSthHiZStB/bBkE2Kj3/X8lWJDBkoV6Y=;
        b=jfTLQRUATkVI4UyXndhSZTFq4zka6G64hOkBEPE+GI1vSBNS5Us/TQ2tHz5QvQu4mx
         Ty/CfI2LgqkSLgX6K1DJO4/KZLljzu7fa6xy7GOC4+se1ipi0QqDN+0FS15p30NmmZz9
         KpIgt6CsdtUli9qTwpp68fj2nZCf0yPurZZ6JceW2q5MzYbicYHXeIUxMHLGkKnxF1vN
         JmqOp9P4FKwM8WZA09dqNPaaUSf5sEXXCEk30D7nju+0grg7rEL9e/vOa0xFun9dYNYN
         ZJpJys8sNs3h3IoTwxp1offubQ/ly9LHrGk8Jpy5qUUYWjfyZl6fLptT6smU3XPcUi2E
         sUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNoQs5qOgvjqSthHiZStB/bBkE2Kj3/X8lWJDBkoV6Y=;
        b=2JA79f2t/nmSHVqqVbRt09+N4BVXl4efB86+e/kOJG8nlnyAaacg8F1E7zJcPFv39/
         rJpdH4igD7Dq42nyzd1IV+uCl/7OGCXd4aWGg+K28ewxfmFh9/xqH1GyohHtgrfTwQbt
         KO2xa7kCgZrsZABy1qwmUb5F2QbNeFekYbSvlcnboDXiNBYHUD2IsJl40cq7cEGSNGSJ
         +Wkz4/AxfoE7e7ERuTrxmgr1Xz12a7SqiceVEMcOJBhkmQauRfE5JwJt6ENT4yV1ndcD
         7Cvkd2IyxpHi3xzOjYbcotVMspYtZfR5zMySqeBxYQ0dd5ws/1zQwqYCzrZgKJkTa9ET
         8pqw==
X-Gm-Message-State: AAQBX9cZ1SxjcQzgW8NTBM5fvkl2a2AAoPj05O65MqWs0hk3mxnlYmjr
        atWt3S6DzCxABOWPv3iuG7ZHTbeFvC3H13LtuZQ=
X-Google-Smtp-Source: AKy350Z+Yv1n0ctaOMR7TjVcAmZKU+AeThDZl/VfKw0+mm/6qA758RJtMnSRdxl6YXfQyLf7oyWN6Q==
X-Received: by 2002:a05:6a20:1452:b0:bf:58d1:ce94 with SMTP id a18-20020a056a20145200b000bf58d1ce94mr17024279pzi.19.1681146629454;
        Mon, 10 Apr 2023 10:10:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id q11-20020a63cc4b000000b0050bc4ca9024sm7187818pgi.65.2023.04.10.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:10:29 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v8 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Mon, 10 Apr 2023 22:40:10 +0530
Message-Id: <20230410171010.2561393-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230410171010.2561393-1-bhupesh.sharma@linaro.org>
References: <20230410171010.2561393-1-bhupesh.sharma@linaro.org>
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

Add USB superspeed qmp phy node to dtsi.

Make sure that the various board dts files (which include sm4250.dtsi file)
continue to work as intended.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++++++++--
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index a1f0622db5a0..75951fd439df 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -242,6 +242,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2505c815c65a..b2ea8f13e827 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -651,6 +651,31 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy: phy@1615000 {
+			compatible = "qcom,sm6115-qmp-usb3-phy";
+			reg = <0x0 0x01615000 0x0 0x200>;
+
+			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "cfg_ahb",
+				      "ref",
+				      "com_aux",
+				      "pipe";
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
+			reset-names = "phy", "phy_phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "usb3_phy_pipe_clk_src";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
@@ -1101,8 +1126,8 @@ usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x04e00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_hsphy>;
-				phy-names = "usb2-phy";
+				phys = <&usb_hsphy>, <&usb_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 10c9d338446c..d60cc024749b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -280,6 +280,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
-- 
2.38.1

