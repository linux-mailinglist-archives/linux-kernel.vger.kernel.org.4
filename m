Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411FE607C60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJUQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJUQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:23 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C20277A14
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:21 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id m185-20020a6771c2000000b00390d0a1217aso1031538vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+WerD0u1o5rdjYYXB/kVnQa0VLhkM9eeGW4etvGwB4=;
        b=tdKQZAo0gYs0G2kdztjg1TX/oj/RnJXrve82tS8xBK6mSdOdMhGNTvkXAs8ZVxrK7z
         c8Kzgsu4FgaGzd7K4NG6nHrY9Icl4OgkNHSsL2+fveGeW7tPGAvA7jOfo/RrP3+xhVsj
         hj3HZu2VVZPzkXEDKmJLfia5sRbAnjgM+kgr5WU35yWKtsbyjTr1njgKfeGFoYirHR50
         cSTvm6iAX5EBkULkMrNaZyqGJUKF7r8UPQRlxf5X/7PYgCLrcqJENsCKtKyvvJj2Wm1K
         9YyCpBMTJx1mwbB+Hpr2b1STLxNq4+6UD5uPyGqMcDZTJDNCR2PlND0UA0Ab0EPHpo7w
         JnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+WerD0u1o5rdjYYXB/kVnQa0VLhkM9eeGW4etvGwB4=;
        b=IxGNPGDzH58a/yH0mVo4hKr5CbxTpG84kGKUuqN6zLMEqODbi/O35k9NqEZQaZweQU
         1CeTVPW+PWMOxxrmCWeH28sOX1QMkzhD7bpKkkAzcAagB25B1EBbkNY3JcFB6hkYw1ec
         xLkzDpOlMbzWIblSzAqe/C1ARFLn0OyqfWuU8EHddJp40ek4llDfAEuP5Jg4ajiKRCXa
         3P58OIQNJO55SZ0DNOgj65XfKP8SdRabtHfDyWeCPgcZqCvhjSvBR/YjBrBX5AbdTxAO
         cG2vdpXcm8DVIt3nAP/sAPNH7D8lmsNkUG24oM67Np8ULGSmMmM+BezwHwvq5vNp5XM2
         pTfg==
X-Gm-Message-State: ACrzQf1sdo0pS7LirXi42T8djTE4WWisMiPCc6T+jcnv7x+nAQLKRiX0
        DB+efbhMIjTHt2bOBmVqtrg++TI+eGlnWkC0
X-Google-Smtp-Source: AMsMyM6gtOTS1JtxBT054d/UW8WqhzjYFLQgqbNi7vzatLh9x6zB+jmUsXXfe5Kdu0BRGsbHY5icbADcYMj/NEsT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:aa42:0:b0:3ab:81ee:8fa9 with SMTP
 id t63-20020a1faa42000000b003ab81ee8fa9mr12468300vke.17.1666370240102; Fri,
 21 Oct 2022 09:37:20 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:20 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-5-jthoughton@google.com>
Subject: [RFC PATCH v2 04/47] hugetlb: only adjust address ranges when VMAs
 want PMD sharing
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

Currently this check is overly aggressive. For some userfaultfd VMAs,
VMA sharing is disabled, yet we still widen the address range, which is
used for flushing TLBs and sending MMU notifiers.

This is done now, as HGM VMAs also have sharing disabled, yet would
still have flush ranges adjusted. Overaggressively flushing TLBs and
triggering MMU notifiers is particularly harmful with lots of
high-granularity operations.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 20a111b532aa..52cec5b0789e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6835,22 +6835,31 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
+static bool pmd_sharing_possible(struct vm_area_struct *vma)
 {
-	unsigned long start = addr & PUD_MASK;
-	unsigned long end = start + PUD_SIZE;
-
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
 #endif
 	/*
-	 * check on proper vm_flags and page table alignment
+	 * Only shared VMAs can share PMDs.
 	 */
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return false;
 	if (!vma->vm_private_data)	/* vma lock required for sharing */
 		return false;
+	return true;
+}
+
+bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
+{
+	unsigned long start = addr & PUD_MASK;
+	unsigned long end = start + PUD_SIZE;
+	/*
+	 * check on proper vm_flags and page table alignment
+	 */
+	if (!pmd_sharing_possible(vma))
+		return false;
 	if (!range_in_vma(vma, start, end))
 		return false;
 	return true;
@@ -6871,7 +6880,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 	 * vma needs to span at least one aligned PUD size, and the range
 	 * must be at least partially within in.
 	 */
-	if (!(vma->vm_flags & VM_MAYSHARE) || !(v_end > v_start) ||
+	if (!pmd_sharing_possible(vma) || !(v_end > v_start) ||
 		(*end <= v_start) || (*start >= v_end))
 		return;
 
-- 
2.38.0.135.g90850a2211-goog

