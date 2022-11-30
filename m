Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D979E63D990
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiK3PhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK3Pgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:36:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7FA51C43D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:36:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30EE4D6E;
        Wed, 30 Nov 2022 07:36:52 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C77E33F67D;
        Wed, 30 Nov 2022 07:36:44 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geoff Blake <blakgeof@amazon.com>
Subject: [PATCH 1/2] perf/arm-cmn: Cope with spurious IRQs better
Date:   Wed, 30 Nov 2022 15:36:38 +0000
Message-Id: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we reset the CMN state during probe before requesting our
interrupt(s), a pending IRQ could already have been latched at the
interrupt controller, and thus be delivered spuriously as soon as the
IRQ is enabled. Not handling that can then lead to the IRQ layer
disabling it again, and things subseuqently going wonky.

Since we can't support shared IRQs anyway for affinity-management
reasons, the only time we should concievably return IRQ_NONE is for a
spurious interrupt which did somehow originate from our CMN, so there
should be no harm in removing the problem by simply claiming to have
handled those as well.

Reported-by: Geoff Blake <blakgeof@amazon.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b80a9b74662b..9e8be5586423 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1798,7 +1798,6 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
 static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 {
 	struct arm_cmn_dtc *dtc = dev_id;
-	irqreturn_t ret = IRQ_NONE;
 
 	for (;;) {
 		u32 status = readl_relaxed(dtc->base + CMN_DT_PMOVSR);
@@ -1807,7 +1806,6 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 
 		for (i = 0; i < CMN_DTM_NUM_COUNTERS; i++) {
 			if (status & (1U << i)) {
-				ret = IRQ_HANDLED;
 				if (WARN_ON(!dtc->counters[i]))
 					continue;
 				delta = (u64)arm_cmn_read_counter(dtc, i) << 16;
@@ -1816,7 +1814,6 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 		}
 
 		if (status & (1U << CMN_DT_NUM_COUNTERS)) {
-			ret = IRQ_HANDLED;
 			if (dtc->cc_active && !WARN_ON(!dtc->cycles)) {
 				delta = arm_cmn_read_cc(dtc);
 				local64_add(delta, &dtc->cycles->count);
@@ -1826,7 +1823,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 		writel_relaxed(status, dtc->base + CMN_DT_PMOVSR_CLR);
 
 		if (!dtc->irq_friend)
-			return ret;
+			return IRQ_HANDLED;
 		dtc += dtc->irq_friend;
 	}
 }
-- 
2.36.1.dirty

