Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E610E6E4E90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDQQuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDQQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:50:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA28526A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:50:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so21366067wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681750210; x=1684342210;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVxn7jsSXN6cFmGlh7iPmqKTw1/QG53dua3O+qpaphA=;
        b=pdMAlsQZiUWs1gwSwM7qLwr+VwYkiYvgg+wK2dfSTjHxHNYqjLtmbRi8ETT945So4b
         qv76bdCfUQGAmTYBBJgwXjzjz8VxVT8YGJgUZ+kNPtClOSyVMGrIEJjCs0nPOXVf+uMO
         zaqGMpAEDQ1Bngj21YfiJlJtSRbnyNjAjwm7gySmYDcSd8cKzJ6tSZv6l534y+pM8A3V
         hbNfaTGArBHzCKCb6d7pRRhznTR5Z70/UnFaNnnzQPdosBvwvjn+KzZabM4+SRkDN/HS
         eIYqQHxGz8O6YUGAyis1SU3FzDqsSahqhsXlXKt/R42S3n2fnQSeioDBMrzHW6H+aQV/
         6MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681750210; x=1684342210;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVxn7jsSXN6cFmGlh7iPmqKTw1/QG53dua3O+qpaphA=;
        b=AAI9kHCVyNBfFfSHuX5pYZ7oZ11u2c7BLnT3DpqygBGOAmbdX0WWtyapVH42+8KVbT
         7s6IVcGuCIQE+6QW0o2Ll7t7tu9nU1stQcCTarfBcASRcYOx4PcjHen3t0Y2+w1CoGLL
         gz9S9TwTHM80fnzaJfTnYkqkgWty+LNe1dPl/TeZ9KDzHEu0TkU+KWIDrydbjwxoKZ5A
         ZQf1mBkf/LD9vh7mIrKxrWvfzwprp0tBUTfdo5cECeoTADQEcimFyifTmH9MC2bhLghN
         pAcgXkrMWIHwyvKn6yk49PImVHtcxUanVVE7G7Zk4/raZSbuM77ujznzFLA3pscCeNPj
         8pbg==
X-Gm-Message-State: AAQBX9dvBqkAdFpsKH7nG48uvS7xwZWZrRFjBDnSfyt6nUkQbvm7P0Iw
        9s3CEoLfx3Wj5cx61+68Fm4IdVl1pF6l3/k71w==
X-Google-Smtp-Source: AKy350ag0fCY562PNfOcqsLtODnkgy8Yfe04YSSdUqbRW6gBwYfWbmcFFVxUtjw+EnVOeWblSXjsbA==
X-Received: by 2002:a7b:c3d5:0:b0:3f1:643e:3872 with SMTP id t21-20020a7bc3d5000000b003f1643e3872mr7459334wmj.2.1681750210290;
        Mon, 17 Apr 2023 09:50:10 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b003f174cafcdasm2371809wmb.7.2023.04.17.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:50:09 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Mon, 17 Apr 2023 18:49:46 +0200
Subject: [PATCH v2] arm64: dts: qcom: msm8998: add blsp spi nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-msm8998-spi-v2-1-b314c6d9ea31@freebox.fr>
X-B4-Tracking: v=1; b=H4sIAKl4PWQC/22NQQ6CMBBFr0Jm7RhKEQor72FYFDpIEyhkRgmGc
 Hcra5fvJf+/HYTYk0Cd7MC0evFziJBdEugGG56E3kWGLM10mqsSJ5lMVRmUxWNZuNLoIu20cRA
 XrRXClm3ohrgJ73GMcmHq/XYmHk3kwctr5s9ZXNXP/j9fFSosyCrtjL1pk997Jmrn7dozNMdxf
 AEg+ch0vAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10279; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=xwBcMoKbpuAn5NrruY660ZtuxjSBoRHKK6jHYGIXZcc=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkPXi67ETRey0NLh5SQUN5fkYUYtB869SDdXpSR
 QIpq1lWQ2mJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD14ugAKCRBxA//ZuzQ0
 q8yGD/4qNHn6FwMulPpY/+eYCh7U8FibzDGbmsV/5+85/0kyqLDHopMR+z61WYXX4ix55NBhzs+
 06mDNJnduLLXVRbpQhzz4CkGpMA/+8GuPyp8gHWy/qF9LmzKNQWq2KjJPEptzf7XwRdGNyI2Xvc
 /tLPkazNlRYIm+87RiHOuxnv0enqenJ/nTIWZYWTyMSqb2Fbq5Xe1n8xHMC8D+2LuQ5i9mpbjoc
 cjl2Oe+Ck13JbKYkv9RkHKqXpk0I9tLwUsYn6exM7w6DcyhoHuGLi1HRJi2mhUrB811UPYzn6VB
 G+8O/9gPjFlWdSJJbVavVVTMhBtQVLqiU8+UjDxqtE1trDWKBwywaXUB0m5ahXuNrgcO28BdzKY
 moJ4Sx2bBc54miE+ot9dvBJGOqC+q4k3Kit7EPJIrX1P/DqLi7wtPmYPqWO9qj1nX2MXxZiKG1F
 nTxdf2F5nE/rj6kU6RDwQVHQhGmEC6csAyyS869Mj29tNgXNAGTr5mgw9FP2TAbyhjgNc/WdgAf
 D3zmvi4DEcKAfjdBwTWwDFkpPmQlfx3Cd8vH/h+FofmnCkjodm4dM+j8k7dNrwdOW/MW7g6s9k3
 pkjRmTwjFLfuroC6/muTjFE/1c66FMdJZV7zUSM6kOmeFNNZELVvNttVe7cke5EloP9jPjgSC0/
 HqA3R2oozZ16ibA==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl and qup nodes in msm8998 device tree to support spi.
