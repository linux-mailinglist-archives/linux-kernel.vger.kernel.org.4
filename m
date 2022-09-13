Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21525B7BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIMT6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIMT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578672EF8;
        Tue, 13 Sep 2022 12:57:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r20so8904690qtn.12;
        Tue, 13 Sep 2022 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rWqwJImtlBlKgE2e4HCMCjZ57hDnUIYZvYnGoYO3Ko0=;
        b=d2+jGtD0TKLMdHImIPIOFRc/CCsLBd1zTd7Z32acL/4ee7Q///DRfLAeWKVby8PAWE
         fgb6z8hXf1k5PM+mERKCcjYlhJUc7YcVmkzbKybhsAlNUjEqr+U7/BKoMqeCMB/HNIHI
         g9CIZx3cpM7r7QtrN3niww/63rwDZ4ABYIOm7CcpFGEgc/xw03gOtoM8VQgFq7CdtHOy
         PnM3xHgjGzGq4Cl6QAxH02OPTmRMVzFrDgXO8l6Rjf0jEf15sxaNGCsaRPE9K0g1rGX0
         Q9q2x8LOpIavofodITDiPKTwnIXo7FGcbxZ+dhF4xLlkpGof9K3nuM7AOF386w+Nu9xd
         TF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rWqwJImtlBlKgE2e4HCMCjZ57hDnUIYZvYnGoYO3Ko0=;
        b=htp07O+LUzlLcuRDBo/jLs0Qna4JbMm1SQP1g5z6O3NJVGsbQRLGt/FroqyvjADLwz
         LEMGzTv6UD9Tos1We7dGLItHAVse6cwnI4Ire47DJpRmvCcxQEh9CKd1xPIW1kZ9p3fE
         KUnenjT3BnrC9g32o4+NcyjVTrZwGRK3uR9PcCnI98eg8+7loYIdZ2q0hzrZB+GaV5VL
         aYEJ96G6ubneVTjKtjzKAuahTwZZ6gzVTUOJqTQ/uDEnLNMvHIqU4/rVUk5ROOj9KwAa
         e5oGpTGDJrmJnijMsHOymLBVMRPrQuNV1RA1FAor6jUg983Pxs6iT+vpyXQfOV+n0D1s
         atUg==
X-Gm-Message-State: ACgBeo3twSvFvU9kaYE+n/RZ7xkEDk+fcfFmuP2i1U2V6Nxumu+VUctb
        GXQmW0fP6MXVoDMkZFYpeQo=
X-Google-Smtp-Source: AA6agR5i53agCunM1nP5BNWdgMMXAxgKBBgHP+YifFsQRT8ONLZddir0hPCAFH311ymBKWli946Oxg==
X-Received: by 2002:a05:622a:40e:b0:343:7769:5895 with SMTP id n14-20020a05622a040e00b0034377695895mr30562094qtx.467.1663099078015;
        Tue, 13 Sep 2022 12:57:58 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:57:57 -0700 (PDT)
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
Subject: [PATCH 01/21] mm/page_isolation: protect cma from isolate_single_pageblock
Date:   Tue, 13 Sep 2022 12:54:48 -0700
Message-Id: <20220913195508.3511038-2-opendmb@gmail.com>
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

The function set_migratetype_isolate() has special handling for
pageblocks of MIGRATE_CMA type that protects them from being
isolated for MIGRATE_MOVABLE requests.

Since isolate_single_pageblock() doesn't receive the migratetype
argument of start_isolate_page_range() it used the migratetype
of the pageblock instead of the requested migratetype which
defeats this MIGRATE_CMA check.

This allows an attempt to create a gigantic page within a CMA
region to change the migratetype of the first and last pageblocks
from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
failure, which corrupts the CMA region.

The calls to (un)set_migratetype_isolate() for the first and last
pageblocks of the start_isolate_page_range() are moved back into
that function to allow access to its migratetype argument and make
it easier to see how all of the pageblocks in the range are
isolated.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_isolation.c | 75 +++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 9d73dc38e3d7..8e16aa22cb61 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * @flags:			isolation flags
  * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
- * @skip_isolation:	the flag to skip the pageblock isolation in second
- *			isolate_single_pageblock()
  *
  * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
  * pageblock. When not all pageblocks within a page are isolated at the same
@@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
-			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
+			gfp_t gfp_flags, bool isolate_before)
 {
-	unsigned char saved_mt;
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
 	unsigned long pfn;
@@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 	start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
 				      zone->zone_start_pfn);
 
-	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
-
-	if (skip_isolation)
-		VM_BUG_ON(!is_migrate_isolate(saved_mt));
-	else {
-		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
-				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
-
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
 	 * a free or in-use page across boundary_pfn:
@@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 					ret = set_migratetype_isolate(page, page_mt,
 						flags, head_pfn, head_pfn + nr_pages);
 					if (ret)
-						goto failed;
+						return ret;
 				}
 
 				ret = __alloc_contig_migrate_range(&cc, head_pfn,
@@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 					unset_migratetype_isolate(page, page_mt);
 
 				if (ret)
-					goto failed;
+					return -EBUSY;
 				/*
 				 * reset pfn to the head of the free page, so
 				 * that the free page handling code above can split
@@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				while (!PageBuddy(pfn_to_page(outer_pfn))) {
 					/* stop if we cannot find the free page */
 					if (++order >= MAX_ORDER)
-						goto failed;
+						return -EBUSY;
 					outer_pfn &= ~0UL << order;
 				}
 				pfn = outer_pfn;
 				continue;
 			} else
 #endif
-				goto failed;
+				return -EBUSY;
 		}
 
 		pfn++;
 	}
 	return 0;
-failed:
-	/* restore the original migratetype */
-	if (!skip_isolation)
-		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
-	return -EBUSY;
 }
 
 /**
@@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
 	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;
-	bool skip_isolation = false;
 
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
-	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
+	ret = set_migratetype_isolate(pfn_to_page(isolate_start), migratetype,
+			flags, isolate_start, isolate_start + pageblock_nr_pages);
 	if (ret)
 		return ret;
-
-	if (isolate_start == isolate_end - pageblock_nr_pages)
-		skip_isolation = true;
+	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
+	if (ret)
+		goto unset_start_block;
 
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
-	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
+	pfn = isolate_end - pageblock_nr_pages;
+	if (isolate_start != pfn) {
+		ret = set_migratetype_isolate(pfn_to_page(pfn), migratetype,
+				flags, pfn, pfn + pageblock_nr_pages);
+		if (ret)
+			goto unset_start_block;
+	}
+	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
 	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
-		return ret;
+		if (isolate_start != pfn)
+			goto unset_end_block;
+		else
+			goto unset_start_block;
 	}
 
 	/* skip isolated pageblocks at the beginning and end */
@@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
-					start_pfn, end_pfn)) {
-			undo_isolate_page_range(isolate_start, pfn, migratetype);
-			unset_migratetype_isolate(
-				pfn_to_page(isolate_end - pageblock_nr_pages),
-				migratetype);
-			return -EBUSY;
-		}
+					start_pfn, end_pfn))
+			goto unset_isolated_blocks;
 	}
 	return 0;
+
+unset_isolated_blocks:
+	ret = -EBUSY;
+	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
+				migratetype);
+unset_end_block:
+	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_pages),
+				  migratetype);
+unset_start_block:
+	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
+	return ret;
 }
 
 /*
-- 
2.25.1

