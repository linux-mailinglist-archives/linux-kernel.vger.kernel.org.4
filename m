Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB9671911
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjARKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjARKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:32:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC2C1309
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:39:44 -0800 (PST)
X-UUID: eed0a592971311eda06fc9ecc4dadd91-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WaDG+rrqxlJT/6GIGWHNWGiT1aQrPsWBNzoW/dbYNnM=;
        b=V8eIWzGwUm3H3qqhVEsZDmJB+fBOvydGVPyVJrVUyXF7+fnAFH8F0U84AmMsTqCt3u81Cdj2I7KV+YxTbqLNn6bUX1wWF3yjr41Ld1o9RmNKa/TiL4ySSLQh05BjDfVOy6+ZhXio0+Njmg5yMzHXEInFK6SwXn/BqDJmMHit1fk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:7f928ffa-14cd-4fb0-8d02-1bf6c2c1c9c6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:b6c69b8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: eed0a592971311eda06fc9ecc4dadd91-20230118
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1301835293; Wed, 18 Jan 2023 17:38:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 17:38:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 17:38:57 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] kasan: infer the requested size by scanning shadow memory
Date:   Wed, 18 Jan 2023 17:38:30 +0800
Message-ID: <20230118093832.1945-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We scan the shadow memory to infer the requested size instead of
printing cache->object_size directly.

This patch will fix the confusing kasan slab-out-of-bounds
report like below. [1]
Report shows "cache kmalloc-192 of size 192", but user
actually kmalloc(184).

==================================================================
BUG: KASAN: slab-out-of-bounds in _find_next_bit+0x143/0x160 lib/find_bit.c:109
Read of size 8 at addr ffff8880175766b8 by task kworker/1:1/26
...
The buggy address belongs to the object at ffff888017576600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 184 bytes inside of
 192-byte region [ffff888017576600, ffff8880175766c0)
...
Memory state around the buggy address:
 ffff888017576580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888017576600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888017576680: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                        ^
 ffff888017576700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888017576780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

After this patch, slab-out-of-bounds report will show as below.
==================================================================
...
The buggy address belongs to the object at ffff888017576600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes right of
 allocated 184-byte region [ffff888017576600, ffff8880175766b8)
...
==================================================================

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216457 [1]

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
V1 -> V2:
 - Implement getting allocated size of object for tag-based kasan.
 - Refine the kasan report.
 - Check if it is slab-out-of-bounds report type.
 - Thanks for Andrey and Dmitry suggestion.

 mm/kasan/kasan.h          |  2 ++
 mm/kasan/report.c         | 20 +++++++++++++-------
 mm/kasan/report_generic.c | 24 ++++++++++++++++++++++++
 mm/kasan/report_hw_tags.c | 18 ++++++++++++++++++
 mm/kasan/report_sw_tags.c | 17 +++++++++++++++++
 mm/kasan/report_tags.c    |  8 ++++++++
 6 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index abbcc1b0eec5..15ffd46fec6a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -185,6 +185,7 @@ struct kasan_report_info {
 	const char *bug_type;
 	struct kasan_track alloc_track;
 	struct kasan_track free_track;
+	int obj_size;
 };
 
 /* Do not change the struct layout: compiler ABI. */
@@ -306,6 +307,7 @@ static inline bool addr_has_metadata(const void *addr)
 void *kasan_find_first_bad_addr(void *addr, size_t size);
 void kasan_complete_mode_report_info(struct kasan_report_info *info);
 void kasan_metadata_fetch_row(char *buffer, void *row);
+int kasan_get_alloc_size(void *object_addr, struct kmem_cache *cache);
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 void kasan_print_tags(u8 addr_tag, const void *addr);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index df3602062bfd..dae0d4ae8fe9 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -210,12 +210,13 @@ static inline struct page *addr_to_page(const void *addr)
 }
 
 static void describe_object_addr(const void *addr, struct kmem_cache *cache,
-				 void *object)
+				 void *object, int obj_size, const char *bug_type)
 {
 	unsigned long access_addr = (unsigned long)addr;
 	unsigned long object_addr = (unsigned long)object;
 	const char *rel_type;
 	int rel_bytes;
+	bool slab_oob = false;
 
 	pr_err("The buggy address belongs to the object at %px\n"
 	       " which belongs to the cache %s of size %d\n",
@@ -224,18 +225,22 @@ static void describe_object_addr(const void *addr, struct kmem_cache *cache,
 	if (access_addr < object_addr) {
 		rel_type = "to the left";
 		rel_bytes = object_addr - access_addr;
-	} else if (access_addr >= object_addr + cache->object_size) {
+	} else if (access_addr >= object_addr + obj_size) {
 		rel_type = "to the right";
-		rel_bytes = access_addr - (object_addr + cache->object_size);
+		rel_bytes = access_addr - (object_addr + obj_size);
 	} else {
 		rel_type = "inside";
 		rel_bytes = access_addr - object_addr;
 	}
 
+	if (strcmp(bug_type, "slab-out-of-bounds") == 0)
+		slab_oob = true;
+
 	pr_err("The buggy address is located %d bytes %s of\n"
-	       " %d-byte region [%px, %px)\n",
-		rel_bytes, rel_type, cache->object_size, (void *)object_addr,
-		(void *)(object_addr + cache->object_size));
+	       " %s%d-byte region [%px, %px)\n",
+	       rel_bytes, rel_type, slab_oob ? "allocated " : "",
+	       obj_size, (void *)object_addr,
+	       (void *)(object_addr + obj_size));
 }
 
 static void describe_object_stacks(struct kasan_report_info *info)
@@ -257,7 +262,8 @@ static void describe_object(const void *addr, struct kasan_report_info *info)
 {
 	if (kasan_stack_collection_enabled())
 		describe_object_stacks(info);
-	describe_object_addr(addr, info->cache, info->object);
+	describe_object_addr(addr, info->cache, info->object, info->obj_size,
+			info->bug_type);
 }
 
 static inline bool kernel_or_module_addr(const void *addr)
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 043c94b04605..7b4bec9e6d1a 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -43,6 +43,25 @@ void *kasan_find_first_bad_addr(void *addr, size_t size)
 	return p;
 }
 
