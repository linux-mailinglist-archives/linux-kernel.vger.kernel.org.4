Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069D36B656E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCLL1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCLL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:27:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFB52F78
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620435; x=1710156435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dORBfkbxhzi1hEEMwZ37gZ5mNHOdLznvEXqItjRFy7I=;
  b=eww8sX4S44/68TdF8QPGmaDF3L4OCHtSSV8foOx0eVm8KatkwFcXRkRw
   MO0s5BTHvo/R8SInWBqkUvJWGzQjmT1XHEbn5Vtbq2gauld1B288bTu9+
   mdy9xKhc4K1IHdWiZx00hg+w00a/9mKA+O+0pD3nGh5XkR2XjaIvUnePf
   v6oM9fGykTKM0MOeKvnWLNdiHfWX+IqX1DYK6iJxfwKmNq51xSFEaGoAN
   exlw/nZP1Z/bAK2Z2pDNnWEZ35BZU8+voT4hQrjfTaVNCicGyo9w03LTo
   gDaLHoh7tKdITz7oo7HIBwre6L/nTYxb+CK9zvH7/8TRjVukGKL/fxWqU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="399577585"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="399577585"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="671580737"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="671580737"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id AF00310D7B7; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
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
Subject: [PATCHv16 09/17] mm: Expose untagging mask in /proc/$PID/status
Date:   Sun, 12 Mar 2023 14:26:04 +0300
Message-Id: <20230312112612.31869-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
---
 arch/arm64/include/asm/mmu_context.h    | 6 ++++++
 arch/sparc/include/asm/mmu_context_64.h | 6 ++++++
 arch/x86/include/asm/mmu_context.h      | 6 ++++++
 fs/proc/array.c                         | 7 +++++++
 include/linux/mmu_context.h             | 7 +++++++
 5 files changed, 32 insertions(+)

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
index eb1387ac40fa..06eaaf75d572 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -104,6 +104,12 @@ static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
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
index 9b0315d34c58..6daea628bc76 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -91,6 +91,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
 #include <linux/kthread.h>
+#include <linux/mmu_context.h>
 
 #include <asm/processor.h>
 #include "internal.h"
@@ -423,6 +424,11 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
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
@@ -438,6 +444,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
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
2.39.2

