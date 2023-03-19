Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EEB6C05D2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjCSWAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCSWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDB1514A;
        Sun, 19 Mar 2023 15:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D12611CE;
        Sun, 19 Mar 2023 22:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B8AC4339B;
        Sun, 19 Mar 2023 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263232;
        bh=hdgTCF3AluRT54E9MLIUV0kdVH4EuuQ6uLe4WMnOnfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBpAFCMO2EPuJQ3DceQO11KrNG1Xa7ss1NwTGDl2lsm+DZvOGWjpBOdQuIwm3VlAR
         YiaL0FwisP5hqGIHrOB0A0C58SWIc+Kr9de4Fb2Co9kcLSMuF4+YLkruSuuiF53opk
         QcVgTdrUsMaauwl8da/sCVuB3R+2qsDeSEAjjOJ9poCOOx+3RZJtudqLmOr7jNrtn/
         d2MLLOWir2J8tvaSn6KkJAawHeUVjENMXHRwOT0QTmY8YBGVV5EznK0U84MAzrILLh
         5qR/7Lv83L7RgyzqAdFgqJFQDybFQTrUQ3ysGBg/Mu/UDsJdOJEl4YvmCEn3CKJbgf
         tP8fiOTbLMnLA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/15] mm/page_alloc: add helper for checking if check_pages_enabled
Date:   Sun, 19 Mar 2023 23:59:56 +0200
Message-Id: <20230319220008.2138576-4-rppt@kernel.org>
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

Instead of duplicating long static_branch_enabled(&check_pages_enabled)
wrap it in a helper function is_check_pages_enabled()

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/page_alloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 22e3da842e3f..e52f90d5d6a3 100644
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
@@ -2345,7 +2350,7 @@ static int check_new_page(struct page *page)
 
 static inline bool check_new_pages(struct page *page, unsigned int order)
 {
-	if (static_branch_unlikely(&check_pages_enabled)) {
+	if (is_check_pages_enabled()) {
 		for (int i = 0; i < (1 << order); i++) {
 			struct page *p = page + i;
 
-- 
2.35.1

