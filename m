Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A5672E73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjASBth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjASBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E22C6B997
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:38:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB7256176F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F7C433F1;
        Thu, 19 Jan 2023 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674092319;
        bh=yP6UCgAzws1bfIuCPl7GC+6z1XlLpntmwCkcasuOLyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/Sn7kF6Omqwq6ivaQphfNyZL1j/yVGYRmDcofn0KoeDu27nTBXyEXj08jraNePN+
         Xn4BAUjzN+DK4KTjJBGSJcB8oka3uisg8HYE5hMkn9XrF/IRHDk/KKChGrB3enxxv6
         4mqfuu2PfswrNY11OQriGo6l+SmFWK12o3UpoVnDU2Fp2ZxmpdceUme7do10dGrDnU
         +TqGgvf+I8K8kk21Zmqht6LtGFiwLRyKbVqV5J/B7v663j9EYoJk9DuuGUZnFwsZTq
         bQmbCIu49vdLv1YmI9j8umVn8Ym1RnWBYzFW9gzIpapvEb3oZMUwJ1HueZvAcuErDK
         gjORYVfVgvtqA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/damon/core: update monitoring results for new monitoring attributes
Date:   Thu, 19 Jan 2023 01:38:30 +0000
Message-Id: <20230119013831.1911-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119013831.1911-1-sj@kernel.org>
References: <20230119013831.1911-1-sj@kernel.org>
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

region->nr_accesses is the number of sampling intervals in the last
aggregation interval that access to the region has found, and
region->age is the number of aggregation intervals that its access
pattern has maintained.  Hence, the real meaning of the two fields'
values is depending on current sampling and aggregation intervals.

This means the values need to be updated for every sampling and/or
aggregation intervals updates.  As DAMON core doesn't, it is a duty of
in-kernel DAMON framework applications like DAMON sysfs interface, or
the userspace users.

Handling it in userspace or in-kernel DAMON application is complicated,
inefficient, and repetitive compared to doing the update in DAMON core.
Do the update in DAMON core.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2db8c53491ca..d9ef62047bf5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -465,6 +465,76 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	kfree(ctx);
 }
 
+static unsigned int damon_age_for_new_attrs(unsigned int age,
+		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
+{
+	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
+}
+
+/* convert access ratio in bp (per 10,000) to nr_accesses */
+static unsigned int damon_accesses_bp_to_nr_accesses(
+		unsigned int accesses_bp, struct damon_attrs *attrs)
+{
+	unsigned int max_nr_accesses =
+		attrs->aggr_interval / attrs->sample_interval;
+
+	return accesses_bp * max_nr_accesses / 10000;
+}
+
+/* convert nr_accesses to access ratio in bp (per 10,000) */
+static unsigned int damon_nr_accesses_to_accesses_bp(
+		unsigned int nr_accesses, struct damon_attrs *attrs)
+{
+	unsigned int max_nr_accesses =
+		attrs->aggr_interval / attrs->sample_interval;
+
+	return nr_accesses * 10000 / max_nr_accesses;
+}
+
+static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
+		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
+{
+	return damon_accesses_bp_to_nr_accesses(
+			damon_nr_accesses_to_accesses_bp(
+				nr_accesses, old_attrs),
+			new_attrs);
+}
+
+static void damon_update_monitoring_result(struct damon_region *r,
+		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
+{
+	r->nr_accesses = damon_nr_accesses_for_new_attrs(r->nr_accesses,
+			old_attrs, new_attrs);
+	r->age = damon_age_for_new_attrs(r->age, old_attrs, new_attrs);
+}
+
+/*
+ * region->nr_accesses is the number of sampling intervals in the last
+ * aggregation interval that access to the region has found, and region->age is
+ * the number of aggregation intervals that its access pattern has maintained.
+ * For the reason, the real meaning of the two fields depend on current
+ * sampling interval and aggregation interval.  This function updates
+ * ->nr_accesses and ->age of given damon_ctx's regions for new damon_attrs.
+ */
+static void damon_update_monitoring_results(struct damon_ctx *ctx,
+		struct damon_attrs *new_attrs)
+{
+	struct damon_attrs *old_attrs = &ctx->attrs;
+	struct damon_target *t;
+	struct damon_region *r;
+
+	/* if any interval is zero, simply forgive conversion */
+	if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
+			!new_attrs->sample_interval ||
+			!new_attrs->aggr_interval)
+		return;
+
+	damon_for_each_target(t, ctx)
+		damon_for_each_region(r, t)
+			damon_update_monitoring_result(
+					r, old_attrs, new_attrs);
+}
+
 /**
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
@@ -482,6 +552,7 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
 		return -EINVAL;
 
+	damon_update_monitoring_results(ctx, attrs);
 	ctx->attrs = *attrs;
 	return 0;
 }
-- 
2.25.1

