Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5035BFD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIUMOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIUMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:14:01 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8DFF95AD3;
        Wed, 21 Sep 2022 05:13:59 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app3 (Coremail) with SMTP id cC_KCgB3Xajs_ypjJ5XdBg--.55807S2;
        Wed, 21 Sep 2022 20:13:39 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     peterz@infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V3] perf/x86/rapl: fix deadlock in rapl_pmu_event_stop
Date:   Wed, 21 Sep 2022 20:13:32 +0800
Message-Id: <20220921121332.24363-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgB3Xajs_ypjJ5XdBg--.55807S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47XryxCr4rWFW5WFyfWFg_yoW8tF4Upr
        WxAryaqr1jv3ZFqay8t3WkXrW3Zan7GanxJw4fGw1rA3ZxWan5ta1xGayF9FW3AF93X3sa
        yw10qrWrAFZrZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg4AAVZdtbktIAAEsD
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

This patch uses hrtimer_try_to_cancel() to replace hrtimer_cancel()
and moves the check "if (!pmu->n_active)" into the protection scope
of pmu->lock. If the timer callback function is running, the
hrtimer_try_to_cancel() will directly return. After the
rapl_pmu_event_stop() has finished, the "pmu->n_active" equals to 0
and the rapl_hrtimer_handle() will return "HRTIMER_NORESTART".

Fixes: 65661f96d3b3 ("perf/x86: Add RAPL hrtimer support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in V3:
  - Use hrtimer_try_to_cancel() to replace hrtimer_cancel().
  - Use pmu->lock to protect the check "if (!pmu->n_active)".

 arch/x86/events/rapl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5a..a526a08ee6e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -219,11 +219,13 @@ static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 	struct perf_event *event;
 	unsigned long flags;
 
-	if (!pmu->n_active)
-		return HRTIMER_NORESTART;
-
 	raw_spin_lock_irqsave(&pmu->lock, flags);
 
+	if (!pmu->n_active) {
+		raw_spin_unlock_irqrestore(&pmu->lock, flags);
+		return HRTIMER_NORESTART;
+	}
+
 	list_for_each_entry(event, &pmu->active_list, active_entry)
 		rapl_event_update(event);
 
@@ -282,7 +284,7 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		WARN_ON_ONCE(pmu->n_active <= 0);
 		pmu->n_active--;
 		if (pmu->n_active == 0)
-			hrtimer_cancel(&pmu->hrtimer);
+			hrtimer_try_to_cancel(&pmu->hrtimer);
 
 		list_del(&event->active_entry);
 
-- 
2.17.1

