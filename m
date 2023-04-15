Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41D6E2DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDOAIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:08:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9730F1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:08:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c17fb245dso257450757b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681517302; x=1684109302;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HTZMn+gdePQ6w7ytfojAbFuEgA1Exnj51R99edjgsk4=;
        b=HXjWck7PIwn2MOmDJ61gXB6mzp/zcBEjD3VXA3dtP3JJsKBX66dn/fLDKzYLSzjpIV
         uB6IAS5hoNhvCHiUomWn2VQqw2IPnD5EyGKpS2wAoHPc6fmCfv5WdV4AdkiAndxqG0/f
         A3iGSOwBT+Wc9uyp37v4l1yGWipIaT8+Fddu6G6fOKU+GvtsudqwOPNOy+I2UADevQPI
         P6HALgBGheXxZj4ZF4896PfGAnRZtV9TnQ8x06UepUb5yCvAn51CJ7jiAOvqNUJUJpOy
         P7bkZdc8Fc1YaoWGW3I/Npq2iAY8MJJCIYd4bz5+Vt3agxk4OVsmono5B9lYJtW3B4Ql
         Kn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681517302; x=1684109302;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTZMn+gdePQ6w7ytfojAbFuEgA1Exnj51R99edjgsk4=;
        b=Z/03rRaL2sq/TwUTWMYvaqqXRSLMY/dCZoYTz0i+YVlelsL7r1R7tnqfMRqHqVEh+V
         bxL9Vi16bRbZG/NwPWZDdmjsN2XYoypfG9BGNH3N4cjTfEqLBX/HpW7dAeoQxthLufEo
         1F6qUME8sXeOzTavtxC/cIe29o+nuk7Dp8BmiWj2ZQMtkACSK6fMtlCbsLjmNugvqxQF
         dzlVKmdgk4Ez64BQOJoTYMXktu3KMF8glojMKtk5MjbZie0z4aNvB/1ty1PSEtP63JuT
         B0cZ+tl+Y/4u+9Uyakzdfrthx3WqJ4Tn9coymN4YEuOvdAVKoVglrqwOo/OhfuZBxsnt
         D58g==
X-Gm-Message-State: AAQBX9dh51l4uzvz9IVD5bpvv/n8KF041JON7NS61VoJnwpV/+tB/Ru1
        /VV8sEmSIa5IEa849U8z0VaznFd+dr0=
X-Google-Smtp-Source: AKy350Zdqn2SuZ84MXlUvPdnfLvMmZOEwQDahaWw8QbW+PES4oLAtpiiNIVM9mruaQNMWSGM6qirf/zEdBQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:46c0:7584:f020:e09f])
 (user=surenb job=sendgmr) by 2002:a81:b71c:0:b0:54f:b931:adf7 with SMTP id
 v28-20020a81b71c000000b0054fb931adf7mr5042050ywh.4.1681517302208; Fri, 14 Apr
 2023 17:08:22 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:08:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230415000818.1955007-1-surenb@google.com>
Subject: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
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
 mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 01a23ad48a04..c3b709ceeed7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5080,24 +5080,30 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
  * updates.  However, note that the handling of PERF_COUNT_SW_PAGE_FAULTS should
  * still be in per-arch page fault handlers at the entry of page fault.
  */
-static inline void mm_account_fault(struct pt_regs *regs,
+static inline void mm_account_fault(struct mm_struct *mm, struct pt_regs *regs,
 				    unsigned long address, unsigned int flags,
 				    vm_fault_t ret)
 {
 	bool major;
 
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
+	 * Do not account for incomplete faults (VM_FAULT_RETRY). They will be
+	 * counted upon completion.
 	 */
-	if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
+	if (ret & VM_FAULT_RETRY)
+		return;
+
+	/* Register both successful and failed faults in PGFAULT counters. */
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
@@ -5180,21 +5186,22 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
+	/* Copy vma->vm_mm in case mmap_lock is dropped and vma becomes unstable. */
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
@@ -5223,8 +5230,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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

