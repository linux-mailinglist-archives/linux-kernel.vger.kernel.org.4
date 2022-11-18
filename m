Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8D62EABD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiKRBLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiKRBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:11:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7082225
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2GgktAyXhDRBB8fn5rbcYoK/H0Sll/0lbzArKYhQzY=;
        b=ApQeGQkmbSMVPsr+Xdpa/9MFmm/79+V0L+f94Hc/CYj0TXFGgSB9PhlKS2vxxgoWXiA+e6
        Jr1SVbYaIudklgmSqTZ2tDIcT0693TUHc1kqi6HBQQWb52OvLMD3xHTMxhkuBjfK2zQbIR
        h9EsczfXbLd4Yai/AGva9x8AURGvGT4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-QyX55SCUPECLRr5723Eo2A-1; Thu, 17 Nov 2022 20:10:37 -0500
X-MC-Unique: QyX55SCUPECLRr5723Eo2A-1
Received: by mail-qk1-f197.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so4375945qkb.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2GgktAyXhDRBB8fn5rbcYoK/H0Sll/0lbzArKYhQzY=;
        b=e5G+vGBIaxl35pnkYLs6qBXK3oB7d93/BfZbvsbQjreCqzkNp6ODa4iXFYOYSB/rXJ
         rJSusuPrHfm9XnwYrtKUf9JGMUzGzH9vOchVoYTVUa74kGooxoVsZwClhK3RohBKeRRs
         M8I0QnLcc+rpk4liFaIKtn6SdSAZgRhEleK8gxjJqxJJXzZpJ4EHh/kJUFUOe3u6DUJ2
         KROJxmJG2H31bCiRB4GrSDkXmQdzenT2GQ3EHvhyJbyhsfq04dFCETAkadYCK+H9UzBF
         jWS819Hn7asbziZp18oNkJrAEaiLwBs/6n6meXmILC2FkCjy0eafnMCI2YcERlL8iVtt
         VjbA==
X-Gm-Message-State: ANoB5pnNQ/IuwLLhA/aUHaE1PjsXmZQVS47CydOk5yussgwhT1NrSLEi
        IJXLQKZh72Murdz2YLfHIwvy9uikAa99I96APc39UIVVCDX9zj6VUywttu1EDy2cc1sPuXKa3b+
        DsQ+00tOxNC4XWINrCxXy/h4O
X-Received: by 2002:ac8:48ce:0:b0:3a5:65ac:9c8a with SMTP id l14-20020ac848ce000000b003a565ac9c8amr4698801qtr.457.1668733836693;
        Thu, 17 Nov 2022 17:10:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5rnz6DDTlt9Ny28N2rVHhXYOuDlhdIfEgZs3xq/IpEsL+2rvvX9NavYJjdTwg6ClUXgreJUw==
X-Received: by 2002:ac8:48ce:0:b0:3a5:65ac:9c8a with SMTP id l14-20020ac848ce000000b003a565ac9c8amr4698782qtr.457.1668733836471;
        Thu, 17 Nov 2022 17:10:36 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 05/12] mm/hugetlb: Make userfaultfd_huge_must_wait() safe to pmd unshare
Date:   Thu, 17 Nov 2022 20:10:18 -0500
Message-Id: <20221118011025.2178986-6-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
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

