Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF05665C77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjAKNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjAKNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:24:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32C3883
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673443443; x=1704979443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kszyd7Hv0tB7dUw4wLUAy/XS4ksOrmCTMURWZ8B+Snc=;
  b=AVpoSwX0IuU7AN2fypET9xIzUc6PvYi9UcRlmdGGiyfCrREaesuDdWbE
   DVN4NR7nLJlDro3/R3lXFu4InN1BjGcmar2yS1aFwfLVxO9Xqtkma3e+F
   qXrUNgut5xz6ZMUuETP4MAbphLhYsm5UOj21m2mUbVK69Va18ShutJvqP
   zlDIHWVIdib0IL82hBZD0dTnNb8rKmjLGwsd7jZq152c6ay2IMIAhAgby
   +Hso9nFq2J2/HDB1tNbV0K6e9XcdtnT8ROUcRD7UknygG2oiUw7wI5XHO
   FEnoRgzhxvZIm3ZPcIoSwUxGsNLMb5/6Z9vyd0hkLckSricV04RyJgGQl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387872557"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="387872557"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:24:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687927441"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="687927441"
Received: from bachaue1-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.250])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:57 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5F5FA109CB6; Wed, 11 Jan 2023 15:37:41 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCHv14 09/17] mm: Expose untagging mask in /proc/$PID/status
Date:   Wed, 11 Jan 2023 15:37:28 +0300
Message-Id: <20230111123736.20025-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a line in /proc/$PID/status to report untag_mask. It can be
used to find out LAM status of the process from the outside. It is
useful for debuggers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/mmu_context.h    | 6 ++++++
 arch/sparc/include/asm/mmu_context_64.h | 6 ++++++
 arch/x86/include/asm/mmu_context.h      | 6 ++++++
 fs/proc/array.c                         | 6 ++++++
 include/linux/mmu_context.h             | 7 +++++++
 5 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 72dbd6400549..56911691bef0 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -288,6 +288,12 @@ void post_ttbr_update_workaround(void);
 unsigned long arm64_mm_context_get(struct mm_struct *mm);
 void arm64_mm_context_put(struct mm_struct *mm);
 
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return -1UL >> 8;
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 7a8380c63aab..799e797c5cdd 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -185,6 +185,12 @@ static inline void finish_arch_post_lock_switch(void)
 	}
 }
 
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+       return -1UL >> adi_nbits();
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* !(__ASSEMBLY__) */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 1d0b743daebb..4b77c96da07f 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -103,6 +103,12 @@ static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 	mm->context.untag_mask = oldmm->context.untag_mask;
 }
 
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return mm->context.untag_mask;
+}
+
 static inline void mm_reset_untag_mask(struct mm_struct *mm)
 {
 	mm->context.untag_mask = -1UL;
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b8103c7..d2a94eafe9a3 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -428,6 +428,11 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+static inline void task_untag_mask(struct seq_file *m, struct mm_struct *mm)
+{
+	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(mm));
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -443,6 +448,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 		task_mem(m, mm);
 		task_core_dumping(m, task);
 		task_thp_status(m, mm);
+		task_untag_mask(m, mm);
 		mmput(mm);
 	}
 	task_sig(m, task);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index b9b970f7ab45..14b9c1fa05c4 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -28,4 +28,11 @@ static inline void leave_mm(int cpu) { }
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
 
+#ifndef mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return -1UL;
+}
+#endif
+
 #endif
-- 
2.38.2

