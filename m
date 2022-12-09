Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D018C648726
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLIRCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLIRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEDA9857C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KF8YBIr+SenpQMPOCGcYKB11m6lZYSBtX9iYqo4LY9E=;
        b=Uw8a7AAhzLIhx8sWioDN6YkBSOA9pkP3o+0vi3iDFLGzZJUFY0frrw4aEa/RB+wm5sWIKz
        ybSQicFWvU7mdKGoi0fYMzujHTjCJlByj3EVQmR2ozN2Ro0uaUHvMavdZS1l3KC+fibX6l
        ci+pwETu/EXAGrrMcxsWJIzfGCQvbSM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-E888qujWNYmCjCrllVjtrQ-1; Fri, 09 Dec 2022 12:01:16 -0500
X-MC-Unique: E888qujWNYmCjCrllVjtrQ-1
Received: by mail-qk1-f200.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso5612434qkp.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF8YBIr+SenpQMPOCGcYKB11m6lZYSBtX9iYqo4LY9E=;
        b=RaH7CiRedd2U6H2qbNpM+tnlLm0AO8KdDBB4oYCElTmoQbrfzaKMoF8uN2a1zWICuP
         /MxcULTuYTbuBl9J5hhMuW9ZFR0ZuMlzTUR6mSE+Epc+bAkWs2Z6kYZnLAp89pyZB+ea
         dBfoajyL5VEE1X+J5kiOSSOForaYytMvVtncGwYnPMXk1xCnVINurclCaGyUJJ0fbmke
         skm2VErsyF4Stn2F3AHjq8OZnZzAm4lUHHwgh7wZwJi0GOX4QywaS2aXtF7lQOHdHls9
         dcK4JHYi5o4D9iauIRq4AIhOvCObMoLVcsqeSvTGBTMXO6B1XLxSTQ5LqRgYeLo7cH3F
         xsFg==
X-Gm-Message-State: ANoB5pmwrWYG6dMJbbx+sOzK0G6olWnLamHVjNk8p3RI2ofAWyVMO6sQ
        7biw0UHyMb2N/3vcnW3O+UgFBEqMYJrHhsvkk1abPXqFgaxzkhRZV00RgYkD8n7AF72yqmfQxP2
        OTwenIx9Yn7iuqIjRscZ8YhV/
X-Received: by 2002:a05:622a:181b:b0:3a6:8b0a:89f4 with SMTP id t27-20020a05622a181b00b003a68b0a89f4mr5562655qtc.37.1670605275470;
        Fri, 09 Dec 2022 09:01:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7GjjyC9zskYeywpb+Ewu/62cki7ptxUtlYncuU3jbM740NAM3GpI8Fy9pUHhtyChxzmv3XbA==
X-Received: by 2002:a05:622a:181b:b0:3a6:8b0a:89f4 with SMTP id t27-20020a05622a181b00b003a68b0a89f4mr5562589qtc.37.1670605275115;
        Fri, 09 Dec 2022 09:01:15 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:14 -0800 (PST)
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
Subject: [PATCH v3 3/9] mm/hugetlb: Document huge_pte_offset usage
Date:   Fri,  9 Dec 2022 12:00:54 -0500
Message-Id: <20221209170100.973970-4-peterx@redhat.com>
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

huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
hugetlb address.

Normally, it's always safe to walk a generic pgtable as long as we're with
the mmap lock held for either read or write, because that guarantees the
pgtable pages will always be valid during the process.

But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
pgtable freed by pmd unsharing, it means that even with mmap lock held for
current mm, the PMD pgtable page can still go away from under us if pmd
unsharing is possible during the walk.

So we have two ways to make it safe even for a shared mapping:

  (1) If we're with the hugetlb vma lock held for either read/write, it's
      okay because pmd unshare cannot happen at all.

  (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
      okay because even if pmd unshare can happen, the pgtable page cannot
      be freed from under us.

Document it.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 551834cd5299..d755e2a7c0db 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
+/*
+ * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
+ * Returns the pte_t* if found, or NULL if the address is not mapped.
+ *
+ * Since this function will walk all the pgtable pages (including not only
+ * high-level pgtable page, but also PUD entry that can be unshared
+ * concurrently for VM_SHARED), the caller of this function should be
+ * responsible of its thread safety.  One can follow this rule:
+ *
+ *  (1) For private mappings: pmd unsharing is not possible, so holding the
+ *      mmap_lock for either read or write is sufficient. Most callers
+ *      already hold the mmap_lock, so normally, no special action is
+ *      required.
+ *
+ *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
+ *      pgtable page can go away from under us!  It can be done by a pmd
+ *      unshare with a follow up munmap() on the other process), then we
+ *      need either:
+ *
+ *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
+ *           won't happen upon the range (it also makes sure the pte_t we
+ *           read is the right and stable one), or,
+ *
+ *     (2.2) hugetlb mapping i_mmap_rwsem lock held read or write, to make
+ *           sure even if unshare happened the racy unmap() will wait until
+ *           i_mmap_rwsem is released.
+ *
+ * Option (2.1) is the safest, which guarantees pte stability from pmd
+ * sharing pov, until the vma lock released.  Option (2.2) doesn't protect
+ * a concurrent pmd unshare, but it makes sure the pgtable page is safe to
+ * access.
+ */
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
-- 
2.37.3

