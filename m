Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC636C05D8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjCSWBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCSWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:00:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15251D926;
        Sun, 19 Mar 2023 15:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D829B80B8A;
        Sun, 19 Mar 2023 22:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2E8C433A0;
        Sun, 19 Mar 2023 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263241;
        bh=P8FXnqE0dz8+EFTBTuViTvRWyj1tIPqZHteVCKqB69c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKXnkkoHgl0euhog4fZoR5wa1c1Sd1phnsl14UWKcX5nkks8OeN3Jxnh6Fc9iJydM
         DzTs8rBsC1k3D1xz99rAr1FAM4G1QaAtbwlmRgyLhloYNQdUTrdTseiSply+39hlVB
         J7unwXUSRZjkZBtSLNT46Su7PVQfoEmN4alECNByK10OBwwFvM4I4brCN67bkGyqdw
         +8Axk9QL2Ld8K7ysWax2H47g1RkxYxAqYMYxygOXB79+RlEsaM7B5HbLbhZmUsZ62f
         4d4yuRcfRDuNKFHgp5qUQzLj6gM3u83AijuLjnnZvEjGwLzkSxFOwg7KDjRtZGLLBf
         IiyMGiuxlsp/A==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 05/15] mm: handle hashdist initialization in mm/mm_init.c
Date:   Sun, 19 Mar 2023 23:59:58 +0200
Message-Id: <20230319220008.2138576-6-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
---
 mm/mm_init.c    | 22 ++++++++++++++++++++++
 mm/page_alloc.c | 18 ------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 63aa7b6b2880..8aaaddd13a20 100644
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

