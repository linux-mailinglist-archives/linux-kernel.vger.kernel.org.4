Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9367710B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbjEYLmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbjEYLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:42:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C812F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:42:42 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QRmPp4gnGzTkn0;
        Thu, 25 May 2023 19:42:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 19:42:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <tsahu@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <ssawgyw@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] memblock: unify memblock dump and debugfs show
Date:   Thu, 25 May 2023 19:58:56 +0800
Message-ID: <20230525115856.124507-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two interfaces to show the memblock information, memblock_dump_all()
and /sys/kernel/debug/memblock/, but the content is displayed separately,
let's unify them in case of more different changes over time.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 80 ++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f82ee3fac1cd..d68826e8c97b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -47,6 +47,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_MAX_UNKNOWN	= 0x10,	/* unknow flags */
 };
 
 /**
diff --git a/mm/memblock.c b/mm/memblock.c
index c5c80d9bcea3..890ff9a16b1d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1899,16 +1899,35 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
 	return memblock.current_limit;
 }
 
-static void __init_memblock memblock_dump(struct memblock_type *type)
+#define memblock_printf(m, to_dmesg, fmt, args...)		\
+({								\
+	if (to_dmesg)						\
+		pr_info(fmt, ##args);				\
+	else							\
+		seq_printf(m, fmt, ##args);			\
+})
+
+static const char * const flagname[] __initdata_memblock = {
+	[ilog2(MEMBLOCK_HOTPLUG)]		= "HOTPLUG",
+	[ilog2(MEMBLOCK_MIRROR)]		= "MIRROR",
+	[ilog2(MEMBLOCK_NOMAP)]			= "NOMAP",
+	[ilog2(MEMBLOCK_DRIVER_MANAGED)]	= "DRV_MNG",
+	[ilog2(MEMBLOCK_MAX_UNKNOWN)]		= "UNKNOWN",
+};
+
+static void __init_memblock memblock_dump(struct memblock_type *type,
+					  struct seq_file *m, bool to_dmesg)
 {
+	unsigned count = ARRAY_SIZE(flagname);
 	phys_addr_t base, end, size;
 	enum memblock_flags flags;
-	int idx;
 	struct memblock_region *rgn;
+	int idx, i;
 
-	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
+	memblock_printf(m, to_dmesg, " %s.cnt  = 0x%lx\n", type->name, type->cnt);
 
 	for_each_memblock_type(idx, type, rgn) {
+		const char *fp = "NONE";
 		char nid_buf[32] = "";
 
 		base = rgn->base;
@@ -1920,8 +1939,19 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
 				 memblock_get_region_node(rgn));
 #endif
-		pr_info(" %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %#x\n",
-			type->name, idx, &base, &end, &size, nid_buf, flags);
+		if (flags) {
+			fp = flagname[count];
+
+			for (i = 0; i < count; i++) {
+				if (flags & (1U << i)) {
+					fp = flagname[i];
+					break;
+				}
+			}
+		}
+
+		memblock_printf(m, to_dmesg, " %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %s\n",
+			type->name, idx, &base, &end, &size, nid_buf, fp);
 	}
 }
 
@@ -1932,10 +1962,10 @@ static void __init_memblock __memblock_dump_all(void)
 		&memblock.memory.total_size,
 		&memblock.reserved.total_size);
 
-	memblock_dump(&memblock.memory);
-	memblock_dump(&memblock.reserved);
+	memblock_dump(&memblock.memory, NULL, true);
+	memblock_dump(&memblock.reserved, NULL, true);
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
-	memblock_dump(&physmem);
+	memblock_dump(&physmem, NULL, true);
 #endif
 }
 
@@ -2158,41 +2188,13 @@ void __init memblock_free_all(void)
 }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
-static const char * const flagname[] = {
-	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
-	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
-	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
-	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
-};
 
 static int memblock_debug_show(struct seq_file *m, void *private)
 {
 	struct memblock_type *type = m->private;
-	struct memblock_region *reg;
-	int i, j;
-	unsigned int count = ARRAY_SIZE(flagname);
-	phys_addr_t end;
-
-	for (i = 0; i < type->cnt; i++) {
-		reg = &type->regions[i];
-		end = reg->base + reg->size - 1;
-
-		seq_printf(m, "%4d: ", i);
-		seq_printf(m, "%pa..%pa ", &reg->base, &end);
-		seq_printf(m, "%4d ", memblock_get_region_node(reg));
-		if (reg->flags) {
-			for (j = 0; j < count; j++) {
-				if (reg->flags & (1U << j)) {
-					seq_printf(m, "%s\n", flagname[j]);
-					break;
-				}
-			}
-			if (j == count)
-				seq_printf(m, "%s\n", "UNKNOWN");
-		} else {
-			seq_printf(m, "%s\n", "NONE");
-		}
-	}
+
+	memblock_dump(type, m, false);
+
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(memblock_debug);
-- 
2.35.3

