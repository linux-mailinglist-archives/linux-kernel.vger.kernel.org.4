Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4736FBB7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjEHXlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjEHXlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:41:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338D4C31
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:41:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef302a642eso26898611cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1683589263; x=1686181263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXyotAzP+VPxO7VVOPWj4wSwSUrdQsmucc2QXoXVneg=;
        b=NTno1hBVsyYnrek/PMyx+m0tZ4K6xLpWDC5gWFZAj5BshzMxsP27OcOq9NTagyo2CV
         hGa+Qmu7sVB7GX5230dpYckispNBjEyXREQoEFQfu7B0uTZR9iDtw5oX/hbAYSci3Sz0
         cqncSiXX0P+NmbipJgflFGAOCQ618y+daoGrNS5F2/b+IX1QZkmxqQjFcn8pG1+kv7uT
         gi0kJ7wnJlyDCkutOEAcs3/BgT2JHla/snfnbtSVw5EVkSbtucoLHsNhhsKNvjKCQIl9
         MDAshjNqjW6Zp3oeQIqS+Jji2ZAQ7Skk7zk1AcMEa2Egpv3ts99audqtXnm/RJHqbaqW
         lKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683589263; x=1686181263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXyotAzP+VPxO7VVOPWj4wSwSUrdQsmucc2QXoXVneg=;
        b=HVkVGUu02gbyQg996UngfkrVtoRXHqBVbk2UV4QicQ2YLLHmxvwwsd73dd08CGamvu
         2J3rh76K4pOaJF8zhY4/GHiOD35y2qunRP2/c+1icERQXV6YS/1yYbyrksf9wLtwqsU6
         R5Xl2yjyUJG8qhCAinJRDd+m4Zu1XfowWIqi8T4OCsrC6oAHuW4sbYxvESuTP71oI2Ru
         RLFQD2yDR1KhtqeEa+6YrpyewP3q7qU1jOheUUhaBntNXFPbAQ7dfSFJNln/dAJtIfsr
         WAZpCVQ9aU0t0aMFppMJVJoNTi27d7E0SEXOrwaoE13GI1TORPVaBbBE/F42B/T7B13U
         /hZg==
X-Gm-Message-State: AC+VfDxmufmIekoyeon3CT6urI5A27Jit5pr3i+tC6UJbZzv9mK1dcC6
        P+zxKS4CpTkxycUMbNouVbYTGA==
X-Google-Smtp-Source: ACHHUZ5K/IMkHlHxC6ISgy6AEyScv8HjSVfJbJ1Lzy2TT/TOP0WrdHo7hSGOMDmQcFxJTwRpeksFKg==
X-Received: by 2002:a05:622a:1708:b0:3ef:3f51:dad5 with SMTP id h8-20020a05622a170800b003ef3f51dad5mr18505310qtk.20.1683589263162;
        Mon, 08 May 2023 16:41:03 -0700 (PDT)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id j29-20020a05620a001d00b0074411b03972sm1357415qki.51.2023.05.08.16.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:41:02 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mhocko@suse.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: [PATCH v3] mm: hugetlb_vmemmap: provide stronger vmemmap allocation guarantees
Date:   Mon,  8 May 2023 23:40:59 +0000
Message-ID: <20230508234059.2529638-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HugeTLB pages have a struct page optimizations where struct pages for tail
pages are freed. However, when HugeTLB pages are destroyed, the memory for
struct pages (vmemmap) need to be allocated again.

Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
but given that this flag makes very little effort to actually reclaim
memory the returning of huge pages back to the system can be problem. Lets
use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
reclaim without causing ooms, but at least it may perform a few retries,
and will fail only when there is genuinely little amount of unused memory
in the system.

Freeing a 1G page requires 16M of free memory. A machine might need to be
reconfigured from one task to another, and release a large number of 1G pages
back to the system if allocating 16M fails, the release won't work.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Suggested-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb_vmemmap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Changelog:
v3
  - updated patch log to include details about when the failure can happen.
v2
  - removed gfp_mask argument from alloc_vmemmap_page_list as suggested by
    David Rientjes.
  - Fixed spelling in the patch title.

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 27f001e0f0a2..f42079b73f82 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -384,8 +384,9 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 }
 
 static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
-				   gfp_t gfp_mask, struct list_head *list)
+				   struct list_head *list)
 {
+	gfp_t gfp_mask = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE;
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
@@ -413,12 +414,11 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
- * @gfp_mask:	GFP flag for allocating vmemmap pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse, gfp_t gfp_mask)
+			       unsigned long reuse)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
@@ -430,7 +430,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 	/* See the comment in the vmemmap_remap_free(). */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
+	if (alloc_vmemmap_page_list(start, end, &vmemmap_pages))
 		return -ENOMEM;
 
 	mmap_read_lock(&init_mm);
@@ -476,8 +476,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse,
-				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-- 
2.40.1.521.gf1e218fcd8-goog

