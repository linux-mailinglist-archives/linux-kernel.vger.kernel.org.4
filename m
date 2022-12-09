Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D61648731
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLIRDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLIRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E128D182
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SiCXWzCdYbU9QHTa4B1WTrTi25NBF8hxZPF60vWGZSs=;
        b=EjKoCatLCpCy2lrxJ71HIOBk7eegBAKleKL3NlgCsSmwUUMnzNe9ygaCYICLz+3C3ONEX6
        bFwGtlurU6KnIkcy9ikMQ46Lqj/RKkAv87Ev2yST3mos05YPM2jCnbxz1coABZqEHIgR4a
        GFt5yuDNYeIy4Gr4BVgmjj+O4LTkxyo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-r_oC_N5yO9ysXI9T_kwNww-1; Fri, 09 Dec 2022 12:01:29 -0500
X-MC-Unique: r_oC_N5yO9ysXI9T_kwNww-1
Received: by mail-oi1-f198.google.com with SMTP id s18-20020a056808209200b0035be56b3f8dso2339468oiw.21
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiCXWzCdYbU9QHTa4B1WTrTi25NBF8hxZPF60vWGZSs=;
        b=Ik7+DT0W7PIma+XxzHiQAHrHAjj3BftsmrlUmC/lqHgvc83RryXbbtfhnY4OuECPKy
         +PqqZbERNTB9ntqkBHncx5yL1Lla9IF8vioEhkiXNFZX2ucEHchBatFToy5/682RKwtW
         CQ0jd6FmqniSfBh/473UDqH3gcn/aOccUuPjMeKt2lujbIQqU4MC3Cmcnd5H4kNQvjgY
         KaL3lfOCeyiNw264+jzisNvRCUA7b0WfutrzFQDflHMBfvZgPYFQdGKbHgq1V3WI/P4c
         o0W1OM1/V/WgAhz6+E4Ufyl4cP11YBtW6SzvqF6UjIbOl835dJW7Q5Enux0eUlcoZde6
         EX8A==
X-Gm-Message-State: ANoB5pnfsD73+HDOceewsH/enELT7rruDowoOXIMT6iC9A7N1PeKm4vI
        L5fNJwB1kBqaJKuFeBWubNKt2KqYDVBT/gaeB+yLrRwVd0AATcpz+B2/7OLdj55Zom9cN1Mcle/
        rF/O5T+TUQdcUJSAAqI1DUTz5
X-Received: by 2002:a05:6808:141:b0:35a:640d:300e with SMTP id h1-20020a056808014100b0035a640d300emr2638002oie.19.1670605288797;
        Fri, 09 Dec 2022 09:01:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6z8153BBKEHldWTDZCjSK48fzRxQgu6nHidb9TN0qLtv3uxM5cswjC0U3ES+rGDimiirmJAQ==
X-Received: by 2002:a05:6808:141:b0:35a:640d:300e with SMTP id h1-20020a056808014100b0035a640d300emr2637970oie.19.1670605288528;
        Fri, 09 Dec 2022 09:01:28 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:27 -0800 (PST)
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
Subject: [PATCH v3 8/9] mm/hugetlb: Make walk_hugetlb_range() safe to pmd unshare
Date:   Fri,  9 Dec 2022 12:00:59 -0500
Message-Id: <20221209170100.973970-9-peterx@redhat.com>
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

Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pagewalk.h | 11 ++++++++++-
 mm/hmm.c                 | 15 ++++++++++++++-
 mm/pagewalk.c            |  2 ++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 959f52e5867d..27a6df448ee5 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -21,7 +21,16 @@ struct mm_walk;
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
  *			are skipped.
- * @hugetlb_entry:	if set, called for each hugetlb entry
+ * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
+ *			function is called with the vma lock held, in order to
+ *			protect against a concurrent freeing of the pte_t* or
+ *			the ptl. In some cases, the hook function needs to drop
+ *			and retake the vma lock in order to avoid deadlocks
+ *			while calling other functions. In such cases the hook
+ *			function must either refrain from accessing the pte or
+ *			ptl after dropping the vma lock, or else revalidate
+ *			those items after re-acquiring the vma lock and before
+ *			accessing them.
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
  *			"do page table walk over the current vma", returning
diff --git a/mm/hmm.c b/mm/hmm.c
index 3850fb625dda..796de6866089 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -493,8 +493,21 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	required_fault =
 		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
 	if (required_fault) {
+		int ret;
+
 		spin_unlock(ptl);
-		return hmm_vma_fault(addr, end, required_fault, walk);
+		hugetlb_vma_unlock_read(vma);
+		/*
+		 * Avoid deadlock: drop the vma lock before calling
+		 * hmm_vma_fault(), which will itself potentially take and
+		 * drop the vma lock. This is also correct from a
+		 * protection point of view, because there is no further
+		 * use here of either pte or ptl after dropping the vma
+		 * lock.
+		 */
+		ret = hmm_vma_fault(addr, end, required_fault, walk);
+		hugetlb_vma_lock_read(vma);
+		return ret;
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 7f1c9b274906..d98564a7be57 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	hugetlb_vma_lock_read(vma);
 	do {
 		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
@@ -314,6 +315,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 		if (err)
 			break;
 	} while (addr = next, addr != end);
+	hugetlb_vma_unlock_read(vma);
 
 	return err;
 }
-- 
2.37.3

