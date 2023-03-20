Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3D6C1A88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjCTP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCTP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:57:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD873B665
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:48:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r29so10795572wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679327333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsKc7FFFdalJIV9dCkij4wY4vcv7EXBiScT7/uI+2a0=;
        b=w09DTQq6RRzT1IAc25UmK6hdK8XeWr/LvBYlvt1Dw1A65MqzZL/dk6TGJ4rXJTcVyZ
         AHkKni0wj4aizsqy+VEoJLADXOLWkgbVUfOktL07OTpRzr+5TY7V8ardqqV80U41U3zX
         nXpC589j7yP7t83h280D6WxMSWJg3/vECy9mrYMVdRabMmQkg5PcZ3Vw7NMGp5J88E6y
         wfOT6rHZNbTejDfLojE3yO6FgT1sFM2PvW4uJGJXv7yhnHf62rP3aFDfxBQc2rqzfrN0
         6Yg4I3YK2D4MVaPytrKMQy9pmEz5rqBa82+9QNFa28shcguB7qYlc0VrIV42/tptPKZo
         lyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsKc7FFFdalJIV9dCkij4wY4vcv7EXBiScT7/uI+2a0=;
        b=lvWB3HtHY2PQC9kRcgEn2HjSE/qqeiVM71Mw59M/WsLlWSA1PYvOsPBa2uWP7N/AvY
         /NPuRmsK/VBSEAGVeJQxA6Ih04sj37Eo4EN/FIrW5/ywB6pVQtFECtrjVhGIcJgDIGNJ
         l83tmRuPgFxLA/HnYukBs+ESeVztXE18F8hPTIO7GrqhMXhhvoE8SLx3CEAZIw+IbROq
         5luAwF4GLtNqG9+wYB/eEW04vt6rqPL8CjRN7pqcOCb9ydP2C2jT02hO2kijOnYKdNjD
         JZ+PnkafxvSHF9Io++tFNEuP+rLwIKeQ7xyAZR94IWASDhxM5oihfT4RXjh/p3a1lCdg
         I9ag==
X-Gm-Message-State: AO0yUKWHCX9lvclPBVc7h0l2ph4Fr3wJBLkSs80DYeDZ4cdKxufS1IpH
        H1rj1OgaVjROjPj1WbDheUd3Qg==
X-Google-Smtp-Source: AK7set/P/5bd4ZLSTK8UIhwgqiSGSvZkbXGOC9n5sJmP7yy11KzEya16YPHulcsAxz+C6+/aQfhGzg==
X-Received: by 2002:adf:db43:0:b0:2d1:5698:3f6e with SMTP id f3-20020adfdb43000000b002d156983f6emr12227488wrj.58.1679327332742;
        Mon, 20 Mar 2023 08:48:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d7d9:4f38:38b4:82b4])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b002c71a32394dsm9202578wrn.64.2023.03.20.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:48:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 02/15] arm64: dts: qcom: sa8775p: sort soc nodes by reg property
Date:   Mon, 20 Mar 2023 16:48:28 +0100
Message-Id: <20230320154841.327908-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230320154841.327908-1-brgl@bgdev.pl>
References: <20230320154841.327908-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Sort all children of the soc node by the first address in their reg
property. This was mostly already the case but there were some nodes
that didn't follow it so fix it now for consistency.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 394 +++++++++++++-------------
 1 file changed, 197 insertions(+), 197 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 5aa28a3b12ae..296ba69b81ab 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -471,50 +471,6 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
