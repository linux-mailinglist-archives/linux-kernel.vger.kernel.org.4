Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38D67AEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjAYJqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjAYJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:45:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194C392A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso828414wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZq6vcYLSpCiJSp+WXg/JczZdDBpy+pHgfwtM/oSjxQ=;
        b=riaqyz2lwEb4DgM0DUm64FLRI8iaWEEMMQzY6GbWHcBYCxWgvo+eLWxql42HJwDqdg
         5E1WHr3vkJnBnwLoRLzdkeW29K6EFBNSL81MpHGzMelRCf48byQZLTzKLJBfs2uVco2t
         RJxKMCzO4rjxteeiDVxiTHtN+qdNO6XjCoxA0Nuozzdo2pOWC5/OGkclB8sVv0jcG87t
         Ls+NNwk3AELp6pvZwTkP7kTM+NalRzUGhbVM9WG/zW6M3zJFhueg5ZuDQ1UR+e2wJkxy
         qlmRYVU6AL3dgsD7puT137KkwSVS4mMyzCXuKq4/Y47MsDKsPvbB08Ta8QINRUyqrm4o
         uRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZq6vcYLSpCiJSp+WXg/JczZdDBpy+pHgfwtM/oSjxQ=;
        b=X/L3nsnBaW/G0m7CqSHIk7g/XwuHka6DBcwDDP67Vf1zbeZQlKrbpxtvUcwxLuNkM3
         Slrvvx0kGIzerjxtb/K7D+QgktXztmn/joSdGggPUUQ4p+9vt4qW7SWNmH4vs3DYXn3c
         JWneyYKjaeerOOBP3PCpmswh0O4k17/h0Wg3vEK5wUlMGihhzYqHx1lQqVOAR6s7Clgf
         7JNUkL4KduHyOkzCWv3RVc/GLDGdIXYk9uNA6L64XLDesxCucgRj0mtafKuE8TFo52Po
         6FUwxGzEuTLdzLT+Fzdlw0Iqdb1xYmoOIHWG2Qr6mzuXW2MUk9BM/HNqMTGoBEB8qG6B
         9gHg==
X-Gm-Message-State: AFqh2kqH9ts9sE5v2MZRCQtlECMMjVfd6PDEp6eoFnqc1Sl0cCQwQgzo
        yTMZZ3W70ADjQSHNBKrLFQ2jKw==
X-Google-Smtp-Source: AMrXdXuy+4yRtxn6PwfDpPIkQah7RDCN2kOJNdXw4AfxjVEUCgRM6YUTPwxZLoFkmpFWYt6dAEFPDg==
X-Received: by 2002:a05:600c:a13:b0:3db:1de2:af31 with SMTP id z19-20020a05600c0a1300b003db1de2af31mr23106016wmp.37.1674639926917;
        Wed, 25 Jan 2023 01:45:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm1419238wmb.2.2023.01.25.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:45:26 -0800 (PST)
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
Subject: [PATCH 4/9] ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos4210
Date:   Wed, 25 Jan 2023 10:45:08 +0100
Message-Id: <20230125094513.155063-4-krzysztof.kozlowski@linaro.org>
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

  exynos4210.dtsi:218.20-224.5:
    Warning (simple_bus_reg): /soc/bus-dmc: missing or empty reg/ranges property

and dtbs_check:

  exynos4210-i9100.dtb: soc: bus-dmc:
    {'compatible': ['samsung,exynos-bus'], 'clocks': [[5, 457]], 'clock-names': ['bus'], 'operating-points-v2': [[82]], 'status': ['disabled']} should not be valid under {'type': 'object'}

Move the bus nodes and their OPP tables out of SoC to fix this.
Re-order them alphabetically while moving and put some of the OPP tables
in device nodes (if they are not shared).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210.dtsi | 322 +++++++++++++++---------------
 1 file changed, 161 insertions(+), 161 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index d11cbe03770d..1b4e55822e7c 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -28,6 +28,151 @@ aliases {
 		pinctrl2 = &pinctrl_2;
 	};
 
