Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AF71FCA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjFBIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjFBIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:51:54 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2231728
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:51:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by andre.telenet-ops.be with bizsmtp
        id 48qo2A00L1tRZS8018qoWZ; Fri, 02 Jun 2023 10:51:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50UO-00BhYR-Vj;
        Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50Ui-00APxl-2q;
        Fri, 02 Jun 2023 10:50:48 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 6/7] soc: renesas: rmobile-sysc: Convert to readl_poll_timeout_atomic()
Date:   Fri,  2 Jun 2023 10:50:41 +0200
Message-Id: <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1685692810.git.geert+renesas@glider.be>
References: <cover.1685692810.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use readl_poll_timeout_atomic() instead of open-coding the same
operation.

  1. rmobile_pd_power_down(): as typically less than 20 retries are
     needed, PSTR_RETRIES (100) µs is a suitable timeout value.

  2. __rmobile_pd_power_up(): the old method of first polling some
     cycles with a 1 µs delay, followed by more polling cycles without
     any delay didn't make much sense, as the latter was insignificant
     compared to the former.  Furthermore, typically no retries are
     needed.  Hence just retain the polling with delay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Polling measurements done on R-Mobile APE6 and A1, and SH-Mobile AG5.

v3:
  - New.
---
 drivers/soc/renesas/rmobile-sysc.c | 31 ++++++++++--------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
index 728ebac98e14a5cc..5d621c35fba1116a 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -12,6 +12,8 @@
 #include <linux/clk/renesas.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pm.h>
@@ -19,8 +21,6 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 
-#include <asm/io.h>
-
 /* SYSC */
 #define SPDCR		0x08	/* SYS Power Down Control Register */
 #define SWUCR		0x14	/* SYS Wakeup Control Register */
@@ -47,6 +47,7 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
 	unsigned int mask = BIT(rmobile_pd->bit_shift);
+	u32 val;
 
 	if (rmobile_pd->suspend) {
 		int ret = rmobile_pd->suspend();
@@ -56,14 +57,10 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 	}
 
 	if (readl(rmobile_pd->base + PSTR) & mask) {
-		unsigned int retry_count;
 		writel(mask, rmobile_pd->base + SPDCR);
 
-		for (retry_count = PSTR_RETRIES; retry_count; retry_count--) {
-			if (!(readl(rmobile_pd->base + SPDCR) & mask))
-				break;
-			cpu_relax();
-		}
+		readl_poll_timeout_atomic(rmobile_pd->base + SPDCR, val,
+					  !(val & mask), 0, PSTR_RETRIES);
 	}
 
 	pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n", genpd->name, mask,
@@ -74,25 +71,17 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 
 static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
 {
-	unsigned int mask = BIT(rmobile_pd->bit_shift);
-	unsigned int retry_count;
-	int ret = 0;
+	unsigned int val, mask = BIT(rmobile_pd->bit_shift);
+	int ret;
 
 	if (readl(rmobile_pd->base + PSTR) & mask)
 		return ret;
 
 	writel(mask, rmobile_pd->base + SWUCR);
 
-	for (retry_count = 2 * PSTR_RETRIES; retry_count; retry_count--) {
-		if (!(readl(rmobile_pd->base + SWUCR) & mask))
-			break;
-		if (retry_count > PSTR_RETRIES)
-			udelay(PSTR_DELAY_US);
-		else
-			cpu_relax();
-	}
-	if (!retry_count)
-		ret = -EIO;
+	ret = readl_poll_timeout_atomic(rmobile_pd->base + SWUCR, val,
+					(val & mask), PSTR_DELAY_US,
+					PSTR_RETRIES * PSTR_DELAY_US);
 
 	pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
 		 rmobile_pd->genpd.name, mask,
-- 
2.34.1

