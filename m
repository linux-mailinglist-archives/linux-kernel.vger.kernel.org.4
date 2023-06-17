Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE60733E58
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345668AbjFQFZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjFQFYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5781FD3;
        Fri, 16 Jun 2023 22:24:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-970028cfb6cso224238666b.1;
        Fri, 16 Jun 2023 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979480; x=1689571480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=jCovODCcHOh+h7XzvfTbf2spQ2eSL/9of4yKqaXBTH2BzrftbexcEQPJML9XXTvvfM
         fFOkZOA/wt+o3AuXYtS+F9kOdFKFioDdxsYwUDiE55dyI+40kLAxNtN1W459wwWT6PIX
         Zt4pPEWuRs+wp1uq6Jn4iHZxKz+FeZ2AvoSjKXzIVOEJCv5LXqZBh6O9wL6MqgJStsCr
         +aFb/wN+SIrt2Me+GPYmPtEjALEI9W4ZiU99vcPZT1dUr9Cn59RlUaEfbY3WzTEivRNM
         CrR+ubJAdbKn4SaGHJidxLls1fz1zsR9O3ZU8aWtEEkB8jB7reC8bhzOkLA5/Asu0wXj
         SpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979480; x=1689571480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=JO5gwWDw2ZSf2dra/GUkDhfZyEOD5s1rDlfIVoGaIlytD69NQD4d6mv7wnsXUbjjkX
         eWWj7t8tPHhMYdDa7qdBJRNZ+Uo7c0N68MAwwyZDVpmamUMO0Zvz+Aa3arENI0n8ukb9
         a3EGuQ3NJ6zjrk5PdsQ3mLqmYAQ6lnOd5W2W8EzASqmnb7dNBdSByB0GLtNl3KvdRLq5
         izJFm7CZu+UVzH7+sGqal9VGR8GW9Wo3dvOEcWl6dzL5Q5RjCusQW8QNJBfCPlRRe36H
         dTIAiz/dRnYCSiESBho5w1szM0xN7kFfB6LGA+AO6ZAOhaKeHTIh7/KdF1XawP0xKTRX
         q6ow==
X-Gm-Message-State: AC+VfDxpcYPE9wieF5FothhAzvtR8synybiuJsnJ3FicoJwO+6eYcz9K
        /6i9JQXWwwpZZOBw0Z94sGdISqNrjDc=
X-Google-Smtp-Source: ACHHUZ6oAetfMIbsVagmnia6ogpkx0PGADiCp1PmhrXXIJ/ipt/Jbwq99GGw9FcVL7WYvUkev1/vcw==
X-Received: by 2002:a17:907:36c9:b0:987:9203:64b7 with SMTP id bj9-20020a17090736c900b00987920364b7mr685827ejc.18.1686979480702;
        Fri, 16 Jun 2023 22:24:40 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:40 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 3/9] mips: ralink: rt288x: remove clock related code
Date:   Sat, 17 Jun 2023 07:24:29 +0200
Message-Id: <20230617052435.359177-4-sergio.paracuellos@gmail.com>
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

