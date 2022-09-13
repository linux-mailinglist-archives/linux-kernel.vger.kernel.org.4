Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1B5B797D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiIMS1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiIMS0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6545FAE7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB756154D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797F2C43144;
        Tue, 13 Sep 2022 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091099;
        bh=weWy/2YvUWIofhX6Yg4PxkLbauvFc1P8+Pog3c5HCQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNWe89E2W4HG4Qc4c5ym3tC6m8DqT09MtflLX5NQn2wKg99VI2QxGhRhr1dGRcNtB
         yCkIWEvTXjvuIEgtgIeuN5D+7ejYSNd1T1nM9ISx0Y7Mf8BpzMtWFJzxUHgotwZ1GF
         eC53jZPOZvrnVL6UE10nsoX8Vm/R6zMn435XDwdHYO/WCljc2omiMuCADFWLZKnTCp
         oM5R6qmKYlTOZ+4h63qyc2v4afrw5GYHOA4urdD28HAOZisRSPjJ31oosApurqCj9F
         v7h6fVDLGvANvAowyLhgNI/h1MZG9dahfv+8+2eTQ06+I2V2GsOH73fxM5BrdR2KFM
         opUKzr6qZHerA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/22] mm/damon/reclaim: use 'struct damon_attrs' for storing parameters for it
Date:   Tue, 13 Sep 2022 17:44:34 +0000
Message-Id: <20220913174449.50645-8-sj@kernel.org>
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

DAMON_RECLAIM receives monitoring attributes by parameters one by one to
separate variables, and then combine those into 'struct damon_attrs'.
This commit makes the module directly stores the parameter values to a
static 'struct damon_attrs' variable and use it to simplify the code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index bc841efbab45..d35a00d8dde2 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -129,14 +129,22 @@ module_param(wmarks_mid, ulong, 0600);
 static unsigned long wmarks_low __read_mostly = 200;
 module_param(wmarks_low, ulong, 0600);
 
+static struct damon_attrs damon_reclaim_mon_attrs = {
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
  * The sampling interval of DAMON for the cold memory monitoring.  Please refer
  * to the DAMON documentation for more detail.  5 ms by default.
  */
-static unsigned long sample_interval __read_mostly = 5000;
-module_param(sample_interval, ulong, 0600);
+module_param_named(sample_interval, damon_reclaim_mon_attrs.sample_interval,
+		ulong, 0600);
 
 /*
  * Aggregation interval for the monitoring in microseconds.
@@ -144,8 +152,8 @@ module_param(sample_interval, ulong, 0600);
  * The aggregation interval of DAMON for the cold memory monitoring.  Please
  * refer to the DAMON documentation for more detail.  100 ms by default.
  */
-static unsigned long aggr_interval __read_mostly = 100000;
-module_param(aggr_interval, ulong, 0600);
+module_param_named(aggr_interval, damon_reclaim_mon_attrs.aggr_interval, ulong,
+		0600);
 
 /*
  * Minimum number of monitoring regions.
@@ -155,8 +163,8 @@ module_param(aggr_interval, ulong, 0600);
  * But, setting this too high could result in increased monitoring overhead.
  * Please refer to the DAMON documentation for more detail.  10 by default.
  */
-static unsigned long min_nr_regions __read_mostly = 10;
-module_param(min_nr_regions, ulong, 0600);
+module_param_named(min_nr_regions, damon_reclaim_mon_attrs.min_nr_regions,
+		ulong, 0600);
 
 /*
  * Maximum number of monitoring regions.
@@ -166,8 +174,8 @@ module_param(min_nr_regions, ulong, 0600);
  * However, setting this too low could result in bad monitoring quality.
  * Please refer to the DAMON documentation for more detail.  1000 by default.
  */
-static unsigned long max_nr_regions __read_mostly = 1000;
-module_param(max_nr_regions, ulong, 0600);
+module_param_named(max_nr_regions, damon_reclaim_mon_attrs.max_nr_regions,
+		ulong, 0600);
 
 /*
  * Start of the target memory region in physical address.
@@ -239,7 +247,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 		.min_nr_accesses = 0,
 		.max_nr_accesses = 0,
 		/* for min_age or more micro-seconds */
-		.min_age_region = min_age / aggr_interval,
+		.min_age_region = min_age /
+			damon_reclaim_mon_attrs.aggr_interval,
 		.max_age_region = UINT_MAX,
 	};
 	struct damos_watermarks wmarks = {
@@ -275,18 +284,11 @@ static struct damos *damon_reclaim_new_scheme(void)
 
 static int damon_reclaim_apply_parameters(void)
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
 	int err = 0;
 
-	err = damon_set_attrs(ctx, &attrs);
+	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		return err;
 
-- 
2.25.1

