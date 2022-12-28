Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B858065760E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiL1Lwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiL1Lwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:52:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C814101C9;
        Wed, 28 Dec 2022 03:52:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id u19so37833151ejm.8;
        Wed, 28 Dec 2022 03:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lv+2gfd1swZJvfXBV25TOjELjyrVqoIgTLkjJVFeok=;
        b=DNW2K1iFqBTf0U1xLmUuFlXeaQQEl2UEqISP1Lim8nVz0J11FMS9hN24joYP5QVLT9
         wbkdNOIvQ6ysf5f/1lOOujFdJXVf5h8jvybdI6mJW2i/gKV11RqkZ8lg63fJBw16PPdT
         0x8X7XAO5sFXXbhBB0J3b9ve/hZlzBqPRXJ+lEMOe+vkhktIa8OYyBGSDI64PEOMfm8n
         iPzBL9R1uZbThqQjwL5TwLpx+ry3P+GB1XjJNvZN/9ECFTHTvZ0N7beuDqsnc8UwnJe1
         OdjYE5t3/eNHG87PEeg968SKO7IVt0jz0fQfPo0FYneEGK4DgP+yPAczbvoRn1AOjMpB
         0fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lv+2gfd1swZJvfXBV25TOjELjyrVqoIgTLkjJVFeok=;
        b=2ylPrEhprUWLVaXDuUt+2KD8DWbbdtUYL0YeY23xFzbFcHVaxUEx+mikfm0oREX6rV
         9uECwH8GL4HR6siwansXKRi+KQPCl/vP4vtejvtsichSxRd0QETyMHnwwmltmV4OZSv1
         kFfatLJho2RK8a7kolR2i6p/nKUQ7FBIhsbHz0pOVEMgML66X5JufAyNxc16ybt0P5Nb
         hjA5jRIOv4sPCGX/E8tbkIJQGJ8cQt5jKGY9aap3WBUDjzsVTum7IrYS1JPsaDcxCL6/
         ou2znVw2p+ZK8F4gcs2BsKxeTeWnuIM5avC9zHN59ZmWcj59dSvwiaGNIbizRCNSUZf0
         aBsg==
X-Gm-Message-State: AFqh2krZE9DN3LaRrNhTBEANsgg1zLgUA9iU3qnQ/tiqOtHcC32EoPWD
        wZ/Cr3tqnw5nePFAytyb98Ab5rDKl4Y=
X-Google-Smtp-Source: AMrXdXv55eOV/6Zaz0YJaQGgx35FTElVq6rR/m8ceGSaLLbqjTYyNbhRktYia9tAdoB64tho8M3h6g==
X-Received: by 2002:a17:906:3f97:b0:83f:41a2:a68b with SMTP id b23-20020a1709063f9700b0083f41a2a68bmr20473464ejj.30.1672228367668;
        Wed, 28 Dec 2022 03:52:47 -0800 (PST)
Received: from localhost.localdomain ([46.216.42.4])
        by smtp.googlemail.com with ESMTPSA id s1-20020a1709067b8100b007c07b23a79bsm7317467ejo.213.2022.12.28.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 03:52:47 -0800 (PST)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v2] arm64: dts: qcom: Re-enable resin on MSM8998 and SDM845 boards
Date:   Wed, 28 Dec 2022 14:52:43 +0300
Message-Id: <20221228115243.201038-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resin node declaration was moved to pm8998.dtsi file (in disabled state).
MSM8998 and SDM845 boards defining resin node did not previously have
status="okay" and ended up disabled.
Re-enable it by using resin node link from pm8998.dtsi with status="okay".

Fixes: f86ae6f23a9e ("arm64: dts: qcom: sagit: add initial device tree for sagit")
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
Link: https://lore.kernel.org/linux-arm-msm/20221222115922.jlachctn4lxopp7a@SoMainline.org/
---
Changes v2:
- change description and subject

 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts       | 11 +++--------
 .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi    | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts            | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi        | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts     | 11 +++--------
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts    | 11 +++--------
 7 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 310f7a2df1e8..510d12c8c512 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -364,14 +364,9 @@ cam_snapshot_pin_a: cam-snapshot-btn-active-state {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		bias-pull-up;
-		debounce = <15625>;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &qusb2phy {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 5da87baa2b23..3bbd5df196bf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -357,14 +357,9 @@ vib_default: vib-en-state {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEUP>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
 };
 
 &qusb2phy {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index f41c6d600ea8..878801f540c5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -615,14 +615,9 @@ vol_up_pin_a: vol-up-active-state {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pmi8998_lpg {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 1eb423e4be24..943287804e1a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -482,14 +482,9 @@ &mss_pil {
 	status = "okay";
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &sdhc_2 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index bb77ccfdc68c..e6191602c70a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -522,14 +522,9 @@ pinconf {
 	};
 };
 
-&pm8998_pon {
-	volume_down_resin: resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pmi8998_lpg {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index eb6b2b676eca..1b12b1a4dcbc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -325,14 +325,9 @@ &pmi8998_wled {
 	qcom,cabc;
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pmi8998_rradc {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 38ba809a95cd..fba229d0bd10 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -530,14 +530,9 @@ pinconf {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		compatible = "qcom,pm8941-resin";
-		linux,code = <KEY_VOLUMEDOWN>;
-		debounce = <15625>;
-		bias-pull-up;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &q6afedai {
-- 
2.30.2

