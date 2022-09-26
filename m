Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EFE5E9A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiIZHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiIZHLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:11:32 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C810F8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:11:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQhSYSJ_1664176262;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQhSYSJ_1664176262)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 15:11:04 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH v1 1/2] mm/damon: rename sz_damon_region to damon_region_size
Date:   Mon, 26 Sep 2022 15:10:59 +0800
Message-Id: <20220926071100.76379-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here, i rename sz_damon_region() to damon_region_size(), and move it to
"include/linux/damon.h", because in many places, we can to use this func.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h | 1 +
 mm/damon/core.c       | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ed5470f50bab..21f4bfd0f41f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -524,6 +524,7 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
+unsigned long damon_region_size(struct damon_region *r);

 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action, struct damos_quota *quota,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4de8c7c52979..74ab45b2c2f1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -864,7 +864,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }

-static inline unsigned long sz_damon_region(struct damon_region *r)
+unsigned long damon_region_size(struct damon_region *r)
 {
 	return r->ar.end - r->ar.start;
 }
@@ -875,7 +875,7 @@ static inline unsigned long sz_damon_region(struct damon_region *r)
 static void damon_merge_two_regions(struct damon_target *t,
 		struct damon_region *l, struct damon_region *r)
 {
-	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
+	unsigned long sz_l = damon_region_size(l), sz_r = damon_region_size(r);

 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
@@ -904,7 +904,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,

 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
-		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
+		    damon_region_size(prev) + damon_region_size(r) <= sz_limit)
 			damon_merge_two_regions(t, prev, r);
 		else
 			prev = r;
--
2.31.0
