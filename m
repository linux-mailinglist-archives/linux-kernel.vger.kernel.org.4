Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418F71FCA3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjFBIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjFBIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:51:54 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEBC1729
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:51:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by andre.telenet-ops.be with bizsmtp
        id 48qo2A00F1tRZS8018qoWX; Fri, 02 Jun 2023 10:51:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50UO-00BhYI-U1;
        Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50Ui-00APxd-1F;
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
Subject: [PATCH v3 4/7] clk: renesas: mstp: Convert to readl_poll_timeout_atomic()
Date:   Fri,  2 Jun 2023 10:50:39 +0200
Message-Id: <bce7d0bdd80c800aa150f1868b610b7d94f4cc66.1685692810.git.geert+renesas@glider.be>
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
Polling measurements done on R-Mobile APE6 and A1, R-Car H1, and
SH-Mobile AG5.

v3:
  - New.
---
 drivers/clk/renesas/clk-mstp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 6e3c4a9c16b07ae9..e96457371b4cce88 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -14,6 +14,7 @@
 #include <linux/clk/renesas.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pm_clock.h>
@@ -78,8 +79,8 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	struct mstp_clock_group *group = clock->group;
 	u32 bitmask = BIT(clock->bit_index);
 	unsigned long flags;
-	unsigned int i;
 	u32 value;
+	int ret;
 
 	spin_lock_irqsave(&group->lock, flags);
 
@@ -102,19 +103,14 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	if (!enable || !group->mstpsr)
 		return 0;
 
-	for (i = 1000; i > 0; --i) {
-		if (!(cpg_mstp_read(group, group->mstpsr) & bitmask))
-			break;
-		cpu_relax();
-	}
-
-	if (!i) {
+	/* group->width_8bit is always false if group->mstpsr is present */
+	ret = readl_poll_timeout_atomic(group->mstpsr, value,
+					!(value & bitmask), 0, 10);
+	if (ret)
 		pr_err("%s: failed to enable %p[%d]\n", __func__,
 		       group->smstpcr, clock->bit_index);
-		return -ETIMEDOUT;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int cpg_mstp_clock_enable(struct clk_hw *hw)
-- 
2.34.1

