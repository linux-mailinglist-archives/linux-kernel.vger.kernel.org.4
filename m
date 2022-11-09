Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89744622AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKILvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiKILva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56813317DE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id io19so16854739plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7l0gcyZTSMtgONlgCq8JYmzNKlzJdwXwSa9TtKzHX4=;
        b=dCtnfolV7NZTjIQst7bLm+R0e8lXueKVV0v7b/QjyVHeRBIdxnvcnXoOnCxxFDvSvk
         EwwKsn9H/c3u3wxAH18AuVZrTTGa0xtsRdZ2lQvewblpJv1hQ/BJ1/cVh02T51kqwibA
         9TfwfyIhmJ1AFeRqYwaDl6PjbFd3przV0Cnok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7l0gcyZTSMtgONlgCq8JYmzNKlzJdwXwSa9TtKzHX4=;
        b=c/5Hb3R6dYADGrTTgn3PO5Zg5TRoGCR0bZNueq9tXrc/8O+Vt5uAhSQF4UHQtn4E3B
         fX+vG62L7V/P9mI6Y5EMXkOJzARWby+E7mt8q/1khebJGROotqe87b5F42ipui1sfzOR
         a4CinDWNRUvYrFjsDwsWFyfetW4ebBvFwVX4rWrezrjPzq/NqVmGnZGEOJWhdgLLc/Au
         2d1QYm0hGLnE71m7jou30sId8UzG9Vt68SWp2g4xaTD1f6eKyhRXeXqvdMhW2kluIH1e
         Dzgxk5tPe4I/A3ZRer6/D401Pa6ytsfBVrkmlA+Zg9faOcyos/e3sjamyXQjBQ7d6C0x
         Y9ig==
X-Gm-Message-State: ACrzQf2emUEp99M/24i5zognwepUNYDxoRtTUsc+V5DkhCh77pdtlKl8
        aeTTuTFN/sFHk1YdV1CkMAnyGg==
X-Google-Smtp-Source: AMsMyM7Rg2hU/k1WD6TqY27OHXzxKTED3WjneC0q/KoUbZcCmKt04o1vVWc7COK2SZU7DinwUBf6Tg==
X-Received: by 2002:a17:90a:cb03:b0:214:219:b2b9 with SMTP id z3-20020a17090acb0300b002140219b2b9mr48462292pjt.191.1667994680525;
        Wed, 09 Nov 2022 03:51:20 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:20 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 10/13] zram: Add algo parameter support to zram_recompress()
Date:   Wed,  9 Nov 2022 20:50:44 +0900
Message-Id: <20221109115047.2921851-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recompression iterates through all the registered secondary
compression algorithms in order of their priorities so that
we have higher chances of finding the algorithm that compresses
a particular page. This, however, may not always be best
approach and sometimes we may want to limit recompression to
only one particular algorithm. For instance, when a higher
priority algorithm uses too much power and device has a
relatively low battery level we may want to limit recompression
to use only a lower priority algorithm, which uses less power.

Introduce algo= parameter support to recompression sysfs knob
so that user-sapce can request recompression with particular
algorithm only:

  echo "type=idle algo=zstd" > /sys/block/zramX/recompress

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 54 +++++++++++++++++++++++++++++------
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 67b58f2255db..89d25f60b33e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1677,6 +1677,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
+	u32 num_recomps = 0;
 	void *src, *dst;
 	int ret;
 
@@ -1711,6 +1712,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		if (prio <= zram_get_priority(zram, index))
 			continue;
 
+		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_atomic(page);
 		ret = zcomp_compress(zstrm, src, &comp_len_new);
@@ -1743,13 +1745,19 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	if (!zstrm)
 		return 0;
 
-	/*
-	 * All secondary algorithms failed to re-compress the page in a way
-	 * that would save memory, mark the object as incompressible so that
-	 * we will not try to compress it again.
-	 */
 	if (class_index_new >= class_index_old) {
-		zram_set_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+		/*
+		 * Secondary algorithms failed to re-compress the page
+		 * in a way that would save memory, mark the object as
+		 * incompressible so that we will not try to compress
+		 * it again.
+		 *
+		 * We need to make sure that all secondary algorithms have
+		 * failed, so we test if the number of recompressions matches
+		 * the number of active secondary algorithms.
+		 */
+		if (num_recomps == zram->num_active_comps - 1)
+			zram_set_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 		return 0;
 	}
 
@@ -1798,10 +1806,11 @@ static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
+	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
-	u32 mode = 0, threshold = 0, prio = ZRAM_SECONDARY_COMP;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	char *args, *param, *val;
+	char *args, *param, *val, *algo = NULL;
+	u32 mode = 0, threshold = 0;
 	unsigned long index;
 	struct page *page;
 	ssize_t ret;
@@ -1833,6 +1842,11 @@ static ssize_t recompress_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "algo")) {
+			algo = val;
+			continue;
+		}
 	}
 
 	if (threshold >= PAGE_SIZE)
@@ -1844,6 +1858,26 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	if (algo) {
+		bool found = false;
+
+		for (; prio < ZRAM_MAX_COMPS; prio++) {
+			if (!zram->comp_algs[prio])
+				continue;
+
+			if (!strcmp(zram->comp_algs[prio], algo)) {
+				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			ret = -EINVAL;
+			goto release_init_lock;
+		}
+	}
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
@@ -1874,7 +1908,7 @@ static ssize_t recompress_store(struct device *dev,
 			goto next;
 
 		err = zram_recompress(zram, index, page, threshold,
-				      prio, ZRAM_MAX_COMPS);
+				      prio, prio_max);
 next:
 		zram_slot_unlock(zram, index);
 		if (err) {
@@ -2110,6 +2144,7 @@ static void zram_destroy_comps(struct zram *zram)
 		if (!comp)
 			continue;
 		zcomp_destroy(comp);
+		zram->num_active_comps--;
 	}
 }
 
@@ -2177,6 +2212,7 @@ static ssize_t disksize_store(struct device *dev,
 		}
 
 		zram->comps[prio] = comp;
+		zram->num_active_comps++;
 	}
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index b80faae76835..473325415a74 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -125,6 +125,7 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_COMPS];
+	s8 num_active_comps;
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.38.1.431.g37b22c650d-goog

