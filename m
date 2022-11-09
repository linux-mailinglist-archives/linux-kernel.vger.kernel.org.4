Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B55622AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKILvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiKILvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:07 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DF32EF22
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:05 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 6so7882208pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n33F25aQVl5gMALLYTt7F+KllpnjMjEm9LlYHN1WT00=;
        b=Rh2BlWtYS21q0RL18T9fNl9H/b1v7TFvFlPRO/DpVHp+5NppILseTVaEWsK9ZpAFR2
         gVvXlR10W5bORh+1bAKmeuf2JHm7eYWkze5Ysg4+LSwQNlYj+PoCgz4bUzxa2VNBInas
         fd0c3WKvxwSED3juQz7UrslELXMc/sBuqQy7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n33F25aQVl5gMALLYTt7F+KllpnjMjEm9LlYHN1WT00=;
        b=ylyjj/BqHO0Gd9dkd6K2cvIQtnyvyUFk8DvQ76yAMVI7qLhBqznUeo8ev0eZFR7jjd
         EontwDhVpCuhjqOhqQXbKxIRtoPej5ddDJ2GcnZQ+DL4kXbZKkAbWXFz8Rh+6P9FD+lY
         t0HjzeWYdExw1ELzq62Aqhd+5OzFStZVprOidXC1+q6xo6qPhHC9d2882KqJyfA0N0vT
         rz3lfbmdw5g1ZzVOJCDCodZDTHqRuQWv9Mw765mEAh+q91scL09avqXJRCjqD0k+pTBn
         P2/hjaJpRwMI5Mt/9VCEcdronITSNsnldpQPlJjMRbBctNkw6lXml2JxeW5hzdG9YGnM
         lXfg==
X-Gm-Message-State: ACrzQf1nTh5etVX09XLzypUpK9GH7foGzNHW1rDGS19gF1ZJ2s1nRlYg
        XcyRCI63+ix27OsR++q2fq28bw==
X-Google-Smtp-Source: AMsMyM7p8pimAY7i/uNHTUklIfUHS9rEp4bNx9mbfWjFZIjoKxPIfq1X7n0uEgwxpOt6ckLrwn/gOQ==
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id d15-20020a056a0010cf00b0052848c379e0mr60134369pfu.18.1667994665061;
        Wed, 09 Nov 2022 03:51:05 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:04 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 04/13] zram: Introduce recompress sysfs knob
Date:   Wed,  9 Nov 2022 20:50:38 +0900
Message-Id: <20221109115047.2921851-5-senozhatsky@chromium.org>
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

Allow zram to recompress (using secondary compression streams)
pages.

Re-compression algorithms (we support up to 3 at this stage)
are selected via recomp_algorithm:

  echo "algo=zstd priority=1" > /sys/block/zramX/recomp_algorithm

Please read documentation for more details.

We support several recompression modes:

1) IDLE pages recompression is activated by `idle` mode

  echo "type=idle" > /sys/block/zram0/recompress

2) Since there may be many idle pages user-space may pass a size
threshold value (in bytes) and we will recompress pages only
of equal or greater size:

  echo "threshold=888" > /sys/block/zram0/recompress

3) HUGE pages recompression is activated by `huge` mode

  echo "type=huge" > /sys/block/zram0/recompress

4) HUGE_IDLE pages recompression is activated by `huge_idle` mode

  echo "type=huge_idle" > /sys/block/zram0/recompress

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig    |   9 ++
 drivers/block/zram/zram_drv.c | 264 +++++++++++++++++++++++++++++++++-
 drivers/block/zram/zram_drv.h |   7 +
 3 files changed, 277 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index d4100b0c083e..0386b7da02aa 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -78,3 +78,12 @@ config ZRAM_MEMORY_TRACKING
 	  /sys/kernel/debug/zram/zramX/block_state.
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
+
+config ZRAM_MULTI_COMP
+	bool "Enable multiple compression streams"
+	depends on ZRAM
+	help
+	  This will enable multi-compression streams, so that ZRAM can
+	  re-compress pages using a potentially slower but more effective
+	  compression algorithm. Note, that IDLE page recompression
+	  requires ZRAM_MEMORY_TRACKING.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a6a5fd2474d7..749e4266dd72 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -155,6 +155,25 @@ static inline bool is_partial_io(struct bio_vec *bvec)
 }
 #endif
 
