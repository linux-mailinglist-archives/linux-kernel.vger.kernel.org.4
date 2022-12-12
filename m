Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7D649B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiLLKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiLLKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:02:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133055F4B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:02:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so17650934lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVQ6v7A609DhVKEKlf0Q+UIpn+1EhJyHwokdFRJhhyQ=;
        b=VY5POQ+OBBRnOXvTmWokGv/+Ebor0cPyqlibGkVFzRS/Dub01CwClEkTveydQzrY1c
         VeTj+1P8LiwIV5ZaWWfc5ObdqIn3anUjaIEY3uXcY41BG/KzH06dnpVgKPrj5UtA+elR
         BVuw/4BeL2oWemFAdnvwj/N+h73jCtjC/g16xbtml7M6XM1RsdL9XVCLUF9+vxFmRfuG
         t3t2TPLi3CuwFBJqv7qSSisURZ13c7AJ6dhkZYGfviU/GYdjUcJGTmNWNZeA+sesPqLv
         RQ5Twg7hcl/aVxm+B4iJYG22VdgRmyj4aceiHtWlbTsXczcE+fNMbaiSSyWokdvrP62x
         /1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVQ6v7A609DhVKEKlf0Q+UIpn+1EhJyHwokdFRJhhyQ=;
        b=3hJjAQ2Zf9sClHnrHmgY1evHOLQ+f5UqlTyKjI2pq5CBPV1NrVthSO+RohKJ0i3fIo
         8o+Vb3wAhUCfcX1NeSsutZPa6ZDsmOlcCRNyKdwdyYRyyb9LtfMZPN5AOINzhKW1wIZo
         M3Vzmu0FkCkUWgAeI8fgdNoHtnoMGD3i1fwLGJRTJJxu+H69OSCyEDGAX0Qzo2qFD9ks
         xPTWVT4dnoc1KW/F6LFQsxTxPd+Sbyqb3dcJ71hsSBl3mfQ59Of4o6Pa6ql3QWrMybD3
         visM9sGurqrc0BwGvSZ1aSY+LrWuC9c78/Cd2SE+msywg1RhuYk+ge0jlsparwtZMEON
         s2qw==
X-Gm-Message-State: ANoB5pkx2Hj+C3+YK0mUP6p/UUL2B8R12JUlJc9uKCQfH4Oh62Tmq9G0
        WNnEqexKyulRWN0oByf53E2wWQ==
X-Google-Smtp-Source: AA0mqf7Tk7AMYCQhwMCt1+QESfuVeEx45ZL7EIAOqndUFmevpEhymOJySo7h/5oVYsh8l6ACV9ImfQ==
X-Received: by 2002:ac2:4c24:0:b0:4b4:900c:3a28 with SMTP id u4-20020ac24c24000000b004b4900c3a28mr3723025lfq.60.1670839366239;
        Mon, 12 Dec 2022 02:02:46 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i124-20020a2e2282000000b0027712379ec8sm1145101lji.28.2022.12.12.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:02:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: sdm845: order top-level nodes alphabetically
Date:   Mon, 12 Dec 2022 11:02:28 +0100
Message-Id: <20221212100232.138519-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
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

Order top-level nodes like memory, reserved-memory, opp-table-cpu
alphabetically for easier code maintenance.  No functional change (same
dtx_diff, except phandle changes).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 384 +++++++++++++--------------
 1 file changed, 192 insertions(+), 192 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a63dbd12230f..88e7d4061aae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -69,122 +69,18 @@ aliases {
 
 	chosen { };
 
-	memory@80000000 {
-		device_type = "memory";
-		/* We expect the bootloader to fill in the size */
-		reg = <0 0x80000000 0 0>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		hyp_mem: hyp-mem@85700000 {
-			reg = <0 0x85700000 0 0x600000>;
-			no-map;
-		};
-
-		xbl_mem: xbl-mem@85e00000 {
-			reg = <0 0x85e00000 0 0x100000>;
-			no-map;
-		};
-
-		aop_mem: aop-mem@85fc0000 {
-			reg = <0 0x85fc0000 0 0x20000>;
-			no-map;
-		};
-
-		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
-			compatible = "qcom,cmd-db";
-			reg = <0x0 0x85fe0000 0 0x20000>;
-			no-map;
-		};
-
-		smem@86000000 {
-			compatible = "qcom,smem";
-			reg = <0x0 0x86000000 0 0x200000>;
-			no-map;
-			hwlocks = <&tcsr_mutex 3>;
-		};
-
-		tz_mem: tz@86200000 {
-			reg = <0 0x86200000 0 0x2d00000>;
-			no-map;
-		};
-
-		rmtfs_mem: rmtfs@88f00000 {
-			compatible = "qcom,rmtfs-mem";
-			reg = <0 0x88f00000 0 0x200000>;
-			no-map;
-
-			qcom,client-id = <1>;
-			qcom,vmid = <15>;
-		};
-
-		qseecom_mem: qseecom@8ab00000 {
-			reg = <0 0x8ab00000 0 0x1400000>;
-			no-map;
-		};
-
-		camera_mem: camera-mem@8bf00000 {
-			reg = <0 0x8bf00000 0 0x500000>;
-			no-map;
-		};
-
-		ipa_fw_mem: ipa-fw@8c400000 {
-			reg = <0 0x8c400000 0 0x10000>;
-			no-map;
-		};
-
-		ipa_gsi_mem: ipa-gsi@8c410000 {
-			reg = <0 0x8c410000 0 0x5000>;
-			no-map;
-		};
-
-		gpu_mem: gpu@8c415000 {
-			reg = <0 0x8c415000 0 0x2000>;
-			no-map;
-		};
-
-		adsp_mem: adsp@8c500000 {
-			reg = <0 0x8c500000 0 0x1a00000>;
-			no-map;
-		};
-
-		wlan_msa_mem: wlan-msa@8df00000 {
-			reg = <0 0x8df00000 0 0x100000>;
-			no-map;
-		};
-
-		mpss_region: mpss@8e000000 {
-			reg = <0 0x8e000000 0 0x7800000>;
-			no-map;
-		};
-
-		venus_mem: venus@95800000 {
-			reg = <0 0x95800000 0 0x500000>;
-			no-map;
-		};
-
-		cdsp_mem: cdsp@95d00000 {
-			reg = <0 0x95d00000 0 0x800000>;
-			no-map;
-		};
-
-		mba_region: mba@96500000 {
-			reg = <0 0x96500000 0 0x200000>;
-			no-map;
-		};
-
-		slpi_mem: slpi@96700000 {
-			reg = <0 0x96700000 0 0x1400000>;
-			no-map;
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <38400000>;
+			clock-output-names = "xo_board";
 		};
 
-		spss_mem: spss@97b00000 {
-			reg = <0 0x97b00000 0 0x100000>;
-			no-map;
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
 		};
 	};
 
