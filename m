Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016F1606A91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJTVy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJTVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:38 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8E148C9F;
        Thu, 20 Oct 2022 14:54:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o2so859053qkk.10;
        Thu, 20 Oct 2022 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvfEueXv3MPyKUTDqbsvcgdPv0lPq1HvhYO0pg1lxgg=;
        b=ffixkJKdZbTCBgQd/yyyoLEt9enHtHJdBGSffjbahVDco4N7boG7mqHf4g6HNIWDRV
         TUF2h3/TlW1N88JPvCgjd5FjVNusNzYKuIyp8TGrBY9OXkwOzi7zUpMXlULvLJUWJ8W9
         avv5kHbuJnwKwgHuWuDXHdm9QYpgnsiEKcZEFOneAtsv2+MP3U8dOTOOGDD1USkrXOCt
         Iqv8+KZIqj6eh2vmChJHacuLhyL1e4qs7ooWBZUnlQp/Eb7vo1cQiMKoyTJrkOBKnZSP
         ZtvvP6oZGVyoOyC7Bt9iXv+x4vQtDi9ovBXsTNzCOqpI7rcL0jEiTpC70OvnjYfdeMAU
         hhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvfEueXv3MPyKUTDqbsvcgdPv0lPq1HvhYO0pg1lxgg=;
        b=ECgPztQgBXk3UIt9mXyycXkwVO1hGloxY0Eg50laC/OjziTbyTgGa3/54TfzGvezjs
         LwO1vRBkC0fkl+gnwao2Mbxew4ZTIE4YmNfvp4MXJplP73AmfEPSY95zgAv7roDmW7RG
         r9sNhs4pjCleXUdfSyiYRw2+oXhUDwWa+55azPZYfvwOaR81dKkr1J+1c3Asw/mYy9f6
         Y7F+EVv/6UPx7yUxNVDawOJo7J2teiXiI9t+u9VKmF92tPStBWjGxQvo4XcST6FiOTjI
         dVADD8cknqhs6Ofeh9S9tQgPlmt/t5ivjdVbe+Bj4E8a6IUqkPdKXsvstulmI1IMdcC0
         otpQ==
X-Gm-Message-State: ACrzQf10IoeWJFkzK+lc63BVbFSr5cfh9bhFo5KKibR5RJreu2ZAy6fZ
        aIqmUzyvVHHExEOOuoVZDXQ=
X-Google-Smtp-Source: AMsMyM5Nmw4C772V70Q+LmwGPXj1++mwiH027m+RB4IR5T/YT15ihOIWJHuJ1fNCaKZtV3P9KumgYA==
X-Received: by 2002:a05:620a:2b91:b0:6ee:bc07:24c with SMTP id dz17-20020a05620a2b9100b006eebc07024cmr11239651qkb.64.1666302869881;
        Thu, 20 Oct 2022 14:54:29 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:29 -0700 (PDT)
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
Subject: [PATCH v3 3/9] mm/page_alloc: prevent creation of empty zones
Date:   Thu, 20 Oct 2022 14:53:12 -0700
Message-Id: <20221020215318.4193269-4-opendmb@gmail.com>
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

If none of the pages a zone spans are present then its start pfn
and span should be zeroed to prevent initialization.

This prevents the creation of an empty zone if all of its pages
are moved to a zone that would overlap it.

The real_size name is reverted to just size to reduce the burden
of supporting multiple realities.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 92908c51f1c3..2f7b88d78bc2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7548,8 +7548,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
-		unsigned long spanned, absent;
-		unsigned long size, real_size;
+		unsigned long spanned, absent, size;
 
 		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
 						     node_start_pfn,
@@ -7560,20 +7559,21 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						   node_start_pfn,
 						   node_end_pfn);
 
-		size = spanned;
-		real_size = size - absent;
+		size = spanned - absent;
 
-		if (size)
+		if (size) {
 			zone->zone_start_pfn = zone_start_pfn;
-		else
+		} else {
+			spanned = 0;
 			zone->zone_start_pfn = 0;
-		zone->spanned_pages = size;
-		zone->present_pages = real_size;
+		}
+		zone->spanned_pages = spanned;
+		zone->present_pages = size;
 #if defined(CONFIG_MEMORY_HOTPLUG)
-		zone->present_early_pages = real_size;
+		zone->present_early_pages = size;
 #endif
 
-		totalpages += real_size;
+		totalpages += size;
 	}
 
 	pgdat->node_spanned_pages = node_end_pfn - node_start_pfn;
-- 
2.25.1

