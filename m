Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5BE6E38E0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDPNgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDPNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:36:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03AE46AC;
        Sun, 16 Apr 2023 06:35:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id xi5so57466822ejb.13;
        Sun, 16 Apr 2023 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681652154; x=1684244154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQtdUpGvqOFI5m3CYQBb7DJVZ7RwGog7OTZYtnBhNgg=;
        b=gEYHuKUzVAozCaD6E7EU2UuonkmY4sJyEur7ksh/befuOC9PPmaWSHzzNz/tIlvm86
         /JQeTe3lJzY6R8380es7HPXvLRnEplN5h/+hRFKEzx09r7h9kMgLVmY0ulUKNX0Au5FG
         iHq0mY4ePwU1ut19LqIzI/f6dNI1K8tBO5NjbmeijSdbjV3TxNUVVsfUvD8mlYJlFKEN
         BIY/LZL1BuHP9WkaaWsnQDNDpW+tubyQMvgeIQ6AgEpMD4Z4QWV7wqFFTltff3AnLdRd
         3piDlpuZajFMWORY6kcyr79CX7NTEZbUJr2rUnwfmP3v220ZbBm69/6UlZ8GRV+nPIar
         Hdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681652154; x=1684244154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQtdUpGvqOFI5m3CYQBb7DJVZ7RwGog7OTZYtnBhNgg=;
        b=IqAjBssbkFv09lpKdgX3VZzCH5ndxWYOrLeS3ugw1dypQnyqh06EooDGZ8fGs7Ao2e
         hlNLfCP8jWjGycRlEcN/QrzUQ+29vPFTUzwp67LbsATJnHPmdN/FGsrrH7SxThE0VyXO
         Wy637ruTSPgoGj6sA42RlmVO2ht/kjfOosppL+QQCa89iCiO2b4wapDgmOI51J28tNSs
         7ob9vy9rN6tNV57sF960TUlIQhWD1IL1wsWiZxTjbyzoIllWBNhiGG6G5a2CBvbGMZKK
         kxOCiklId2NVboYnGSnhP3fsU0xoOlFP+JzTbFM6P5XHctotveP1be7L8lnAseum4uu3
         oD0Q==
X-Gm-Message-State: AAQBX9emLGZolzySh2OBoWSfZby66s5iJZgBzfNzplSmWeK52pdMx/EG
        +giIjdntV1uYA04/pbudpXs=
X-Google-Smtp-Source: AKy350bcbt+kXqVbXMrRRzDyP3re999IIiqHnNBAXF6Vh3cRgJy9p0sNoIltZTtkc4toCfmkUyACbg==
X-Received: by 2002:a17:906:f9cd:b0:94f:5fd0:dd42 with SMTP id lj13-20020a170906f9cd00b0094f5fd0dd42mr1205683ejb.39.1681652154038;
        Sun, 16 Apr 2023 06:35:54 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5122958ejc.161.2023.04.16.06.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:35:53 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 09/12] ARM: dts: Move common Exynos4x12 definitions to exynos4x12.dtsi
Date:   Sun, 16 Apr 2023 15:34:19 +0200
Message-Id: <20230416133422.1949-10-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416133422.1949-1-aweber.kernel@gmail.com>
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the re-introduction of the Exynos4212, move
their shared definitions to a separate file. Rename the pinctrl
definitions accordingly, and adapt the Exynos4412 DTSI to these
changes.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/exynos4412.dtsi             | 645 +----------------
 ...2-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} |   4 +-
 arch/arm/boot/dts/exynos4x12.dtsi             | 665 ++++++++++++++++++
 3 files changed, 671 insertions(+), 643 deletions(-)
 rename arch/arm/boot/dts/{exynos4412-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} (99%)
 create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 11f9dd94b6b3..c2b53f1b7a47 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -14,151 +14,11 @@
  * nodes can be added to this file.
  */
 
