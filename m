Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC862014C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiKGVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiKGVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:37:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A9CD9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667857048; x=1699393048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWyRCW5aKXNWtiucVf5kkixxGLClq+OtEfuUo4LHoho=;
  b=ACZhRB6Zj8oClnlG2tsVALHsfQR/D6mBX4uTz0Fb7iWK1RV0Fr7W1X8+
   QfgzCUuXxh3eTRDCnfjVXc1Zarxx5r3JaM0j4px8MeP4ZRNmsy4WxmCCo
   z1su85xbO0aoFovE842MQnrHT33IVFEIXxNRRACQEouovLYAkA8x7nTbd
   MwhU3ka1huRcpkPDwwvwV8tdhOItvghdkihoxSWydctmmsRAFSBO3l/p4
   nyRjm+3eEpmP0s9ClMz/ppSdvXCxkJ9Pp9Qp9Sg/p2wX14Dqa8Ru/j/Lw
   PZvDUYnaoxJIhJCbV/HalqsJSPHpHUzmkStsekm6sdCLc8gGNEmDfzV9e
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="396827877"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396827877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:37:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="965326539"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="965326539"
Received: from biancabe-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.218.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:37:23 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E49C010964A; Tue,  8 Nov 2022 00:37:20 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     kirill.shutemov@linux.intel.com
Cc:     ak@linux.intel.com, andreyknvl@gmail.com, ashok.raj@intel.com,
        bharata@amd.com, dave.hansen@linux.intel.com, dvyukov@google.com,
        glider@google.com, hjl.tools@gmail.com,
        jacob.jun.pan@linux.intel.com, kcc@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com,
        ryabinin.a.a@gmail.com, tarasmadan@google.com, x86@kernel.org
Subject: [PATCHv11.1 07/16] x86/mm: Provide arch_prctl() interface for LAM
Date:   Tue,  8 Nov 2022 00:37:09 +0300
Message-Id: <20221107213709.28330-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221025001722.17466-8-kirill.shutemov@linux.intel.com>
References: <20221025001722.17466-8-kirill.shutemov@linux.intel.com>
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
 arch/x86/kernel/process_64.c      | 71 ++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

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
index 6b3418bff326..b8f2558a3aeb 100644
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
-- 
2.38.0

