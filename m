Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8A5BD998
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiITBpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiITBpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:45:15 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36C0540BFC;
        Mon, 19 Sep 2022 18:45:12 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnbQwPGyljNLDDBg--.19579S2;
        Tue, 20 Sep 2022 09:44:53 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     peterz@infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V2] perf/x86/rapl: fix deadlock in rapl_pmu_event_stop
Date:   Tue, 20 Sep 2022 09:44:47 +0800
Message-Id: <20220920014447.71946-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnbQwPGyljNLDDBg--.19579S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47XryxCr4rWFW5WFyfWFg_yoW8AFWrpr
        WxAFy5tF1jv3Z2qayUK3WkXw4fua1kXanrJryfGw1rAan8Wan8J3W8WayFvF45JrZ7XasI
        yw10qrWrAFyDAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgkTAVZdtbikRgAHs6
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
raw_spin_lock_irqsave(). As a result, the rapl_hrtimer_handle()
could obtain the pmu->lock.

Fixes: 65661f96d3b3 ("perf/x86: Add RAPL hrtimer support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Move hrtimer_cancel() to the end of rapl_pmu_event_stop() function.

 arch/x86/events/rapl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5a..7c110092c83 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -281,8 +281,6 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		WARN_ON_ONCE(pmu->n_active <= 0);
 		pmu->n_active--;
-		if (pmu->n_active == 0)
-			hrtimer_cancel(&pmu->hrtimer);
 
 		list_del(&event->active_entry);
 
@@ -300,6 +298,11 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
+	if (!pmu->n_active) {
+		raw_spin_unlock_irqrestore(&pmu->lock, flags);
+		hrtimer_cancel(&pmu->hrtimer);
+		return;
+	}
 	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
-- 
2.17.1

