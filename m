Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCF6C9492
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjCZNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCZNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:42:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F2972AB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77C71B80C9A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204DAC433EF;
        Sun, 26 Mar 2023 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679838170;
        bh=QomJxmHFHEg1D6+6n5cFYGToSzAqlNRqVQNvQ76f0pE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=D+Sdrs9yVNlYys8gz9LIFR7W4UwRT+pPt3M02zS9/T+iCIerY74bm8BnJUZMpW6Dr
         Yq7VqJxfT9nl6FtBQOyk0DwJPA52+pFxjolIczpOY9RjS6QiN0DpH1sZrgrlV82OEF
         o4SsjTvLE2wTkvLcZgjeAuUunNVVfwqEyt8vcioPmvsOqQO9FL2ripJC5xmR+inIg5
         EiGIPxusQ3NE0QkoQPs5oFkZU2W2leY8nOuHMyGtQvzuy6X5PUfGu7Dp1uaBjLv35Q
         h9aiQE+nflrTMIQyTDhbKP4z+rB9kK8R0gGSr5bnITr5XGqakndMt0+NLPGLLBNXVA
         /a2rE7aqpy6iw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 26 Mar 2023 14:42:38 +0100
Subject: [PATCH v2 1/2] regmap: Factor out single value register syncing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230325-regcache-maple-v2-1-799dcab3ecb1@kernel.org>
References: <20230325-regcache-maple-v2-0-799dcab3ecb1@kernel.org>
In-Reply-To: <20230325-regcache-maple-v2-0-799dcab3ecb1@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QomJxmHFHEg1D6+6n5cFYGToSzAqlNRqVQNvQ76f0pE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkIEvVZtvtk5LqHIofZVwrdWpYutCKKSOUZgBYKqpc
 rZvCqXeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCBL1QAKCRAk1otyXVSH0JtzB/
 41ddUryS62ss/+QHOKfK7Xwje0qB/PpTxcabZVNL1tuNehf+GnsMC140hRMR4qPvIhd2A4wUkjU2w8
 71Z79RH2pLxYRQ03bxjuzCqvekrO9OyDTQ1gPYmbKXxRjzJuiq472TOi463b7zEPaL5mGLhxNJBgCK
 z/BxAH6ZKlycr8NKjizwFOyhe4NECoox5D95yXQGX4tJGCd9xdl9CzOzHrv4j+30hIo5o+Na5EcXKf
 T0aUw8rrakl0Ebgq4LhPbjwptRydT+3rA8cTgbb3U66bcazSwHJ2Gj/mjcCf5bBNRS+YxVipTLu5R5
 7vJUq6LQ+DY6njuNWXadFM2Q1YL9kQ
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

