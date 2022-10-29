Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822EE612159
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ2IVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2IVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:21:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3295C45A0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 01:21:37 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mzsh66qX0zmVJY;
        Sat, 29 Oct 2022 16:16:38 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 16:21:35 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 16:21:35 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next v2] riscv/mm/fault: simplify code for do_page_fault()
Date:   Sat, 29 Oct 2022 08:47:15 +0000
Message-ID: <20221029084715.3669204-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the code more hierarchical and readable, we fold vma related
judgments into __do_page_fault(). And to simplify the code, move the
tsk->thread.bad_cause's setting into bad_area(). No functional change
intended.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
v1 -> v2:
  Fixed incorrect use of macro VM_FAULT_BADMAP.

 arch/riscv/mm/fault.c | 77 +++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index d86f7cebd4a7..3fdc2eebdd36 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -85,6 +85,8 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 
 static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
 {
+	current->thread.bad_cause = regs->cause;
+
 	/*
 	 * Something tried to access memory that isn't in our memory map.
 	 * Fix it, but check if it's kernel or user first.
@@ -200,6 +202,38 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 	return false;
 }
 
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+
+static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
+				unsigned int mm_flags, struct pt_regs *regs)
+{
+	struct vm_area_struct *vma = find_vma(mm, addr);
+
+	if (unlikely(!vma))
+		return VM_FAULT_BADMAP;
+
+	if (unlikely(vma->vm_start > addr)) {
+		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN) ||
+				expand_stack(vma, addr)))
+			return VM_FAULT_BADMAP;
+	}
+
+	/*
+	 * Ok, we have a good vm_area for this memory access, so
+	 * we can handle it.
+	 */
+	if (unlikely(access_error(regs->cause, vma)))
+		return VM_FAULT_BADACCESS;
+
+	/*
+	 * If for any reason at all we could not handle the fault,
+	 * make sure we exit gracefully rather than endlessly redo
+	 * the fault.
+	 */
+	return handle_mm_fault(vma, addr, mm_flags, regs);
+}
+
 /*
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
@@ -207,7 +241,6 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 asmlinkage void do_page_fault(struct pt_regs *regs)
 {
 	struct task_struct *tsk;
-	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long addr, cause;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
@@ -280,44 +313,16 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		flags |= FAULT_FLAG_INSTRUCTION;
 retry:
 	mmap_read_lock(mm);
-	vma = find_vma(mm, addr);
-	if (unlikely(!vma)) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (likely(vma->vm_start <= addr))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (unlikely(expand_stack(vma, addr))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
 
-	/*
-	 * Ok, we have a good vm_area for this memory access, so
-	 * we can handle it.
-	 */
-good_area:
-	code = SEGV_ACCERR;
+	fault = __do_page_fault(mm, addr, flags, regs);
 
-	if (unlikely(access_error(cause, vma))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
+	if (unlikely(fault & VM_FAULT_BADMAP))
+		return bad_area(regs, mm, code, addr);
 
-	/*
-	 * If for any reason at all we could not handle the fault,
-	 * make sure we exit gracefully rather than endlessly redo
-	 * the fault.
-	 */
-	fault = handle_mm_fault(vma, addr, flags, regs);
+	if (unlikely(fault & VM_FAULT_BADACCESS)) {
+		code = SEGV_ACCERR;
+		return bad_area(regs, mm, code, addr);
+	}
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
-- 
2.25.1

