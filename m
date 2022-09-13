Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A705B7987
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiIMS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiIMS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3525FF77
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FED161551
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165DDC433B5;
        Tue, 13 Sep 2022 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091100;
        bh=t9hexQZJ8425+LB2Nnk1GDKOCK+nsv8kErzuC6jdjaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzARBjc+b2EGph+GmNC6Uuaf+rE6285m8cIpolJIwlcgLD4RYkhT8rjd/UNjWXNyX
         kL6NPs3+Mvkqla410Y6Wg9HpYE9Wz5TsIrtegel/6wmVc9yhuNSprDlUazn97gUQFQ
         5+QNIpfdHLk8vCrrXanRAU9ng/6v36aJhiYXfNdmpWEtg/kwCBZ+5iNvL/mWFDD/9m
         7QjA+mT+1iRHREfBbXvWwWxBlYQZ5TCgl62KKns7DjJkK/iGonvXbyEzfnq7EyO5ho
         Dnvy+93O6xEpLNnEasEnxiX1uuo0tpqchbKEd+5eSN2nOsX+wOsH2SKE+Yg7kgx+t8
         9Hu065mtEuOPg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/22] mm/damon/lru_sort: use 'struct damon_attrs' for storing parameters for it
Date:   Tue, 13 Sep 2022 17:44:35 +0000
Message-Id: <20220913174449.50645-9-sj@kernel.org>
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

DAMON_LRU_SORT receives monitoring attributes by parameters one by one
to separate variables, and then combines those into 'struct
damon_attrs'.  This commit makes the module directly stores the
parameter values to a static 'struct damon_attrs' variable and use it to
simplify the code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 6d5f83965276..ade985b83652 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -127,14 +127,22 @@ module_param(wmarks_mid, ulong, 0600);
 static unsigned long wmarks_low __read_mostly = 50;
 module_param(wmarks_low, ulong, 0600);
 
+static struct damon_attrs damon_lru_sort_mon_attrs = {
+	.sample_interval = 5000,
+	.aggr_interval = 100000,
+	.ops_update_interval = 0,
+	.min_nr_regions = 10,
+	.max_nr_regions = 1000,
+};
+
 /*
  * Sampling interval for the monitoring in microseconds.
  *
  * The sampling interval of DAMON for the hot/cold memory monitoring.  Please
  * refer to the DAMON documentation for more detail.  5 ms by default.
  */
-static unsigned long sample_interval __read_mostly = 5000;
-module_param(sample_interval, ulong, 0600);
+module_param_named(sample_interval, damon_lru_sort_mon_attrs.sample_interval,
+		ulong, 0600);
 
 /*
  * Aggregation interval for the monitoring in microseconds.
@@ -142,8 +150,8 @@ module_param(sample_interval, ulong, 0600);
  * The aggregation interval of DAMON for the hot/cold memory monitoring.
  * Please refer to the DAMON documentation for more detail.  100 ms by default.
  */
-static unsigned long aggr_interval __read_mostly = 100000;
-module_param(aggr_interval, ulong, 0600);
+module_param_named(aggr_interval, damon_lru_sort_mon_attrs.aggr_interval, ulong,
+		0600);
 
 /*
  * Minimum number of monitoring regions.
@@ -153,8 +161,8 @@ module_param(aggr_interval, ulong, 0600);
  * But, setting this too high could result in increased monitoring overhead.
  * Please refer to the DAMON documentation for more detail.  10 by default.
  */
-static unsigned long min_nr_regions __read_mostly = 10;
-module_param(min_nr_regions, ulong, 0600);
+module_param_named(min_nr_regions, damon_lru_sort_mon_attrs.min_nr_regions,
+		ulong, 0600);
 
 /*
  * Maximum number of monitoring regions.
@@ -164,8 +172,8 @@ module_param(min_nr_regions, ulong, 0600);
  * However, setting this too low could result in bad monitoring quality.
  * Please refer to the DAMON documentation for more detail.  1000 by default.
  */
-static unsigned long max_nr_regions __read_mostly = 1000;
-module_param(max_nr_regions, ulong, 0600);
+module_param_named(max_nr_regions, damon_lru_sort_mon_attrs.max_nr_regions,
+		ulong, 0600);
 
 /*
  * Start of the target memory region in physical address.
@@ -350,25 +358,19 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 
 static int damon_lru_sort_apply_parameters(void)
 {
-	struct damon_attrs attrs = {
-		.sample_interval = sample_interval,
-		.aggr_interval = aggr_interval,
-		.ops_update_interval = 0,
-		.min_nr_regions = min_nr_regions,
-		.max_nr_regions = max_nr_regions,
-	};
 	struct damos *scheme;
 	struct damon_addr_range addr_range;
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
 
-	err = damon_set_attrs(ctx, &attrs);
+	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		return err;
 
 	/* aggr_interval / sample_interval is the maximum nr_accesses */
-	hot_thres = aggr_interval / sample_interval * hot_thres_access_freq /
-		1000;
+	hot_thres = damon_lru_sort_mon_attrs.aggr_interval /
+		damon_lru_sort_mon_attrs.sample_interval *
+		hot_thres_access_freq / 1000;
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
 		return -ENOMEM;
@@ -376,7 +378,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
-	cold_thres = cold_min_age / aggr_interval;
+	cold_thres = cold_min_age / damon_lru_sort_mon_attrs.aggr_interval;
 	scheme = damon_lru_sort_new_cold_scheme(cold_thres);
 	if (!scheme)
 		return -ENOMEM;
-- 
2.25.1

