Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7538606A92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJTVzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJTVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:52 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57116404;
        Thu, 20 Oct 2022 14:54:37 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i12so637632qvs.2;
        Thu, 20 Oct 2022 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/FIsjw19eZ3OnJAIkw3KCiDeRv2n8mXkgoaXFlI9ro=;
        b=Jfxyh2ci01RrSPT9NlGFNscPY5PnsXAUGYcYoRSlBmjDz2eJE3LFrmNFqOjrNXF+V7
         kH7Xlpre2JSJCWaxUVgT2xDPJMzJX5z+2wD5qUCsUREd0mY/eySZwJWln98Pra1/1gbI
         fdmxz5E2ZJWa8NubMcYhANwAlL2V5iNmTwIDWbIxEfbqDC8yvhsWJAZ+kFU+7giGU7DC
         wvFTrJT7YJ0e9wl+7meEo6c8q0ukXsJVNF2a7Z6z4aN61MeappkLjeJyJUo2B5Vqouqn
         cfqt7nA9MgPPPtx5fwH3bgE+niTxHXdMv3M/Tbp64/fEWFwMqF//10fYVb5EeAksvWUg
         kHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/FIsjw19eZ3OnJAIkw3KCiDeRv2n8mXkgoaXFlI9ro=;
        b=4jyl2xmEK22RHMZC/e7KW7kKtq62dxpz4LJZnkZfT/Z0JaT3jaWX6OT3JYdYl19R/3
         hrmSIcBpQhByJk/silENsIgd18ztqKJu2wA6t/VN9W+9kAwNGgraawJR1y06zwIIQtF6
         ioC/YXo0YIYzmIJYpNUKZGfwFncLltqCs9envJZdp+VReeM3Uk4XU9dh3DeT1AB34rUK
         vmuCfhUQBSRXVpCZqVvgLuJkQd6oIw7w9EUxeDFwBQ3+1Q6t1MsR818MlPaAR/kZtbhP
         BZdrk2yb6HIJL10FDEIvFkhioJmZGTcSTAJm3ZIXPfr8hbG9Yzqhju7KgzPnET5wM1jn
         rqxA==
X-Gm-Message-State: ACrzQf1pv8aeWfZTzvLwLBuJE+ds45Q7dKTIJyy5lFt2GUKaPG85AJwn
        6kgUKdFp7rAwXbzh7gMF1pY=
X-Google-Smtp-Source: AMsMyM6pLENQr5vbjvY+6Kql1ESyWRc/dvrXQFOAxarXh38H3a3fK/a5qUu7a9qn0oImRKl027uuPg==
X-Received: by 2002:ad4:5968:0:b0:4b4:7d98:7ede with SMTP id eq8-20020ad45968000000b004b47d987edemr13626883qvb.130.1666302876219;
        Thu, 20 Oct 2022 14:54:36 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:35 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v3 5/9] mm/page_alloc: introduce init_reserved_pageblock()
Date:   Thu, 20 Oct 2022 14:53:14 -0700
Message-Id: <20221020215318.4193269-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020215318.4193269-1-opendmb@gmail.com>
References: <20221020215318.4193269-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index ef4aea3b356e..6d66193f336d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -347,9 +347,6 @@ extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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
index a4c2c157bacf..d7a5a05ead4b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2308,9 +2308,8 @@ void __init page_alloc_init_late(void)
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
@@ -2320,14 +2319,11 @@ void __init init_cma_reserved_pageblock(struct page *page)
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

