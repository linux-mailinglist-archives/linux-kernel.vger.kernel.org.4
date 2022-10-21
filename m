Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6F607C75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJUQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiJUQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59192859B4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36772c0c795so33791817b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b10z9K2d7yL2NkYZoSYI1eqym2z6cE2oNjVSRM+YxM4=;
        b=RdBFlvTWkP0mOj/+10aeT3pEp8gO1xe67MKNQAL9eJH8ygvwfl65HnLVJ/TXb07S8J
         Ekg4eIzJiS8mFJVRjcHyYUexaJ2Wpz0KD24tdJaK9vQvVpzHw4Swadb/CS9sPPIaClpx
         a4pSknIHqn7yKEu2xGQn6BM9ClrfpieKDQTxfc134vaHcOGtZtUzcwwZ/+hyo2Y9SDbU
         EqxOcGGs64poU/YYQXMdII6wUC0HnwMTfwDML9Jw5n3ISsd1571avOMoRlykby8HbVOv
         iidSXRx0txEQjxJng6lLm/tQXQGCk4PTQsXMvO/tZsN0O2ZrP+47TYzob91093CTHxXV
         vE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b10z9K2d7yL2NkYZoSYI1eqym2z6cE2oNjVSRM+YxM4=;
        b=ugRGnq3Otogx+T2tmhZUiCeEjyUgUxsc+Z8ijVoLEn/k0gE+yx4FZ7SyqxRBiBvgfr
         h/OmZ2+cog51m7tdIDGtBcjhOKzQOrRolgYq4gNn5D2xtiM2qd1ZtUVmfujKKaTEH8LH
         ZYmSTuw2djMJEx2aUEQAVE9UqOjSuV+g4vFt1MSfSyaOpuLNk3xaG9dAlTs1r9T084Ga
         +/3N+qJmbolSNWIlxkjf6RXy8dcABYzif7yVHF7UzjqVuT55SM75OcnEP5spsKDIyVdk
         g+KlujAqvXr343olNXJiH+piKuT6a7ZY5ZTIbZWOp/Vur7JKPE1V9MAsBSGPJ6ET8It6
         MwOw==
X-Gm-Message-State: ACrzQf2DlbhLWtgrhGwe1GSgS12MPEOO5TADZN6TyKONKVWBbfJR961k
        9LQybsqY6L9hJOLjDp4rK8bPp1dIL9kAf6Wt
X-Google-Smtp-Source: AMsMyM4a1Xbq88agbnwbbrlQOayFRrDGXm2X6sV7Iqp0l2y6+5WLGgjVLDxiqSHzLLJPyqPxXNBrDUUp2xxQ0SZu
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:8d14:0:b0:361:4e59:a90e with SMTP
 id d20-20020a818d14000000b003614e59a90emr17171702ywg.288.1666370255675; Fri,
 21 Oct 2022 09:37:35 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:37 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-22-jthoughton@google.com>
Subject: [RFC PATCH v2 21/47] mm: rmap: provide pte_order in page_vma_mapped_walk
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

page_vma_mapped_walk callers will need this information to know how
HugeTLB pages are mapped. pte_order only applies if pte is not NULL.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/rmap.h | 1 +
 mm/page_vma_mapped.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bd3504d11b15..e0557ede2951 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -378,6 +378,7 @@ struct page_vma_mapped_walk {
 	pmd_t *pmd;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned int pte_order;
 	unsigned int flags;
 };
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3c..395ca4e21c56 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 static bool map_pte(struct page_vma_mapped_walk *pvmw)
 {
 	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
+	pvmw->pte_order = 0;
 	if (!(pvmw->flags & PVMW_SYNC)) {
 		if (pvmw->flags & PVMW_MIGRATION) {
 			if (!is_swap_pte(*pvmw->pte))
@@ -174,6 +175,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (!pvmw->pte)
 			return false;
 
+		pvmw->pte_order = huge_page_order(hstate);
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
 		if (!check_pte(pvmw))
 			return not_found(pvmw);
@@ -269,6 +271,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				}
 				pte_unmap(pvmw->pte);
 				pvmw->pte = NULL;
+				pvmw->pte_order = 0;
 				goto restart;
 			}
 			pvmw->pte++;
-- 
2.38.0.135.g90850a2211-goog

