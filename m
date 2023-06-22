Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E9739B30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjFVI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjFVIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:55:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD32695
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b693afe799so2464575ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424115; x=1690016115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Gb8UpD3lZt4bh5cbhFKOyQevww2sfofkVlmbPNwxg8=;
        b=D5LVC+4HokJCz4FPeXcY+dsaTssife3Qqo2QFad+aTpXncu7uEYIb5Esgo0X9193yq
         JD9ShpMbmoNV55hSp3a3PNB6eqKE4aEEgjXjfXMhn0CWCq43W/gk5ji4OA6QFiz5YEbm
         Of780eCZQIl3oU3nzqHMjitXTfpqsvwkQAoJ3/aSYN48pFnlXdDicr+5TJONhzqSsJ8t
         IgcwK0tiB9rdlMicFxhfFEkVC1N5FWb0hV5n3c+iSTxmBlXa0ZlHHEAwcq0BLcrHgmll
         f7y7d2fR0/LzWuGi/rCVXp+lACayEzs+7pdEprt9XcBuFLw9Vycb7reaOybOjmFS0TWh
         I1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424115; x=1690016115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Gb8UpD3lZt4bh5cbhFKOyQevww2sfofkVlmbPNwxg8=;
        b=ekhgaYAEOCU4O4QfidUeDDHDPmP/Uio0fWc1ZajjruJoUbtHU+Pjhj1Z1/dkYLnQV8
         0aqHS0ijyzSndDiSigp53IAubYBCQ6aQICbu4hBZKrJJ+aggHtajFWVRWsUBtWeGbgKd
         ihR4ax0BxNZdkvhr68Zzomh/O3r3kpNs8NQtLEKO6/6LXi94luxdwJ1z9jaub/ohhujx
         y50KngFOWzVIIw38i579Xr6JwMLCZD1GKbRMX/ghYYpAviIf5EeS4xhy3MGGdlAPi3gd
         spXNjx4+120AvOUc5OmFfEg0/mi53he723Pi5Ci0GAGwqbkGXlZUTqPbrvAShN6mktd2
         ToAQ==
X-Gm-Message-State: AC+VfDzTDdKD4IHGR9ymQfcakZIL9Pes0zVS6QKyxss5IAJweVS2Hx+K
        ooHUNC03X1Mj/4TdLkE55bLBhg==
X-Google-Smtp-Source: ACHHUZ4eMYIbb4I7cyZSyRLa7A39+u7jKZFqr72/TYsRg3oKUy2dca/PQ8JGq6DHBe5p8nrFI+JLcw==
X-Received: by 2002:a17:903:2451:b0:1b0:34c6:3bf2 with SMTP id l17-20020a170903245100b001b034c63bf2mr21539426pls.5.1687424114850;
        Thu, 22 Jun 2023 01:55:14 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:55:14 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 09/29] bcache: dynamically allocate the md-bcache shrinker
Date:   Thu, 22 Jun 2023 16:53:15 +0800
Message-Id: <20230622085335.77010-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the md-bcache shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct cache_set.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/bcache/bcache.h |  2 +-
 drivers/md/bcache/btree.c  | 23 ++++++++++++++---------
 drivers/md/bcache/sysfs.c  |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 700dc5588d5f..53c73b372e7a 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -541,7 +541,7 @@ struct cache_set {
 	struct bio_set		bio_split;
 
 	/* For the btree cache */
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
 
 	/* For the btree cache and anything allocation related */
 	struct mutex		bucket_lock;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 569f48958bde..1131ae91f62a 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -667,7 +667,7 @@ static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
 static unsigned long bch_mca_scan(struct shrinker *shrink,
 				  struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 	struct btree *b, *t;
 	unsigned long i, nr = sc->nr_to_scan;
 	unsigned long freed = 0;
@@ -734,7 +734,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 static unsigned long bch_mca_count(struct shrinker *shrink,
 				   struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 
 	if (c->shrinker_disabled)
 		return 0;
@@ -752,8 +752,8 @@ void bch_btree_cache_free(struct cache_set *c)
 
 	closure_init_stack(&cl);
 
-	if (c->shrink.list.next)
-		unregister_shrinker(&c->shrink);
+	if (c->shrink->list.next)
+		unregister_and_free_shrinker(c->shrink);
 
 	mutex_lock(&c->bucket_lock);
 
@@ -828,14 +828,19 @@ int bch_btree_cache_alloc(struct cache_set *c)
 		c->verify_data = NULL;
 #endif
 
-	c->shrink.count_objects = bch_mca_count;
-	c->shrink.scan_objects = bch_mca_scan;
-	c->shrink.seeks = 4;
-	c->shrink.batch = c->btree_pages * 2;
+	c->shrink = shrinker_alloc_and_init(bch_mca_count, bch_mca_scan,
+					    c->btree_pages * 2, 4, 0, c);
+	if (!c->shrink) {
+		pr_warn("bcache: %s: could not allocate shrinker\n",
+				__func__);
+		return -ENOMEM;
+	}
 
-	if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
+	if (register_shrinker(c->shrink, "md-bcache:%pU", c->set_uuid)) {
 		pr_warn("bcache: %s: could not register shrinker\n",
 				__func__);
+		shrinker_free(c->shrink);
+	}
 
 	return 0;
 }
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index c6f677059214..771577581f52 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -866,7 +866,7 @@ STORE(__bch_cache_set)
 
 		sc.gfp_mask = GFP_KERNEL;
 		sc.nr_to_scan = strtoul_or_return(buf);
-		c->shrink.scan_objects(&c->shrink, &sc);
+		c->shrink->scan_objects(c->shrink, &sc);
 	}
 
 	sysfs_strtoul_clamp(congested_read_threshold_us,
-- 
2.30.2

