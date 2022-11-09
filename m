Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD80A622AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKILvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiKILu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:50:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86571C126
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:50:57 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so1664003pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh+SDXfLWIiVuWyo4HoAJrWsmodyn/AWQvoZfxriBos=;
        b=lg6XyX6EZCivsCvPp8F8Rk6MdzQU/pZ+5B2QkiAgYr9uOdlZI8FpXbs7pOWgOxaC27
         Ha1xmVXR8wH+qelEb8KwopTpXVQWggLiLk+qU61M2tVtEFOJ5v89IAhpSrgx7rGO6XZ+
         rZpDnypFeVyF+dtrNl7DFImc7xwrivwZmV2cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh+SDXfLWIiVuWyo4HoAJrWsmodyn/AWQvoZfxriBos=;
        b=uWIAKB7WRY04P4cHtI/pXPlm2LF0ITeI/OvxEnBI+ifCpqVuifLd3Uuv4BtDSmd4yN
         pw7kRFLW1y4wiMJWh7b3D7WhOvic5NnRJtMZf8W9DoOWftQMlQdirJturA6HWQWlGq4Y
         uZTbjm/d24ejQRkD+grdy2Xl2YFv1TX036NOftuESZpdKrXGKZHX60Jjgys/PqQu+aPq
         nPy3ZlFYGXkPIoQOIujNrV/qNZwfEFGYXeypu3limt17oGQ+x4YSi+aQwDJmZ0a6ma+8
         tmcwe72433+x/xfrOhOk+9tgV4qjd/EpAnYLBTRQrjKYIcysAuxtThmvLcfaqr2dG0qb
         x7/Q==
X-Gm-Message-State: ACrzQf2dwkBflrSrpRp5iDL036kwnkyY4WT95UyVrHDx5MvzM+o7Dtht
        yJHDu7bFnpEM+fDvz5txRmxs3g==
X-Google-Smtp-Source: AMsMyM5ap4cnFJgQIJB7Qd+V3iIFej6hsh6xDMaaJARu3Yb9BdtCqFiYi2/jyzLy7wFP2TGgAFTMcA==
X-Received: by 2002:a17:903:11cd:b0:170:cde8:18b7 with SMTP id q13-20020a17090311cd00b00170cde818b7mr44212976plh.165.1667994657224;
        Wed, 09 Nov 2022 03:50:57 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:50:56 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 01/13] zram: Preparation for multi-zcomp support
Date:   Wed,  9 Nov 2022 20:50:35 +0900
Message-Id: <20221109115047.2921851-2-senozhatsky@chromium.org>
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

The patch turns compression streams and compressor algorithm
name struct zram members into arrays, so that we can have
multiple compression streams support (in the next patches).

The patch uses a rather explicit API for compressor selection:

- Get primary (default) compression stream
	zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP])
- Get secondary compression stream
	zcomp_stream_get(zram->comps[ZRAM_SECONDARY_COMP])

We use similar API for compression streams put().

At this point we always have just one compression stream,
since CONFIG_ZRAM_MULTI_COMP is not yet defined.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    |  6 +--
 drivers/block/zram/zcomp.h    |  2 +-
 drivers/block/zram/zram_drv.c | 90 +++++++++++++++++++++++++----------
 drivers/block/zram/zram_drv.h | 14 +++++-
 4 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 0916de952e09..55af4efd7983 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -206,7 +206,7 @@ void zcomp_destroy(struct zcomp *comp)
  * case of allocation error, or any other error potentially
  * returned by zcomp_init().
  */
-struct zcomp *zcomp_create(const char *compress)
+struct zcomp *zcomp_create(const char *alg)
 {
 	struct zcomp *comp;
 	int error;
@@ -216,14 +216,14 @@ struct zcomp *zcomp_create(const char *compress)
 	 * is not loaded yet. We must do it here, otherwise we are about to
 	 * call /sbin/modprobe under CPU hot-plug lock.
 	 */
-	if (!zcomp_available_algorithm(compress))
+	if (!zcomp_available_algorithm(alg))
 		return ERR_PTR(-EINVAL);
 
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
 
-	comp->name = compress;
+	comp->name = alg;
 	error = zcomp_init(comp);
 	if (error) {
 		kfree(comp);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 40f6420f4b2e..cdefdef93da8 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -27,7 +27,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
 bool zcomp_available_algorithm(const char *comp);
 
-struct zcomp *zcomp_create(const char *comp);
+struct zcomp *zcomp_create(const char *alg);
 void zcomp_destroy(struct zcomp *comp);
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 966aab902d19..5371ed63c785 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1007,36 +1007,53 @@ static ssize_t comp_algorithm_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->compressor, buf);
+	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_COMP], buf);
 	up_read(&zram->init_lock);
 
 	return sz;
 }
 
+static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
+{
+	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
+	if (zram->comp_algs[prio] != default_compressor)
+		kfree(zram->comp_algs[prio]);
+	zram->comp_algs[prio] = alg;
+}
+
 static ssize_t comp_algorithm_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	char compressor[ARRAY_SIZE(zram->compressor)];
+	char *compressor;
 	size_t sz;
 
-	strscpy(compressor, buf, sizeof(compressor));
+	sz = strlen(buf);
+	if (sz >= CRYPTO_MAX_ALG_NAME)
+		return -E2BIG;
+
+	compressor = kstrdup(buf, GFP_KERNEL);
+	if (!compressor)
+		return -ENOMEM;
+
 	/* ignore trailing newline */
-	sz = strlen(compressor);
 	if (sz > 0 && compressor[sz - 1] == '\n')
 		compressor[sz - 1] = 0x00;
 
