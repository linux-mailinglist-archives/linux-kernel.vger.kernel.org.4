Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1174D8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjGJOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGJOOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:14:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943CD2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:14:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e6541c98so4003168b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688998461; x=1691590461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv8u75UgPYyw3J1c9x8u8HK0vBlvX+2V/eWoGzYtNdA=;
        b=EnnUPxjQSRVAftNOSQhQMjO52wPL4wQUmZ9WZbSnktt9md1Ol3cg6GnBkmpRFi1qCR
         sL8jv0E56Ymlc0CfjwkNSK2MF06DXTJfLqLchxLzGLp9GugiIQ9NA78Nx4cYFx4mf0+x
         lflaF910uZF8eRd/t+tfVMa1e5ef3HkxZ89E0yTAlZaHTJcXb9xQduW9RH2gWYgiakMe
         A8hqCiXb6qHUA6l/vTA+Qw847QlvJ/aS30/+1hPZ7QO7oLGdoiWETZUmuR+Rem1dmXqD
         HVyR2kIRjwI/TDNEODrsMuRVKOgACfucnYVKAoWYkgQQLOES5SjtLQ0PAUgbKHbEjJVf
         IKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688998461; x=1691590461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv8u75UgPYyw3J1c9x8u8HK0vBlvX+2V/eWoGzYtNdA=;
        b=l3ldNH6Y1XOLHas2tOYenh+J8j/umE50aw9Ephk2Jv2KdpGOHBBa9Y42dRJodW99/K
         7z1+TM8bT5Vrigwv8NCZylhbBkDUpzQfZbweAeDDIJL+AHbZZC8aMl8+uNqoFOBmlHJy
         ZxJEdDYsQxUIiCZ+eEIQAyoAMwMy5RTBfTDYo5+uxdQniTtm5jMW+lxh2vfJUPVJJXx7
         FpT7Ssr6u0JCWc0+uvmp0g6C0e40soGN8QxKcjYUTzYi3cwHdrwHh4bqQLMp+/q3AN88
         vszrovnRb3ECvydq8f430Yesa8axjWdAKf/CPfk3Iq7ya84ndTmX3Er/wPZ0vXm9WZ5z
         5QSA==
X-Gm-Message-State: ABy/qLY6s+6jL9ZAhulrYWaQZ1tRJ9oXOoj2ufLt59rkpBmIABh9AJAv
        A6t/ouLYBXIuXlQa6ccQP8c=
X-Google-Smtp-Source: APBJJlHsZpjqp1tOUsGLo2NIwaH4oWoc0CdMZFihBn4V9/gyCo4grpssGwQBRVOssU7NBeu0jaLAJQ==
X-Received: by 2002:a05:6a00:15d3:b0:67f:1d30:9e51 with SMTP id o19-20020a056a0015d300b0067f1d309e51mr17644702pfu.33.1688998461035;
        Mon, 10 Jul 2023 07:14:21 -0700 (PDT)
Received: from localhost ([58.38.26.179])
        by smtp.gmail.com with ESMTPSA id a9-20020a62bd09000000b0066884d4efdbsm7432182pff.12.2023.07.10.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:14:20 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Cc:     zhoubinbin@loongson.cn, chenfeiyang@loongson.cn,
        jiaxun.yang@flygoat.com, rppt@kernel.org,
        akpm@linux-foundation.org, hpa@zytor.com, x86@kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com,
        kernel@xen0n.name, chenhuacai@kernel.org,
        Liam Ni <zhiguangni01@gmail.com>
Subject: [PATCH V3] [PATCH V3] NUMA:Improve the efficiency of calculating pages loss
Date:   Mon, 10 Jul 2023 22:14:08 +0800
Message-Id: <20230710141408.9998-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of pages in memblock that doesn't have the node
assigned,which also means that these pages are not in numa_info.
So these pages can represent the number of lose pages.