-#include "exynos4.dtsi"
-
-#include "exynos4-cpu-thermal.dtsi"
+#include "exynos4x12.dtsi"
 
 / {
 	compatible = "samsung,exynos4412", "samsung,exynos4";
 
-	aliases {
-		pinctrl0 = &pinctrl_0;
-		pinctrl1 = &pinctrl_1;
-		pinctrl2 = &pinctrl_2;
-		pinctrl3 = &pinctrl_3;
-		fimc-lite0 = &fimc_lite_0;
-		fimc-lite1 = &fimc_lite_1;
-		mshc0 = &mshc_0;
-	};
-
-	bus_acp: bus-acp {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_DIV_ACP>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_acp_opp_table>;
-		status = "disabled";
-
-		bus_acp_opp_table: opp-table {
-			compatible = "operating-points-v2";
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
-			opp-267000000 {
-				opp-hz = /bits/ 64 <267000000>;
-			};
-		};
-	};
-
-	bus_c2c: bus-c2c {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_DIV_C2C>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_dmc_opp_table>;
-		status = "disabled";
-	};
-
-	bus_dmc: bus-dmc {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_DIV_DMC>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_dmc_opp_table>;
-		samsung,data-clock-ratio = <4>;
-		#interconnect-cells = <0>;
-		status = "disabled";
-	};
-
-	bus_display: bus-display {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_ACLK160>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_display_opp_table>;
-		interconnects = <&bus_leftbus &bus_dmc>;
-		#interconnect-cells = <0>;
-		status = "disabled";
-
-		bus_display_opp_table: opp-table {
-			compatible = "operating-points-v2";
-
-			opp-160000000 {
-				opp-hz = /bits/ 64 <160000000>;
-			};
-			opp-200000000 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-		};
-	};
-
-	bus_fsys: bus-fsys {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_ACLK133>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_fsys_opp_table>;
-		status = "disabled";
-
-		bus_fsys_opp_table: opp-table {
-			compatible = "operating-points-v2";
-
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-			opp-134000000 {
-				opp-hz = /bits/ 64 <134000000>;
-			};
-		};
-	};
-
-	bus_leftbus: bus-leftbus {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_DIV_GDL>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		interconnects = <&bus_dmc>;
-		#interconnect-cells = <0>;
-		status = "disabled";
-	};
-
-	bus_mfc: bus-mfc {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_SCLK_MFC>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		status = "disabled";
-	};
-
-	bus_peri: bus-peri {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_ACLK100>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_peri_opp_table>;
-		status = "disabled";
-
-		bus_peri_opp_table: opp-table {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-			};
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-		};
-	};
-
-	bus_rightbus: bus-rightbus {
-		compatible = "samsung,exynos-bus";
-		clocks = <&clock CLK_DIV_GDR>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		status = "disabled";
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -298,499 +158,20 @@ cpu0_opp_1500: opp-1500000000 {
 			turbo-mode;
 		};
 	};
+};
 
