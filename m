Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2E71FDE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjFBJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjFBJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:30:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEA4BE51
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:30:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 053C21063;
        Fri,  2 Jun 2023 02:30:49 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD1E3F7BD;
        Fri,  2 Jun 2023 02:30:01 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Subject: [PATCH v3 0/4] Fixes for pte encapsulation bypasses
Date:   Fri,  2 Jun 2023 10:29:45 +0100
Message-Id: <20230602092949.545577-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first half of v3 of a series to improve the encapsulation of pte
entries by disallowing non-arch code from directly dereferencing pte_t pointers.
Based on earlier feedback, I've split the series in 2; this first part contains
fixes for existing bugs that were discovered during the work. The second part,
which contains the new changes I'm adding, will be posted separately.

These fixes have had a fair amount of review now so I hope they can be
considered for addition to the appropriate mm- branch as is. And I've cc'ed
stable since I believe they should be candidates for backport.

See the v1 cover letter at [1] for rationale and explanation of overall
objective (requires both parts of the split series to achieve).

The series is split up as follows:

patch 1-2:  Fix bugs where code was _setting_ ptes directly, rather than using
            set_pte_at() and friends. Data corruption was theoretically
	    possible.
patch 3:    Minor refactoring requested in v2 review.
patch 4:    Fix highmem unmapping issue I spotted while doing the work.

Patches are based on v6.4-rc4 and a branch is available at [3].

Changes since v2 [2]:
   - patch 2: minor commit message rewording to fix review nits
   - patch 3: Refactored damon code to use {pte|pmd}p_clear_young_notify()
   - patch 1-4: applied Ack/Reviewed-by tags; thanks for those!

Changes since v1 [1]:
   - patch 1: Refactored pfn to use local variable
   - patch 1-2: Minor rewording of commit message: 'verify' -> 'check'
   - patch 1-3: applied Ack/Reviewed-by tags; thanks for those!

[1] https://lore.kernel.org/linux-mm/20230511132113.80196-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230518110727.2106156-1-ryan.roberts@arm.com/
[3] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/bugs/pte_encapsulation_bypasses-lkml_v3

Thanks,
Ryan

Ryan Roberts (4):
  mm: vmalloc must set pte via arch code
  mm/damon/ops-common: atomically test and clear young on ptes and pmds
  mm/damon/ops-common: Refactor to use {pte|pmd}p_clear_young_notify()
  mm: Fix failure to unmap pte on highmem systems

 mm/damon/ops-common.c | 30 ++++--------------------------
 mm/damon/ops-common.h |  4 ++--
 mm/damon/paddr.c      |  4 ++--
 mm/damon/vaddr.c      |  4 ++--
 mm/memory.c           |  6 ++----
 mm/vmalloc.c          | 10 ++++++++--
 6 files changed, 20 insertions(+), 38 deletions(-)

--
2.25.1

