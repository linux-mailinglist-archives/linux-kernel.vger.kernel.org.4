Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7686CB985
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjC1IfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC1Iev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061335A1;
        Tue, 28 Mar 2023 01:34:50 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XO6hDe3Y+PUd7kKgZVf+zuUdDB4Cc0B8dXgM5NXPIE8=;
        b=q2YLWKQ46VYo26Ssu8LHoYac0li5Rdoiea3SNVfqg87HYZ8dHzrNszv6jTddEiGVYshkyT
        KZa91cRPSFoYCsUUPKImShjgkiyfHDnev0lrwMy7QyMZJU+HVFrgw+lYR+tlssf+P/mrbm
        no7SI7eWOM2FmXUF4nBWSgozQ1zO/z60F01vaeOdEKjwxD1AZpM4QfGD3V3UQAHY0YTNr8
        93MOaYtoB1/bjQPbE+HlclKy6IqF57SG2SPwgOIX1mMUqKXfzVo0gvPQUz7xK2iGaT6yus
        1ltF2vmCBZC9uLezmVbOCzsERB4gP4ktlFdeWFpr2Uzaf0bvVNryg0MTuGf4nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XO6hDe3Y+PUd7kKgZVf+zuUdDB4Cc0B8dXgM5NXPIE8=;
        b=g86gzRx3SGHd5mRdGuuMA7sa3P6INk8YJraspl7eCxcYWzNNTAxXvoVh1XTJJo7r124EuN
        KQYtSvligSxkVbCg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] sched, smp: Trace IPIs sent via
 send_call_function_single_ipi()
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307143558.294354-3-vschneid@redhat.com>
References: <20230307143558.294354-3-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <167999248631.5837.6674946507911418669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     cc9cb0a71725aa8dd8d8f534a9b562bbf7981f75
Gitweb:        https://git.kernel.org/tip/cc9cb0a71725aa8dd8d8f534a9b562bbf7981f75
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Tue, 07 Mar 2023 14:35:53 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:27 +01:00

sched, smp: Trace IPIs sent via send_call_function_single_ipi()

send_call_function_single_ipi() is the thing that sends IPIs at the bottom
of smp_call_function*() via either generic_exec_single() or
smp_call_function_many_cond(). Give it an IPI-related tracepoint.

Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230307143558.294354-3-vschneid@redhat.com
---
 arch/arm/kernel/smp.c   |  1 -
 arch/arm64/kernel/smp.c |  1 -
 kernel/sched/core.c     |  9 +++++++--
 kernel/smp.c            |  2 ++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0b8c257..5edf092 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -48,7 +48,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mpu.h>
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
 /*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4e83272..438c16f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -51,7 +51,6 @@
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 488655f..c26a2cd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -80,6 +80,7 @@
 #define CREATE_TRACE_POINTS
 #include <linux/sched/rseq_api.h>
 #include <trace/events/sched.h>
+#include <trace/events/ipi.h>
 #undef CREATE_TRACE_POINTS
 
 #include "sched.h"
@@ -95,6 +96,8 @@
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
+
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
@@ -3830,10 +3833,12 @@ void send_call_function_single_ipi(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (!set_nr_if_polling(rq->idle))
+	if (!set_nr_if_polling(rq->idle)) {
+		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
 		arch_send_call_function_single_ipi(cpu);
-	else
+	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
+	}
 }
 
 /*
diff --git a/kernel/smp.c b/kernel/smp.c
index 298ba75..770e879 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -26,6 +26,8 @@
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
 
+#include <trace/events/ipi.h>
+
 #include "smpboot.h"
 #include "sched/smp.h"
 
