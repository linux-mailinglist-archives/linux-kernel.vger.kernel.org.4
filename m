Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B236072C4F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjFLMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjFLMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:51:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8AE52
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:51:10 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qfs0z6s95zLq6v;
        Mon, 12 Jun 2023 20:48:03 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 20:51:07 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rppt@kernel.org>, <akpm@linux-foundation.org>
CC:     <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH] memblock: use the helper macro for_each_zone
Date:   Mon, 12 Jun 2023 20:51:02 +0800
Message-ID: <20230612125102.1674568-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Let's use the helper macro for_each_zone to iterate over all memory
zones and reset the node managed pages. After that, we can remove the
unused function reset_node_managed_pages.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/memblock.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index da4264528e1e..af552604c3fb 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2122,23 +2122,15 @@ static unsigned long __init free_low_memory_core_early(void)
 
 static int reset_managed_pages_done __initdata;
 
-static void __init reset_node_managed_pages(pg_data_t *pgdat)
-{
-	struct zone *z;
-
-	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
-		atomic_long_set(&z->managed_pages, 0);
-}
-
 void __init reset_all_zones_managed_pages(void)
 {
-	struct pglist_data *pgdat;
+	struct zone *z;
 
 	if (reset_managed_pages_done)
 		return;
 
-	for_each_online_pgdat(pgdat)
-		reset_node_managed_pages(pgdat);
+	for_each_zone(z)
+		atomic_long_set(&z->managed_pages, 0);
 
 	reset_managed_pages_done = 1;
 }
-- 
2.25.1