-	if (!zcomp_available_algorithm(compressor))
+	if (!zcomp_available_algorithm(compressor)) {
+		kfree(compressor);
 		return -EINVAL;
+	}
 
 	down_write(&zram->init_lock);
 	if (init_done(zram)) {
 		up_write(&zram->init_lock);
+		kfree(compressor);
 		pr_info("Can't change algorithm for initialized device\n");
 		return -EBUSY;
 	}
 
-	strcpy(zram->compressor, compressor);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, compressor);
 	up_write(&zram->init_lock);
 	return len;
 }
@@ -1284,7 +1301,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	size = zram_get_obj_size(zram, index);
 
 	if (size != PAGE_SIZE)
-		zstrm = zcomp_stream_get(zram->comp);
+		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
@@ -1296,7 +1313,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
 	zram_slot_unlock(zram, index);
@@ -1363,13 +1380,13 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	kunmap_atomic(mem);
 
 compress_again:
-	zstrm = zcomp_stream_get(zram->comp);
+	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	src = kmap_atomic(page);
 	ret = zcomp_compress(zstrm, src, &comp_len);
 	kunmap_atomic(src);
 
 	if (unlikely(ret)) {
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		pr_err("Compression failed! err=%d\n", ret);
 		zs_free(zram->mem_pool, handle);
 		return ret;
@@ -1397,7 +1414,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 				__GFP_HIGHMEM |
 				__GFP_MOVABLE);
 	if (IS_ERR((void *)handle)) {
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
@@ -1414,14 +1431,14 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		 * zstrm buffer back. It is necessary that the dereferencing
 		 * of the zstrm variable below occurs correctly.
 		 */
-		zstrm = zcomp_stream_get(zram->comp);
+		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	}
 
 	alloced_pages = zs_get_total_pages(zram->mem_pool);
 	update_used_max(zram, alloced_pages);
 
 	if (zram->limit_pages && alloced_pages > zram->limit_pages) {
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
@@ -1435,7 +1452,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	if (comp_len == PAGE_SIZE)
 		kunmap_atomic(src);
 
-	zcomp_stream_put(zram->comp);
+	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
 out:
@@ -1710,6 +1727,20 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 
+static void zram_destroy_comps(struct zram *zram)
+{
+	u32 prio;
+
+	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
+		struct zcomp *comp = zram->comps[prio];
+
+		zram->comps[prio] = NULL;
+		if (!comp)
+			continue;
+		zcomp_destroy(comp);
+	}
+}
+
 static void zram_reset_device(struct zram *zram)
 {
 	down_write(&zram->init_lock);
@@ -1727,11 +1758,11 @@ static void zram_reset_device(struct zram *zram)
 	/* I/O operation under all of CPU are done so let's free */
 	zram_meta_free(zram, zram->disksize);
 	zram->disksize = 0;
+	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	zcomp_destroy(zram->comp);
-	zram->comp = NULL;
 	reset_bdev(zram);
 
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 	up_write(&zram->init_lock);
 }
 
@@ -1742,6 +1773,7 @@ static ssize_t disksize_store(struct device *dev,
 	struct zcomp *comp;
 	struct zram *zram = dev_to_zram(dev);
 	int err;
+	u32 prio;
 
 	disksize = memparse(buf, NULL);
 	if (!disksize)
@@ -1760,22 +1792,28 @@ static ssize_t disksize_store(struct device *dev,
 		goto out_unlock;
 	}
 
-	comp = zcomp_create(zram->compressor);
-	if (IS_ERR(comp)) {
-		pr_err("Cannot initialise %s compressing backend\n",
-				zram->compressor);
-		err = PTR_ERR(comp);
-		goto out_free_meta;
-	}
+	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
+		if (!zram->comp_algs[prio])
+			continue;
+
+		comp = zcomp_create(zram->comp_algs[prio]);
+		if (IS_ERR(comp)) {
+			pr_err("Cannot initialise %s compressing backend\n",
+			       zram->comp_algs[prio]);
+			err = PTR_ERR(comp);
+			goto out_free_comps;
+		}
 
-	zram->comp = comp;
+		zram->comps[prio] = comp;
+	}
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
 
 	return len;
 
-out_free_meta:
+out_free_comps:
+	zram_destroy_comps(zram);
 	zram_meta_free(zram, disksize);
 out_unlock:
 	up_write(&zram->init_lock);
@@ -1962,7 +2000,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	strscpy(zram->compressor, default_compressor, sizeof(zram->compressor));
+	zram->comp_algs[ZRAM_PRIMARY_COMP] = default_compressor;
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index a2bda53020fd..7a643c8c38ec 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -89,10 +89,20 @@ struct zram_stats {
 #endif
 };
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+#define ZRAM_PRIMARY_COMP	0U
+#define ZRAM_SECONDARY_COMP	1U
+#define ZRAM_MAX_COMPS	4U
+#else
+#define ZRAM_PRIMARY_COMP	0U
+#define ZRAM_SECONDARY_COMP	0U
+#define ZRAM_MAX_COMPS	1U
+#endif
+
 struct zram {
 	struct zram_table_entry *table;
 	struct zs_pool *mem_pool;
-	struct zcomp *comp;
+	struct zcomp *comps[ZRAM_MAX_COMPS];
 	struct gendisk *disk;
 	/* Prevent concurrent execution of device init */
 	struct rw_semaphore init_lock;
@@ -107,7 +117,7 @@ struct zram {
 	 * we can store in a disk.
 	 */
 	u64 disksize;	/* bytes */
-	char compressor[CRYPTO_MAX_ALG_NAME];
+	const char *comp_algs[ZRAM_MAX_COMPS];
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.38.1.431.g37b22c650d-goog

