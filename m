Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFA69B6D0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBRA35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBRA3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F66C00F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k72-20020a25244b000000b0083fa6f15c2fso1931074ybk.16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wSMKMWzwfQ8fLAFHXt0NmwJTi1H1o52qxxMn528B3Y=;
        b=axPHyxy1GBdJ3j5NWk4sW5NYHawOKf9AoibB4HV5FfIZJydc97adJIODrPR+QPgxNK
         nr00e5FMgkdE8K907sG4ZDoHr5Lt8bsvRMbzhBZu9D/vDZvX+woxXErLOoWLQSU7lSB3
         ColvlhjaPZZh6IxAnrEln+IITIxYCmy04Z2l1SbzE3B6POnZJUSMCAYWIRaT1Yw6pXLR
         Wq0cbmdstbtdCR3d2d+bJjVqqNZDwx8tE8yRYgFkpy+28U20Db+9VK0iOYSso+pD2sG8
         OJeoIbKDbGGxUqdzljTj52m+1rUrxcY+G67jmbfYWqpHTo5y/BK5aqWA0UQIkWR55NRP
         GAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wSMKMWzwfQ8fLAFHXt0NmwJTi1H1o52qxxMn528B3Y=;
        b=M9PdICCwevoqsB+YVTZsRvQA61+M95wXb0iiBN3kIbODe4IrbG7LRQmgVpBlmVrqaS
         3PDMXLyKm5+6I0IXX1hKLyLZdou2vq95clAAR4aCJGS/qRCvtcAjtqz40z7Y5lMaK9KV
         l0E9+fyxGoU4kbf198vOow1giRLatW4yVE/bHiPLqaRhoWLyrec8sTlUMOxnQyG7V4Yl
         OJNMLEeAKhvBq3QytuB34asEcjSPnnVWKLhZTdWfg7zb7hpD1jpUn15fOct9SWRFBABH
         WcWWYLlpe5zA91qiP5lJn4J+vmB984/78vdtDnOS9Fc/0Q9vkYn9A9algB6N+kmL6hzW
         Aa4g==
X-Gm-Message-State: AO0yUKUGGrCD7M5JpPpo+d/M2EdLTg+ulxaUvXg1m2BkERda9pyfJIUJ
        Uu30ZxWxXHgh0wnMwBQ7wgQAQC5hRf6PGl5/
X-Google-Smtp-Source: AK7set8P4IRNjQRV3GSaApBMgcJvUr/kZLWUTr2MSxmgTV4ZqD4cm7y5M6XYvFN0JDI5vO1MJ3hc9iawF3gnH6MW
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:38d:b0:533:a15a:d33e with SMTP
 id bh13-20020a05690c038d00b00533a15ad33emr73114ywb.5.1676680140092; Fri, 17
 Feb 2023 16:29:00 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:50 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-18-jthoughton@google.com>
Subject: [PATCH v2 17/46] hugetlbfs: do a full walk to check if vma maps a page
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it is safe to do so, do a full high-granularity page table walk
to check if the page is mapped.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index cfd09f95551b..c0ee69f0418e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -386,17 +386,24 @@ static void hugetlb_delete_from_page_cache(struct folio *folio)
 static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 				unsigned long addr, struct page *page)
 {
-	pte_t *ptep, pte;
+	pte_t pte;
+	struct hugetlb_pte hpte;
 
-	ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
-	if (!ptep)
+	if (hugetlb_full_walk(&hpte, vma, addr))
 		return false;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(hpte.ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
 		return false;
 
-	if (pte_page(pte) == page)
+	if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte)))
+		/*
+		 * We raced with someone splitting us, and the only case
+		 * where this is impossible is when the pte was none.
+		 */
+		return false;
+
+	if (compound_head(pte_page(pte)) == page)
 		return true;
 
 	return false;
-- 
2.39.2.637.g21b0678d19-goog

