Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092FC65270C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiLTTag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiLTTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4591C40D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671564552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiG5qnWyizE+3kvexhKzuCxizjY/RwUtRVrY9OF6w0s=;
        b=DNcxwCJm834wtD+fHh5VAcKHyB4csqq/Pdd1XQPcgG0xoJ1FXcwFV8pq/TZSL54kFuVa6m
        FXwSjz14NMRO00e8FAMmoV+Op72wXNIv0qukQDOzUusnQ6629/73Lsxu+rE1BWSJRz1hRX
        BEauFMU00c3QnZhGoD9Zdthiz1kYJB8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-450-ztQht4CjOfex8XCKvOiuIQ-1; Tue, 20 Dec 2022 14:29:11 -0500
X-MC-Unique: ztQht4CjOfex8XCKvOiuIQ-1
Received: by mail-qk1-f198.google.com with SMTP id de38-20020a05620a372600b0070224de1c6eso9198164qkb.17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiG5qnWyizE+3kvexhKzuCxizjY/RwUtRVrY9OF6w0s=;
        b=HBZJXp8C8EzOluQnylne1ZnuxQPerDehJmak/x/isXhPEbkid9CgKw+eXxzIaqK576
         OwzTl+a0XQ/Ls3nzCziXU1kwU3k+ZCXlG87L8PZx0s3Ji8oSXOdpo4w0ukN1Hup+05vk
         22RDsZ/XfmvVOXsDBSVayZmwT/93qEY9FEuomSaS/xdVhivItrmoih0M1CfDO9CiGapn
         QmE1JKpK09qknEqShuL4sNY+gebBgX5eghGd3qCJtCnwkG5UWB/0NkNxY4trfFwe/I32
         yrRZb7wTrRoF941B0rvMI2DGZCZJXwgzeHKKdFpukgEvvOhxpnFl8I32cHKhGTBiDG4N
         aWeQ==
X-Gm-Message-State: ANoB5pkC1vKnI7qPG8A9uRxI8HhFxS30JlsWroCPtirgj784JQskokKy
        /cEiEtSO8i3lRAoV1GuaJvWlump32dikDd0+iY5fqZYZdjCPayOT9v08V+F7BBTIfpHiCDOddnO
        0fR/cjsxNJzOKFLJVkW8wLGDw
X-Received: by 2002:ac8:4548:0:b0:3a8:2a12:411e with SMTP id z8-20020ac84548000000b003a82a12411emr32671073qtn.3.1671564550643;
        Tue, 20 Dec 2022 11:29:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6phngO4lfrofV4jj38wjcOQxUqsfHMd3c1NRhSb9DuU3bWHqmpTh03QDVDLn2UPcRRKKvW2A==
X-Received: by 2002:ac8:4548:0:b0:3a8:2a12:411e with SMTP id z8-20020ac84548000000b003a82a12411emr32671050qtn.3.1671564550357;
        Tue, 20 Dec 2022 11:29:10 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id gd15-20020a05622a5c0f00b003a82ca4e81csm744348qtb.80.2022.12.20.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:29:09 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v3 5/7] arm64: dts: qcom: sc8280xp: add missing spi nodes
Date:   Tue, 20 Dec 2022 14:28:52 -0500
Message-Id: <20221220192854.521647-6-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220192854.521647-1-bmasney@redhat.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
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

Add the missing nodes for the spi buses that's present on this SoC.

This work was derived from various patches that Qualcomm delivered
to Red Hat in a downstream kernel.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes from v2 to v3
- None

Changes from v1 to v2
- Dropped qupX_ prefix from labels. (Johan)
- Dropped spi-max-frequency property from spi nodes. (Shazad)

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 360 +++++++++++++++++++++++++
 1 file changed, 360 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a502d4e19d98..4591d411f5fb 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -829,6 +829,21 @@ i2c16: i2c@880000 {
 				status = "disabled";
 			};
 
+			spi16: spi@880000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00880000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c17: i2c@884000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00884000 0 0x4000>;
@@ -845,6 +860,21 @@ i2c17: i2c@884000 {
 				status = "disabled";
 			};
 
