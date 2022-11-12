Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE2626995
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKLNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 08:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLNXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 08:23:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E6DF96
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 05:23:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8FE111F890;
        Sat, 12 Nov 2022 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668259418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Lzs4s6ThfI/Cryj0DS92Vtk9nJ4GBe5JTPtbjjKk9HI=;
        b=dy+yrA7+wJLuK/hi2++hyzE90Av1bO8emPl4vdobeaup1lfBoKcNPnR5Xi/ex2wJE7jgwb
        ZiEDMqw8d340OavTInDgcs710dqR516tS0v76gSCQd1wuP51tcu+jb5beZkShn2qFuzoIj
        WvV38uMkQ0R6DiiV3RUYKd75TSHf3Kk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22A4C13A08;
        Sat, 12 Nov 2022 13:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bWkWB1qeb2MyGQAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 12 Nov 2022 13:23:38 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/xen: call xen_set_upcall_vector() only after local apic setup
Date:   Sat, 12 Nov 2022 14:23:36 +0100
Message-Id: <20221112132336.698-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling xen_set_upcall_vector() before the local APIC has been
initialized results in warnings when setting up the local APIC:

[    0.037322] APIC: Stale IRR: 00080000, ...

Avoid this problem by moving the call of xen_set_upcall_vector() for
APs from xen_cpu_up_prepare_hvm() to a new hotplug callback called on
the AP before interrupts are enabled and after the local APIC has been
initialized. There is already a Xen specific hotplug state defined at
a matching position, but right now it is specific to Arm. So rename
the CPUHP_AP_ARM_XEN_STARTING to CPUHP_AP_XEN_STARTING and use it for
x86, too.

On the boot processor use the x86_init.irqs.intr_mode_init hook to
call xen_set_upcall_vector() only after the local APIC initialization.
As interrupts are on already at the time when the hook is being used,
modify xen_init_setup_upcall_vector() to disable interrupts. This is
needed as the xen_percpu_upcall flag is set only after the callback
has been registered, and the flag is needed for correctly acknowledging
an interrupt.

Fixes: b1c3497e604d ("x86/xen: Add support for HVMOP_set_evtchn_upcall_vector")
Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/arm/xen/enlighten.c         |  4 ++--
 arch/x86/xen/enlighten_hvm.c     |  9 ---------
 drivers/xen/events/events_base.c | 22 +++++++++++++++++-----
 include/linux/cpuhotplug.h       |  2 +-
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 93c8ccbf2982..1778a7a7c3ed 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -529,8 +529,8 @@ static int __init xen_guest_init(void)
 	if (xen_initial_domain())
 		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
 
-	return cpuhp_setup_state(CPUHP_AP_ARM_XEN_STARTING,
-				 "arm/xen:starting", xen_starting_cpu,
+	return cpuhp_setup_state(CPUHP_AP_XEN_STARTING,
+				 "xen:starting", xen_starting_cpu,
 				 xen_dying_cpu);
 }
 early_initcall(xen_guest_init);
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index c1cd28e915a3..55d140cc6128 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -177,15 +177,6 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	if (!xen_have_vector_callback)
 		return 0;
 
-	if (xen_percpu_upcall) {
-		rc = xen_set_upcall_vector(cpu);
-		if (rc) {
-			WARN(1, "HVMOP_set_evtchn_upcall_vector"
-			     " for CPU %d failed: %d\n", cpu, rc);
-			return rc;
-		}
-	}
-
 	if (xen_feature(XENFEAT_hvm_safe_pvclock))
 		xen_setup_timer(cpu);
 
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c443f04aaad7..7609fedb2a33 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -39,6 +39,7 @@
 #include <linux/ktime.h>
 
 #ifdef CONFIG_X86
+#include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/ptrace.h>
 #include <asm/idtentry.h>
@@ -2209,16 +2210,27 @@ void xen_setup_callback_vector(void)
  */
 static __init void xen_init_setup_upcall_vector(void)
 {
+	unsigned long flags;
+
+	apic_intr_mode_init();
+
 	if (!xen_have_vector_callback)
 		return;
 
+	local_irq_save(flags);
+
 	if ((cpuid_eax(xen_cpuid_base() + 4) & XEN_HVM_CPUID_UPCALL_VECTOR) &&
-	    !xen_set_upcall_vector(0))
+	    !xen_set_upcall_vector(0)) {
 		xen_percpu_upcall = true;
+		WARN_ON(cpuhp_setup_state(CPUHP_AP_XEN_STARTING, "xen:starting",
+					  xen_set_upcall_vector, NULL));
+	}
 	else if (xen_feature(XENFEAT_hvm_callback_vector))
 		xen_setup_callback_vector();
 	else
 		xen_have_vector_callback = false;
+
+	local_irq_restore(flags);
 }
 
 int xen_set_upcall_vector(unsigned int cpu)
@@ -2250,9 +2262,7 @@ static __init void xen_alloc_callback_vector(void)
 }
 #else
 void xen_setup_callback_vector(void) {}
-static inline void xen_init_setup_upcall_vector(void) {}
 int xen_set_upcall_vector(unsigned int cpu) {}
-static inline void xen_alloc_callback_vector(void) {}
 #endif /* CONFIG_XEN_PVHVM */
 #endif /* CONFIG_X86 */
 
@@ -2314,9 +2324,11 @@ void __init xen_init_IRQ(void)
 		if (xen_initial_domain())
 			pci_xen_initial_domain();
 	}
-	xen_init_setup_upcall_vector();
-	xen_alloc_callback_vector();
 
+#ifdef CONFIG_XEN_PVHVM
+	x86_init.irqs.intr_mode_init = xen_init_setup_upcall_vector;
+	xen_alloc_callback_vector();
+#endif
 
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f61447913db9..c232ada4e4ca 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -191,7 +191,7 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ARM_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
-	CPUHP_AP_ARM_XEN_STARTING,
+	CPUHP_AP_XEN_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
-- 
2.35.3

