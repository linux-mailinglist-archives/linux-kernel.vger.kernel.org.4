Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98DE5F20BA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJBAXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJBAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:23:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F74853024
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664670212; x=1696206212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSTT9RCqaAKsDAKHEpxgRwFsvLUWOLIZHfpn9oZ87V8=;
  b=PKkmlvFvARDlMFc1wqs+EBfozyiCC3NJ746ywLwREZBjdnIn4w0xl9JB
   QL4GIE/nuCwMdoQaZLFl5mBmf8hqTzKcTxIAvX5NA+S6wPScD2F6gRQDC
   mnnHNEnPPrEBG03UzujovnPjcJeL+R+SM3RcyXld8xaTylfd2chVXjivi
   9TzMBPpRCBxov/i5gZGqGseD2gzUs9/ICjOUYJY4fcrOKBSIMET0DRWnA
   iMa0C/xjpRYZ6GaVbbd+TM1G7WEFwYvJJBeS8wAxSbltuvRtHj93bTV8h
   mJmWibPiJR5fzu/0VgzZdXCOttPDD7pyrWpemHw/X2Q31mSQtfkA/H+Ac
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="285564521"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="285564521"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="656347038"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="656347038"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.181.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:31 -0700
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
Subject: [PATCH 2/4] tee: Remove vmalloc page support
Date:   Sat,  1 Oct 2022 17:23:24 -0700
Message-Id: <20221002002326.946620-3-ira.weiny@intel.com>
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

Remove the vmalloc page support from shm_get_kernel_pages().  Replace
with a warn on once.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Jens I went with the suggestion from Linus and Christoph and rejected
vmalloc addresses.  I did not hear back from you regarding Linus'
question if the vmalloc page support was required by an up coming patch
set or not.  So I assumed it was something out of tree.
---
 drivers/tee/tee_shm.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 27295bda3e0b..527a6eabc03e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -24,37 +24,25 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
 static int shm_get_kernel_pages(unsigned long start, size_t page_count,
 				struct page **pages)
 {
+	struct kvec *kiov;
 	size_t n;
 	int rc;
 
-	if (is_vmalloc_addr((void *)start)) {
-		struct page *page;
-
-		for (n = 0; n < page_count; n++) {
-			page = vmalloc_to_page((void *)(start + PAGE_SIZE * n));
-			if (!page)
-				return -ENOMEM;
-
-			get_page(page);
-			pages[n] = page;
-		}
-		rc = page_count;
-	} else {
-		struct kvec *kiov;
-
-		kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
-		if (!kiov)
-			return -ENOMEM;
+	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
+		return -EINVAL;
 
-		for (n = 0; n < page_count; n++) {
-			kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
-			kiov[n].iov_len = PAGE_SIZE;
-		}
+	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
+	if (!kiov)
+		return -ENOMEM;
 
-		rc = get_kernel_pages(kiov, page_count, 0, pages);
-		kfree(kiov);
+	for (n = 0; n < page_count; n++) {
+		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
+		kiov[n].iov_len = PAGE_SIZE;
 	}
 
+	rc = get_kernel_pages(kiov, page_count, 0, pages);
+	kfree(kiov);
+
 	return rc;
 }
 
-- 
2.37.2

