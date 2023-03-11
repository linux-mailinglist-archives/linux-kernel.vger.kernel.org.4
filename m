Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813DC6B56DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCKAlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCKAkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:40 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FFA1408A9;
        Fri, 10 Mar 2023 16:40:14 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id op8so4747911qvb.11;
        Fri, 10 Mar 2023 16:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtzU35tbRJ3gnQ1OO0E5TSthDsuwzlQZXdQbmvmImVI=;
        b=EI9ItuekjPEI1ZTS23O9YP0nD+tkWC1qq0vSYnml6KNfIm6jcJv7iWb2BovYcnb5TQ
         vsb0iWRfzAD9R7HdHwlCC//JPb2p13EA1HOWSZY4Mpa0+6D6buOrOt0W7dpGXe71MEVH
         mXEFC1IAXgt4HvEhYylEkVF5kKLJ8WaOzWEWNpirupjVV/ttZbYjsJxi/PzCRQWqrITT
         0EFqsCzdOwUAOP+xT9WSTKlgrasqopGGQm/8Ro3V92TYbNpywUEgnYZ7kLwtPIMBt+F6
         Hz1HGTW2qLSSjxQovQl6WveZTAjkHGVhQlVnN3U8qHEi++x0ld2rx/89o4Aujd1e+0Y+
         hKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtzU35tbRJ3gnQ1OO0E5TSthDsuwzlQZXdQbmvmImVI=;
        b=ctPVhDVhwhP/GpMnBT0xD9grhhScFr1H095W4WEKWQJwsjoaWCALMDvbhOSlUC4kKQ
         p3t4SNsO8tU6f1y5z1Se+K0r63Mlw49QQu/gChD6mf0iMjhZBhZ7YU5mWR7pfnosCXR/
         /YQSY7zt185v5DKtEIp2CL/9C9fEb7blpi0NHTB6lQmK2+r48eePqqfW7Il7G05JNWaS
         ScDEVUCs+VZWvdFuMShXSaVJa3els/ka9ZnxSicMjbJPKR8BR/1tkIiRX9XADna/UJwh
         DT9PQGidk5i7vqlDXb6Uahc/3X/VGG5pvAo4UbdH9kJrpshpihZHEY+JgjMd/zfxVF/P
         +gsA==
X-Gm-Message-State: AO0yUKUJZ81weas6T+tiBX55sMJLPcHtBSD+deDVV7ZQGthCWt7z2n1e
        erpZFI/HxptYfLakqyn1ZzA=
X-Google-Smtp-Source: AK7set/eL7lVruxcZE0wUHCIKgMg9nihcg2qsfNt94iZ5Zprmu4kPjrI8/xfFMTDXQ978rNM+ux+fA==
X-Received: by 2002:a05:6214:2124:b0:537:708d:3fef with SMTP id r4-20020a056214212400b00537708d3fefmr1431894qvc.38.1678495212405;
        Fri, 10 Mar 2023 16:40:12 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:40:12 -0800 (PST)
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
Subject: [PATCH v4 8/9] mm/page_alloc: make alloc_contig_pages DMB aware
Date:   Fri, 10 Mar 2023 16:38:54 -0800
Message-Id: <20230311003855.645684-9-opendmb@gmail.com>
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
index 26846a9a9fc4..d4358d19d5a1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -417,7 +417,7 @@ static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
 static unsigned long min_dmb_pfn[MAX_NUMNODES] __initdata;
 static unsigned long max_dmb_pfn[MAX_NUMNODES] __initdata;
-static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
+static unsigned long zone_movable_pfn[MAX_NUMNODES];
 bool mirrored_kernelcore __initdata_memblock;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
@@ -9503,6 +9503,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 	unsigned long i, end_pfn = start_pfn + nr_pages;
 	struct page *page;
 
+	if (dmb_intersects(start_pfn, end_pfn))
+		return false;
+
 	for (i = start_pfn; i < end_pfn; i++) {
 		page = pfn_to_online_page(i);
 		if (!page)
@@ -9559,7 +9562,10 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
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
2.34.1

