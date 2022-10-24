Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F13760992F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJXEfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJXEfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:35:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FC1248CD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666586102; x=1698122102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZBlPxqq4LjioAqMcl77X4b+mE9LrGUprIKCn0OV7KE=;
  b=DensI+mXVOXgkGaL8Fr27f02H9TqLDJS1Z1SpSFfV6CtykpHCB2Ma/v8
   LxbImvZbjwBiEZtB3k9Ew47DRBd7PjnqeOAoK7vSzm1jnqIE0LCYFyXtp
   zhmWMwdi58DD7x8GRDg+sx3lTknpWxKJDgkOHtEo2FeY6yCqHJ8zVZw/t
   ZQWEOAQO0g7BCgYv+XqnPxH3cA3ORADvNToRbRdJx5FG2Nj4iPIeRO1VE
   L2pbL+3ST7u0uGlQCFUe+cPZy8Mx5d3+OEdtrgn4Xm+z5FN5IBuhrQ5XI
   GmRjQHuKeOf6ehMUKeRpspS18Jhde0C0IMcQV6a7RxI/HfKkyskVk/LFJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="290638532"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="290638532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:35:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="736273355"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="736273355"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.252.130.95])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:35:01 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/userfaultfd: Replace kmap/kmap_atomic() with kmap_local_page()
Date:   Sun, 23 Oct 2022 21:34:52 -0700
Message-Id: <20221024043452.1491677-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page() which is appropriate for any thread local context.[1]

A recent locking bug report with userfaultfd showed that the conversion
of these kmap_atomic()'s required care with regard to the prevention of
deadlock.[2]

Complete kmap conversion in userfaultfd by replacing the kmap() and
kmap_atomic() calls with kmap_local_page().  When replacing the
kmap_atomic() call ensure page faults continue to be disabled to support
the correct fall back behavior and add a comment to inform future souls
of the requirement.

[1] https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/all/Y1Mh2S7fUGQ%2FiKFR@iweiny-desk3/

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/userfaultfd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e24e8a47ce8a..c5db06f4d28d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -157,11 +157,18 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		if (!page)
 			goto out;
 
-		page_kaddr = kmap_atomic(page);
+		page_kaddr = kmap_local_page(page);
+		/*
+		 * The mmap_lock is held here.  Disable page faults to
+		 * prevent deadlock should copy_from_user() fault.  The
+		 * copy will be retried outside the mmap_lock.
+		 */
+		pagefault_disable();
 		ret = copy_from_user(page_kaddr,
 				     (const void __user *) src_addr,
 				     PAGE_SIZE);
-		kunmap_atomic(page_kaddr);
+		pagefault_enable();
+		kunmap_local(page_kaddr);
 
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
@@ -646,11 +653,11 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!page);
 
-			page_kaddr = kmap(page);
+			page_kaddr = kmap_local_page(page);
 			err = copy_from_user(page_kaddr,
 					     (const void __user *) src_addr,
 					     PAGE_SIZE);
-			kunmap(page);
+			kunmap_local(page_kaddr);
 			if (unlikely(err)) {
 				err = -EFAULT;
 				goto out;
-- 
2.37.2

