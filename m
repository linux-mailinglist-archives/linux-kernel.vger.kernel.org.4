Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12869888B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBOXDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBOXDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:03:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D04EEA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:03:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8576361DF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7268CC4339B;
        Wed, 15 Feb 2023 23:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676502190;
        bh=RmZP8LXAzXmudAg+WjCvMFE/Rw2yf7ik6Dcir0mGUhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1qOOoejtZrXM/pP10mBRqvPAG1L4fZ0yzMF0eEpRzrsxlY7q5mH6PtWJfnS3+G/h
         Z+P5+9uuX1bdPD2EziZDwA5lavk/1+NcoXtLG8uTB2v/5ETkoUDOd0wjznXEsDfPxQ
         o5la/zXRqePYzas3GMlRCESF02FqLzM6ep6oZvumR561NMLJ8SQC7mrYLjbHsymXqX
         pLBNhqMQIG3py5JHkqFub5+4UOdaCfEpZfM2VM3p+fHtSaS4Wbc0xp9OBT/qQd6/Fp
         f2hue51lpamV0wFsycRxltVtyhUypmNv1oh2+KP1HGZT9QJEMzbMRokgtseDw+K2Bs
         j3l/out0PY3yA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/memory_hotplug: cleanup 'ret' variable usage in do_migrate_range()
Date:   Wed, 15 Feb 2023 23:03:00 +0000
Message-Id: <20230215230300.61125-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215230300.61125-1-sj@kernel.org>
References: <20230215230300.61125-1-sj@kernel.org>
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

Because do_migrate_range() is returning nothing, some 'ret' variable
usages are unnecessary.  Remove unnecessary usage and reduce its scope.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/memory_hotplug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6c615ba1a5c7..6df3072d11df 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1624,7 +1624,6 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
 	struct page *page, *head;
-	int ret = 0;
 	LIST_HEAD(source);
 	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
@@ -1678,7 +1677,6 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 						    page_is_file_lru(page));
 
 		} else {
-			ret = -EBUSY;
 			if (__ratelimit(&migrate_rs)) {
 				pr_warn("failed to isolate pfn %lx\n", pfn);
 				dump_page(page, "isolation failed");
@@ -1692,6 +1690,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			.nmask = &nmask,
 			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 		};
+		int ret;
 
 		/*
 		 * We have checked that migration range is on a single zone so
-- 
2.25.1

