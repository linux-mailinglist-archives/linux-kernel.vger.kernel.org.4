Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C727869B6C2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBRAay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBRA35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:57 -0500
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C86368E63
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:19 -0800 (PST)
Received: by mail-vk1-xa4a.google.com with SMTP id g1-20020ac5c5c1000000b00401b81d313bso828558vkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676680149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2na1A3NSq7U/MTCBc/o5RGQOMMtDEqSAD5VSD0flvE=;
        b=qVyA3qUqF5DHCviCI1nzfYS5Svk9ua2LpWd4a99ORevkgEpjI4dqg4lKQMb+bwNcNw
         61c9ND7a9iH3goStVFiSljoFRjNY2j1AhhPNcUU/a1rv5fdHxnLbmQMVtti88Q+JYZyU
         bhe8TGck/nYHhFokZ4sDeNAoyxCO64fiBBLXbHmrXkJokroObrlP3/h9q8bTGXc3eo/F
         vBbNamFNBm7arbW972qTZ0yke+aKbVBelBbPkEYjM+gx8b1eyLRItOwCX8k0eelqQ1oo
         E6X1WzYSjvE5m5sQqtV1xVs+q8GAKHv2jxgseAPVQAnj0ZSKEohG90BS+LNhWTC4WS5w
         8pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676680149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2na1A3NSq7U/MTCBc/o5RGQOMMtDEqSAD5VSD0flvE=;
        b=zNstsPHLth5kt06+gbX294bYdljsYHrbEn1ZyZmjZbRpk2DAWWwaRf0Y2h7MT65kN2
         kNHatYxMZgbFyFlyTrBfedM0rkt7Ek734QZ+fcjmqCnsqVHAECF2WPksdITnosqjV4h3
         zxE0cOyzh6XWAEIPHqrWZ105hzsUv89g4kFKd77JZ+skW0U6979Vpw24DdaZH+1zRXyu
         83kuwnz2ay800WWZtwgs/Sn5agzv+89C9sNyHfXHnVSDksHWMzk6CGPxLDxpt1unRdku
         2CgflRKwPuq0AEt08x48c2zXhL9AwJLb61oivTmHqEjaI7bpWpQiVa2vpc7L6jftEHTo
         d6Rw==
X-Gm-Message-State: AO0yUKVSlJQiq9oKLyadBYwHXnE9rcSiNF9o2xRaVP2oyg+MPgj7Tvj5
        xFJame8ugmcpiZehtfoSuUEGMTcZlhHKAopU
X-Google-Smtp-Source: AK7set+z+B4A4WuUUUfTfMJ3HPbCsVBPAnASJYuSG63wOfEVQp9exRkXKeR5pjRe9t+Ysvo+wmN1lJQLga4KIPTk
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:c485:0:b0:412:4cf3:d0ed with SMTP
 id d5-20020a67c485000000b004124cf3d0edmr38832vsk.32.1676680149589; Fri, 17
 Feb 2023 16:29:09 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:59 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-27-jthoughton@google.com>
Subject: [PATCH v2 26/46] mm: rmap: provide pte_order in page_vma_mapped_walk
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

page_vma_mapped_walk callers will need this information to know how
HugeTLB pages are mapped. pte_order only applies if pte is not NULL.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a4570da03e58..87a2c7f422bf 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -387,6 +387,7 @@ struct page_vma_mapped_walk {
 	pmd_t *pmd;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned int pte_order;
 	unsigned int flags;
 };
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 4e448cfbc6ef..08295b122ad6 100644
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
@@ -177,6 +178,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (!pvmw->pte)
 			return false;
 
+		pvmw->pte_order = huge_page_order(hstate);
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
 		if (!check_pte(pvmw))
 			return not_found(pvmw);
@@ -272,6 +274,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				}
 				pte_unmap(pvmw->pte);
 				pvmw->pte = NULL;
+				pvmw->pte_order = 0;
 				goto restart;
 			}
 			pvmw->pte++;
-- 
2.39.2.637.g21b0678d19-goog

