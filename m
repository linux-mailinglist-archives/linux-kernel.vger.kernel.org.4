Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8652972A8DB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjFJDql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFJDqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:46:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854921BF0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 20:46:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QdP1X3jC8zLq5N;
        Sat, 10 Jun 2023 11:43:28 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 10 Jun
 2023 11:46:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: compaction: mark kcompactd_run() and kcompactd_stop() __meminit
Date:   Sat, 10 Jun 2023 11:46:15 +0800
Message-ID: <20230610034615.997813-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Add __meminit to kcompactd_run() and kcompactd_stop() to ensure they're
default to __init when memory hotplug is not enabled.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/compaction.h | 4 ++--
 mm/compaction.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 57b16e69c19a..e94776496049 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -98,8 +98,8 @@ extern void compaction_defer_reset(struct zone *zone, int order,
 bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 					int alloc_flags);
 
-extern void kcompactd_run(int nid);
-extern void kcompactd_stop(int nid);
+extern void __meminit kcompactd_run(int nid);
+extern void __meminit kcompactd_stop(int nid);
 extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
 
 #else
diff --git a/mm/compaction.c b/mm/compaction.c
index 3398ef3a55fe..8859cc91062f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3086,7 +3086,7 @@ static int kcompactd(void *p)
  * This kcompactd start function will be called by init and node-hot-add.
  * On node-hot-add, kcompactd will moved to proper cpus if cpus are hot-added.
  */
-void kcompactd_run(int nid)
+void __meminit kcompactd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 
@@ -3104,7 +3104,7 @@ void kcompactd_run(int nid)
  * Called by memory hotplug when all memory in a node is offlined. Caller must
  * be holding mem_hotplug_begin/done().
  */
-void kcompactd_stop(int nid)
+void __meminit kcompactd_stop(int nid)
 {
 	struct task_struct *kcompactd = NODE_DATA(nid)->kcompactd;
 
-- 
2.27.0

