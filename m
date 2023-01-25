Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2703E67AEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjAYJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjAYJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:45:55 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601E53B20
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so820389wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9fFPW0G+RJzOZ4eS7AbpNJHxxkkGAHbd5kJhIA6+NA=;
        b=dVhRfjVecKWFsPRP4zMcaQ2Pu7dpVYvpUmEJlyDYOJ/UqDi90rtrh1d595bW7GQz0I
         W9oEUg+sZbz7A11m7ckhEfqxPgL5gscR83aMlF9uK6yl1udMLF7a7aAO9dNEqpH8u6ic
         L6WAy4RhLZ7+DR4fheU0Jy68cqkXDFBXRW8mVsUxC8tLKGVknsMlBHQwktXa3FyyPRnd
         ksgO22vSyx+djokVJD6kcIuOcozjXFqx220iARiR5F+CNtDUDfrmavb1zC6orucrCWSx
         jFn/WaH+0RvbNp+6sIwG+74fHVigq8nBiCWwdMbIqeaaMJBVkUzplN5Hzg5e5IxxuxW9
         qE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9fFPW0G+RJzOZ4eS7AbpNJHxxkkGAHbd5kJhIA6+NA=;
        b=2slTHZDnTbgZfQQJjeFn6cdLyloVANt+H88aE1o85o0uUGbk++6zaf107m0N7COxU7
         qfNu6cA4+L0/oQvN0n/rGeJBZNOq0Er7kn/p4OVwUN1J9bEHEO8Ivffmyr+4WpC3CbWz
         IGQz1httIeYBEcOdFZM1FjotZaMyf15PD92e1V9cTtQAZh7N2tWQfNfdnbQjsy2bV0y4
         LxIKeiH/OeWmqqDyyoviisnQbdYd1rpuLARlDGz5d/3LwLFVQZ64h0nhzGuF4hwA/7iO
         T+QuTWcYjagR0QHjGSon1Pf/JCjiZNtU9uFq6diyOe0Xgn0VE8ZZBXPi76Tzf6aYxz6T
         +VQw==
X-Gm-Message-State: AFqh2kqoTQDSY1osS+nnlUldP6ezKLgIar6yLgxapuGWtpDE3ZrQULvs
        YJvaZmlopyOAv81PVnW/QuKsqg==
X-Google-Smtp-Source: AMrXdXuF0kR05yRTW+K8kKeK79mcqHC1VFIZ0ZDl6OwJ7lnYSQuPyCh7uWhF+6geFRrHCA0CKpOvig==
X-Received: by 2002:a7b:c45a:0:b0:3d1:ed41:57c0 with SMTP id l26-20020a7bc45a000000b003d1ed4157c0mr38846399wmi.30.1674639925510;
        Wed, 25 Jan 2023 01:45:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm1419238wmb.2.2023.01.25.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:45:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/9] ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos3250
Date:   Wed, 25 Jan 2023 10:45:07 +0100
Message-Id: <20230125094513.155063-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
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

The soc node is supposed to have only device nodes with MMIO addresses,
as reported by dtc W=1:

  exynos3250.dtsi:775.20-781.5:
    Warning (simple_bus_reg): /soc/bus-dmc: missing or empty reg/ranges property

and dtbs_check:

  exynos3250-artik5-eval.dtb: soc: bus-dmc:
    {'compatible': ['samsung,exynos-bus'], 'clocks': [[67, 16]], 'clock-names': ['bus'], 'operating-points-v2': [[68]], 'status': ['disabled']} should not be valid under {'type': 'object'}

Move the bus nodes and their OPP tables out of SoC to fix this.
Re-order them alphabetically while moving and put some of the OPP tables
in device nodes (if they are not shared).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 352 +++++++++++++++---------------
 1 file changed, 176 insertions(+), 176 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 36b47c2c1663..2e81371e04c2 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -46,6 +46,157 @@ aliases {
 		serial2 = &serial_2;
 	};
 