+	bus_acp: bus-acp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_ACP>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_acp_opp_table>;
+		status = "disabled";
+
+		bus_acp_opp_table: opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+			};
+			opp-160000000 {
+				opp-hz = /bits/ 64 <160000000>;
+			};
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+		};
+	};
+
+	bus_display: bus-display {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_display_opp_table>;
+		status = "disabled";
+
+		bus_display_opp_table: opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp-134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+			};
+			opp-160000000 {
+				opp-hz = /bits/ 64 <160000000>;
+			};
+		};
+	};
+
+	bus_dmc: bus-dmc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_DMC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+
+		bus_dmc_opp_table: opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+				opp-microvolt = <1025000>;
+			};
+			opp-267000000 {
+				opp-hz = /bits/ 64 <267000000>;
+				opp-microvolt = <1050000>;
+			};
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <1150000>;
+				opp-suspend;
+			};
+		};
+	};
+
+	bus_fsys: bus-fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK133>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys_opp_table>;
+		status = "disabled";
+
+		bus_fsys_opp_table: opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-10000000 {
+				opp-hz = /bits/ 64 <10000000>;
+			};
+			opp-134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+			};
+		};
+	};
+
+	bus_lcd0: bus-lcd0 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK200>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_leftbus: bus-leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mfc: bus-mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_SCLK_MFC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_peri: bus-peri {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK100>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peri_opp_table>;
+		status = "disabled";
+
+		bus_peri_opp_table: opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-5000000 {
+				opp-hz = /bits/ 64 <5000000>;
+			};
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+		};
+	};
+
+	bus_rightbus: bus-rightbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDR>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -82,6 +227,22 @@ cpu1: cpu@901 {
 		};
 	};
 
+	bus_leftbus_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp-160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-suspend;
+		};
+	};
+
 	soc: soc {
 		sysram: sram@2020000 {
 			compatible = "mmio-sram";
@@ -214,167 +375,6 @@ sysmmu_fimd1: sysmmu@12220000 {
 			power-domains = <&pd_lcd1>;
 			#iommu-cells = <0>;
 		};
-
-		bus_dmc: bus-dmc {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DIV_DMC>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_dmc_opp_table>;
-			status = "disabled";
-		};
-
-		bus_acp: bus-acp {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DIV_ACP>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_acp_opp_table>;
-			status = "disabled";
-		};
-
-		bus_peri: bus-peri {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_ACLK100>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_peri_opp_table>;
-			status = "disabled";
-		};
-
-		bus_fsys: bus-fsys {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_ACLK133>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_fsys_opp_table>;
-			status = "disabled";
-		};
-
-		bus_display: bus-display {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_ACLK160>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_display_opp_table>;
-			status = "disabled";
-		};
-
-		bus_lcd0: bus-lcd0 {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_ACLK200>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_leftbus: bus-leftbus {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DIV_GDL>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_rightbus: bus-rightbus {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DIV_GDR>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_mfc: bus-mfc {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_SCLK_MFC>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			status = "disabled";
-		};
-
-		bus_dmc_opp_table: opp-table-1 {
-			compatible = "operating-points-v2";
-			opp-shared;
-
-			opp-134000000 {
-				opp-hz = /bits/ 64 <134000000>;
-				opp-microvolt = <1025000>;
-			};
-			opp-267000000 {
-				opp-hz = /bits/ 64 <267000000>;
-				opp-microvolt = <1050000>;
-			};
-			opp-400000000 {
-				opp-hz = /bits/ 64 <400000000>;
-				opp-microvolt = <1150000>;
-				opp-suspend;
-			};
-		};
-
-		bus_acp_opp_table: opp-table-2 {
-			compatible = "operating-points-v2";
-			opp-shared;
-
-			opp-134000000 {
-				opp-hz = /bits/ 64 <134000000>;
-			};
-			opp-160000000 {
-				opp-hz = /bits/ 64 <160000000>;
-			};
-			opp-200000000 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-		};
-
-		bus_peri_opp_table: opp-table-3 {
-			compatible = "operating-points-v2";
-			opp-shared;
-
-			opp-5000000 {
-				opp-hz = /bits/ 64 <5000000>;
-			};
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-		};
-
-		bus_fsys_opp_table: opp-table-4 {
-			compatible = "operating-points-v2";
-			opp-shared;
-
-			opp-10000000 {
-				opp-hz = /bits/ 64 <10000000>;
-			};
-			opp-134000000 {
-				opp-hz = /bits/ 64 <134000000>;
-			};
-		};
-
-		bus_display_opp_table: opp-table-5 {
-			compatible = "operating-points-v2";
-			opp-shared;
-
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-			opp-134000000 {
-				opp-hz = /bits/ 64 <134000000>;
-			};
-			opp-160000000 {
-				opp-hz = /bits/ 64 <160000000>;
-			};
-		};
-
-		bus_leftbus_opp_table: opp-table-6 {
-			compatible = "operating-points-v2";
-			opp-shared;
-
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-			opp-160000000 {
-				opp-hz = /bits/ 64 <160000000>;
-			};
-			opp-200000000 {
-				opp-hz = /bits/ 64 <200000000>;
-				opp-suspend;
-			};
-		};
 	};
 };
 
-- 
2.34.1

