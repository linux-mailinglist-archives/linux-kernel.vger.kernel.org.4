Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2625665E8DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjAEKVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAEKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C680559DC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so36503864ybh.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nuChqEE6EgS9ZWad0RFM9vhCC4fCrQA1CHpyknS9e9I=;
        b=PMdoUglmYM3qm6mWAqtyVJgzu77MRJxWmvYG3y/y52hzYvzk3AeSDZU/v2V/pwhi1f
         AihoMvQwpu8u1lszjJmu97VBPUPHphQwGK+Wi8ukPijxmNbY6TtoExxE1zmWstSCaeED
         T5Ii9p6OfjRqSgGbZeKD1Y0Rzcm0Fdvj3xukaysFr/AEQaLMJgbLYNRWvM54l3lHDA7x
         fl11csrpr58Kd28oGSDnxgd7q6xGmGLlKrMpRBTnVtv5V+fe2oSKpXRf+O+a4IQLcoCC
         PuKdMBIByP3sRXz/ggMAPuiyizC3+IXS18St1U3mOWfSpY1iHbA15ZXf/yxY1pQexB6C
         posA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuChqEE6EgS9ZWad0RFM9vhCC4fCrQA1CHpyknS9e9I=;
        b=2yp3XvOgcjrMUSjDXZFOBefclY0cZNlvGSMBU+biuX8yV2OVnWVjWtlh1ZrZ2K8Tw5
         DZYyZVzmDl+VFMWmRRXAv0VIoBMHEYiJyboXLQBBId35FuwZF64wSpec2+/gUxBxj3kl
         gKZqLL2egqzImWqNDConQDQsEoMXY/8AO4wMGQK+r5OAeNQZPmj88shUNoBKbySV08/U
         LEsXazUie5BMHuRoa8LRNGAE76rihzq5/zko+7ufuptrsan70UvdzeI4PxLgLACk4QR0
         2DxUBfWMGxt19VpDFaqYkKNLBkJZrrjEpuP26o4tomXOePevI20FwL2vwLa3MP4THiZx
         n93g==
X-Gm-Message-State: AFqh2koxNadWcFQL9CE5i4EBhPXIDX4ubPftqoCDiJ1J8/bj7DKXVJpN
        AbqRYgy+YDFuk4grrFgUWHPdNWtTJ8T/lkpi
X-Google-Smtp-Source: AMrXdXsmbu5aWUcLBPTHt2L3Enr+YToepIDBEUyzT+YPIQDSoYjuNB0al+BU5pwPYUwrP+sl0xBGKb8Hi38zvCCs
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:688a:0:b0:3b7:e501:90cf with SMTP
 id d132-20020a81688a000000b003b7e50190cfmr2167304ywc.501.1672913967234; Thu,
 05 Jan 2023 02:19:27 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:20 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-23-jthoughton@google.com>
Subject: [PATCH 22/46] mm: rmap: provide pte_order in page_vma_mapped_walk
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
2.39.0.314.g84b9a713c41-goog

