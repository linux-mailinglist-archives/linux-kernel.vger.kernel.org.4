Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720A963C891
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiK2Tic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiK2ThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0139950D58
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2GgktAyXhDRBB8fn5rbcYoK/H0Sll/0lbzArKYhQzY=;
        b=HOXLYMVvhzztEaPIwe4aXANqPDSJyGxCzx5yIJu7YQPpDhqU0aG0azJHaxV0ifm3yaxoVL
        8mbRB9uzCSomu6jCnX1j07MV+XwZJQDxFm+YjPzYngTDBW8WENpX0D26bXy8Y9GD+uImFl
        lbPn2T0j+HMv1vaT1/xMOYYTTCzOLd4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-505-lbRug1EjMHWUwpBv52iZPQ-1; Tue, 29 Nov 2022 14:35:38 -0500
X-MC-Unique: lbRug1EjMHWUwpBv52iZPQ-1
Received: by mail-qk1-f197.google.com with SMTP id w14-20020a05620a424e00b006fc46116f7dso30274291qko.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2GgktAyXhDRBB8fn5rbcYoK/H0Sll/0lbzArKYhQzY=;
        b=SeQpGKgodsfAn5gimG4Bn9WV9811ovWBM6clWcnQoVuBM6aFb95EZqqL2nnM1BxT08
         A2IIxjUQgEJoqeOIneFBDxL/C58H27pfRealAwkK657KA5eFlPZr2NPYZUeKB/khshDl
         FW6MdXbq8AztRmmcnYceeit2pBOZMDSSfSAlvNFTtGhzYJon/gwETCI3a51SWRJWVUoe
         BVYFo+b/yREWjuz1PiqoO7OSJwS89Nj6pG2fFtHksZjBfHuhifKQ5DobPUWT8ubB0Z+4
         tformfiLKe04CdamWnkn/zr6T1Zf4iMo97U1U3aihkTH2u/D7mDwUfqW6yLuplvkkEZL
         2mbw==
X-Gm-Message-State: ANoB5pnVEkgI//4ENiMna2uxeE7kgpwOt8du4AmkNuKlg4WaXQsI0znq
        Cqw5BBiJQsPLaYKiPJ9eWR0KhQrfU7se8JiTCz7DP1lTCsdwi0eWLOmc78EKtHg4I6wZXVneczr
        7v6VXn70VufCz9oXdLcbYgTAx
X-Received: by 2002:ad4:5a12:0:b0:4c6:cfb3:461f with SMTP id ei18-20020ad45a12000000b004c6cfb3461fmr29830214qvb.18.1669750538313;
        Tue, 29 Nov 2022 11:35:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5sUOLP+bu5vmUyeu4eR0d5tdrBlXwCznX/b9tlkmnKZ8SzN/XLnce+u+p7KI/YvBLKOKGVTQ==
X-Received: by 2002:ad4:5a12:0:b0:4c6:cfb3:461f with SMTP id ei18-20020ad45a12000000b004c6cfb3461fmr29830188qvb.18.1669750538086;
        Tue, 29 Nov 2022 11:35:38 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 05/10] mm/hugetlb: Make userfaultfd_huge_must_wait() safe to pmd unshare
Date:   Tue, 29 Nov 2022 14:35:21 -0500
Message-Id: <20221129193526.3588187-6-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can take the hugetlb walker lock, here taking vma lock directly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07c81ab3fd4d..a602f008dde5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -376,7 +376,8 @@ static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
  */
 vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 {
-	struct mm_struct *mm = vmf->vma->vm_mm;
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
 	struct userfaultfd_ctx *ctx;
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -403,7 +404,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 */
 	mmap_assert_locked(mm);
 
-	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
+	ctx = vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
 		goto out;
 
@@ -493,6 +494,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
 
+	/*
+	 * This stablizes pgtable for hugetlb on e.g. pmd unsharing.  Need
+	 * to be before setting current state.
+	 */
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_vma_lock_read(vma);
+
 	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	/*
 	 * After the __add_wait_queue the uwq is visible to userland
@@ -507,13 +515,15 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	set_current_state(blocking_state);
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
-	if (!is_vm_hugetlb_page(vmf->vma))
+	if (!is_vm_hugetlb_page(vma))
 		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
 						  reason);
 	else
-		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
+		must_wait = userfaultfd_huge_must_wait(ctx, vma,
 						       vmf->address,
 						       vmf->flags, reason);
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_vma_unlock_read(vma);
 	mmap_read_unlock(mm);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
-- 
2.37.3

