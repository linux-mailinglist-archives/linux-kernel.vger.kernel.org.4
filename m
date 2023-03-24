Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2363D6C8246
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCXQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:22:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1F0AD06
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4C6FB82548
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A943CC433D2;
        Fri, 24 Mar 2023 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679674916;
        bh=HM0bbOzJNG1g/62mAtX6up1CaeF1K5fyPRb2+lPdlCQ=;
        h=From:Date:Subject:To:Cc:From;
        b=pgxOFdqvtwz3AxNBQLeXFIOuMxSMBaAaplEtX6/n8pzYn25kK2xLinCDWjndAIxHB
         ZHQxPhQY6nP04fIodq1MNyZ/XZKgD1R69ynVplmCSFarp+zDzPK5qHAtVuvYAh6R9T
         80CKKpNDN1kT5NzDX56ikYoamvr6DoAFxLo358gW16P/4nxJ31TUVprickB/aexFvk
         XLIz89PMjI4UAbM3n/2HoSKlJGD7LkJffRMwzOKy+hcmpCPpdJeArSJELydqVC8Nuw
         rFR0IxztX36aFLlIzUUFNWLAOSl8NIdQeKY09jeokpCdCTVcJIteAh3sP8cuFPv0V5
         mCJJptX5jALjQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 24 Mar 2023 16:21:49 +0000
Subject: [PATCH] regmap: Removed compressed cache support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-regcache-lzo-v1-1-08c5d63e2a5e@kernel.org>
X-B4-Tracking: v=1; b=H4sIABzOHWQC/x2N0QqDMAwAf0XyvIBWRd2vjD2kWbRhox0puDHx3
 617vIPjNshiKhmu1QYmq2ZNsUBzqYADxUVQH4XB1a6tW9ehycLEQfD1S+ipZ99M4zCRQEk8ZUF
 vFDmc0SfZ89Rvk1m//8vtvu8HJgp0n3UAAAA=
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=12333; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HM0bbOzJNG1g/62mAtX6up1CaeF1K5fyPRb2+lPdlCQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHc4hObGg9byeWqNDN3lkpBpFkN2x+mu3APK9Btm9
 ARP9taSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZB3OIQAKCRAk1otyXVSH0OzhB/
 9Mgr5APNkyQiKYtMmRfKkJH+SX9gvUXrxABlXt54Cv6ECpSFyXn9FHrY3qR3pgUvjtuNbM5/6GWP+z
 PV2rsK/JrD2tvgWIRu8ZAZ1ayjU5SOH90f8cT6C6RBxXsMWaRmNljHhcBTQfbUGwVOLKJRRGAkVPB6
 bu4IWe5l+g0kRq+ZS6SDTOXdudipGTFBU6IDz0Gu87L8/N9YjdlMA3roX9xkXDFbV0MduHfHVeZ6Uo
 T5ItcYQYaDxMkNMuuM2Rp0w5cVKlzOggD0MGHSi2VJxDkZblGt1pQegnjVSTEyFevjzofakx6Jk7+v
 +tHCh4lyIpoNi9P3T5L3m1Ij5u4WjW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed register cache support has assumptions that make it hard to
