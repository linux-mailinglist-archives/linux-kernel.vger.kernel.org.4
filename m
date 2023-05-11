Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A4F6FF1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbjEKM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjEKM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:59:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D1577AA1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:59:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE531688;
        Thu, 11 May 2023 05:59:57 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46B23F5A1;
        Thu, 11 May 2023 05:59:11 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: [PATCH v1 4/5] mm: Add new ptep_deref() helper to fully encapsulate pte_t
Date:   Thu, 11 May 2023 13:58:47 +0100
Message-Id: <20230511125848.78621-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511125848.78621-1-ryan.roberts@arm.com>
References: <20230511125848.78621-1-ryan.roberts@arm.com>
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

There are many call sites that directly dereference a pte_t pointer.
This makes it very difficult to properly encapsulate a page table in the
arch code without having to allocate shadow page tables. ptep_deref()
aims to solve this by replacing all direct dereferences with a call to
this function.

The default implementation continues to just dereference the pointer
(*ptep), so generated code should be exactly the same. However, it is
possible for the architecture to override the default with their own
implementation, that can (e.g.) hide certain bits from the core code, or
determine young/dirty status by mixing in state from another source.

While ptep_get() and ptep_get_lockless() already exist, these are
implemented as atomic accesses (e.g. READ_ONCE() in the default case).
So rather than using ptep_get() and risking performance regressions,
introduce an new variant.

Call sites will be converted to use the accessor in future commits.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5a51481bbb9..1161beab2492 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -204,6 +204,13 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef ptep_deref
+static inline pte_t ptep_deref(pte_t *ptep)
+{
+	return *(pte_t *)ptep;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
-- 
2.25.1

