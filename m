Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C91C69B6B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBRA3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBRA2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:53 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7673F62FF2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:52 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id s31-20020a9f3662000000b00683c94d9881so924538uad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVR7nxu9NqFl8iop5UBI5tIYqVwEs8TwTl7GvIiAmDc=;
        b=f9I/sF017TCFQ06v8JVGvP2Gz6zjUBu/YI/6tPRqHUhBratYAP73U723CvkiNRmX+2
         Xq1dOa8TR7SCr3LVAGWBGIMiSfJg1XkFZM5gm/al2A53lbtwLqPsmpTxwC6EJWviOgyV
         6ZoThnT1qOoxqJ91hnxCH3KMvw34Z4n+qBZp+x8ogItt4N49rc+X+Kia1yaFeZctlPrt
         dHqaxn4yVk5u2oBjIzFDTnhm8t11FS1zIMAY2JsmW8Lyk6cGaRH4PRACzyyvtyhEDhjv
         2AMBPlp0rxu60Rp9Xuc47FP4zxAkrddmeJ3HXqOflP02EXV117YxiSCeFjnJ8DA0bJ1V
         pWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVR7nxu9NqFl8iop5UBI5tIYqVwEs8TwTl7GvIiAmDc=;
        b=FAup0ns9VEeANrNpxNVtn4sv/iM06UQ3zsrPsLB7byECciDfxDoyJGP5BLQDdHwvqW
         jhwWtl1AB15EBfYt/xO4JszZKNLPTwVwoEI6F13tyubgk+tXOi18Fj2R45ugpe9kkzn2
         E4+JJOHfE9EVsPbbo66k4kOJuXaxAlpper/InArBOmXzXSfezKlWjiouLLFSv0ePE5Rj
         ft6NzPZ5XSanl38OBeLIGyBk7Ml2gCjFEkgof0Twke7KviXNLezEp8Xuecl/Y+pccyqR
         aoKwXhtM/WwOLGLJKUDEam/M6tCHqp+7IjcAgJF21xWJY+UFaAAWJuUzm+tKIPkuO68B
         DkEA==
X-Gm-Message-State: AO0yUKVymVzqsQdj/pmLtfmftBmjFhxeePVwbb7aUKJaDhGE/IeeVagK
        wUwK8WmherXvk2/pLLMh0RE5cJ0i4AbCGTgy
X-Google-Smtp-Source: AK7set+7kve29zHBIESSAgNBn7bVNkTyjU2Wm0RcYZpG6xt7UjvZapCdpaj7ibFEOjWwLks8K3N9f134pdwQEDVw
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:21c4:0:b0:406:983c:e6de with SMTP
 id h187-20020a1f21c4000000b00406983ce6demr657672vkh.1.1676680131643; Fri, 17
 Feb 2023 16:28:51 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:41 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-9-jthoughton@google.com>
Subject: [PATCH v2 08/46] hugetlb: add HugeTLB HGM enablement helpers
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

hugetlb_hgm_eligible indicates that a VMA is eligible to have HGM
explicitly enabled via MADV_SPLIT, and hugetlb_hgm_enabled indicates
that HGM has been enabled.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7c977d234aba..efd2635a87f5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1211,6 +1211,20 @@ static inline void hugetlb_unregister_node(struct node *node)
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
index 6c008c9de80e..0576dcc98044 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7004,6 +7004,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
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
@@ -7267,6 +7271,18 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
 
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
+{
+	/* All shared VMAs may have HGM. */
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
2.39.2.637.g21b0678d19-goog

