Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAEB6B56D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCKAkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCKAkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:14 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17361378B9;
        Fri, 10 Mar 2023 16:40:02 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id g9so4757891qvt.8;
        Fri, 10 Mar 2023 16:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8Ej0xERH/saZ/pDi1cj12vURZcx4JMPO5LgIvCru00=;
        b=QuGf7CPVoKCsHOOIjm2NK5cjpLghKA1j7kJ/1K741bb8Tjt2zne1lcBoQKG5RZFaLH
         d+9iDxF3djo9jXBNdij0VGTP6ZY1SP8dGV2Shkve2mUoxGpnaN76uokoWkwI7LKRvxaz
         KF+uFAAEj6TJzhXi7bf5vxZsTi5W+CbUoaBE2wno33o87jXYbrldRxk4635GHPh9JKm9
         VfG5OUzjlwFRg/KWjFtjZSd0w2xGePXLgufWztrOsXM8yCuJbytBX4lGLAtjafBKNG5q
         fVvaqQHAnJwIYiTQug11IA0ltwfKKzu0TeoRULLmWlo061rrvJL/iDxv+7SOUACOFXta
         PEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8Ej0xERH/saZ/pDi1cj12vURZcx4JMPO5LgIvCru00=;
        b=QNI3yBm3NeatOulxg+jyt4vnxwD/nk/PAgiQJEj65R4JSrP1DrG0DwqU113RieXXX5
         PL0AHbl8K1k6epNq/uArZPb6ITPixjLJCAK9CiBTkPw/3+9tYWst+GA3DHulgFrsrAt2
         CF4XjXMdqA8+r7NhMU6gUTAIrAQCQ9GIIF73WCRE3mYXe7uPNA1OwjSQZ+XIpHsDsVTF
         EDqcEq8XCKR8EYrVY5g7ByVXeXNqI+WlAsf7OSw0MA4AdSxAAkF1rAPNTtPL1ZmmTbhl
         ikraX2/uEkZhncQBbdaNEWQR33uEataRmKoPdtmIttmMA5JcgGkUCKYuSCKQI7Uhk1XS
         lcRA==
X-Gm-Message-State: AO0yUKV+dRMVbVlw57E4B5qFd9vceWWH7+ZcHeaHsw67QfH5ru+gtwrm
        W1k/r/an/5TWwBFzHYMgzb4=
X-Google-Smtp-Source: AK7set/lVXoZ5W4bIAwoTLxlwAsTqWdy1gsFvdTIDfjsCCmW6gc1QRgTGtZT2GQJIiWjAJ6Nsll19w==
X-Received: by 2002:a05:6214:124b:b0:5a1:d44:79a7 with SMTP id r11-20020a056214124b00b005a10d4479a7mr1926784qvv.20.1678495201744;
        Fri, 10 Mar 2023 16:40:01 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:40:01 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v4 5/9] mm/page_alloc: introduce init_reserved_pageblock()
Date:   Fri, 10 Mar 2023 16:38:51 -0800
Message-Id: <20230311003855.645684-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311003855.645684-1-opendmb@gmail.com>
References: <20230311003855.645684-1-opendmb@gmail.com>
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
index 65a78773dcca..a7892b3c436b 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -361,9 +361,6 @@ extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
-#ifdef CONFIG_CMA
-/* CMA stuff */
-extern void init_cma_reserved_pageblock(struct page *page);
-#endif
+extern void init_reserved_pageblock(struct page *page);
 
 #endif /* __LINUX_GFP_H */
diff --git a/mm/cma.c b/mm/cma.c
index a7263aa02c92..cc462df68781 100644
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
index e574c6a79e2f..da1af678995b 100644
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
2.34.1

