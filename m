Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F97241EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjFFMSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFFMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:18:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682FE7E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:18:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb8Zs2B1gztQdM;
        Tue,  6 Jun 2023 20:16:05 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 20:18:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: vmscan: mark kswapd_run() and kswapd_stop() __meminit
Date:   Tue, 6 Jun 2023 20:18:13 +0800
Message-ID: <20230606121813.242163-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
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

Add __meminit to kswapd_run() and kswapd_stop() to ensure they're default
to __init when memory hotplug is not enabled.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h | 4 ++--
 mm/vmscan.c          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2ddbfd85f6c7..b5f6f2916de1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -460,8 +460,8 @@ static inline bool node_reclaim_enabled(void)
 void check_move_unevictable_folios(struct folio_batch *fbatch);
 void check_move_unevictable_pages(struct pagevec *pvec);
 
-extern void kswapd_run(int nid);
-extern void kswapd_stop(int nid);
+extern void __meminit kswapd_run(int nid);
+extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 43dc5c90abbf..a8881571e0ed 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7871,7 +7871,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 /*
  * This kswapd start function will be called by init and node-hot-add.
  */
-void kswapd_run(int nid)
+void __meminit kswapd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 
@@ -7892,7 +7892,7 @@ void kswapd_run(int nid)
  * Called by memory hotplug when all memory in a node is offlined.  Caller must
  * be holding mem_hotplug_begin/done().
  */
-void kswapd_stop(int nid)
+void __meminit kswapd_stop(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	struct task_struct *kswapd;
-- 
2.27.0

