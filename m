Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854C565AEE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjABJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjABJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:46:54 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A755BB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:46:49 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so40900886lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERKKb/3eZDAmTV4JBb4t41CVu5eLM4AeSfJAWHJoeBs=;
        b=iBpbODyaE9iyTKYM3K5lqeCPEo8kKB1NcJ6lDvdzicFycXTghPeaDosSU7yzX6Vsuv
         1VQ6BnQi7ixrfy+v+YiI5TlNO4/eZqnoolUBS4TcyzDHUHvQRDcq8TfnHPpbq/RAadPp
         XfqHXdVUl9ccwdmnkxMrEn7yM1UooWaViHbIP55k5FoOSJvgQzRU33O7sdc8UAc9ARuY
         kldGEpR0cT9Wivz2zUFP63dc8SXYvaYyUkw3gymw//cI9v2S26snhFo+CSJ5gRi9grPw
         PVVvZSROXRAYoWjmVYi70jYgHHLQr59DNu4Hc4U6TUQhV21V4MfdzhYY1zAdYbPaURIb
         VQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERKKb/3eZDAmTV4JBb4t41CVu5eLM4AeSfJAWHJoeBs=;
        b=gjwJ02rHbKhoUExqx50Xsfc+K0hcH+K0sSdr3YUbLEEihGzW2FdZJwV6f3d+SuPm1Y
         fL1c46478DGnDVVTvkH/LeqA8Srobc7HBjW+kL/jI9WRdjm7cqZ05mF95rrKIAlNBMRX
         yB91r0QuBN+QUFbpkCpJzYpg2/ICtUkszca80D3pSVMG0p529j1BkIsqmF6SX8s2dQam
         8VHGTKTJEP9/r0mP6Ft7gVsO7pnH8Kzyt+mhcIYhqNu/F190S8B6eE5WOoGwioOUSd2b
         OPK9bL5EqFTIFU/aDsMRrAqJgNZT66zQhvMe3Ehgdj1BBDMNOUT+G9GPqYG1C9x3eeLF
         z8kA==
X-Gm-Message-State: AFqh2kokMkzJ0Ln9TF3CQbXc0cbhqGdlb7L8QKTgWUudZk+tkUUM7bUX
        A2WNLtwfaUhSbGbIXrf3fHgV9w==
X-Google-Smtp-Source: AMrXdXvUIUXaUPxzNkm47Mf0Y7mV3KNx4YzR/GvSyzDzMDtta9N3cpNcIbNcTUOaNMNudeHpDXR+cQ==
X-Received: by 2002:a05:6512:398c:b0:4b5:7a91:70f5 with SMTP id j12-20020a056512398c00b004b57a9170f5mr13010070lfu.63.1672652807879;
        Mon, 02 Jan 2023 01:46:47 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:46:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/17] arm64: dts: qcom: ipq6018: Fix up indentation
Date:   Mon,  2 Jan 2023 10:46:27 +0100
Message-Id: <20230102094642.74254-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
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

The dwc3 subnode was indented using spaces for some reason and other
properties were not exactly properly indented. Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- Squash with a similar indent-fixing patch [4/18]

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 44 +++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 6f12c1a8f90f..d1c02efc2ea9 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -201,8 +201,8 @@ crypto: crypto@73a000 {
 			compatible = "qcom,crypto-v5.1";
 			reg = <0x0 0x0073a000 0x0 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
-				<&gcc GCC_CRYPTO_AXI_CLK>,
-				<&gcc GCC_CRYPTO_CLK>;
+				 <&gcc GCC_CRYPTO_AXI_CLK>,
+				 <&gcc GCC_CRYPTO_CLK>;
 			clock-names = "iface", "bus", "core";
 			dmas = <&cryptobam 2>, <&cryptobam 3>;
 			dma-names = "rx", "tx";
@@ -272,7 +272,7 @@ blsp1_uart3: serial@78b1000 {
 			reg = <0x0 0x078b1000 0x0 0x200>;
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
-				<&gcc GCC_BLSP1_AHB_CLK>;
+				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
 		};
@@ -285,7 +285,7 @@ blsp1_spi1: spi@78b5000 {
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			spi-max-frequency = <50000000>;
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
-				<&gcc GCC_BLSP1_AHB_CLK>;
+				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
@@ -300,7 +300,7 @@ blsp1_spi2: spi@78b6000 {
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			spi-max-frequency = <50000000>;
 			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
-				<&gcc GCC_BLSP1_AHB_CLK>;
+				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
@@ -358,8 +358,8 @@ qpic_nand: nand-controller@79b0000 {
 			clock-names = "core", "aon";
 
 			dmas = <&qpic_bam 0>,
-				<&qpic_bam 1>,
-				<&qpic_bam 2>;
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
 			dma-names = "tx", "rx", "cmd";
 			pinctrl-0 = <&qpic_pins>;
 			pinctrl-names = "default";
@@ -372,10 +372,10 @@ intc: interrupt-controller@b000000 {
 			#size-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <0x3>;
-			reg =   <0x0 0x0b000000 0x0 0x1000>,  /*GICD*/
-				<0x0 0x0b002000 0x0 0x1000>,  /*GICC*/
-				<0x0 0x0b001000 0x0 0x1000>,  /*GICH*/
-				<0x0 0x0b004000 0x0 0x1000>;  /*GICV*/
+			reg = <0x0 0x0b000000 0x0 0x1000>,  /*GICD*/
+			      <0x0 0x0b002000 0x0 0x1000>,  /*GICC*/
+			      <0x0 0x0b001000 0x0 0x1000>,  /*GICH*/
+			      <0x0 0x0b004000 0x0 0x1000>;  /*GICV*/
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			ranges = <0 0 0 0xb00a000 0 0xffd>;
 
@@ -663,17 +663,17 @@ usb2: usb@70f8800 {
 			status = "disabled";
 
 			dwc_1: usb@7000000 {
-			       compatible = "snps,dwc3";
-			       reg = <0x0 0x07000000 0x0 0xcd00>;
-			       interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-			       phys = <&qusb_phy_1>;
-			       phy-names = "usb2-phy";
-			       tx-fifo-resize;
-			       snps,is-utmi-l1-suspend;
-			       snps,hird-threshold = /bits/ 8 <0x0>;
-			       snps,dis_u2_susphy_quirk;
-			       snps,dis_u3_susphy_quirk;
-			       dr_mode = "host";
+				compatible = "snps,dwc3";
+				reg = <0x0 0x07000000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_1>;
+				phy-names = "usb2-phy";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				dr_mode = "host";
 			};
 		};
 
-- 
2.39.0

