Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972825BDAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiITDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiITDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:45:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3FE0BF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:45:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p18so1123293plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YD7hd3hhitQ0ZZVcAt1CNpm+2q/a/QqH8eSW/It4jOc=;
        b=R8P+SsH3Wyqs714dWK/k+Pwca0WluPJ3cMXSNEx8dbv5h7zk3n4WPOUCtz+1DxYY1t
         1x4Ig7cwuPZLpUnagq7nTWzEW6ZwXG3oqMF9NkNDarrAjHcsedv/eCJFHn2m45YMN/hK
         k1lLAaV+HYRbJwutjv46LQqdX5the5r3VT0iQ6MYkkaIyRGW2DUeV9jGMvmrQTcOhStx
         dJsKsc6zFShdRsqc0oWpoqOPp91yBtSzbotEgriDkQMp8rwnj/ihl4A+IQwegSpj1DaB
         rShDG5NHSpkP3IQUYOlZez9jyzdrVj1sLnmIAA7itIVPFzrUH83ShjlpCi6G3tgWKRYZ
         kiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YD7hd3hhitQ0ZZVcAt1CNpm+2q/a/QqH8eSW/It4jOc=;
        b=oWFW9QITziEtbGL75jz6GcZ3G8rjPzebyLG1nojPxFyBIHkvavNprYrtA46v5LN/iE
         xYiODIg3t+IZA+MsBGEKfJwK7eHlvipoCZElAuoPbgCRBB19IH4HeAyATBcIVeW4/MB8
         ZILu8LvqB1+3clI2aMs2Ev276nljp2otlvYySYwbQefLw8jKLUPUHB0KH5sczVEU225R
         JCN6GBbv04IeufvHS4PNIdr2tQkEzJqGnxBV6lwbUTmI0gdRygdghoNDpuYrigeIpfu6
         vNEtzKe14AxioMG9f8AJdNXEJdGyVGCTJ88/SaUDYTyYLzofZf2HcSOc5aDE+lHWqNmi
         y+cQ==
X-Gm-Message-State: ACrzQf01dgK97rTR0+Ox2mM9QWSlbF9zSK/czH1jsC1XvmjQ7kN0RAHF
        yzSLwMckvjQn98Za3Jq8yM3vtp0TkBUc
X-Google-Smtp-Source: AMsMyM4ZJ1O4dtE9VngQsTj07UObovLvLpvTPeHPr20gQ6Uwr6RB+6a39/H2k+ybIxNI/orlP3y1lQ==
X-Received: by 2002:a17:903:1110:b0:178:9f67:b524 with SMTP id n16-20020a170903111000b001789f67b524mr3032927plh.50.1663645507266;
        Mon, 19 Sep 2022 20:45:07 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id mj24-20020a17090b369800b001fb53587166sm261301pjb.28.2022.09.19.20.45.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2022 20:45:06 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()
Date:   Tue, 20 Sep 2022 11:44:21 +0800
Message-Id: <1663645461-21084-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The bodies of damon_{reclaim,lru_sort}_apply_parameters() contain
duplicates. This commit add a common function
damon_set_region_biggest_system_ram_default() to removes the
duplicates.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Suggested-by: SeongJae Park <sj@kernel.org>
---
v2:
 -change the common function name and add kernel comment.

 include/linux/damon.h |  3 ++-
 mm/damon/core.c       | 35 ++++++++++++++++++++++++++++++++++-
 mm/damon/lru_sort.c   | 13 +++----------
 mm/damon/reclaim.c    | 13 +++----------
 4 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e7808a84675f..ed5470f50bab 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -557,7 +557,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
-bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
+int damon_set_region_biggest_system_ram_default(struct damon_target *t,
+				unsigned long *start, unsigned long *end);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9c80c6eb00c2..9e96cb9fb5db 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1245,7 +1245,8 @@ static int walk_system_ram(struct resource *res, void *arg)
  * Find biggest 'System RAM' resource and store its start and end address in
  * @start and @end, respectively.  If no System RAM is found, returns false.
  */
-bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
+static bool damon_find_biggest_system_ram(unsigned long *start,
+						unsigned long *end)
 
 {
 	struct damon_system_ram_region arg = {};
@@ -1259,6 +1260,38 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
 	return true;
 }
 
+/*
+ * damon_set_region_biggest_system_ram_default() - Set the region of the given
+ * monitoring target as requested, or biggest 'System RAM'.
+ * @t:		The monitoring target to set the region.
+ * @start:	The pointer to the start address of the region.
+ * @end:	The pointer to the end address of the region.
+ *
+ * This function sets the region of @t as requested by @start and @end.  If the
+ * values of the two pointers are pointing to are zero, however, this function
+ * finds the biggest 'System RAM' resource and set the region to cover the
+ * resource.  In the latter case, this function saves the start and end address
+ * of the resource in @start and @end, respectively.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_region_biggest_system_ram_default(struct damon_target *t,
+			unsigned long *start, unsigned long *end)
+{
+	struct damon_addr_range addr_range;
+
+	if (*start > *end)
+		return -EINVAL;
+
+	if (!*start && !*end &&
+		!damon_find_biggest_system_ram(start, end))
+		return -EINVAL;
+
+	addr_range.start = *start;
+	addr_range.end = *end;
+	return damon_set_regions(t, &addr_range, 1);
+}
+
 static int __init damon_init(void)
 {
 	damon_region_cache = KMEM_CACHE(damon_region, 0);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index d7eb72b41cb6..efbc2bda8b9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -188,7 +188,6 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 static int damon_lru_sort_apply_parameters(void)
 {
 	struct damos *scheme;
-	struct damon_addr_range addr_range;
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
 
@@ -211,15 +210,9 @@ static int damon_lru_sort_apply_parameters(void)
 		return -ENOMEM;
 	damon_add_scheme(ctx, scheme);
 
-	if (monitor_region_start > monitor_region_end)
-		return -EINVAL;
-	if (!monitor_region_start && !monitor_region_end &&
-	    !damon_find_biggest_system_ram(&monitor_region_start,
-					   &monitor_region_end))
-		return -EINVAL;
-	addr_range.start = monitor_region_start;
-	addr_range.end = monitor_region_end;
-	return damon_set_regions(target, &addr_range, 1);
+	return damon_set_region_biggest_system_ram_default(target,
+					&monitor_region_start,
+					&monitor_region_end);
 }
 
 static int damon_lru_sort_turn(bool on)
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3d59ab11b7b3..162c9b1ca00f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -144,7 +144,6 @@ static struct damos *damon_reclaim_new_scheme(void)
 static int damon_reclaim_apply_parameters(void)
 {
 	struct damos *scheme;
-	struct damon_addr_range addr_range;
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -157,15 +156,9 @@ static int damon_reclaim_apply_parameters(void)
 		return -ENOMEM;
 	damon_set_schemes(ctx, &scheme, 1);
 
-	if (monitor_region_start > monitor_region_end)
-		return -EINVAL;
-	if (!monitor_region_start && !monitor_region_end &&
-	    !damon_find_biggest_system_ram(&monitor_region_start,
-					   &monitor_region_end))
-		return -EINVAL;
-	addr_range.start = monitor_region_start;
-	addr_range.end = monitor_region_end;
-	return damon_set_regions(target, &addr_range, 1);
+	return damon_set_region_biggest_system_ram_default(target,
+					&monitor_region_start,
+					&monitor_region_end);
 }
 
 static int damon_reclaim_turn(bool on)
-- 
2.27.0

