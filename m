Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2F659F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 01:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiLaA1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 19:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiLaA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 19:27:24 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E331EAC2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:27:22 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id u8so12123631ilq.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XU58kPYl9n82LN59dtODH7bg7cp4BHh6YJsgbAZI+Ks=;
        b=t33hWfZzTekkZPTFN2v5aPWvOuFLfga2yWC4R7FZG8dbJx7MhhspkKC7sJuV91HXqT
         Kj0ycqZbQ4hEI5eJCuElLowh9uqaq0CodlclWiDUxMDqRRtaUt3/9C10f/QdXOlPRNZ3
         vbVPBopwb1/J8mSRK2UwHSgay1yNWNw8mHbX1OyJuf5pB3cfbDnsZzoEKE91UicPM4RL
         zCXVkJ9ntM1DKfm1dPzhMwYAt6xABnuSX7jBuqRUB/xETiblYVOTozLdHcpHSHt57ldB
         9Vrf98DgKz6EFdjcn9NUPEPTqNJjNcKqDTfXqQKUwvnLGJ3gPUxRk47EGNmagTKUeNP5
         Qc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XU58kPYl9n82LN59dtODH7bg7cp4BHh6YJsgbAZI+Ks=;
        b=pc0obiEHzVIHNChqSlJ81lwUOI1rA6Wtb1KCGr7zxbmi15PpthH0S2OW9chKQBCU95
         qr0TPx3I8cmyFUzH4L1BZzP7DAgNI9xbLsTBQBy0ag2LBl3L+/SMIBd7g9D1evaQoknt
         1CMG1XiG2P+eJaSvKcTG47IA+XFxZQT9FcwtkfvetSWh2s+hQE6gDghQ1sxZWUHixQZq
         V/NLcW6O5WxT075QkRz6tM9b4Crck1Mt8eKbxNBHpaF1PDzpoEYV9UG36aSgmqytnB0o
         ISggBVliCqUnoexttwQI+rdrCJ2XZ0MuMWrr+q5k91SnL5ei4U36kqTo74lgv+knQG+s
         KdLw==
X-Gm-Message-State: AFqh2koToLkjCLSWj4eYEkzfOvcXVQ8PnDqK5ciuzqYcSjr91UhTJljg
        G0QAxDhY/6lNoi8+q/2SdU6z8w==
X-Google-Smtp-Source: AMrXdXvlUHSbyBgmovCj8d/Gsd+ikI6F8/sKZNwvtCWADE61C7G94gt6YYrfNdLgtRqs5HeMKAZj+g==
X-Received: by 2002:a92:d950:0:b0:30c:2ff1:c8d7 with SMTP id l16-20020a92d950000000b0030c2ff1c8d7mr2910385ilq.0.1672446441882;
        Fri, 30 Dec 2022 16:27:21 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id t4-20020a922c04000000b002f9f7d24d78sm6969279ile.76.2022.12.30.16.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 16:27:21 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: use qcom,gsi-loader for IPA
Date:   Fri, 30 Dec 2022 18:27:16 -0600
Message-Id: <20221231002716.2367375-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221231002716.2367375-1-elder@linaro.org>
References: <20221231002716.2367375-1-elder@linaro.org>
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

Depending on the platform, either the modem or the AP must load GSI
firmware for IPA before it can be used.  To date, this has been
indicated by the presence or absence of a "modem-init" property.

That mechanism has been deprecated.  Instead, we indicate how GSI
firmware should be loaded by the value of the "qcom,gsi-loader"
property.

Update all arm64 platforms that use IPA to use the "qcom,gsi-loader"
property to specify how the GSI firmware is loaded.

Update the affected nodes so the status property is last.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi         | 5 ++---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                   | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                   | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                      | 3 ++-
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi          | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts            | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 3 ++-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 1 +
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 3 ++-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts             | 3 ++-
 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts   | 4 ++--
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts                      | 4 ++--
 arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi      | 3 ++-
 15 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
