Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E7607C74
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiJUQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiJUQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:09 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886E7285996
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:35 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id i4-20020a05610220c400b003a7718929ecso1043612vsr.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRJ6pkRKArtLmZe7XMBJjGLJyFbSk0rbbeye9q84C9k=;
        b=ZQtGwmeXsLEasfxlAVd+Ky+KcZ4u0ied8Nvno8abVpS+XKmDnGeaG7sbDC8DX8DjvM
         74vP8xl/C/D6frwkZjH0NjGEaALQrxYOl4qyIHM6NFQ6TqBYFbfRh99+goV7aMS+wqHZ
         EWOers7WW52iKsOYpfLe1iauG6eIptFtQYmFfmKiotPdEPO4sKbu65xEzDbR/5RG82C/
         y77vYpTF7YV+Whm4oAUX1QUUOJtL0b1RKIBN4O1mH8xMYkKU5aZVNAgTr4TGtpelYVZI
         e9gU8PeJNzs1B5TCPPy55btaAR0P5+I/VVVQLdPgY9hG0sq1HT32TKdmh24otsMY096+
         x/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRJ6pkRKArtLmZe7XMBJjGLJyFbSk0rbbeye9q84C9k=;
        b=QXrSZID3DZb2tjqMQ3iz4ddmhYtkKm5Xk55sArygLEkLaKi0F/Fq/5gb2h45ehMUjS
         uGgBBXVjE9U2ZgrsMea35WJ02Cx7sw6eMBbVBDVbwRLcEI2GxHMR8n2DGR01tfFKAY7e
         EHI0ZHfm18/P6FHwbyDEi76BcGl7NolszPrH3ounF2eQSnjnv9dZAalw0FveFJe+M8Yh
         pRaYfKVq9nrbDI2UtnKpDUxFG+wK/qc63sCxGD4ElzLizgk72mOCCl8Mkvm3fknHl/4/
         zW7yZaS+/BBRxMvcbaWfMZMxDmEXyOOhOIU//ny1R0vm+YHuPBrx2f2u1OUKNSBg3aQn
         kCrw==
X-Gm-Message-State: ACrzQf2dgtVGS4ZhR1wwh4oAmVjMbmKfrQsYhv4rUW+NprYLHBJneyqX
        Lj9BS3RDel0Lr22Sbo/yPeYTIefKQREX3Pxo
X-Google-Smtp-Source: AMsMyM58r3yVRAL1NhZoJpcVLFGz0JqMpwGwsUiw6+Jq6Q4QwSneC2a182VZO4sfXGLadr38QjPrDD4kaXOFzTvM
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:3678:b0:3a7:6056:9e7a with
 SMTP id bg24-20020a056102367800b003a760569e7amr12639659vsb.62.1666370254111;
 Fri, 21 Oct 2022 09:37:34 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:35 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-20-jthoughton@google.com>
Subject: [RFC PATCH v2 19/47] hugetlb: make hugetlb_follow_page_mask HGM-enabled
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

The change here is very simple: do a high-granularity walk.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d76ab32fb6d3..5783a8307a77 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6408,6 +6408,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	struct page *page = NULL;
 	spinlock_t *ptl;
 	pte_t *pte, entry;
+	struct hugetlb_pte hpte;
 
 	/*
 	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
@@ -6429,9 +6430,22 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 	}
 
-	ptl = huge_pte_lock(h, mm, pte);
+retry_walk:
+	hugetlb_pte_populate(&hpte, pte, huge_page_shift(h),
+			hpage_size_to_level(huge_page_size(h)));
+	hugetlb_hgm_walk(mm, vma, &hpte, address,
+			PAGE_SIZE,
+			/*stop_at_none=*/true);
+
+	ptl = hugetlb_pte_lock(mm, &hpte);
 	entry = huge_ptep_get(pte);
 	if (pte_present(entry)) {
+		if (unlikely(!hugetlb_pte_present_leaf(&hpte, entry))) {
+			/* We raced with someone splitting from under us. */
+			spin_unlock(ptl);
+			goto retry_walk;
+		}
+
 		page = pte_page(entry) +
 				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
 		/*
-- 
2.38.0.135.g90850a2211-goog

