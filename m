Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B66F9A6F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjEGRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEGRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:07:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4473AD33
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 10:07:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64115eef620so29532404b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683479248; x=1686071248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwSoQAc7RbQrYw6wtZrAMpWLXHB/By9Q7OuDr1RV12Y=;
        b=PHn3HatrrXTilibhO/B32WQZfXLxtuQRjz3v3L2ZfTB9+VVfks2XHVrwDw8QEDzc34
         nRzUlgMxNktS121uu7zypH1Rp/S3fBwUJqtWRT1wB17zDGnc1bsbLAoWowu4t2QAb293
         UDM2cCdAcdgO7PF9CmnXJl8XDJCaL7J0alieJUM3hyb+3l1TloGpfuq82/xDVa8DWLn7
         IBnroT+IA39zWwwC3YexhUD/iQBhTujVWyEmuN2sORnYQ4/zxRtOhmcVZJZorD5X8D4t
         ZxyRhJMgR2J7/mpg2D/S9x79GzL4iSHtI8KbysR0Wx5//OGYvrcMTUUUjgP/5Ivs6OZD
         fEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683479248; x=1686071248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwSoQAc7RbQrYw6wtZrAMpWLXHB/By9Q7OuDr1RV12Y=;
        b=VcW7U6379dj/KUFGNvnNK1NLoyvg4vvM5x05+DT08UBpy4Y5qCsQjRr0nj6F+95P5n
         C12GTPNOZ8zYx8Z1J3XUItyR8Hu+SA+7lFwc8Pyv3RI+t3kiCy9d1Zn/dBN4pAWHRaxe
         npFGMPXCYL2PotdAU6HEn6UKecgA+soliyPXHFmIQ//x6yvZV9HjtrtNigW7MSK3Jqar
         u8PXOkcQZR4GeEX/fqH/0Cu7bl1ZK9xv0MoVXGggvymKrq2/2EpJQk0Y36D/hL/wG413
         2b96aWiHKzVxw4QO/XI9ONItY4hCfv9JQqcdEFnd3gKOMFa7I1uKgPM+1Ck3WNvCFB9o
         B5sw==
X-Gm-Message-State: AC+VfDyjjBBOT5utWx7Powr9VY2m8DLEFl44/+tX6J4Sze37mLn9WCgJ
        wAF5RwhVzy1uD1FrzxuGPhG/Gw==
X-Google-Smtp-Source: ACHHUZ4GU5TWfGVWE8k1nBxNf8YxRbDK2NY9T2SMPy8Wb+TEaDqAqicYl6XGzMZJrXx3j0So6AviYw==
X-Received: by 2002:a17:902:f54f:b0:1ac:750e:33d6 with SMTP id h15-20020a170902f54f00b001ac750e33d6mr1358228plf.23.1683479248261;
        Sun, 07 May 2023 10:07:28 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id az8-20020a170902a58800b001ab0159ba3esm4374546plb.13.2023.05.07.10.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 10:07:27 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        andrea.righi@canonical.com, Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v3] blk-throttle: Fix io statistics for cgroup v1
Date:   Mon,  8 May 2023 01:06:31 +0800
Message-Id: <20230507170631.89607-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
the only stable io stats interface of cgroup v1, and these statistics
are done in the blk-throttle code. But the current code only counts the
bios that are actually throttled. When the user does not add the throttle
limit, the io stats for cgroup v1 has nothing. I fix it according to the
statistical method of v2, and made it count all ios accurately.

Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 block/blk-cgroup.c   | 6 ++++--
 block/blk-throttle.c | 6 ------
 block/blk-throttle.h | 9 +++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ce64dd73cfe..5b29912a0ee2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2048,6 +2048,9 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
+		return;
+
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(blkcg->css.cgroup))
 		return;
@@ -2079,8 +2082,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
+	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
 	put_cpu();
 }
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9d010d867fbf..7397ff199d66 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2178,12 +2178,6 @@ bool __blk_throtl_bio(struct bio *bio)
 
 	rcu_read_lock();
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
-		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
-				bio->bi_iter.bi_size);
-		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
-	}
-
 	spin_lock_irq(&q->queue_lock);
 
 	throtl_update_latency_buckets(td);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ef4b7a4de987..d1ccbfe9f797 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -185,6 +185,15 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 	int rw = bio_data_dir(bio);
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
+			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+					bio->bi_iter.bi_size);
+		}
+		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	}
+
 	/* iops limit is always counted */
 	if (tg->has_rules_iops[rw])
 		return true;
-- 
2.20.1

