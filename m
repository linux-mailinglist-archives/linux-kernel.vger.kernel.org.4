Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E96FF2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbjEKNXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbjEKNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:23:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB1221157C
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:21:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF9C1684;
        Thu, 11 May 2023 06:22:11 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B85EA3F5A1;
        Thu, 11 May 2023 06:21:25 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: [RESEND PATCH v1 3/5] mm: Fix failure to unmap pte on highmem systems
Date:   Thu, 11 May 2023 14:21:11 +0100
Message-Id: <20230511132113.80196-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511132113.80196-1-ryan.roberts@arm.com>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loser of a race to service a pte for a device private entry in the
swap path previously unlocked the ptl, but failed to unmap the pte. This
only affects highmem systems since unmapping a pte is a noop on
non-highmem systems.

Fixes: 16ce101db85d ("mm/memory.c: fix race when faulting a device private page")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..ed429e20a1bb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3728,10 +3728,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
-				spin_unlock(vmf->ptl);
-				goto out;
-			}
+			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
+				goto unlock;

 			/*
 			 * Get a page reference while we know the page can't be
--
2.25.1

