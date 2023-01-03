Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9E65C619
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbjACSYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbjACSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB4913E24
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBfnG2FEiyAwTAbQnSPSn0PzrNwcC6RoTMJ49+9V96M=;
        b=hwVLAvLhui7Vprd1SL8RFLL6Fb5qZ+8cYtPKSAPpxEHoY/Fcnmw9OMqAooKXeRiN74jBij
        sgH9mRlryiLDVpdzjMGrVWfVSddF2RyCC44q9rywKyPNdNqQJ4KnU6ebVwPb1kEqXgEZKI
        N+ZxpnmV1bdh542rDA/SmmlKDjkv5vw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-aLVqCfx5NByPiMQKhr645Q-1; Tue, 03 Jan 2023 13:22:46 -0500
X-MC-Unique: aLVqCfx5NByPiMQKhr645Q-1
Received: by mail-qt1-f200.google.com with SMTP id w13-20020ac87e8d000000b003ab89c2625eso7374332qtj.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBfnG2FEiyAwTAbQnSPSn0PzrNwcC6RoTMJ49+9V96M=;
        b=wWCg7D5JMdS2PF3KSv/edSw582eyWq1JvFtJziRLf9fj7vyHbNVNpOt17Xuu+TSedR
         /5yHdi1Yg4w+9QtuvB2jiZhiXKATDdSTBHfhJ/tstP29gyvhqr8G3G1O+gf4MnAyx7CJ
         jIbxwtCPAWOL5hgFptQfs42RnXrhyfa9GrKdnrnQEkRkYaD1X4lymJP+tmOmCfHr3iUa
         tLtAceBSevXuNMDOhlf4b+LGfq/qwh/4B5RFoVGcpB2S2+KicUxHchS6k2/eo+zuaYEC
         isSDIcH2zpRnadMsR2gNI3g86fnoZ1CWVJLM67JwWg0hVg9Gaw8b3GMyz3ybM2tG2rW2
         uPAw==
X-Gm-Message-State: AFqh2kpHKWyRwWtL3OA24V1dG/DpY9YgnVtfk6OzUSI1uU1JlFmYaech
        rZtiZ7W2KQp8tFJJO+qOm5rJcb35uO6bMwK80kqt1+Zr0zCkh71iLkiMxcTCKBumxKgqeKdrO2F
        dwgOWDY5AQf2KBEupHJRhK/Bq
X-Received: by 2002:ac8:13cb:0:b0:3a8:2e73:24c9 with SMTP id i11-20020ac813cb000000b003a82e7324c9mr62936867qtj.46.1672770166392;
        Tue, 03 Jan 2023 10:22:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtbrwoSRn2qCdN72mM+X3Ta6eDMCdqzHyjkofDhl4dpgUir8YZQ6o8j2l9lMfayo2FL9CRvJQ==
X-Received: by 2002:ac8:13cb:0:b0:3a8:2e73:24c9 with SMTP id i11-20020ac813cb000000b003a82e7324c9mr62936839qtj.46.1672770166122;
        Tue, 03 Jan 2023 10:22:46 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:45 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 03/10] arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17
Date:   Tue,  3 Jan 2023 13:22:22 -0500
Message-Id: <20230103182229.37169-4-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103182229.37169-1-bmasney@redhat.com>
References: <20230103182229.37169-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding the missing SPI and I2C nodes to
sc8280xp.dtsi, it was decided to rename all of the existing qupX_
uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
and rename qup2_uart17 to uart17. Note that some nodes are moved in the
file by this patch to preserve the expected sort order in the file.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
No changes in v4

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts  | 12 ++++++------
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 12 ++++++------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 14 +++++++-------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi    |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 84cb6f3eeb56..61f2e44e70c1 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -17,7 +17,7 @@ / {
 	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
 
 	aliases {
-		serial0 = &qup2_uart17;
+		serial0 = &uart17;
 	};
 
 	chosen {
@@ -240,11 +240,6 @@ &qup2 {
 	status = "okay";
 };
 
-&qup2_uart17 {
-	compatible = "qcom,geni-debug-uart";
-	status = "okay";
-};
-
 &remoteproc_adsp {
 	firmware-name = "qcom/sa8540p/adsp.mbn";
 	status = "okay";
@@ -338,6 +333,11 @@ pm8450g_gpios: gpio@c000 {
 	};
 };
 
+&uart17 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index d70859803fbd..d19af74f5057 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -17,7 +17,7 @@ / {
 	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
 
 	aliases {
-		serial0 = &qup2_uart17;
+		serial0 = &uart17;
 	};
 
 	chosen {
@@ -192,11 +192,6 @@ &qup2 {
 	status = "okay";
 };
 
-&qup2_uart17 {
-	compatible = "qcom,geni-debug-uart";
-	status = "okay";
-};
-
 &remoteproc_nsp0 {
 	firmware-name = "qcom/sa8540p/cdsp.mbn";
 	status = "okay";
@@ -207,6 +202,11 @@ &remoteproc_nsp1 {
 	status = "okay";
 };
 
+&uart17 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 551768f97729..db273face248 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -17,7 +17,7 @@ / {
 	compatible = "qcom,sc8280xp-crd", "qcom,sc8280xp";
 
 	aliases {
-		serial0 = &qup2_uart17;
+		serial0 = &uart17;
 	};
 
 	backlight {
@@ -363,12 +363,6 @@ keyboard@68 {
 	};
 };
 
-&qup2_uart17 {
-	compatible = "qcom,geni-debug-uart";
-
-	status = "okay";
-};
-
 &remoteproc_adsp {
 	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
 
@@ -381,6 +375,12 @@ &remoteproc_nsp0 {
 	status = "okay";
 };
 
+&uart17 {
+	compatible = "qcom,geni-debug-uart";
+
+	status = "okay";
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c0ffca9c9ddb..b8f567642551 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -813,7 +813,7 @@ qup2: geniqup@8c0000 {
 
 			status = "disabled";
 
-			qup2_uart17: serial@884000 {
+			uart17: serial@884000 {
 				compatible = "qcom,geni-uart";
 				reg = <0 0x00884000 0 0x4000>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
-- 
2.39.0

