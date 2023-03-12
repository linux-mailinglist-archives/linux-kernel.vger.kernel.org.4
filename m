Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC56B6560
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCLL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCLL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:26:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF3311F9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620390; x=1710156390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tV3JtlGM60BECBxuCA+QuZaWNCs779YV6vXF0y1DbTc=;
  b=kRkElrl/fgyh1CaTLusht2vr3WZocR+/mg3gY1ktpPBIKLhArbfxF3F1
   mZfYXpUBsw8ToHzUs1YOjg3yD1+2zg6mNfl+sxzeeI5P+iZZHIo1OD+V3
   aWh8+vM913A2iY5pMcyQdYYnTa0M83nCXKbQwO7JlVRx1IvrNLrvNTyQo
   AOIl7BWGLrSdIg/Ztm+9wbghM8EOdBb5OPIt9SKsRSCnL3RNkrOC2wOPH
   WKp5s7s5YCz6sxLhpnpkYbNtnbW++FqQmqOv4Bm04fo93C3aWbaQ1fa1D
   1WyLchopSDK0ZlFMIajD8f/YsqB9xiYThdg1rnJBxaI9mNYAEcBLfKEK+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="339349931"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="339349931"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="852438015"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="852438015"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:22 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6695310D7B0; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
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
Subject: [PATCHv16 02/17] x86: Allow atomic MM_CONTEXT flags setting
Date:   Sun, 12 Mar 2023 14:25:57 +0300
Message-Id: <20230312112612.31869-3-kirill.shutemov@linux.intel.com>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/include/asm/mmu.h            | 6 +++---
 arch/x86/include/asm/mmu_context.h    | 2 +-
 arch/x86/kernel/process_64.c          | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index d234ca797e4a..e0ca8120aea8 100644
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
index e01aa74a6de7..b4e4a0c04304 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -182,7 +182,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
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
2.39.2

