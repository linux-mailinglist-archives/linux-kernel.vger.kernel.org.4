Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EA5B797B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiIMS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiIMS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B42F5C363
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9702DB80CBC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C2C433D7;
        Tue, 13 Sep 2022 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091097;
        bh=0FJOrqHiBH1OMZ45Xdi5Z4U0goCpXjUFgshxwmAlQlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=es99vqn1ffMbBBFLbtJGVKcjrXyHgR79vSQyF0z+ScdGpaJVr4lW+yHoZQY+cSeoA
         sDnWKHHLwouvB+Zqwonl+asV8uuQ5yR3RntZz1IOzHkyWWrBqHL+dCMk1djGjKD2w/
         cadkRl8b9QdRMDShd4e8ji6ZM44RrDr5DaZoBADBZCiKrMoShbygsJBMtDTVNIH9fJ
         bZLFnSUNJJ1OTq/ZZO/TQSFP2yIjj3mZpxhQA4R/6qcuZYoCskfcc+6uDPI8/TywE6
         Lw9m7KejLWOzndrIP8VeFBEQAs1J/S2f7h+Q5xNCBA33BVfctyyg2DNBGdTuErwq+U
         uoTiG3DLxRwoA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/22] mm/damon/core: copy struct-to-struct instead of field-to-field in damon_new_scheme()
Date:   Tue, 13 Sep 2022 17:44:30 +0000
Message-Id: <20220913174449.50645-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
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

The function for new 'struct damos' creation, 'damon_new_scheme()',
copies each field of the struct one by one, though it could simply
copied via struct to struct.  This commit replaces the unnecessarily
verbose field-to-field copies with struct-to-struct copies to make code
simple and short.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c21f5fe5928a..27e0c312f7a5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -276,22 +276,13 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme = kmalloc(sizeof(*scheme), GFP_KERNEL);
 	if (!scheme)
 		return NULL;
-	scheme->pattern.min_sz_region = pattern->min_sz_region;
-	scheme->pattern.max_sz_region = pattern->max_sz_region;
-	scheme->pattern.min_nr_accesses = pattern->min_nr_accesses;
-	scheme->pattern.max_nr_accesses = pattern->max_nr_accesses;
-	scheme->pattern.min_age_region = pattern->min_age_region;
-	scheme->pattern.max_age_region = pattern->max_age_region;
+	scheme->pattern = *pattern;
 	scheme->action = action;
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
-	scheme->quota.ms = quota->ms;
-	scheme->quota.sz = quota->sz;
-	scheme->quota.reset_interval = quota->reset_interval;
-	scheme->quota.weight_sz = quota->weight_sz;
-	scheme->quota.weight_nr_accesses = quota->weight_nr_accesses;
-	scheme->quota.weight_age = quota->weight_age;
+	scheme->quota = *quota;
+	/* caller might not zero-initialized the private fileds */
 	scheme->quota.total_charged_sz = 0;
 	scheme->quota.total_charged_ns = 0;
 	scheme->quota.esz = 0;
@@ -300,11 +291,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->quota.charge_target_from = NULL;
 	scheme->quota.charge_addr_from = 0;
 
-	scheme->wmarks.metric = wmarks->metric;
-	scheme->wmarks.interval = wmarks->interval;
-	scheme->wmarks.high = wmarks->high;
-	scheme->wmarks.mid = wmarks->mid;
-	scheme->wmarks.low = wmarks->low;
+	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
 	return scheme;
-- 
2.25.1

