Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7329B70E701
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjEWU5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjEWU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE0FE54
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F18796366A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAB8C433EF;
        Tue, 23 May 2023 20:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684875429;
        bh=VDaXY9Z26DgqTQfA7kdWz2RLA0Qbr8V8gDzJu6fxAGE=;
        h=From:To:Cc:Subject:Date:From;
        b=NdF7czWO5Ya8oF7Qy46hT26QDGGQDjALDUg69WYCsXtnkaxipvAViOFpyY2QsLJ+0
         6MEaVIbsEaQJaK4TJDtQulv94/YeKuKLvuww1qNDq2gP1NPAYFauQNzAjhTNkPVUzf
         V44Hi/SXNNJPxg2tpMCYUHWJvxWjhcOTq6utvKbvJEoqLoRFlr24ONC7GJe8taKJjm
         6MiIw2IhCyvbYBqjy59HghYmcVsbUvyVGQU/sWjm34lzYGDNW8q/8/kigq0SgWxJAT
         rk2CduI212QtBRPBC2otAcr12GCESPO1ahrnrtK4SN8J2eJRWky1ZbU8j/9YlQpEqt
         EmBhEuL4buyuA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] x86: xen: add missing prototypes
Date:   Tue, 23 May 2023 22:56:46 +0200
Message-Id: <20230523205703.2116910-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These function are all called from assembler files, or from inline assembler,
so there is no immediate need for a prototype in a header, but if -Wmissing-prototypes
is enabled, the compiler warns about them:

arch/x86/xen/efi.c:130:13: error: no previous prototype for 'xen_efi_init' [-Werror=missing-prototypes]
arch/x86/platform/pvh/enlighten.c:120:13: error: no previous prototype for 'xen_prepare_pvh' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:358:20: error: no previous prototype for 'xen_pte_val' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:366:20: error: no previous prototype for 'xen_pgd_val' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:372:17: error: no previous prototype for 'xen_make_pte' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:380:17: error: no previous prototype for 'xen_make_pgd' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:387:20: error: no previous prototype for 'xen_pmd_val' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:425:17: error: no previous prototype for 'xen_make_pmd' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:432:20: error: no previous prototype for 'xen_pud_val' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:438:17: error: no previous prototype for 'xen_make_pud' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:522:20: error: no previous prototype for 'xen_p4d_val' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:528:17: error: no previous prototype for 'xen_make_p4d' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:1442:17: error: no previous prototype for 'xen_make_pte_init' [-Werror=missing-prototypes]
arch/x86/xen/enlighten_pv.c:1233:34: error: no previous prototype for 'xen_start_kernel' [-Werror=missing-prototypes]
arch/x86/xen/irq.c:22:14: error: no previous prototype for 'xen_force_evtchn_callback' [-Werror=missing-prototypes]
arch/x86/entry/common.c:302:24: error: no previous prototype for 'xen_pv_evtchn_do_upcall' [-Werror=missing-prototypes]

Declare all of them in an appropriate header file to avoid the warnings.
For consistency, also move the asm_cpu_bringup_and_idle() declaration out of
smp_pv.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: move declations of conditional function in an #ifdef with a stub
v2: fix up changelog
---
 arch/x86/xen/efi.c     |  2 ++
 arch/x86/xen/smp.h     | 11 +++++++++++
 arch/x86/xen/smp_pv.c  |  1 -
 arch/x86/xen/xen-ops.h | 26 ++++++++++++++++++++++++++
 include/xen/xen.h      |  3 +++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 7d7ffb9c826a..863d0d6b3edc 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -16,6 +16,8 @@
 #include <asm/setup.h>
 #include <asm/xen/hypercall.h>
 
