Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4296D7F76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbjDEO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbjDEO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:29:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A311128;
        Wed,  5 Apr 2023 07:28:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B4E220698;
        Wed,  5 Apr 2023 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680704922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YqF8idOT1k8dhFhoAQM1OZCaPGH+LbOP3hVosygnnAQ=;
        b=WVaVx3f8jfJQKBrfm1KKPpu1TcMgehaxgeLwwQ9QdGOHYxkx8YPpK+YnwBcH/TuDfUtltp
        eGYu5tbmV+Jy0lWoWendCQ+RFdn948Skgg9VRW3qrz2VzOewuUgNOEED7NoEOReVQlebjg
        aQSL802rqCiFXe2+0TVtvusx2+oMtNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680704922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YqF8idOT1k8dhFhoAQM1OZCaPGH+LbOP3hVosygnnAQ=;
        b=k7dqNQ3FQNhza/bL6k9yridUZP846ungl/5G4HuGIotJRUoBC4mwuwU/xNE9aquALOp7hH
        jMzFA8BhZsNC/tAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7850B13A31;
        Wed,  5 Apr 2023 14:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ocHaHJqFLWT3CwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 05 Apr 2023 14:28:42 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Mel Gorman <mgorman@techsingularity.net>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm, page_alloc: use check_pages_enabled static key to check tail pages
Date:   Wed,  5 Apr 2023 16:28:40 +0200
Message-Id: <20230405142840.11068-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 700d2e9a36b9 ("mm, page_alloc: reduce page alloc/free sanity
checks") has introduced a new static key check_pages_enabled to control
when struct pages are sanity checked during allocation and freeing. Mel
Gorman suggested that free_tail_pages_check() could use this static key
as well, instead of relying on CONFIG_DEBUG_VM. That makes sense, so do
that. Also rename the function to free_tail_page_prepare() because it
works on a single tail page and has a struct page preparation component
as well as the optional checking component.
Also remove some unnecessary unlikely() within static_branch_unlikely()
statements that Mel pointed out for commit 700d2e9a36b9.

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/hugetlb_vmemmap.c |  2 +-
 mm/page_alloc.c      | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a15cc56cf70a..656b00d1a2fb 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -264,7 +264,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
  * How many struct page structs need to be reset. When we reuse the head
  * struct page, the special metadata (e.g. page->flags or page->mapping)
  * cannot copy to the tail struct page structs. The invalid value will be
- * checked in the free_tail_pages_check(). In order to avoid the message
+ * checked in the free_tail_page_prepare(). In order to avoid the message
  * of "corrupted mapping in tail page". We need to reset at least 3 (one
  * head struct page struct and two tail struct page structs) struct page
  * structs.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a109444e9f44..7df5bf07e013 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1308,7 +1308,7 @@ static inline bool free_page_is_bad(struct page *page)
 	return true;
 }
 
-static int free_tail_pages_check(struct page *head_page, struct page *page)
+static int free_tail_page_prepare(struct page *head_page, struct page *page)
 {
 	struct folio *folio = (struct folio *)head_page;
 	int ret = 1;
@@ -1319,7 +1319,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 	 */
 	BUILD_BUG_ON((unsigned long)LIST_POISON1 & 1);
 
-	if (!IS_ENABLED(CONFIG_DEBUG_VM)) {
+	if (!static_branch_unlikely(&check_pages_enabled)) {
 		ret = 0;
 		goto out;
 	}
@@ -1447,9 +1447,9 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			ClearPageHasHWPoisoned(page);
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
-				bad += free_tail_pages_check(page, page + i);
+				bad += free_tail_page_prepare(page, page + i);
 			if (static_branch_unlikely(&check_pages_enabled)) {
-				if (unlikely(free_page_is_bad(page + i))) {
+				if (free_page_is_bad(page + i)) {
 					bad++;
 					continue;
 				}
@@ -2375,7 +2375,7 @@ static inline bool check_new_pages(struct page *page, unsigned int order)
 		for (int i = 0; i < (1 << order); i++) {
 			struct page *p = page + i;
 
-			if (unlikely(check_new_page(p)))
+			if (check_new_page(p))
 				return true;
 		}
 	}
-- 
2.40.0

