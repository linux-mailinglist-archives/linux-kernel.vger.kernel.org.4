Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3597971FCA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjFBIwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjFBIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:51:52 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B310DB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:51:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by xavier.telenet-ops.be with bizsmtp
        id 48qo2A0061tRZS8018qoDG; Fri, 02 Jun 2023 10:51:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50UO-00BhYG-TJ;
        Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50Ui-00APxY-0T;
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
Subject: [PATCH v3 3/7] clk: renesas: cpg-mssr: Convert to readl_poll_timeout_atomic()
Date:   Fri,  2 Jun 2023 10:50:38 +0200
Message-Id: <832d29fd9aa3239ea949535309d2bdb003d40c9e.1685692810.git.geert+renesas@glider.be>
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

As typically no retries are needed, 10 µs is a suitable timeout value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Polling measurements done on R-Car M2-W, H3 ES2.0, M3-W, M3-N, E3, and
V4H.

v3:
  - New.
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 31 +++++++++-----------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index e9c0e341380e8f55..2772499d20165127 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -196,8 +197,8 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	struct device *dev = priv->dev;
 	u32 bitmask = BIT(bit);
 	unsigned long flags;
-	unsigned int i;
 	u32 value;
+	int error;
 
 	dev_dbg(dev, "MSTP %u%02u/%pC %s\n", reg, bit, hw->clk,
 		enable ? "ON" : "OFF");
@@ -228,19 +229,13 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	if (!enable || priv->reg_layout == CLK_REG_LAYOUT_RZ_A)
 		return 0;
 
-	for (i = 1000; i > 0; --i) {
-		if (!(readl(priv->base + priv->status_regs[reg]) & bitmask))
-			break;
-		cpu_relax();
-	}
-
-	if (!i) {
+	error = readl_poll_timeout_atomic(priv->base + priv->status_regs[reg],
+					  value, !(value & bitmask), 0, 10);
+	if (error)
 		dev_err(dev, "Failed to enable SMSTP %p[%d]\n",
 			priv->base + priv->control_regs[reg], bit);
-		return -ETIMEDOUT;
-	}
 
-	return 0;
+	return error;
 }
 
 static int cpg_mstp_clock_enable(struct clk_hw *hw)
@@ -896,8 +891,9 @@ static int cpg_mssr_suspend_noirq(struct device *dev)
 static int cpg_mssr_resume_noirq(struct device *dev)
 {
 	struct cpg_mssr_priv *priv = dev_get_drvdata(dev);
-	unsigned int reg, i;
+	unsigned int reg;
 	u32 mask, oldval, newval;
+	int error;
 
 	/* This is the best we can do to check for the presence of PSCI */
 	if (!psci_ops.cpu_suspend)
@@ -935,14 +931,9 @@ static int cpg_mssr_resume_noirq(struct device *dev)
 		if (!mask)
 			continue;
 
-		for (i = 1000; i > 0; --i) {
-			oldval = readl(priv->base + priv->status_regs[reg]);
-			if (!(oldval & mask))
-				break;
-			cpu_relax();
-		}
-
-		if (!i)
+		error = readl_poll_timeout_atomic(priv->base + priv->status_regs[reg],
+						oldval, !(oldval & mask), 0, 10);
+		if (error)
 			dev_warn(dev, "Failed to enable SMSTP%u[0x%x]\n", reg,
 				 oldval & mask);
 	}
-- 
2.34.1

