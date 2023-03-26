Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2206C9494
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjCZNnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCZNmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:42:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A3072B3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D314DB80C9F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F279C4339C;
        Sun, 26 Mar 2023 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679838171;
        bh=JzRb0vPHK81K/w4HAdgArDg0c/30xVRY6Pqby/OShLs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=g8IUwSZ6bkMob6B3d/HMxNHUtG8U3oUP7KRKSCm2xcxPNHeKC/G0/QehtWeewUNjP
         WNKs9riKHOHbiFWsArm5e0Mm0VFR8z+ttMKi0VPVhutCdhSUhoMJ7/B1HqGCqFP2Hq
         I/J22Z4u83tlatZhRf19Dm/ZRh38AES6GhQClM4PFpbL1r5EquXHdSZkUfzMMQD9hb
         Mx1c7BXhnKKgPd//YcvEJF6SgVO/wkT4ZRfSGdBiKcmVklAXnaMv3WGTkjPcuDfdKd
         8i0/jPXBC9EG4i5wqaKU3wZAkmhwA192EkUbWJuviPzgaUZ/rICgKjvWXf4JAcol/7
         MCuDPQPePRG5A==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 26 Mar 2023 14:42:39 +0100
Subject: [PATCH v2 2/2] regmap: Add maple tree based register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230325-regcache-maple-v2-2-799dcab3ecb1@kernel.org>
References: <20230325-regcache-maple-v2-0-799dcab3ecb1@kernel.org>
In-Reply-To: <20230325-regcache-maple-v2-0-799dcab3ecb1@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=10316; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JzRb0vPHK81K/w4HAdgArDg0c/30xVRY6Pqby/OShLs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkIEvWCIaO8pCOMK7FgEyK4AhwWiv319Os5BvuxXSA
 1W2k8ZiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCBL1gAKCRAk1otyXVSH0DJ0B/
 9xxYMJd5jzIzsT97q33UMDe3CnRNuyje2xgCMylVlaRNlMx89ugDcXqQ8iHRozuqFYwP6IAIr8w/Ji
 6To0RjkVUVa+FNTs/eCeQfRGMY90GtdRUnL4mZSdx8TkLVyXsolntXLrzX4TIYy3DZBw0XRdfLAykJ
 LucelvxACMk/q4cUM9Ai+VEcY6OPN6hjxFIkKE+Htv95RhmRaw2Ok3fkbLCnmPQEuwM5gL32n0rv1a
 HArp1rYqpHoDkmvsC+VBgTqk06qVD7TNbFbV5LWp6Rbw9iacdVKwjNHFu//obOSZoorEBNCGZ30dc2
 xsCMQn2ealvTU9rZTLgey5TxuKFjma
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

The current state of the art for sparse register maps is the
rbtree cache.  This works well for most applications but isn't
always ideal for sparser register maps since the rbtree can get
deep, requiring a lot of walking.  Fortunately the kernel has a
data structure intended to address this very problem, the maple
tree.  Provide an initial implementation of a register cache
based on the maple tree to start taking advantage of it.

The entries stored in the maple tree are arrays of register
values, with the maple tree keys holding the register addresses.
We store data in host native format rather than device native
format as we do for rbtree, this will be a benefit for devices
where we don't marshal data within regmap and simplifies the code
but will result in additional CPU overhead when syncing the cache
on devices where we do marshal data in regmap.

This should work well for a lot of devices, though there's some
additional areas that could be looked at such as caching the
last accessed entry like we do for rbtree and trying to minimise
the maple tree level locking. We should also use bulk writes
rather than single register writes when resyncing the cache where
possible, even if we don't store in device native format.

Very small register maps may continue to to better with rbtree
longer term.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/Makefile         |   2 +-
 drivers/base/regmap/internal.h       |   1 +
 drivers/base/regmap/regcache-maple.c | 265 +++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regcache.c       |   1 +
 drivers/base/regmap/regmap-kunit.c   |   3 +
 include/linux/regmap.h               |   1 +
 6 files changed, 272 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 4cb73468a197..f6c6cb017200 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -3,7 +3,7 @@
 CFLAGS_regmap.o := -I$(src)
 
 obj-$(CONFIG_REGMAP) += regmap.o regcache.o
