Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD256936F2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBLLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:03:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947FB421C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:03:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 78so6434136pgb.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcfVzYwQPANvaQ3YEeKrIrZyoY6D1sHP+o29Dg4fwsM=;
        b=YrKuy2r3nr3FtUgXY2Ju0cIDDVMp7LcjKJIG0PEay5WIdY69Xc+RhLvWAH/9bvDSbu
         p5pESBkU0NHzCSGY1ez0ObLpmjEo/kpbHD41PQnPDPgFR9/kedCc5Mas0JH45EaRxSmN
         v9Zbe7qfHf6JmQadL2st0BI7ovpWUscNDZSJZm9H/RbGwr3IX0p4ELNbdo6h62VVmbLx
         NhmH+OMZn9MK1peCtjm5dwGiOll//I3XXV81pez+8FI2Y4wOkvTmgfiLtcdGuKKsEaeP
         Mc0EIUz1Qj6amk6iv63ykk6EX3uW2SbttffHgKEOre0LMHJEYxqzDgfx3MXwOvlpX2rK
         D4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcfVzYwQPANvaQ3YEeKrIrZyoY6D1sHP+o29Dg4fwsM=;
        b=q6Dj4UhlytE2kWSnYdTgrK0zVry7YAQmVy7HfKAR05yk5NFwAJmx7x6zmVPID0NcX5
         iBKqx2lb/ABSETfTHBlIkK7Pr9o9/YRks52qtyZoIaUUH3VpbVRwEPxW9ri7CxIr8dIf
         HbWRINDjedT2EoLLX5kFyIEBL5MIuHANhW+Wy4vZ2oA8LPYoAdRNvoWE2dX4ykU1cTcq
         WPJhVnxn7tbjaOO/xWXyVqB/U2RmxLATXupH8dHo/dMJfnTnJk3eWCZ5b96rWnbj/xbF
         2IysQLPQdtIg+8AfJhrvNESYqNevIT2Wjhpw/J5dS9OnoGALU9zNdJep752Dlyc5BKLX
         IVxA==
X-Gm-Message-State: AO0yUKV02CKpO0IJI5z6DiSdJhYbmobwWioz0Xr84tIb5mVtE/tSfLko
        x7C4oHq68dl+weyFMFTh9uhT9Q==
X-Google-Smtp-Source: AK7set9RfIiai5AI9qdkqcCzbp6uV27HRQuTSUUWmvUp3PckXHJ0mew1kpJIQFdznV9FO7tj6tWrxA==
X-Received: by 2002:a62:86c2:0:b0:5a8:abe2:fee2 with SMTP id x185-20020a6286c2000000b005a8abe2fee2mr1342985pfd.2.1676199800095;
        Sun, 12 Feb 2023 03:03:20 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z20-20020aa791d4000000b0058e08796e98sm5963987pfa.196.2023.02.12.03.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 03:03:19 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Teng Hu <huteng.ht@bytedance.com>
Subject: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Date:   Sun, 12 Feb 2023 19:03:05 +0800
Message-Id: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, numa_register_memblks() is only interested in
those nodes which have enough memory, so it skips over
all nodes with memory below NODE_MIN_SIZE (treated as
a memoryless node). Later on, we will initialize these
memoryless nodes (allocate pgdat in free_area_init()
and build zonelist etc), and will online these nodes
in init_cpu_to_node() and init_gi_nodes().

After boot, these memoryless nodes are in N_ONLINE
state but not in N_MEMORY state. But we can still allocate
pages from these memoryless nodes.

In SLUB, we only process nodes in the N_MEMORY state,
such as allocating their struct kmem_cache_node. So if
we allocate a page from the memoryless node above to
SLUB, the struct kmem_cache_node of the node corresponding
to this page is NULL, which will cause panic.

For example, if we use qemu to start a two numa node kernel,
one of the nodes has 2M memory (less than NODE_MIN_SIZE),
and the other node has 2G, then we will encounter the
following panic:

[    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    0.150783] #PF: supervisor write access in kernel mode
[    0.151488] #PF: error_code(0x0002) - not-present page
<...>
[    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
<...>
[    0.169781] Call Trace:
[    0.170159]  <TASK>
[    0.170448]  deactivate_slab+0x187/0x3c0
[    0.171031]  ? bootstrap+0x1b/0x10e
[    0.171559]  ? preempt_count_sub+0x9/0xa0
[    0.172145]  ? kmem_cache_alloc+0x12c/0x440
[    0.172735]  ? bootstrap+0x1b/0x10e
[    0.173236]  bootstrap+0x6b/0x10e
[    0.173720]  kmem_cache_init+0x10a/0x188
[    0.174240]  start_kernel+0x415/0x6ac
[    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
[    0.175417]  </TASK>
[    0.175713] Modules linked in:
[    0.176117] CR2: 0000000000000000

In addition, we can also encountered this panic in the actual
production environment. We set up a 2c2g container with two
numa nodes, and then reserved 128M for kdump, and then we
can encountered the above panic in the kdump kernel.

To fix it, we can filter memoryless nodes when allocating
pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reported-by: Teng Hu <huteng.ht@bytedance.com>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 588555754601..b9cce56f4e21 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4188,6 +4188,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			(alloc_flags & ALLOC_CPUSET) &&
 			!__cpuset_zone_allowed(zone, gfp_mask))
 				continue;
+
+		/* Don't allocate page from memoryless nodes. */
+		if (!node_state((zone_to_nid(zone)), N_MEMORY))
+			continue;
+
 		/*
 		 * When allocating a page cache page for writing, we
 		 * want to get it from a node that is within its dirty
-- 
2.20.1

