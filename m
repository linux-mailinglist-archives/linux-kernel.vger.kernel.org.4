Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4E6C37BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjCURGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCURGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9F41C597;
        Tue, 21 Mar 2023 10:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A434D61D40;
        Tue, 21 Mar 2023 17:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEA9C4339E;
        Tue, 21 Mar 2023 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418348;
        bh=yFWOiCGTMb0kxnXPUeW5UI17+2jMfP/fnjpb1q+J7gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9Gkip7tvni7Mnk6n8TnDZm1hR1VR1sJVwbjOXRQMBdSY6XQ/jhJ8WEU/oTZwSlE1
         GP/lFo6JYzaIYubsVYtTlwq8hx6XR2v8y1h712a2FPq/Pa6aFUL5xK/t99zP5SJIuD
         sZvf8FuC7AqYl3VSwrRJSJYzLka8040ITH3d7XbHNuTpDpF3wPabprMDq7Ru72qm6x
         K62Om+CkOZFw3ZN4t3JSw3GkOICBNja2MmgJ33e9HWVB2x0mXlLMBEa7RGxcSegz3g
         NEoSCfxTQ69n+/jiDvPFYL2WiWcO7I0PhFAnazvV+AZWMATjfg2SvTCTTdOdaWWfJD
         7j6iOQu0oR4Pw==
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
Subject: [PATCH v2 05/14] mm/page_alloc: rename page_alloc_init() to page_alloc_init_cpuhp()
Date:   Tue, 21 Mar 2023 19:05:04 +0200
Message-Id: <20230321170513.2401534-6-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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

