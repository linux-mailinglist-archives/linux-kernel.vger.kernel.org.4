Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD145602A56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJRLgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiJRLfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:35:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB8BA91A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666092920; x=1697628920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1RmDlHjank+08AvRxU4Dq3nTeuAWGKaZTDb08aAe7to=;
  b=jK/dwJ7Ul61emAbaOoppOksFM66niauKjbrzzpE9hiKypmDU6nm5v1S5
   YeszmEYg0/i4W64JdK7dGLLgtwTXqqPMldghpEqREiY6/mq7HR4t3UXY5
   5mgLW9yEvhfrWd8eqGYZuxn6iN/UxhT11BiR8CiFeXRtYHGkaGFwNoA8E
   OoDGvpEIQNxdIvRvVxn1CwIyOi2/JdBy136+hPvjqQFoyTs5gQCkw8r2p
   wkFEWzxotFVHvg5mVOIcjRcduMv7tu7P1QjvdXXukkwotIIvSCYRjBD0d
   IByk7VteTm4nCVJ3cFXvMLWmC+r8+msrALVWsDkVM/v9AAfFpq8V3wcaX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368105823"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="368105823"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 04:34:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691763175"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="691763175"
Received: from vhavel-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 04:34:13 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3AAA610479E; Tue, 18 Oct 2022 14:34:04 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv10 07/15] x86/mm: Provide arch_prctl() interface for LAM
Date:   Tue, 18 Oct 2022 14:33:50 +0300
Message-Id: <20221018113358.7833-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/uapi/asm/prctl.h |  4 ++
 arch/x86/kernel/process_64.c      | 65 ++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

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
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6b3418bff326..a98536101447 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -743,6 +743,60 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
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
+	/* Update CR3 to get LAM active on the CPU */
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
@@ -830,7 +884,16 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
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
2.38.0

