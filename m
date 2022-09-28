Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30E5EE975
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiI1We5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiI1Wea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:34:30 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA156FA0C1;
        Wed, 28 Sep 2022 15:34:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x13so1962461qvn.4;
        Wed, 28 Sep 2022 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hndRuqLYmpsdza/I5YqR10YZRjB6Gw7lqCVZwv7bT84=;
        b=W5KTlkD6VDvTed2L2KfHwXo9j86RBLv0DNqupCjdd7UJXUFKgQ6ICn1v22QPaFF653
         UUH7LRcXhW62qq39IHwi34e5XSq8nSnOM5SAyWJvUpLscbaqAkYsuFZsSYCAiBqDk+WE
         12K8uhBSmyEFWms9uxioDGzI3h9oFNasFPBomC7bWYUMDQ+i5OMAZnByjvqWrIn0HhIf
         KJhuzCmgX/7mBYgrmftfQadDSto2kyNLE2imb9nYnmLFfllPp4mAvrPZGMDuVzxUOjDG
         9lGghwppmTYcB6NOl9/Hb1f4XFaxXyms0ePckizh45ccJw6S8t2QhVjg7VgrvpJxSSdo
         T/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hndRuqLYmpsdza/I5YqR10YZRjB6Gw7lqCVZwv7bT84=;
        b=esRAE4OanpPfxp8gvyk58G/xU3ONRpdSpq/niBm+D4fgIAaHH/hYqbLncZFyJ6muUB
         T5juzBDaedZDjHX/+ac7VXT+D76RFZWUSwaZhv2OE93sEx2W8f2Dj1sMJqwaJQGSMIhb
         GbsghRVnmY76n1A7+hWeh2zVuriVoVbYePs1Sp0nug3yCqiHDrhLq3KpzA43nAQIK1BB
         j1OHn9P+Nd6IJ1/WOwEhjgBD384q+bhUoQ0hate+eWwaXYRoexYKh+Z7FjRwUm/4rEDW
         eHtpHQGKk7NFYpoGsOpersuiivhOtmlNLlO7wGlYT09MtgATT/uYMa2nkaqzzn3E+8Nj
         4brg==
X-Gm-Message-State: ACrzQf1AWCuj6aq457owTkfDeziKleIoptNQaUXygW2xN6crffOw1jfP
        FsSqiq6MPkZxxiM3jtWHi2I=
X-Google-Smtp-Source: AMsMyM6Ccu/5uERbT7jxjfR+0FE1IFewQaesnxuWr2WVMdlCZf4bfvdaCH8iSFcEiEy/T6yQAHFDhA==
X-Received: by 2002:ad4:4ea7:0:b0:4ad:656a:260c with SMTP id ed7-20020ad44ea7000000b004ad656a260cmr268848qvb.51.1664404446501;
        Wed, 28 Sep 2022 15:34:06 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:34:05 -0700 (PDT)
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
Subject: [PATCH v2 8/9] mm/page_alloc: make alloc_contig_pages DMB aware
Date:   Wed, 28 Sep 2022 15:33:00 -0700
Message-Id: <20220928223301.375229-9-opendmb@gmail.com>
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
index cd31f26b0d21..c07111a897c0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -435,7 +435,7 @@ static unsigned long required_kernelcore_percent __initdata;
 static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
 static unsigned long min_dmb_pfn[MAX_NUMNODES] __initdata;
-static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
+static unsigned long zone_movable_pfn[MAX_NUMNODES];
 bool mirrored_kernelcore __initdata_memblock;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
@@ -9369,6 +9369,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 	unsigned long i, end_pfn = start_pfn + nr_pages;
 	struct page *page;
 
+	if (dmb_intersects(start_pfn, end_pfn))
+		return false;
+
 	for (i = start_pfn; i < end_pfn; i++) {
 		page = pfn_to_online_page(i);
 		if (!page)
@@ -9425,7 +9428,10 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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

