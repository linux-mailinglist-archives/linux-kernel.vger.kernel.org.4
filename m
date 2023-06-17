Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70B1733E5A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbjFQFZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjFQFYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA61FF5;
        Fri, 16 Jun 2023 22:24:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1041546f8f.0;
        Fri, 16 Jun 2023 22:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979483; x=1689571483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0hlvvdbeDEIm7xJGhHSHeJnLpm+LhG9OICPA4xVqkE=;
        b=Npb/0wBJBX/A+QGXzKWI5KCJ5QS0u0YZEqfZ6moNWnPGCjwP5gud/sFAXtFe/lV4Il
         xIlFPjM4FG8sdzMgX83/LDAg/DZ5K4uGJH55+3MRGNfCBHhaLoimiRIEI29lMunSNqpv
         st5wZXqnahLzujHepMlWiH1ba9JtgoeXXJkuHZ18U4/aGnM8ioly06HOEjUR1E84IcKt
         a2NBzL9KY5CXmv7iYc4LSbtwt58+BWWvZL6KZ7LMy8N1u3XmkLySJoEsH7ZGMtCuWfbx
         HE4btXoqiXhara9OM0LiHEUqzTK2StRGFfcwOZBqifBLgZ3316OB86zL+caDXbYEoGWo
         8EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979483; x=1689571483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0hlvvdbeDEIm7xJGhHSHeJnLpm+LhG9OICPA4xVqkE=;
        b=IFheNpuov8t3ax3EdcLMGL6VqriC+T3eaD1CIUiOxNChgU1yGUq9OMZNokkkBI41Io
         TPGYaVK9dsyRTgW0Lv61XtqGrIRj0kCVoQSr9QPJ2mJBZlagmZGqhmq6p+kNkxVTF1E3
         lR+CNrAQmF06lilz/mpX+JsF4iS/H7RIlfL80wgo3SgyC4rxMYXex+kqh914r5OyNoAH
         VN4wKXH/P1i/3D+jLjWo1KgpyX9/KQ/VuMxrcL49ghUsaWEhfda+XyxNaSNeu6uV+RyS
         jLZNLIhZKcWT4BXmVg/UAT5U+tfZ7kZ4xNBpAvRDwP3RJjkJuR5ou5jp85DeYLbMH+B1
         uNYQ==
X-Gm-Message-State: AC+VfDx19FiC92Lx4erD4E5mmtalmZ9NCIY5UI0cstOtGu7tTnMHOpFo
        1MQmXKbeETZgdev8mH8Lb8q46Lc8RHo=
X-Google-Smtp-Source: ACHHUZ5VGIsDDSoANIat4aBRr83QRGmJHP5z0v3bJ8NP65S7JnbsoJVYYXAYw3QOzhNNUN42t/h/Iw==
X-Received: by 2002:a5d:5305:0:b0:30f:d2d3:55a8 with SMTP id e5-20020a5d5305000000b0030fd2d355a8mr2473743wrv.11.1686979483414;
        Fri, 16 Jun 2023 22:24:43 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:42 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 5/9] mips: ralink: rt3883: remove clock related code
Date:   Sat, 17 Jun 2023 07:24:31 +0200
Message-Id: <20230617052435.359177-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A properly clock driver for ralink SoCs has been added. Hence there is no
need to have clock related code in 'arch/mips/ralink' folder anymore.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/rt3883.h |  8 ----
 arch/mips/ralink/rt3883.c                  | 44 ----------------------
 2 files changed, 52 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt3883.h b/arch/mips/include/asm/mach-ralink/rt3883.h
index ad25d5e8d2dc..4a835b178925 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883.h
@@ -92,14 +92,6 @@
 #define RT3883_REVID_VER_ID_SHIFT	8
 #define RT3883_REVID_ECO_ID_MASK	0x0f
 
-#define RT3883_SYSCFG0_DRAM_TYPE_DDR2	BIT(17)
-#define RT3883_SYSCFG0_CPUCLK_SHIFT	8
-#define RT3883_SYSCFG0_CPUCLK_MASK	0x3
-#define RT3883_SYSCFG0_CPUCLK_250	0x0
-#define RT3883_SYSCFG0_CPUCLK_384	0x1
-#define RT3883_SYSCFG0_CPUCLK_480	0x2
-#define RT3883_SYSCFG0_CPUCLK_500	0x3
-
 #define RT3883_SYSCFG1_USB0_HOST_MODE	BIT(10)
 #define RT3883_SYSCFG1_PCIE_RC_MODE	BIT(8)
 #define RT3883_SYSCFG1_PCI_HOST_MODE	BIT(7)
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index cca887af378f..14c56993611a 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -21,50 +21,6 @@
 
 static struct ralink_soc_info *soc_info_ptr;
 
-void __init ralink_clk_init(void)
-{
-	unsigned long cpu_rate, sys_rate;
-	u32 syscfg0;
-	u32 clksel;
-	u32 ddr2;
-
-	syscfg0 = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG0);
-	clksel = ((syscfg0 >> RT3883_SYSCFG0_CPUCLK_SHIFT) &
-		RT3883_SYSCFG0_CPUCLK_MASK);
-	ddr2 = syscfg0 & RT3883_SYSCFG0_DRAM_TYPE_DDR2;
-
-	switch (clksel) {
-	case RT3883_SYSCFG0_CPUCLK_250:
-		cpu_rate = 250000000;
-		sys_rate = (ddr2) ? 125000000 : 83000000;
-		break;
-	case RT3883_SYSCFG0_CPUCLK_384:
-		cpu_rate = 384000000;
-		sys_rate = (ddr2) ? 128000000 : 96000000;
-		break;
-	case RT3883_SYSCFG0_CPUCLK_480:
-		cpu_rate = 480000000;
-		sys_rate = (ddr2) ? 160000000 : 120000000;
-		break;
-	case RT3883_SYSCFG0_CPUCLK_500:
-		cpu_rate = 500000000;
-		sys_rate = (ddr2) ? 166000000 : 125000000;
-		break;
-	}
-
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("10000100.timer", sys_rate);
-	ralink_clk_add("10000120.watchdog", sys_rate);
-	ralink_clk_add("10000500.uart", 40000000);
-	ralink_clk_add("10000900.i2c", 40000000);
-	ralink_clk_add("10000a00.i2s", 40000000);
-	ralink_clk_add("10000b00.spi", sys_rate);
-	ralink_clk_add("10000b40.spi", sys_rate);
-	ralink_clk_add("10000c00.uartlite", 40000000);
-	ralink_clk_add("10100000.ethernet", sys_rate);
-	ralink_clk_add("10180000.wmac", 40000000);
-}
-
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,rt3883-sysc");
-- 
2.25.1

