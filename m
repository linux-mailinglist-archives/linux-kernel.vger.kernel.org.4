Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9564A715
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiLLSZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiLLSZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7C1056B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670869409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36MqwyXO1Uv69/AVbNcMRN0gMv1afzIDRB6zP0xQ7/8=;
        b=dlfXyjraOLpBDYqSJ6Gjuqi7sCY6IqIm9wrvFh7JFcsPeXf3eTzFhocXKS33P3c3W+kTvF
        n5PUrW+QAC0l/RKAjDLkcOPmgU5hYQ4EH3FwyTLzLi4C/4PUBlvy3cB0erBmqV7MakySw1
        Cm3dLKKAtSV8esn9lRDtiKV2ksjLQWg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-teXYMQuOPVa8YbhVL7uLXw-1; Mon, 12 Dec 2022 13:23:28 -0500
X-MC-Unique: teXYMQuOPVa8YbhVL7uLXw-1
Received: by mail-qk1-f199.google.com with SMTP id i21-20020a05620a405500b006fb25ba3e00so14746415qko.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36MqwyXO1Uv69/AVbNcMRN0gMv1afzIDRB6zP0xQ7/8=;
        b=DGn1NSYGM8Nq5kYGaHTCV9Qm8OK5hefxBDikjiNCwJyhn7Vlb2GFwgWYyUoA4NeGCC
         aAN8RPr6XdkQUkodLvIC8ovPxm9iG4nfuhhZy6wyhJCR/ATFbwMrH0sWMqRPqcWXBSaO
         uuO7ZOqN8izjTyLqcxp9qXhiWkky/MWk2ZLtkQnZiTn3bn/DhDwUJoITS58Kw1GXInHo
         cshuNQVJXNbOdwP/bREyV1qbnwdKUZ4df8BwYUFRTkWqwkTtjkAVDIKVaWiIK8DYqRVZ
         CpTU9rutgh4Vw5+LHpxep+JObuEuOQdQ/kzHWuHnnrcwjVrjk8Nwy3RQGHzu5dIWN7PH
         oYyA==
X-Gm-Message-State: ANoB5pnCBUvccvaLfYZ6MsjxEMzT1FMrs7NK14Bc6EDi5YhgMaqTTZZv
        mVBuBAlJLFeoepdrLndaxvP6vlkSmP6KFKYnVMOjrJTuH91UvnHFfzwld1QH7GT/cstG+Ul2ZqM
        nlflb5emG03VqYBg5FGYn2Xyh
X-Received: by 2002:ac8:464d:0:b0:3a7:f91d:917c with SMTP id f13-20020ac8464d000000b003a7f91d917cmr25677479qto.31.1670869407695;
        Mon, 12 Dec 2022 10:23:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FaqYavyVyGZG/vj8VyGoEgclGw7lUewz1j1Jz0jHaSMyYDoD/WW60hKddy3NpRJepxDd7XA==
X-Received: by 2002:ac8:464d:0:b0:3a7:f91d:917c with SMTP id f13-20020ac8464d000000b003a7f91d917cmr25677453qto.31.1670869407385;
        Mon, 12 Dec 2022 10:23:27 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85643000000b003a816011d51sm1998185qtt.38.2022.12.12.10.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:23:26 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Date:   Mon, 12 Dec 2022 13:23:14 -0500
Message-Id: <20221212182314.1902632-5-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212182314.1902632-1-bmasney@redhat.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
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

Add the missing nodes for the spi buses that's present on this SoC.

This work was derived from various patches that Qualcomm delivered
to Red Hat in a downstream kernel.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 384 +++++++++++++++++++++++++
 1 file changed, 384 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 392a1509f0be..b50db09feae2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -829,6 +829,22 @@ qup2_i2c16: i2c@880000 {
 				status = "disabled";
 			};
 
+			qup2_spi16: spi@880000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup2_i2c17: i2c@884000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00884000 0 0x4000>;
@@ -845,6 +861,22 @@ qup2_i2c17: i2c@884000 {
 				status = "disabled";
 			};
 
