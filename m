Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4525BC2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiISG2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiISG2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:28:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E44B6466
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:28:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ge9so15276956pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4WuZzVRxwcTGHQZujoUVeEOCj8W31DhiTMyONvZ57AA=;
        b=C7poXa9A9sBin/vPnHXBndUU4/Qwekk3fXFmg8Lw0NKK3r6WnHu8j5SR/tG/lvZpXr
         SoINxtIChpZ6dbFt8Kd0HOWBxN5+4YwLKjwBddEaxJIPJ4I0V5zRpBgpD9oIXHpueuMz
         o/IA40WwOkljkuhdZZeAZvBkIF8X5yRPVorThzihTLUx6QOrI3MRl9tGRQMC+KxAxede
         6vjKXWkdMm/tdozpAwbeaZexCTIZ1W05InKxljdzNi/GAcibfOaGH4LIzxLYs20ME01I
         F59g2p3kMxsHJKCGbztDy3Y/5WwYazNS8VitGmr/MIEKsEr+ok27KanMLhS9yyDkJt8s
         XJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4WuZzVRxwcTGHQZujoUVeEOCj8W31DhiTMyONvZ57AA=;
        b=mI6ORzeSICbDQEAAYDKSmXYgFpU2I4ymAqg44PUZJAvtROBDDWH5xvgBaf3RUYbYzS
         Ey20pwcILQEkeXMRKcPRtl5yLjwZEZJNuNBYhV0WbzygyZau+ikkrAj7yXRp3qF5MdFb
         RiOpwrlNCcQTqr2wk9CU/jC/+ClDwFbN9a8urfesaFMSdak3v2w66kvs2PYz5BOtsMgM
         XwWP9Xccxdp3OIO7tQqbBv1b71YdsM92h7odtHra7dlII1AS69ErGYabX7ahCpsOHe/J
         tITwagVI2dpaIHOfMeMoTuNwz+bhgUnu+QXblNwsOuy4Sy1dy2RlG4L32zBCqx3nN3uY
         WTwA==
X-Gm-Message-State: ACrzQf1KaLCDX82onI7IDv221vLTy8y/X6gbytHw4uGTO1WrXTgjTneu
        Xmi/L6Fzd4C55jME9WQpUg==
X-Google-Smtp-Source: AMsMyM6KfjLlQbOOM0eEafho5Jey3U0WUAIhvROAuqw6rNfno/hBboac9DDKd1AgWsrH/xRDYl+xYA==
X-Received: by 2002:a17:90b:1b0e:b0:202:c913:221f with SMTP id nu14-20020a17090b1b0e00b00202c913221fmr29411347pjb.211.1663568908981;
        Sun, 18 Sep 2022 23:28:28 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id co16-20020a17090afe9000b001fba4716f11sm5840259pjb.22.2022.09.18.23.28.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Sep 2022 23:28:28 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()
Date:   Mon, 19 Sep 2022 14:28:09 +0800
Message-Id: <1663568889-17634-1-git-send-email-kaixuxia@tencent.com>
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
damon_set_regions_from_system_ram() to removes the duplicates.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 include/linux/damon.h |  3 ++-
 mm/damon/core.c       | 20 +++++++++++++++++++-
 mm/damon/lru_sort.c   | 13 +++----------
 mm/damon/reclaim.c    | 13 +++----------
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e7808a84675f..2fd05568ef45 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -557,7 +557,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
-bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
+int damon_set_regions_from_system_ram(struct damon_target *t,
+				unsigned long *start, unsigned long *end);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9c80c6eb00c2..d967b2805a53 100644
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
@@ -1259,6 +1260,23 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
 	return true;
 }
 
+int damon_set_regions_from_system_ram(struct damon_target *t,
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
index d7eb72b41cb6..0276cbec632a 100644
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
+	return damon_set_regions_from_system_ram(target,
+				&monitor_region_start,
+				&monitor_region_end);
 }
 
 static int damon_lru_sort_turn(bool on)
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3d59ab11b7b3..6297e1799190 100644
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
+	return damon_set_regions_from_system_ram(target,
+				&monitor_region_start,
+				&monitor_region_end);
 }
 
 static int damon_reclaim_turn(bool on)
-- 
2.27.0

