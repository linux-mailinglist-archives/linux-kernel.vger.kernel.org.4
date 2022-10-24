Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913D60992C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJXEdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJXEdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:33:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306BA754BC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666585995; x=1698121995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ObwjONVUV1m6qgO+y0lFIH+jDLUNTJNwafsT6+bksmU=;
  b=lcPUjuqYqGSIRxorcfoUyv7MFrikZc9F6mbTLR85g+56kOSlhWTAsfmu
   B07hQElMoTSZh4tMByzlAfOaTQWFoQOR/Hmz+BtfqKGXzPSOWmv1VEAD5
   9xQp3A8sqW+5z+uUJp7OiTYyZ25ZPwqrgsvqe7CQnvpxj8BO0lVeNAStS
   /a+icmkPM0Z+qT8N87nG64HnIpe8aSkJAQuisk+Pc9OaJO7t+SlPp45wU
   P0VbmC0P8ZH0RgBVP5XvpVDuzjiyzi/WVqaQKmaXoT4sHwQza5Wap6xv+
   iVSkuKarhd5lxmRtSCveQQIJ5crqikibPNQJlT+C7bgb4Ow+5XyFKT6Fc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="371555184"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="371555184"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:33:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="694424439"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="694424439"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.252.130.95])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:33:12 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH for rc] mm/shmem: Ensure proper fallback if page faults
Date:   Sun, 23 Oct 2022 21:33:05 -0700
Message-Id: <20221024043305.1491403-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The kernel test robot flagged a recursive lock as a result of a
conversion from kmap_atomic() to kmap_local_folio()[Link]

The cause was due to the code depending on the kmap_atomic() side effect
of disabling page faults.  In that case the code expects the fault to
fail and take the fallback case.

git archaeology implied that the recursion may not be an actual bug.[1]
However, the mmap_lock needed in the fault may be the one held.[2]

Add an explicit pagefault_disable() and a big comment to explain this
for future souls looking at this code.

[1] https://lore.kernel.org/all/Y1MymJ%2FINb45AdaY@iweiny-desk3/
[2] https://lore.kernel.org/all/Y1M2p9OtBGnKwGUE@x1n/

Fixes: 7a7256d5f512 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210211215.9dc6efb5-yujie.liu@intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Thanks to Matt and Andrew for initial diagnosis.
Thanks to Randy for pointing out C code needs ';'  :-D
Thanks to Andrew for suggesting an elaborate comment
Thanks to Peter for pointing out that the mm's may be the same.
---
 mm/shmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8280a5cb48df..c1bca31cd485 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2424,9 +2424,16 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 		if (!zeropage) {	/* COPY */
 			page_kaddr = kmap_local_folio(folio, 0);
+			/*
+			 * The mmap_lock is held here.  Disable page faults to
+			 * prevent deadlock should copy_from_user() fault.  The
+			 * copy will be retried outside the mmap_lock.
+			 */
+			pagefault_disable();
 			ret = copy_from_user(page_kaddr,
 					     (const void __user *)src_addr,
 					     PAGE_SIZE);
+			pagefault_enable();
 			kunmap_local(page_kaddr);
 
 			/* fallback to copy_from_user outside mmap_lock */
-- 
2.37.2

