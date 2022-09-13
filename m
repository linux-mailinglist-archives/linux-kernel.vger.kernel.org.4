Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DCF5B796F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiIMS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiIMS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A49659C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD0A161510
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B54C433B5;
        Tue, 13 Sep 2022 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091102;
        bh=tFHqJ7jOLkswItslmys2QZPPIVwL8A4ty4xh6NVyqHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/pdAxwMLzIzYIksGQm4SyVLptPt/nnH0sfzxQE0+Ffb/7fpqjSXYyhwhbH+4gs7t
         8clwtJj+BeQ4Yb2yUI/L1xRJDF8ZxVo3dTgElUIoI5bnLu3gk41K2K2yOfqbn83xAD
         DWlQWRGkQrjL/4Q8IX8kIlf5T79Tk85FnP1Ya0TD8F/LAzEwZXwUjaObqLX/TZNfqo
         vu6iHJ93TI2ff5psq0lb3AiDe0+iNQ/GKgp4pGEvHURGqMewVSlRFWGmdosCsGJJcs
         +B+b0niFN7O3V92JW9XJRG6rxCyDzfnO0pv+8RDIGjwNafaw68EhVrhr3UvkGn80Hd
         KDizRAi/BxTJw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/22] mm/damon/reclaim: use monitoring attributes parameters generator macro
Date:   Tue, 13 Sep 2022 17:44:38 +0000
Message-Id: <20220913174449.50645-12-sj@kernel.org>
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

This commit makes DAMON_RECLAIM to generate the module parameters for
DAMON monitoring attributes using the generator macro to simplify the
code and reduce duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 47 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 42 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index d35a00d8dde2..48326bef20f5 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -13,6 +13,8 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 
+#include "modules-common.h"
+
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
@@ -130,52 +132,13 @@ static unsigned long wmarks_low __read_mostly = 200;
 module_param(wmarks_low, ulong, 0600);
 
 static struct damon_attrs damon_reclaim_mon_attrs = {
-	.sample_interval = 5000,
-	.aggr_interval = 100000,
+	.sample_interval = 5000,	/* 5 ms */
+	.aggr_interval = 100000,	/* 100 ms */
 	.ops_update_interval = 0,
 	.min_nr_regions = 10,
 	.max_nr_regions = 1000,
 };
-
-/*
- * Sampling interval for the monitoring in microseconds.
- *
- * The sampling interval of DAMON for the cold memory monitoring.  Please refer
- * to the DAMON documentation for more detail.  5 ms by default.
- */
-module_param_named(sample_interval, damon_reclaim_mon_attrs.sample_interval,
-		ulong, 0600);
-
-/*
- * Aggregation interval for the monitoring in microseconds.
- *
- * The aggregation interval of DAMON for the cold memory monitoring.  Please
- * refer to the DAMON documentation for more detail.  100 ms by default.
- */
-module_param_named(aggr_interval, damon_reclaim_mon_attrs.aggr_interval, ulong,
-		0600);
-
-/*
- * Minimum number of monitoring regions.
- *
- * The minimal number of monitoring regions of DAMON for the cold memory
- * monitoring.  This can be used to set lower-bound of the monitoring quality.
- * But, setting this too high could result in increased monitoring overhead.
- * Please refer to the DAMON documentation for more detail.  10 by default.
- */
-module_param_named(min_nr_regions, damon_reclaim_mon_attrs.min_nr_regions,
-		ulong, 0600);
-
-/*
- * Maximum number of monitoring regions.
- *
- * The maximum number of monitoring regions of DAMON for the cold memory
- * monitoring.  This can be used to set upper-bound of the monitoring overhead.
- * However, setting this too low could result in bad monitoring quality.
- * Please refer to the DAMON documentation for more detail.  1000 by default.
- */
-module_param_named(max_nr_regions, damon_reclaim_mon_attrs.max_nr_regions,
-		ulong, 0600);
+DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_reclaim_mon_attrs);
 
 /*
  * Start of the target memory region in physical address.
-- 
2.25.1

