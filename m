Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34036CF7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjC3AKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC3AKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:10:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0F4202
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB122B82548
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67081C4339C;
        Thu, 30 Mar 2023 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680135033;
        bh=QomJxmHFHEg1D6+6n5cFYGToSzAqlNRqVQNvQ76f0pE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VYrIzViUDhkCXh0s4reRK+ILASouwRvLkS+lo+OwpqLf5qDlm5HeyqYEb7VTPjblq
         ITunRr5Xqxv0pNaw1swr1mWO2+61uIxKM7mpjb3ugSrYdenqQoYvOzs9RMnoXY+7+/
         1ctwK5SXwi9HkKqtEKmAJd7ebHMGNEtYK3c4mO4qui1koPWz21y4M7PKYKC55UPEyU
         rhraEWJ65KKSX0wFLuRGaz7xCx5a5e69xIkn+F7RrcmCzQZMe4/IbN7l0rweXtlA9V
         1yAGVExyf7e/zT0ZOWJadQHeYge16xFOLikuCJsGauayTrt/EY6zKrsNjgXzYiXvtd
         2OZX4khsi2+QA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 30 Mar 2023 01:10:23 +0100
Subject: [PATCH v3 1/2] regmap: Factor out single value register syncing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230325-regcache-maple-v3-1-23e271f93dc7@kernel.org>
References: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
In-Reply-To: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QomJxmHFHEg1D6+6n5cFYGToSzAqlNRqVQNvQ76f0pE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhhSVy8U+5oW63pf41jOds+HM+qDQu/CX+uabosuPxf79fG+q
 Nuv2TkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIq+N2f/7H9NIbbAuuixX9D7vH1
 sB5+y9bHqGKd9+KeuaT8w3rrew//dTRKLF1yDp/XXLXxlnO+dzbl7eFbnrTJvd0sPGtx+Jrxb6djdZ
 Wf1jaa7L7QPFlm+eScnHflv3p7Jd3jBzhdfea3mF939cUeR/lBKbWpuZLM46a14d74OPzmt35PzZeT
 6td8mUIvXrP7Vz1bnZb+hyNzVph5jq93NvvO/ZOzskrkJtGpNY/Iacatdpdma1Leub1VgrvhyyM7+8
 RGru1P8nXL9dM8rJ0o8MiUvosdvPwTL5/2TpbQ+CjExfe2hHKZvOmpRTI8zdIcjwT/A0t+4m3hW/by
 2/05viu8pEaIq9kEnZxqDbwurcAA==
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

In order to support sparse caches that don't store data in raw format
factor out the parts of the raw block sync implementation that deal with
writing a single register via _regmap_write().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h |  1 +
 drivers/base/regmap/regcache.c | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 10aca7119d33..7b9ef43bcea6 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -270,6 +270,7 @@ unsigned int regcache_get_val(struct regmap *map, const void *base,
 bool regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 		      unsigned int val);
 int regcache_lookup_reg(struct regmap *map, unsigned int reg);
+int regcache_sync_val(struct regmap *map, unsigned int reg, unsigned int val);
 
 int _regmap_raw_write(struct regmap *map, unsigned int reg,
 		      const void *val, size_t val_len, bool noinc);
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index d4877099e990..e5d6b535c002 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -669,6 +669,30 @@ static bool regcache_reg_present(unsigned long *cache_present, unsigned int idx)
 	return test_bit(idx, cache_present);
 }
 
+int regcache_sync_val(struct regmap *map, unsigned int reg, unsigned int val)
+{
+	int ret;
+
+	if (!regcache_reg_needs_sync(map, reg, val))
+		return 0;
+
+	map->cache_bypass = true;
+
+	ret = _regmap_write(map, reg, val);
+
+	map->cache_bypass = false;
+
+	if (ret != 0) {
+		dev_err(map->dev, "Unable to sync register %#x. %d\n",
+			reg, ret);
+		return ret;
+	}
+	dev_dbg(map->dev, "Synced register %#x, value %#x\n",
+		reg, val);
+
+	return 0;
+}
+
 static int regcache_sync_block_single(struct regmap *map, void *block,
 				      unsigned long *cache_present,
 				      unsigned int block_base,
@@ -685,21 +709,9 @@ static int regcache_sync_block_single(struct regmap *map, void *block,
 			continue;
 
 		val = regcache_get_val(map, block, i);
-		if (!regcache_reg_needs_sync(map, regtmp, val))
-			continue;
-
-		map->cache_bypass = true;
-
-		ret = _regmap_write(map, regtmp, val);
-
-		map->cache_bypass = false;
-		if (ret != 0) {
-			dev_err(map->dev, "Unable to sync register %#x. %d\n",
-				regtmp, ret);
+		ret = regcache_sync_val(map, regtmp, val);
+		if (ret != 0)
 			return ret;
-		}
-		dev_dbg(map->dev, "Synced register %#x, value %#x\n",
-			regtmp, val);
 	}
 
 	return 0;

-- 
2.34.1

