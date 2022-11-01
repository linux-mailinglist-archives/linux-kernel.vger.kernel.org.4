Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9802C6154A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKAWDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiKAWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10563C7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D2A5B81F90
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CFBC43470;
        Tue,  1 Nov 2022 22:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340213;
        bh=RJxfjUA7jNYJ7rWPy3bqy3nlzFdR9jtjrg0QcbRrD0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLI4dX1ktExmpS86A8YCkyHR1D8R29/qqVpOFjBUDqtvYEmJugGewa7sIYD5WLI9R
         pBLkM+jK4FtBoIt2BcpKlGqFFuw6XU3fVbXHrSubLQ5kV8nE+QBaTqpKuwaLxclSeg
         ktyuyFdw5fDZvOgpmgUi5NsOXzvUosBUH+h1EaupHKSxWOLPZ7ZFjZGccgji22fdsq
         hMKSS3z8J/fXd3CGtSG7hdLUuc3VXOgFZrqQo/QTg9eGN2pFF13QbeLIuFSsqO95L4
         0w7ORnyKfxlVwQN0L0jckgI/e93A8xNYx2UNFvn5BUjBy/pHCh7lS4mzsqex25YBBT
         4W4WBOLWK5pNw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/8] mm/damon/core: add a callback for scheme target regions check
Date:   Tue,  1 Nov 2022 22:03:21 +0000
Message-Id: <20221101220328.95765-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting DAMON monitoring results of only specific access pattern (e.g.,
getting address ranges of memory that not accessed at all for two
minutes) can be useful for efficient monitoring of the system.  The
information can also be helpful for deep level investigation of
DAMON-based operation schemes.

For that, users need to record (in case of the user space users) or
iterate (in case of the kernel space users) full monitoring results and
filter it out for the specific access pattern.  In case of the DAMOS
investigation, users will even need to simulate DAMOS' quota and
prioritization mechanisms.  It's inefficient and complex.

Add a new DAMON callback that will be called before each scheme is
applied to each region.  DAMON kernel API users will be able to do the
query-like monitoring results collection, or DAMOS investigation in an
efficient and simple way using it.

Commits for providing the capability to the user space users will
follow.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 620ada094c3b..35630634d790 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -357,6 +357,7 @@ struct damon_operations {
  * @after_wmarks_check:	Called after each schemes' watermarks check.
  * @after_sampling:	Called after each sampling.
  * @after_aggregation:	Called after each aggregation.
+ * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
  * @private:		User private data.
  *
@@ -385,6 +386,10 @@ struct damon_callback {
 	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
+	int (*before_damos_apply)(struct damon_ctx *context,
+			struct damon_target *target,
+			struct damon_region *region,
+			struct damos *scheme);
 	void (*before_terminate)(struct damon_ctx *context);
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 80d5937fe337..ceec75b88ef9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -772,6 +772,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
+	int err = 0;
 
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
@@ -782,7 +783,10 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			damon_split_region_at(t, r, sz);
 		}
 		ktime_get_coarse_ts64(&begin);
-		sz_applied = c->ops.apply_scheme(c, t, r, s);
+		if (c->callback.before_damos_apply)
+			err = c->callback.before_damos_apply(c, t, r, s);
+		if (!err)
+			sz_applied = c->ops.apply_scheme(c, t, r, s);
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-- 
2.25.1

