Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59DC6C37C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCURHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCURGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7553D8D;
        Tue, 21 Mar 2023 10:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EC1A61D51;
        Tue, 21 Mar 2023 17:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EA9C433EF;
        Tue, 21 Mar 2023 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418360;
        bh=l6knMFWLRO6NO1OlV9wEy5NTCDPOQC0mr+EPbgyJTJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1+3RUxV8PjdFb2Z3pJU1FBDhbdrnaFRGETGsBn//Zlj51dbwei2/lrw+AKTnP3qK
         qsLdEwU+0j0zaQJcDaezHRMSOUDut9/IXVVYbHpy6ARc6hmxNtTBb4JqDZdVtaZM6X
         76LGkvPoFkzHwg8h5UbNJUW8+gfXg2GYAB0/nU95mx/46l8TKFO3TW0tQbKHq9/HT/
         /DtKEAieU2fZHcDcpayxDcyi3p1HUnTgwmMyG/cW7RdQ8qbAjSmtDkYY+EWN8lHthX
         YILzxaJYNzM6fK66YFzIOp0ztAWP9rSZiErQ/EN26L3SNzNsUPYM70hZHcb757bUb1
         OSSJqMpe8djdg==
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
Subject: [PATCH v2 08/14] mm: call {ptlock,pgtable}_cache_init() directly from mm_core_init()
Date:   Tue, 21 Mar 2023 19:05:07 +0200
Message-Id: <20230321170513.2401534-9-rppt@kernel.org>
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

and drop pgtable_init() as it has no real value and it's name is
misleading.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 6 ------
 mm/mm_init.c       | 3 ++-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d7f095136fc..c3c67d8bc833 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2782,12 +2782,6 @@ static inline bool ptlock_init(struct page *page) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline void pgtable_init(void)
-{
-	ptlock_cache_init();
-	pgtable_cache_init();
-}
-
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
diff --git a/mm/mm_init.c b/mm/mm_init.c
index bba73f1fb277..f1475413394d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2584,7 +2584,8 @@ void __init mm_core_init(void)
 	 */
 	page_ext_init_flatmem_late();
 	kmemleak_init();
-	pgtable_init();
+	ptlock_cache_init();
+	pgtable_cache_init();
 	debug_objects_mem_init();
 	vmalloc_init();
 	/* If no deferred init page_ext now, as vmap is fully initialized */
-- 
2.35.1

