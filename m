Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6F704899
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjEPJKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjEPJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9314C3A;
        Tue, 16 May 2023 02:09:59 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaAEyGO0rgfuaokk68q9BXMlN3wFzct5a6NYlMkV/4g=;
        b=ySgWkvWRcTFvvamV6M1cUk7cfsFZxN2hxwJB2yKKU4Tg4SrZJi1zp22ygPm8FaWywi1ymc
        jSBXbebYUY6jpJBqYtvkjJp10895arnX5EY+jNardihEEQXFD3X3IF5Z9X6XEw7JnH3nU/
        eP9lQselPzXx+m6K8BfRzrNk4Xy9lwUITFpEGPDNMoqPtkstgIIASqjsSkoC9Fg31bu7KN
        IxsW+TfuniwXJsyBfQ8RtSEcXQduuNxm0cTqVguVB7oTxTIX22oT59aMuFm+crS46ceW8J
        Vp0bkb89D+XhFLoUPYezobgMVl55AtZuOrPP6NRPOKN3dZ81bUBPLaImrKQRTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaAEyGO0rgfuaokk68q9BXMlN3wFzct5a6NYlMkV/4g=;
        b=7iVYgQ648mZADwqUvpxXePLNmviE4ELLXZ86SEiNbwpzLhxw4q7qh54QocXUEkoInuPn/C
        Fd+WW5XxcFYfKhBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Enable split CPU startup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205257.133453992@linutronix.de>
References: <20230512205257.133453992@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819524.404.15605450135439994513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     8b5a0f957cc5ca1f68486163d4da4683be3b47aa
Gitweb:        https://git.kernel.org/tip/8b5a0f957cc5ca1f68486163d4da4683be3b47aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:45:01 +02:00

x86/smpboot: Enable split CPU startup

The x86 CPU bringup state currently does AP wake-up, wait for AP to
respond and then release it for full bringup.

It is safe to be split into a wake-up and and a separate wait+release
state.

Provide the required functions and enable the split CPU bringup, which
prepares for parallel bringup, where the bringup of the non-boot CPUs takes
two iterations: One to prepare and wake all APs and the second to wait and
release them. Depending on timing this can eliminate the wait time
completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205257.133453992@linutronix.de
---
 arch/x86/Kconfig           |  2 +-
 arch/x86/include/asm/smp.h |  9 ++-------
 arch/x86/kernel/smp.c      |  2 +-
 arch/x86/kernel/smpboot.c  |  8 ++++----
 arch/x86/xen/smp_pv.c      |  4 ++--
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index adb1ec8..c140a73 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -274,8 +274,8 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
-	select HOTPLUG_CORE_SYNC_FULL		if SMP
 	select HOTPLUG_SMT			if SMP
+	select HOTPLUG_SPLIT_STARTUP		if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 693c999..726c2a2 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -40,7 +40,7 @@ struct smp_ops {
 
 	void (*cleanup_dead_cpu)(unsigned cpu);
 	void (*poll_sync_state)(void);
-	int (*cpu_up)(unsigned cpu, struct task_struct *tidle);
+	int (*kick_ap_alive)(unsigned cpu, struct task_struct *tidle);
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
@@ -80,11 +80,6 @@ static inline void smp_cpus_done(unsigned int max_cpus)
 	smp_ops.smp_cpus_done(max_cpus);
 }
 
-static inline int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-{
-	return smp_ops.cpu_up(cpu, tidle);
-}
-
 static inline int __cpu_disable(void)
 {
 	return smp_ops.cpu_disable();
@@ -124,7 +119,7 @@ void native_smp_prepare_cpus(unsigned int max_cpus);
 void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
 int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
-int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
+int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
 int native_cpu_disable(void);
 void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 4f6375b..0d54115 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -268,7 +268,7 @@ struct smp_ops smp_ops = {
 #endif
 	.smp_send_reschedule	= native_smp_send_reschedule,
 
-	.cpu_up			= native_cpu_up,
+	.kick_ap_alive		= native_kick_ap,
 	.cpu_disable		= native_cpu_disable,
 	.play_dead		= native_play_dead,
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5938641..a27941a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1052,7 +1052,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 	return ret;
 }
 
-static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
+int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
 	int apicid = apic->cpu_present_to_apicid(cpu);
 	int err;
@@ -1088,15 +1088,15 @@ static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 	return err;
 }
 
-int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
 {
-	return native_kick_ap(cpu, tidle);
+	return smp_ops.kick_ap_alive(cpu, tidle);
 }
 
 void arch_cpuhp_cleanup_kick_cpu(unsigned int cpu)
 {
 	/* Cleanup possible dangling ends... */
-	if (smp_ops.cpu_up == native_cpu_up && x86_platform.legacy.warm_reset)
+	if (smp_ops.kick_ap_alive == native_kick_ap && x86_platform.legacy.warm_reset)
 		smpboot_restore_warm_reset_vector();
 }
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index b089fb1..a92e800 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -314,7 +314,7 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
+static int xen_pv_kick_ap(unsigned int cpu, struct task_struct *idle)
 {
 	int rc;
 
@@ -438,7 +438,7 @@ static const struct smp_ops xen_smp_ops __initconst = {
 	.smp_prepare_cpus = xen_pv_smp_prepare_cpus,
 	.smp_cpus_done = xen_smp_cpus_done,
 
-	.cpu_up = xen_pv_cpu_up,
+	.kick_ap_alive = xen_pv_kick_ap,
 	.cpu_die = xen_pv_cpu_die,
 	.cleanup_dead_cpu = xen_pv_cleanup_dead_cpu,
 	.poll_sync_state = xen_pv_poll_sync_state,
