Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE84665C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjAKNZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjAKNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:24:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF32BE8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673443440; x=1704979440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOPc1Ih/L2zXkoODIOcmvuNWh1/N6FlnZJa49Np69gU=;
  b=dHLiQl2q2+gnDrHk+kIybhYO6U1lb350dRSvE0mv/vgY/oajkyp47yIC
   Pm9C6NoBh7bGrctmFrJ7H9KUiEkrNrgRCTY0b5Yvn4d5WaBmDc7or5OIu
   MRFxv8xTEoymAGlRux1e24OQVJpkm6eA/7bztzA1ewtB35KplnW1VtOMz
   OawHzvUmyLaBLZBz2o6u0aJA4KVaFk2JW+gAgz9fKWEMzYrkRM5rfDNEF
   treLI3LRNdA4UsYOjJK2qdK42s+s5AzUO92Tgyoqt30/pU//gGU2MdO9G
   r5MTaxD3YTltzRc/CAiJWkWlFWDlsASw3O0nbflsIo62S3iGvL6hTNx5X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324646101"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324646101"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720725483"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720725483"
Received: from bachaue1-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.250])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:49 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 133EB109C7C; Wed, 11 Jan 2023 15:37:41 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv14 02/17] x86: Allow atomic MM_CONTEXT flags setting
Date:   Wed, 11 Jan 2023 15:37:21 +0300
Message-Id: <20230111123736.20025-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far there's no need in atomic setting of MM context flags in
mm_context_t::flags. The flags set early in exec and never change
after that.

LAM enabling requires atomic flag setting. The upcoming flag
MM_CONTEXT_FORCE_TAGGED_SVA can be set much later in the process
lifetime where multiple threads exist.

Convert the field to unsigned long and do MM_CONTEXT_* accesses with
__set_bit() and test_bit().

No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/include/asm/mmu.h            | 6 +++---
 arch/x86/include/asm/mmu_context.h    | 2 +-
 arch/x86/kernel/process_64.c          | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4af81df133ee..aa226f451c52 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -317,7 +317,7 @@ static struct vm_area_struct gate_vma __ro_after_init = {
 struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 #ifdef CONFIG_COMPAT
-	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
+	if (!mm || !test_bit(MM_CONTEXT_HAS_VSYSCALL, &mm->context.flags))
 		return NULL;
 #endif
 	if (vsyscall_mode == NONE)
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..efa3eaee522c 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -9,9 +9,9 @@
 #include <linux/bits.h>
 
 /* Uprobes on this MM assume 32-bit code */
-#define MM_CONTEXT_UPROBE_IA32	BIT(0)
+#define MM_CONTEXT_UPROBE_IA32		0
 /* vsyscall page is accessible on this MM */
-#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
+#define MM_CONTEXT_HAS_VSYSCALL		1
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
@@ -39,7 +39,7 @@ typedef struct {
 #endif
 
 #ifdef CONFIG_X86_64
-	unsigned short flags;
+	unsigned long flags;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..53ef591a6166 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -181,7 +181,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 static inline bool is_64bit_mm(struct mm_struct *mm)
 {
 	return	!IS_ENABLED(CONFIG_IA32_EMULATION) ||
-		!(mm->context.flags & MM_CONTEXT_UPROBE_IA32);
+		!test_bit(MM_CONTEXT_UPROBE_IA32, &mm->context.flags);
 }
 #else
 static inline bool is_64bit_mm(struct mm_struct *mm)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4e34b3b68ebd..8b06034e8c70 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -671,7 +671,7 @@ void set_personality_64bit(void)
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
 	if (current->mm)
-		current->mm->context.flags = MM_CONTEXT_HAS_VSYSCALL;
+		__set_bit(MM_CONTEXT_HAS_VSYSCALL, &current->mm->context.flags);
 
 	/* TBD: overwrites user setup. Should have two bits.
 	   But 64bit processes have always behaved this way,
@@ -708,7 +708,7 @@ static void __set_personality_ia32(void)
 		 * uprobes applied to this MM need to know this and
 		 * cannot use user_64bit_mode() at that time.
 		 */
-		current->mm->context.flags = MM_CONTEXT_UPROBE_IA32;
+		__set_bit(MM_CONTEXT_UPROBE_IA32, &current->mm->context.flags);
 	}
 
 	current->personality |= force_personality32;
-- 
2.38.2