@@ -436,6 +332,18 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-sdm845", "qcom,scm";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0 0x80000000 0 0>;
+	};
+
 	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -701,32 +609,174 @@ pmu {
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
-	};
+	psci: psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
 
-	clocks {
-		xo_board: xo-board {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <38400000>;
-			clock-output-names = "xo_board";
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
 		};
 
-		sleep_clk: sleep-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32764>;
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: power-domain-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 	};
 
-	firmware {
-		scm {
-			compatible = "qcom,scm-sdm845", "qcom,scm";
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: hyp-mem@85700000 {
+			reg = <0 0x85700000 0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: xbl-mem@85e00000 {
+			reg = <0 0x85e00000 0 0x100000>;
+			no-map;
+		};
+
+		aop_mem: aop-mem@85fc0000 {
+			reg = <0 0x85fc0000 0 0x20000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x85fe0000 0 0x20000>;
+			no-map;
+		};
+
+		smem@86000000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x86000000 0 0x200000>;
+			no-map;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
+		tz_mem: tz@86200000 {
+			reg = <0 0x86200000 0 0x2d00000>;
+			no-map;
+		};
+
+		rmtfs_mem: rmtfs@88f00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0x88f00000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		qseecom_mem: qseecom@8ab00000 {
+			reg = <0 0x8ab00000 0 0x1400000>;
+			no-map;
+		};
+
+		camera_mem: camera-mem@8bf00000 {
+			reg = <0 0x8bf00000 0 0x500000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa-fw@8c400000 {
+			reg = <0 0x8c400000 0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa-gsi@8c410000 {
+			reg = <0 0x8c410000 0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: gpu@8c415000 {
+			reg = <0 0x8c415000 0 0x2000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@8c500000 {
+			reg = <0 0x8c500000 0 0x1a00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: wlan-msa@8df00000 {
+			reg = <0 0x8df00000 0 0x100000>;
+			no-map;
+		};
+
+		mpss_region: mpss@8e000000 {
+			reg = <0 0x8e000000 0 0x7800000>;
+			no-map;
+		};
+
+		venus_mem: venus@95800000 {
+			reg = <0 0x95800000 0 0x500000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp@95d00000 {
+			reg = <0 0x95d00000 0 0x800000>;
+			no-map;
+		};
+
+		mba_region: mba@96500000 {
+			reg = <0 0x96500000 0 0x200000>;
+			no-map;
+		};
+
+		slpi_mem: slpi@96700000 {
+			reg = <0 0x96700000 0 0x1400000>;
+			no-map;
+		};
+
+		spss_mem: spss@97b00000 {
+			reg = <0 0x97b00000 0 0x100000>;
+			no-map;
 		};
 	};
 
@@ -1018,64 +1068,6 @@ slpi_smp2p_in: slave-kernel {
 		};
 	};
 
-	psci: psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-
-		CPU_PD0: power-domain-cpu0 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD1: power-domain-cpu1 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD2: power-domain-cpu2 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD3: power-domain-cpu3 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD4: power-domain-cpu4 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CPU_PD5: power-domain-cpu5 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CPU_PD6: power-domain-cpu6 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CPU_PD7: power-domain-cpu7 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CLUSTER_PD: power-domain-cluster {
-			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>;
-		};
-	};
-
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -5771,4 +5763,12 @@ modem_alert0: trip-point0 {
 			};
 		};
 	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
-- 
2.34.1

