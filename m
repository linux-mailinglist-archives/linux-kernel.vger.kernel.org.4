Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1856C37BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCURGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCURFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A052F5F;
        Tue, 21 Mar 2023 10:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE47C61D4E;
        Tue, 21 Mar 2023 17:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D45C433EF;
        Tue, 21 Mar 2023 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418344;
        bh=MPWRuoot5VH9l7RTC3NQyqOuQ7W1sTgroDlLaej4jgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ki4HDy3h8Gte0ZZEiRROBgIVBKFw/KuBSOBtijYBxEVe/p0aoS4vQdaXkNPzwqJiy
         jm62Y7wVswZ217UB4t9S6RFrE+xX2Aao48V72Jt+lJScMIs2rLYjzI38K++ZlzsIkN
         i/L8Zo/nLOb/yunaZ65ZbQOSUL5sKCjfTgEaxzzfUa94sKcDTnLlLzB5lPAVdkSyyy
         F8EUSzfSGiOVR8MHUlvJfsNjsn63XilQL/5NFHyCYEiYete/89jyWdOkUmMYvIpQ5N
         we3BPRxPxI0VZoDmzEjWBv4KLNuxG9TJ5NQq7Hxa4nTmiROIigUvgn7nULl7rQz+Jr
         MhE9LOk0eZosw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 04/14] mm: handle hashdist initialization in mm/mm_init.c
Date:   Tue, 21 Mar 2023 19:05:03 +0200
Message-Id: <20230321170513.2401534-5-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The hashdist variable must be initialized before the first call to
alloc_large_system_hash() and free_area_init() looks like a better place
for it than page_alloc_init().

Move hashdist handling to mm/mm_init.c

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mm_init.c    | 22 ++++++++++++++++++++++
 mm/page_alloc.c | 18 ------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 68d0187c7886..2e60c7186132 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -607,6 +607,25 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 
 	return nid;
 }
+
+int hashdist = HASHDIST_DEFAULT;
+
+static int __init set_hashdist(char *str)
+{
+	if (!str)
+		return 0;
+	hashdist = simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("hashdist=", set_hashdist);
+
+static inline void fixup_hashdist(void)
+{
+	if (num_node_state(N_MEMORY) == 1)
+		hashdist = 0;
+}
+#else
+static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -1855,6 +1874,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	}
 
 	memmap_init();
+
+	/* disable hash distribution for systems with a single node */
+	fixup_hashdist();
 }
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c56c147bdf27..ff6a2fff2880 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6383,28 +6383,10 @@ static int page_alloc_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-#ifdef CONFIG_NUMA
-int hashdist = HASHDIST_DEFAULT;
-
-static int __init set_hashdist(char *str)
-{
-	if (!str)
-		return 0;
-	hashdist = simple_strtoul(str, &str, 0);
-	return 1;
-}
-__setup("hashdist=", set_hashdist);
-#endif
-
 void __init page_alloc_init(void)
 {
 	int ret;
 
-#ifdef CONFIG_NUMA
-	if (num_node_state(N_MEMORY) == 1)
-		hashdist = 0;
-#endif
-
 	ret = cpuhp_setup_state_nocalls(CPUHP_PAGE_ALLOC,
 					"mm/page_alloc:pcp",
 					page_alloc_cpu_online,
-- 
2.35.1

