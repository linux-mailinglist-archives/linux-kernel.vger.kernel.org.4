Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778A72B1C6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFKMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD665A1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 05:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46CCD60C55
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 12:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E93FC433D2;
        Sun, 11 Jun 2023 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686485173;
        bh=aeOdJcBlgG9LW45em1qeUMwNheAGfNrkzkBZ4oShQjI=;
        h=From:Date:Subject:To:Cc:From;
        b=uPXpfTdBp/VNeJWkOoGhsHj/b2qAGk+XMfTRIC++24T93o0D/FMtWEk/aoOBvW8ZN
         6Xd0/l5ryz2/OTd6MEZpZodLAtG0srCdX4X/qQe8i8Mj5KXzj06Do2hcV1zObSXh3B
         NuGNtoTWGf6Jf4PYUHkYb3PvlR8DDZcn2Xx1yKNBwotIvyyhkacgcxM/THblZeKT8j
         2W/R31UZhEtwYH6lCGbe+f8BiDNLgSYKMAmqLHULXW9vnjzZqbMMy9Ittn+LIVtYuy
         /z0QCbyX1VwIRpsqi3CS0SfuILjQ6YPIMqaKR6gW8zdAtg+w4t4BkQaJCH0CNJ2ent
         S48ZDWdesxj6Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 11 Jun 2023 13:06:07 +0100
Subject: [PATCH] regmap: maple: Implement block sync for the maple tree
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-regcache-maple-sync-raw-v1-1-8ddeb4e2b9ab@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK+4hWQC/x2Nyw6CMBAAf4Xs2U0K+Gj9FeNhWVa6UQvZJqIh/
 DvF40wymQWymEqGa7WAyUezjqlAfaiAI6VBUPvC0LimdWcX0GRg4ij4puklmH+J0WhGPvna++C
 OlzZAqTvKgp1R4rj382jPXU8mD/3+h7f7um7vwlDIgAAAAA==
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4918; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aeOdJcBlgG9LW45em1qeUMwNheAGfNrkzkBZ4oShQjI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhbiz8UwJAOJ1etkhKduXiErM6MxoaiWUjUUEH3RF
 87dgiMyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIW4swAKCRAk1otyXVSH0NIFB/
 9KjraWjdSjdzwZRwEjmQ8QYs/lj3rll/93/F2iWGJrV9uv8MiDkPzGB7WMBCkZ1/Wi30HWIH7d2d7M
 BTFxWRRwJ+7RpEuq7vz4ZLq4WxTWEFwYZB1GUK6OyKK6wJXjke6lFihQb6E4NfvRcrhcoiHvao06+3
 o9KNu6ZCp/3ikvvpU5jz36Ouplxm98s5yLbclYJBQ50t29Aaj1xiiBUvcrQ+z0bM8doa7m/qoBKKnN
 mkb+EfroPLuQLB3duj62ly0Fags84yaGwE9DfERe5gHRdJkduPcDd1pitiMce9W/fulUoIbX547WAg
 VnnkK2WNq/0qZZow3vwBe/hSLXt02O
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For register maps where we can write multiple values in a single bus
operation it is generally much faster to do so. Improve the performance of
maple tree cache syncs on such devices by identifying blocks of adjacent
registers that need to be written out and combining them into a single
operation.

Combining writes does mean that we need to allocate a scratch buffer and
format the data into it but it is expected that for most cases where caches
are in use the cost of I/O will be much greater than the cost of doing the
allocation and format.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h       |  2 +
 drivers/base/regmap/regcache-maple.c | 82 +++++++++++++++++++++++++++++++++---
 drivers/base/regmap/regcache.c       |  4 +-
 3 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 9bd0dfd1e259..f993e2484f80 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -257,6 +257,8 @@ int regcache_sync_block(struct regmap *map, void *block,
 			unsigned long *cache_present,
 			unsigned int block_base, unsigned int start,
 			unsigned int end);
+bool regcache_reg_needs_sync(struct regmap *map, unsigned int reg,
+			     unsigned int val);
 
 static inline const void *regcache_get_val_addr(struct regmap *map,
 						const void *base,
diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index c2e3a0f6c218..67f90853dd8f 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -186,6 +186,55 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	return ret;
 }
 
+static int regcache_maple_sync_block(struct regmap *map, unsigned long *entry,
+				     struct ma_state *mas,
+				     unsigned int min, unsigned int max)
+{
+	void *buf;
+	unsigned long r;
+	size_t val_bytes = map->format.val_bytes;
+	int ret = 0;
+
+	mas_pause(mas);
+	rcu_read_unlock();
+
+	/*
+	 * Use a raw write if writing more than one register to a
+	 * device that supports raw writes to reduce transaction
+	 * overheads.
+	 */
+	if (max - min > 1 && regmap_can_raw_write(map)) {
+		buf = kmalloc(val_bytes * (max - min), map->alloc_flags);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* Render the data for a raw write */
+		for (r = min; r < max; r++) {
+			regcache_set_val(map, buf, r - min,
+					 entry[r - mas->index]);
+		}
+
+		ret = _regmap_raw_write(map, min, buf, (max - min) * val_bytes,
+					false);
+
+		kfree(buf);
+	} else {
+		for (r = min; r < max; r++) {
+			ret = _regmap_write(map, r,
+					    entry[r - mas->index]);
+			if (ret != 0)
+				goto out;
+		}
+	}
+
+out:
+	rcu_read_lock();
+
+	return ret;
+}
+
 static int regcache_maple_sync(struct regmap *map, unsigned int min,
 			       unsigned int max)
 {
@@ -194,8 +243,9 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 	MA_STATE(mas, mt, min, max);
 	unsigned long lmin = min;
 	unsigned long lmax = max;
-	unsigned int r;
+	unsigned int r, v, sync_start;
 	int ret;
+	bool sync_needed = false;
 
 	map->cache_bypass = true;
 
@@ -203,18 +253,38 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 
 	mas_for_each(&mas, entry, max) {
 		for (r = max(mas.index, lmin); r <= min(mas.last, lmax); r++) {
-			mas_pause(&mas);
-			rcu_read_unlock();
-			ret = regcache_sync_val(map, r, entry[r - mas.index]);
+			v = entry[r - mas.index];
+
+			if (regcache_reg_needs_sync(map, r, v)) {
+				if (!sync_needed) {
+					sync_start = r;
+					sync_needed = true;
+				}
+				continue;
+			}
+
+			if (!sync_needed)
+				continue;
+
+			ret = regcache_maple_sync_block(map, entry, &mas,
+							sync_start, r);
 			if (ret != 0)
 				goto out;
-			rcu_read_lock();
+			sync_needed = false;
+		}
+
+		if (sync_needed) {
+			ret = regcache_maple_sync_block(map, entry, &mas,
+							sync_start, r);
+			if (ret != 0)
+				goto out;
+			sync_needed = false;
 		}
 	}
 
+out:
 	rcu_read_unlock();
 
-out:
 	map->cache_bypass = false;
 
 	return ret;
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 029564695dbb..c7d065f96a87 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -279,8 +279,8 @@ int regcache_write(struct regmap *map,
 	return 0;
 }
 
-static bool regcache_reg_needs_sync(struct regmap *map, unsigned int reg,
-				    unsigned int val)
+bool regcache_reg_needs_sync(struct regmap *map, unsigned int reg,
+			     unsigned int val)
 {
 	int ret;
 

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-regcache-maple-sync-raw-c58188904739

Best regards,
-- 
Mark Brown <broonie@kernel.org>

