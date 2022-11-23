Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA310635C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiKWLpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiKWLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:45:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B611255DB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:45:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48CE221F33;
        Wed, 23 Nov 2022 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669203925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AyhBQAsNxho2kk1GfKGx6zDLyWYyV1QLz+gDG7NJTZA=;
        b=Zkn7ZzDpoCCf/JgfLleT4uX7j1LVB22KCBz2YLwsoyCKxzEJYFLn6dS2KCoYG/ZDbmrWKd
        M6vUekyG/a2ld98xp97yxvtjLIwhLz4IRtOgVFz2nFKxZyiNNfQBdi3lyMXNpdB8zeg/Yc
        ejYMSHpqTF7xKsKSpz0Z4TJdktOrVNE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E31CB13A37;
        Wed, 23 Nov 2022 11:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6+UDNtQHfmPTUwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 23 Nov 2022 11:45:24 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v3] x86/boot: skip realmode init code when running as Xen PV guest
Date:   Wed, 23 Nov 2022 12:45:23 +0100
Message-Id: <20221123114523.3467-1-jgross@suse.com>
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

When running as a Xen PV guest there is no need for setting up the
realmode trampoline, as realmode isn't supported in this environment.

Trying to setup the trampoline has been proven to be problematic in
some cases, especially when trying to debug early boot problems with
Xen requiring to keep the EFI boot-services memory mapped (some
firmware variants seem to claim basically all memory below 1M for boot
services).

Introduce new x86_platform_ops operations for that purpose, which can
be set to a nop by the Xen PV specific kernel boot code.

Fixes: 084ee1c641a0 ("x86, realmode: Relocator for realmode code")
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- and yet another approach (H. Peter Anvin)
---
 arch/x86/include/asm/realmode.h | 1 +
 arch/x86/include/asm/x86_init.h | 4 ++++
 arch/x86/kernel/setup.c         | 2 +-
 arch/x86/kernel/x86_init.c      | 3 +++
 arch/x86/realmode/init.c        | 8 ++++++--
 arch/x86/xen/enlighten_pv.c     | 2 ++
 6 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index fd6f6e5b755a..a336feef0af1 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -91,6 +91,7 @@ static inline void set_real_mode_mem(phys_addr_t mem)
 
 void reserve_real_mode(void);
 void load_trampoline_pgtable(void);
+void init_real_mode(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index e9170457697e..c1c8c581759d 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -285,6 +285,8 @@ struct x86_hyper_runtime {
  * 				possible in x86_early_init_platform_quirks() by
  * 				only using the current x86_hardware_subarch
  * 				semantics.
+ * @realmode_reserve:		reserve memory for realmode trampoline
+ * @realmode_init:		initialize realmode trampoline
  * @hyper:			x86 hypervisor specific runtime callbacks
  */
 struct x86_platform_ops {
@@ -301,6 +303,8 @@ struct x86_platform_ops {
 	void (*apic_post_init)(void);
 	struct x86_legacy_features legacy;
 	void (*set_legacy_features)(void);
+	void (*realmode_reserve)(void);
+	void (*realmode_init)(void);
 	struct x86_hyper_runtime hyper;
 	struct x86_guest guest;
 };
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 216fee7144ee..892609cde4a2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1175,7 +1175,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Moreover, on machines with SandyBridge graphics or in setups that use
 	 * crashkernel the entire 1M is reserved anyway.
 	 */
-	reserve_real_mode();
+	x86_platform.realmode_reserve();
 
 	init_mem_mapping();
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 57353519bc11..ef80d361b463 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -25,6 +25,7 @@
 #include <asm/iommu.h>
 #include <asm/mach_traps.h>
 #include <asm/irqdomain.h>
+#include <asm/realmode.h>
 
 void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
@@ -145,6 +146,8 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.get_nmi_reason			= default_get_nmi_reason,
 	.save_sched_clock_state		= tsc_save_sched_clock_state,
 	.restore_sched_clock_state	= tsc_restore_sched_clock_state,
+	.realmode_reserve		= reserve_real_mode,
+	.realmode_init			= init_real_mode,
 	.hyper.pin_vcpu			= x86_op_int_noop,
 
 	.guest = {
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 41d7669a97ad..247aca9f8ed1 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -200,14 +200,18 @@ static void __init set_real_mode_permissions(void)
 	set_memory_x((unsigned long) text_start, text_size >> PAGE_SHIFT);
 }
 
-static int __init init_real_mode(void)
+void __init init_real_mode(void)
 {
 	if (!real_mode_header)
 		panic("Real mode trampoline was not allocated");
 
 	setup_real_mode();
 	set_real_mode_permissions();
+}
 
+static int __init call_init_real_mode(void)
+{
+	x86_platform.realmode_init();
 	return 0;
 }
-early_initcall(init_real_mode);
+early_initcall(call_init_real_mode);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 038da45f057a..8944726255c9 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1266,6 +1266,8 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 	xen_vcpu_info_reset(0);
 
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
+	x86_platform.realmode_reserve = x86_init_noop;
+	x86_platform.realmode_init = x86_init_noop;
 
 	x86_init.resources.memory_setup = xen_memory_setup;
 	x86_init.irqs.intr_mode_select	= x86_init_noop;
-- 
2.35.3

