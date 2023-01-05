Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8581C65E6D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjAEI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjAEI0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:26:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BC5D4C720
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:25:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 747A31063;
        Thu,  5 Jan 2023 00:25:57 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFD873F71A;
        Thu,  5 Jan 2023 00:25:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, mgorman@suse.de,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Repalce with deferred_pages_enabled() wherever applicable
Date:   Thu,  5 Jan 2023 13:55:06 +0530
Message-Id: <20230105082506.241529-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of directly accessing static deferred_pages, replace such instances
with the helper deferred_pages_enabled(). No functional change is intended.

Cc; Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.2-rc2.

 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..232d0323047b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4244,7 +4244,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * Watermark failed for this zone, but see if we can
 			 * grow this zone if it contains deferred pages.
 			 */
-			if (static_branch_unlikely(&deferred_pages)) {
+			if (deferred_pages_enabled()) {
 				if (_deferred_grow_zone(zone, order))
 					goto try_this_zone;
 			}
@@ -4293,7 +4293,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		} else {
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
-			if (static_branch_unlikely(&deferred_pages)) {
+			if (deferred_pages_enabled()) {
 				if (_deferred_grow_zone(zone, order))
 					goto try_this_zone;
 			}
-- 
2.25.1