+			qup2_spi17: spi@884000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup2_uart17: serial@884000 {
 				compatible = "qcom,geni-uart";
 				reg = <0 0x00884000 0 0x4000>;
@@ -875,6 +907,22 @@ qup2_i2c18: i2c@888000 {
 				status = "disabled";
 			};
 
+			qup2_spi18: spi@888000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup2_i2c19: i2c@88c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0088c000 0 0x4000>;
@@ -891,6 +939,22 @@ qup2_i2c19: i2c@88c000 {
 				status = "disabled";
 			};
 
+			qup2_spi19: spi@88c000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup2_i2c20: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00890000 0 0x4000>;
@@ -907,6 +971,22 @@ qup2_i2c20: i2c@890000 {
 				status = "disabled";
 			};
 
+			qup2_spi20: spi@890000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup2_i2c21: i2c@894000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00894000 0 0x4000>;
@@ -923,6 +1003,22 @@ qup2_i2c21: i2c@894000 {
 				status = "disabled";
 			};
 
+			qup2_spi21: spi@894000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup2_i2c22: i2c@898000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00898000 0 0x4000>;
@@ -939,6 +1035,22 @@ qup2_i2c22: i2c@898000 {
 				status = "disabled";
 			};
 
+			qup2_spi22: spi@898000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup2_i2c23: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0089c000 0 0x4000>;
@@ -954,6 +1066,22 @@ qup2_i2c23: i2c@89c000 {
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
+
+			qup2_spi23: spi@89c000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
 		};
 
 		qup0: geniqup@9c0000 {
@@ -986,6 +1114,22 @@ qup0_i2c0: i2c@980000 {
 				status = "disabled";
 			};
 
+			qup0_spi0: spi@980000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup0_i2c1: i2c@984000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00984000 0 0x4000>;
@@ -1002,6 +1146,22 @@ qup0_i2c1: i2c@984000 {
 				status = "disabled";
 			};
 
+			qup0_spi1: spi@984000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup0_i2c2: i2c@988000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00988000 0 0x4000>;
@@ -1018,6 +1178,22 @@ qup0_i2c2: i2c@988000 {
 				status = "disabled";
 			};
 
+			qup0_spi2: spi@988000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup0_i2c3: i2c@98c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0098c000 0 0x4000>;
@@ -1034,6 +1210,22 @@ qup0_i2c3: i2c@98c000 {
 				status = "disabled";
 			};
 
+			qup0_spi3: spi@98c000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup0_i2c4: i2c@990000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00990000 0 0x4000>;
@@ -1050,6 +1242,22 @@ qup0_i2c4: i2c@990000 {
 				status = "disabled";
 			};
 
+			qup0_spi4: spi@990000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup0_i2c5: i2c@994000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00994000 0 0x4000>;
@@ -1066,6 +1274,22 @@ qup0_i2c5: i2c@994000 {
 				status = "disabled";
 			};
 
+			qup0_spi5: spi@994000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup0_i2c6: i2c@998000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00998000 0 0x4000>;
@@ -1082,6 +1306,22 @@ qup0_i2c6: i2c@998000 {
 				status = "disabled";
 			};
 
+			qup0_spi6: spi@998000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup0_i2c7: i2c@99c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0099c000 0 0x4000>;
@@ -1097,6 +1337,22 @@ qup0_i2c7: i2c@99c000 {
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
+
+			qup0_spi7: spi@99c000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
 		};
 
 		qup1: geniqup@ac0000 {
@@ -1129,6 +1385,22 @@ qup1_i2c8: i2c@a80000 {
 				status = "disabled";
 			};
 
+			qup1_spi8: spi@a80000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup1_i2c9: i2c@a84000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a84000 0 0x4000>;
@@ -1145,6 +1417,22 @@ qup1_i2c9: i2c@a84000 {
 				status = "disabled";
 			};
 
+			qup1_spi9: spi@a84000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup1_i2c10: i2c@a88000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a88000 0 0x4000>;
@@ -1161,6 +1449,22 @@ qup1_i2c10: i2c@a88000 {
 				status = "disabled";
 			};
 
+			qup1_spi10: spi@a88000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup1_i2c11: i2c@a8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a8c000 0 0x4000>;
@@ -1177,6 +1481,22 @@ qup1_i2c11: i2c@a8c000 {
 				status = "disabled";
 			};
 
+			qup1_spi11: spi@a8c000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup1_i2c12: i2c@a90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a90000 0 0x4000>;
@@ -1193,6 +1513,22 @@ qup1_i2c12: i2c@a90000 {
 				status = "disabled";
 			};
 
+			qup1_spi12: spi@a90000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup1_i2c13: i2c@a94000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a94000 0 0x4000>;
@@ -1209,6 +1545,22 @@ qup1_i2c13: i2c@a94000 {
 				status = "disabled";
 			};
 
+			qup1_spi13: spi@a94000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup1_i2c14: i2c@a98000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a98000 0 0x4000>;
@@ -1225,6 +1577,22 @@ qup1_i2c14: i2c@a98000 {
 				status = "disabled";
 			};
 
+			qup1_spi14: spi@a98000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
+
 			qup1_i2c15: i2c@a9c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a9c000 0 0x4000>;
@@ -1240,6 +1608,22 @@ qup1_i2c15: i2c@a9c000 {
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
+
+			qup1_spi15: spi@a9c000 {
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
+				spi-max-frequency = <50000000>;
+				status = "disabled";
+			};
 		};
 
 		pcie4: pcie@1c00000 {
-- 
2.38.1

