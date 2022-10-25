Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8CA60D299
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiJYRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiJYRg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:36:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B437E0DD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA21A61A90
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3774C433C1;
        Tue, 25 Oct 2022 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666719417;
        bh=+caf26+jd72lruUI8kvmUSn/EY6APaB7dnve/Z0xjuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrvuZF1rz0yy76gaafEWaleR/CkM5YsNrvrCOFv6/E/w/seFIqYB3UP9+6l4nkUTG
         ZvaeD6LBqntTUHJSQYSR8rE458QNlCE4yoc5sowKYsyMG68vZ5Hfx+1Tk5RzBwZDjn
         En713epPu9yRhZ/GWV1RvdxH7xh1lnwvRF+yUwj18v7h3FaEoskB39vXx82qym80d0
         0FlNhjJ58O79R1P46X9E5ZPNQmfjaMLSyaeVFQogOnq+so/lHveaSACm4ezDf/7u29
         hIZBH9Ax7ptOX8LFis2l27TqE0j+wh3OOxDcxTBbVrZGJx14i+gIJ3el2R+euIju8M
         seP77KD02p9tQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/4] mm/damon/lru_sort: enable and disable synchronously
Date:   Tue, 25 Oct 2022 17:36:49 +0000
Message-Id: <20221025173650.90624-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025173650.90624-1-sj@kernel.org>
References: <20221025173650.90624-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing a value to DAMON_RECLAIM's 'enabled' parameter turns on or off
DAMON in an ansychronous way.  This means the parameter cannot be used
to read the current status of DAMON_RECLAIM.  'kdamond_pid' parameter
should be used instead for the purpose.  The documentation is easy to be
read as it works in a synchronous way, so it is a little bit confusing.
It also makes the user space tooling dirty.

There's no real reason to have the asynchronous behavior, though.
Simply make the parameter works synchronously, rather than updating the
document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 51 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 5c60163e556c..2a532e3983df 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -9,7 +9,6 @@
 
 #include <linux/damon.h>
 #include <linux/module.h>
-#include <linux/workqueue.h>
 
 #include "modules-common.h"
 
@@ -235,38 +234,31 @@ static int damon_lru_sort_turn(bool on)
 	return 0;
 }
 
-static struct delayed_work damon_lru_sort_timer;
-static void damon_lru_sort_timer_fn(struct work_struct *work)
-{
-	static bool last_enabled;
-	bool now_enabled;
-
-	now_enabled = enabled;
-	if (last_enabled != now_enabled) {
-		if (!damon_lru_sort_turn(now_enabled))
-			last_enabled = now_enabled;
-		else
-			enabled = last_enabled;
-	}
-}
-static DECLARE_DELAYED_WORK(damon_lru_sort_timer, damon_lru_sort_timer_fn);
-
-static bool damon_lru_sort_initialized;
-
 static int damon_lru_sort_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	int rc = param_set_bool(val, kp);
+	bool is_enabled = enabled;
+	bool enable;
+	int err;
+
+	err = strtobool(val, &enable);
+	if (err)
+		return err;
 
-	if (rc < 0)
-		return rc;
+	if (is_enabled == enable)
+		return 0;
 
-	if (!damon_lru_sort_initialized)
-		return rc;
+	/* Called before init function.  The function will handle this. */
+	if (!ctx)
+		goto set_param_out;
 
-	schedule_delayed_work(&damon_lru_sort_timer, 0);
+	err = damon_lru_sort_turn(enable);
+	if (err)
+		return err;
 
-	return 0;
+set_param_out:
+	enabled = enable;
+	return err;
 }
 
 static const struct kernel_param_ops enabled_param_ops = {
@@ -320,10 +312,11 @@ static int __init damon_lru_sort_init(void)
 	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
 
-	schedule_delayed_work(&damon_lru_sort_timer, 0);
+	/* 'enabled' has set before this function, probably via command line */
+	if (enabled)
+		err = damon_lru_sort_turn(true);
 
-	damon_lru_sort_initialized = true;
-	return 0;
+	return err;
 }
 
 module_init(damon_lru_sort_init);
-- 
2.25.1

