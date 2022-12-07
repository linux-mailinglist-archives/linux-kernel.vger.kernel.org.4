Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BEB64626C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLGUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLGUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307517B57D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnUJ2i61erGKHgVVBS7fwgSAnx0w9hoDMCwKHPZDtzw=;
        b=f6s6nbfUCZYloXQKbEpunbY8UjvK37tq2gruLTfSjBW5VmtTbTOgRLKvWqS3Eu+rpimxPI
        eEswRhxHlf7xop6edqNJgRCELKQAnbQKa/xJ7/LshzoElmpQz36+K7iLB+sX5I+UNCzWnd
        i7bJ2IO9B6BmP/5166yDizoOAMzYgls=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-7l3cns-tOk2acgjeiX0obQ-1; Wed, 07 Dec 2022 15:30:53 -0500
X-MC-Unique: 7l3cns-tOk2acgjeiX0obQ-1
Received: by mail-qt1-f198.google.com with SMTP id w27-20020a05622a191b00b003a56c0e1cd0so38191158qtc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnUJ2i61erGKHgVVBS7fwgSAnx0w9hoDMCwKHPZDtzw=;
        b=Lb9ecmWMME5qcb/t8efYrJ4pCuzY1Te/CLckWh39jHUNsA8DB/D9mZup6heRt93Gur
         7DIZ9cVQt5CxqZInykzBfYCJ8YKDjO3y+Q40NpaGv3PZ5eGKWZCX0SBL554cSvVLESFx
         /qzdLrNP4SwFYlLooxP0EYmsrPpTg5/SwnzMPJ7eEqmP0/3BR2jLRCxKoGh+FgWA7RGA
         CAWU9vHST7daqULrFEmej8KWdeGyJsJvit0zk2pzkbE9h+hFnEJn5InZ2q/FzU7lZhZq
         0kBjyBbWQDMCD5SGtYJN/ngLngMIniW16E3Od6+bcyVxVajYDUO3SFW2WfiBv6b4st7W
         IgUg==
X-Gm-Message-State: ANoB5pmqCZuz9jyeEep+SJnH0qCOP+Ly1iUSlki4fmSxgHhd4AtsztE0
        WsHx51OCqSkeU+nyjj+LgU1tOjxrUJLolnVwFDcS6DKkoennSauRjlmvH2UNMe/YOBugLJY012g
        FScT4QLRlR8EsNh7bZaM02Tsb
X-Received: by 2002:a05:622a:4116:b0:39c:e5bf:8162 with SMTP id cc22-20020a05622a411600b0039ce5bf8162mr1523508qtb.55.1670445050825;
        Wed, 07 Dec 2022 12:30:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Dm6o+mvrRgKNPfSdavyDzIrF0yVxDNEuk8J2b1g1jeHdYzQXkU2H9nY0+acDohHOQ2RPx0Q==
X-Received: by 2002:a05:622a:4116:b0:39c:e5bf:8162 with SMTP id cc22-20020a05622a411600b0039ce5bf8162mr1523492qtb.55.1670445050551;
        Wed, 07 Dec 2022 12:30:50 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:50 -0800 (PST)
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
Subject: [PATCH v2 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd unshare
Date:   Wed,  7 Dec 2022 15:30:32 -0500
Message-Id: <20221207203034.650899-9-peterx@redhat.com>
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

Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/gmap.c      |  2 ++
 fs/proc/task_mmu.c       |  2 ++
 include/linux/pagewalk.h | 11 ++++++++++-
 mm/hmm.c                 | 15 ++++++++++++++-
 mm/pagewalk.c            |  2 ++
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 8947451ae021..292a54c490d4 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2643,7 +2643,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 	end = start + HPAGE_SIZE - 1;
 	__storage_key_init_range(start, end);
 	set_bit(PG_arch_1, &page->flags);
+	hugetlb_vma_unlock_read(walk->vma);
 	cond_resched();
+	hugetlb_vma_lock_read(walk->vma);
 	return 0;
 }
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e35a0398db63..cf3887fb2905 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1613,7 +1613,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			frame++;
 	}
 
+	hugetlb_vma_unlock_read(walk->vma);
 	cond_resched();
+	hugetlb_vma_lock_read(walk->vma);
 
 	return err;
 }
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

