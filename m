Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E100B5EE96F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiI1Wee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiI1WeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:34:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC2FAC74;
        Wed, 28 Sep 2022 15:33:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id s13so9015177qvq.10;
        Wed, 28 Sep 2022 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lhtWJhsd4j1WsvrD24jP2B8/duCGXddB3TQ2GRCgsxg=;
        b=K4Q7s1SxcUiklLSpEe6hESiZP1eOwlpB06nDUMzWfLR+0hfwHBSsDc9vw59nU6aEJj
         fuU58WUvQGm9lOcNc70XihFXQHcDbjXpCyfRDy2Yj10m+KOk1le/1KJ5jGnO2/drUJNV
         6/w5oHj4j7ksI1PvbfmNogyb+2VAXBylqvHHytrxEPT6B9tqreUV6nx7JxfuMcSx1mg9
         udUN//BAAEMQCXBmrh/9DmVfqDgnInPV/jLTGI6qM30DD1crAkg5uZsVTBCOviHGTcAp
         iByb2ebeoASWVGlb1e4wklMEohoA3Kf3sXcc76Vlm2ERoj9cZ8IF+PZ5jHcsAhAgaAvh
         BJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lhtWJhsd4j1WsvrD24jP2B8/duCGXddB3TQ2GRCgsxg=;
        b=nMbZmndGPJVkXxyRaDC6j8HhN7y3GbxEostCjJWBNI6BoQFWEAcwt1UWepRM3TbV00
         3/xmGeMOLGlf2PIyyXHsfMb97HAKKdc5X7AsdL4zUprYkXu2SBTVrtBvHzUPtXE7xvP8
         TBA/ix1eo8wN85sR7eRwoML4sDkPu6Huaq7mZHVnsMxrl8U6F3E6dQ37UE1YbCceR2pH
         XMORJBYuD9PPTVDbXuZRIZtU4PRf34GgulLEiCcgnGv5k1XfuFhmC74LOG8/iAiTfHgD
         NwSELYhEPjtdcr3kNJISOY5bx532W08faUVEXXoCzikCqA2HU5vGiaZXyMrRzzqnSFWB
         6lPA==
X-Gm-Message-State: ACrzQf20i58Q5BBWWk1OAH69+lwU3+rjFfMPJbuIKGXXLx8OjcLzFJ8v
        akuXRtJIrWVWvaZdO1rg9fI=
X-Google-Smtp-Source: AMsMyM6hndsIdtDYd0/y5nc1hr5JoFumCrEoRQfIpyGeSDegaAZLd45AZZ0iEbDObJ88KUO8KKuesA==
X-Received: by 2002:a0c:b295:0:b0:496:b91a:f5f4 with SMTP id r21-20020a0cb295000000b00496b91af5f4mr234203qve.20.1664404438041;
        Wed, 28 Sep 2022 15:33:58 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:33:57 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 5/9] mm/page_alloc: introduce init_reserved_pageblock()
Date:   Wed, 28 Sep 2022 15:32:57 -0700
Message-Id: <20220928223301.375229-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928223301.375229-1-opendmb@gmail.com>
References: <20220928223301.375229-1-opendmb@gmail.com>
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
index 81f97c5ed080..6d4470b0daba 100644
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

