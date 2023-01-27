Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B546367E850
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjA0OcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjA0Ob7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:31:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083D5820FF;
        Fri, 27 Jan 2023 06:31:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B8E2F;
        Fri, 27 Jan 2023 06:32:37 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 148DA3F5A1;
        Fri, 27 Jan 2023 06:31:53 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, peterz@infradead.org,
        ravi.bangoria@amd.com
Cc:     James Clark <james.clark@arm.com>,
        syzbot+697196bc0265049822bd@syzkaller.appspotmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf: Fix warning from concurrent read/write of perf_event_pmu_context
Date:   Fri, 27 Jan 2023 14:31:41 +0000
Message-Id: <20230127143141.1782804-2-james.clark@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127143141.1782804-1-james.clark@arm.com>
References: <20230127143141.1782804-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running two Perf sessions, the following warning can appear:

  WARNING: CPU: 1 PID: 2245 at kernel/events/core.c:4925 put_pmu_ctx+0x1f0/0x278
  Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter bridge stp llc coresight_stm stm_core coresight_etm4x coresight_tmc coresight_replicator coresight_funnel coresight_tpiu coresight arm_spe_pmu ip_tables x_tables ipv6 xhci_pci xhci_pci_renesas r8169
  CPU: 1 PID: 2245 Comm: perf Not tainted 6.2.0-rc4+ #1
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : put_pmu_ctx+0x1f0/0x278
  lr : put_pmu_ctx+0x1b4/0x278
  sp : ffff80000dfcbc20
  x29: ffff80000dfcbca0 x28: ffff008004f00000 x27: ffff00800763a928
  x26: ffff00800763a928 x25: 00000000000000c0 x24: 0000000000000000
  x23: 00000000000a0003 x22: ffff00837df74088 x21: ffff80000dfcbd18
  x20: 0000000000000000 x19: ffff00800763a6c0 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
  x14: 0000000000000000 x13: ffff80000dfc8000 x12: ffff80000dfcc000
  x11: be58ab6d2939e700 x10: be58ab6d2939e700 x9 : 0000000000000000
  x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : ffff00800093c9c0 x4 : 0000000000000000 x3 : ffff80000dfcbca0
  x2 : ffff008004f00000 x1 : ffff8000082403c4 x0 : 0000000000000000
  Call trace:
   put_pmu_ctx+0x1f0/0x278
   _free_event+0x2bc/0x3d0
   perf_event_release_kernel+0x444/0x4bc
   perf_release+0x20/0x30
   __fput+0xe4/0x25c
   ____fput+0x1c/0x28
   task_work_run+0xc4/0xe8
   do_notify_resume+0x10c/0x164
   el0_svc+0xb4/0xdc
   el0t_64_sync_handler+0x84/0xf0
   el0t_64_sync+0x190/0x194

This is because there is no locking around the access of "if
(!epc->ctx)" in find_get_pmu_context() and when it is set to NULL in
put_pmu_ctx().

The decrement of the reference count in put_pmu_ctx() also happens
outside of the spinlock, leading to the possibility of this order of
events, and the context being cleared in put_pmu_ctx(), after its
refcount is non zero:

 CPU0                                   CPU1
 find_get_pmu_context()
   if (!epc->ctx) == false
                                        put_pmu_ctx()
                                        atomic_dec_and_test(&epc->refcount) == true
                                        epc->refcount == 0
     atomic_inc(&epc->refcount);
     epc->refcount == 1
                                        list_del_init(&epc->pmu_ctx_entry);
	                                      epc->ctx = NULL;

Another issue is that WARN_ON for no active PMU events in put_pmu_ctx()
is outside of the lock. If the perf_event_pmu_context is an embedded
one, even after clearing it, it won't be deleted and can be re-used. So
the warning can trigger. For this reason it also needs to be moved
inside the lock.

The above warning is very quick to trigger on Arm by running these two
commands at the same time:

  while true; do perf record -- ls; done
  while true; do perf record -- ls; done

Reported-by: syzbot+697196bc0265049822bd@syzkaller.appspotmail.com
Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: James Clark <james.clark@arm.com>
---
 kernel/events/core.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 380476a934e8..b11edb86d518 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4813,19 +4813,17 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 
 		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
 		epc = &cpc->epc;
-
+		raw_spin_lock_irq(&ctx->lock);
 		if (!epc->ctx) {
 			atomic_set(&epc->refcount, 1);
 			epc->embedded = 1;
-			raw_spin_lock_irq(&ctx->lock);
 			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
 			epc->ctx = ctx;
-			raw_spin_unlock_irq(&ctx->lock);
 		} else {
 			WARN_ON_ONCE(epc->ctx != ctx);
 			atomic_inc(&epc->refcount);
 		}
-
+		raw_spin_unlock_irq(&ctx->lock);
 		return epc;
 	}
 
@@ -4897,32 +4895,32 @@ static void free_epc_rcu(struct rcu_head *head)
 static void put_pmu_ctx(struct perf_event_pmu_context *epc)
 {
 	unsigned long flags;
+	struct perf_event_context *ctx = epc->ctx;
 
-	if (!atomic_dec_and_test(&epc->refcount))
+	/*
+	 * XXX
+	 *
+	 * lockdep_assert_held(&ctx->mutex);
+	 *
+	 * can't because of the call-site in _free_event()/put_event()
+	 * which isn't always called under ctx->mutex.
+	 */
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (!atomic_dec_and_test(&epc->refcount)) {
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 		return;
+	}
 
-	if (epc->ctx) {
-		struct perf_event_context *ctx = epc->ctx;
-
-		/*
-		 * XXX
-		 *
-		 * lockdep_assert_held(&ctx->mutex);
-		 *
-		 * can't because of the call-site in _free_event()/put_event()
-		 * which isn't always called under ctx->mutex.
-		 */
+	WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
 
-		WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
-		raw_spin_lock_irqsave(&ctx->lock, flags);
-		list_del_init(&epc->pmu_ctx_entry);
-		epc->ctx = NULL;
-		raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	}
+	list_del_init(&epc->pmu_ctx_entry);
+	epc->ctx = NULL;
 
 	WARN_ON_ONCE(!list_empty(&epc->pinned_active));
 	WARN_ON_ONCE(!list_empty(&epc->flexible_active));
 
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
 	if (epc->embedded)
 		return;
 
-- 
2.39.1

