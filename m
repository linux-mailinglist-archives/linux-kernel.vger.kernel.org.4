Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EE6013A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJQQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJQQkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:40:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158504E840
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:40:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m6so11642331pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja3n7UoR5krxLTXF2BIGLH1a4R4IrPfEp3/SrF1htuE=;
        b=qEih3QuJC+Y/SzRtUxEpqY+PWzQgky53hGqBB75AJJeJeXUaLWWmXFn0tbt8AhUPc0
         uBybEPWIQ+8oUmmEPwNQRgL38VHNUfO/9+prYSKNMWk7zkIBCjwrwkgawK+3BdEK+sLy
         vOYPxA0VMaFR3JIcsnEQmveEPxlum/GZ291qb4MGdokrkGtuSDXGKZaQ5TczUhRXPNXp
         NFkiNhm65vBdZrNejraWch1IF8WEBlYjeEWHc/2H7h58j7NiCze4wYIJf4BCApkwy40Z
         Jg5+yuUHl3rY6z5KLm/xdIN302Lgyzpihrw/zC14CMnVR5TKozemlSHhvRxiRJVOGOn3
         Rf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja3n7UoR5krxLTXF2BIGLH1a4R4IrPfEp3/SrF1htuE=;
        b=begqBAn3jhLA239z/ERo3o0rx5sR1y816u4M7yL2i9h6MS8Y5XsnKG28W4wUA17sp5
         Yyh0tF2+zaOXnWdR8kDTNhVZ10pe9W1v3GlHICgvKE97y5NKruv5oENQt6ltih55Q4Xk
         hSL0K6bDEFl5G9pm7T+YlvG9qv/szwkhhWWwKKd1Rslm7ryfyLl2NT/DfT0lsg/pVirA
         Y5CkX0N4PRILfRUsMq/miZuIfwrpWciLl+IJztBoV/kTcaF9HVpIEQAdfx7Oxqc4C3Xz
         qbCxBTTQR0VMNrO74q/TiCvB0pPQTVuD/rHqcDnylLDUQLISC6LSdBmCc6qYautokq0C
         y+HA==
X-Gm-Message-State: ACrzQf1IJp7oVKf+Mj69Gd1deqOTWZCh036ECmGZNa6mub5/XQNJwk77
        AoaHYCTU0iN3v3hV7yzGqKD6sw==
X-Google-Smtp-Source: AMsMyM5j2iFAOZ0VnbEXzq8FF+Zoh8S6Qvvv9hf/o5FL6ZmwBZTanXJXB13ASnC3VgJnjHLkOYug2Q==
X-Received: by 2002:aa7:84ce:0:b0:563:1aaf:81d5 with SMTP id x14-20020aa784ce000000b005631aaf81d5mr13479784pfn.63.1666024831991;
        Mon, 17 Oct 2022 09:40:31 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.186])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902b70e00b00178af82a08dsm6872113pls.91.2022.10.17.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:40:31 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "arm64: dts: qcom: sm8250: Add cpuidle states"
Date:   Mon, 17 Oct 2022 22:10:05 +0530
Message-Id: <20221017164005.2622934-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
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

This reverts commit 32bc936d732171d48c9c8f96c4fa25ac3ed7e1c7.

This patch was part of a patch series to add APSS RSC to
Cluster power domain
https://patchwork.kernel.org/project/linux-pm/cover/1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com/
but the rest of the patches in this series got NACKed and didn't land.

These cpuidle states made RB5 (sm8250) highly unstable and I run into
following crash every now and then:

[    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
[    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
[    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110

I reported this breakage earlier this year as well:
https://lore.kernel.org/all/CAMi1Hd2Sngya_2m2odkjq4fdV8OiiXsFMEX1bb807cWMC7H-sg@mail.gmail.com/
I can confirm that if I cherry-pick the rest of the patches from the
series then I can't reproduce this crash, but I'm not sure when the rest
of the patches are going to land though.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 105 ---------------------------
 1 file changed, 105 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..a2c15da1a450 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -101,8 +101,6 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <448>;
 			dynamic-power-coefficient = <205>;
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD0>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -125,8 +123,6 @@ CPU1: cpu@100 {
 			capacity-dmips-mhz = <448>;
 			dynamic-power-coefficient = <205>;
 			next-level-cache = <&L2_100>;
-			power-domains = <&CPU_PD1>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -146,8 +142,6 @@ CPU2: cpu@200 {
 			capacity-dmips-mhz = <448>;
 			dynamic-power-coefficient = <205>;
 			next-level-cache = <&L2_200>;
-			power-domains = <&CPU_PD2>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -167,8 +161,6 @@ CPU3: cpu@300 {
 			capacity-dmips-mhz = <448>;
 			dynamic-power-coefficient = <205>;
 			next-level-cache = <&L2_300>;
-			power-domains = <&CPU_PD3>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -188,8 +180,6 @@ CPU4: cpu@400 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <379>;
 			next-level-cache = <&L2_400>;
-			power-domains = <&CPU_PD4>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -209,8 +199,6 @@ CPU5: cpu@500 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <379>;
 			next-level-cache = <&L2_500>;
-			power-domains = <&CPU_PD5>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -231,8 +219,6 @@ CPU6: cpu@600 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <379>;
 			next-level-cache = <&L2_600>;
-			power-domains = <&CPU_PD6>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -252,8 +238,6 @@ CPU7: cpu@700 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <444>;
 			next-level-cache = <&L2_700>;
-			power-domains = <&CPU_PD7>;
-			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			operating-points-v2 = <&cpu7_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -300,42 +284,6 @@ core7 {
 				};
 			};
 		};
-
-		idle-states {
-			entry-method = "psci";
-
-			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
-				compatible = "arm,idle-state";
-				idle-state-name = "silver-rail-power-collapse";
-				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <360>;
-				exit-latency-us = <531>;
-				min-residency-us = <3934>;
-				local-timer-stop;
-			};
-
-			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
-				compatible = "arm,idle-state";
-				idle-state-name = "gold-rail-power-collapse";
-				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <702>;
-				exit-latency-us = <1061>;
-				min-residency-us = <4488>;
-				local-timer-stop;
-			};
-		};
-
-		domain-idle-states {
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "domain-idle-state";
-				idle-state-name = "cluster-llcc-off";
-				arm,psci-suspend-param = <0x4100c244>;
-				entry-latency-us = <3264>;
-				exit-latency-us = <6562>;
-				min-residency-us = <9987>;
-				local-timer-stop;
-			};
-		};
 	};
 
 	cpu0_opp_table: opp-table-cpu0 {
@@ -649,59 +597,6 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-
-		CPU_PD0: cpu0 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD1: cpu1 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD2: cpu2 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD3: cpu3 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
-		};
-
-		CPU_PD4: cpu4 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CPU_PD5: cpu5 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CPU_PD6: cpu6 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CPU_PD7: cpu7 {
-			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
-		};
-
-		CLUSTER_PD: cpu-cluster0 {
-			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>;
-		};
 	};
 
 	qup_opp_table: opp-table-qup {
-- 
2.25.1

