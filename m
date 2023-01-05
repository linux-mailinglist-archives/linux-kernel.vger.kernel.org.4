Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE565E8CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjAEKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjAEKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:33 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061B50E69
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-45dd4fb5580so378164247b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMmONeDZhRsfRYenu3fsdwuxvPajRN7/ApHlNDbguPQ=;
        b=UFJAvfKJ0l2l1UPgK2wOxQdo8MGVCU1OiqZoCoIsORlWWBUstNNxYXGaVW7ns6IVpx
         sWOpSOdqwOmhWrxPIEuTJShy8NWBIxPmZh7CTQVtYZgNAzrkiyxm4tK3EB2cr1fcFG72
         NL2UY0HHYPq++cxfnJOWh1PCfM28o2mBsAvAuRNwxLK1h+x7QAsbLSW86Vjev3uMwHMA
         m4xMKgabvqB+ymtxPfBLgyttxaDC5fCgZB7AtaPYv2QEle4gH4NgP5WxMkQzfjWNUecC
         PeW8MaipU+W1oEePXDzy12uT9ZIJZoMLhlOKeScuy6DFqn7J8Iqdtb46MwSIbDmz23uA
         U6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMmONeDZhRsfRYenu3fsdwuxvPajRN7/ApHlNDbguPQ=;
        b=MYD6qk8u7Aq/b2rD3KPDtgHy7eDsX8TG9WOFnZfjlhq5m/9kS6m5P6Fag+PkEZO0H2
         cvuzAFyM9t7UAJwDAjPmzjC9TrYKvOy8d62yaRxmoWkMJ9i4DtGLuS6fd8W8rUkdMU2j
         yThkX7pmzKRZaqzmxYvI2TULPa2MhJQgJ/qwdSoVOo9QU51V+h/3RjlAPPWn4Y1S4ulE
         X2Ghu2QvLqFojp9lFblYuYrvY4e8xmjRVZPF0JfAOoP1iBbBvopl2+tTXqUxnCWOsnE+
         AFerXEPOdgoZoj59teqyHpafNO7UV+OAI814J0DSh2kJ+PqH+1XQwYgH4DYFl0lQomUF
         wRBA==
X-Gm-Message-State: AFqh2krQ9QPbxBbE9HVoI1khl8PHEiK6TZpiIvRBbX3Cy4SIc+cNXHcC
        agY1Y5g4wvgjO9c6Af6WHtLhVgSpjtc/tnMY
X-Google-Smtp-Source: AMrXdXuQ5Q7cd5DOaU1a35I5qFByRezT/TNbnvDB/nPoo5UD/uGnkAVP9cU36gf8YA6RbJ0CrF4M1Z/gEQoDQ92V
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:58f:0:b0:727:6671:ff85 with SMTP id
 l15-20020a5b058f000000b007276671ff85mr4592846ybp.585.1672913945077; Thu, 05
 Jan 2023 02:19:05 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:06 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-9-jthoughton@google.com>
Subject: [PATCH 08/46] hugetlb: add HugeTLB HGM enablement helpers
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

hugetlb_hgm_eligible indicates that a VMA is eligible to have HGM
explicitly enabled via MADV_SPLIT, and hugetlb_hgm_enabled indicates
that HGM has been enabled.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 14 ++++++++++++++
 mm/hugetlb.c            | 23 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index aa49fd8cb47c..8713d9c4f86c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1207,6 +1207,20 @@ static inline void hugetlb_unregister_node(struct node *node)
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
+bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
+#else
+static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
+{
+	return false;
+}
+static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
 					struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2f86fedef283..d27fe05d5ef6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6966,6 +6966,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
+#endif
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	if (hugetlb_hgm_enabled(vma))
+		return false;
 #endif
 	/*
 	 * Only shared VMAs can share PMDs.
@@ -7229,6 +7233,25 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
 
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
+{
+	/*
+	 * All shared VMAs may have HGM.
+	 *
+	 * HGM requires using the VMA lock, which only exists for shared VMAs.
+	 * To make HGM work for private VMAs, we would need to use another
+	 * scheme to prevent collapsing/splitting from invalidating other
+	 * threads' page table walks.
+	 */
+	return vma && (vma->vm_flags & VM_MAYSHARE);
+}
+bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
+{
+	return vma && (vma->vm_flags & VM_HUGETLB_HGM);
+}
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+
 /*
  * These functions are overwritable if your architecture needs its own
  * behavior.
-- 
2.39.0.314.g84b9a713c41-goog

