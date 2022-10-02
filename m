Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724BD5F20BB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJBAXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJBAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:23:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335C53039
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664670213; x=1696206213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rnaezL/AbXrdYNjWPYKIXI3BC43DB1DUbdzw9KizDgQ=;
  b=cFzwCSwGUI0st8DwyNrSBo0E6J0O6N67zH7x5XxPRt9gXl3ag2mS8HfD
   Wf2bS7dYDr0VYRpb2vJFK32EHTNNqaAWr4W4UO5GuYLTegt3CL32UnIhs
   LtmfrZUK7ubwScrD+VE0LjSwOc1LJVBt5luw9u4XjPCEkxdLDIWUUR5c1
   LZSrLUGwlPZCKDOmlTPC7c0O8cOxlLrUkuD7FnkBmdC0hQSqeA1HpGeg5
   E94RSZ/bOe1wZS33B2r1H1sWg78cSfxRsywsuFsvlSpvuDBkJxFCeLu2e
   FuXGg00vz0Isr8Co+j0ZMsp/GsWYAZl1GYDHiyFHERli4Z3OD9PgTW09p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="285564523"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="285564523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="656347042"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="656347042"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.181.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:32 -0700
From:   ira.weiny@intel.com
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Date:   Sat,  1 Oct 2022 17:23:25 -0700
Message-Id: <20221002002326.946620-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221002002326.946620-1-ira.weiny@intel.com>
References: <20221002002326.946620-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The kernel pages used by shm_get_kernel_pages() are allocated using
GFP_KERNEL through the following call stack:

trusted_instantiate()
	trusted_payload_alloc() -> GFP_KERNEL
	<trusted key op>
		tee_shm_register_kernel_buf()
			register_shm_helper()
				shm_get_kernel_pages()

Where <trusted key op> is one of:

	trusted_key_unseal()
	trusted_key_get_random()
	trusted_key_seal()

Because the pages can't be from highmem get_kernel_pages() boils down to
a get_page() call.

Remove the get_kernel_pages() call and open code the get_page().

In case a kmap page does slip through warn on once for a kmap address.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/tee/tee_shm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 527a6eabc03e..45e6ff1a452e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -11,6 +11,7 @@
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/highmem.h>
 #include "tee_private.h"
 
 static void shm_put_kernel_pages(struct page **pages, size_t page_count)
@@ -26,9 +27,9 @@ static int shm_get_kernel_pages(unsigned long start, size_t page_count,
 {
 	struct kvec *kiov;
 	size_t n;
-	int rc;
 
-	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
+	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
+			 is_kmap_addr((void *)start)))
 		return -EINVAL;
 
 	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
@@ -38,12 +39,12 @@ static int shm_get_kernel_pages(unsigned long start, size_t page_count,
 	for (n = 0; n < page_count; n++) {
 		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
 		kiov[n].iov_len = PAGE_SIZE;
+		pages[n] = virt_to_page(kiov[n].iov_base);
+		get_page(pages[n]);
 	}
-
-	rc = get_kernel_pages(kiov, page_count, 0, pages);
 	kfree(kiov);
 
-	return rc;
+	return page_count;
 }
 
 static void release_registered_pages(struct tee_shm *shm)
-- 
2.37.2

