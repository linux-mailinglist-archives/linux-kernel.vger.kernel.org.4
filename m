Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347B55B7BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIMT72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIMT6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A075CD8;
        Tue, 13 Sep 2022 12:58:35 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q8so10091435qvr.9;
        Tue, 13 Sep 2022 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KeLoRQJB3eAOdyXC4NTd1TP4on3QCykrOlScFxq8ZPE=;
        b=FeFlqfsiEQU3HSeYb1n4gkpg1qmnB5WeDR3FybX0zPrw0OvjL/48yUYTNjXdAaMlAU
         JdyQzl2XCc8s8RP5OO/H5J7S/0xDcSLDPZ/g9EIPbcsw9LhFgl8pcNCL7ia4xS0HbBWk
         UrWVqsTOfQjwUdrXVkxZ/eY8sVsnX0gm6/fSQE07CBzEH1IsIWTpZVsPIgNRukD5QnzD
         c6mLxWXf85eq1Q9U3EFaUBdh/wEyMg/Ynk1wbDDmvjWml5kn5SQbnOB+ZusyeRT2gzZB
         30p18F8NjILejz6FdnbFmeCsFxJLxim3pDKbO19ZAHgQZI8N1Ooww3p9oQH3KqqVXxOk
         7Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KeLoRQJB3eAOdyXC4NTd1TP4on3QCykrOlScFxq8ZPE=;
        b=73KjvX/hW9b5RIPytF7VDZZ7S9LzWUCqudyw8RUyKfzCrGd7gkafXXeBavDigf4GBj
         +SVaqRADsGAZHfiNfxsflokn9wb9vAFNSGIygClAFJFwd57lWGwuVg5Q24TPJWd/v/2p
         MYiMhO8D17H8ltry2pZ4Ccufwbj3cZSDTgZwQgfx6JxVeeqNYizA+Ows5gzI3P1058Qw
         /xzwh4+hT2pQl3y8YpHrXDPAQtOokDevGK4nQd7NOahZX0d+iD5pN4BabwGc3rRlOOeG
         XmCeAmTeXJ8/SGlxX9p+dXKvSM9pRdbHieA4xMoRWsBdWkmeopsrYE2corD+GuECEJmv
         V+pg==
X-Gm-Message-State: ACgBeo1od7ThmtacegZzr+jd83r5Zf2XBxYxgTruXNP71wOOO7MifYy6
        ihRahicxK6tfQyxIngXEprQ=
X-Google-Smtp-Source: AA6agR6LdySz/okFv68gwh3HYvltSAZalCbl/B/p5X5bZPgANvOoXngUoiwr94jsBmavX1SN+2thWQ==
X-Received: by 2002:a05:6214:301a:b0:4ac:a4ec:b8b1 with SMTP id ke26-20020a056214301a00b004aca4ecb8b1mr13793217qvb.122.1663099114897;
        Tue, 13 Sep 2022 12:58:34 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:34 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 11/21] mm/page_alloc: introduce init_reserved_pageblock()
Date:   Tue, 13 Sep 2022 12:54:58 -0700
Message-Id: <20220913195508.3511038-12-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the implementation of init_cma_reserved_pageblock() is
common to the initialization of any reserved pageblock for use
by the page allocator.

This commit breaks that functionality out into the new common
function init_reserved_pageblock() for use by code other than
CMA. The CMA specific code is relocated from page_alloc to the
point where init_cma_reserved_pageblock() was invoked and the
new function is used there instead. The error path is also
updated to use the function to operate on pageblocks rather
than pages.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/gfp.h |  5 +----
 mm/cma.c            | 15 +++++++++++----
 mm/page_alloc.c     |  8 ++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f314be58fa77..71ed687be406 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -367,9 +367,6 @@ extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
-#ifdef CONFIG_CMA
-/* CMA stuff */
-extern void init_cma_reserved_pageblock(struct page *page);
-#endif
+extern void init_reserved_pageblock(struct page *page);
 
 #endif /* __LINUX_GFP_H */
diff --git a/mm/cma.c b/mm/cma.c
index 4a978e09547a..6208a3e1cd9d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kmemleak.h>
+#include <linux/page-isolation.h>
 #include <trace/events/cma.h>
 
 #include "cma.h"
@@ -116,8 +117,13 @@ static void __init cma_activate_area(struct cma *cma)
 	}
 
 	for (pfn = base_pfn; pfn < base_pfn + cma->count;
-	     pfn += pageblock_nr_pages)
-		init_cma_reserved_pageblock(pfn_to_page(pfn));
+	     pfn += pageblock_nr_pages) {
+		struct page *page = pfn_to_page(pfn);
+
+		set_pageblock_migratetype(page, MIGRATE_CMA);
+		init_reserved_pageblock(page);
+		page_zone(page)->cma_pages += pageblock_nr_pages;
+	}
 
 	spin_lock_init(&cma->lock);
 
@@ -133,8 +139,9 @@ static void __init cma_activate_area(struct cma *cma)
 out_error:
 	/* Expose all pages to the buddy, they are useless for CMA. */
 	if (!cma->reserve_pages_on_error) {
-		for (pfn = base_pfn; pfn < base_pfn + cma->count; pfn++)
-			free_reserved_page(pfn_to_page(pfn));
+		for (pfn = base_pfn; pfn < base_pfn + cma->count;
+		     pfn += pageblock_nr_pages)
+			init_reserved_pageblock(pfn_to_page(pfn));
 	}
 	totalcma_pages -= cma->count;
 	cma->count = 0;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ad38a81203e5..1682d8815efa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2302,9 +2302,8 @@ void __init page_alloc_init_late(void)
 		set_zone_contiguous(zone);
 }
 
-#ifdef CONFIG_CMA
-/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
-void __init init_cma_reserved_pageblock(struct page *page)
+/* Free whole pageblock */
+void __init init_reserved_pageblock(struct page *page)
 {
 	unsigned i = pageblock_nr_pages;
 	struct page *p = page;
@@ -2314,14 +2313,11 @@ void __init init_cma_reserved_pageblock(struct page *page)
 		set_page_count(p, 0);
 	} while (++p, --i);
 
-	set_pageblock_migratetype(page, MIGRATE_CMA);
 	set_page_refcounted(page);
 	__free_pages(page, pageblock_order);
 
 	adjust_managed_page_count(page, pageblock_nr_pages);
-	page_zone(page)->cma_pages += pageblock_nr_pages;
 }
-#endif
 
 /*
  * The order of subdivision here is critical for the IO subsystem.
-- 
2.25.1

