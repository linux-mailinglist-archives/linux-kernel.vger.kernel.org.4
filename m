Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9173E64EE33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiLPPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiLPPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72481566F8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KF8YBIr+SenpQMPOCGcYKB11m6lZYSBtX9iYqo4LY9E=;
        b=csNWsGW/bQnmfPX6UmmutwDcOq+CNrGpRvu2gA07KwgnQdZdJy1bZlf3f/0b3k4m1U4O1w
        XUIJIPC/KzhmvhwseKfYWjq0DCm/H+NNljNp0nXFPuSc/u3vuWAassH/WotfobLpmOdrrh
        5IwrblOLfp1rtWdV+1cFelUkUanpSIw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-uNnN6rg-Ope8mSlwuzmkpg-1; Fri, 16 Dec 2022 10:51:14 -0500
X-MC-Unique: uNnN6rg-Ope8mSlwuzmkpg-1
Received: by mail-qk1-f197.google.com with SMTP id de38-20020a05620a372600b0070224de1c6eso1227110qkb.17
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF8YBIr+SenpQMPOCGcYKB11m6lZYSBtX9iYqo4LY9E=;
        b=tWNhQwJR2zKBByCNcJNFpjdAYEJmUqxIK2emHwWbcsjcQyEsewvlUXltDSc5dJXycl
         aVTegJ6nsl8kAXKk/LbkrwLyUIh2NnCxuyeSFW45bKoqpf1tXSwhPc64RM2gQYF9ALno
         eCrj46PxBQ/K5166em7No2GtFyLiZWBCO/WJoHa2sipZRiGp7MJaszP5vf7ftlFi0+8M
         hN8UkC2eQHNk1mlLNnMXBFO6RvCXSxbuuUyRXUug3jr+fqb3ZBGbMm2wspbm0RpgR31A
         BmvnmU63Ycyoutsli1JX2o4Fva1jAIAAtfE9SQTsDlTKHCxsFz/YJKc506QlSZaOSuxd
         MbTw==
X-Gm-Message-State: ANoB5pkMpVKRnJacbUn0KBQr3Sosg2m7N9CE/64mwmjrHc45yq5x3hQC
        0Q7WpMdnQkmQcge320gNC6pjXlYbhhXQsEi9B3pUpgrIFLS44kKFWV4vD8m/OqjqWD+tjRnQ744
        /G42IWMSY9r3nlxDFdIT8vemmrhLXWqQCEDgopYoaqks+Y5kg8imVheeOPANvDj2/W2Sew+2X0A
        ==
X-Received: by 2002:a05:622a:4d8e:b0:3a6:258d:4387 with SMTP id ff14-20020a05622a4d8e00b003a6258d4387mr42497444qtb.13.1671205873269;
        Fri, 16 Dec 2022 07:51:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Jn2Uhau9BzqMwoo3qPaHalj0PlAXaiA0mx+xscLlNHjTHI5SgMhkHZ6FN0+QlzD5tFFX+mQ==
X-Received: by 2002:a05:622a:4d8e:b0:3a6:258d:4387 with SMTP id ff14-20020a05622a4d8e00b003a6258d4387mr42497407qtb.13.1671205872924;
        Fri, 16 Dec 2022 07:51:12 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id s81-20020a37a954000000b006eeb3165554sm1682297qke.19.2022.12.16.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:51:12 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        James Houghton <jthoughton@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v4 3/9] mm/hugetlb: Document huge_pte_offset usage
Date:   Fri, 16 Dec 2022 10:50:54 -0500
Message-Id: <20221216155100.2043537-4-peterx@redhat.com>
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

