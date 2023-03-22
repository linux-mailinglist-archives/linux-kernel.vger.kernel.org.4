Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470F6C51DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjCVRFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjCVREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0265464;
        Wed, 22 Mar 2023 10:03:52 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nBuo1olh+RupjbAp5df59j0oCBhWWlgOMcq4CCUGQTw=;
        b=hthQgJ6tpc5PpuTAcfqBO4KeqF5GmoVxNq0q33V4BFM9OrEBkLY3V5yR+ZKxvMQgWO1fwN
        CAgIFHobMDzKYSw22Zv4RxVYesSnYvsUxISiqOGWrw08PuojQJpKooWgt/7tDn2tNcAYoN
        quFuZ5231KO7vOO1DsElUmNhsufQ/qyy79LfAoBSoR3FklbmuHrtSvEVXdfpuA38I723Xt
        6++cZaPF7xQ8+83VW1X4m/HAHlCKBZ6evPpUy4a9Kjv4eTPzt+B6pERT9Tbz1LN1UT+NbW
        g0v8E+0qhn9FVvJikeoijEin2J6xo0Za+19EwECcwqG/nnogyBoFCFoGuiAmLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nBuo1olh+RupjbAp5df59j0oCBhWWlgOMcq4CCUGQTw=;
        b=JeRzuBzmAzz+xv45CjnKOwKD/LtAWSex5+Z0d0k3GADFV3tDHzN1TQOHxPoWuMySXovo16
        ucsZ/TJJG8DzLzBA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Provide arch_prctl() interface for LAM
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458713.5837.14519789205254281026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     2f8794bd087e7958c8d1f0a0538856ca03e0bf3c
Gitweb:        https://git.kernel.org/tip/2f8794bd087e7958c8d1f0a0538856ca03e0bf3c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:03 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:39 -07:00

x86/mm: Provide arch_prctl() interface for LAM

Add a few of arch_prctl() handles:

 - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
   of tag bits. It is rounded up to the nearest LAM mode that can
   provide it. For now only LAM_U57 is supported, with 6 tag bits.

 - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
   bits located in the address.

 - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can request.
   Zero if LAM is not supported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20230312112612.31869-9-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/mmu.h        |  2 +-
 arch/x86/include/uapi/asm/prctl.h |  4 ++-
 arch/x86/kernel/process.c         |  3 ++-
 arch/x86/kernel/process_64.c      | 55 +++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 9cac8c4..e80762e 100644
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
index 500b96e..a31e27b 100644
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
index bbc8c4c..50d9507 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -163,6 +163,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
+
+	if (p->mm && (clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM)
+		set_bit(MM_CONTEXT_LOCK_LAM, &p->mm->context.flags);
 #else
 	p->thread.sp0 = (unsigned long) (childregs + 1);
 	savesegment(gs, p->thread.gs);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cd34bcf..186f34a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -743,6 +743,48 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+
+#define LAM_U57_BITS 6
+
+static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LAM))
+		return -ENODEV;
+
+	/* PTRACE_ARCH_PRCTL */
+	if (current->mm != mm)
+		return -EINVAL;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags)) {
+		mmap_write_unlock(mm);
+		return -EBUSY;
+	}
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
+	set_tlbstate_lam_mode(mm);
+	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+
+	mmap_write_unlock(mm);
+
+	return 0;
+}
+#endif
+
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
@@ -830,7 +872,18 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+#ifdef CONFIG_ADDRESS_MASKING
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
+#endif
 	default:
 		ret = -EINVAL;
 		break;
