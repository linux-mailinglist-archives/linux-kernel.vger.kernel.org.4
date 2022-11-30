Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EBD63E131
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiK3UKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiK3UJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:09:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD88C6A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8681CB81CD9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E89C43146;
        Wed, 30 Nov 2022 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669838983;
        bh=grt8f69Dz6AwyetZSMeMbFhewde1iaVMzadAT1LoRZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLNVlXze66e6bJgKZEGO6XI9qKr/WWkt6nkzk1TBS/Zp1Ly0AijwDHo+ze1hiwAg8
         IWldWCPVTjtow7pGt00n5zCRRKElawSyBxP+MSy8AZp7EjmkPhMyQa9tfE9qrQYQ8Y
         5ERqWfkAUyirqLxgMNPSQ3kmrgyMEIrq9Qm7aJDQUiXLJQEI52w1/f21B2soeQUYtN
         OWALqy4zpatDyFmHUrVLOiWSqokxBiwwl0NylXbV4md41gQpUegL7x6yQswbiK2ZtB
         8Zw46mBgzM5M42g+RpWukjcjOMYjgsei/DCOxhSOHXGQfogoPE724ciYkfcZladH5+
         kdqd1DsjoGUWg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 03/11] mm/damon/reclaim: add a parameter called skip_anon for avoiding anonymous pages reclamation
Date:   Wed, 30 Nov 2022 20:09:29 +0000
Message-Id: <20221130200937.118005-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200937.118005-1-sj@kernel.org>
References: <20221130200937.118005-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, for example if users have confidence at anonymous pages
management or the swap device is too slow, users would want to avoid
DAMON_RECLAIM swapping the anonymous pages out.  For such case, add yet
another DAMON_RECLAIM parameter, namely 'skip_anon'.  When it is set as
'Y', DAMON_RECLAIM will avoid reclaiming anonymous pages using a DAMOS
filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e82631f39481..648d2a85523a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -98,6 +98,15 @@ module_param(monitor_region_start, ulong, 0600);
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
+/*
+ * Skip anonymous pages reclamation.
+ *
+ * If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+ * pages.  By default, ``N``.
+ */
+static bool skip_anon __read_mostly;
+module_param(skip_anon, bool, 0600);
+
 /*
  * PID of the DAMON thread
  *
@@ -142,6 +151,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 static int damon_reclaim_apply_parameters(void)
 {
 	struct damos *scheme;
+	struct damos_filter *filter;
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -152,6 +162,15 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
+	if (skip_anon) {
+		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+		if (!filter) {
+			/* Will be freed by next 'damon_set_schemes()' below */
+			damon_destroy_scheme(scheme);
+			return -ENOMEM;
+		}
+		damos_add_filter(scheme, filter);
+	}
 	damon_set_schemes(ctx, &scheme, 1);
 
 	return damon_set_region_biggest_system_ram_default(target,
-- 
2.25.1

