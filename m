Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F175BA762
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIPHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiIPHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:23:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CA1A50DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:23:40 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTQRT18CRzMmx1;
        Fri, 16 Sep 2022 15:19:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:23:38 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 06/16] mm/page_alloc: fix freeing static percpu memory
Date:   Fri, 16 Sep 2022 15:22:47 +0800
Message-ID: <20220916072257.9639-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220916072257.9639-1-linmiaohe@huawei.com>
References: <20220916072257.9639-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of struct per_cpu_zonestat can be 0 on !SMP && !NUMA. In that
case, zone->per_cpu_zonestats will always equal to boot_zonestats. But
in zone_pcp_reset(), zone->per_cpu_zonestats is freed via free_percpu()
directly without checking against boot_zonestats first. boot_zonestats
will be released by free_percpu() unexpectedly.

Fixes: 28f836b6777b ("mm/page_alloc: split per cpu page lists and zone stats")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 27ef763bb59f..cad235770948 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9505,9 +9505,11 @@ void zone_pcp_reset(struct zone *zone)
 			drain_zonestat(zone, pzstats);
 		}
 		free_percpu(zone->per_cpu_pageset);
-		free_percpu(zone->per_cpu_zonestats);
 		zone->per_cpu_pageset = &boot_pageset;
-		zone->per_cpu_zonestats = &boot_zonestats;
+		if (zone->per_cpu_zonestats != &boot_zonestats) {
+			free_percpu(zone->per_cpu_zonestats);
+			zone->per_cpu_zonestats = &boot_zonestats;
+		}
 	}
 }
 
-- 
2.23.0

