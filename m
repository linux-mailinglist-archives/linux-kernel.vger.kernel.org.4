Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D996B56DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCKAkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCKAj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:39:58 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947421340E6;
        Fri, 10 Mar 2023 16:39:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id cf14so7703799qtb.10;
        Fri, 10 Mar 2023 16:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BQ3Tu4Fh7Zw0bEuz451Bf6KjfFz+vAaaszEEJUUChw=;
        b=ACBZmz9T+fOJ/er2MQetIFMNgeRLKnusO2uR98YFrcykpO+2zcEzh45d0mpQn8L8jZ
         cdR/zhSiqUdc+7AlJATmoMf24jV3C/a2RsALpIVpVApX7OZzvi2A5rlaFFLOoM+4a+Iu
         cmlDmVB6VWydoOGSTEEfkLhgMkdb8XzoDjcQk2fg+HQnJYwd+s4LvbFXcehweSegHqMN
         qGoJLqVGKKRZcSfMSqbYZaOJYXZtrhVIS58QLZE1cpB/NF+nc7muaTC4uG6RsPAN/amf
         FfNftp8lhVc0lAl1X0hPzYaMUxdq1qzm2P450TpVFNj2Fc9ZAuorzU1Nl1iW7OagYS9k
         XYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BQ3Tu4Fh7Zw0bEuz451Bf6KjfFz+vAaaszEEJUUChw=;
        b=hkCigIN8a7E1jIrzfSTw4gxlSIIHwwSLoqm3cONJV0BiAY1J74giI3hwGyH6lAljCg
         syFBa5Oxy9369XpCQoBDw8JCir2fWwJPCz0+S9J/KmK/7RxxdbnzmStNT5+9/GunKZKr
         kMdoetvkKK75jmKePj3WXFwILqmxsnqswIS9MBh6sAUzoHHcOPYCIe78bwuNvVm55swF
         aNz75PvVWr9N3Qp+aI36jye1lKdlO3DdlJ+SpYDE7T9eENZValrt6vfF4rjxSpbFzo+5
         nUxe3sNOiDdAUyEC3M11cM9HV6USyAna7GZHMpzz1SEllSv3Yt0+u2fWi/xaCOxM+V/8
         k9gA==
X-Gm-Message-State: AO0yUKWAfKemK8hkmgBhpBZrerIQ1pEN/9zmJDqt5vjobmCwafUIiGP+
        FSmf413U7X/8dGJRfsNAX+Y=
X-Google-Smtp-Source: AK7set+MmuySHwc8FcDbJGZpaVLU4HCrie7tiN1VA0TeZDeCtzqts9IA4rg4ydaSqQ297OiyWnJ7pQ==
X-Received: by 2002:ac8:5a88:0:b0:3bf:d8ec:a9fc with SMTP id c8-20020ac85a88000000b003bfd8eca9fcmr11747709qtc.52.1678495194581;
        Fri, 10 Mar 2023 16:39:54 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:39:54 -0800 (PST)
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
Subject: [PATCH v4 3/9] mm/page_alloc: prevent creation of empty zones
Date:   Fri, 10 Mar 2023 16:38:49 -0800
Message-Id: <20230311003855.645684-4-opendmb@gmail.com>
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
index b1952f86ab6d..827b4bfef625 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7592,8 +7592,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
-		unsigned long spanned, absent;
-		unsigned long size, real_size;
+		unsigned long spanned, absent, size;
 
 		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
 						     node_start_pfn,
@@ -7604,20 +7603,21 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
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
2.34.1

