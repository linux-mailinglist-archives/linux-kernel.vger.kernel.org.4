Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EF5EC97E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiI0Q3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiI0Q2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:28:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E51D73C0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d24so9564060pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AsJY41XMXFwgdgJedGBIEW9iEXdmuZaxFchvtZgLRts=;
        b=m6GcP6wWedee5WJZJaWbkT5RTdd55uan6Np016DjpR8muG6vIptBwf3QzE4ERNpttX
         affNl+gUFcSzOYXosWJ/VRNjxYXy6FJfUHO5liFb7f0D5IstX1F597GLJSGrDA7jLhUD
         agxRfB3pWC7X6zWYvj7pwv0ePgUXr9cf1klPUuTHnNmaQhlQA0/PzaK0mKwVXiZUPXMj
         OZSsmozTQGpDPKL7eaUGXjsln2FL4L4E1wk/WU0AWbsxNpjOvcdECApM3/JSfUfxUR1B
         /ivlVLd+zH8EmphX+KW4fYQo4eRP8Tu2zNIh1l1qyg+uW8hsnnAiVXXZYMF2KwGSTiBq
         rHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AsJY41XMXFwgdgJedGBIEW9iEXdmuZaxFchvtZgLRts=;
        b=vrgCuG15IJzeQU7BBhj6kXrdX1+LCQcXlvunXrVX2V0uARqoKj+eDVbwrrpHIvnhnS
         DF0I+vFXgK0hV09vcI8/qCD4FQFOufYOqwZX122qx/jRTf6nVyMwmLR1S+LGYIAvS4Pp
         2xmraXaKgmX2W7XZGEuM1/QxShK2a6dF0YguBpvci7FAw8U9b/MBNyKEQCnlVf4f2fCk
         SHL2XZ9Zy3ykTZDmBsvLZRq8iiHX1y0mAK8r8z4RUpftK24rk1wAJRKgGjAGLvWFarRt
         mobLqTikZyvQoufwOWYdjWO7G06quAoUw4u20ZliIXsBU3QFCSwIFzsceEOm3psGdwa5
         nNzg==
X-Gm-Message-State: ACrzQf1a1ySS3GtGOZnPW9pRKGGfcrvXC5vt/1lLdVcyru0i8lFgEm8G
        no05zvyfE7DrrKlRt/jvmg8=
X-Google-Smtp-Source: AMsMyM718HLi2PtSjot1gUUVGevKickODf7v55QPmyvyloREZ18G25HdbEpAcyTcqIr1Rfcie5ZhUg==
X-Received: by 2002:a17:90b:3e86:b0:205:d88c:616d with SMTP id rj6-20020a17090b3e8600b00205d88c616dmr4387498pjb.78.1664296100553;
        Tue, 27 Sep 2022 09:28:20 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:28:19 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 8/9] mm: Handle COW PTE with reclaim algorithm
Date:   Wed, 28 Sep 2022 00:29:56 +0800
Message-Id: <20220927162957.270460-9-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927162957.270460-1-shiyn.lin@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the PFRA reclaiming the page resided in the COWed PTE table,
break COW when it using rmap to unmap all the processes.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/rmap.h | 2 ++
 mm/page_vma_mapped.c | 5 +++++
 mm/rmap.c            | 2 +-
 mm/swapfile.c        | 1 +
 mm/vmscan.c          | 1 +
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b89b4b86951f8..5c7e3bedc068b 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -312,6 +312,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 #define PVMW_SYNC		(1 << 0)
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
+/* Break COW PTE during the walking */
+#define PVMW_COW_PTE		(1 << 2)
 
 struct page_vma_mapped_walk {
 	unsigned long pfn;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 8e9e574d535aa..5008957bbe4a7 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -251,6 +251,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
+
+		/* TODO: Does breaking COW PTE here is correct? */
+		if (pvmw->flags & PVMW_COW_PTE)
+			handle_cow_pte(vma, pvmw->pmd, pvmw->address, false);
+
 		if (!map_pte(pvmw))
 			goto next_pte;
 this_pte:
diff --git a/mm/rmap.c b/mm/rmap.c
index 93d5a6f793d20..8f737cb44e48a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1477,7 +1477,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_COW_PTE);
 	pte_t pteval;
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1fdccd2f1422e..ef4d3d81a824b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1916,6 +1916,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	do {
 		cond_resched();
 		next = pmd_addr_end(addr, end);
+		handle_cow_pte(vma, pmd, addr, false);
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431352dcd..030fad3d310d9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1822,6 +1822,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		/*
 		 * The folio is mapped into the page tables of one or more
 		 * processes. Try to unmap it here.
+		 * It will write to the page tables, break COW PTE here.
 		 */
 		if (folio_mapped(folio)) {
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
-- 
2.37.3

