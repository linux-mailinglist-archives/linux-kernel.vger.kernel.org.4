Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17373FD60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjF0OHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjF0OHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:07:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE02D76
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:07:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b698937f85so47926661fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687874861; x=1690466861;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdJObOgvpAtWcviOs9VvRQlqG45niW1BqgpRqny2SRI=;
        b=YxCKqXrr+yIYc/KOcWWKFK4OwXQFk1egKOmLrF3UMjonSLl0bL07kVSKQR6oAXcWdW
         mOfxYDmb2dnZmwWOU6QweaVtyxTsVYKiyHETvNkPGUXlgi+IRtwnSUf2cXOPk50nPCO8
         R3I0zKwI8djZvxvjeevwR+OFM5Cy0QiQ6nqSWDf13S66nUUVFHMmCRwTah/X0Wwyfzul
         RtdxH8KNJ83cYK6DcM2ORyngWdA93nyN5jIB8KCLG1wT4t4tG4LvSPOVb9w3tkmHZO3a
         JBj1rHzriz5hp6XW0eeGWxh+hLRVrv2+Wshbt8AqOl2zIFtQX7NK9/ckSRQ4QlddAxQI
         TYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687874861; x=1690466861;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdJObOgvpAtWcviOs9VvRQlqG45niW1BqgpRqny2SRI=;
        b=cznSsIDCDSU14g75UlJPKMAWb6F6/nYEaxPWwNx40HyONj1N5DS21XJeoRzUPp/q/W
         +HwaNSQmdkdt5PfVp2mx9ti2+2YoszS+7Hnu+QfhmkmZcWlI9Ptid+KjeQDa9v/x+C7W
         2BFI+DaGJkM3DE8ChAA6WjxjVhMywMuTwSr2SN5ZpY24rVEp1bUjjqydEBPUhxk5a+4h
         tOi9Iol0jc2wMtCiQ6Hcn/lHINuPoh/vDuf9jg9nWM1siJzsoRmSF5K1+qiLbqDD/A7u
         VJveCakRaunfm1uZASoSt67g4a1kV1JTx2q99NIIkEi49ME9m6FS8megYa8gddxwwYPv
         QOaw==
X-Gm-Message-State: AC+VfDyuCr3goG6PmpPfAlBlI+Dp/icjRR31dBW71xOrngTgeywqplRx
        9nB6aZgTEfeSSL5+SueT5EfG8Q==
X-Google-Smtp-Source: ACHHUZ7yyZ8kw35CqRjD9NGeShe50fXTentEo8Vxu8cwLuRVgH9pupTh6TFlpDxe0ShR8U6ofi+8Qg==
X-Received: by 2002:a2e:9d89:0:b0:2b6:999e:d53c with SMTP id c9-20020a2e9d89000000b002b6999ed53cmr4924936ljj.21.1687874860110;
        Tue, 27 Jun 2023 07:07:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id j10-20020a2e850a000000b002b6b5c1bfcfsm187821lji.104.2023.06.27.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:07:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 16:07:37 +0200
Subject: [PATCH] arm64: dts: qcom: sm6375: Set up L3 scaling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-6375_l3-v1-1-9cb03ef05150@linaro.org>
X-B4-Tracking: v=1; b=H4sIACjtmmQC/x2NWwqDMBAAryL73YWYqBGvUkrJY9WFECWpUhDv3
 qWfMzDMBZUKU4WpuaDQyZW3LNA+GgirywshR2HQShs1aIufbeeAg7H9OxnsRq9MVNTZ6EEa7yq
 hLy6HVap8pCRyLzTz9z95vu77B9i+DRt0AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687874858; l=6896;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=D2QJK2zKd3+cRQgReUYE+6MsW3+94+0zmQi3s4xbGSA=;
 b=PrYT6oOUukC9gPxQUK90j704JUQ8yGNqFwsVY34WpYZdiFTRzMtF8SxuvUKZ0s36rIgpMn8DI
 3cpJ3Gh9uNNAm6iUZ5KlAyRm/EU0JAb5uy8ZY9oHsOUcjwmhhTAX9qv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPU OPP tables including core frequency and L3 bus frequency.
The L3 throughput values were chosen by studying the frequencies
available in HW LUT and picking the highest one that's less than the
CPU frequency. They will be replaced with a dynamic, bwmon-style
decision maker once support for MEMLAT is introduced upstream.

Available values from the HW LUT:
300000
556800
652800
768000
844800
921600
1171200
1382400
1497600

This commit dramatically improves overall performance of the system.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 127 +++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 3dba34210a6d..927aa59d4a07 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,sm6375-gpucc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -45,6 +46,8 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -69,6 +72,8 @@ CPU1: cpu@100 {
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -88,6 +93,8 @@ CPU2: cpu@200 {
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -107,6 +114,8 @@ CPU3: cpu@300 {
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -126,6 +135,8 @@ CPU4: cpu@400 {
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -145,6 +156,8 @@ CPU5: cpu@500 {
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -164,6 +177,8 @@ CPU6: cpu@600 {
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -183,6 +198,8 @@ CPU7: cpu@700 {
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&cpucp_l3 MASTER_EPSS_L3_APPS &cpucp_l3 SLAVE_EPSS_L3_SHARED>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -300,6 +317,116 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <(300000 * 32)>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <(556800 * 32)>;
+		};
+
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <(652800 * 32)>;
+		};
+
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(921600 * 32)>;
+		};
+
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <(921600 * 32)>;
+		};
+
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <(1171200 * 32)>;
+		};
+
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+	};
+
+	cpu6_opp_table: opp-table-cpu6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <(556800 * 32)>;
+		};
+
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(921600 * 32)>;
+		};
+
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-peak-kBps = <(1171200 * 32)>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(1382400 * 32)>;
+		};
+
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-peak-kBps = <(1497600 * 32)>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;

---
base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
change-id: 20230627-topic-6375_l3-48b03d0e47db

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

