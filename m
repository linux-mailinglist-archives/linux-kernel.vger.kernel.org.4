Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE535BCBFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiISMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiISMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:37:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE6ABC88;
        Mon, 19 Sep 2022 05:37:57 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbwuHtKrlIzha+dJb+Dec4SeaSv72OIazrgTuiM1MCA=;
        b=ooKv9ji80asj0p5I5dNN4vkHoKx/XhN1plPxBSj9HjQa3RWc72fRyhu4jgKRZwuv9fG/lF
        Oaa5IkStm3s/lKclq9ArhtDdXqRmpdjSWZRp+NdnxBln4nk0End8VKeQFseCRc+awX2Ev1
        s4w9GtdxCvsIUGpRjC6pQtiNioGyhI6aHgmyWLvpIF6Zp60ofmxKWWijZ4gSkNrxEwYHw3
        Sk3lVUu8YIVcM7sik+8ICUb4rtqyGqHcfvRAZVSMdtxDpPnNjImMKBQ4zidqgKqaRGgw0m
        DLLMi2lg5iM+YR0HFiKzfrMyYGgwRFhVkuK+gVuAFXmw3u4aIei7Fgfb3t2XTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbwuHtKrlIzha+dJb+Dec4SeaSv72OIazrgTuiM1MCA=;
        b=0jaYHKmJNhcWfZ9Q3jMytiaAHDrJuhXM1bDOdqli5ER9LSo2/BCpXezq1iuksnFOvnrNvU
        a7i1e+lOiqw//OAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] mm/memcontrol: Replace the PREEMPT_RT conditionals
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-6-bigeasy@linutronix.de>
References: <20220825164131.402717-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107474.401.17555764326521072393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     e575d401583273a7ac5dfb27520e41c821e81816
Gitweb:        https://git.kernel.org/tip/e575d401583273a7ac5dfb27520e41c821e81816
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:08 +02:00

mm/memcontrol: Replace the PREEMPT_RT conditionals

Use VM_WARN_ON_IRQS_ENABLED() and preempt_disable/enable_nested() to
replace the CONFIG_PREEMPT_RT #ifdeffery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/r/20220825164131.402717-6-bigeasy@linutronix.de

---
 mm/memcontrol.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c..d35b6fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -597,25 +597,18 @@ static u64 flush_next_time;
  */
 static void memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#else
-      VM_BUG_ON(!irqs_disabled());
-#endif
+	preempt_disable_nested();
+	VM_WARN_ON_IRQS_ENABLED();
 }
 
 static void __memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#endif
+	preempt_disable_nested();
 }
 
 static void memcg_stats_unlock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_enable();
-#endif
+	preempt_enable_nested();
 }
 
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
@@ -715,7 +708,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	 * interrupt context while other caller need to have disabled interrupt.
 	 */
 	__memcg_stats_lock();
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
 		switch (idx) {
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
@@ -725,7 +718,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			WARN_ON_ONCE(!in_task());
 			break;
 		default:
-			WARN_ON_ONCE(!irqs_disabled());
+			VM_WARN_ON_IRQS_ENABLED();
 		}
 	}
 