cover in testing, mainly that it requires raw registers defaults be
provided. Rather than either address these assumptions or leave it untested
by the forthcoming KUnit tests let's remove it, the use case is quite thin
and there are no current users.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/Kconfig        |   5 -
 drivers/base/regmap/Makefile       |   1 -
 drivers/base/regmap/regcache-lzo.c | 368 -------------------------------------
 drivers/base/regmap/regcache.c     |   3 -
 include/linux/regmap.h             |   1 -
 5 files changed, 378 deletions(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index cd4bb642b9de..9f8dcb32c24b 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -9,11 +9,6 @@ config REGMAP
 	select MDIO_BUS if REGMAP_MDIO
 	bool
 
-config REGCACHE_COMPRESSED
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
-	bool
-
 config REGMAP_AC97
 	tristate
 
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 6990de7ca9a9..8900c340e352 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -4,7 +4,6 @@ CFLAGS_regmap.o := -I$(src)
 
 obj-$(CONFIG_REGMAP) += regmap.o regcache.o
 obj-$(CONFIG_REGMAP) += regcache-rbtree.o regcache-flat.o
-obj-$(CONFIG_REGCACHE_COMPRESSED) += regcache-lzo.o
 obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
 obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
 obj-$(CONFIG_REGMAP_I2C) += regmap-i2c.o
diff --git a/drivers/base/regmap/regcache-lzo.c b/drivers/base/regmap/regcache-lzo.c
deleted file mode 100644
index 7886303eb026..000000000000
--- a/drivers/base/regmap/regcache-lzo.c
+++ /dev/null
@@ -1,368 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Register cache access API - LZO caching support
-//
-// Copyright 2011 Wolfson Microelectronics plc
-//
-// Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
-
-#include <linux/device.h>
-#include <linux/lzo.h>
-#include <linux/slab.h>
-
-#include "internal.h"
-
-static int regcache_lzo_exit(struct regmap *map);
-
-struct regcache_lzo_ctx {
-	void *wmem;
-	void *dst;
-	const void *src;
-	size_t src_len;
-	size_t dst_len;
-	size_t decompressed_size;
-	unsigned long *sync_bmp;
-	int sync_bmp_nbits;
-};
-
-#define LZO_BLOCK_NUM 8
-static int regcache_lzo_block_count(struct regmap *map)
-{
-	return LZO_BLOCK_NUM;
-}
-
-static int regcache_lzo_prepare(struct regcache_lzo_ctx *lzo_ctx)
-{
-	lzo_ctx->wmem = kmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
-	if (!lzo_ctx->wmem)
-		return -ENOMEM;
-	return 0;
-}
-
-static int regcache_lzo_compress(struct regcache_lzo_ctx *lzo_ctx)
-{
-	size_t compress_size;
-	int ret;
-
-	ret = lzo1x_1_compress(lzo_ctx->src, lzo_ctx->src_len,
-			       lzo_ctx->dst, &compress_size, lzo_ctx->wmem);
-	if (ret != LZO_E_OK || compress_size > lzo_ctx->dst_len)
-		return -EINVAL;
-	lzo_ctx->dst_len = compress_size;
-	return 0;
-}
-
-static int regcache_lzo_decompress(struct regcache_lzo_ctx *lzo_ctx)
-{
-	size_t dst_len;
-	int ret;
-
-	dst_len = lzo_ctx->dst_len;
-	ret = lzo1x_decompress_safe(lzo_ctx->src, lzo_ctx->src_len,
-				    lzo_ctx->dst, &dst_len);
-	if (ret != LZO_E_OK || dst_len != lzo_ctx->dst_len)
-		return -EINVAL;
-	return 0;
-}
-
-static int regcache_lzo_compress_cache_block(struct regmap *map,
-		struct regcache_lzo_ctx *lzo_ctx)
-{
-	int ret;
-
-	lzo_ctx->dst_len = lzo1x_worst_compress(PAGE_SIZE);
-	lzo_ctx->dst = kmalloc(lzo_ctx->dst_len, GFP_KERNEL);
-	if (!lzo_ctx->dst) {
-		lzo_ctx->dst_len = 0;
-		return -ENOMEM;
-	}
-
-	ret = regcache_lzo_compress(lzo_ctx);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-static int regcache_lzo_decompress_cache_block(struct regmap *map,
-		struct regcache_lzo_ctx *lzo_ctx)
-{
-	int ret;
-
-	lzo_ctx->dst_len = lzo_ctx->decompressed_size;
-	lzo_ctx->dst = kmalloc(lzo_ctx->dst_len, GFP_KERNEL);
-	if (!lzo_ctx->dst) {
-		lzo_ctx->dst_len = 0;
-		return -ENOMEM;
-	}
-
-	ret = regcache_lzo_decompress(lzo_ctx);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-static inline int regcache_lzo_get_blkindex(struct regmap *map,
-					    unsigned int reg)
-{
-	return ((reg / map->reg_stride) * map->cache_word_size) /
-		DIV_ROUND_UP(map->cache_size_raw,
-			     regcache_lzo_block_count(map));
-}
-
-static inline int regcache_lzo_get_blkpos(struct regmap *map,
-					  unsigned int reg)
-{
-	return (reg / map->reg_stride) %
-		    (DIV_ROUND_UP(map->cache_size_raw,
-				  regcache_lzo_block_count(map)) /
-		     map->cache_word_size);
-}
-
-static inline int regcache_lzo_get_blksize(struct regmap *map)
-{
-	return DIV_ROUND_UP(map->cache_size_raw,
-			    regcache_lzo_block_count(map));
-}
-
-static int regcache_lzo_init(struct regmap *map)
-{
-	struct regcache_lzo_ctx **lzo_blocks;
-	size_t bmp_size;
-	int ret, i, blksize, blkcount;
-	const char *p, *end;
-	unsigned long *sync_bmp;
-
-	ret = 0;
-
-	blkcount = regcache_lzo_block_count(map);
-	map->cache = kcalloc(blkcount, sizeof(*lzo_blocks),
-			     GFP_KERNEL);
-	if (!map->cache)
-		return -ENOMEM;
-	lzo_blocks = map->cache;
-
-	/*
-	 * allocate a bitmap to be used when syncing the cache with
-	 * the hardware.  Each time a register is modified, the corresponding
-	 * bit is set in the bitmap, so we know that we have to sync
-	 * that register.
-	 */
-	bmp_size = map->num_reg_defaults_raw;
-	sync_bmp = bitmap_zalloc(bmp_size, GFP_KERNEL);
-	if (!sync_bmp) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	/* allocate the lzo blocks and initialize them */
-	for (i = 0; i < blkcount; i++) {
-		lzo_blocks[i] = kzalloc(sizeof **lzo_blocks,
-					GFP_KERNEL);
-		if (!lzo_blocks[i]) {
-			bitmap_free(sync_bmp);
-			ret = -ENOMEM;
-			goto err;
-		}
-		lzo_blocks[i]->sync_bmp = sync_bmp;
-		lzo_blocks[i]->sync_bmp_nbits = bmp_size;
-		/* alloc the working space for the compressed block */
-		ret = regcache_lzo_prepare(lzo_blocks[i]);
-		if (ret < 0)
-			goto err;
-	}
-
-	blksize = regcache_lzo_get_blksize(map);
-	p = map->reg_defaults_raw;
-	end = map->reg_defaults_raw + map->cache_size_raw;
-	/* compress the register map and fill the lzo blocks */
-	for (i = 0; i < blkcount; i++, p += blksize) {
-		lzo_blocks[i]->src = p;
-		if (p + blksize > end)
-			lzo_blocks[i]->src_len = end - p;
-		else
-			lzo_blocks[i]->src_len = blksize;
-		ret = regcache_lzo_compress_cache_block(map,
-						       lzo_blocks[i]);
-		if (ret < 0)
-			goto err;
-		lzo_blocks[i]->decompressed_size =
-			lzo_blocks[i]->src_len;
-	}
-
-	return 0;
-err:
-	regcache_lzo_exit(map);
-	return ret;
-}
-
-static int regcache_lzo_exit(struct regmap *map)
-{
-	struct regcache_lzo_ctx **lzo_blocks;
-	int i, blkcount;
-
-	lzo_blocks = map->cache;
-	if (!lzo_blocks)
-		return 0;
-
-	blkcount = regcache_lzo_block_count(map);
-	/*
-	 * the pointer to the bitmap used for syncing the cache
-	 * is shared amongst all lzo_blocks.  Ensure it is freed
-	 * only once.
-	 */
-	if (lzo_blocks[0])
-		bitmap_free(lzo_blocks[0]->sync_bmp);
-	for (i = 0; i < blkcount; i++) {
-		if (lzo_blocks[i]) {
-			kfree(lzo_blocks[i]->wmem);
-			kfree(lzo_blocks[i]->dst);
-		}
-		/* each lzo_block is a pointer returned by kmalloc or NULL */
-		kfree(lzo_blocks[i]);
-	}
-	kfree(lzo_blocks);
-	map->cache = NULL;
-	return 0;
-}
-
-static int regcache_lzo_read(struct regmap *map,
-			     unsigned int reg, unsigned int *value)
-{
-	struct regcache_lzo_ctx *lzo_block, **lzo_blocks;
-	int ret, blkindex, blkpos;
-	size_t tmp_dst_len;
-	void *tmp_dst;
-
-	/* index of the compressed lzo block */
-	blkindex = regcache_lzo_get_blkindex(map, reg);
-	/* register index within the decompressed block */
-	blkpos = regcache_lzo_get_blkpos(map, reg);
-	lzo_blocks = map->cache;
-	lzo_block = lzo_blocks[blkindex];
-
-	/* save the pointer and length of the compressed block */
-	tmp_dst = lzo_block->dst;
-	tmp_dst_len = lzo_block->dst_len;
-
-	/* prepare the source to be the compressed block */
-	lzo_block->src = lzo_block->dst;
-	lzo_block->src_len = lzo_block->dst_len;
-
-	/* decompress the block */
-	ret = regcache_lzo_decompress_cache_block(map, lzo_block);
-	if (ret >= 0)
-		/* fetch the value from the cache */
-		*value = regcache_get_val(map, lzo_block->dst, blkpos);
-
-	kfree(lzo_block->dst);
-	/* restore the pointer and length of the compressed block */
-	lzo_block->dst = tmp_dst;
-	lzo_block->dst_len = tmp_dst_len;
-
-	return ret;
-}
-
-static int regcache_lzo_write(struct regmap *map,
-			      unsigned int reg, unsigned int value)
-{
-	struct regcache_lzo_ctx *lzo_block, **lzo_blocks;
-	int ret, blkindex, blkpos;
-	size_t tmp_dst_len;
-	void *tmp_dst;
-
-	/* index of the compressed lzo block */
-	blkindex = regcache_lzo_get_blkindex(map, reg);
-	/* register index within the decompressed block */
-	blkpos = regcache_lzo_get_blkpos(map, reg);
-	lzo_blocks = map->cache;
-	lzo_block = lzo_blocks[blkindex];
-
-	/* save the pointer and length of the compressed block */
-	tmp_dst = lzo_block->dst;
-	tmp_dst_len = lzo_block->dst_len;
-
-	/* prepare the source to be the compressed block */
-	lzo_block->src = lzo_block->dst;
-	lzo_block->src_len = lzo_block->dst_len;
-
-	/* decompress the block */
-	ret = regcache_lzo_decompress_cache_block(map, lzo_block);
-	if (ret < 0) {
-		kfree(lzo_block->dst);
-		goto out;
-	}
-
-	/* write the new value to the cache */
-	if (regcache_set_val(map, lzo_block->dst, blkpos, value)) {
-		kfree(lzo_block->dst);
-		goto out;
-	}
-
-	/* prepare the source to be the decompressed block */
-	lzo_block->src = lzo_block->dst;
-	lzo_block->src_len = lzo_block->dst_len;
-
-	/* compress the block */
-	ret = regcache_lzo_compress_cache_block(map, lzo_block);
-	if (ret < 0) {
-		kfree(lzo_block->dst);
-		kfree(lzo_block->src);
-		goto out;
-	}
-
-	/* set the bit so we know we have to sync this register */
-	set_bit(reg / map->reg_stride, lzo_block->sync_bmp);
-	kfree(tmp_dst);
-	kfree(lzo_block->src);
-	return 0;
-out:
-	lzo_block->dst = tmp_dst;
-	lzo_block->dst_len = tmp_dst_len;
-	return ret;
-}
-
-static int regcache_lzo_sync(struct regmap *map, unsigned int min,
-			     unsigned int max)
-{
-	struct regcache_lzo_ctx **lzo_blocks;
-	unsigned int val;
-	int i;
-	int ret;
-
-	lzo_blocks = map->cache;
-	i = min;
-	for_each_set_bit_from(i, lzo_blocks[0]->sync_bmp,
-			      lzo_blocks[0]->sync_bmp_nbits) {
-		if (i > max)
-			continue;
-
-		ret = regcache_read(map, i, &val);
-		if (ret)
-			return ret;
-
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, i);
-		if (ret > 0 && val == map->reg_defaults[ret].def)
-			continue;
-
-		map->cache_bypass = true;
-		ret = _regmap_write(map, i, val);
-		map->cache_bypass = false;
-		if (ret)
-			return ret;
-		dev_dbg(map->dev, "Synced register %#x, value %#x\n",
-			i, val);
-	}
-
-	return 0;
-}
-
-struct regcache_ops regcache_lzo_ops = {
-	.type = REGCACHE_COMPRESSED,
-	.name = "lzo",
-	.init = regcache_lzo_init,
-	.exit = regcache_lzo_exit,
-	.read = regcache_lzo_read,
-	.write = regcache_lzo_write,
-	.sync = regcache_lzo_sync
-};
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 362e043e26d8..d4877099e990 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -17,9 +17,6 @@
 
 static const struct regcache_ops *cache_types[] = {
 	&regcache_rbtree_ops,
-#if IS_ENABLED(CONFIG_REGCACHE_COMPRESSED)
-	&regcache_lzo_ops,
-#endif
 	&regcache_flat_ops,
 };
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4d10790adeb0..24fc4a9ed1f9 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -50,7 +50,6 @@ struct sdw_slave;
 enum regcache_type {
 	REGCACHE_NONE,
 	REGCACHE_RBTREE,
-	REGCACHE_COMPRESSED,
 	REGCACHE_FLAT,
 };
 

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230324-regcache-lzo-ba5cb19879ae

Best regards,
-- 
Mark Brown <broonie@kernel.org>