-	bus_dmc_opp_table: opp-table-1 {
-		compatible = "operating-points-v2";
-
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <900000>;
-		};
-		opp-134000000 {
-			opp-hz = /bits/ 64 <134000000>;
-			opp-microvolt = <900000>;
-		};
-		opp-160000000 {
-			opp-hz = /bits/ 64 <160000000>;
-			opp-microvolt = <900000>;
-		};
-		opp-267000000 {
-			opp-hz = /bits/ 64 <267000000>;
-			opp-microvolt = <950000>;
-		};
-		opp-400000000 {
-			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <1050000>;
-			opp-suspend;
-		};
-	};
-
-	bus_leftbus_opp_table: opp-table-2 {
-		compatible = "operating-points-v2";
-
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <900000>;
-		};
-		opp-134000000 {
-			opp-hz = /bits/ 64 <134000000>;
-			opp-microvolt = <925000>;
-		};
-		opp-160000000 {
-			opp-hz = /bits/ 64 <160000000>;
-			opp-microvolt = <950000>;
-		};
-		opp-200000000 {
-			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <1000000>;
-			opp-suspend;
-		};
-	};
-
-	soc: soc {
-
-		pinctrl_0: pinctrl@11400000 {
-			compatible = "samsung,exynos4x12-pinctrl";
-			reg = <0x11400000 0x1000>;
-			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		pinctrl_1: pinctrl@11000000 {
-			compatible = "samsung,exynos4x12-pinctrl";
-			reg = <0x11000000 0x1000>;
-			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-
-			wakup_eint: wakeup-interrupt-controller {
-				compatible = "samsung,exynos4210-wakeup-eint";
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		pinctrl_2: pinctrl@3860000 {
-			compatible = "samsung,exynos4x12-pinctrl";
-			reg = <0x03860000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <10 0>;
-		};
-
-		pinctrl_3: pinctrl@106e0000 {
-			compatible = "samsung,exynos4x12-pinctrl";
-			reg = <0x106e0000 0x1000>;
-			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		sram@2020000 {
-			compatible = "mmio-sram";
-			reg = <0x02020000 0x40000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x02020000 0x40000>;
-
-			smp-sram@0 {
-				compatible = "samsung,exynos4210-sysram";
-				reg = <0x0 0x1000>;
-			};
-
-			smp-sram@2f000 {
-				compatible = "samsung,exynos4210-sysram-ns";
-				reg = <0x2f000 0x1000>;
-			};
-		};
-
-		pd_isp: power-domain@10023ca0 {
-			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023ca0 0x20>;
-			#power-domain-cells = <0>;
-			label = "ISP";
-		};
-
-		l2c: cache-controller@10502000 {
-			compatible = "arm,pl310-cache";
-			reg = <0x10502000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
-			prefetch-data = <1>;
-			prefetch-instr = <1>;
-			arm,tag-latency = <2 2 1>;
-			arm,data-latency = <3 2 1>;
-			arm,double-linefill = <1>;
-			arm,double-linefill-incr = <0>;
-			arm,double-linefill-wrap = <1>;
-			arm,prefetch-drop = <1>;
-			arm,prefetch-offset = <7>;
-		};
-
-		clock: clock-controller@10030000 {
-			compatible = "samsung,exynos4412-clock";
-			reg = <0x10030000 0x18000>;
-			#clock-cells = <1>;
-		};
-
-		isp_clock: clock-controller@10048000 {
-			compatible = "samsung,exynos4412-isp-clock";
-			reg = <0x10048000 0x1000>;
-			#clock-cells = <1>;
-			power-domains = <&pd_isp>;
-			clocks = <&clock CLK_ACLK200>,
-				 <&clock CLK_ACLK400_MCUISP>;
-			clock-names = "aclk200", "aclk400_mcuisp";
-		};
-
-		timer@10050000 {
-			compatible = "samsung,exynos4412-mct";
-			reg = <0x10050000 0x800>;
-			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
-			clock-names = "fin_pll", "mct";
-			interrupts-extended = <&gic GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-					      <&combiner 12 5>,
-					      <&combiner 12 6>,
-					      <&combiner 12 7>,
-					      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		watchdog: watchdog@10060000 {
-			compatible = "samsung,exynos5250-wdt";
-			reg = <0x10060000 0x100>;
-			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_WDT>;
-			clock-names = "watchdog";
-			samsung,syscon-phandle = <&pmu_system_controller>;
-		};
-
-		adc: adc@126c0000 {
-			compatible = "samsung,exynos4212-adc";
-			reg = <0x126c0000 0x100>;
-			interrupt-parent = <&combiner>;
-			interrupts = <10 3>;
-			clocks = <&clock CLK_TSADC>;
-			clock-names = "adc";
-			#io-channel-cells = <1>;
-			samsung,syscon-phandle = <&pmu_system_controller>;
-			status = "disabled";
-		};
-
-		g2d: g2d@10800000 {
-			compatible = "samsung,exynos4212-g2d";
-			reg = <0x10800000 0x1000>;
-			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
-			clock-names = "sclk_fimg2d", "fimg2d";
-			iommus = <&sysmmu_g2d>;
-		};
-
-		mshc_0: mmc@12550000 {
-			compatible = "samsung,exynos4412-dw-mshc";
-			reg = <0x12550000 0x1000>;
-			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			fifo-depth = <0x80>;
-			clocks = <&clock CLK_SDMMC4>, <&clock CLK_SCLK_MMC4>;
-			clock-names = "biu", "ciu";
-			status = "disabled";
-		};
-
-		sysmmu_g2d: sysmmu@10a40000 {
-			compatible = "samsung,exynos-sysmmu";
-			reg = <0x10a40000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <4 7>;
-			clock-names = "sysmmu", "master";
-			clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
-			#iommu-cells = <0>;
-		};
-
-		sysmmu_fimc_isp: sysmmu@12260000 {
-			compatible = "samsung,exynos-sysmmu";
-			reg = <0x12260000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <16 2>;
-			power-domains = <&pd_isp>;
-			clock-names = "sysmmu";
-			clocks = <&isp_clock CLK_ISP_SMMU_ISP>;
-			#iommu-cells = <0>;
-		};
-
-		sysmmu_fimc_drc: sysmmu@12270000 {
-			compatible = "samsung,exynos-sysmmu";
-			reg = <0x12270000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <16 3>;
-			power-domains = <&pd_isp>;
-			clock-names = "sysmmu";
-			clocks = <&isp_clock CLK_ISP_SMMU_DRC>;
-			#iommu-cells = <0>;
-		};
-
-		sysmmu_fimc_fd: sysmmu@122a0000 {
-			compatible = "samsung,exynos-sysmmu";
-			reg = <0x122a0000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <16 4>;
-			power-domains = <&pd_isp>;
-			clock-names = "sysmmu";
-			clocks = <&isp_clock CLK_ISP_SMMU_FD>;
-			#iommu-cells = <0>;
-		};
-
-		sysmmu_fimc_mcuctl: sysmmu@122b0000 {
-			compatible = "samsung,exynos-sysmmu";
-			reg = <0x122b0000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <16 5>;
-			power-domains = <&pd_isp>;
-			clock-names = "sysmmu";
-			clocks = <&isp_clock CLK_ISP_SMMU_ISPCX>;
-			#iommu-cells = <0>;
-		};
-
-		sysmmu_fimc_lite0: sysmmu@123b0000 {
-			compatible = "samsung,exynos-sysmmu";
-			reg = <0x123b0000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <16 0>;
-			power-domains = <&pd_isp>;
-			clock-names = "sysmmu", "master";
-			clocks = <&isp_clock CLK_ISP_SMMU_LITE0>,
-				 <&isp_clock CLK_ISP_FIMC_LITE0>;
-			#iommu-cells = <0>;
-		};
-
-		sysmmu_fimc_lite1: sysmmu@123c0000 {
-			compatible = "samsung,exynos-sysmmu";
-			reg = <0x123c0000 0x1000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <16 1>;
-			power-domains = <&pd_isp>;
-			clock-names = "sysmmu", "master";
-			clocks = <&isp_clock CLK_ISP_SMMU_LITE1>,
-				 <&isp_clock CLK_ISP_FIMC_LITE1>;
-			#iommu-cells = <0>;
-		};
-	};
+&clock {
+	compatible = "samsung,exynos4412-clock";
 };
 
 &combiner {
 	samsung,combiner-nr = <20>;
-	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&camera {
-	clocks = <&clock CLK_SCLK_CAM0>, <&clock CLK_SCLK_CAM1>,
-		 <&clock CLK_PIXELASYNCM0>, <&clock CLK_PIXELASYNCM1>;
-	clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
-
-	/* fimc_[0-3] are configured outside, under phandles */
-	fimc_lite_0: fimc-lite@12390000 {
-		compatible = "samsung,exynos4212-fimc-lite";
-		reg = <0x12390000 0x1000>;
-		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&pd_isp>;
-		clocks = <&isp_clock CLK_ISP_FIMC_LITE0>;
-		clock-names = "flite";
-		iommus = <&sysmmu_fimc_lite0>;
-		status = "disabled";
-	};
-
-	fimc_lite_1: fimc-lite@123a0000 {
-		compatible = "samsung,exynos4212-fimc-lite";
-		reg = <0x123a0000 0x1000>;
-		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&pd_isp>;
-		clocks = <&isp_clock CLK_ISP_FIMC_LITE1>;
-		clock-names = "flite";
-		iommus = <&sysmmu_fimc_lite1>;
-		status = "disabled";
-	};
-
-	fimc_is: fimc-is@12000000 {
-		compatible = "samsung,exynos4212-fimc-is";
-		reg = <0x12000000 0x260000>;
-		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&pd_isp>;
-		clocks = <&isp_clock CLK_ISP_FIMC_LITE0>,
-			 <&isp_clock CLK_ISP_FIMC_LITE1>,
-			 <&isp_clock CLK_ISP_PPMUISPX>,
-			 <&isp_clock CLK_ISP_PPMUISPMX>,
-			 <&isp_clock CLK_ISP_FIMC_ISP>,
-			 <&isp_clock CLK_ISP_FIMC_DRC>,
-			 <&isp_clock CLK_ISP_FIMC_FD>,
-			 <&isp_clock CLK_ISP_MCUISP>,
-			 <&isp_clock CLK_ISP_GICISP>,
-			 <&isp_clock CLK_ISP_MCUCTL_ISP>,
-			 <&isp_clock CLK_ISP_PWM_ISP>,
-			 <&isp_clock CLK_ISP_DIV_ISP0>,
-			 <&isp_clock CLK_ISP_DIV_ISP1>,
-			 <&isp_clock CLK_ISP_DIV_MCUISP0>,
-			 <&isp_clock CLK_ISP_DIV_MCUISP1>,
-			 <&clock CLK_MOUT_MPLL_USER_T>,
-			 <&clock CLK_ACLK200>,
-			 <&clock CLK_ACLK400_MCUISP>,
-			 <&clock CLK_DIV_ACLK200>,
-			 <&clock CLK_DIV_ACLK400_MCUISP>,
-			 <&clock CLK_UART_ISP_SCLK>;
-		clock-names = "lite0", "lite1", "ppmuispx",
-			      "ppmuispmx", "isp",
-			      "drc", "fd", "mcuisp",
-			      "gicisp", "mcuctl_isp", "pwm_isp",
-			      "ispdiv0", "ispdiv1", "mcuispdiv0",
-			      "mcuispdiv1", "mpll", "aclk200",
-			      "aclk400mcuisp", "div_aclk200",
-			      "div_aclk400mcuisp", "uart";
-		iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
-			 <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
-		iommu-names = "isp", "drc", "fd", "mcuctl";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		status = "disabled";
-
-		pmu@10020000 {
-			reg = <0x10020000 0x3000>;
-		};
-
-		i2c1_isp: i2c-isp@12140000 {
-			compatible = "samsung,exynos4212-i2c-isp";
-			reg = <0x12140000 0x100>;
-			clocks = <&isp_clock CLK_ISP_I2C1_ISP>;
-			clock-names = "i2c_isp";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-&exynos_usbphy {
-	compatible = "samsung,exynos4x12-usb2-phy";
-	samsung,sysreg-phandle = <&sys_reg>;
-};
-
-&fimc_0 {
-	compatible = "samsung,exynos4212-fimc";
-	samsung,pix-limits = <4224 8192 1920 4224>;
-	samsung,mainscaler-ext;
-	samsung,isp-wb;
-	samsung,cam-if;
-};
-
-&fimc_1 {
-	compatible = "samsung,exynos4212-fimc";
-	samsung,pix-limits = <4224 8192 1920 4224>;
-	samsung,mainscaler-ext;
-	samsung,isp-wb;
-	samsung,cam-if;
-};
-
-&fimc_2 {
-	compatible = "samsung,exynos4212-fimc";
-	samsung,pix-limits = <4224 8192 1920 4224>;
-	samsung,mainscaler-ext;
-	samsung,isp-wb;
-	samsung,lcd-wb;
-	samsung,cam-if;
-};
-
-&fimc_3 {
-	compatible = "samsung,exynos4212-fimc";
-	samsung,pix-limits = <1920 8192 1366 1920>;
-	samsung,rotators = <0>;
-	samsung,mainscaler-ext;
-	samsung,isp-wb;
-	samsung,lcd-wb;
 };
 
 &gic {
 	cpu-offset = <0x4000>;
 };
 
-&gpu {
-	interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "gp",
-			  "gpmmu",
-			  "pp0",
-			  "ppmmu0",
-			  "pp1",
-			  "ppmmu1",
-			  "pp2",
-			  "ppmmu2",
-			  "pp3",
-			  "ppmmu3",
-			  "pmu";
-	operating-points-v2 = <&gpu_opp_table>;
-
-	gpu_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-160000000 {
-			opp-hz = /bits/ 64 <160000000>;
-			opp-microvolt = <875000>;
-		};
-		opp-267000000 {
-			opp-hz = /bits/ 64 <267000000>;
-			opp-microvolt = <900000>;
-		};
-		opp-350000000 {
-			opp-hz = /bits/ 64 <350000000>;
-			opp-microvolt = <950000>;
-		};
-		opp-440000000 {
-			opp-hz = /bits/ 64 <440000000>;
-			opp-microvolt = <1025000>;
-		};
-	};
-};
-
-&hdmi {
-	compatible = "samsung,exynos4212-hdmi";
-};
-
-&jpeg_codec {
-	compatible = "samsung,exynos4212-jpeg";
-};
-
-&rotator {
-	compatible = "samsung,exynos4212-rotator";
-};
-
-&mixer {
-	compatible = "samsung,exynos4212-mixer";
-	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
-	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
-		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
-	interconnects = <&bus_display &bus_dmc>;
-};
-
 &pmu {
 	interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
 	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
@@ -799,22 +180,4 @@ &pmu {
 
 &pmu_system_controller {
 	compatible = "samsung,exynos4412-pmu", "syscon";
-	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
-			"clkout4", "clkout8", "clkout9";
-	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
-		<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
-		<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>, <&clock CLK_XUSBXTI>;
-	#clock-cells = <1>;
 };
-
-&tmu {
-	compatible = "samsung,exynos4412-tmu";
-	interrupt-parent = <&combiner>;
-	interrupts = <2 4>;
-	reg = <0x100c0000 0x100>;
-	clocks = <&clock CLK_TMU_APBIF>;
-	clock-names = "tmu_apbif";
-	status = "disabled";
-};
-
-#include "exynos4412-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
similarity index 99%
rename from arch/arm/boot/dts/exynos4412-pinctrl.dtsi
rename to arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index 8ab31c3daa48..9f7ea5f2a91f 100644
--- a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Samsung's Exynos4412 SoCs pin-mux and pin-config device tree source
+ * Samsung's Exynos4x12 SoCs pin-mux and pin-config device tree source
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * Samsung's Exynos4412 SoCs pin-mux and pin-config optiosn are listed as device
+ * Samsung's Exynos4x12 SoCs pin-mux and pin-config optiosn are listed as device
  * tree nodes are listed in this file.
  */
 
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
new file mode 100644
index 000000000000..76118a34e540
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos4x12 SoC device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos4x12 SoC series device nodes are listed in this file. Particular
+ * SoCs from Exynos4x12 series can include this file and provide values for SoCs
+ * specfic bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos4x12 SoC. As device tree coverage for Exynos4x12 increases, additional
+ * nodes can be added to this file.
+ */
+
+#include "exynos4.dtsi"
+
+#include "exynos4-cpu-thermal.dtsi"
+
+/ {
+	aliases {
+		pinctrl0 = &pinctrl_0;
+		pinctrl1 = &pinctrl_1;
+		pinctrl2 = &pinctrl_2;
+		pinctrl3 = &pinctrl_3;
+		fimc-lite0 = &fimc_lite_0;
+		fimc-lite1 = &fimc_lite_1;
+		mshc0 = &mshc_0;
+	};
+
+	bus_acp: bus-acp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_ACP>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_acp_opp_table>;
+		status = "disabled";
+
+		bus_acp_opp_table: opp-table {
+			compatible = "operating-points-v2";
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
+			opp-267000000 {
+				opp-hz = /bits/ 64 <267000000>;
+			};
+		};
+	};
+
+	bus_c2c: bus-c2c {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_C2C>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_dmc: bus-dmc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_DMC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		samsung,data-clock-ratio = <4>;
+		#interconnect-cells = <0>;
+		status = "disabled";
+	};
+
+	bus_display: bus-display {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_display_opp_table>;
+		interconnects = <&bus_leftbus &bus_dmc>;
+		#interconnect-cells = <0>;
+		status = "disabled";
+
+		bus_display_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-160000000 {
+				opp-hz = /bits/ 64 <160000000>;
+			};
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
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
+
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp-134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+			};
+		};
+	};
+
+	bus_leftbus: bus-leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		interconnects = <&bus_dmc>;
+		#interconnect-cells = <0>;
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
+
+			opp-50000000 {
+				opp-hz = /bits/ 64 <50000000>;
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
+	bus_dmc_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1050000>;
+			opp-suspend;
+		};
+	};
+
+	bus_leftbus_opp_table: opp-table-2 {
+		compatible = "operating-points-v2";
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <925000>;
+		};
+		opp-160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+			opp-suspend;
+		};
+	};
+
+	soc: soc {
+
+		pinctrl_0: pinctrl@11400000 {
+			compatible = "samsung,exynos4x12-pinctrl";
+			reg = <0x11400000 0x1000>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_1: pinctrl@11000000 {
+			compatible = "samsung,exynos4x12-pinctrl";
+			reg = <0x11000000 0x1000>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+
+			wakup_eint: wakeup-interrupt-controller {
+				compatible = "samsung,exynos4210-wakeup-eint";
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		pinctrl_2: pinctrl@3860000 {
+			compatible = "samsung,exynos4x12-pinctrl";
+			reg = <0x03860000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <10 0>;
+		};
+
+		pinctrl_3: pinctrl@106e0000 {
+			compatible = "samsung,exynos4x12-pinctrl";
+			reg = <0x106e0000 0x1000>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		sram@2020000 {
+			compatible = "mmio-sram";
+			reg = <0x02020000 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x02020000 0x40000>;
+
+			smp-sram@0 {
+				compatible = "samsung,exynos4210-sysram";
+				reg = <0x0 0x1000>;
+			};
+
+			smp-sram@2f000 {
+				compatible = "samsung,exynos4210-sysram-ns";
+				reg = <0x2f000 0x1000>;
+			};
+		};
+
+		pd_isp: power-domain@10023ca0 {
+			compatible = "samsung,exynos4210-pd";
+			reg = <0x10023ca0 0x20>;
+			#power-domain-cells = <0>;
+			label = "ISP";
+		};
+
+		l2c: cache-controller@10502000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x10502000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+			prefetch-data = <1>;
+			prefetch-instr = <1>;
+			arm,tag-latency = <2 2 1>;
+			arm,data-latency = <3 2 1>;
+			arm,double-linefill = <1>;
+			arm,double-linefill-incr = <0>;
+			arm,double-linefill-wrap = <1>;
+			arm,prefetch-drop = <1>;
+			arm,prefetch-offset = <7>;
+		};
+
+		clock: clock-controller@10030000 {
+			reg = <0x10030000 0x18000>;
+			#clock-cells = <1>;
+		};
+
+		isp_clock: clock-controller@10048000 {
+			compatible = "samsung,exynos4412-isp-clock";
+			reg = <0x10048000 0x1000>;
+			#clock-cells = <1>;
+			power-domains = <&pd_isp>;
+			clocks = <&clock CLK_ACLK200>,
+				 <&clock CLK_ACLK400_MCUISP>;
+			clock-names = "aclk200", "aclk400_mcuisp";
+		};
+
+		timer@10050000 {
+			compatible = "samsung,exynos4412-mct";
+			reg = <0x10050000 0x800>;
+			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+			clock-names = "fin_pll", "mct";
+			interrupts-extended = <&gic GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+					      <&combiner 12 5>,
+					      <&combiner 12 6>,
+					      <&combiner 12 7>,
+					      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		watchdog: watchdog@10060000 {
+			compatible = "samsung,exynos5250-wdt";
+			reg = <0x10060000 0x100>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_WDT>;
+			clock-names = "watchdog";
+			samsung,syscon-phandle = <&pmu_system_controller>;
+		};
+
+		adc: adc@126c0000 {
+			compatible = "samsung,exynos4212-adc";
+			reg = <0x126c0000 0x100>;
+			interrupt-parent = <&combiner>;
+			interrupts = <10 3>;
+			clocks = <&clock CLK_TSADC>;
+			clock-names = "adc";
+			#io-channel-cells = <1>;
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			status = "disabled";
+		};
+
+		g2d: g2d@10800000 {
+			compatible = "samsung,exynos4212-g2d";
+			reg = <0x10800000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
+			clock-names = "sclk_fimg2d", "fimg2d";
+			iommus = <&sysmmu_g2d>;
+		};
+
+		mshc_0: mmc@12550000 {
+			compatible = "samsung,exynos4412-dw-mshc";
+			reg = <0x12550000 0x1000>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			fifo-depth = <0x80>;
+			clocks = <&clock CLK_SDMMC4>, <&clock CLK_SCLK_MMC4>;
+			clock-names = "biu", "ciu";
+			status = "disabled";
+		};
+
+		sysmmu_g2d: sysmmu@10a40000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x10a40000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <4 7>;
+			clock-names = "sysmmu", "master";
+			clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_isp: sysmmu@12260000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12260000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 2>;
+			power-domains = <&pd_isp>;
+			clock-names = "sysmmu";
+			clocks = <&isp_clock CLK_ISP_SMMU_ISP>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_drc: sysmmu@12270000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12270000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 3>;
+			power-domains = <&pd_isp>;
+			clock-names = "sysmmu";
+			clocks = <&isp_clock CLK_ISP_SMMU_DRC>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_fd: sysmmu@122a0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x122a0000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 4>;
+			power-domains = <&pd_isp>;
+			clock-names = "sysmmu";
+			clocks = <&isp_clock CLK_ISP_SMMU_FD>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_mcuctl: sysmmu@122b0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x122b0000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 5>;
+			power-domains = <&pd_isp>;
+			clock-names = "sysmmu";
+			clocks = <&isp_clock CLK_ISP_SMMU_ISPCX>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_lite0: sysmmu@123b0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x123b0000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 0>;
+			power-domains = <&pd_isp>;
+			clock-names = "sysmmu", "master";
+			clocks = <&isp_clock CLK_ISP_SMMU_LITE0>,
+				 <&isp_clock CLK_ISP_FIMC_LITE0>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_lite1: sysmmu@123c0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x123c0000 0x1000>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 1>;
+			power-domains = <&pd_isp>;
+			clock-names = "sysmmu", "master";
+			clocks = <&isp_clock CLK_ISP_SMMU_LITE1>,
+				 <&isp_clock CLK_ISP_FIMC_LITE1>;
+			#iommu-cells = <0>;
+		};
+	};
+};
+
+&combiner {
+	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&camera {
+	clocks = <&clock CLK_SCLK_CAM0>, <&clock CLK_SCLK_CAM1>,
+		 <&clock CLK_PIXELASYNCM0>, <&clock CLK_PIXELASYNCM1>;
+	clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
+
+	/* fimc_[0-3] are configured outside, under phandles */
+	fimc_lite_0: fimc-lite@12390000 {
+		compatible = "samsung,exynos4212-fimc-lite";
+		reg = <0x12390000 0x1000>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_isp>;
+		clocks = <&isp_clock CLK_ISP_FIMC_LITE0>;
+		clock-names = "flite";
+		iommus = <&sysmmu_fimc_lite0>;
+		status = "disabled";
+	};
+
+	fimc_lite_1: fimc-lite@123a0000 {
+		compatible = "samsung,exynos4212-fimc-lite";
+		reg = <0x123a0000 0x1000>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_isp>;
+		clocks = <&isp_clock CLK_ISP_FIMC_LITE1>;
+		clock-names = "flite";
+		iommus = <&sysmmu_fimc_lite1>;
+		status = "disabled";
+	};
+
+	fimc_is: fimc-is@12000000 {
+		compatible = "samsung,exynos4212-fimc-is";
+		reg = <0x12000000 0x260000>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_isp>;
+		clocks = <&isp_clock CLK_ISP_FIMC_LITE0>,
+			 <&isp_clock CLK_ISP_FIMC_LITE1>,
+			 <&isp_clock CLK_ISP_PPMUISPX>,
+			 <&isp_clock CLK_ISP_PPMUISPMX>,
+			 <&isp_clock CLK_ISP_FIMC_ISP>,
+			 <&isp_clock CLK_ISP_FIMC_DRC>,
+			 <&isp_clock CLK_ISP_FIMC_FD>,
+			 <&isp_clock CLK_ISP_MCUISP>,
+			 <&isp_clock CLK_ISP_GICISP>,
+			 <&isp_clock CLK_ISP_MCUCTL_ISP>,
+			 <&isp_clock CLK_ISP_PWM_ISP>,
+			 <&isp_clock CLK_ISP_DIV_ISP0>,
+			 <&isp_clock CLK_ISP_DIV_ISP1>,
+			 <&isp_clock CLK_ISP_DIV_MCUISP0>,
+			 <&isp_clock CLK_ISP_DIV_MCUISP1>,
+			 <&clock CLK_MOUT_MPLL_USER_T>,
+			 <&clock CLK_ACLK200>,
+			 <&clock CLK_ACLK400_MCUISP>,
+			 <&clock CLK_DIV_ACLK200>,
+			 <&clock CLK_DIV_ACLK400_MCUISP>,
+			 <&clock CLK_UART_ISP_SCLK>;
+		clock-names = "lite0", "lite1", "ppmuispx",
+			      "ppmuispmx", "isp",
+			      "drc", "fd", "mcuisp",
+			      "gicisp", "mcuctl_isp", "pwm_isp",
+			      "ispdiv0", "ispdiv1", "mcuispdiv0",
+			      "mcuispdiv1", "mpll", "aclk200",
+			      "aclk400mcuisp", "div_aclk200",
+			      "div_aclk400mcuisp", "uart";
+		iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
+			 <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
+		iommu-names = "isp", "drc", "fd", "mcuctl";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		status = "disabled";
+
+		pmu@10020000 {
+			reg = <0x10020000 0x3000>;
+		};
+
+		i2c1_isp: i2c-isp@12140000 {
+			compatible = "samsung,exynos4212-i2c-isp";
+			reg = <0x12140000 0x100>;
+			clocks = <&isp_clock CLK_ISP_I2C1_ISP>;
+			clock-names = "i2c_isp";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&exynos_usbphy {
+	compatible = "samsung,exynos4x12-usb2-phy";
+	samsung,sysreg-phandle = <&sys_reg>;
+};
+
+&fimc_0 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <4224 8192 1920 4224>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,cam-if;
+};
+
+&fimc_1 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <4224 8192 1920 4224>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,cam-if;
+};
+
+&fimc_2 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <4224 8192 1920 4224>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,lcd-wb;
+	samsung,cam-if;
+};
+
+&fimc_3 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <1920 8192 1366 1920>;
+	samsung,rotators = <0>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,lcd-wb;
+};
+
+&gpu {
+	interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "gp",
+			  "gpmmu",
+			  "pp0",
+			  "ppmmu0",
+			  "pp1",
+			  "ppmmu1",
+			  "pp2",
+			  "ppmmu2",
+			  "pp3",
+			  "ppmmu3",
+			  "pmu";
+	operating-points-v2 = <&gpu_opp_table>;
+
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <875000>;
+		};
+		opp-267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-350000000 {
+			opp-hz = /bits/ 64 <350000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-440000000 {
+			opp-hz = /bits/ 64 <440000000>;
+			opp-microvolt = <1025000>;
+		};
+	};
+};
+
+&hdmi {
+	compatible = "samsung,exynos4212-hdmi";
+};
+
+&jpeg_codec {
+	compatible = "samsung,exynos4212-jpeg";
+};
+
+&rotator {
+	compatible = "samsung,exynos4212-rotator";
+};
+
+&mixer {
+	compatible = "samsung,exynos4212-mixer";
+	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
+	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
+		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+	interconnects = <&bus_display &bus_dmc>;
+};
+
+&pmu_system_controller {
+	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
+			"clkout4", "clkout8", "clkout9";
+	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
+		<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
+		<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>, <&clock CLK_XUSBXTI>;
+	#clock-cells = <1>;
+};
+
+&tmu {
+	compatible = "samsung,exynos4412-tmu";
+	interrupt-parent = <&combiner>;
+	interrupts = <2 4>;
+	reg = <0x100c0000 0x100>;
+	clocks = <&clock CLK_TMU_APBIF>;
+	clock-names = "tmu_apbif";
+	status = "disabled";
+};
+
+#include "exynos4x12-pinctrl.dtsi"
-- 
2.40.0