index fd4b712037542..bffcbd141bd7c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
@@ -19,12 +19,11 @@ &remoteproc_mpss {
 };
 
 &ipa {
-	status = "okay";
-
 	/*
 	 * Trogdor doesn't have QHEE (Qualcomm's EL2 blob), so the
 	 * modem needs to cover certain init steps (GSI init), and
 	 * the AP needs to wait for it.
 	 */
-	modem-init;
+	qcom,gsi-loader = "modem";
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index f7efb9966afd1..5ad97cd5f1b75 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -377,8 +377,8 @@ &gpi_dma1 {
 };
 
 &ipa {
+	qcom,gsi-loader = "modem";
 	status = "okay";
-	modem-init;
 };
 
 &lpass_cpu {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index df49564ae6dc1..6d80c64097e97 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -337,8 +337,8 @@ vreg_bob: bob {
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
 &ipa {
+	qcom,gsi-loader = "modem";
 	status = "okay";
-	modem-init;
 };
 
 &lpass_va_macro {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index ca676e04687b0..c194a88f91fd1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -756,8 +756,8 @@ &gpu {
 };
 
 &ipa {
+	qcom,gsi-loader = "modem";
 	status = "okay";
-	modem-init;
 };
 
 &lpasscc {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 1eb423e4be24c..b62beffc27bf7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -474,8 +474,8 @@ zap-shader {
 };
 
 &ipa {
+	qcom,gsi-loader = "modem";
 	status = "okay";
-	modem-init;
 };
 
 &mss_pil {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index de2d10e0315af..f5a186fd7c72b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -518,8 +518,9 @@ &i2c10 {
 };
 
 &ipa {
-	status = "okay";
+	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
+	status = "okay";
 };
 
 &mdss {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 42cf4dd5ea284..d8a601d36c6df 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -424,10 +424,10 @@ rmi4_f12: rmi4-f12@12 {
 };
 
 &ipa {
-	status = "okay";
-
+	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
 	firmware-name = "qcom/sdm845/oneplus6/ipa_fws.mbn";
+	status = "okay";
 };
 
 &mdss {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index bb77ccfdc68c0..fcd401f460456 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -495,10 +495,10 @@ touchscreen@38 {
 };
 
 &ipa {
-	status = "okay";
-
+	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
 	firmware-name = "qcom/sdm845/axolotl/ipa_fws.mbn";
+	status = "okay";
 };
 
 &mdss {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index eb6b2b676eca4..d6b11d56ebb37 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -299,9 +299,10 @@ &mss_pil {
 };
 
 &ipa {
-	status = "okay";
+	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
 	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
+	status = "okay";
 };
 
 &pm8998_gpio {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 38ba809a95cd6..9ca4682aea1b2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -449,6 +449,7 @@ &ibb {
 };
 
 &ipa {
+	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
 	firmware-name = "qcom/sdm845/polaris/ipa_fws.mbn";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index f32b7445f7c96..15da94808b21d 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -465,8 +465,9 @@ ecsh: hid@5c {
 };
 
 &ipa {
-	status = "okay";
+	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
+	status = "okay";
 };
 
 &mdss {
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index daca1e0ad62ad..15f6059b75757 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -383,9 +383,10 @@ digitizer@9 {
 };
 
 &ipa {
-	status = "okay";
+	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
 	firmware-name = "qcom/sdm850/samsung/w737/ipa_fws.elf";
+	status = "okay";
 };
 
 /* No idea why it causes an SError when enabled */
diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
index 9c4cfd995ff29..00f16cde6c4ac 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
@@ -290,9 +290,9 @@ &i2c11 {
 };
 
 &ipa {
-	status = "okay";
-
+	qcom,gsi-loader = "self";
 	memory-region = <&pil_ipa_fw_mem>;
+	status = "okay";
 };
 
 &mpss {
diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
index 52cf3045602f9..f70e0de0509c5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
@@ -376,7 +376,7 @@ &usb_2_qmpphy {
 };
 
 &ipa {
-	status = "okay";
-
+	qcom,gsi-loader = "self";
 	memory-region = <&pil_ipa_fw_mem>;
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index 1f2d660f8f86c..d00e8d922ceeb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -524,9 +524,10 @@ &i2c17 {
 };
 
 &ipa {
-	status = "okay";
+	qcom,gsi-loader = "self";
 	memory-region = <&pil_ipa_fw_mem>;
 	firmware-name = "qcom/sm8350/Sony/sagami/ipa_fws.mbn";
+	status = "okay";
 };
 
 &mpss {
-- 
2.34.1