-		qupv3_id_1: geniqup@ac0000 {
-			compatible = "qcom,geni-se-qup";
-			reg = <0x0 0x00ac0000 0x0 0x6000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			clock-names = "m-ahb", "s-ahb";
-			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
-				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
-			iommus = <&apps_smmu 0x443 0x0>;
-			status = "disabled";
-
-			uart10: serial@a8c000 {
-				compatible = "qcom,geni-uart";
-				reg = <0x0 0x00a8c000 0x0 0x4000>;
-				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "se";
-				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
-				interconnect-names = "qup-core", "qup-config";
-				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
-						 &clk_virt SLAVE_QUP_CORE_1 0>,
-						<&gem_noc MASTER_APPSS_PROC 0
-						 &config_noc SLAVE_QUP_1 0>;
-				power-domains = <&rpmhpd SA8775P_CX>;
-				operating-points-v2 = <&qup_opp_table_100mhz>;
-				status = "disabled";
-			};
-
-			uart12: serial@a94000 {
-				compatible = "qcom,geni-uart";
-				reg = <0x0 0x00a94000 0x0 0x4000>;
-				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
-				clock-names = "se";
-				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
-						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
-						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
-						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
-				interconnect-names = "qup-core", "qup-config";
-				power-domains = <&rpmhpd SA8775P_CX>;
-				status = "disabled";
-			};
-		};
-
 		qupv3_id_2: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x008c0000 0x0 0x6000>;
@@ -585,173 +541,56 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 			};
 		};
 
-		intc: interrupt-controller@17a00000 {
-			compatible = "arm,gic-v3";
-			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
-			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			#redistributor-regions = <1>;
-			redistributor-stride = <0x0 0x20000>;
-		};
-
-		memtimer: timer@17c20000 {
-			compatible = "arm,armv7-timer-mem";
-			reg = <0x0 0x17c20000 0x0 0x1000>;
-			ranges = <0x0 0x0 0x0 0x20000000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			frame@17c21000 {
-				reg = <0x17c21000 0x1000>,
-				      <0x17c22000 0x1000>;
-				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				frame-number = <0>;
-			};
-
-			frame@17c23000 {
-				reg = <0x17c23000 0x1000>;
-				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				frame-number = <1>;
-				status = "disabled";
-			};
-
-			frame@17c25000 {
-				reg = <0x17c25000 0x1000>;
-				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				frame-number = <2>;
-				status = "disabled";
-			};
-
-			frame@17c27000 {
-				reg = <0x17c27000 0x1000>;
-				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				frame-number = <3>;
-				status = "disabled";
-			};
-
-			frame@17c29000 {
-				reg = <0x17c29000 0x1000>;
-				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				frame-number = <4>;
-				status = "disabled";
-			};
+		qupv3_id_1: geniqup@ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x00ac0000 0x0 0x6000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x443 0x0>;
+			status = "disabled";
 
-			frame@17c2b000 {
-				reg = <0x17c2b000 0x1000>;
-				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				frame-number = <5>;
+			uart10: serial@a8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x00a8c000 0x0 0x4000>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				interconnect-names = "qup-core", "qup-config";
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
+						 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_1 0>;
+				power-domains = <&rpmhpd SA8775P_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
 
-			frame@17c2d000 {
-				reg = <0x17c2d000 0x1000>;
-				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				frame-number = <6>;
+			uart12: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x00a94000 0x0 0x4000>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
 				status = "disabled";
 			};
 		};
 
-		apps_rsc: rsc@18200000 {
-			compatible = "qcom,rpmh-rsc";
-			reg = <0x0 0x18200000 0x0 0x10000>,
-			      <0x0 0x18210000 0x0 0x10000>,
-			      <0x0 0x18220000 0x0 0x10000>;
-			reg-names = "drv-0", "drv-1", "drv-2";
-			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-			      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-			      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-			qcom,tcs-offset = <0xd00>;
-			qcom,drv-id = <2>;
-			qcom,tcs-config = <ACTIVE_TCS 2>,
-					  <SLEEP_TCS 3>,
-					  <WAKE_TCS 3>,
-					  <CONTROL_TCS 0>;
-			label = "apps_rsc";
-
-			apps_bcm_voter: bcm-voter {
-				compatible = "qcom,bcm-voter";
-			};
-
-			rpmhcc: clock-controller {
-				compatible = "qcom,sa8775p-rpmh-clk";
-				#clock-cells = <1>;
-				clock-names = "xo";
-				clocks = <&xo_board_clk>;
-			};
-
-			rpmhpd: power-controller {
-				compatible = "qcom,sa8775p-rpmhpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmhpd_opp_table>;
-
-				rpmhpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmhpd_opp_ret: opp-0 {
-						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
-					};
-
-					rpmhpd_opp_min_svs: opp-1 {
-						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
-					};
-
-					rpmhpd_opp_low_svs: opp2 {
-						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
-					};
-
-					rpmhpd_opp_svs: opp3 {
-						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
-					};
-
-					rpmhpd_opp_svs_l1: opp-4 {
-						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
-					};
-
-					rpmhpd_opp_nom: opp-5 {
-						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
-					};
-
-					rpmhpd_opp_nom_l1: opp-6 {
-						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
-					};
-
-					rpmhpd_opp_nom_l2: opp-7 {
-						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
-					};
-
-					rpmhpd_opp_turbo: opp-8 {
-						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
-					};
-
-					rpmhpd_opp_turbo_l1: opp-9 {
-						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
-					};
-				};
-			};
-		};
-
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
 			#hwlock-cells = <1>;
 		};
 
