Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B242734AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjFSEKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFSEJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:09:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD1E4D;
        Sun, 18 Jun 2023 21:09:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so1137200f8f.3;
        Sun, 18 Jun 2023 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687147788; x=1689739788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=rWSUKJvt/jGydpbQj+ieYSPxqrAh2IzA8yRlhBExkpXNM13zRMkZ6yL08Ph9643jPV
         o+y0aN0l/ePqnKbqaKJEuWCpKUeHTs/ZFRrv/D5Y/qenuajAnEJ4drn9Qdum/qRdNADr
         liuDGifl+ZZyMTlL2TwyvsEs0t9egpO2N1oR5BLlpz9OwwRZ30sLxh3v8VZXsJZYmDfA
         glrDJATPnOHJ6W5vty3X+q6cfj0POaT5Y2PKxVFd/oN/bd+mxqeK84+smgSEDiknVLPl
         qDy0VC2LZnfVzBFvI8oIrVtbCs6pgbRZTj3G5w3tD9DcZFLl4hgo4x8828F1iUILgNo5
         KLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147788; x=1689739788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=fydiCjwhHFez1XnrWHc7/gvwCUVjyUdfE8q043e/3qwdUEWb660EP7IE/h10hMco/l
         zuJTuKI1ygXUR+AFXD0VAKnk3XmNNC6k5KbM0vtrwAX46vls69yJa1y2k6gTl3ecuAJ4
         1gGWxH1SAMdhQU1ql5cpRpLJSdrY1KWBKf0U15Q2EuAuTfIkyNoN6WaYN69iUgOxC2N/
         vSq8VRLvrJNuAwWbRygKyEr6XYMxzQYD+m0fDMX1vTAMedjj2HMR6XdlG35eQt6+e6j4
         xO3WRvI4wBZtdYUp6EDimSvyoBzlsmagNaRhFfcoPbND3sZWdfjwz9yXTil+txE9W9cQ
         vhRA==
X-Gm-Message-State: AC+VfDzevVCKGKb8aDvQNWC/6ySkHS+cTZwUy+xfKE5ZDYu+5HnOnP4n
        761sh/9NgfSicUAO1b0+dCUWSp0QhZs=
X-Google-Smtp-Source: ACHHUZ6P2TeuW/m4nhpy2Mlx9kH++dqvNshhspERPDkG917wc6QGSxRuYVgidSurWG7b96Zxqcfa8A==
X-Received: by 2002:adf:ffc3:0:b0:30f:c3ec:e78f with SMTP id x3-20020adfffc3000000b0030fc3ece78fmr4583025wrs.21.1687147788273;
        Sun, 18 Jun 2023 21:09:48 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm30004052wrz.36.2023.06.18.21.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:09:47 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com
Subject: [PATCH v5 3/9] mips: ralink: rt288x: remove clock related code
Date:   Mon, 19 Jun 2023 06:09:35 +0200
Message-Id: <20230619040941.1340372-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
References: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
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

