Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FED638852
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKYLMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKYLL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:11:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A54B748;
        Fri, 25 Nov 2022 03:11:56 -0800 (PST)
Date:   Fri, 25 Nov 2022 11:11:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669374714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GXTS8DRABfEQqmVVAvJxRLFxj/iVN/fTNZe1cP1ll0Y=;
        b=nFqNQ+b/dgS+DTMpGP/f8hhZGVgXEIQakgwF9KdL+9HNoi7muYto7StT8TzFahNgKKzAOf
        3UgaBTtcgQ84bIGW5JUL2aOig686ewaGYh7GU8lB6MD6NKX9JBL91EyTtNHbs7viPTdMZy
        1ESGD1cxlXgooNKtro5CCeZnD1KjMI67nlEYKKqnmPkp02T04xpb/7m6dFs2K62TZIx4lo
        3VtE4KRO20FhYoJ4sAzh1N7RRoo5Ef2kA1dN30zu39DtoJVNtRp5ak3ZmB3GdMuTUh/Fuo
        cLwSKaxisGUV2/bRu8Al33MPiBYIjF4VJ47MoFaED1tjndj1wgS0stKn8GW13A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669374714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GXTS8DRABfEQqmVVAvJxRLFxj/iVN/fTNZe1cP1ll0Y=;
        b=8AWIyW2D9/cR8fo7uTc7zcYYc98UEdPBCl64Quqc45ffLQ1T6oFQ0KEli6cjXO+oEpAyho
        QA2GnCT3e8eTz/CQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Skip realmode init code when running as Xen
 PV guest
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123114523.3467-1-jgross@suse.com>
References: <20221123114523.3467-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166937470979.4906.10096767565105528046.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     f1e525009493cbd569e7c8dd7d58157855f8658d
Gitweb:        https://git.kernel.org/tip/f1e525009493cbd569e7c8dd7d58157855f8658d
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 23 Nov 2022 12:45:23 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 25 Nov 2022 12:05:22 +01:00

x86/boot: Skip realmode init code when running as Xen PV guest

When running as a Xen PV guest there is no need for setting up the
realmode trampoline, as realmode isn't supported in this environment.

Trying to setup the trampoline has been proven to be problematic in
some cases, especially when trying to debug early boot problems with
Xen requiring to keep the EFI boot-services memory mapped (some
firmware variants seem to claim basically all memory below 1Mb for boot
services).

Introduce new x86_platform_ops operations for that purpose, which can
be set to a NOP by the Xen PV specific kernel boot code.

  [ bp: s/call_init_real_mode/do_init_real_mode/ ]

Fixes: 084ee1c641a0 ("x86, realmode: Relocator for realmode code")
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221123114523.3467-1-jgross@suse.com
---
 arch/x86/include/asm/realmode.h | 1 +
 arch/x86/include/asm/x86_init.h | 4 ++++
 arch/x86/kernel/setup.c         | 2 +-
 arch/x86/kernel/x86_init.c      | 3 +++
 arch/x86/realmode/init.c        | 8 ++++++--
 arch/x86/xen/enlighten_pv.c     | 2 ++
 6 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index fd6f6e5..a336fee 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -91,6 +91,7 @@ static inline void set_real_mode_mem(phys_addr_t mem)
 
 void reserve_real_mode(void);
 void load_trampoline_pgtable(void);
+void init_real_mode(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index e917045..c1c8c58 100644
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
index 216fee7..892609c 100644
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
index 5735351..ef80d36 100644
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
index 41d7669..af56581 100644
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
 
+static int __init do_init_real_mode(void)
+{
+	x86_platform.realmode_init();
 	return 0;
 }
-early_initcall(init_real_mode);
+early_initcall(do_init_real_mode);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 038da45..8944726 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1266,6 +1266,8 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 	xen_vcpu_info_reset(0);
 
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
+	x86_platform.realmode_reserve = x86_init_noop;
+	x86_platform.realmode_init = x86_init_noop;
 
 	x86_init.resources.memory_setup = xen_memory_setup;
 	x86_init.irqs.intr_mode_select	= x86_init_noop;
