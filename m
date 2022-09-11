Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867E5B4B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 02:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIKA70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 20:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIKA7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 20:59:25 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFCC46236
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 17:59:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPHfOLp_1662857958;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPHfOLp_1662857958)
          by smtp.aliyun-inc.com;
          Sun, 11 Sep 2022 08:59:19 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH V2] mm/damon: simplify scheme create in damon_lru_sort_apply_parameters
Date:   Sun, 11 Sep 2022 08:59:17 +0800
Message-Id: <20220911005917.835-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In damon_lru_sort_apply_parameters(), we can use damon_set_schemes() to
replace the way of creating the first 'scheme' in original code, this
makes the code look cleaner.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
Changes from v1
(https://lore.kernel.org/linux-mm/20220910165536.99023-1-xhao@linux.alibaba.com/T/)
- Fix complile warning about unused 'next_schemes' variable
---
 mm/damon/lru_sort.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index b8ec52739e0f..1eb824ab8a98 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -340,7 +340,7 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)

 static int damon_lru_sort_apply_parameters(void)
 {
-	struct damos *scheme, *next_scheme;
+	struct damos *scheme;
 	struct damon_addr_range addr_range;
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
@@ -350,17 +350,15 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;

-	/* free previously set schemes */
-	damon_for_each_scheme_safe(scheme, next_scheme, ctx)
-		damon_destroy_scheme(scheme);
-
 	/* aggr_interval / sample_interval is the maximum nr_accesses */
 	hot_thres = aggr_interval / sample_interval * hot_thres_access_freq /
 		1000;
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
 		return -ENOMEM;
-	damon_add_scheme(ctx, scheme);
+	err = damon_set_schemes(ctx, &scheme, 1);
+	if (err)
+		return err;

 	cold_thres = cold_min_age / aggr_interval;
 	scheme = damon_lru_sort_new_cold_scheme(cold_thres);
--
2.31.0