+int kasan_get_alloc_size(void *addr, struct kmem_cache *cache)
+{
+	int size = 0;
+	u8 *shadow;
+
+	shadow = (u8 *)kasan_mem_to_shadow(addr);
+	while (size < cache->object_size) {
+		if (*shadow == 0)
+			size += KASAN_GRANULE_SIZE;
+		else if (*shadow >= 1 && *shadow <= KASAN_GRANULE_SIZE - 1)
+			size += *shadow;
+		else
+			return size;
+		shadow++;
+	}
+
+	return cache->object_size;
+}
+
 static const char *get_shadow_bug_type(struct kasan_report_info *info)
 {
 	const char *bug_type = "unknown-crash";
@@ -149,6 +168,11 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 		memcpy(&info->free_track, &free_meta->free_track,
 		       sizeof(info->free_track));
 	}
+
+	if (strcmp(info->bug_type, "slab-out-of-bounds") == 0)
+		info->obj_size = kasan_get_alloc_size(info->object, info->cache);
+	else
+		info->obj_size = info->cache->object_size;
 }
 
 void kasan_metadata_fetch_row(char *buffer, void *row)
diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
index f3d3be614e4b..e462dd750fe2 100644
--- a/mm/kasan/report_hw_tags.c
+++ b/mm/kasan/report_hw_tags.c
@@ -21,6 +21,24 @@ void *kasan_find_first_bad_addr(void *addr, size_t size)
 	return kasan_reset_tag(addr);
 }
 
+int kasan_get_alloc_size(void *addr, struct kmem_cache *cache)
+{
+	int size = 0, i = 0;
+	u8 memory_tag;
+
+	while (size < cache->object_size) {
+		memory_tag = hw_get_mem_tag(addr + i * KASAN_GRANULE_SIZE);
+
+		if (memory_tag != KASAN_TAG_INVALID)
+			size += KASAN_GRANULE_SIZE;
+		else
+			return size;
+		i++;
+	}
+
+	return cache->object_size;
+}
+
 void kasan_metadata_fetch_row(char *buffer, void *row)
 {
 	int i;
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index 7a26397297ed..d50caefd7fd5 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -45,6 +45,23 @@ void *kasan_find_first_bad_addr(void *addr, size_t size)
 	return p;
 }
 
+int kasan_get_alloc_size(void *addr, struct kmem_cache *cache)
+{
+	int size = 0;
+	u8 *shadow;
+
+	shadow = (u8 *)kasan_mem_to_shadow(addr);
+	while (size < cache->object_size) {
+		if (*shadow != KASAN_TAG_INVALID)
+			size += KASAN_GRANULE_SIZE;
+		else
+			return size;
+		shadow++;
+	}
+
+	return cache->object_size;
+}
+
 void kasan_metadata_fetch_row(char *buffer, void *row)
 {
 	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index ecede06ef374..b349a0ae1b83 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -7,6 +7,7 @@
 #include <linux/atomic.h>
 
 #include "kasan.h"
+#include "../slab.h"
 
 extern struct kasan_stack_ring stack_ring;
 
@@ -113,4 +114,11 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 	/* Assign the common bug type if no entries were found. */
 	if (!info->bug_type)
 		info->bug_type = get_common_bug_type(info);
+
+	if (info->object && info->cache) {
+		if (strcmp(info->bug_type, "slab-out-of-bounds") == 0)
+			info->obj_size = kasan_get_alloc_size(info->object, info->cache);
+		else
+			info->obj_size = info->cache->object_size;
+	}
 }
-- 
2.18.0