+static inline void zram_set_priority(struct zram *zram, u32 index, u32 prio)
+{
+	prio &= ZRAM_COMP_PRIORITY_MASK;
+	/*
+	 * Clear previous priority value first, in case if we recompress
+	 * further an already recompressed page
+	 */
+	zram->table[index].flags &= ~(ZRAM_COMP_PRIORITY_MASK <<
+				      ZRAM_COMP_PRIORITY_BIT1);
+	zram->table[index].flags |= (prio << ZRAM_COMP_PRIORITY_BIT1);
+}
+
+static inline u32 zram_get_priority(struct zram *zram, u32 index)
+{
+	u32 prio = zram->table[index].flags >> ZRAM_COMP_PRIORITY_BIT1;
+
+	return prio & ZRAM_COMP_PRIORITY_MASK;
+}
+
 /*
  * Check if request is within bounds and aligned on zram logical blocks.
  */
@@ -1307,6 +1326,11 @@ static void zram_free_page(struct zram *zram, size_t index)
 		atomic64_dec(&zram->stats.huge_pages);
 	}
 
+	if (zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+		zram_clear_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+
+	zram_set_priority(zram, index, 0);
+
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
 		free_block_bdev(zram, zram_get_element(zram, index));
@@ -1367,6 +1391,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 	unsigned long handle;
 	unsigned int size;
 	void *src, *dst;
+	u32 prio;
 	int ret;
 
 	handle = zram_get_handle(zram, index);
@@ -1383,8 +1408,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	size = zram_get_obj_size(zram, index);
 
-	if (size != PAGE_SIZE)
-		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
+	if (size != PAGE_SIZE) {
+		prio = zram_get_priority(zram, index);
+		zstrm = zcomp_stream_get(zram->comps[prio]);
+	}
 
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
@@ -1396,7 +1423,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zram->comps[prio]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
 	return ret;
@@ -1627,6 +1654,235 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	return ret;
 }
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+/*
+ * This function will decompress (unless it's ZRAM_HUGE) the page and then
+ * attempt to compress it using provided compression algorithm priority
+ * (which is potentially more effective).
+ *
+ * Corresponding ZRAM slot should be locked.
+ */
+static int zram_recompress(struct zram *zram, u32 index, struct page *page,
+			   u32 threshold, u32 prio, u32 prio_max)
+{
+	struct zcomp_strm *zstrm = NULL;
+	unsigned long handle_old;
+	unsigned long handle_new;
+	unsigned int comp_len_old;
+	unsigned int comp_len_new;
+	void *src, *dst;
+	int ret;
+
+	handle_old = zram_get_handle(zram, index);
+	if (!handle_old)
+		return -EINVAL;
+
+	comp_len_old = zram_get_obj_size(zram, index);
+	/*
+	 * Do not recompress objects that are already "small enough".
+	 */
+	if (comp_len_old < threshold)
+		return 0;
+
+	ret = zram_read_from_zspool(zram, page, index);
+	if (ret)
+		return ret;
+
+	/*
+	 * Iterate the secondary comp algorithms list (in order of priority)
+	 * and try to recompress the page.
+	 */
+	for (; prio < prio_max; prio++) {
+		if (!zram->comps[prio])
+			continue;
+
+		/*
+		 * Skip if the object is already re-compressed with a higher
+		 * priority algorithm (or same algorithm).
+		 */
+		if (prio <= zram_get_priority(zram, index))
+			continue;
+
+		zstrm = zcomp_stream_get(zram->comps[prio]);
+		src = kmap_atomic(page);
+		ret = zcomp_compress(zstrm, src, &comp_len_new);
+		kunmap_atomic(src);
+
+		if (ret) {
+			zcomp_stream_put(zram->comps[prio]);
+			return ret;
+		}
+
+		/* Continue until we make progress */
+		if (comp_len_new >= huge_class_size ||
+		    comp_len_new >= comp_len_old ||
+		    (threshold && comp_len_new >= threshold)) {
+			zcomp_stream_put(zram->comps[prio]);
+			continue;
+		}
+
+		/* Recompression was successful so break out */
+		break;
+	}
+
+	/*
+	 * We did not try to recompress, e.g. when we have only one
+	 * secondary algorithm and the page is already recompressed
+	 * using that algorithm
+	 */
+	if (!zstrm)
+		return 0;
+
+	/*
+	 * All secondary algorithms failed to re-compress the page in a way
+	 * that would save memory, mark the object as incompressible so that
+	 * we will not try to compress it again.
+	 */
+	if (comp_len_new >= huge_class_size || comp_len_new >= comp_len_old) {
+		zram_set_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+		return 0;
+	}
+
+	/* Successful recompression but above threshold */
+	if (threshold && comp_len_new >= threshold)
+		return 0;
+
+	/*
+	 * No direct reclaim (slow path) for handle allocation and no
+	 * re-compression attempt (unlike in __zram_bvec_write()) since
+	 * we already have stored that object in zsmalloc. If we cannot
+	 * alloc memory for recompressed object then we bail out and
+	 * simply keep the old (existing) object in zsmalloc.
+	 */
+	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
+			       __GFP_KSWAPD_RECLAIM |
+			       __GFP_NOWARN |
+			       __GFP_HIGHMEM |
+			       __GFP_MOVABLE);
+	if (IS_ERR_VALUE(handle_new)) {
+		zcomp_stream_put(zram->comps[prio]);
+		return PTR_ERR((void *)handle_new);
+	}
+
+	dst = zs_map_object(zram->mem_pool, handle_new, ZS_MM_WO);
+	memcpy(dst, zstrm->buffer, comp_len_new);
+	zcomp_stream_put(zram->comps[prio]);
+
+	zs_unmap_object(zram->mem_pool, handle_new);
+
+	zram_free_page(zram, index);
+	zram_set_handle(zram, index, handle_new);
+	zram_set_obj_size(zram, index, comp_len_new);
+	zram_set_priority(zram, index, prio);
+
+	atomic64_add(comp_len_new, &zram->stats.compr_data_size);
+	atomic64_inc(&zram->stats.pages_stored);
+
+	return 0;
+}
+
+#define RECOMPRESS_IDLE		(1 << 0)
+#define RECOMPRESS_HUGE		(1 << 1)
+
+static ssize_t recompress_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u32 mode = 0, threshold = 0, prio = ZRAM_SECONDARY_COMP;
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	char *args, *param, *val;
+	unsigned long index;
+	struct page *page;
+	ssize_t ret;
+
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		if (!*val)
+			return -EINVAL;
+
+		if (!strcmp(param, "type")) {
+			if (!strcmp(val, "idle"))
+				mode = RECOMPRESS_IDLE;
+			if (!strcmp(val, "huge"))
+				mode = RECOMPRESS_HUGE;
+			if (!strcmp(val, "huge_idle"))
+				mode = RECOMPRESS_IDLE | RECOMPRESS_HUGE;
+			continue;
+		}
+
+		if (!strcmp(param, "threshold")) {
+			/*
+			 * We will re-compress only idle objects equal or
+			 * greater in size than watermark.
+			 */
+			ret = kstrtouint(val, 10, &threshold);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+
+	if (threshold >= PAGE_SIZE)
+		return -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		ret = -EINVAL;
+		goto release_init_lock;
+	}
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	ret = len;
+	for (index = 0; index < nr_pages; index++) {
+		int err;
+
+		zram_slot_lock(zram, index);
+
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		if (mode & RECOMPRESS_IDLE &&
+		    !zram_test_flag(zram, index, ZRAM_IDLE))
+			goto next;
+
+		if (mode & RECOMPRESS_HUGE &&
+		    !zram_test_flag(zram, index, ZRAM_HUGE))
+			goto next;
+
+		if (zram_test_flag(zram, index, ZRAM_WB) ||
+		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
+		    zram_test_flag(zram, index, ZRAM_SAME) ||
+		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+			goto next;
+
+		err = zram_recompress(zram, index, page, threshold,
+				      prio, ZRAM_MAX_COMPS);
+next:
+		zram_slot_unlock(zram, index);
+		if (err) {
+			ret = err;
+			break;
+		}
+
+		cond_resched();
+	}
+
+	__free_page(page);
+
+release_init_lock:
+	up_read(&zram->init_lock);
+	return ret;
+}
+#endif
+
 /*
  * zram_bio_discard - handler on discard request
  * @index: physical block index in PAGE_SIZE units
@@ -2006,6 +2262,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
+static DEVICE_ATTR_WO(recompress);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -2032,6 +2289,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_debug_stat.attr,
 #ifdef CONFIG_ZRAM_MULTI_COMP
 	&dev_attr_recomp_algorithm.attr,
+	&dev_attr_recompress.attr,
 #endif
 	NULL,
 };
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 7a643c8c38ec..b80faae76835 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -40,6 +40,9 @@
  */
 #define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
 
+/* Only 2 bits are allowed for comp priority index */
+#define ZRAM_COMP_PRIORITY_MASK	0x3
+
 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
 	/* zram slot is locked */
@@ -49,6 +52,10 @@ enum zram_pageflags {
 	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
+	ZRAM_INCOMPRESSIBLE, /* none of the algorithms could compress it */
+
+	ZRAM_COMP_PRIORITY_BIT1, /* First bit of comp priority index */
+	ZRAM_COMP_PRIORITY_BIT2, /* Second bit of comp priority index */
 
 	__NR_ZRAM_PAGEFLAGS,
 };
-- 
2.38.1.431.g37b22c650d-goog

