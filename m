Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416696E80B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjDSR6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:58:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29874EC3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:58:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c64-20020a254e43000000b00b92530ded91so225881ybb.17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681927120; x=1684519120;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GcWrIDO6GH5yJpHF/uWaF8jYk6l7KP2l0HcvbP0QLVU=;
        b=b8KAmYXrp9C9kGB31W/3uEQ+Go+Y0JBvLAJeq/hVhD34sd3sj8TtC7ZXZQomTcS79z
         koWqV9IeWVnH/KWCpZlkKCsuaTOCwJm9EwDVc5CZ3QdsTUQmOfZQpORT0i7eUSBKD2eH
         OVaH5Ru0DnYgzfXdR5pSiU6XEfHSftrrUL0zGt1TgtHvVXBbUO5c8c+f3zgcf+pSna7P
         us5hy2jwo/mFvr12D5Aa5lQWPb7AA4sqTbKPHPdE2N/Ee4VwO2ToiQKyRjcvxi9Nn8fL
         NJV4S5ZWjgNkLxP5R0+W8acutV2PTpe4E4PxUw7DNfFo7G8DukmtLRhxWIiy8l6PWihV
         06aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681927120; x=1684519120;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcWrIDO6GH5yJpHF/uWaF8jYk6l7KP2l0HcvbP0QLVU=;
        b=Kchh/ODkjSpLPU0xnL7540ilxx9QHz2W58evKqQhm/Hrxo0RoV/yggOVGhPV3HOMhU
         R/S5KwBZq9dhHG4cwwoZv+HvSQYuyc0bljez/rc8wgdhWo6/PcGDJpShFppzxj5CwhjR
         ochahB+iM7kkp2mXe/F08oC2ELzm1gI0fc0aT9sS5plpNeWr4Ubk0rkZfT2489pq1WB2
         tm1NUsh22UUpS/ul5boBVfEPSMky7KWu2sBuGjKd3E8fWaTd2ysInq09HroX2euj94j2
         WU9sezmP2Ie09VC+2OPzI5zLUzDK3WM42ysxjXhuUs92q76ZcYrfsZ+kPYHTlLQ9BQk5
         SwVw==
X-Gm-Message-State: AAQBX9dylddXENBMQ6a7lISBF/cYPkPbHWr4Hj0bMBt5xXzXJtxAJVWE
        CcPSHibOWocnD+QrMm0aG0aS0zLgWF8=
X-Google-Smtp-Source: AKy350ZN/NekAmaDhc7GI/R22C6mGO6MT6c2t8KbzwLAGZNIGAMtX16FRUineRnh4JOkeMeU/vb6XaN+afo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:4b5f:8e2f:d0bb:d3cf])
 (user=surenb job=sendgmr) by 2002:a25:cac1:0:b0:b6c:48c3:3c1c with SMTP id
 a184-20020a25cac1000000b00b6c48c33c1cmr336892ybg.13.1681927120024; Wed, 19
 Apr 2023 10:58:40 -0700 (PDT)
Date:   Wed, 19 Apr 2023 10:58:36 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419175836.3857458-1-surenb@google.com>
Subject: [PATCH v3 1/1] mm: do not increment pgfault stats when page fault
 handler retries
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the page fault handler requests a retry, we will count the fault
multiple times. This is a relatively harmless problem as the retry paths
are not often requested, and the only user-visible problem is that the
fault counter will be slightly higher than it should be.  Nevertheless,
userspace only took one fault, and should not see the fact that the
kernel had to retry the fault multiple times.
Move page fault accounting into mm_account_fault() and skip incomplete
faults which will be accounted upon completion.

Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes from v2 (https://lore.kernel.org/all/20230415000818.1955007-1-surenb@google.com/):
- Updated comments per Matthew Wilcox and Peter Xu

 mm/memory.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 01a23ad48a04..7ce9286ee4d4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5080,24 +5080,31 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
  * updates.  However, note that the handling of PERF_COUNT_SW_PAGE_FAULTS should
  * still be in per-arch page fault handlers at the entry of page fault.
  */
-static inline void mm_account_fault(struct pt_regs *regs,
+static inline void mm_account_fault(struct mm_struct *mm, struct pt_regs *regs,
 				    unsigned long address, unsigned int flags,
 				    vm_fault_t ret)
 {
 	bool major;
 
+	/* Incomplete faults will be accounted upon completion. */
+	if (ret & VM_FAULT_RETRY)
+		return;
+
 	/*
-	 * We don't do accounting for some specific faults:
-	 *
-	 * - Unsuccessful faults (e.g. when the address wasn't valid).  That
-	 *   includes arch_vma_access_permitted() failing before reaching here.
-	 *   So this is not a "this many hardware page faults" counter.  We
-	 *   should use the hw profiling for that.
-	 *
-	 * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
-	 *   once they're completed.
+	 * To preserve the behavior of older kernels, PGFAULT counters record
+	 * both successful and failed faults, as opposed to perf counters,
+	 * which ignore failed cases.
 	 */
-	if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
+	count_vm_event(PGFAULT);
+	count_memcg_event_mm(mm, PGFAULT);
+
+	/*
+	 * Do not account for unsuccessful faults (e.g. when the address wasn't
+	 * valid).  That includes arch_vma_access_permitted() failing before
+	 * reaching here. So this is not a "this many hardware page faults"
+	 * counter.  We should use the hw profiling for that.
+	 */
+	if (ret & VM_FAULT_ERROR)
 		return;
 
 	/*
@@ -5180,21 +5187,22 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
+	/* If the fault handler drops the mmap_lock, vma may be freed */
+	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
 
 	__set_current_state(TASK_RUNNING);
 
-	count_vm_event(PGFAULT);
-	count_memcg_event_mm(vma->vm_mm, PGFAULT);
-
 	ret = sanitize_fault_flags(vma, &flags);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
-					    flags & FAULT_FLAG_REMOTE))
-		return VM_FAULT_SIGSEGV;
+					    flags & FAULT_FLAG_REMOTE)) {
+		ret = VM_FAULT_SIGSEGV;
+		goto out;
+	}
 
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
@@ -5223,8 +5231,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 		if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
 			mem_cgroup_oom_synchronize(false);
 	}
-
-	mm_account_fault(regs, address, flags, ret);
+out:
+	mm_account_fault(mm, regs, address, flags, ret);
 
 	return ret;
 }
-- 
2.40.0.634.g4ca3ef3211-goog

