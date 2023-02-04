Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD468A815
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjBDEHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjBDEGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:06:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886E1945F6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675483610; x=1707019610;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JQRhs8fV+wugaMbuU/xsYw9mo1fl9vkSLqCGXzy9tz8=;
  b=Kba6PoV/VGGmY/+Hli75SQWZkwzpheJr7ktIit3+KFvEVUqxxeOYdIsJ
   GsrXN+p8bK72qldZ0cUa6d2N0md1TJxyTU1bM5V7uh07kGycEaxc5KqDw
   JwaZxjMlK9rSC119BrIIqrZkscSnkT4nCx/ReRw+KrVDaTvkMIDOzVvmD
   3ifH3anQbbYjF1SS9BLrAQZ9jviYM0GW+92u2b9jdPJB/sFoU066zIhcz
   oZ9HuVv2DgOiqNw3rtlNcBkDYNxMd1gUroz0NlbgyXnMFkFsRAXIyunSI
   V5HzX82m4tmWNpQj0isUb35XPe3RI7QhX4W8OPpNzKAbeZg9UmaB8wyVh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="391309384"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="391309384"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="734573743"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="734573743"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.125.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 03 Feb 2023 20:06:34 -0800
Subject: [PATCH v2 3/4] tee: Remove call to get_kernel_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-get_kernel_pages-v2-3-f1dc4af273f1@intel.com>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-mm@kvack.org, Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675483603; l=2426;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=JQRhs8fV+wugaMbuU/xsYw9mo1fl9vkSLqCGXzy9tz8=;
 b=AaCtTJ4OiWZ81WHjyg8HuDS5/qjKjXFczxneo+wuWXA1er0d3AbqF8WmVH8OPaOMT7MFHfqplc4h
 8SdcI7hmA9jv/b3bsJlcrP/twziO9uzdZVNnfM9Qbjeiy1zfFBMX
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

In case a highmem page does slip through warn on once for a kmap'ed
address.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
	Al/Christoph: Remove kiov altogether
---
 drivers/tee/tee_shm.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 527a6eabc03e..b1c6231defad 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -11,6 +11,7 @@
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/highmem.h>
 #include "tee_private.h"
 
 static void shm_put_kernel_pages(struct page **pages, size_t page_count)
@@ -24,26 +25,20 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
 static int shm_get_kernel_pages(unsigned long start, size_t page_count,
 				struct page **pages)
 {
-	struct kvec *kiov;
+	struct page *page;
 	size_t n;
-	int rc;
 
-	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
+	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
+			 is_kmap_addr((void *)start)))
 		return -EINVAL;
 
-	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
-	if (!kiov)
-		return -ENOMEM;
-
+	page = virt_to_page(start);
 	for (n = 0; n < page_count; n++) {
-		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
-		kiov[n].iov_len = PAGE_SIZE;
+		pages[n] = page + n;
+		get_page(pages[n]);
 	}
 
-	rc = get_kernel_pages(kiov, page_count, 0, pages);
-	kfree(kiov);
-
-	return rc;
+	return page_count;
 }
 
 static void release_registered_pages(struct tee_shm *shm)

-- 
2.39.1
