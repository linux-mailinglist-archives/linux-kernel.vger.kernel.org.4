Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8B6970C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBNWcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBNWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:32:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC72ED67
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:32:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA7E261947
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED34C433D2;
        Tue, 14 Feb 2023 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676413963;
        bh=uCymYJjsvlSAxM5NzeVGbDlkk/dWJpRCAk9l/0RStWA=;
        h=From:To:Cc:Subject:Date:From;
        b=SkpDRj6GA4MjWpC9ZEdydWBG+6rhmVnxHG+cMRQ1D99RJJjTo23AtnBINs3gylKva
         3NA0UCoHrWsKQLCOGD8joUhDwU9cBeiIzu4Pu1Km6XZLkLVUuXvvkGktiZ5N7kJU6R
         rDPqpJPsOpeyPwM4UKW4UQHsrJLHi3wRdEVJildlep5aIwP6y4RUgEsTlgDS4oGPmg
         L50nvmNyY7GN3vSNklsA1zaoOSxivjp+WXoP7fdug9WWL5zUknog9rv0I7NWLb3Inm
         HjoYn3H1+UKle3ip+Z12jXMjkesM1XMa/JTRAWsqFTGJnnXChKfOPcaYUNKUf4pOeI
         2OafpudXJUC1g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/memory_hotplug: return zero from do_migrate_range() for only success
Date:   Tue, 14 Feb 2023 22:32:36 +0000
Message-Id: <20230214223236.58430-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

do_migrate_range() returns migrate_pages() return value, which zero
means perfect success, in usual cases.  If all pages are failed to be
isolated, however, it returns isolate_{lru,movalbe}_page() return
values, or zero if all pfn were invalid, were hugetlb or hwpoisoned.  So
do_migrate_range() returning zero means either perfect success, or
special cases of isolation total failure.

Actually, the return value is not checked by any caller, so it might be
better to simply make it a void function.  However, there is a TODO for
checking the return value.

Make it easier to understand what it means.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/memory_hotplug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a1e8c3e9ab08..db2c02d502a2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1620,6 +1620,12 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	return 0;
 }
 
+/*
+ * migrate pages in the given pfn range.
+ *
+ * Returns the number of {normal folio, large folio, hugetlb} that were not
+ * migrated, or an error code.
+ */
 static int
 do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
@@ -1685,6 +1691,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		}
 		put_page(page);
 	}
+	ret = -ENOENT;
 	if (!list_empty(&source)) {
 		nodemask_t nmask = node_states[N_MEMORY];
 		struct migration_target_control mtc = {
-- 
2.25.1

