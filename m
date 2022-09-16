Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9345BB021
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIPPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiIPPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:22:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C336AA4DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:22:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j12so21535691pfi.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8piKn5FnzNCRTWXKeKltQYBcUotQeP0xAHSm87BtmOg=;
        b=YKah748oMkqEZtDKOJdy63FjeXS3rfEh1bkzQ9bZPEQyZRWO+kERMHY6vVw6kAhfG3
         e1CP8tw9FI/kXPKWTntaMb/QXYAHS5QC+wAOzJtYwfCorb1I+/PBrRkFEEp2qebmiZ3k
         aEJJqL0JLKwMe7JnitgX+aSZABWgKDbbxvxSvFRgKvnvefN18Ne9RaHUdAPpiOGpZjo9
         yl4zR8qfzoinC8toiPtbgHoRmdRwSVr9WxFCrhLUKGCB0/o6Y+z1RvYj7fDPI1892c+5
         Q2ddyEuKcKEEoEzCFiWAkUuuRCCnn/rlaBTJ1qu4DMZdbqDqFUmlffJ60paVzJ29gbfb
         ZBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8piKn5FnzNCRTWXKeKltQYBcUotQeP0xAHSm87BtmOg=;
        b=iA0qI3KbHjGZ8GcKsT6+QnhbEDfLWjNlipQjK//tEy5Fvt3k9og4o/7Fst4esl2EIF
         Ot7hlXi/op0hDv+2BN4i2v2x9apnEasVo9eGGsh5uGvSuqJGprYGKDXCXDOpzrq7kEwY
         UzuZsiwbO5H9bEHU6DPv6xqxBTIE5D3yj9b7jRcyDt3hcpZ9QRPKD2B9JLpITyKiU0iW
         rUif7hy9ChVlya2pnlqOlaizqwUiVIAaOGCP0dJovNIpe6omiEHfrLH/UkeE0/+oRAuY
         5d6AbV9MyqUyvLrq5lak+NUdCXTojmmJuAW7aT67wzHIJVsfTFeTLS74zyKG9cjMUg0A
         jD7w==
X-Gm-Message-State: ACrzQf3BZqtG/KOybjj2AOncBZNppDiJEkwrUEDp7qXL2EsZii+N8MGv
        8qdEq/iloeF3A0FfdknpDw==
X-Google-Smtp-Source: AMsMyM6xJ68WQvbE7MiwVujE3NnstM8TpzOuUmkp/ve1xHZ+2MhL2p85sgsiPNKOB//JCsfxBtwsaQ==
X-Received: by 2002:a05:6a00:b4d:b0:540:cee1:657e with SMTP id p13-20020a056a000b4d00b00540cee1657emr5359168pfo.22.1663341774957;
        Fri, 16 Sep 2022 08:22:54 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id 17-20020a630d51000000b0042fe1914e26sm13845173pgn.37.2022.09.16.08.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2022 08:22:54 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: return void from damon_set_schemes()
Date:   Fri, 16 Sep 2022 23:20:35 +0800
Message-Id: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
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

There is no point in returning an int from damon_set_schemes().
It always returns 0 which is meaningless for the caller, so
change it to return void directly.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 include/linux/damon.h | 2 +-
 mm/damon/core.c       | 5 +----
 mm/damon/dbgfs.c      | 8 +++-----
 mm/damon/lru_sort.c   | 4 +---
 mm/damon/reclaim.c    | 4 +---
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1dda8d0068e5..e7808a84675f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -541,7 +541,7 @@ unsigned int damon_nr_regions(struct damon_target *t);
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
-int damon_set_schemes(struct damon_ctx *ctx,
+void damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
 int damon_nr_running_ctxs(void);
 bool damon_is_registered_ops(enum damon_ops_id id);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a843673c11cf..9c80c6eb00c2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -454,10 +454,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
  *
  * This function should not be called while the kdamond of the context is
  * running.
- *
- * Return: 0 if success, or negative error code otherwise.
  */
-int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
+void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 			ssize_t nr_schemes)
 {
 	struct damos *s, *next;
@@ -467,7 +465,6 @@ int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 		damon_destroy_scheme(s);
 	for (i = 0; i < nr_schemes; i++)
 		damon_add_scheme(ctx, schemes[i]);
-	return 0;
 }
 
 /**
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index c00eba4448d8..6f0ae7d3ae39 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -307,11 +307,9 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 		goto unlock_out;
 	}
 
-	ret = damon_set_schemes(ctx, schemes, nr_schemes);
-	if (!ret) {
-		ret = count;
-		nr_schemes = 0;
-	}
+	damon_set_schemes(ctx, schemes, nr_schemes);
+	ret = count;
+	nr_schemes = 0;
 
 unlock_out:
 	mutex_unlock(&ctx->kdamond_lock);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index abfaf471e3e9..0abb9f8aa9af 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -203,9 +203,7 @@ static int damon_lru_sort_apply_parameters(void)
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
 		return -ENOMEM;
-	err = damon_set_schemes(ctx, &scheme, 1);
-	if (err)
-		return err;
+	damon_set_schemes(ctx, &scheme, 1);
 
 	cold_thres = cold_min_age / damon_lru_sort_mon_attrs.aggr_interval;
 	scheme = damon_lru_sort_new_cold_scheme(cold_thres);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 039fa55e0ae9..3d59ab11b7b3 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -155,9 +155,7 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
-	err = damon_set_schemes(ctx, &scheme, 1);
-	if (err)
-		return err;
+	damon_set_schemes(ctx, &scheme, 1);
 
 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
-- 
2.27.0

