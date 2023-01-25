Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196D67AEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjAYJp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjAYJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:45:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA55B1E5C2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso802859wmn.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rehPnk2K/g3HXkr8UJKDPsOY+ol6GSyRA/iFMHVWuqk=;
        b=AkRRpJfCwwPxqcpsA+LKNlZ7Jny8XdYdKTc93VU8NK8sazeJwiFsFrKyfoOMdi6LOK
         zDaiWw7w7zN4+KNR8la89f1du9bVRIOhqpD8uo+rDGCDSS9CzzRGqnoQEnNxbexKQeUC
         TLrrCERr80jYN+ibCWYAegmeslI2nCUQQ0K8ac8PcThBMdLGSitXEMEqzyyykQ6O4qqh
         bxuDsLCa2PQYWtQ3dbiQil1FxuHrAa6gsmIiSIJq3sPO+7KGT/NbKVZwur2AYfAC3PGg
         eeqPEfESdJ3RkGI/o3wc+DC4qv6Zl8r7VDzxqHrehxbxngoHcijUX/LBg2Zk3V5jKWr8
         eppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rehPnk2K/g3HXkr8UJKDPsOY+ol6GSyRA/iFMHVWuqk=;
        b=VZHb211KZddlxvHJf+FIi6WFAeXOil3TMbSek1OP60dcbI6B172+dQJDHY0jCOy6Xk
         Fps3BWGtac1LKaNYpPW/K846RmC+CSMpL9Lm1bW57moumXgE+gnTgPVUiZK+kNV4fosc
         RRi+bQb4Xm3KEd+tCXGnqyHDO8lSGRw/UPEpLoKtiBMiznFiY3AsqLKjkoi5kvVq006o
         jbqXsuGgo/IgWC8mcV8d+LFkMnt2XCoCKiP8Fywxypis4jT+r8mt63HDUKSTPI4QoL8G
         Urghw4VHtrG9O3PLzhpJGC4jHi8QccqZLjfm2oyXy5NuafP4wXTZ6USuhetAboF6W5vk
         4sIg==
X-Gm-Message-State: AFqh2krS30lLxb+l2NCxz6OjJzDjWKIGgpUL89yZg+b+jLBxf1wbAs30
        737u2voxNVUIltn0MnAx4qXWyw==
X-Google-Smtp-Source: AMrXdXu1QouqMqcUhoSHEnoEjM/FaCPnmBG3wQhdmo3c/e2wtU3NkiUnWjv9OG2LwHe7gXmrIVn7mw==
X-Received: by 2002:a05:600c:5386:b0:3cf:9844:7b11 with SMTP id hg6-20020a05600c538600b003cf98447b11mr32371950wmb.23.1674639924113;
        Wed, 25 Jan 2023 01:45:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm1419238wmb.2.2023.01.25.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:45:23 -0800 (PST)
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
Subject: [PATCH 2/9] ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos5420
Date:   Wed, 25 Jan 2023 10:45:06 +0100
Message-Id: <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
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

  arch/arm/boot/dts/exynos5420.dtsi:1070.24-1075.5:
    Warning (simple_bus_reg): /soc/bus-wcore: missing or empty reg/ranges property

and dtbs_check:

  exynos5420-arndale-octa.dtb: soc: bus-wcore:
    {'compatible': ['samsung,exynos-bus'], 'clocks': [[2, 769]], 'clock-names': ['bus'], 'status': ['disabled']} should not be valid under {'type': 'object'}

Move the bus nodes and their OPP tables out of SoC to fix this.
Re-order them alphabetically while moving and put some of the OPP tables
in device nodes (if they are not shared).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 223 +++++++++++++++---------------
 1 file changed, 111 insertions(+), 112 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7efe72879dc4..cea92f175d46 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -37,6 +37,117 @@ aliases {
 		spi2 = &spi_2;
 	};
 
+	bus_disp1: bus-disp1 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK400_DISP1>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_disp1_fimd: bus-disp1-fimd {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_fsys: bus-fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_fsys2: bus-fsys2 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_fsys_apb: bus-fsys-apb {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_g2d: bus-g2d {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK333_G2D>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_g2d_acp: bus-g2d-acp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK266_G2D>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+	bus_gen: bus-gen {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK266>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_gscl_scaler: bus-gscl-scaler {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_jpeg: bus-jpeg {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_jpeg_apb: bus-jpeg-apb {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK166>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_mfc: bus-mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK333>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_mscl: bus-mscl {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_noc: bus-noc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK100_NOC>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_peri: bus-peri {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK66>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
+	bus_wcore: bus-wcore {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
+		clock-names = "bus";
+		status = "disabled";
+	};
+
 	/*
 	 * The 'cpus' node is not present here but instead it is provided
 	 * by exynos5420-cpus.dtsi or exynos5422-cpus.dtsi.
@@ -1066,118 +1177,6 @@ sysmmu_fimd1_1: sysmmu@14680000 {
 			power-domains = <&disp_pd>;
 			#iommu-cells = <0>;
 		};
-
-		bus_wcore: bus-wcore {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_noc: bus-noc {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK100_NOC>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_fsys_apb: bus-fsys-apb {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_fsys: bus-fsys {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_fsys2: bus-fsys2 {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_mfc: bus-mfc {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK333>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_gen: bus-gen {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK266>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_peri: bus-peri {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK66>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_g2d: bus-g2d {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK333_G2D>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_g2d_acp: bus-g2d-acp {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK266_G2D>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_jpeg: bus-jpeg {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_jpeg_apb: bus-jpeg-apb {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK166>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_disp1_fimd: bus-disp1-fimd {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_disp1: bus-disp1 {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK400_DISP1>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_gscl_scaler: bus-gscl-scaler {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
-			clock-names = "bus";
-			status = "disabled";
-		};
-
-		bus_mscl: bus-mscl {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
-			clock-names = "bus";
-			status = "disabled";
-		};
 	};
 
 	thermal-zones {
-- 
2.34.1

