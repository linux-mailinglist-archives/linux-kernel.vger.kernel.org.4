Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83464626B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLGUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLGUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD0F7BC1E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+Krxeq6Jc+PcaZJFIdSBIisnuJapI9S7rvolPGgBf8=;
        b=PTmas97Jb93qnuAog8k00coQ9bjf3eaC8ajXy2xigRSNgTiAb1RCoAxGG9h+XEXeAZSHmu
        ilQplszTVbbfQzO2cKGPcReX/6bUk3MlVMU0K+PUT2U23NCvXdY16Rk1Zbd5dkUHBibpKb
        VEexxEwkrsfWEER+1wP4KC1ExugASDo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-2GMUU1jMPreIwdjOd4-7ng-1; Wed, 07 Dec 2022 15:30:46 -0500
X-MC-Unique: 2GMUU1jMPreIwdjOd4-7ng-1
Received: by mail-qt1-f199.google.com with SMTP id w27-20020a05622a191b00b003a56c0e1cd0so38190777qtc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+Krxeq6Jc+PcaZJFIdSBIisnuJapI9S7rvolPGgBf8=;
        b=vUCvmUX2JnCXTdddOHtMiVBaPxSpRSwZCiAtgeOt1oLrBoxZp9Jpf3ozunGONn5uY4
         M+0M0XYGRabNT2PyHuh0w227QBB+A72HokKOwmnNIf8+XiyXNqggwV1OJwyT1InZLA9r
         3E4FdTTgTiyc64/fDinb9gQJLAOCHdtyLou4yYa8hz8djwg7263ZOWxm2YNRS9bsTOab
         qtv5tY71/6wLapolkJkfQc1AgpvqESCt4+ixQHGnQXwzyDo+Iu7ilObnRwpMW3MMgVTm
         AdY8hIbuluXitIUesiPBl/0qrco8hiQrvewPtTWGKmhhtuWPkPmVt+jJt2yxVpUe8XNe
         JaHQ==
X-Gm-Message-State: ANoB5pmAFQBZIjx2MIsg323IzVIm3TgSMXxuVbY8Obtd8fwEgDcHB74J
        k0WstnuzRi/9aKDNAVPYulg1t+46duvlLzzS3+xyvZUSjKweAHBAZ5SwrX34cBTpckNM5gVSMNX
        QySFFSrRZ/qeNzvqPA4/tDdvZ
X-Received: by 2002:ad4:4049:0:b0:4c6:e720:39ff with SMTP id r9-20020ad44049000000b004c6e72039ffmr1560027qvp.28.1670445046159;
        Wed, 07 Dec 2022 12:30:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4HMr/hq5EZlF5E6QU5x135bvh3KiJsjh1/wzJyvKRsivrnjQIaSzqnKC1C9heD+L0fqJzg4A==
X-Received: by 2002:ad4:4049:0:b0:4c6:e720:39ff with SMTP id r9-20020ad44049000000b004c6e72039ffmr1560015qvp.28.1670445045854;
        Wed, 07 Dec 2022 12:30:45 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:45 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 05/10] mm/hugetlb: Make userfaultfd_huge_must_wait() safe to pmd unshare
Date:   Wed,  7 Dec 2022 15:30:29 -0500
Message-Id: <20221207203034.650899-6-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207203034.650899-1-peterx@redhat.com>
References: <20221207203034.650899-1-peterx@redhat.com>
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

