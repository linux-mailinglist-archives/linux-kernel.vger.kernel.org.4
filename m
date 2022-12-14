Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8E64CEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiLNRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiLNRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A82656C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671037920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4t1D4tXBAIgEtpKIXuYcJZLp0CgcR2xNILD0s4VGW0=;
        b=jD23NQBWJB7jjlumdA81yQiYH1pPUhAE0aLN9lDothgAumWcPKtEffAKWlRTAKew45untI
        7TjJ6PbGYun0+F3RK1mFxyJqZNaPwLvBA3a+JF3SNt/6pmfq+wf7XU1yYl0vgEMznouyk4
        CdY0dD+v+Uf+sD3L3wKDd3fFH7vbl1o=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-GSKoyEZxMFuSG3AHp0GW1g-1; Wed, 14 Dec 2022 12:11:59 -0500
X-MC-Unique: GSKoyEZxMFuSG3AHp0GW1g-1
Received: by mail-yb1-f198.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso484835ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4t1D4tXBAIgEtpKIXuYcJZLp0CgcR2xNILD0s4VGW0=;
        b=lP91hQ/CVagXX7qgXUG1YThS584WiM7ep4lwKgbYQiywFpbl/yGf5EBCKMjgT71TR/
         42pw34PW11nTVUa+gUN2fCPNgowzXyBzPovkBP6NPeY1i0fw+yrbMYaywd9VGh4V16Va
         N3AsrlXX3XOsNmSUxUgwy+iKeUKXrG0O+VBFnSXJQYMH+V/vFRxwj3gjyR3Jl72AQ/dg
         ETvPzAqjsSM1oyuIunuvespuFIHSgSyL6Lig4oNelasm6aPFV5TdzOTfqs4be4wzynye
         UdCTaelrwfiZR6YW8Du78eqwoJ3nYI21526pU8wwDFKqfqKjrL3DZd0EVwNc7cynhfWm
         wrZA==
X-Gm-Message-State: ANoB5pl8jB/XUG28PaUt8rFoB1+LoUbwJ43LfVQUNlW1s3USOAY4CRuA
        Iu7VOPtT6SkKBSRYhagxLQQkiw7+3mAOTOh+wKAKODnhnDcbn3vqas24eRxMnVi/q6xaCjeC+mF
        IcKbgLJZr50NyjvXRSg9bSVWv
X-Received: by 2002:a25:cac2:0:b0:714:446:3671 with SMTP id a185-20020a25cac2000000b0071404463671mr22802377ybg.36.1671037918927;
        Wed, 14 Dec 2022 09:11:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7D6qoj5A4VtE01xgKeZX00elQ7voZQgb6gJgOZ/RzZzgkSyBN4/HLbWyfthjqV7037e4oDGA==
X-Received: by 2002:a25:cac2:0:b0:714:446:3671 with SMTP id a185-20020a25cac2000000b0071404463671mr22802353ybg.36.1671037918674;
        Wed, 14 Dec 2022 09:11:58 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t30-20020a37ea1e000000b006eef13ef4c8sm10305477qkj.94.2022.12.14.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:11:57 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v2 1/7] arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17
Date:   Wed, 14 Dec 2022 12:11:39 -0500
Message-Id: <20221214171145.2913557-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214171145.2913557-1-bmasney@redhat.com>
References: <20221214171145.2913557-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
---
This is a new patch that's introduced in v2.

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
index 21f3ff024910..b6e0db5508c7 100644
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
index 109c9d2b684d..951cb1b6fcc4 100644
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
2.38.1

