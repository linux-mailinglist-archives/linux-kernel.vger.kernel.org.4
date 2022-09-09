Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0815B33EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiIIJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiIIJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:26:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE3979FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:25:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP9TN6FrnzZcnt;
        Fri,  9 Sep 2022 17:20:56 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:25:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 06/16] mm/page_alloc: fix freeing static percpu memory
Date:   Fri, 9 Sep 2022 17:24:41 +0800
Message-ID: <20220909092451.24883-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220909092451.24883-1-linmiaohe@huawei.com>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3497919f4ef5..a35ef385d906 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9510,9 +9510,11 @@ void zone_pcp_reset(struct zone *zone)
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

