Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02565DC9E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbjADTSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjADTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:18:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE821C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:18:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12904B8189F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4286CC433D2;
        Wed,  4 Jan 2023 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672859897;
        bh=/a1ST1ZnmxMiB7Kfy4mw19tmCPrOMY5YoQtFMqkWXjk=;
        h=From:To:Cc:Subject:Date:From;
        b=mhOIg47ecYOAzFbSXOuJEOP3I+JHngjYgRJfee8h8Rbh20Tn5/I5uyQHXjY4obkUF
         bKl0v7B9B91OveXVgKQobr/mA5smTXvsFznZQ7jYrAWemiRvh1xeLPpbvjUUbje1vh
         18BMDHbhoWdvRGS5LGAlvC62A+5/hu/rnb7+HHaeO4qVup472WEcOgLvfo6B2HD9O2
         s8LFVj+4++NbLJ3ukVihw8q+uLpxxXBs8WHAZFdiidNAg7ChcFAB8lXQwYNzb77w8b
         JIbGnOwQ/Neja0+5k6ACW7/4NAv3qSqMQIx+v1lRdDoaO0uPHxu+hIZIw4JOGra4bU
         IYdPwOn2KkZtQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: invert logic for early page initialisation checks
Date:   Wed,  4 Jan 2023 21:18:05 +0200
Message-Id: <20230104191805.2535864-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Rename early_page_uninitialised() to early_page_initialised() and invert
its logic to make the code more readable.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..a881f2d42b2c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -443,15 +443,15 @@ static inline bool deferred_pages_enabled(void)
 	return static_branch_unlikely(&deferred_pages);
 }
 
-/* Returns true if the struct page for the pfn is uninitialised */
-static inline bool __meminit early_page_uninitialised(unsigned long pfn)
+/* Returns true if the struct page for the pfn is initialised */
+static inline bool __meminit early_page_initialised(unsigned long pfn)
 {
 	int nid = early_pfn_to_nid(pfn);
 
 	if (node_online(nid) && pfn >= NODE_DATA(nid)->first_deferred_pfn)
-		return true;
+		return false;
 
-	return false;
+	return true;
 }
 
 /*
@@ -498,9 +498,9 @@ static inline bool deferred_pages_enabled(void)
 	return false;
 }
 
-static inline bool early_page_uninitialised(unsigned long pfn)
+static inline bool early_page_initialised(unsigned long pfn)
 {
-	return false;
+	return true;
 }
 
 static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
@@ -1641,7 +1641,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	pg_data_t *pgdat;
 	int nid, zid;
 
-	if (!early_page_uninitialised(pfn))
+	if (early_page_initialised(pfn))
 		return;
 
 	nid = early_pfn_to_nid(pfn);
@@ -1804,7 +1804,7 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
-	if (early_page_uninitialised(pfn))
+	if (!early_page_initialised(pfn))
 		return;
 	if (!kmsan_memblock_free_pages(page, order)) {
 		/* KMSAN will take care of these pages. */
-- 
2.35.1

