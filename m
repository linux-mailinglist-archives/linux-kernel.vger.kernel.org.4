Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0611C5F4DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJECkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJECkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:40:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2853D09
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:40:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so495869pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2ldirlHW/bqumOOMqCAOQKJNqbk5ea09l+ng8hK5Jrw=;
        b=E0HioGtE495MshKKZWvw4odlvQR7s9Z5ne3/Km+M/hJQIfwWoHjTzRysM1AZ6xOHMR
         IBjnWL7aP60hidEnBsDjzroSi2fQSBRRvoV0L+fdbcd1ZJuLtLjE0OVl4MmhbKT0QZWW
         9PA9tukgTAk+q3L7sczEH3rsRq//iNzu4/p5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2ldirlHW/bqumOOMqCAOQKJNqbk5ea09l+ng8hK5Jrw=;
        b=wI8itFL+Aepp4hlO/qFQnhpVZaONfh69PO9dGMhkt2iaSlEVoffD2Av8cUSaVs2+g0
         2SeDS8jV2kkSdNdEEru1jM62fZ4V5LXoikmrs8m6ar/ycP313Xg25VEjQx5COJQ8rSD8
         2vYruVCLtb68KU2z5eu9qeGhp0a8e/pxMgdAfKRKgcRUpICse3vTNHldijdOMaZaLyWb
         rs0a0inSQZL8F8+oyNT8QX3V/Ud7a4LXfB2TK/YhVA12HJ7uez8D+0Yoo+LYW8A6Djf3
         V3ID84eq3TIDZSKceMJ5xSyEY2JWAZFuIDSyMpovOqA3/dYuRkslc+2BZo9f4Hi41kaC
         K+FA==
X-Gm-Message-State: ACrzQf0BA1k/xNW9eEKBZCMckmHxFXkeoLH5owLzegMQ0W0z6+q7QgzU
        izfkWRLg2vzcOqlYvey2huWUVw==
X-Google-Smtp-Source: AMsMyM4e2jHH5e7/5+FrjgXccrWcGMZ+CGRT7W7wOetcAdt0ey0+KVLFKVaDficjROwIE+/bGMzOmA==
X-Received: by 2002:a17:902:9684:b0:17e:71b2:bd16 with SMTP id n4-20020a170902968400b0017e71b2bd16mr16382234plp.163.1664937632242;
        Tue, 04 Oct 2022 19:40:32 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a9d9:6396:ee12:8be8])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b00561e010a309sm1673579pfl.19.2022.10.04.19.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 19:40:31 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 4/8] zram: Introduce recompress sysfs knob
Date:   Wed,  5 Oct 2022 11:40:10 +0900
Message-Id: <20221005024014.22914-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221005024014.22914-1-senozhatsky@chromium.org>
References: <20221005024014.22914-1-senozhatsky@chromium.org>
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
pages. We support three modes:

1) IDLE pages recompression is activated by `idle` mode

	echo idle > /sys/block/zram0/recompress

2) Since there may be many idle pages user-space may pass a size
watermark value and we will recompress IDLE pages only of equal
or greater size:

	echo 888 > /sys/block/zram0/recompress

3) HUGE pages recompression is activated by `huge` mode

	echo huge > /sys/block/zram0/recompress

4) HUGE_IDLE pages recompression is activated by `huge_idle` mode

	echo huge_idle > /sys/block/zram0/recompress

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig    |  12 +++
 drivers/block/zram/zram_drv.c | 192 +++++++++++++++++++++++++++++++++-
 drivers/block/zram/zram_drv.h |   2 +
 3 files changed, 203 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index d4100b0c083e..7febf36e93eb 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -78,3 +78,15 @@ config ZRAM_MEMORY_TRACKING
 	  /sys/kernel/debug/zram/zramX/block_state.
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
+
+config ZRAM_MULTI_COMP
+	bool "Enable multiple per-CPU compression streams"
+	depends on ZRAM
+	help
+	This will enable per-CPU multi-compression streams, so that ZRAM
+	can re-compress IDLE/huge pages, using a potentially slower but
+	more effective compression algorithm. Note, that IDLE page support
+	requires ZRAM_MEMORY_TRACKING.
+
+          echo TIMEOUT > /sys/block/zramX/idle
+          echo SIZE > /sys/block/zramX/recompress
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9ec60deeb186..aacabaefb0c7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1282,6 +1282,12 @@ static void zram_free_page(struct zram *zram, size_t index)
 		atomic64_dec(&zram->stats.huge_pages);
 	}
 
+	if (zram_test_flag(zram, index, ZRAM_RECOMP))
+		zram_clear_flag(zram, index, ZRAM_RECOMP);
+
+	if (zram_test_flag(zram, index, ZRAM_RECOMP_SKIP))
+		zram_clear_flag(zram, index, ZRAM_RECOMP_SKIP);
+
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
 		free_block_bdev(zram, zram_get_element(zram, index));
@@ -1347,6 +1353,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 	unsigned long handle;
 	unsigned int size;
 	void *src, *dst;
+	u32 idx;
 	int ret;
 
 	handle = zram_get_handle(zram, index);
@@ -1363,8 +1370,13 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	size = zram_get_obj_size(zram, index);
 
