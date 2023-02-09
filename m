Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FA69082C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBIMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBIMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:05:45 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AC518D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:55:19 -0800 (PST)
Received: from droid01-xa.amlogic.com (10.88.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 9 Feb 2023
 19:54:12 +0800
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] perf/amlogic: Fix large number of counter issue
Date:   Thu, 9 Feb 2023 19:54:02 +0800
Message-ID: <20230209115403.521868-2-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
References: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.88.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use 1ms interval, very large number of counter happens
once in a while as below:

25.968654513 281474976710655.84 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
26.118657346 281474976710655.88 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
26.180137180 281474976710655.66 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/

Root cause is the race between irq handler
and pmu.read callback. Use spin lock to protect the sw&hw
counters.

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index 0b24dee1ed3c..9b2e5d5c0626 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -14,6 +14,7 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/spinlock.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -23,6 +24,7 @@ struct ddr_pmu {
 	struct pmu pmu;
 	struct dmc_info info;
 	struct dmc_counter counters;	/* save counters from hw */
+	spinlock_t lock;		/* protect hw/sw counter */
 	bool pmu_enabled;
 	struct device *dev;
 	char *name;
@@ -92,10 +94,12 @@ static void meson_ddr_perf_event_update(struct perf_event *event)
 	int idx;
 	int chann_nr = pmu->info.hw_info->chann_nr;
 
+	spin_lock(&pmu->lock);
 	/* get the remain counters in register. */
 	pmu->info.hw_info->get_counters(&pmu->info, &dc);
 
 	ddr_cnt_addition(&sum_dc, &pmu->counters, &dc, chann_nr);
+	spin_unlock(&pmu->lock);
 
 	switch (event->attr.config) {
 	case ALL_CHAN_COUNTER_ID:
@@ -355,6 +359,7 @@ static irqreturn_t dmc_irq_handler(int irq, void *dev_id)
 
 	pmu = dmc_info_to_pmu(info);
 
+	spin_lock(&pmu->lock);
 	if (info->hw_info->irq_handler(info, &counters) != 0)
 		goto out;
 
@@ -372,6 +377,8 @@ static irqreturn_t dmc_irq_handler(int irq, void *dev_id)
 		 * it in ISR to support continue mode.
 		 */
 		info->hw_info->enable(info);
+out:
+	spin_unlock(&pmu->lock);
 
 	dev_dbg(pmu->dev, "counts: %llu %llu %llu, %llu, %llu, %llu\t\t"
 			"sum: %llu %llu %llu, %llu, %llu, %llu\n",
@@ -388,7 +395,7 @@ static irqreturn_t dmc_irq_handler(int irq, void *dev_id)
 			pmu->counters.channel_cnt[1],
 			pmu->counters.channel_cnt[2],
 			pmu->counters.channel_cnt[3]);
-out:
+
 	return IRQ_HANDLED;
 }
 
@@ -539,6 +546,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
 	pmu->name = name;
 	pmu->dev = &pdev->dev;
 	pmu->pmu_enabled = false;
+	spin_lock_init(&pmu->lock);
 
 	platform_set_drvdata(pdev, pmu);
 
-- 
2.25.1

