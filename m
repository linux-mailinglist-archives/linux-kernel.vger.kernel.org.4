Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4D60C089
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiJYBJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJYBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:08:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEACCDDB57
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666657064; x=1698193064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cE/mAE1tS/HlPb0lkn7x72bPiGqyAx36Rg2eRUbRk1w=;
  b=GCd+NOTJmuHOK+H4BE76tybIFTZ4VNGhk31FRZD/qRsJOSprOTqxuuNd
   YZ5z/I0Sf1sbI50dj6nxHdYAiJ8l1gZzn2bmn0Wm5lgNwfc7OjufOhr1u
   YeUfVlLBBSQPHL2MCQCYCmed/gW7v2mh8EzSMNWPiakQ/BHES5GMcTaGJ
   Lt+L1DEVSzocF5w/UhFLUKvSy+94rA57uOxSxTOTA4CaaKLn6PNpMpigp
   2pj7sFhWtITL6btrfT1G4ZUSn7SuP7al5lFwUeIvxZwvpaFkBrKRgF2ym
   wkFhIxwe1v/vZofsnyUnsdixxF8qreyYk7OTwTetVa3DoHdPyspTLyl3c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334143878"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="334143878"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631447761"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="631447761"
Received: from ghoyler-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.118])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:35 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 066701095BE; Tue, 25 Oct 2022 03:17:26 +0300 (+03)
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
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCHv11 09/16] mm: Expose untagging mask in /proc/$PID/status
Date:   Tue, 25 Oct 2022 03:17:15 +0300
Message-Id: <20221025001722.17466-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a line in /proc/$PID/status to report untag_mask. It can be
used to find out LAM status of the process from the outside. It is
useful for debuggers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h    | 6 ++++++
 arch/sparc/include/asm/mmu_context_64.h | 6 ++++++
 arch/x86/include/asm/mmu_context.h      | 6 ++++++
 fs/proc/array.c                         | 6 ++++++
 include/linux/mmu_context.h             | 7 +++++++
 5 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index d3f8b5df0c1f..81ac12d69795 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -278,6 +278,12 @@ void post_ttbr_update_workaround(void);
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
index 5bd3d46685dc..84277547ad28 100644
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
2.38.0