-	if (size != PAGE_SIZE)
-		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
+	if (size != PAGE_SIZE) {
+		idx = ZRAM_PRIMARY_ZCOMP;
+		if (zram_test_flag(zram, index, ZRAM_RECOMP))
+			idx = ZRAM_SECONDARY_ZCOMP;
+
+		zstrm = zcomp_stream_get(zram->comps[idx]);
+	}
 
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
@@ -1376,7 +1388,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
+		zcomp_stream_put(zram->comps[idx]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
 	return ret;
@@ -1602,6 +1614,178 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	return ret;
 }
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+/*
+ * This function will decompress (unless it's ZRAM_HUGE) the page and then
+ * attempt to compress it using secondary compression algorithm (which is
+ * potentially more effective).
+ *
+ * Corresponding ZRAM slot should be locked.
+ */
+static int zram_recompress(struct zram *zram,
+			   u32 index,
+			   struct page *page,
+			   int size_watermark)
+{
+	unsigned long handle_prev;
+	unsigned long handle_next;
+	unsigned int comp_len_next;
+	unsigned int  comp_len_prev;
+	struct zcomp_strm *zstrm;
+	void *src, *dst;
+	int ret;
+
+	handle_prev = zram_get_handle(zram, index);
+	if (!handle_prev)
+		return -EINVAL;
+
+	comp_len_prev = zram_get_obj_size(zram, index);
+	/*
+	 * Do not recompress objects that are already "small enough".
+	 */
+	if (comp_len_prev < size_watermark)
+		return 0;
+
+	ret = zram_read_from_zspool(zram, page, index);
+	if (ret)
+		return ret;
+
+	zstrm = zcomp_stream_get(zram->comps[ZRAM_SECONDARY_ZCOMP]);
+	src = kmap_atomic(page);
+	ret = zcomp_compress(zstrm, src, &comp_len_next);
+	kunmap_atomic(src);
+
+	/*
+	 * Either a compression error or we failed to compressed the object
+	 * in a way that will save us memory. Mark the object so that we
+	 * don't attemp to re-compress it again (RECOMP_SKIP).
+	 */
+	if (comp_len_next >= huge_class_size ||
+	    comp_len_next >= comp_len_prev ||
+	    ret) {
+		zram_set_flag(zram, index, ZRAM_RECOMP_SKIP);
+		zram_clear_flag(zram, index, ZRAM_IDLE);
+		zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
+		return ret;
+	}
+
+	/*
+	 * No direct reclaim (slow path) for handle allocation and no
+	 * re-compression attempt (unlike in __zram_bvec_write()) since
+	 * we already stored that object in zsmalloc. If we cannot alloc
+	 * memory then me bail out.
+	 */
+	handle_next = zs_malloc(zram->mem_pool, comp_len_next,
+				__GFP_KSWAPD_RECLAIM |
+				__GFP_NOWARN |
+				__GFP_HIGHMEM |
+				__GFP_MOVABLE);
+	if (IS_ERR((void *)handle_next)) {
+		zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
+		return -ENOMEM;
+	}
+
+	dst = zs_map_object(zram->mem_pool, handle_next, ZS_MM_WO);
+	memcpy(dst, zstrm->buffer, comp_len_next);
+	zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
+
+	zs_unmap_object(zram->mem_pool, handle_next);
+
+	zram_free_page(zram, index);
+	zram_set_handle(zram, index, handle_next);
+	zram_set_obj_size(zram, index, comp_len_next);
+
+	zram_set_flag(zram, index, ZRAM_RECOMP);
+	atomic64_add(comp_len_next, &zram->stats.compr_data_size);
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
+				const char *buf,
+				size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long index;
+	struct page *page;
+	ssize_t ret = 0;
+	int mode, size_watermark = 0;
+
+	if (sysfs_streq(buf, "idle")) {
+		mode = RECOMPRESS_IDLE;
+	} else if (sysfs_streq(buf, "huge")) {
+		mode = RECOMPRESS_HUGE;
+	} else if (sysfs_streq(buf, "huge_idle")) {
+		mode = RECOMPRESS_IDLE | RECOMPRESS_HUGE;
+	} else {
+		/*
+		 * We will re-compress only idle objects equal or greater
+		 * in size than watermark.
+		 */
+		ret = kstrtoint(buf, 10, &size_watermark);
+		if (ret)
+			return ret;
+		mode = RECOMPRESS_IDLE;
+	}
+
+	if (size_watermark > PAGE_SIZE)
+		return ret;
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
+	for (index = 0; index < nr_pages; index++) {
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
+		    zram_test_flag(zram, index, ZRAM_RECOMP) ||
+		    zram_test_flag(zram, index, ZRAM_RECOMP_SKIP))
+			goto next;
+
+		ret = zram_recompress(zram, index, page, size_watermark);
+next:
+		zram_slot_unlock(zram, index);
+		if (ret)
+			break;
+	}
+
+	ret = len;
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
@@ -1982,6 +2166,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
+static DEVICE_ATTR_WO(recompress);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -2008,6 +2193,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_debug_stat.attr,
 #ifdef CONFIG_ZRAM_MULTI_COMP
 	&dev_attr_recomp_algorithm.attr,
+	&dev_attr_recompress.attr,
 #endif
 	NULL,
 };
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4044ddbb2326..09b9ceb5dfa3 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -49,6 +49,8 @@ enum zram_pageflags {
 	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
+	ZRAM_RECOMP,	/* page was recompressed */
+	ZRAM_RECOMP_SKIP, /* secondary algorithm cannot compress this page */
 
 	__NR_ZRAM_PAGEFLAGS,
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog

