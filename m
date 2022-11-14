Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034B3628D78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiKNXex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiKNXer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:34:47 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95709FFE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37360a6236fso119574917b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cpwJSG+gvh3glc3dOQ38fZa92Ac/9klHHU5qKLkZb18=;
        b=PQQAi16C8zgDDM3/BCbQSjJbmg6i2opO9L5mutmTr5bbVZ711ZplobJtam0gZQjQ4f
         o3O/p2byD3ATBmFA2/YAK9RCKiKauwXMbhiGeBM4yHXoc2gFwo6UEulWtEXJpopa4OVW
         YKX9dG+9bq9TXT7mCYi0wrv3XZu7o/JOuACgZokxJO///AH/r+M9EFLJqZ4PsQNZzcko
         rrHgsvBdRIizwNrW8ySSaiiZR1FABWPDMIsduIaWUIsAH5frkfTCvwluU5lKUQlB/d6h
         AKfAHfnv5vjak1xWlJuvbk2/Ewy9Tvyu9M/8d40e03399V5kdTNF31UvUoROt8DkP9mt
         ZtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpwJSG+gvh3glc3dOQ38fZa92Ac/9klHHU5qKLkZb18=;
        b=7xyL/nXzKSzhB7uvYCqAiErdklhRIywE/JR2aYmGf2IHyCUyIAy+D6h8MFNb7S2Ye4
         xo5t95McHtjidmDVMxWrrQ7punYkO7tRru4DuhV3Sq+41Wpzpg1NE7HNeeZpXixuQ7Oo
         0LqSIZhcNoIoq/uLCXJTcxJ1l8gw6Z3kDxHut/WiAn0K1dKeQlxmSX7Jx4DwQ2f41niG
         oCM1PZzBmzwqoYJcNGZY6Dt+aGzDGRY+uADQRF6qHUNS1JbRjLSNxU2pyY8sSh8YJ1+I
         KmVWRi87j21u+QNBbHUgFW9pWugQOuq+vMxlrFBRriTCAU+j1XiK0Ws/oaa8eocM0ZH9
         NECA==
X-Gm-Message-State: ANoB5pmFpfj0rU0ZBP0g5IGGdd+rkEotgOtTN404rDFaRWjA9EAuJHPo
        iSx/8DTzZKFhr51BVao5/uENxQNg6xs=
X-Google-Smtp-Source: AA0mqf5b2zWAQcYts2VBnXk3WzAH3necLCIzPiQEe0f9zvwF3Fw4z4lRp3Yr1SowczEGJkmjpI0LdrI5yIY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d48c:0:b0:6dd:e9d:5365 with SMTP id
 m134-20020a25d48c000000b006dd0e9d5365mr14735431ybf.39.1668468885962; Mon, 14
 Nov 2022 15:34:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 14 Nov 2022 23:34:39 +0000
In-Reply-To: <20221114233441.3895891-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221114233441.3895891-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221114233441.3895891-2-seanjc@google.com>
Subject: [PATCH v3 1/3] x86/crash: Disable virt in core NMI crash handler to
 avoid double shootdown
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable virtualization in crash_nmi_callback() and rework the
emergency_vmx_disable_all() path to do an NMI shootdown if and only if a
shootdown has not already occurred.   NMI crash shootdown fundamentally
can't support multiple invocations as responding CPUs are deliberately
put into halt state without unblocking NMIs.  But, the emergency reboot
path doesn't have any work of its own, it simply cares about disabling
virtualization, i.e. so long as a shootdown occurred, emergency reboot
doesn't care who initiated the shootdown, or when.

If "crash_kexec_post_notifiers" is specified on the kernel command line,
panic() will invoke crash_smp_send_stop() and result in a second call to
nmi_shootdown_cpus() during native_machine_emergency_restart().

Invoke the callback _before_ disabling virtualization, as the current
VMCS needs to be cleared before doing VMXOFF.  Note, this results in a
subtle change in ordering between disabling virtualization and stopping
Intel PT on the responding CPUs.  While VMX and Intel PT do interact,
VMXOFF and writes to MSR_IA32_RTIT_CTL do not induce faults between one
another, which is all that matters when panicking.

Harden nmi_shootdown_cpus() against multiple invocations to try and
capture any such kernel bugs via a WARN instead of hanging the system
during a crash/dump, e.g. prior to the recent hardening of
register_nmi_handler(), re-registering the NMI handler would trigger a
double list_add() and hang the system if CONFIG_BUG_ON_DATA_CORRUPTION=y.

 list_add double add: new=ffffffff82220800, prev=ffffffff8221cfe8, next=ffffffff82220800.
 WARNING: CPU: 2 PID: 1319 at lib/list_debug.c:29 __list_add_valid+0x67/0x70
 Call Trace:
  __register_nmi_handler+0xcf/0x130
  nmi_shootdown_cpus+0x39/0x90
  native_machine_emergency_restart+0x1c9/0x1d0
  panic+0x237/0x29b

Extract the disabling logic to a common helper to deduplicate code, and
to prepare for doing the shootdown in the emergency reboot path if SVM
is supported.

