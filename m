Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4990662640D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiKKV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiKKV6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:58:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCEEDE85;
        Fri, 11 Nov 2022 13:58:31 -0800 (PST)
Date:   Fri, 11 Nov 2022 21:58:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668203909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BCUnFSEgXqFPUUW5UerPVfg/BV4gyo2gPkqS6wbdVxw=;
        b=Z7sGRkvGKlpiO/4in/mRL4MPB68FNH+jzdqm8oT/I2x+S2BK2FnGHDKwjFdxTNp9BIk0lb
        zLwgy9efPsepHTFoEricyVXYYnWYT/7SZJ2SKMYY9VKQntjF7XyQHrkLemEWmrkzMDvWBK
        UmVqswnffmI4ZKvrPuzJ5TleNPumbYzI2NUhLX5nYOpddRTsAK5OHCggwoOdssJ2dP5pBA
        ZnIwA28T9HFnOu9l68n4efm3MyREZbbGhO0PkVDaYKqse+3SL4n4WVXhAJkQ45h8Emo6ZA
        XEL2yBOOkJ5qPtI5bl+KfLEKpnaz9OAK8922PPVYDufOigmzT/8lSaWI5whF9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668203909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BCUnFSEgXqFPUUW5UerPVfg/BV4gyo2gPkqS6wbdVxw=;
        b=oHgC8xMUmW4UnN/tjkxUJVAM8wqD6FZVwfaDE4HyZNdW+LTkqIusD0hLfRGwmGgQTCA+Zw
        lhVxmcK0P776HZBA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Provide arch_prctl() interface for LAM
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166820390853.4906.11890562076114153914.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6b38f4411021e3e63f541925c3cb5d7fed983ca1
Gitweb:        https://git.kernel.org/tip/6b38f4411021e3e63f541925c3cb5d7fed983ca1
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:31 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 13:28:08 -08:00

x86/mm: Provide arch_prctl() interface for LAM

Add a couple of arch_prctl() handles:

 - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
   of tag bits. It is rounded up to the nearest LAM mode that can
   provide it. For now only LAM_U57 is supported, with 6 tag bits.

 - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
   bits located in the address.

 - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can request.
   Zero if LAM is not supported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20221109165140.9137-8-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/uapi/asm/prctl.h |  4 ++-
 arch/x86/kernel/process_64.c      | 71 +++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

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
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6b3418b..b8f2558 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -743,6 +743,66 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+static void enable_lam_func(void *mm)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	unsigned long lam_mask;
+	unsigned long cr3;
+
+	if (loaded_mm != mm)
+		return;
+
+	lam_mask = READ_ONCE(loaded_mm->context.lam_cr3_mask);
+
+	/*
+	 * Update CR3 to get LAM active on the CPU.
+	 *
+	 * This might not actually need to update CR3 if a context switch
+	 * happened between updating 'lam_cr3_mask' and running this IPI
+	 * handler.  Update it unconditionally for simplicity.
+	 */
+	cr3 = __read_cr3();
+	cr3 &= ~(X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
+	cr3 |= lam_mask;
+	write_cr3(cr3);
+	set_tlbstate_cr3_lam_mask(lam_mask);
+}
+
+#define LAM_U57_BITS 6
+
+static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
+{
+	int ret = 0;
+
+	if (!cpu_feature_enabled(X86_FEATURE_LAM))
+		return -ENODEV;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	/* Already enabled? */
+	if (mm->context.lam_cr3_mask) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!nr_bits) {
+		ret = -EINVAL;
+		goto out;
+	} else if (nr_bits <= LAM_U57_BITS) {
+		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+		mm->context.untag_mask =  ~GENMASK(62, 57);
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+out:
+	mmap_write_unlock(mm);
+	return ret;
+}
+
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
@@ -830,7 +890,16 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
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
