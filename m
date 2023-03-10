Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4606B5202
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCJUeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjCJUeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:34:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DB193DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02067CE2AE5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED33AC433A4;
        Fri, 10 Mar 2023 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678480310;
        bh=CBHxIGuSYu6bJMUaDANXQBrNAVJXopMpEyLRVtQvHW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZZW+prDIBIphH77NQg7znMT6xO5n8NcyL301B8iRCfMSHxgDQLBzPrTIPiysU9fJ
         nPoQJYHSg/1tJvVZDThgzkyj2+NExjlNBs3ynkvPBLJ11VYGq8RBrCy9CXS+F34qES
         2xe8is378eqqLV3cw5orfQwAQH/29Xw5GdVtY0dIUpbq8gmlNCLWtE4Ms2uDMWLL6X
         gP6XJ64yfwD+/BZ4PGe/i2+1IHaqCB8G7vPXGLCssJ3AtmkG8h1aSbGZPEfGJ+LGDh
         FW6DRm/l0CajzEGLcLwN75HZwDWa+EdTm1+dGRQNaNYWpxHjbOSgNnSYGkWKYLuRsZ
         49hXhqt6gJwxg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC][PATCH 4/5] static_call: Remove DEFINE_STATIC_CALL_RET0() and its uses
Date:   Fri, 10 Mar 2023 12:31:16 -0800
Message-Id: <82391676fd575d7123899d0dc44dcc07fe2ca2f7.1678474914.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678474914.git.jpoimboe@kernel.org>
References: <cover.1678474914.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_STATIC_CALL_RET0() is now identical to DEFINE_STATIC_CALL_NULL().
All static calls to NULL function pointers are actually calls to "do
nothing return 0" functions.

Replace all DEFINE_STATIC_CALL_RET0() usages and remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/powerpc/kernel/irq.c   |  2 +-
 arch/x86/events/amd/core.c  |  2 +-
 arch/x86/events/core.c      |  2 +-
 include/linux/static_call.h |  7 -------
 kernel/events/core.c        |  8 ++++----
 kernel/sched/core.c         | 10 +++++-----
 6 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index c9535f2760b5..320e1a41abd6 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -220,7 +220,7 @@ static __always_inline void call_do_softirq(const void *sp)
 }
 #endif
 
-DEFINE_STATIC_CALL_RET0(ppc_get_irq, *ppc_md.get_irq);
+DEFINE_STATIC_CALL_NULL(ppc_get_irq, *ppc_md.get_irq);
 
 static void __do_irq(struct pt_regs *regs, unsigned long oldsp)
 {
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8c45b198b62f..3c545595bfeb 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -330,7 +330,7 @@ static inline bool amd_is_pair_event_code(struct hw_perf_event *hwc)
 	}
 }
 
-DEFINE_STATIC_CALL_RET0(amd_pmu_branch_hw_config, *x86_pmu.hw_config);
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_hw_config, *x86_pmu.hw_config);
 
 static int amd_core_hw_config(struct perf_event *event)
 {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c94537501091..3f662c16aa08 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -96,7 +96,7 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
  */
-DEFINE_STATIC_CALL_RET0(x86_pmu_guest_get_msrs, *x86_pmu.guest_get_msrs);
+DEFINE_STATIC_CALL_NULL(x86_pmu_guest_get_msrs, *x86_pmu.guest_get_msrs);
 
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3b3e9e9a1582..6b8d7b687c13 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -17,7 +17,6 @@
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL_NULL(name, typename);
- *   DEFINE_STATIC_CALL_RET0(name, typename);
  *
  *   __static_call_return0;
  *
@@ -171,8 +170,6 @@ extern int static_call_text_reserved(void *start, void *end);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
-#define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
-
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -206,8 +203,6 @@ static inline int static_call_init(void) { return 0; }
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
-
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
@@ -251,8 +246,6 @@ static inline int static_call_init(void) { return 0; }
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
 
-#define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
-
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..42017f696e2e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6757,9 +6757,9 @@ static void perf_pending_task(struct callback_head *head)
 #ifdef CONFIG_GUEST_PERF_EVENTS
 struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
-DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
-DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
-DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
+DEFINE_STATIC_CALL_NULL(__perf_guest_state, *perf_guest_cbs->state);
+DEFINE_STATIC_CALL_NULL(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
+DEFINE_STATIC_CALL_NULL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
 
 void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
@@ -13766,4 +13766,4 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
 };
 #endif /* CONFIG_CGROUP_PERF */
 
-DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
+DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e038b48..cf50562277b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8492,12 +8492,12 @@ EXPORT_SYMBOL(__cond_resched);
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define cond_resched_dynamic_enabled	__cond_resched
 #define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
-DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
+DEFINE_STATIC_CALL_NULL(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
 #define might_resched_dynamic_enabled	__cond_resched
 #define might_resched_dynamic_disabled	((void *)&__static_call_return0)
-DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
+DEFINE_STATIC_CALL_NULL(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
@@ -8598,7 +8598,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *
  * NONE:
  *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
+ *   might_resched              <- NULL
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
@@ -8611,8 +8611,8 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   irqentry_exit_cond_resched <- NOP
  *
  * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
+ *   cond_resched               <- NULL
+ *   might_resched              <- NULL
  *   preempt_schedule           <- preempt_schedule
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
-- 
2.39.2

