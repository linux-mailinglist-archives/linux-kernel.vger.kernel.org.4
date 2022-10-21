Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7FA607B93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJUPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJUPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3FCBE532;
        Fri, 21 Oct 2022 08:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C60361F0B;
        Fri, 21 Oct 2022 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD80EC433B5;
        Fri, 21 Oct 2022 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666367684;
        bh=GmW53LJo22UqZsQom5RVQJUjOo34/GKH+2iN7vYTsKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drcj45CMGOdbT6gQ7oc6iW0maJ/F4A7aDDG3q8CMEUhMj6kHZJ9TzcuZBMSDTN47W
         /54pExNenZQ0rlYMSkbga6w/tEfFQKMteBBLKQ8IgUBT1dklhQWW3E9v6R512FZsyE
         GWCAW56Tc0yN6RZcsY/UIsSP1QyAtGPO4aG5U4Lqee4KTUpkaMVDIfcTsofxqBaKR8
         s47f0CnF7bAqcFO+XjQ2+B56unnlcrnE7L1H8LYHTPY1DuTj+NeW+5zHYC6NCP826O
         PxvCwATnD5UsQq29ILBSrcboSsjitMId+xf5CN+5FDgqG8nUeSNvgxo8qPOZizDCJa
         MExojCoKO5byQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org
Subject: [PATCH 04/11] ARM: sa1100: make cpufreq driver build standalone
Date:   Fri, 21 Oct 2022 17:49:34 +0200
Message-Id: <20221021155000.4108406-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021155000.4108406-1-arnd@kernel.org>
References: <20221021155000.4108406-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Commit 59a2e613d07f ("cpufreq: sa11x0: move cpufreq driver
to drivers/cpufreq") added an unnecessary reference to
mach/generic.h. Just remove it again after moving the code
into the corresponding driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-sa1100/generic.c              | 32 ---------------------
 arch/arm/mach-sa1100/generic.h              |  4 ---
 arch/arm/mach-sa1100/include/mach/generic.h |  1 -
 drivers/cpufreq/sa1110-cpufreq.c            | 32 +++++++++++++++++++++
 4 files changed, 32 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/generic.h

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 6c21f214cd60..424f08eece20 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -39,38 +39,6 @@
 #include "generic.h"
 #include <clocksource/pxa.h>
 
-#define NR_FREQS	16
-
-/*
- * This table is setup for a 3.6864MHz Crystal.
- */
-struct cpufreq_frequency_table sa11x0_freq_table[NR_FREQS+1] = {
-	{ .frequency = 59000,	/*  59.0 MHz */},
-	{ .frequency = 73700,	/*  73.7 MHz */},
-	{ .frequency = 88500,	/*  88.5 MHz */},
-	{ .frequency = 103200,	/* 103.2 MHz */},
-	{ .frequency = 118000,	/* 118.0 MHz */},
-	{ .frequency = 132700,	/* 132.7 MHz */},
-	{ .frequency = 147500,	/* 147.5 MHz */},
-	{ .frequency = 162200,	/* 162.2 MHz */},
-	{ .frequency = 176900,	/* 176.9 MHz */},
-	{ .frequency = 191700,	/* 191.7 MHz */},
-	{ .frequency = 206400,	/* 206.4 MHz */},
-	{ .frequency = 221200,	/* 221.2 MHz */},
-	{ .frequency = 235900,	/* 235.9 MHz */},
-	{ .frequency = 250700,	/* 250.7 MHz */},
-	{ .frequency = 265400,	/* 265.4 MHz */},
-	{ .frequency = 280200,	/* 280.2 MHz */},
-	{ .frequency = CPUFREQ_TABLE_END, },
-};
-
-unsigned int sa11x0_getspeed(unsigned int cpu)
-{
-	if (cpu)
-		return 0;
-	return sa11x0_freq_table[PPCR & 0xf].frequency;
-}
-
 /*
  * Default power-off for SA1100
  */
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 158a4fd5ca24..cc891c57d306 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -4,7 +4,6 @@
  *
  * Author: Nicolas Pitre
  */
-#include <linux/cpufreq.h>
 #include <linux/reboot.h>
 
 extern void sa1100_timer_init(void);
@@ -21,9 +20,6 @@ extern void sa11x0_init_late(void);
 extern void sa1110_mb_enable(void);
 extern void sa1110_mb_disable(void);
 
-extern struct cpufreq_frequency_table sa11x0_freq_table[];
-extern unsigned int sa11x0_getspeed(unsigned int cpu);
-
 struct flash_platform_data;
 struct resource;
 
diff --git a/arch/arm/mach-sa1100/include/mach/generic.h b/arch/arm/mach-sa1100/include/mach/generic.h
deleted file mode 100644
index 665542e0c9e2..000000000000
--- a/arch/arm/mach-sa1100/include/mach/generic.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../generic.h"
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index bb7f591a8b05..ce636c1147a6 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -29,6 +29,38 @@
 
 #undef DEBUG
 
+#define NR_FREQS	16
+
+/*
+ * This table is setup for a 3.6864MHz Crystal.
+ */
+static struct cpufreq_frequency_table sa11x0_freq_table[NR_FREQS+1] = {
+	{ .frequency = 59000,	/*  59.0 MHz */},
+	{ .frequency = 73700,	/*  73.7 MHz */},
+	{ .frequency = 88500,	/*  88.5 MHz */},
+	{ .frequency = 103200,	/* 103.2 MHz */},
+	{ .frequency = 118000,	/* 118.0 MHz */},
+	{ .frequency = 132700,	/* 132.7 MHz */},
+	{ .frequency = 147500,	/* 147.5 MHz */},
+	{ .frequency = 162200,	/* 162.2 MHz */},
+	{ .frequency = 176900,	/* 176.9 MHz */},
+	{ .frequency = 191700,	/* 191.7 MHz */},
+	{ .frequency = 206400,	/* 206.4 MHz */},
+	{ .frequency = 221200,	/* 221.2 MHz */},
+	{ .frequency = 235900,	/* 235.9 MHz */},
+	{ .frequency = 250700,	/* 250.7 MHz */},
+	{ .frequency = 265400,	/* 265.4 MHz */},
+	{ .frequency = 280200,	/* 280.2 MHz */},
+	{ .frequency = CPUFREQ_TABLE_END, },
+};
+
+static unsigned int sa11x0_getspeed(unsigned int cpu)
+{
+	if (cpu)
+		return 0;
+	return sa11x0_freq_table[PPCR & 0xf].frequency;
+}
+
 struct sdram_params {
 	const char name[20];
 	u_char  rows;		/* bits				 */
-- 
2.29.2

