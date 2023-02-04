Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB368A814
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjBDEG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjBDEGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:06:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8781193E3C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675483609; x=1707019609;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xPznNTTYEOG4Wgd/WE5V34/CM30jMXDiAV2/7i6RFQ0=;
  b=LHOFfvzIUQXyO3LMDkcSrL3Wk6fhPcpe7VMa5L0t3PWPcO4Uvbbnk23W
   ia/4PqNfkE8knqbCTonmKNmq16Hn3jRDsa8zwKelfHRwH9bL2zuAR+ocr
   Gs9t3idcKASwVNaW40YKefEeCApBaMFge6uupaaD8aK6IKu0/Fq1U/6CZ
   cXFjL3rEO+IgfcMwdwWlBYAEeBDMtFLimdHrNd84LxDpoKqadO4Ao8ise
   pGUJ4DAhrbbDhDkWYuKd792Z1oO0VvRBwydcer3RlqXXdzWTxTSGbJbRO
   2LM9AJrvm5ZtsuwfdFckP+gykrDyy2B0Sbj7K7jjr8rMCSGk4A22+1vop
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="391309373"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="391309373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="734573734"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="734573734"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.125.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:47 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 03 Feb 2023 20:06:33 -0800
Subject: [PATCH v2 2/4] tee: Remove vmalloc page support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-get_kernel_pages-v2-2-f1dc4af273f1@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675483603; l=2347;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=xPznNTTYEOG4Wgd/WE5V34/CM30jMXDiAV2/7i6RFQ0=;
 b=zI8xrMYrd7xg0YhdT9eEp6Z83hAZpqExdK8hmPMgjoJ6qOuEy8ld7Ir/IYtcWFpxBVOS3FyxJzDM
 vG51TsTlAIyGPK7gBX8LG5wQeeEIUZ7KSW8JEbAuIHayiyf/Ewxa
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

Remove the vmalloc page support from shm_get_kernel_pages().  Replace
with a warn on once.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
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
2.39.1
