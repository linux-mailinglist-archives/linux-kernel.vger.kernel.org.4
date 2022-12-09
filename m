Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF364872B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLIRCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLIRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6679C8D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMLwOwXmHw3aEdY2dAtBVU7yezK1ZrIU2NcKyDsSofc=;
        b=ixxtqDBz3KXFU6W6Rd51ro51xrtpek0V/FAklQ2MBKrfiB1dpf37iOiLNQx5ztGtBOKXtj
        xdYP0FerDvl1v/XoqBOHNuLl4YcEGNJtsykIefg7Jttua5FdOUUHd09yftg2YzM92zAaVH
        +T7n6G3CBh5s10r9Mt56CMx5qu9IadQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198--M-jSTl9NvmeHNcRCz_TsQ-1; Fri, 09 Dec 2022 12:01:21 -0500
X-MC-Unique: -M-jSTl9NvmeHNcRCz_TsQ-1
Received: by mail-oo1-f72.google.com with SMTP id d3-20020a4a9cc3000000b004a06af5f883so1569304ook.17
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMLwOwXmHw3aEdY2dAtBVU7yezK1ZrIU2NcKyDsSofc=;
        b=3z9tp4o7sWfhViG9o+mu5VPnmnCPdmD0Tk52eY75e18M8vUt2fnZVCQQSCGw7N2Js+
         oLi5RTqvBJwLGFPGiBkhIkP4X0JN7erhQLCHjPfzpXROTIxL4P6oZ7d9C9t9fEhYrM9Y
         lln5u27DctxxiA04+wXVvrvQzl1mD4/tAvGAPv0Y6hG0jsZL1jUHPE5xYNTFN+nC8yWU
         has5wABEQCzv79lZc8vqCZAmbFcMfoTZaEEiFZ4ftVJ/s5kxdgOKBwhLWJ1nHofCO+z2
         QqagrOx1yVVwMgSFZjCjqzQBlNG2F1KSCvICDBmb3hslR+oUTEiA+mHTGK0eOLBcCSY3
         gnFA==
X-Gm-Message-State: ANoB5pl4WqVuLQg0vb/BNApQKDuK8p6WggZDE1FNbaaKbptLL6ikmm8n
        sf+6Ja1rNpPzB78tDeZE335G2YhuX7HV1d5efkE+UMCvR4Jr7LXiVL97gL5hOgwGd6IObnOd6tw
        6c+1r+F0Jz+5JznopTZ4pEoBV
X-Received: by 2002:a9d:77c1:0:b0:66d:c8a2:b9b with SMTP id w1-20020a9d77c1000000b0066dc8a20b9bmr3276915otl.12.1670605281160;
        Fri, 09 Dec 2022 09:01:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4oQHCNJfUC59F5uvhM+SYrQAPCUwZXG/cB2hzsrwqoVJGknQCDLk0levxupMtmfDVgjRq8Jw==
X-Received: by 2002:a9d:77c1:0:b0:66d:c8a2:b9b with SMTP id w1-20020a9d77c1000000b0066dc8a20b9bmr3276898otl.12.1670605280840;
        Fri, 09 Dec 2022 09:01:20 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:20 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 5/9] mm/hugetlb: Make userfaultfd_huge_must_wait() safe to pmd unshare
Date:   Fri,  9 Dec 2022 12:00:56 -0500
Message-Id: <20221209170100.973970-6-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209170100.973970-1-peterx@redhat.com>
References: <20221209170100.973970-1-peterx@redhat.com>
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07c81ab3fd4d..969f4be967c6 100644
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
 
@@ -493,6 +494,15 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
 
+        /*
+         * Take the vma lock now, in order to safely call
+         * userfaultfd_huge_must_wait() later. Since acquiring the
+         * (sleepable) vma lock can modify the current task state, that
+         * must be before explicitly calling set_current_state().
+         */
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_vma_lock_read(vma);
+
 	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	/*
 	 * After the __add_wait_queue the uwq is visible to userland
@@ -507,13 +517,15 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
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

