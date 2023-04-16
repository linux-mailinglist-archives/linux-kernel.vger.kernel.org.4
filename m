Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93C6E3754
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDPKUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjDPKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:19:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204723C2B;
        Sun, 16 Apr 2023 03:18:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id xd13so22887555ejb.4;
        Sun, 16 Apr 2023 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640308; x=1684232308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Daq90p6qrczMZk89cBam/kQAHCGL98Y3xxZQBJA/2hY=;
        b=okCnUFUVYcKcBnxuGO85xXyESOLr7/haQlIajZZuDWUlLJ5Yoh6J6pq7SouGTuzY/R
         wN91hmUpkhd9DMyTBXAZEoA7DeWakR+7yJcru2JpVMGmAxRnMcu4AuoRF1VbSS2+2wXl
         8PtVAI8MH6FfciGFY2s4YXngR1iaUaw+CbbuQzfGrM+f38kvqT4vrzIrIJlEJKJw66Y6
         HHkBFWxpcuZkgE26hNiJgCPc2FtwpqQHbm3ATQi/poroipVZ1J8WDhBLtKSU+qM9pVfe
         6w3f2eniTeEBCYJiUhJpBPUR51b/NdA5Kzt8XuWzCxncQibGG76fvTjFfGXk5YcRgUNf
         DUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640308; x=1684232308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Daq90p6qrczMZk89cBam/kQAHCGL98Y3xxZQBJA/2hY=;
        b=WSbQfavf9/pbOu6dBhGeBA1SlaSfhWFc5ImRlXVFXVA85s4kHrqAQ251T2KbPGNoTn
         7XfFso2JnrTRY60uQFzFudDudSxtM5oN5eeWE4sphPHhjrD7dHnSJbVxh2RyNxzlQZNa
         TYnTCk4d6mJsc5J/lXHa5ERcsnu45PcxzerWOOLFxzpFn0WPRCyg0GCPLRVtjqEnGQaF
         UY/VQOIl7df26fza9AO9j1l5Djhhg5JSjNung30eDai4R/CDd8nUYqA/+SagiVZyE4Ch
         7E/pfe6QyxTHAY+glDYRollsXdC53FWDfF8vS70x+KTV2aWxPbI9eT6bYqZ7Nadw7StD
         F+pQ==
X-Gm-Message-State: AAQBX9dyuHuvVCfVzCntKOeo77fHXVvdoIEi0hil4HTMjfwb+PEuN4bC
        mSVwhDmd8w+mvsipnH8X5fE=
X-Google-Smtp-Source: AKy350bC0Ffjgx9yHHyWLXVl19/OfrGLF4yIZtpo7LQsvpr4YAdPGrRsYD7MUM/bBfhKBRvmFCxjsg==
X-Received: by 2002:a17:907:6d11:b0:94f:6218:191c with SMTP id sa17-20020a1709076d1100b0094f6218191cmr682586ejc.18.1681640308461;
        Sun, 16 Apr 2023 03:18:28 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:28 -0700 (PDT)
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
Subject: [PATCH 10/12] ARM: dts: Re-introduce Exynos4212 DTSI
Date:   Sun, 16 Apr 2023 12:16:22 +0200
Message-Id: <20230416101624.15866-11-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
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

The DTSI file was originally dropped in commit bca9085e0ae9 ("ARM:
dts: exynos: remove Exynos4212 support (dead code)"), as there were
no boards using it.

We will be adding a device that uses it, so add it back.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/exynos4212.dtsi | 157 ++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4212.dtsi

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
new file mode 100644
index 000000000000..9261c14a4489
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos4212 SoC device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos4212 SoC device nodes are listed in this file. Exynos4212
+ * based board files can include this file and provide values for board specfic
+ * bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos4212 SoC. As device tree coverage for Exynos4212 increases, additional
+ * nodes can be added to this file.
+ */
+
+#include "exynos4x12.dtsi"
+
+/ {
+	compatible = "samsung,exynos4212", "samsung,exynos4";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@a00 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xa00>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
+		};
+
+		cpu1: cpu@a01 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xa01>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
+		};
+	};
+
+	cpu0_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <987500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <200000>;
+			opp-suspend;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1087500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1187500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1287500>;
+			clock-latency-ns = <200000>;
+		};
+		cpu0_opp_1500: opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1350000>;
+			clock-latency-ns = <200000>;
+			turbo-mode;
+		};
+	};
+};
+
+&clock {
+	compatible = "samsung,exynos4212-clock";
+};
+
+&combiner {
+	samsung,combiner-nr = <18>;
+};
+
+&gic {
+	cpu-offset = <0x8000>;
+};
+
+&pmu {
+	interrupts = <2 2>, <3 2>;
+	interrupt-affinity = <&cpu0>, <&cpu1>;
+	status = "okay";
+};
+
+&pmu_system_controller {
+	compatible = "samsung,exynos4212-pmu", "syscon";
+};
-- 
2.40.0