+	bus_dmc: bus-dmc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_dmc CLK_DIV_DMC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+
+		bus_dmc_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <800000>;
+			};
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <800000>;
+			};
+			opp-134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+				opp-microvolt = <800000>;
+			};
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <825000>;
+			};
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <875000>;
+			};
+		};
+	};
+
+	bus_fsys: bus-fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_200>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_isp: bus-isp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_266>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_isp_opp_table>;
+		status = "disabled";
+
+		bus_isp_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp-80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+			};
+		};
+	};
+
+	bus_lcd0: bus-lcd0 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_leftbus: bus-leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mcuisp: bus-mcuisp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_mcuisp_opp_table>;
+		status = "disabled";
+
+		bus_mcuisp_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp-80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+			};
+		};
+	};
+
+	bus_mfc: bus-mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_SCLK_MFC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_peril: bus-peril {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_100>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peril_opp_table>;
+		status = "disabled";
+
+		bus_peril_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp-80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+		};
+	};
+
+	bus_rightbus: bus-rightbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_GDR>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -129,6 +280,31 @@ xtcxo: clock-2 {
 		clock-output-names = "xtcxo";
 	};
 
+	bus_leftbus_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+
+		opp-50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-80000000 {
+			opp-hz = /bits/ 64 <80000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp-134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -771,182 +947,6 @@ ppmu_mfc: ppmu@13660000 {
 			clock-names = "ppmu";
 			status = "disabled";
 		};
-
-		bus_dmc: bus-dmc {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu_dmc CLK_DIV_DMC>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_dmc_opp_table>;
-			status = "disabled";
-		};
-
-		bus_dmc_opp_table: opp-table-1 {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-				opp-microvolt = <800000>;
-			};
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-				opp-microvolt = <800000>;
-			};
-			opp-134000000 {
-				opp-hz = /bits/ 64 <134000000>;
-				opp-microvolt = <800000>;
-			};
-			opp-200000000 {
-				opp-hz = /bits/ 64 <200000000>;
-				opp-microvolt = <825000>;
-			};
-			opp-400000000 {
-				opp-hz = /bits/ 64 <400000000>;
-				opp-microvolt = <875000>;
-			};
-		};
-
-		bus_leftbus: bus-leftbus {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_DIV_GDL>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_rightbus: bus-rightbus {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_DIV_GDR>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_lcd0: bus-lcd0 {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_DIV_ACLK_160>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_fsys: bus-fsys {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_DIV_ACLK_200>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_mcuisp: bus-mcuisp {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_mcuisp_opp_table>;
-			status = "disabled";
-		};
-
-		bus_isp: bus-isp {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_DIV_ACLK_266>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_isp_opp_table>;
-			status = "disabled";
-		};
-
-		bus_peril: bus-peril {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_DIV_ACLK_100>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_peril_opp_table>;
-			status = "disabled";
-		};
-
-		bus_mfc: bus-mfc {
-			compatible = "samsung,exynos-bus";
-			clocks = <&cmu CLK_SCLK_MFC>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_leftbus_opp_table: opp-table-2 {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-				opp-microvolt = <900000>;
-			};
-			opp-80000000 {
-				opp-hz = /bits/ 64 <80000000>;
-				opp-microvolt = <900000>;
-			};
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-				opp-microvolt = <1000000>;
-			};
-			opp-134000000 {
-				opp-hz = /bits/ 64 <134000000>;
-				opp-microvolt = <1000000>;
-			};
-			opp-200000000 {
-				opp-hz = /bits/ 64 <200000000>;
-				opp-microvolt = <1000000>;
-			};
-		};
-
-		bus_mcuisp_opp_table: opp-table-3 {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-			};
-			opp-80000000 {
-				opp-hz = /bits/ 64 <80000000>;
-			};
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-			opp-200000000 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-			opp-400000000 {
-				opp-hz = /bits/ 64 <400000000>;
-			};
-		};
-
-		bus_isp_opp_table: opp-table-4 {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-			};
-			opp-80000000 {
-				opp-hz = /bits/ 64 <80000000>;
-			};
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-			opp-200000000 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-			opp-300000000 {
-				opp-hz = /bits/ 64 <300000000>;
-			};
-		};
-
-		bus_peril_opp_table: opp-table-5 {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-			};
-			opp-80000000 {
-				opp-hz = /bits/ 64 <80000000>;
-			};
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-		};
 	};
 };
 
-- 
2.34.1

