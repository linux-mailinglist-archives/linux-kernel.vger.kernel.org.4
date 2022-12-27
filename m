Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF62656704
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 04:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiL0DJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 22:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiL0DJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 22:09:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA382AFB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672110535; x=1703646535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PApE0uZLyXFEodnTh3dZSNMMuSzjiKqxGiIkJUnjdqE=;
  b=Qk7mfQoMMbPh30d7IY4eMDLF5nPNEyHDrtW3hi2/vTBkDuC3HXTnfbCD
   hHP9oxDXSA1z/ss1OKGEyijHxkZ6BuszS37TarqjldEtuY7PXD4efGR+A
   I4mxaktOZFCnue5w1oRXhDKbw7IOZdjXsLkPzM9QVB0gM1aPONFZVQeOb
   KJyUjX96rsY/aAtBX0hMF0Z/RcllSR2wb4AmEXPmWz1boefFWXWsNmXAv
   uWWbHwrZabcO5N39B9t9y1OCjz/HAu7TcyvSVvCBoLZ/+XMt+n/oA5aUr
   ywsB7rwlg4+odBQcYBQC12PdwfIQvmkFaRjnaMGr8l2+y0OCTXb7CClC4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="321869789"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="321869789"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 19:08:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="652917547"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="652917547"
Received: from ppogotov-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.152])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 19:08:47 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B478C10BBB3; Tue, 27 Dec 2022 06:08:36 +0300 (+03)
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
Subject: [PATCHv13 06/16] x86/mm: Provide arch_prctl() interface for LAM
Date:   Tue, 27 Dec 2022 06:08:19 +0300
Message-Id: <20221227030829.12508-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
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

Add a couple of arch_prctl() handles:

 - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
   of tag bits. It is rounded up to the nearest LAM mode that can
   provide it. For now only LAM_U57 is supported, with 6 tag bits.

 - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
   bits located in the address.

 - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can request.
   Zero if LAM is not supported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu.h        |  2 ++
 arch/x86/include/uapi/asm/prctl.h |  4 +++
 arch/x86/kernel/process.c         |  3 +++
 arch/x86/kernel/process_64.c      | 44 ++++++++++++++++++++++++++++++-
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index ed72fcd2292d..54e4a3e9b5c5 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -12,6 +12,8 @@
 #define MM_CONTEXT_UPROBE_IA32		0
 /* vsyscall page is accessible on this MM */
 #define MM_CONTEXT_HAS_VSYSCALL		1
+/* Do not allow changing LAM mode */
+#define MM_CONTEXT_LOCK_LAM		2
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..a31e27b95b19 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,4 +20,8 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+#define ARCH_GET_UNTAG_MASK		0x4001
+#define ARCH_ENABLE_TAGGED_ADDR		0x4002
+#define ARCH_GET_MAX_TAG_BITS		0x4003
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ef6bde1d40d8..cc0677f58f42 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -162,6 +162,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
+
+	if (p->mm && (clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM)
+		set_bit(MM_CONTEXT_LOCK_LAM, &p->mm->context.flags);
 #else
 	p->thread.sp0 = (unsigned long) (childregs + 1);
 	savesegment(gs, p->thread.gs);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 8b06034e8c70..fef127ed79b6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -743,6 +743,39 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+#define LAM_U57_BITS 6
+
+static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LAM))
+		return -ENODEV;
+
+	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags))
+		return -EBUSY;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (!nr_bits) {
+		mmap_write_unlock(mm);
+		return -EINVAL;
+	} else if (nr_bits <= LAM_U57_BITS) {
+		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+		mm->context.untag_mask =  ~GENMASK(62, 57);
+	} else {
+		mmap_write_unlock(mm);
+		return -EINVAL;
+	}
+
+	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
+	set_tlbstate_cr3_lam_mask(mm->context.lam_cr3_mask);
+	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+
+	mmap_write_unlock(mm);
+
+	return 0;
+}
+
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
@@ -830,7 +863,16 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+	case ARCH_GET_UNTAG_MASK:
+		return put_user(task->mm->context.untag_mask,
+				(unsigned long __user *)arg2);
+	case ARCH_ENABLE_TAGGED_ADDR:
+		return prctl_enable_tagged_addr(task->mm, arg2);
+	case ARCH_GET_MAX_TAG_BITS:
+		if (!cpu_feature_enabled(X86_FEATURE_LAM))
+			return put_user(0, (unsigned long __user *)arg2);
+		else
+			return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.38.2