+#include "xen-ops.h"
+
 static efi_char16_t vendor[100] __initdata;
 
 static efi_system_table_t efi_systab_xen __initdata = {
diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
index 22fb982ff971..9367502281dc 100644
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -2,6 +2,10 @@
 #ifndef _XEN_SMP_H
 
 #ifdef CONFIG_SMP
+
+void asm_cpu_bringup_and_idle(void);
+asmlinkage void cpu_bringup_and_idle(void);
+
 extern void xen_send_IPI_mask(const struct cpumask *mask,
 			      int vector);
 extern void xen_send_IPI_mask_allbutself(const struct cpumask *mask,
@@ -29,6 +33,13 @@ struct xen_common_irq {
 };
 #else /* CONFIG_SMP */
 
+static inline void asm_cpu_bringup_and_idle(void)
+{
+}
+static inline void cpu_bringup_and_idle(void)
+{
+}
+
 static inline int xen_smp_intr_init(unsigned int cpu)
 {
 	return 0;
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a92e8002b5cf..d5ae5de2daa2 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -55,7 +55,6 @@ static DEFINE_PER_CPU(struct xen_common_irq, xen_irq_work) = { .irq = -1 };
 static DEFINE_PER_CPU(struct xen_common_irq, xen_pmu_irq) = { .irq = -1 };
 
 static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id);
-void asm_cpu_bringup_and_idle(void);
 
 static void cpu_bringup(void)
 {
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 6d7f6318fc07..eb4cb30570c7 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -146,12 +146,38 @@ int xen_cpuhp_setup(int (*cpu_up_prepare_cb)(unsigned int),
 void xen_pin_vcpu(int cpu);
 
 void xen_emergency_restart(void);
+void xen_force_evtchn_callback(void);
+
 #ifdef CONFIG_XEN_PV
 void xen_pv_pre_suspend(void);
 void xen_pv_post_suspend(int suspend_cancelled);
+pteval_t xen_pte_val(pte_t pte);
+pgdval_t xen_pgd_val(pgd_t pgd);
+pmdval_t xen_pmd_val(pmd_t pmd);
+pudval_t xen_pud_val(pud_t pud);
+p4dval_t xen_p4d_val(p4d_t p4d);
+pte_t xen_make_pte(pteval_t pte);
+pgd_t xen_make_pgd(pgdval_t pgd);
+pmd_t xen_make_pmd(pmdval_t pmd);
+pud_t xen_make_pud(pudval_t pud);
+p4d_t xen_make_p4d(p4dval_t p4d);
+pte_t xen_make_pte_init(pteval_t pte);
+void xen_start_kernel(struct start_info *si);
 #else
 static inline void xen_pv_pre_suspend(void) {}
 static inline void xen_pv_post_suspend(int suspend_cancelled) {}
+static inline pteval_t xen_pte_val(pte_t pte)	{ return pte.pte; }
+static inline pgdval_t xen_pgd_val(pgd_t pgd)	{ return pgd.pgd; }
+static inline pmdval_t xen_pmd_val(pmd_t pmd)	{ return pmd.pmd; }
+static inline pudval_t xen_pud_val(pud_t pud)	{ return pud.pud; }
+static inline p4dval_t xen_p4d_val(p4d_t p4d)	{ return p4d.p4d; }
+static inline pte_t xen_make_pte(pteval_t pte)	{ return (pte_t){pte}; }
+static inline pgd_t xen_make_pgd(pgdval_t pgd)	{ return (pgd_t){pgd}; }
+static inline pmd_t xen_make_pmd(pmdval_t pmd)	{ return (pmd_t){pmd}; }
+static inline pud_t xen_make_pud(pudval_t pud)	{ return (pud_t){pud}; }
+static inline p4d_t xen_make_p4d(p4dval_t p4d)	{ return (p4d_t){p4d}; }
+static inline pte_t xen_make_pte_init(pteval_t pte)	{ return (pte_t){pte}; }
+static inline void xen_start_kernel(struct start_info *si) {}
 #endif
 
 #ifdef CONFIG_XEN_PVHVM
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0efeb652f9b8..f989162983c3 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -31,6 +31,9 @@ extern uint32_t xen_start_flags;
 
 #include <xen/interface/hvm/start_info.h>
 extern struct hvm_start_info pvh_start_info;
+void xen_prepare_pvh(void);
+struct pt_regs;
+void xen_pv_evtchn_do_upcall(struct pt_regs *regs);
 
 #ifdef CONFIG_XEN_DOM0
 #include <xen/interface/xen.h>
-- 
2.39.2

