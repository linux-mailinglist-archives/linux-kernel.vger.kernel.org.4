Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C65BB8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIQOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:48:12 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D43E230F53;
        Sat, 17 Sep 2022 07:48:08 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app3 (Coremail) with SMTP id cC_KCgBXz6oC3iVjOZWXBg--.23155S2;
        Sat, 17 Sep 2022 22:47:40 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] perf/x86/rapl: fix deadlock in rapl_pmu_event_stop
Date:   Sat, 17 Sep 2022 22:47:29 +0800
Message-Id: <20220917144729.118500-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBXz6oC3iVjOZWXBg--.23155S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47XryxCr4rWFW5WFyfWFg_yoW8ur13pr
        WxAFy3tF18uw10qayUK3WkXrW7Zw4kGwsxJw4fGw1rAanxWws8J3Z7GayF9a15ArWfWr9x
        Aw10vryrAFWDAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgEQAVZdtbgTUQADsV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock in rapl_pmu_event_stop(), the process is
shown below:

    (thread 1)                 |        (thread 2)
rapl_pmu_event_stop()          | rapl_hrtimer_handle()
 ...                           |  if (!pmu->n_active)
 raw_spin_lock_irqsave() //(1) |  ...
  ...                          |
  hrtimer_cancel()             |  raw_spin_lock_irqsave() //(2)
  (block forever)

We hold pmu->lock in position (1) and use hrtimer_cancel() to wait
rapl_hrtimer_handle() to stop, but rapl_hrtimer_handle() also need
pmu->lock in position (2). As a result, the rapl_pmu_event_stop()
will be blocked forever.

This patch extracts hrtimer_cancel() from the protection of
raw_spin_lock_irqsave(). As a result, the rapl_hrtimer_handle() could
obtain the pmu->lock. In order to prevent race conditions, we put
"if (!pmu->n_active)" in rapl_hrtimer_handle() under the protection
of raw_spin_lock_irqsave().

Fixes: 65661f96d3b3 ("perf/x86: Add RAPL hrtimer support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 arch/x86/events/rapl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5a..97c71538d01 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -219,11 +219,11 @@ static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 	struct perf_event *event;
 	unsigned long flags;
 
+	raw_spin_lock_irqsave(&pmu->lock, flags);
+
 	if (!pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-
 	list_for_each_entry(event, &pmu->active_list, active_entry)
 		rapl_event_update(event);
 
@@ -281,8 +281,11 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		WARN_ON_ONCE(pmu->n_active <= 0);
 		pmu->n_active--;
-		if (pmu->n_active == 0)
+		if (!pmu->n_active) {
+			raw_spin_unlock_irqrestore(&pmu->lock, flags);
 			hrtimer_cancel(&pmu->hrtimer);
+			raw_spin_lock_irqsave(&pmu->lock, flags);
+		}
 
 		list_del(&event->active_entry);
 
-- 
2.17.1

