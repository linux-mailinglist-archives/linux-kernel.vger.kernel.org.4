Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B881A7122B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbjEZIxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbjEZIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:53:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17C9B
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:53:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1afbc02c602so14569125ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685091211; x=1687683211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vULi8wP3cxO4TEAm2rbpl3Qmvd6xJYVlkRF7oAxYgxQ=;
        b=ZE2T2CWUJ8fXrRdBuSxPnMkGmKH352ocr4/VgManWjp7N3POEfQ5B8IvhDcAtTJGLB
         ThDPY6JboiSIzxSskqNIa0/KYwVb4UK6lZZ/LQDgdCWPrRqXazsKIteW4P4gMSRmo5bL
         HB6RGmbwANNSjoZvuYiwvc2k2/VqnBRedk6pReISAUfpuhYz0p3rC9QnMgfofFH4OR9A
         uruWHE5HSQNPuR0El4DHtx8bzKE2C5r+MdDLcRoTmg7VEklCbFg1+b+y18f5ekAaUp2x
         c25eXq9xsnnY6GfgDyQ3tSlP9oBeZbz6UZCFhigMbA0Kkay+1I5rXas7FVdBQLVthnuU
         FiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091211; x=1687683211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vULi8wP3cxO4TEAm2rbpl3Qmvd6xJYVlkRF7oAxYgxQ=;
        b=PojfcC+z8b8uUnkGgogdc0xUNF0ir2mO7fYIm1/IgnztdqwKtuiBy5MuUbyVMLHk5l
         usu0TSK4PmwXltSwdk/fbZLtlc0iRV5cEVM1FXdGyL+hzilRsPdqvTv0xCiuHkY6Hzbs
         u+LI6jS8YZ+gQ8SmNJqhFzYI4s1XfzupG3wYPuYdW1qGLboqimiumM81hu3qG5TlmMv/
         Pl2B7kuPnzdImJCzdjVSPVuej6gybgaaWjNLN/ibzc6NAPUtWsoamCu+XopZgx0vxYIb
         q8euxY8ArGtHx45oUq5b7sTpEs0zuA4P8uFeLhu4gekkcnT5Y22rXtHlF/c2zPXBa68J
         2l9Q==
X-Gm-Message-State: AC+VfDytlgPOK3ZQPeo7QlZAhJ3KxhvvPfbRrsI0ezmiDLi+ycwnowiy
        NhQkzk4bSBjcislLUH81ea+8Eg==
X-Google-Smtp-Source: ACHHUZ7i9Uo5IejiNNDJhMv1eKhCiZVnnIJJfyGnzZMigjzGlsUMnijNc1cjuVgvuJ3wRqNNAv5FXg==
X-Received: by 2002:a17:903:44c:b0:1ae:4dda:c2e with SMTP id iw12-20020a170903044c00b001ae4dda0c2emr4829720plb.13.1685091211144;
        Fri, 26 May 2023 01:53:31 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b0019ee045a2b3sm2713911plr.308.2023.05.26.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:53:30 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 1/2] mm/mm_init.c: introduce reset_memoryless_node_totalpages()
Date:   Fri, 26 May 2023 08:52:50 +0000
Message-Id: <20230526085251.1977-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, no matter whether a node actually has memory or not,
calculate_node_totalpages() is used to account number of pages
in zone/node. However, for node without memory, these unnecessary
calculations can be skipped. All the zone/node page counts can be
set to 0 directly. So introduce reset_memoryless_node_totalpages()
to perform this action.

Furthermore, calculate_node_totalpages() only gets called for the
node with memory.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
---
v2:
- drop patch 2 in v1
- inroduce new function reset_memoryless_node_totalpages()
- call calculate_node_totalpages only if node actually has
  memory
---
 mm/mm_init.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..f674e5798f7d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1174,10 +1174,6 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
 	unsigned long zone_start_pfn, zone_end_pfn;
 	unsigned long nr_absent;
 
-	/* When hotadd a new node from cpu_up(), the node should be empty */
-	if (!node_start_pfn && !node_end_pfn)
-		return 0;
-
 	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
 	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
 
@@ -1227,9 +1223,6 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
 {
 	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
 	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
-	/* When hotadd a new node from cpu_up(), the node should be empty */
-	if (!node_start_pfn && !node_end_pfn)
-		return 0;
 
 	/* Get the start and end of the zone */
 	*zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
@@ -1250,6 +1243,24 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
 	return *zone_end_pfn - *zone_start_pfn;
 }
 
+static void __init reset_memoryless_node_totalpages(struct pglist_data *pgdat)
+{
+	struct zone *z;
+
+	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++) {
+		z->zone_start_pfn = 0;
+		z->spanned_pages = 0;
+		z->present_pages = 0;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+		z->present_early_pages = 0;
+#endif
+	}
+
+	pgdat->node_spanned_pages = 0;
+	pgdat->node_present_pages = 0;
+	pr_debug("On node %d totalpages: 0\n", pgdat->node_id);
+}
+
 static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn)
@@ -1702,11 +1713,13 @@ static void __init free_area_init_node(int nid)
 		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
 			(u64)start_pfn << PAGE_SHIFT,
 			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
+
+		calculate_node_totalpages(pgdat, start_pfn, end_pfn);
 	} else {
 		pr_info("Initmem setup node %d as memoryless\n", nid);
-	}
 
-	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
+		reset_memoryless_node_totalpages(pgdat);
+	}
 
 	alloc_node_mem_map(pgdat);
 	pgdat_set_deferred_range(pgdat);
-- 
2.25.1

