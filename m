Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0403644A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiLFRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiLFRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A732BB1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670347197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VGIeQOlE+MYPS8fgyARv+ctXmXZ7yTcBqE/3ohwUXpU=;
        b=Q5MpW6eLK+FghqUABD3yqcXryjvhJPKp0Zmjcm34OG/4qjLOii73PwigEyRzRS79/2rc5k
        B+1iYKJDQrXi2/nqZZ0SD/IBr+W9ErnQrua/rA5g9jQnFvOqem4HVX6LMjQfDhW8xaRkBz
        OuoBFj/5oZEbbv5JJwCUxhNAR+vzYuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-ug--dlF1N-qCeDY4p4auHQ-1; Tue, 06 Dec 2022 12:19:42 -0500
X-MC-Unique: ug--dlF1N-qCeDY4p4auHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F23088646B;
        Tue,  6 Dec 2022 17:19:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB1F4C15BA4;
        Tue,  6 Dec 2022 17:19:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id D1D4B409005E1; Tue,  6 Dec 2022 13:31:40 -0300 (-03)
Message-ID: <20221206162416.509808578@redhat.com>
User-Agent: quilt/0.66
Date:   Tue, 06 Dec 2022 13:18:30 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v9 4/5] tick/nohz_full: Ensure quiet_vmstat() is called on exit to user-mode when the idle tick is stopped
References: <20221206161826.698593151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Tomlin <atomlin@redhat.com>

This patch ensures CPU-specific vmstat differentials do not remain
when the scheduling-tick is stopped and before exiting to user-mode
in the context of nohz_full only.

A trivial test program was used to determine the impact of the proposed
changes and under vanilla. The mlock(2) and munlock(2) system calls was
used solely to modify vmstat item 'NR_MLOCK'. The following is an average
count of CPU-cycles across the aforementioned system calls:

				  Vanilla                 Modified

  Cycles per syscall              8461                    8690    (+2.6%)

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
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
 
@@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
 	}
 }
 
+void __tick_nohz_user_enter_prepare(void)
+{
+	struct tick_sched *ts;
+
+	if (tick_nohz_full_cpu(smp_processor_id())) {
+		ts = this_cpu_ptr(&tick_cpu_sched);
+
+		if (ts->tick_stopped)
+			quiet_vmstat(true);
+		rcu_nocb_flush_deferred_wakeup();
+	}
+}
+EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
+
 /* Get the boot-time nohz CPU list from the kernel parameters. */
 void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 {


