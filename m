Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A570DB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjEWLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjEWLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:40:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63496FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:40:46 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QQXMM3WqTzqSkZ;
        Tue, 23 May 2023 19:36:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 19:40:43 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <tsahu@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <ssawgyw@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] memblock: update numa node of memblk reserved type
Date:   Tue, 23 May 2023 19:57:08 +0800
Message-ID: <20230523115708.195597-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
Reply-To: <20230519105321.333-1-ssawgyw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_REPLYTO,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numa node of memblk reserved type is wrong, it could update
according to the numa node information from memblk memory type,
let's fix it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memblock.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index a50447d970ef..45a0781cda31 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1922,6 +1922,28 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
 	return memblock.current_limit;
 }
 
+static void __init_memblock memblock_reserved_update_node(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t base, end, size;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_NUMA))
+		return;
+
+	for_each_mem_region(rgn) {
+		base = rgn->base;
+		size = rgn->size;
+		end = base + size - 1;
+
+		ret = memblock_set_node(base, size, &memblock.reserved,
+					memblock_get_region_node(rgn));
+		if (ret)
+			pr_err("memblock: Failed to update reserved [%pa-%pa] node",
+			       &base, &end);
+	}
+}
+
 static void __init_memblock memblock_dump(struct memblock_type *type)
 {
 	phys_addr_t base, end, size;
@@ -1955,6 +1977,7 @@ static void __init_memblock __memblock_dump_all(void)
 		&memblock.memory.total_size,
 		&memblock.reserved.total_size);
 
+	memblock_reserved_update_node();
 	memblock_dump(&memblock.memory);
 	memblock_dump(&memblock.reserved);
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -2196,6 +2219,8 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 	unsigned int count = ARRAY_SIZE(flagname);
 	phys_addr_t end;
 
+	memblock_reserved_update_node();
+
 	for (i = 0; i < type->cnt; i++) {
 		reg = &type->regions[i];
 		end = reg->base + reg->size - 1;
-- 
2.35.3

