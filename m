Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1039370F498
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjEXKws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEXKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:52:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A61A3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:52:44 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QR7FT1GPQz18LWZ;
        Wed, 24 May 2023 18:48:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 18:52:42 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <tsahu@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <ssawgyw@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] memblock: update numa node of memblk reserved type
Date:   Wed, 24 May 2023 19:09:04 +0800
Message-ID: <20230524110904.106792-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numa node of memblk reserved type is always wrong when check
memblock_dump_all() or sysfs file (/sys/kernel/debug/memblock/reserved),
no one use reserved type's node except the two debug interfaces,
but uncorrect value is bad as the above interfaces are visible for
user. Let's fix it according to the numa node information from memblk
memory type by adding a memblock_reserved_update_node(), note, it will
be called twice since memblock_reserve could still be called after
memblock_dump_all(), or the sysfs file read may get some wrong value.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: 
- update changelog, explain why update reserved node info twice
- move memblock_reserved_update_node() from sysfs read into
  memblock_init_debugfs()

 mm/memblock.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index c5c80d9bcea3..50dd12958e60 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1899,6 +1899,28 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
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
@@ -1932,6 +1954,7 @@ static void __init_memblock __memblock_dump_all(void)
 		&memblock.memory.total_size,
 		&memblock.reserved.total_size);
 
+	memblock_reserved_update_node();
 	memblock_dump(&memblock.memory);
 	memblock_dump(&memblock.reserved);
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -2209,6 +2232,7 @@ static int __init memblock_init_debugfs(void)
 	debugfs_create_file("physmem", 0444, root, &physmem,
 			    &memblock_debug_fops);
 #endif
+	memblock_reserved_update_node();
 
 	return 0;
 }
-- 
2.35.3