-obj-$(CONFIG_REGMAP) += regcache-rbtree.o regcache-flat.o
+obj-$(CONFIG_REGMAP) += regcache-rbtree.o regcache-flat.o regcache-maple.o
 obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
 obj-$(CONFIG_REGMAP_KUNIT) += regmap-kunit.o
 obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 7b9ef43bcea6..6361df6f553a 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -282,6 +282,7 @@ enum regmap_endian regmap_get_val_endian(struct device *dev,
 					 const struct regmap_config *config);
 
 extern struct regcache_ops regcache_rbtree_ops;
+extern struct regcache_ops regcache_maple_ops;
 extern struct regcache_ops regcache_flat_ops;
 
 static inline const char *regmap_name(const struct regmap *map)
diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
new file mode 100644
index 000000000000..07d446b49801
--- /dev/null
+++ b/drivers/base/regmap/regcache-maple.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register cache access API - maple tree based cache
+//
+// Copyright 2023 Arm, Ltd
+//
+// Author: Mark Brown <broonie@kernel.org>
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/maple_tree.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+static int regcache_maple_read(struct regmap *map,
+			       unsigned int reg, unsigned int *value)
+{
+	struct maple_tree *mt = map->cache;
+	MA_STATE(mas, mt, reg, reg);
+	unsigned long *entry;
+
+	rcu_read_lock();
+
+	entry = mas_find(&mas, reg);
+	if (!entry) {
+		mas_unlock(&mas);
+		return -ENOENT;
+	}
+
+	*value = entry[reg - mas.index];
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int regcache_maple_write(struct regmap *map, unsigned int reg,
+				unsigned int val)
+{
+	struct maple_tree *mt = map->cache;
+	MA_STATE(mas, mt, reg, reg);
+	unsigned long *entry, *upper, *lower;
+	unsigned long index, last;
+	size_t lower_sz, upper_sz;
+	int ret;
+
+	mas_lock(&mas);
+
+	entry = mas_find(&mas, reg);
+	if (entry) {
+		entry[reg - mas.index] = val;
+		ret = 0;
+		goto out;
+	}
+
+	/* Any adjacent entries to extend/merge? */
+	mas_set_range(&mas, reg - 1, reg + 1);
+	index = reg;
+	last = reg;
+
+	lower = mas_find(&mas, reg - 1);
+	if (lower) {
+		index = mas.index;
+		lower_sz = (mas.last - mas.index + 1) * sizeof(unsigned long);
+	}
+
+	upper = mas_find(&mas, reg + 1);
+	if (upper) {
+		last = mas.last;
+		upper_sz = (mas.last - mas.index + 1) * sizeof(unsigned long);
+	}
+
+	entry = kmalloc((last - index + 1) * sizeof(unsigned long),
+			GFP_KERNEL);
+	if (!entry) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (lower)
+		memcpy(entry, lower, lower_sz);
+	entry[reg - index] = val;
+	if (upper)
+		memcpy(&entry[reg - index + 1], upper, upper_sz);
+
+	mas_set_range(&mas, index, last);
+
+	ret = mas_store_gfp(&mas, entry, GFP_KERNEL);
+	if (ret == 0) {
+		kfree(lower);
+		kfree(upper);
+	}
+
+out:
+	mas_unlock(&mas);
+
+	return ret;
+}
+
+static int regcache_maple_drop(struct regmap *map, unsigned int min,
+			       unsigned int max)
+{
+	struct maple_tree *mt = map->cache;
+	MA_STATE(mas, mt, min, max);
+	unsigned long *entry, *lower, *upper;
+	unsigned long lower_index, lower_last;
+	unsigned long upper_index, upper_last;
+	int ret;
+
+	lower = NULL;
+	upper = NULL;
+
+	mas_lock(&mas);
+
+	mas_for_each(&mas, entry, max) {
+		/* Do we need to save any of this entry? */
+		if (mas.index < min) {
+			lower_index = mas.index;
+			lower_last = min -1;
+
+			lower = kmemdup(entry, ((min - mas.index) *
+						sizeof(unsigned long)),
+					GFP_KERNEL);
+			if (!lower) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+
+		if (mas.last > max) {
+			upper_index = max + 1;
+			upper_last = mas.last;
+
+			upper = kmemdup(&entry[max + 1],
+					((mas.last - max) *
+					 sizeof(unsigned long)),
+					GFP_KERNEL);
+			if (!upper) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+
+		/* Delete the current entry */
+		mas_erase(&mas);
+		kfree(entry);
+
+		/* Insert new nodes with the saved data */
+		if (lower) {
+			mas_set_range(&mas, lower_index, lower_last);
+			ret = mas_store_gfp(&mas, lower, GFP_KERNEL);
+			if (ret != 0)
+				goto out;
+			lower = NULL;
+		}
+
+		if (upper) {
+			mas_set_range(&mas, upper_index, upper_last);
+			ret = mas_store_gfp(&mas, upper, GFP_KERNEL);
+			if (ret != 0)
+				goto out;
+			upper = NULL;
+		}
+	}
+
+out:
+	mas_unlock(&mas);
+	kfree(lower);
+	kfree(upper);
+
+	return ret;
+}
+
+static int regcache_maple_sync(struct regmap *map, unsigned int min,
+			       unsigned int max)
+{
+	struct maple_tree *mt = map->cache;
+	unsigned long *entry;
+	MA_STATE(mas, mt, min, max);
+	unsigned long lmin = min;
+	unsigned long lmax = max;
+	unsigned int r;
+	int ret;
+
+	map->cache_bypass = true;
+
+	rcu_read_lock();
+
+	mas_for_each(&mas, entry, max) {
+		for (r = max(mas.index, lmin); r <= min(mas.last, lmax); r++) {
+			ret = regcache_sync_val(map, r, entry[r - mas.index]);
+			if (ret != 0)
+				goto out;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+
+	map->cache_bypass = false;
+
+	return ret;
+}
+
+static int regcache_maple_exit(struct regmap *map)
+{
+	struct maple_tree *mt = map->cache;
+	MA_STATE(mas, mt, 0, UINT_MAX);
+	unsigned int *entry;;
+
+	/* if we've already been called then just return */
+	if (!mt)
+		return 0;
+
+	mas_lock(&mas);
+	mas_for_each(&mas, entry, UINT_MAX)
+		kfree(entry);
+	__mt_destroy(mt);
+	mas_unlock(&mas);
+
+	kfree(mt);
+	map->cache = NULL;
+
+	return 0;
+}
+
+static int regcache_maple_init(struct regmap *map)
+{
+	struct maple_tree *mt;
+	int i;
+	int ret;
+
+	mt = kmalloc(sizeof(*mt), GFP_KERNEL);
+	if (!mt)
+		return -ENOMEM;
+	map->cache = mt;
+
+	mt_init(mt);
+
+	for (i = 0; i < map->num_reg_defaults; i++) {
+		ret = regcache_maple_write(map,
+					   map->reg_defaults[i].reg,
+					   map->reg_defaults[i].def);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	regcache_maple_exit(map);
+	return ret;
+}
+
+struct regcache_ops regcache_maple_ops = {
+	.type = REGCACHE_MAPLE,
+	.name = "maple",
+	.init = regcache_maple_init,
+	.exit = regcache_maple_exit,
+	.read = regcache_maple_read,
+	.write = regcache_maple_write,
+	.drop = regcache_maple_drop,
+	.sync = regcache_maple_sync,
+};
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index e5d6b535c002..0b47721089e6 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -17,6 +17,7 @@
 
 static const struct regcache_ops *cache_types[] = {
 	&regcache_rbtree_ops,
+	&regcache_maple_ops,
 	&regcache_flat_ops,
 };
 
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 6f2bfa4650fe..3486bf9e28b8 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -29,6 +29,7 @@ static const struct regcache_types regcache_types_list[] = {
 	{ REGCACHE_NONE, "none" },
 	{ REGCACHE_FLAT, "flat" },
 	{ REGCACHE_RBTREE, "rbtree" },
+	{ REGCACHE_MAPLE, "maple" },
 };
 
 KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, case_to_desc);
@@ -36,12 +37,14 @@ KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, case_to_desc);
 static const struct regcache_types real_cache_types_list[] = {
 	{ REGCACHE_FLAT, "flat" },
 	{ REGCACHE_RBTREE, "rbtree" },
+	{ REGCACHE_MAPLE, "maple" },
 };
 
 KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, case_to_desc);
 
 static const struct regcache_types sparse_cache_types_list[] = {
 	{ REGCACHE_RBTREE, "rbtree" },
+	{ REGCACHE_MAPLE, "maple" },
 };
 
 KUNIT_ARRAY_PARAM(sparse_cache_types, sparse_cache_types_list, case_to_desc);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 24fc4a9ed1f9..11b360da199d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -51,6 +51,7 @@ enum regcache_type {
 	REGCACHE_NONE,
 	REGCACHE_RBTREE,
 	REGCACHE_FLAT,
+	REGCACHE_MAPLE,
 };
 
 /**

-- 
2.34.1

