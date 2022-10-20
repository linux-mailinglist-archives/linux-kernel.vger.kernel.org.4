Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5619F606A99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJTVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJTVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E066FA0264;
        Thu, 20 Oct 2022 14:54:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d13so881985qko.5;
        Thu, 20 Oct 2022 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cizdPvmJ1B17OrSNKxRqtl13qIriognWBTeBRaDyut8=;
        b=KB+L2mJLWgHCBesUojexARn3KfzhK2H8uBHU+VHa8RVf7cVaGNVrwuXj5H0u/3lYNt
         wcRhSDne7ByyOYLA9cvoYeZ3VkJnXDvSNYrN7WLs2Y8egIdBuC1tsxWHa8GuimGAILbi
         HpD84Z7bldzP6/kQGQaZBJtwCmr8b/q3S10e3mNdrpXjva2ZtAfgkTBffc6/iyI1nZh8
         Dkvb6WhFlo7oG5GjOPlOEGO7jqBEgByfJJkRI0qvYtt0VrUgU2wXlz0p4gbq6SsQ+iYg
         B0OQZMc70gmWoyH7TxZ9cLUl4CmQ26VS1NmykgFEz179lNiZQ6BbQaEEdltfzN3ILZRT
         GG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cizdPvmJ1B17OrSNKxRqtl13qIriognWBTeBRaDyut8=;
        b=SazMMU6G9v97uMklqMjniuu2dpi1W2mJzFrxG0Lryzp+262U/mKkWxoifAd34mxm2y
         a1yysLrDw+rvm852T2QrPqjpr/ExDc1Gr+oNHNUGmCy1qtvLiSepmZX9yTrdGg653BD6
         DjMeYfF3nzkvfG79IIbwEOdy7HAxXtN76kp/TURgg6eJjlukYNjXleIg4L0dAaEK1Qsa
         7MU//ROOEuCVk/ZIDBY6U3bLzCydFJjAaWOzqq6uAmeoIPzvOsRmqoX9V7GQyGZX/ZDE
         hAyXhdNQfgJ4aJ8xnLFQEkeCqXkaC8WTT+UPvkK3Zs10CDOOkEhPb+rG9wXwMsiYInQj
         jTMA==
X-Gm-Message-State: ACrzQf3kj1LQT5Jve5G/OBcMswhfZnHGeK+x1b+B3QcnAGxPoISEy5xI
        S7dQwRyavhedectI82lEGbk=
X-Google-Smtp-Source: AMsMyM4TfR3bYlmhEQVS3hRsR8tGQaHhGxaCz70N0D3SiJn/URFTRu7Q8Q87qGF4C+fS2BQtoGIQDg==
X-Received: by 2002:a05:620a:4510:b0:6ee:e598:a185 with SMTP id t16-20020a05620a451000b006eee598a185mr10499940qkp.765.1666302885214;
        Thu, 20 Oct 2022 14:54:45 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:44 -0700 (PDT)
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
Subject: [PATCH v3 8/9] mm/page_alloc: make alloc_contig_pages DMB aware
Date:   Thu, 20 Oct 2022 14:53:17 -0700
Message-Id: <20221020215318.4193269-9-opendmb@gmail.com>
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

Designated Movable Blocks are skipped when attempting to allocate
contiguous pages. Doing per page validation across all spanned
pages within a zone can be extra inefficient when Designated
Movable Blocks create large overlaps between zones. Use
dmb_intersects() within pfn_range_valid_contig as an early check
to signal the range is not valid.

The zone_movable_pfn array which represents the start of non-
overlapped ZONE_MOVABLE on the node is now preserved to be used
at runtime to skip over any DMB-only portion of the zone.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 82cad751e0b8..a39eca3bc01b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -437,7 +437,7 @@ static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
 static unsigned long min_dmb_pfn[MAX_NUMNODES] __initdata;
 static unsigned long max_dmb_pfn[MAX_NUMNODES] __initdata;
-static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
+static unsigned long zone_movable_pfn[MAX_NUMNODES];
 bool mirrored_kernelcore __initdata_memblock;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
@@ -9460,6 +9460,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 	unsigned long i, end_pfn = start_pfn + nr_pages;
 	struct page *page;
 
+	if (dmb_intersects(start_pfn, end_pfn))
+		return false;
+
 	for (i = start_pfn; i < end_pfn; i++) {
 		page = pfn_to_online_page(i);
 		if (!page)
@@ -9516,7 +9519,10 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 					gfp_zone(gfp_mask), nodemask) {
 		spin_lock_irqsave(&zone->lock, flags);
 
-		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
+		if (zone_idx(zone) == ZONE_MOVABLE && zone_movable_pfn[nid])
+			pfn = ALIGN(zone_movable_pfn[nid], nr_pages);
+		else
+			pfn = ALIGN(zone->zone_start_pfn, nr_pages);
 		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
 			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
 				/*
-- 
2.25.1

