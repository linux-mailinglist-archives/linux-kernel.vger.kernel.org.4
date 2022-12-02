Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF87640618
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiLBLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLBLvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:51:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875761263D;
        Fri,  2 Dec 2022 03:51:01 -0800 (PST)
Date:   Fri, 02 Dec 2022 11:50:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669981860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJPbbV/zpHe91Hs8LO9dQsNTXAtCOPEdqFKM0wf62vE=;
        b=hn9TyCol/8xSXnxis+GNoyMdFxWsVr3XGOUiXVsir3kentPLhuV4yxzyZjv21yMnJdrygH
        J8MpAcBgdfRGjSYLTVCI6rF+lvsIlGzIPkIvpmzQ0N9ak+trvl9HATu+lJle8NcKBPwo+Y
        b9seOFOXOAITauFjDJxgGswpgYjxYlI5f5NPjP2wX8och23FOpKG3YahmXpeIFovNPSFRV
        jxLoJpYMTGqw0ihRYJhvpSUg7R1egAbXuZpWb/9nlsPAD/X4mpZstFWBNgc57w5KzplkPX
        SLimWda5SUtvPmfaZY7umQlCTMVyd3mxZs5P2iz5vwkV8beDAXXnABMKmLzmHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669981860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJPbbV/zpHe91Hs8LO9dQsNTXAtCOPEdqFKM0wf62vE=;
        b=XF7E50RxkKzSUJoQkRVnUDvvXVTVKzb77dXJqoa73boLsGKmBbEi8YVmHPbKJAMwuHXShh
        8AQgY3ymElj5LLDw==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Do not bail-out in DYING/STARTING sections
Cc:     Derek Dolney <z23@posteo.net>,
        Vincent Donnefort <vdonnefort@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220927101259.1149636-1-vdonnefort@google.com>
References: <20220927101259.1149636-1-vdonnefort@google.com>
MIME-Version: 1.0
Message-ID: <166998185857.4906.761294546367847039.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     6f855b39e4602b6b42a8e5cbcfefb8a1b8b5f0be
Gitweb:        https://git.kernel.org/tip/6f855b39e4602b6b42a8e5cbcfefb8a1b8b5f0be
Author:        Vincent Donnefort <vdonnefort@google.com>
AuthorDate:    Tue, 27 Sep 2022 11:12:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 12:43:02 +01:00

cpu/hotplug: Do not bail-out in DYING/STARTING sections

The DYING/STARTING callbacks are not expected to fail. However, as reported
by Derek, buggy drivers such as tboot are still free to return errors
within those sections, which halts the hot(un)plug and leaves the CPU in an
unrecoverable state.

As there is no rollback possible, only log the failures and proceed with
the following steps.

This restores the hotplug behaviour prior to commit 453e41085183
("cpu/hotplug: Add cpuhp_invoke_callback_range()")

Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
Reported-by: Derek Dolney <z23@posteo.net>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Derek Dolney <z23@posteo.net>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
Link: https://lore.kernel.org/r/20220927101259.1149636-1-vdonnefort@google.com

---
 kernel/cpu.c | 56 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3f704a8..6c0a92c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
 	return true;
 }
 
-static int cpuhp_invoke_callback_range(bool bringup,
-				       unsigned int cpu,
-				       struct cpuhp_cpu_state *st,
-				       enum cpuhp_state target)
+static int __cpuhp_invoke_callback_range(bool bringup,
+					 unsigned int cpu,
+					 struct cpuhp_cpu_state *st,
+					 enum cpuhp_state target,
+					 bool nofail)
 {
 	enum cpuhp_state state;
-	int err = 0;
+	int ret = 0;
 
 	while (cpuhp_next_state(bringup, &state, st, target)) {
+		int err;
+
 		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
-		if (err)
+		if (!err)
+			continue;
+
+		if (nofail) {
+			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
+				cpu, bringup ? "UP" : "DOWN",
+				cpuhp_get_step(st->state)->name,
+				st->state, err);
+			ret = -1;
+		} else {
+			ret = err;
 			break;
+		}
 	}
 
-	return err;
+	return ret;
+}
+
+static inline int cpuhp_invoke_callback_range(bool bringup,
+					      unsigned int cpu,
+					      struct cpuhp_cpu_state *st,
+					      enum cpuhp_state target)
+{
+	return __cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
+}
+
+static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
+						      unsigned int cpu,
+						      struct cpuhp_cpu_state *st,
+						      enum cpuhp_state target)
+{
+	__cpuhp_invoke_callback_range(bringup, cpu, st, target, true);
 }
 
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -999,7 +1029,6 @@ static int take_cpu_down(void *_param)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu = smp_processor_id();
-	int ret;
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
@@ -1012,13 +1041,10 @@ static int take_cpu_down(void *_param)
 	 */
 	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
 
-	/* Invoke the former CPU_DYING callbacks */
-	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
-
 	/*
-	 * DYING must not fail!
+	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
 
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
@@ -1296,16 +1322,14 @@ void notify_cpu_starting(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
-	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
-	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
 
 	/*
 	 * STARTING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
 }
 
 /*
