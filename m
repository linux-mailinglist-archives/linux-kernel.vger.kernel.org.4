Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB496C37B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCURGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCURFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:05:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8025E34;
        Tue, 21 Mar 2023 10:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BFDDB818B9;
        Tue, 21 Mar 2023 17:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86B5C4339C;
        Tue, 21 Mar 2023 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418335;
        bh=I9y2VS2sujmV0QDCgNwqn2cmquxP68oIIJXpFeZ8zWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvU/i21VgZbcmY0RKxM7OfYu+1hxrZakEd0qKlbAVLq51IJjKj6CKIcCK9ES+4LDa
         r0GXrHFiB4bewcM9qeWDh0R4qbZZpydLGatuQAdqquua5BUoy3cgjwnftNe2vICXgk
         TsJya2xDyox9It3dWIYTidriR688fhCIfmDNluEO305v19/xELXcjykEw3+9opOrh6
         j4JkM1QSbBxxf6Gi4okJjw4G5rC/LNmMKcrQ21dwK7mzp5N3rfjBiQ2ovPN8tR2szf
         v+9rKcE3YA7RQs/YMnkyaHdIu7kUj5Hu0Zm+3dYlQEJ8RZLovqVXqCPD7NH5ImyjDd
         ua/+qlh76Uwxw==
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
Subject: [PATCH v2 02/14] mm/page_alloc: add helper for checking if check_pages_enabled
Date:   Tue, 21 Mar 2023 19:05:01 +0200
Message-Id: <20230321170513.2401534-3-rppt@kernel.org>
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

Instead of duplicating long static_branch_enabled(&check_pages_enabled)
wrap it in a helper function is_check_pages_enabled()

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 87d760236dba..e1149d54d738 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -245,6 +245,11 @@ EXPORT_SYMBOL(init_on_free);
 /* perform sanity checks on struct pages being allocated or freed */
 static DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
+static inline bool is_check_pages_enabled(void)
+{
+	return static_branch_unlikely(&check_pages_enabled);
+}
+
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
@@ -1443,7 +1448,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
-			if (static_branch_unlikely(&check_pages_enabled)) {
+			if (is_check_pages_enabled()) {
 				if (unlikely(free_page_is_bad(page + i))) {
 					bad++;
 					continue;
@@ -1456,7 +1461,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		page->mapping = NULL;
 	if (memcg_kmem_online() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
-	if (static_branch_unlikely(&check_pages_enabled)) {
+	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
 		if (bad)
@@ -2366,7 +2371,7 @@ static int check_new_page(struct page *page)
 
 static inline bool check_new_pages(struct page *page, unsigned int order)
 {
-	if (static_branch_unlikely(&check_pages_enabled)) {
+	if (is_check_pages_enabled()) {
 		for (int i = 0; i < (1 << order); i++) {
 			struct page *p = page + i;
 
-- 
2.35.1

