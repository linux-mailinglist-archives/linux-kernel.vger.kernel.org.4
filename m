Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1F65BB75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjACH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjACH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:56:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8CCE6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:56:23 -0800 (PST)
X-UUID: aa2a2e6b3e0e4000b97ef770b4a1a713-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NZ9NhCNssNEj8jHwgbBdhsDJ/+YeWKw4bYC90Z9LVjk=;
        b=nR+3dsVKmbCAehJGYivb98X9J3AJZcILW7qt46EDi1sdadR8Lz1yW3Ud+EMun+f4MSMpb6siI89X6f3VLiLZ2INahYO18CfCTVZla7dWIqc/c5VJmClEsltdKAPFFt/mJUdig4q4beRKbolNSB/dotPG5yxbACkhltTu216nJtU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:6b61d3a4-de50-4fd9-9abd-1247832a57ff,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:9bb5a3f4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: aa2a2e6b3e0e4000b97ef770b4a1a713-20230103
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 500920781; Tue, 03 Jan 2023 15:56:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 3 Jan 2023 15:56:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 3 Jan 2023 15:56:18 +0800
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
Subject: [PATCH] kasan: infer the requested size by scanning shadow memory
Date:   Tue, 3 Jan 2023 15:55:58 +0800
Message-ID: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We scan the shadow memory to infer the requested size instead of
printing cache->object_size directly.

This patch will fix the confusing generic kasan report like below. [1]
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

After this patch, report will show "cache kmalloc-192 of size 184".

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216457 [1]

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 mm/kasan/kasan.h          |  5 +++++
 mm/kasan/report.c         |  3 ++-
 mm/kasan/report_generic.c | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 32413f22aa82..7bb627d21580 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -340,8 +340,13 @@ static inline void kasan_print_address_stack_frame(const void *addr) { }
 
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object);
+int kasan_get_alloc_size(void *object_addr, struct kmem_cache *cache);
 #else
 static inline void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object) { }
+static inline int kasan_get_alloc_size(void *object_addr, struct kmem_cache *cache)
+{
+	return cache->object_size;
+}
 #endif
 
 bool kasan_report(unsigned long addr, size_t size,
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 1d02757e90a3..6de454bb2cad 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -236,12 +236,13 @@ static void describe_object_addr(const void *addr, struct kmem_cache *cache,
 {
 	unsigned long access_addr = (unsigned long)addr;
 	unsigned long object_addr = (unsigned long)object;
+	int real_size = kasan_get_alloc_size((void *)object_addr, cache);
 	const char *rel_type;
 	int rel_bytes;
 
 	pr_err("The buggy address belongs to the object at %px\n"
 	       " which belongs to the cache %s of size %d\n",
-		object, cache->name, cache->object_size);
+		object, cache->name, real_size);
 
 	if (access_addr < object_addr) {
 		rel_type = "to the left";
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 043c94b04605..01b38e459352 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -43,6 +43,24 @@ void *kasan_find_first_bad_addr(void *addr, size_t size)
 	return p;
 }
 
+int kasan_get_alloc_size(void *addr, struct kmem_cache *cache)
+{
+	int size = 0;
+	u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
+
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
-- 
2.18.0

