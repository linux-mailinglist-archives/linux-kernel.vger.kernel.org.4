Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E064EE37
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiLPPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiLPPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432CDDE8A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQxWaXmf/BdMLd8AroQPz0fxFz+2cpe/6LbLYuumgUQ=;
        b=CpnfMNzrUAe4bVCEv5QDWfUfNSi3DWx08C7axcKr+2TFdeP6PQUH1KUT8kso/poJ43D89x
        1/K23fKjCTFuS5DA/nM+BLN8WQfM97hD/TD0uX2zIdjCskAgCGib8dMX6BAQpQEBprqZIM
        MGeS9HzGDj+TCcq57lv+w91Xui9NLcc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-mMvBi-XwPmi24i5upU1LWw-1; Fri, 16 Dec 2022 10:52:21 -0500
X-MC-Unique: mMvBi-XwPmi24i5upU1LWw-1
Received: by mail-qk1-f200.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so2074621qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQxWaXmf/BdMLd8AroQPz0fxFz+2cpe/6LbLYuumgUQ=;
        b=E4LDl3xOR/kboR8ldS44s8Ku+6HzBg1Z9On16N1bM9S4D681F8q/L1XW3FkLF6NNFg
         oXoaGIoGFNfLXIlGP5pjUldxoflyQR+cA4T8Lp3KuSFyY17CHrChvFiiCSgUM7JVPuLX
         D34Cz9vWVcYaE2zbbgr248UuW45KUMfjMQlVAzE7s7RkJz5N8I/C4pk/hP0q9/Ta8eSu
         o/ytFu6C68Z7oHGA1WqAKKy652hAxmTRontalPTykYUtvF7MTkGWuiIwHGgk949KHyGr
         e22vDOrHGglNIIdyCmk6IInLe6dNYk8wZyCoUHhsAyOCrTeEeFJksdTjAVc5BeQ2b9hT
         +8tA==
X-Gm-Message-State: ANoB5pn9kwupEWJ1hiSsI2CXerB1fWUdrEd6168inwVeYr5QtoURVVJr
        34xgAwBca8hlnVkjRlALOJdFOpu4FITndSdTWmTS+8qIbVjpGE+2uP8BTmgHOsEhUrnEThow4Np
        0Ymhhb/gbYsB1gqLNE8Tn330sI8otV2DaoIivzjyjzS8YHyCct6A+wxobKVw6oMur4nEIQgXouA
        ==
X-Received: by 2002:a05:622a:4c11:b0:3a5:2f80:5b08 with SMTP id ey17-20020a05622a4c1100b003a52f805b08mr46852455qtb.1.1671205939661;
        Fri, 16 Dec 2022 07:52:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7dhghRe2b9Hr/nL0Vtk5vE2Zf1v91HSpvXyjbmaYYF/40Yyuz87fscH2VZ1GmjeQmVyYE2LA==
X-Received: by 2002:a05:622a:4c11:b0:3a5:2f80:5b08 with SMTP id ey17-20020a05622a4c1100b003a52f805b08mr46852414qtb.1.1671205939371;
        Fri, 16 Dec 2022 07:52:19 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id x13-20020ac8120d000000b003a6847d6386sm1483787qti.68.2022.12.16.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:52:18 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>, peterx@redhat.com,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jann Horn <jannh@google.com>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 5/9] mm/hugetlb: Make userfaultfd_huge_must_wait() safe to pmd unshare
Date:   Fri, 16 Dec 2022 10:52:17 -0500
Message-Id: <20221216155217.2043700-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221216155100.2043537-1-peterx@redhat.com>
References: <20221216155100.2043537-1-peterx@redhat.com>
MIME-Version: 1.0
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
index 98ac37e34e3d..887e20472051 100644
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

