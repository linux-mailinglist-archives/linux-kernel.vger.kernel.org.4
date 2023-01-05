Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB965EB43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjAEM5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjAEM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704E5017D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672923406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hIc0vPvNI1VykGTxKET9i/kMr1uqEk68mXFfOdiRry8=;
        b=b63X5ef82Ne7rvWCJKbYJ6G5r8rK0A9jN4LP6vmchMg03NJNTP97JhZH1515paae4gurkZ
        5wEZ2yNiHSlWB1JUjGniwpbeWDy1kehLFnU9qFpDiluRaQZCbPA458hXwbF92sivkp2WTA
        VFToAYtLcoWE5cfz4HqXBWcTt2RjzFM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-weQCRA3ZMGSGIUvUlcJqnw-1; Thu, 05 Jan 2023 07:56:43 -0500
X-MC-Unique: weQCRA3ZMGSGIUvUlcJqnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B67B3C0F425;
        Thu,  5 Jan 2023 12:56:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D0340C1141;
        Thu,  5 Jan 2023 12:56:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 9F2C340502F3F; Thu,  5 Jan 2023 09:54:47 -0300 (-03)
Message-ID: <20230105125248.892336104@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 05 Jan 2023 09:52:22 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@atomlin.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v13 4/6] tick/nohz_full: Ensure quiet_vmstat() is called on exit to user-mode when the idle tick is stopped
References: <20230105125218.031928326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Tomlin <atomlin@atomlin.com>

For nohz full CPUs, we'd like the per-CPU vm statistics to be
synchronized when userspace is executing. Otherwise, the vmstat_shepherd
might queue a work item to synchronize them, which is undesired
intereference for isolated CPUs.

This patch syncs CPU-specific vmstat differentials, on return to
userspace, if CONFIG_FLUSH_WORK_ON_RESUME_USER is enabled and the tick
is stopped.

A trivial test program was used to determine the impact of the proposed
changes and under vanilla. The mlock(2) and munlock(2) system calls
was used solely to modify vmstat item 'NR_MLOCK'. The following is an
average count of CPU-cycles across the aforementioned system calls:

				  Vanilla                 Modified

  Cycles per syscall              8461                    8690    (+2.6%)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/tick.h     |    5 +++--
 kernel/time/tick-sched.c |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/tick.h
===================================================================
--- linux-2.6.orig/include/linux/tick.h
+++ linux-2.6/include/linux/tick.h
@@ -11,7 +11,6 @@
 #include <linux/context_tracking_state.h>
 #include <linux/cpumask.h>
 #include <linux/sched.h>
-#include <linux/rcupdate.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -272,6 +271,7 @@ static inline void tick_dep_clear_signal
 
 extern void tick_nohz_full_kick_cpu(int cpu);
 extern void __tick_nohz_task_switch(void);
+void __tick_nohz_user_enter_prepare(void);
 extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
@@ -296,6 +296,7 @@ static inline void tick_dep_clear_signal
 
 static inline void tick_nohz_full_kick_cpu(int cpu) { }
 static inline void __tick_nohz_task_switch(void) { }
+static inline void __tick_nohz_user_enter_prepare(void) { }
 static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
 #endif
 
@@ -308,7 +309,7 @@ static inline void tick_nohz_task_switch
 static inline void tick_nohz_user_enter_prepare(void)
 {
 	if (tick_nohz_full_cpu(smp_processor_id()))
-		rcu_nocb_flush_deferred_wakeup();
+		__tick_nohz_user_enter_prepare();
 }
 
 #endif
Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -26,6 +26,7 @@
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
 
 #include <asm/irq_regs.h>
 
@@ -519,6 +520,23 @@ void __tick_nohz_task_switch(void)
 	}
 }
 
+void __tick_nohz_user_enter_prepare(void)
+{
+	if (tick_nohz_full_cpu(smp_processor_id())) {
+		if (IS_ENABLED(CONFIG_FLUSH_WORK_ON_RESUME_USER)) {
+			struct tick_sched *ts;
+
+			ts = this_cpu_ptr(&tick_cpu_sched);
+
+			if (ts->tick_stopped)
+				quiet_vmstat(true);
+		}
+
+		rcu_nocb_flush_deferred_wakeup();
+	}
+}
+EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
+
 /* Get the boot-time nohz CPU list from the kernel parameters. */
 void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 {