-		cpufreq_hw: cpufreq@18591000 {
-			compatible = "qcom,sa8775p-cpufreq-epss",
-				     "qcom,cpufreq-epss";
-			reg = <0x0 0x18591000 0x0 0x1000>,
-			      <0x0 0x18593000 0x0 0x1000>;
-			reg-names = "freq-domain0", "freq-domain1";
-
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
-			clock-names = "xo", "alternate";
-
-			#freq-domain-cells = <1>;
-		};
-
 		tlmm: pinctrl@f000000 {
 			compatible = "qcom,sa8775p-tlmm";
 			reg = <0x0 0x0f000000 0x0 0x1000000>;
@@ -900,6 +739,167 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 892 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		intc: interrupt-controller@17a00000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
+			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+		};
+
+		memtimer: timer@17c20000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0 0x17c20000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x0 0x20000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			frame@17c21000 {
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <0>;
+			};
+
+			frame@17c23000 {
+				reg = <0x17c23000 0x1000>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <1>;
+				status = "disabled";
+			};
+
+			frame@17c25000 {
+				reg = <0x17c25000 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <2>;
+				status = "disabled";
+			};
+
+			frame@17c27000 {
+				reg = <0x17c27000 0x1000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <3>;
+				status = "disabled";
+			};
+
+			frame@17c29000 {
+				reg = <0x17c29000 0x1000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <4>;
+				status = "disabled";
+			};
+
+			frame@17c2b000 {
+				reg = <0x17c2b000 0x1000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <5>;
+				status = "disabled";
+			};
+
+			frame@17c2d000 {
+				reg = <0x17c2d000 0x1000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <6>;
+				status = "disabled";
+			};
+		};
+
+		apps_rsc: rsc@18200000 {
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x0 0x18200000 0x0 0x10000>,
+			      <0x0 0x18210000 0x0 0x10000>,
+			      <0x0 0x18220000 0x0 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS 2>,
+					  <SLEEP_TCS 3>,
+					  <WAKE_TCS 3>,
+					  <CONTROL_TCS 0>;
+			label = "apps_rsc";
+
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,bcm-voter";
+			};
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sa8775p-rpmh-clk";
+				#clock-cells = <1>;
+				clock-names = "xo";
+				clocks = <&xo_board_clk>;
+			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sa8775p-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp-0 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp-1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp-4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp-5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp-6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp-7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp-8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp-9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+		};
+
+		cpufreq_hw: cpufreq@18591000 {
+			compatible = "qcom,sa8775p-cpufreq-epss",
+				     "qcom,cpufreq-epss";
+			reg = <0x0 0x18591000 0x0 0x1000>,
+			      <0x0 0x18593000 0x0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
 	};
 
 	arch_timer: timer {
-- 
2.37.2

