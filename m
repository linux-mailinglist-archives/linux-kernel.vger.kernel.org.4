Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC59D67A40E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjAXUkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjAXUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:40:14 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1994B1AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:40:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674592811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1AR/rv3Oa6O7jvIvFBjmYxJ41m4mSBsPB4PLJyrZR80=;
        b=LRQ50Wlwhf1P8ib6bD5y2GyXEpsCFdUF085x/dfwV/VvezEeAHY1OezRZK/hl25p+jY+mi
        Tz8huiM9NBELezIT+858ud6mKtFPdqQ6cK4fT5RFKBZUFO4UUWv1VJmYvADVVCuCJ/1Jn/
        635A+wFIPnEfuPGzLQjo/LPVYOalXt0=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: [PATCH v2 mm] kasan: reset page tags properly with sampling
Date:   Tue, 24 Jan 2023 21:40:09 +0100
Message-Id: <5dbd866714b4839069e2d8469ac45b60953db290.1674592780.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

The implementation of page_alloc poisoning sampling assumed that
tag_clear_highpage resets page tags for __GFP_ZEROTAGS allocations.
However, this is no longer the case since commit 70c248aca9e7
("mm: kasan: Skip unpoisoning of user pages").

This leads to kernel crashes when MTE-enabled userspace mappings are
used with Hardware Tag-Based KASAN enabled.

Reset page tags for __GFP_ZEROTAGS allocations in post_alloc_hook().

Also clarify and fix related comments.

Reported-by: Peter Collingbourne <pcc@google.com>
Tested-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5514d84cc712..b917aebfd3d0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2471,7 +2471,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
 	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
-	bool reset_tags = !zero_tags;
+	bool reset_tags = true;
 	int i;
 
 	set_page_private(page, 0);
@@ -2498,7 +2498,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 * (which happens only when memory should be initialized as well).
 	 */
 	if (zero_tags) {
-		/* Initialize both memory and tags. */
+		/* Initialize both memory and memory tags. */
 		for (i = 0; i != 1 << order; ++i)
 			tag_clear_highpage(page + i);
 
@@ -2516,14 +2516,15 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		} else {
 			/*
 			 * KASAN decided to exclude this allocation from being
-			 * poisoned due to sampling. Skip poisoning as well.
+			 * (un)poisoned due to sampling. Make KASAN skip
+			 * poisoning when the allocation is freed.
 			 */
 			SetPageSkipKASanPoison(page);
 		}
 	}
 	/*
-	 * If memory tags have not been set, reset the page tags to ensure
-	 * page_address() dereferencing does not fault.
+	 * If memory tags have not been set by KASAN, reset the page tags to
+	 * ensure page_address() dereferencing does not fault.
 	 */
 	if (reset_tags) {
 		for (i = 0; i != 1 << order; ++i)
-- 
2.25.1

