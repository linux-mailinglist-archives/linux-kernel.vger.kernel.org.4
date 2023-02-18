Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49469B6B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBRA3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBRA2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9BA59732
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365936facfso20637387b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywqgi26Brd11uCoWP0sbMHtbYsofzUY9ZAimSzTW2NE=;
        b=n/AuNA+wao69AJqH2jxvia/RDl00z2MfIhcsqjJucnXsT0cN+rnMxxAJPhBDLk5ZSi
         MCiuvlZOLO6F7xC0qObRnm2Fw7Kk4xKcB8RUyTN9WchfsVg6IiD35+jkjOxG7TArgt04
         nthdLjbi+YqMB//69CKeg7ZPl8QIrBQY7Ll3FExxGFCSIT1L0xNOUp19y9PDuIe+SxhZ
         B4Zyh5fsXW/P04RT85l9L0piLa0E//fpZzktUrEB+JJqehCEtNNVOMSTn6SN8kGNhUKz
         UMxeGr/Oj6oj5yYpspoF7jsafZJJiQT+dGrZV68rl4q3U6mgeh9r3mvqGZ+fe/wLSD9M
         jzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywqgi26Brd11uCoWP0sbMHtbYsofzUY9ZAimSzTW2NE=;
        b=krrTtTPp1MUrJHSb8GgjBn4L/tTomeHYvpDdjYpzejPTBRA18rxCgjY7GHp7+0v3by
         KYElLJQd5OAwJ5pXMfRuXvwngMfZz2n6TZlDnAnIrCcVkgAG/NopjtzO3ScxFnBrBz6+
         0YMcaFuHS7YUEDpLaBUrOjf5VIeG9p8SVOmMMG6gvkyH9c15GGrP3KJZAhsNtV6FRi/G
         JN17aIudVJDlaFMMnCY0IJmGrW6MOg0JmRpqxAHtZK81+oW2+kkORHR8evrwZvP3I9Fq
         uhBr86WhR15hUM9AGP5gGYUyDMPJLDuhvCUt0Brt1hNY1Uvjw/23kob9BzdjrwySuRXD
         IpoQ==
X-Gm-Message-State: AO0yUKUYl5XgNYC3pm6BWlKhCVGXYcnngVu/ZQ/NzqSJ6C3OIE+hrto/
        vuDZaV779mIm31QKoFzvo7MaSsBwVraagJCp
X-Google-Smtp-Source: AK7set91EOlgY73vi4WtH0/wZAAYWGqc3EHj1NmJd/UToA1QLT2ebGJE6OT31llBzsdBdICY2Qgx1JjnImasJfkA
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:84:0:b0:902:5b5c:73f7 with SMTP id
 b4-20020a5b0084000000b009025b5c73f7mr14406ybp.12.1676680127282; Fri, 17 Feb
 2023 16:28:47 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:37 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-5-jthoughton@google.com>
Subject: [PATCH v2 04/46] hugetlb: only adjust address ranges when VMAs want
 PMD sharing
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

Currently this check is overly aggressive. For some userfaultfd VMAs,
VMA sharing is disabled, yet we still widen the address range, which is
used for flushing TLBs and sending MMU notifiers.

This is done now, as HGM VMAs also have sharing disabled, yet would
still have flush ranges adjusted. Overaggressively flushing TLBs and
triggering MMU notifiers is particularly harmful with lots of
high-granularity operations.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 540cdf9570d3..08004371cfed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6999,22 +6999,31 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
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
@@ -7035,7 +7044,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 	 * vma needs to span at least one aligned PUD size, and the range
 	 * must be at least partially within in.
 	 */
-	if (!(vma->vm_flags & VM_MAYSHARE) || !(v_end > v_start) ||
+	if (!pmd_sharing_possible(vma) || !(v_end > v_start) ||
 		(*end <= v_start) || (*start >= v_end))
 		return;
 
-- 
2.39.2.637.g21b0678d19-goog

