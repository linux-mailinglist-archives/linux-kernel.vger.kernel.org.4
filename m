Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD55F8A4B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJIJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJIJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:08:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37AB31DC8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:07:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so8052804pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Di6UYGr5o/GSN0ajTLtFClQB+xSRVwulRo8S0QrCcKI=;
        b=YhyVT+feaZTJaqgGyJt76SZs2ZcBpZEPkuaHpuvXaOtZOmphmqZgRaqvn3DYi0upEy
         t7yOIzNZs2gRP6fJS3kskvr4gH1ZoYrzP7/REgxqXRLm3i0Mufst4j2XcMHo7KeKIEop
         n/7EanSxuX44lUiLBTUef0T6xqzl8TmCaeIvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Di6UYGr5o/GSN0ajTLtFClQB+xSRVwulRo8S0QrCcKI=;
        b=zZueOjiU3WBBsUhwKz850sMNxQB4E6ygp57xnajYLcvQ97j27eOptTQshOwO1U6J+k
         JthwWMlebvpLz48jBME6VqwjTOZOKR6TO8ea9vPZ05rykIFLm2Eb/ypdgnlHu8Fj2hvP
         iQEexzl9EUjr3DLBb6VGHWRDNLzBD7xPAHr/Io1qNFAbIVCvEm8XhdqbfTwlYGJjT+vU
         B8vZ3tSRPv0FQOIRhX8qY6r0P8TzXEMpSu47EHQFpYk9p7En4Ck2G8pqfe9xuWUi2jR4
         KBXzwIp5ONV1Hix8sDdnkNZoTVpciN1qPSwwqTgkz6kpWXWS+RIVa1fv0JYWIxXfklNL
         6KFw==
X-Gm-Message-State: ACrzQf1ncO62xWe03szIhynqMNlaxNuvMw0LNDM4BAwLwLRVpG55MaeV
        0j4bcdzsWrjZLCbf4sdPjx/aWIun0BFpUw==
X-Google-Smtp-Source: AMsMyM7YWoa+daGBBBz9uSUN9qJ47XLGsV80REC7vAB/6UsA5DqmTTpqUmhteFDCgPBWGb9qrzm1Yw==
X-Received: by 2002:a17:902:bd44:b0:17f:fc22:3a74 with SMTP id b4-20020a170902bd4400b0017ffc223a74mr11276401plx.161.1665306456519;
        Sun, 09 Oct 2022 02:07:36 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8517:d51e:5fe9:9be7])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm4335148pgq.43.2022.10.09.02.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:07:36 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 4/8] zram: Introduce recompress sysfs knob
Date:   Sun,  9 Oct 2022 18:07:16 +0900
Message-Id: <20221009090720.1040633-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221009090720.1040633-1-senozhatsky@chromium.org>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 194 +++++++++++++++++++++++++++++++++-
 drivers/block/zram/zram_drv.h |   2 +
 3 files changed, 205 insertions(+), 3 deletions(-)

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
index 94c62d7ea818..12368e773f3d 100644
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
@@ -1343,6 +1349,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 	unsigned long handle;
 	unsigned int size;
 	void *src, *dst;
+	u32 idx;
 	int ret;
 
 	handle = zram_get_handle(zram, index);
@@ -1359,8 +1366,13 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
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
@@ -1372,7 +1384,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
+		zcomp_stream_put(zram->comps[idx]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
 	return ret;
@@ -1603,6 +1615,180 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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
+
+		cond_resched();
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
@@ -1983,6 +2169,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
+static DEVICE_ATTR_WO(recompress);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -2009,6 +2196,7 @@ static struct attribute *zram_disk_attrs[] = {
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

