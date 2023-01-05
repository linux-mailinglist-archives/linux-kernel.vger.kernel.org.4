Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475A965E8C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAEKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjAEKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4784FD69
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:18:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w9-20020a05690210c900b007b20e8d0c99so4516353ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fBYHLCr9oSB4M/a/ngoaaKhcuSrl4k3J29XD8vYb2Q=;
        b=NmgS3tlh8WUTbw91DNXzILqULTbddBWnPQn0Wz57ppipw1WObH6FkSpTww6yztM+jA
         6e8g5ZzoA5lVCAREHkwcp9nrWOI+Q0S0zYB3GUuo7cG78xBZHsz/CSyv57wBUHMoyAZn
         uMRawDWwRYn9gVztU7/tvicjuzxjqEUsaG6Q2Nh3CiNSMC3lromhxCi7P1Rw/hwbHL1F
         YmJbdMcEkKBiPCX4t46+UvV1gVJE1sWQPNJLWRGQKmx7VESDn0Z4IGBEAOvcilWvJwx0
         097HlvspkiuYJIAb7OcrrOPaSLfJxD3uYwyJHjA4LcqVHz5gZ4GhB3QpiX2mLa2tpK7P
         fY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fBYHLCr9oSB4M/a/ngoaaKhcuSrl4k3J29XD8vYb2Q=;
        b=wnmt2Kv9a9scTwKcMWBV9N6HLMXJDPxH6gUzS0IZe7ed7HwUOXbuQ2ugjsY7Dlqza+
         PE2OmeTptEQoFyzrWUaMXohnfVXvCB724Ke3caaEnSRnaf+J0rIDXrttE0byjJqdcSDx
         ju/+qxEy/POEfI+VIxKSBik8spJHW3bLNL4dShNIPXov6zsA/bAraTU8x1FF9Q9XYR9k
         7BsjlUtclgFGKm4z7igklXTaHomLmTSYWke82aFWtVrCBaZMoSayO+qh00pTwbuvAYLR
         Enh3M8Om+76+dWSj5jWhg5s+9G/pyzoDiJNmiEgzsVwCGS2tL+RRIWQU0PZIZukpXR4D
         bfUw==
X-Gm-Message-State: AFqh2kqKWT7mpbsj7iaYrWMoMdlDLlRR9qeZHUyYQrgKeH0CNnpn7LDc
        FvAzonvRCw2KGLLKNj7QupofZGkrMcXVgQWo
X-Google-Smtp-Source: AMrXdXtKSspcz64KdJshT2Zl/+9+WpY5XaxA4H4cZjlRHhAILIZdFfHdFt4D44YNQqdRUNZd3I9uCvlbO/Onyj2D
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:f311:0:b0:6ff:84be:717 with SMTP id
 c17-20020a25f311000000b006ff84be0717mr5385597ybs.314.1672913937929; Thu, 05
 Jan 2023 02:18:57 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:02 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-5-jthoughton@google.com>
Subject: [PATCH 04/46] hugetlb: only adjust address ranges when VMAs want PMD sharing
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

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7e9793b602ac..99fadd7680ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6961,22 +6961,31 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
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
@@ -6997,7 +7006,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 	 * vma needs to span at least one aligned PUD size, and the range
 	 * must be at least partially within in.
 	 */
-	if (!(vma->vm_flags & VM_MAYSHARE) || !(v_end > v_start) ||
+	if (!pmd_sharing_possible(vma) || !(v_end > v_start) ||
 		(*end <= v_start) || (*start >= v_end))
 		return;
 
-- 
2.39.0.314.g84b9a713c41-goog