V2:https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmail.com/
V1:https://lore.kernel.org/all/20230615142016.419570-1-zhiguangni01@gmail.com/

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 arch/loongarch/kernel/numa.c | 23 ++++++++---------------
 arch/x86/mm/numa.c           | 26 +++++++-------------------
 include/linux/mm.h           |  1 +
 mm/mm_init.c                 | 20 ++++++++++++++++++++
 4 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 708665895b47..0239891e4d19 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -262,25 +262,18 @@ static void __init node_mem_init(unsigned int node)
  * Sanity check to catch more bad NUMA configurations (they are amazingly
  * common).  Make sure the nodes cover all memory.
  */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
+static bool __init memblock_validate_numa_coverage(const u64 limit)
 {
-	int i;
-	u64 numaram, biosram;
+	u64 lo_pg;
 
-	numaram = 0;
-	for (i = 0; i < mi->nr_blks; i++) {
-		u64 s = mi->blk[i].start >> PAGE_SHIFT;
-		u64 e = mi->blk[i].end >> PAGE_SHIFT;
+	lo_pg = max_pfn - calculate_without_node_pages_in_range();
 
-		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
-		if ((s64)numaram < 0)
-			numaram = 0;
+	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
+	if (lo_pg >= limit) {
+		pr_err("NUMA: We lost 1m size page.\n");
+		return false;
 	}
-	max_pfn = max_low_pfn;
-	biosram = max_pfn - absent_pages_in_range(0, max_pfn);
 
-	BUG_ON((s64)(biosram - numaram) >= (1 << (20 - PAGE_SHIFT)));
 	return true;
 }
 
@@ -428,7 +421,7 @@ int __init init_numa_memory(void)
 		return -EINVAL;
 
 	init_node_memblock();
-	if (numa_meminfo_cover_memory(&numa_meminfo) == false)
+	if (memblock_validate_numa_coverage(SZ_1M) == false)
 		return -EINVAL;
 
 	for_each_node_mask(node, node_possible_map) {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..14feec144675 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -451,30 +451,18 @@ EXPORT_SYMBOL(__node_distance);
  * Sanity check to catch more bad NUMA configurations (they are amazingly
  * common).  Make sure the nodes cover all memory.
  */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
+static bool __init memblock_validate_numa_coverage(const u64 limit)
 {
-	u64 numaram, e820ram;
-	int i;
+	u64 lo_pg;
 
-	numaram = 0;
-	for (i = 0; i < mi->nr_blks; i++) {
-		u64 s = mi->blk[i].start >> PAGE_SHIFT;
-		u64 e = mi->blk[i].end >> PAGE_SHIFT;
-		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
-		if ((s64)numaram < 0)
-			numaram = 0;
-	}
-
-	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
+	lo_pg = max_pfn - calculate_without_node_pages_in_range();
 
 	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
-	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
-		printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
-		       (numaram << PAGE_SHIFT) >> 20,
-		       (e820ram << PAGE_SHIFT) >> 20);
+	if (lo_pg >= limit) {
+		pr_err("NUMA: We lost 1m size page.\n");
 		return false;
 	}
+
 	return true;
 }
 
@@ -583,7 +571,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			return -EINVAL;
 		}
 	}
-	if (!numa_meminfo_cover_memory(mi))
+	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
 
 	/* Finally register nodes. */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0daef3f2f029..b32457ad1ae3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3043,6 +3043,7 @@ unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
 						unsigned long end_pfn);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
+extern unsigned long calculate_without_node_pages_in_range(void);
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3ddd18a89b66..13a4883787e3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1132,6 +1132,26 @@ static void __init adjust_zone_range_for_zone_movable(int nid,
 	}
 }
 
+/**
+ * @start_pfn: The start PFN to start searching for holes
+ * @end_pfn: The end PFN to stop searching for holes
+ *
+ * Return: Return the number of page frames without node assigned within a range.
+ */
+unsigned long __init calculate_without_node_pages_in_range(void)
+{
+	unsigned long num_pages;
+	unsigned long start_pfn, end_pfn;
+	int nid, i;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		if (nid == NUMA_NO_NODE)
+			num_pages += end_pfn - start_pfn;
+	}
+
+	return num_pages;
+}
+
 /*
  * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
  * then all holes in the requested range will be accounted for.
-- 
2.25.1

