Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6978E6CA4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjC0MyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjC0MxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:53:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394441989
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so7310983wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679921601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsAcKkkhh2xD0zEWe6Y/fbdCXDRgje0cU2EbheBpM/A=;
        b=xoksPbxKdJsNHfgM5QsaVFidtL/2Bq+iWgoRNetfXf9KMlnl6mJf8eDW3s/BtfdbX9
         PCt+UnfcWvonQnK+4LcnehnHy/WpSTF7FFh48JYdgzPzQruyYU8WoHDnaUcudrSbHRn4
         7PTqf+U763p3cydt7FmbGxmGpP6DhklPtysaM2OscbbSoyq+u744zJYHfExgMxLhRk2E
         DoVk8O3Nyn6n4qzGKWZqDGtswsSCPQwefixJdW9SJa0KznLh+6jP2ftWi75h0tmAftKT
         cNdXMP0bEFZVRNd0UoC/pjgwMiLhJxdcPQnfwMd+/JOVmuBrNI9gT+pwytaHkjCwank3
         O1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsAcKkkhh2xD0zEWe6Y/fbdCXDRgje0cU2EbheBpM/A=;
        b=T5w2vvzaitPXjbvqlftwNVACCOX5AFy9dn5a5MwIsgUe2SUrh+/DZk0bD3IPI5ZAsJ
         H91E/FqZsqO5Aj4aIUq6PHqQ5gUrHNQ580r9j/Tyq7R0X23RLJxMEtaW4OIbGFHW/+6H
         6bV1IZUMScqoJ/luN65jAhjBhE55yOYR27LzN6OlMdd0qGT0Ka6377Ju6D0UAYeNthJi
         FXpq4jCFR+EKh8wl+WTWb7czUTKS+QItS4vPLeSi1Di8Wjxgox3qPgXpxUNmdvMVmYIY
         RngjmLIX4Kq/hAXe+Ca8ij1ixDJWR1d4EDhONOZtTpEL0TN5ujQQweso7ZgeiuN7s1o2
         rRxw==
X-Gm-Message-State: AO0yUKWAREDaQ9uOD7Sv4eeKZP0kLnkRL+mh4Q+J0R1LDrFTnIb88n6H
        7Y+oxGP1+JbmEORyyNS7ipX+og==
X-Google-Smtp-Source: AK7set/2d6R65fkSCinPsHucKuonJMyNpgCFkbo5jXe3E16ZX8HxQ+b6Hkl8TlAxJG2xOI4PKy/xyA==
X-Received: by 2002:a7b:c38a:0:b0:3ed:276d:81a4 with SMTP id s10-20020a7bc38a000000b003ed276d81a4mr9319532wmj.32.1679921601703;
        Mon, 27 Mar 2023 05:53:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:313d:a304:2790:a949])
        by smtp.gmail.com with ESMTPSA id q25-20020a1ce919000000b003ee58e8c971sm13572220wmc.14.2023.03.27.05.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:53:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 02/18] arm64: dts: qcom: sa8775p: sort soc nodes by reg property
Date:   Mon, 27 Mar 2023 14:53:00 +0200
Message-Id: <20230327125316.210812-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327125316.210812-1-brgl@bgdev.pl>
References: <20230327125316.210812-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