Values were ported from downstream msm-4.4 kernel.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
Changes in v2:
- avoid using underscore in dt node names.
- add missing -state suffix to pinctrl nodes.
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 309 ++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b150437a83558..c53e8dda44a6f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1228,6 +1228,57 @@ blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
 				drive-strength = <2>;
 				bias-pull-up;
 			};
+
+			blsp1_spi_b_default: blsp1-spi-b-default-state {
+				pins = "gpio23", "gpio28";
+				function = "blsp1_spi_b";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi1_default: blsp1-spi1-default-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "blsp_spi1";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi2_default: blsp1-spi2-default-state {
+				pins = "gpio31", "gpio34", "gpio32", "gpio33";
+				function = "blsp_spi2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi3_default: blsp1-spi3-default-state {
+				pins = "gpio45", "gpio46", "gpio47", "gpio48";
+				function = "blsp_spi2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi4_default: blsp1-spi4-default-state {
+				pins = "gpio8", "gpio9", "gpio10", "gpio11";
+				function = "blsp_spi4";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi5_default: blsp1-spi5-default-state {
+				pins = "gpio85", "gpio86", "gpio87", "gpio88";
+				function = "blsp_spi5";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi6_default: blsp1-spi6-default-state {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "blsp_spi6";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+
 			/* 6 interfaces per QUP, BLSP2 indexes are numbered (n)+6 */
 			blsp2_i2c1_default: blsp2-i2c1-default-state {
 				pins = "gpio55", "gpio56";
@@ -1312,6 +1363,48 @@ blsp2_i2c6_sleep: blsp2-i2c6-sleep-state {
 				drive-strength = <2>;
 				bias-pull-up;
 			};
+
+			blsp2_spi1_default: blsp2-spi1-default-state {
+				pins = "gpio53", "gpio54", "gpio55", "gpio56";
+				function = "blsp_spi7";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi2_default: blsp2-spi2-default-state {
+				pins = "gpio4", "gpio5", "gpio6", "gpio7";
+				function = "blsp_spi8";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi3_default: blsp2-spi3-default-state {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "blsp_spi9";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi4_default: blsp2-spi4-default-state {
+				pins = "gpio65", "gpio66", "gpio67", "gpio68";
+				function = "blsp_spi10";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi5_default: blsp2-spi5-default-state {
+				pins = "gpio58", "gpio59", "gpio60", "gpio61";
+				function = "blsp_spi11";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi6_default: blsp2-spi6-default-state {
+				pins = "gpio81", "gpio82", "gpio83", "gpio84";
+				function = "blsp_spi12";
+				drive-strength = <6>;
+				bias-disable;
+			};
 		};
 
 		remoteproc_mss: remoteproc@4080000 {
@@ -2249,6 +2342,114 @@ blsp1_i2c6: i2c@c17a000 {
 			#size-cells = <0>;
 		};
 
+		blsp1_spi1: spi@c175000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c175000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi1_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi2: spi@c176000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c176000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi2_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi3: spi@c177000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c177000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi3_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi4: spi@c178000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c178000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi4_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi5: spi@c179000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c179000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 14>, <&blsp1_dma 15>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi5_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi6: spi@c17a000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c17a000 0x600>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 16>, <&blsp1_dma 17>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi6_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		blsp2_dma: dma-controller@c184000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0c184000 0x25000>;
@@ -2392,6 +2593,114 @@ blsp2_i2c6: i2c@c1ba000 {
 			#size-cells = <0>;
 		};
 
+		blsp2_spi1: spi@c1b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b5000 0x600>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi1_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi2: spi@c1b6000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b6000 0x600>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 8>, <&blsp2_dma 9>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi2_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi3: spi@c1b7000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b7000 0x600>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP3_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi3_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi4: spi@c1b8000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b8000 0x600>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP4_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 12>, <&blsp2_dma 13>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi4_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi5: spi@c1b9000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b9000 0x600>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP5_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 14>, <&blsp2_dma 15>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi5_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi6: spi@c1ba000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1ba000 0x600>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 16>, <&blsp2_dma 17>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi6_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mmcc: clock-controller@c8c0000 {
 			compatible = "qcom,mmcc-msm8998";
 			#clock-cells = <1>;

---
base-commit: e3342532ecd39bbd9c2ab5b9001cec1589bc37e9
change-id: 20230417-msm8998-spi-76d78360c38d

Best regards,
-- 
Arnaud Vrac <avrac@freebox.fr>

