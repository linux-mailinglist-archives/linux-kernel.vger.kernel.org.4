Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3276C05DB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCSWBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCSWAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4B14E86;
        Sun, 19 Mar 2023 15:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F40C611D1;
        Sun, 19 Mar 2023 22:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A58C4339C;
        Sun, 19 Mar 2023 22:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263244;
        bh=IbslJwQtSp0K62Trj6TOitHikiCkl9yMUWR56UtzbLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTcFp2H2uu/R1vYPaYke53LsDbKWDgvSDvKi6CPldoQ/4qufDzX2VtUQ0zZ1Z/CFN
         NPPheSGYydZPKT/k0QdXU4FJq87qVBloqwv6g+zJzdsOpy64g6V1HlZIqFHbu5kUo6
         MayyWZ9S797/6gOCwr9bEPdKm5KJEZG/tbH4xglxgNkQtyk2r12nS9dYcTgCRKmoHJ
         /CvzMpSJyTiyHCmEp2VDwtwLtMIjMial4FQA+bZYa9DcemqT0CXTyvjrnGzrs+2T+3
         9+Bg3zKcIhgO0QtCAMyQkyUVGz+4V8M3zxYZCvAmlLvmuz8EbA26S/KcwArdLNVJ2r
         s5tv4IVeWfZ4g==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 06/15] mm/page_alloc: rename page_alloc_init() to page_alloc_init_cpuhp()
Date:   Sun, 19 Mar 2023 23:59:59 +0200
Message-Id: <20230319220008.2138576-7-rppt@kernel.org>
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

The page_alloc_init() name is really misleading because all this
function does is sets up CPU hotplug callbacks for the page allocator.

Rename it to page_alloc_init_cpuhp() so that name will reflect what the
function does.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/gfp.h | 2 +-
 init/main.c         | 2 +-
 mm/page_alloc.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 7c554e4bd49f..ed8cb537c6a7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -319,7 +319,7 @@ extern void page_frag_free(void *addr);
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
-void page_alloc_init(void);
+void page_alloc_init_cpuhp(void);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
diff --git a/init/main.c b/init/main.c
index 4425d1783d5c..b2499bee7a3c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -969,7 +969,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	boot_cpu_hotplug_init();
 
 	build_all_zonelists(NULL);
-	page_alloc_init();
+	page_alloc_init_cpuhp();
 
 	pr_notice("Kernel command line: %s\n", saved_command_line);
 	/* parameters may set static keys */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff6a2fff2880..d1276bfe7a30 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6383,7 +6383,7 @@ static int page_alloc_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-void __init page_alloc_init(void)
+void __init page_alloc_init_cpuhp(void)
 {
 	int ret;
 
-- 
2.35.1

