Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F96B1C40
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCIH2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCIH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:27:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02807DC3BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:27:28 -0800 (PST)
Date:   Thu, 9 Mar 2023 08:27:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678346846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xrMc8nS/afdgh6gNuFLpCc38mamPBkofjth4qTI6hP0=;
        b=bD3wC6HPU2sqGOyKRj3T8xblfHthFIn2+R9QIQOi6rVOP9E1eDxZTAZe3aGwZdVA3esrws
        dvchu+Fc5FvDIgcShDmdi1LwoBqrsxONJY+WKolOksJ8yyhODE/3+SGoZo3n0DllvCCvIx
        K91+YISck+4LFrWIxXzJy1oJAMn29p5dUH0MqGzAhaTDCl2gIrmQLnpJPZBGxHRHuqc4MB
        OsRHDbIcmLpKt7t2jLma1iE+nxzjPJRIJvb4KCoP9GfbsOadQl7aiT0M8qWaAArM4W6+7r
        rOQKjeATeCZoBQk5Xn1Uo7ugXEVPDkodJsB8TY77g184FxHxx5ZGbXURYtkoaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678346846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xrMc8nS/afdgh6gNuFLpCc38mamPBkofjth4qTI6hP0=;
        b=UwAVc7SBBnKFf8HGDVMxL4vLOjoj8WXKNjOEqjkXVgROsIH/BqcyWEe284mvM6s7/IZ08K
        JMbVPOodaYCmb6Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH RFC] preempt: Put preempt_enable() within an
 instrumentation*() section.
Message-ID: <20230309072724.3F6zRkvw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of preempt_enable() can be within an noinstr section leading to:
| vmlinux.o: warning: objtool: native_sched_clock+0x97: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
| vmlinux.o: warning: objtool: kvm_clock_read+0x22: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
| vmlinux.o: warning: objtool: local_clock+0xb4: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
| vmlinux.o: warning: objtool: enter_from_user_mode+0xea: call to preempt_schedule_thunk() leaves .noinstr.text section
| vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x140: call to preempt_schedule_thunk() leaves .noinstr.text section
| vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0xf2: call to preempt_schedule_thunk() leaves .noinstr.text section
| vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0xea: call to preempt_schedule_thunk() leaves .noinstr.text section

This only happens on CONFIG_PREEMPT+ due to the conditional call into the scheduler.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/preempt.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 12f59cdaaedda..05338f00a5907 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -238,15 +238,21 @@ do { \
 #define preempt_enable() \
 do { \
 	barrier(); \
-	if (unlikely(preempt_count_dec_and_test())) \
+	if (unlikely(preempt_count_dec_and_test())) { \
+		instrumentation_begin(); \
 		__preempt_schedule(); \
+		instrumentation_end(); \
+	} \
 } while (0)
 
 #define preempt_enable_notrace() \
 do { \
 	barrier(); \
-	if (unlikely(__preempt_count_dec_and_test())) \
+	if (unlikely(__preempt_count_dec_and_test())) { \
+		instrumentation_begin(); \
 		__preempt_schedule_notrace(); \
+		instrumentation_end(); \
+	} \
 } while (0)
 
 #define preempt_check_resched() \
-- 
2.39.2

