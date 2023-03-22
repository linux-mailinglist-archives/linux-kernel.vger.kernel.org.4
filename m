Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273266C473F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCVKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCVKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6385AB55;
        Wed, 22 Mar 2023 03:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92C2961291;
        Wed, 22 Mar 2023 10:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DA9C433EF;
        Wed, 22 Mar 2023 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679479748;
        bh=zgcC6CFHZEkI+Y2u0uiAz37vl2FpD8zXEz7zQwJ3YgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBldOBrrjEJQyxaaZp7OQNB1SSqzEmP3LPBASeMLFq0NxHJmyy8pb62xgPTuT2rrl
         6K8u9Y1zqQsnpQNjWOjqedrMPvF8Ypo1JOQyHcV3iZmDCTNcgSenm66S3/vV/eZCe5
         NO8+Sg8q0OXzMRCkokx03NpJ38tNXVfmxv4EyRljot5UFqB3fTTN/zABBuocnmCFUO
         48I7P+cBAHwLRO0bfnYpe8HnrTETSbOT6/UUrcOQ1MiJgQsljMY/ULuROdwFH/Uy7o
         f+DA0TznZBkO3xGTPxfNMjQCylCW0GGRUysXlecbKAq2nUlUo0tzBF2nc5vWiaraJ2
         MBpKTrjx2sUtg==
Date:   Wed, 22 Mar 2023 12:08:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/14] mm: call {ptlock,pgtable}_cache_init() directly
 from mm_core_init()
Message-ID: <ZBrTtQKe7SowXSKb@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-9-rppt@kernel.org>
 <ff403707-a61b-8b87-4d8d-5aecaa574be3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff403707-a61b-8b87-4d8d-5aecaa574be3@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:06:18PM +0300, Sergei Shtylyov wrote:
> On 3/21/23 8:05 PM, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > and drop pgtable_init() as it has no real value and it's name is
> 
>    Its name.

oops :)

Andrew, can you replace this patch with the updated version, please?
 
From 52420723c9bfa84aa48f666330e96f9e5b2f3248 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (IBM)" <rppt@kernel.org>
Date: Sat, 18 Mar 2023 13:55:28 +0200
Subject: [PATCH v3] mm: call {ptlock,pgtable}_cache_init() directly from
 mm_core_init()

and drop pgtable_init() as it has no real value and its name is
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

-- 
Sincerely yours,
Mike.
