Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DD673C37
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjASOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjASOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383D53564
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674139029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCuy74aeG96dFLNHaRy6nwMZ69wGMBkic+YQ3uKUql4=;
        b=dznpR5eGgSbNEQNQjjkVaVMuDG4MhxdM2K3Ny5dU8PN3hhX5pzUTF3cig8kFuE0vFXcgds
        0SmiwqKOrDJ052NDfDtkZu6gAsGu3E3IgvGLgmd/i5P05hT+Lgg6mbNXqXYGlOCtbmjdgZ
        4pnd/ZdBLo0xCz22bg+n+Ea1zmXdOII=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-kIncDfkdPyCPUZHWbJ4FXw-1; Thu, 19 Jan 2023 09:37:07 -0500
X-MC-Unique: kIncDfkdPyCPUZHWbJ4FXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D14801C0A597;
        Thu, 19 Jan 2023 14:37:05 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7418B2026D76;
        Thu, 19 Jan 2023 14:37:00 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 2/7] sched, smp: Trace IPIs sent via send_call_function_single_ipi()
Date:   Thu, 19 Jan 2023 14:36:14 +0000
Message-Id: <20230119143619.2733236-3-vschneid@redhat.com>
In-Reply-To: <20230119143619.2733236-1-vschneid@redhat.com>
References: <20230119143619.2733236-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

send_call_function_single_ipi() is the thing that sends IPIs at the bottom
of smp_call_function*() via either generic_exec_single() or
smp_call_function_many_cond(). Give it an IPI-related tracepoint.

Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/kernel/smp.c   | 3 ---
 arch/arm64/kernel/smp.c | 1 -
 kernel/sched/core.c     | 7 +++++--
 kernel/smp.c            | 4 ++++
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 36e6efad89f30..45b8ca2ce521f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -48,9 +48,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mpu.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/ipi.h>
-
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ffc5d76cf6955..937d2623e06ba 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -51,7 +51,6 @@
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bb1ee6d7bddea..c0d09eb249603 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -81,6 +81,7 @@
 #include <linux/sched/rseq_api.h>
 #include <trace/events/sched.h>
 #undef CREATE_TRACE_POINTS
+#include <trace/events/ipi.h>
 
 #include "sched.h"
 #include "stats.h"
@@ -3819,10 +3820,12 @@ void send_call_function_single_ipi(int cpu)
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
index 06a413987a14a..e2ca1e2f31274 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -26,6 +26,10 @@
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/ipi.h>
+#undef CREATE_TRACE_POINTS
+
 #include "smpboot.h"
 #include "sched/smp.h"
 
-- 
2.31.1