+			spi17: spi@884000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00884000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			uart17: serial@884000 {
 				compatible = "qcom,geni-uart";
 				reg = <0 0x00884000 0 0x4000>;
@@ -875,6 +905,21 @@ i2c18: i2c@888000 {
 				status = "disabled";
 			};
 
+			spi18: spi@888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00888000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c19: i2c@88c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0088c000 0 0x4000>;
@@ -891,6 +936,21 @@ i2c19: i2c@88c000 {
 				status = "disabled";
 			};
 
+			spi19: spi@88c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0088c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c20: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00890000 0 0x4000>;
@@ -907,6 +967,21 @@ i2c20: i2c@890000 {
 				status = "disabled";
 			};
 
+			spi20: spi@890000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00890000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c21: i2c@894000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00894000 0 0x4000>;
@@ -923,6 +998,21 @@ i2c21: i2c@894000 {
 				status = "disabled";
 			};
 
+			spi21: spi@894000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00894000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c22: i2c@898000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00898000 0 0x4000>;
@@ -939,6 +1029,21 @@ i2c22: i2c@898000 {
 				status = "disabled";
 			};
 
+			spi22: spi@898000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00898000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c23: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0089c000 0 0x4000>;
@@ -954,6 +1059,21 @@ i2c23: i2c@89c000 {
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
+
+			spi23: spi@89c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0089c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
+				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
 		};
 
 		qup0: geniqup@9c0000 {
@@ -986,6 +1106,21 @@ i2c0: i2c@980000 {
 				status = "disabled";
 			};
 
+			spi0: spi@980000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00980000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c1: i2c@984000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00984000 0 0x4000>;
@@ -1002,6 +1137,21 @@ i2c1: i2c@984000 {
 				status = "disabled";
 			};
 
+			spi1: spi@984000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00984000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c2: i2c@988000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00988000 0 0x4000>;
@@ -1018,6 +1168,21 @@ i2c2: i2c@988000 {
 				status = "disabled";
 			};
 
+			spi2: spi@988000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00988000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c3: i2c@98c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0098c000 0 0x4000>;
@@ -1034,6 +1199,21 @@ i2c3: i2c@98c000 {
 				status = "disabled";
 			};
 
+			spi3: spi@98c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0098c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c4: i2c@990000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00990000 0 0x4000>;
@@ -1050,6 +1230,21 @@ i2c4: i2c@990000 {
 				status = "disabled";
 			};
 
+			spi4: spi@990000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00990000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c5: i2c@994000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00994000 0 0x4000>;
@@ -1066,6 +1261,21 @@ i2c5: i2c@994000 {
 				status = "disabled";
 			};
 
+			spi5: spi@994000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00994000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c6: i2c@998000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00998000 0 0x4000>;
@@ -1082,6 +1292,21 @@ i2c6: i2c@998000 {
 				status = "disabled";
 			};
 
+			spi6: spi@998000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00998000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c7: i2c@99c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0099c000 0 0x4000>;
@@ -1097,6 +1322,21 @@ i2c7: i2c@99c000 {
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
+
+			spi7: spi@99c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0099c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
 		};
 
 		qup1: geniqup@ac0000 {
@@ -1129,6 +1369,21 @@ i2c8: i2c@a80000 {
 				status = "disabled";
 			};
 
+			spi8: spi@a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a80000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c9: i2c@a84000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a84000 0 0x4000>;
@@ -1145,6 +1400,21 @@ i2c9: i2c@a84000 {
 				status = "disabled";
 			};
 
+			spi9: spi@a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c10: i2c@a88000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a88000 0 0x4000>;
@@ -1161,6 +1431,21 @@ i2c10: i2c@a88000 {
 				status = "disabled";
 			};
 
+			spi10: spi@a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a88000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c11: i2c@a8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a8c000 0 0x4000>;
@@ -1177,6 +1462,21 @@ i2c11: i2c@a8c000 {
 				status = "disabled";
 			};
 
+			spi11: spi@a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c12: i2c@a90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a90000 0 0x4000>;
@@ -1193,6 +1493,21 @@ i2c12: i2c@a90000 {
 				status = "disabled";
 			};
 
+			spi12: spi@a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c13: i2c@a94000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a94000 0 0x4000>;
@@ -1209,6 +1524,21 @@ i2c13: i2c@a94000 {
 				status = "disabled";
 			};
 
+			spi13: spi@a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c14: i2c@a98000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a98000 0 0x4000>;
@@ -1225,6 +1555,21 @@ i2c14: i2c@a98000 {
 				status = "disabled";
 			};
 
+			spi14: spi@a98000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a98000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
+
 			i2c15: i2c@a9c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a9c000 0 0x4000>;
@@ -1240,6 +1585,21 @@ i2c15: i2c@a9c000 {
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
+
+			spi15: spi@a9c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a9c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				status = "disabled";
+			};
 		};
 
 		pcie4: pcie@1c00000 {
-- 
2.38.1

