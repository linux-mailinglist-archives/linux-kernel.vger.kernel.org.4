Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA8725232
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbjFGCvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFGCvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:51:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C77173B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:51:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b04949e5baso60279975ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 19:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686106269; x=1688698269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2ax2figgKOg2flp2WzEe3WSnm61sq9EXkQEI4kHtRM=;
        b=bYiCLhPHy4LMGEt3Qd5bIN1/iRv9YAoOWI6mY7mKQwSKU4u3Srkodt/0b5tjiv+k9H
         KXmi09+TBPfrCmZ7GJvNI+7sHgusTtxD3yfwosnNtB4KdS/NlnRpIGth+jL7n9p1uoiX
         DkXeYUMxAsN+08QlMYuGuhmyngRt1qpKQio7s+oA0PR6jDKvj9b0KOZS+CR99GDAFxz7
         GkZnz+anqOfxu5Ob8LKG8ffLjyX9RruCAhEBaq67MXu2P3BMpk9dLs2wiPmPLPTowa4F
         SZ01vmAZ0JDiFoatLHT/QwZUKs6/CsN/EpJAoZOrZGIWXvWoM7I7Fb0jtsFWzKCOAgxf
         D8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686106269; x=1688698269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2ax2figgKOg2flp2WzEe3WSnm61sq9EXkQEI4kHtRM=;
        b=fsUpr5E3YrqmAdxir5EXeI6QG2ETWsnC8DHLWQUw+qTd05ph13/db2zAAPpu4e9NNM
         kZt4ey8DNdlkJ+/Wfedmx294aaf+wSH5H+oSGdSaYEFzsIuQOU5N4o71ckdOqj+kjlSn
         iPlS1f471D2G7FOQha+T3LH48m0gD8XsezWEly4LVfwsUyiPWHhXvYi6/h2JxhqFLvd6
         ON80VfL+C3szjqZSK1+XW3TnwqLTTy7NbgJN43wfd/CoNHw6TnzALL9GN+7aMrxIqlT7
         W1OBB102hAlwXCC9QlDHdQ5Us/HtGCFrgN4SSPtJAUvEOBtZHNZCsIutX3SKXrrb/VsN
         YU0A==
X-Gm-Message-State: AC+VfDxbOhnxQFU6El7VDesP6zs7f6KX055PHCGpMZBxpLxKDJP/bLvD
        dmxrGtzwcGB/KQAZbSpiZU6gW5kRHGBhXqwSnKWKjwki
X-Google-Smtp-Source: ACHHUZ4EP8dF5XtjL1pzBueRKpoWxNruwp17dcMuGbUeRWvlS9kN6Iag3aBuOVg6tm17TObzZ0EFUg==
X-Received: by 2002:a17:902:e846:b0:1ae:6a3:d058 with SMTP id t6-20020a170902e84600b001ae06a3d058mr4242727plg.36.1686106269476;
        Tue, 06 Jun 2023 19:51:09 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b00186a2274382sm9239439plh.76.2023.06.06.19.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 19:51:09 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     david@redhat.com
Cc:     rppt@kernel.org, osalvador@suse.de, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 2/2] mm/mm_init.c: remove reset_node_present_pages()
Date:   Wed,  7 Jun 2023 02:50:56 +0000
Message-Id: <20230607025056.1348-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d92273f6-28be-dc37-3ca5-a9579a75f8c4@redhat.com>
References: <d92273f6-28be-dc37-3ca5-a9579a75f8c4@redhat.com>
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

reset_node_present_pages() only get called in hotadd_init_pgdat(), move
the action that clear present pages to free_area_init_core_hotplug(), so
the helper can be removed.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
v2:
- declare 'struct zone' within the for loop
- fix comment layout
---
 mm/memory_hotplug.c | 18 ------------------
 mm/mm_init.c        | 15 +++++++++++++--
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 65e385f34679..ee1c0d9a4d5a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1172,16 +1172,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	return ret;
 }
 
-static void reset_node_present_pages(pg_data_t *pgdat)
-{
-	struct zone *z;
-
-	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
-		z->present_pages = 0;
-
-	pgdat->node_present_pages = 0;
-}
-
 /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
 static pg_data_t __ref *hotadd_init_pgdat(int nid)
 {
@@ -1204,14 +1194,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 */
 	build_all_zonelists(pgdat);
 
-	/*
-	 * When memory is hot-added, all the memory is in offline state. So
-	 * clear all zones' present_pages because they will be updated in
-	 * online_pages() and offline_pages().
-	 * TODO: should be in free_area_init_core_hotplug?
-	 */
-	reset_node_present_pages(pgdat);
-
 	return pgdat;
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 78e67041ae9f..a02ba9a79b3d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1507,6 +1507,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 	pgdat->kswapd_order = 0;
 	pgdat->kswapd_highest_zoneidx = 0;
 	pgdat->node_start_pfn = 0;
+	pgdat->node_present_pages = 0;
+
 	for_each_online_cpu(cpu) {
 		struct per_cpu_nodestat *p;
 
@@ -1514,8 +1516,17 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 		memset(p, 0, sizeof(*p));
 	}
 
-	for (z = 0; z < MAX_NR_ZONES; z++)
-		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
+	/*
+	 * When memory is hot-added, all the memory is in offline state. So
+	 * clear all zones' present_pages and managed_pages because they will
+	 * be updated in online_pages() and offline_pages().
+	 */
+	for (z = 0; z < MAX_NR_ZONES; z++) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		zone->present_pages = 0;
+		zone_init_internals(zone, z, nid, 0);
+	}
 }
 #endif
 
-- 
2.25.1

