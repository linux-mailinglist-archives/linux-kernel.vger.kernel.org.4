Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068676E5CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjDRJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjDRJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:03:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794BDD;
        Tue, 18 Apr 2023 02:03:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o9-20020a05600c510900b003f17012276fso3707301wms.4;
        Tue, 18 Apr 2023 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808598; x=1684400598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=L+lDPE9xLwjgOiBHlzytsnInUPKmUpzDTsScTp4m1h2YQHo5+ioSBEq8BcaI0t5b4e
         tLaMB2CkNPh2LXT0On55jRaJGzoltFJIxfxhi4W9cTq3cg2GMoHIT1u/2WE/hgYPnx1j
         GgrbqOAvZsfWak2L+olIuO55ZIk3Q6SF+c7H6/JH6vmAqAEsRBrllI+rEXr+dPITYa2y
         jpL1QKVGe+JqloB2gJB9t0cFg6hVlwwdfnY0BlJURx66nZZJNpeRwuMiWKqMWrUBcSfH
         bJ7EVGbhrl/7e+VRfRiHQonLpih2bO0Fbx04swYRXAk8VUPbOT81Q7VeoqAhGEnExX3i
         tK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808598; x=1684400598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=VMm/dQ2vd1ugFhsno4ZqtErYGko4YC63K7iu6mZ54OBRGPxDWMdR3La5pgWLwjq/I5
         vq8/d1pLBiWdW+pwgoOzEJXPdMJLmpVARyqgw6H0EnsLMDsmOfwzKZoVtPeI1/QAKdyb
         crGpT6sLYmKCdEHIkW1M8jx20BCnPWHIaLflAaGRKHIhZToyXU3NoL4dFRlp14KrhjtZ
         o5paGDqreDbjxXcf7rrFwnRvC9Q0rrmrz1RsMQtatYyHi0yWWuhr5au8wpVgBdKYpKbr
         pwQbdZlHcY4wZqwWyOuFFNh/pp8W2/QTmjkhS7Ej8Z8NjPtsON4jTl69yByCKXX+lhi9
         0vBQ==
X-Gm-Message-State: AAQBX9d0Vk26TuORoA47fQUnF+NR9aQjbTebmA7Tr47ye6i+gB7FGl9j
        1As3mKk6UcfTYy7yQvDclR9i05rbpOk=
X-Google-Smtp-Source: AKy350ZCUz8WXWirNZlLvA4wB0Zp6OwjmJAloCx8NgMqYe4xt7mQQVfBYMoJnNGMEOHH0Fp6elX4tQ==
X-Received: by 2002:a7b:ce0f:0:b0:3f1:6f39:419c with SMTP id m15-20020a7bce0f000000b003f16f39419cmr7763555wmc.36.1681808598514;
        Tue, 18 Apr 2023 02:03:18 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bcb07000000b003ee70225ed2sm14341109wmj.15.2023.04.18.02.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:03:17 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v3 3/9] mips: ralink: rt288x: remove clock related code
Date:   Tue, 18 Apr 2023 11:03:06 +0200
Message-Id: <20230418090312.2818879-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
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
 arch/mips/include/asm/mach-ralink/rt288x.h | 10 -------
 arch/mips/ralink/rt288x.c                  | 31 ----------------------
 2 files changed, 41 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt288x.h b/arch/mips/include/asm/mach-ralink/rt288x.h
index 66a999cd1d80..66d190358e3a 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x.h
@@ -18,7 +18,6 @@
 #define SYSC_REG_CHIP_NAME1		0x04
 #define SYSC_REG_CHIP_ID		0x0c
 #define SYSC_REG_SYSTEM_CONFIG		0x10
-#define SYSC_REG_CLKCFG			0x30
 
 #define RT2880_CHIP_NAME0		0x38325452
 #define RT2880_CHIP_NAME1		0x20203038
@@ -27,15 +26,6 @@
 #define CHIP_ID_ID_SHIFT		8
 #define CHIP_ID_REV_MASK		0xff
 
-#define SYSTEM_CONFIG_CPUCLK_SHIFT	20
-#define SYSTEM_CONFIG_CPUCLK_MASK	0x3
-#define SYSTEM_CONFIG_CPUCLK_250	0x0
-#define SYSTEM_CONFIG_CPUCLK_266	0x1
-#define SYSTEM_CONFIG_CPUCLK_280	0x2
-#define SYSTEM_CONFIG_CPUCLK_300	0x3
-
-#define CLKCFG_SRAM_CS_N_WDT		BIT(9)
-
 #define RT2880_SDRAM_BASE		0x08000000
 #define RT2880_MEM_SIZE_MIN		2
 #define RT2880_MEM_SIZE_MAX		128
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 456ba0b2599e..0c6a87452dd1 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -21,37 +21,6 @@
 
 static struct ralink_soc_info *soc_info_ptr;
 
-void __init ralink_clk_init(void)
-{
-	unsigned long cpu_rate, wmac_rate = 40000000;
-	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
-	t = ((t >> SYSTEM_CONFIG_CPUCLK_SHIFT) & SYSTEM_CONFIG_CPUCLK_MASK);
-
-	switch (t) {
-	case SYSTEM_CONFIG_CPUCLK_250:
-		cpu_rate = 250000000;
-		break;
-	case SYSTEM_CONFIG_CPUCLK_266:
-		cpu_rate = 266666667;
-		break;
-	case SYSTEM_CONFIG_CPUCLK_280:
-		cpu_rate = 280000000;
-		break;
-	case SYSTEM_CONFIG_CPUCLK_300:
-		cpu_rate = 300000000;
-		break;
-	}
-
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("300100.timer", cpu_rate / 2);
-	ralink_clk_add("300120.watchdog", cpu_rate / 2);
-	ralink_clk_add("300500.uart", cpu_rate / 2);
-	ralink_clk_add("300900.i2c", cpu_rate / 2);
-	ralink_clk_add("300c00.uartlite", cpu_rate / 2);
-	ralink_clk_add("400000.ethernet", cpu_rate / 2);
-	ralink_clk_add("480000.wmac", wmac_rate);
-}
-
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,rt2880-sysc");
-- 
2.25.1