Note, prior to commit ed72736183c4 ("x86/reboot: Force all cpus to exit
VMX root if VMX is supported"), nmi_shootdown_cpus() was subtly protected
against a second invocation by a cpu_vmx_enabled() check as the kdump
handler would disable VMX if it ran first.

Fixes: ed72736183c4 ("x86/reboot: Force all cpus to exit VMX root if VMX is supported)
Cc: stable@vger.kernel.org
Reported-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/all/20220427224924.592546-2-gpiccoli@igalia.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/x86/include/asm/reboot.h |  1 +
 arch/x86/kernel/crash.c       | 16 +--------
 arch/x86/kernel/reboot.c      | 66 ++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 04c17be9b5fd..8f2da36435a6 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,6 +25,7 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
+void cpu_crash_disable_virtualization(void);
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_panic_self_stop(struct pt_regs *regs);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..6257981ed837 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -81,15 +81,6 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	 */
 	cpu_crash_vmclear_loaded_vmcss();
 
-	/* Disable VMX or SVM if needed.
-	 *
-	 * We need to disable virtualization on all CPUs.
-	 * Having VMX or SVM enabled on any CPU may break rebooting
-	 * after the kdump kernel has finished its task.
-	 */
-	cpu_emergency_vmxoff();
-	cpu_emergency_svm_disable();
-
 	/*
 	 * Disable Intel PT to stop its logging
 	 */
@@ -148,12 +139,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	 */
 	cpu_crash_vmclear_loaded_vmcss();
 
-	/* Booting kdump kernel with VMX or SVM enabled won't work,
-	 * because (among other limitations) we can't disable paging
-	 * with the virt flags.
-	 */
-	cpu_emergency_vmxoff();
-	cpu_emergency_svm_disable();
+	cpu_crash_disable_virtualization();
 
 	/*
 	 * Disable Intel PT to stop its logging
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index c3636ea4aa71..f2655b78d73c 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -528,10 +528,7 @@ static inline void kb_wait(void)
 	}
 }
 
-static void vmxoff_nmi(int cpu, struct pt_regs *regs)
-{
-	cpu_emergency_vmxoff();
-}
+static inline void nmi_shootdown_cpus_on_restart(void);
 
 /* Use NMIs as IPIs to tell all CPUs to disable virtualization */
 static void emergency_vmx_disable_all(void)
@@ -554,7 +551,7 @@ static void emergency_vmx_disable_all(void)
 		__cpu_emergency_vmxoff();
 
 		/* Halt and exit VMX root operation on the other CPUs. */
-		nmi_shootdown_cpus(vmxoff_nmi);
+		nmi_shootdown_cpus_on_restart();
 	}
 }
 
@@ -802,6 +799,18 @@ static nmi_shootdown_cb shootdown_callback;
 static atomic_t waiting_for_crash_ipi;
 static int crash_ipi_issued;
 
+void cpu_crash_disable_virtualization(void)
+{
+	/*
+	 * Disable virtualization, i.e. VMX or SVM, so that INIT is recognized
+	 * during reboot.  VMX blocks INIT if the CPU is post-VMXON, and SVM
+	 * blocks INIT if GIF=0.  Note, STGI #UDs if SVM isn't enabled, so it's
+	 * easier to just disable SVM unconditionally.
+	 */
+	cpu_emergency_vmxoff();
+	cpu_emergency_svm_disable();
+}
+
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
 	int cpu;
@@ -817,7 +826,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 		return NMI_HANDLED;
 	local_irq_disable();
 
-	shootdown_callback(cpu, regs);
+	if (shootdown_callback)
+		shootdown_callback(cpu, regs);
+
+	/*
+	 * Prepare the CPU for reboot _after_ invoking the callback so that the
+	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
+	 */
+	cpu_crash_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -828,18 +844,32 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	return NMI_HANDLED;
 }
 
-/*
- * Halt all other CPUs, calling the specified function on each of them
+/**
+ * nmi_shootdown_cpus - Stop other CPUs via NMI
+ * @callback:	Optional callback to be invoked from the NMI handler
  *
- * This function can be used to halt all other CPUs on crash
- * or emergency reboot time. The function passed as parameter
- * will be called inside a NMI handler on all CPUs.
+ * The NMI handler on the remote CPUs invokes @callback, if not
+ * NULL, first and then disables virtualization to ensure that
+ * INIT is recognized during reboot.
+ *
+ * nmi_shootdown_cpus() can only be invoked once. After the first
+ * invocation all other CPUs are stuck in crash_nmi_callback() and
+ * cannot respond to a second NMI.
  */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	unsigned long msecs;
+
 	local_irq_disable();
 
+	/*
+	 * Avoid certain doom if a shootdown already occurred; re-registering
+	 * the NMI handler will cause list corruption, modifying the callback
+	 * will do who knows what, etc...
+	 */
+	if (WARN_ON_ONCE(crash_ipi_issued))
+		return;
+
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
 	crashing_cpu = safe_smp_processor_id();
 
@@ -867,7 +897,17 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 		msecs--;
 	}
 
-	/* Leave the nmi callback set */
+	/*
+	 * Leave the nmi callback set, shootdown is a one-time thing.  Clearing
+	 * the callback could result in a NULL pointer dereference if a CPU
+	 * (finally) responds after the timeout expires.
+	 */
+}
+
+static inline void nmi_shootdown_cpus_on_restart(void)
+{
+	if (!crash_ipi_issued)
+		nmi_shootdown_cpus(NULL);
 }
 
 /*
@@ -897,6 +937,8 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	/* No other CPUs to shoot down */
 }
 
+static inline void nmi_shootdown_cpus_on_restart(void) { }
+
 void run_crash_ipi_callback(struct pt_regs *regs)
 {
 }
-- 
2.38.1.431.g37b22c650d-goog

