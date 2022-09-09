Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C925B40B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiIIUar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiIIU35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:29:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFBF1449D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1E08CE24A2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 20:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369FEC43470;
        Fri,  9 Sep 2022 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755345;
        bh=OVGs4WGaZlHSNw1bV9aTKJG9y36ZzMQPGlZGZcjins0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ip+V2dwR7+a6tDS2JAnQCwO5rJFAyowrX5+FfGIBNIsTYot/Veb/nwDlEqmeNtUQs
         nEMBGWe6pqrJyEb8Hs+MdAFA+I5oFdJNB36NlBpZC0nkTMOd21lG8iO2Ra4ypuPpjQ
         4W5dX/F5GI0AkFryiAkYJKkQO8JIV3lB45w4lT7jL47LAAaPIRzynMz6uwU45Bh+XZ
         E5o5BI4Lyarzt66Xj/yFuiQb9R8RZ3h4J+c8G2gc9WN4gZbF7NICi52SH5OVqMv0in
         TH9MrIoz+J6fNJe93GTJ17U6HxX04QkESr522tdExGQL28caqt3vzzSA3ojYrHEmu/
         K2etw9lz6iwkg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yun Levi <ppbuk5246@gmail.com>
Subject: [PATCH 2/7] mm/damon/core: avoid holes in newly set monitoring target ranges
Date:   Fri,  9 Sep 2022 20:28:56 +0000
Message-Id: <20220909202901.57977-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are two or more non-contiguous regions intersecting with
given new ranges, 'damon_set_regions()' does not fill the holes.  This
commit makes the function to fill the holes with newly created regions.

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Reported-by: Yun Levi <ppbuk5246@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bae41990f422..6f6c9c9aca9d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -168,6 +168,27 @@ static bool damon_intersect(struct damon_region *r,
 	return !(r->ar.end <= re->start || re->end <= r->ar.start);
 }
 
+/*
+ * Fill holes in regions with new regions.
+ */
+static void damon_fill_regions_holes(struct damon_region *first,
+		struct damon_region *last, struct damon_target *t)
+{
+	struct damon_region *r = first;
+
+	damon_for_each_region_from(r, t) {
+		struct damon_region *next, *newr;
+
+		if (r == last)
+			break;
+		next = damon_next_region(r);
+		if (r->ar.end != next->ar.start) {
+			newr = damon_new_region(r->ar.end, next->ar.start);
+			damon_insert_region(newr, r, next, t);
+		}
+	}
+}
+
 /*
  * damon_set_regions() - Set regions of a target for given address ranges.
  * @t:		the given target.
@@ -226,6 +247,9 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			first->ar.start = ALIGN_DOWN(range->start,
 					DAMON_MIN_REGION);
 			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+
+			/* fill possible holes in the range */
+			damon_fill_regions_holes(first, last, t);
 		}
 	}
 	return 0;
-- 
2.25.1

