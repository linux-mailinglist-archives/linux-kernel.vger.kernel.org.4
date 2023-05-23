Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB270E747
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjEWVWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEWVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A1FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D531F60ED2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE55DC433D2;
        Tue, 23 May 2023 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684876952;
        bh=+m9RROw8XsbHs+6M4nWP9zSVjzs8K99RtxgbNfvIlEE=;
        h=From:Date:Subject:To:Cc:From;
        b=H4AbQtoRdo9nMjXDlTrG98s6u/IHME7FcF0sz92N+cQICOpzr6NCxwvxk/CWVHyfd
         IiY9ZbFGja9xUJyFds/p9D6tsShLrRTeF8qlmK91/Fw1MAucskuipt6a+yS0v2C0KS
         i5d2uQRB/WaTagPx1g19B7RjygrzPsqVf+uHrdJssyA7ed/uKWzaXZJhVsggCaPMLH
         sgfnzvskqkNr9MjBF/1lpNZLsJsEfottv0DN0qMyc86BplAY8c0rByBtzue3FUhfNN
         /dwx+E0fzJMP8qV+FUVrT5oLnyR4T+w2Eu4zFJ91xIHPhFIpoN5wLWLl8GPmYUzACH
         E+1ClB28ngDRg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 22:22:27 +0100
Subject: [PATCH] regmap: Load register defaults in blocks rather than
 register by register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230523-regcache-maple-load-defaults-v1-1-0c04336f005d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJIubWQC/x2Nyw6DIBAAf8XsuZtQjNH0V5oeFliElIJZ+jAx/
 rvY48xhZoPKErnCrdtA+BtrLLnB9dKBDZRnxugag1a6V4PuUXi2ZAPji5bEmAo5dOzpk94V/Th
 oM05OTUzQEoYqoxHKNpyRX5HnqRdhH9f/9f7Y9wO8+QLrhQAAAA==
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3049; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+m9RROw8XsbHs+6M4nWP9zSVjzs8K99RtxgbNfvIlEE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbS6WtIroeKGXRwL72E77JS9twf3hKhmIb/NjONcd
 AtJqWZSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0ulgAKCRAk1otyXVSH0IqcB/
 9QgIHnY9/ZykVjHkgj/kcs6GS74u+do9gYy8olyYpgdXjqrnKWquW4R9IEbzRgGcPdRjUQesZ9gmOY
 d7DkqBn2LhyIvUxVado195Xb1G8Whr9GI5MODIaYe/jcwJhYa2cds3NV4aa5aET3IlO1qtAy9ng2ZW
 S/l3xJOMX6k0ybeYES85nrmo85d5sxFpodKsfCNzu29de4jrFbRD8iJjMAzIWvxtmwmAON83PVE72Z
 E0PE3yVvGKmHLnHt/hA2JIaWsdigmOco3+vs4IRpieMSEzMjUjdSiEP0AZG/iX0vM1RWRBTfg3lYTC
 J84Hb/bKtHPOpm/s8o2rqJMSZjHJUY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use the normal single register write function to load the
default values into the cache, resulting in a large number of reallocations
when there are blocks of registers as we extend the memory region we are
using to store the values. Instead scan through the list of defaults for
blocks of adjacent registers and do a single allocation and insert for each
such block. No functional change.

We do not take advantage of the maple tree preallocation, this is purely at
the regcache level. It is not clear to me yet if the maple tree level would
help much here or if we'd have more overhead from overallocating and then
freeing maple tree data.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 58 ++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 9b1b559107ef..2d2d5d7ee447 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -239,11 +239,41 @@ static int regcache_maple_exit(struct regmap *map)
 	return 0;
 }
 
+static int regcache_maple_insert_block(struct regmap *map, int first,
+					int last)
+{
+	struct maple_tree *mt = map->cache;
+	MA_STATE(mas, mt, first, last);
+	unsigned long *entry;
+	int i, ret;
+
+	entry = kcalloc(last - first + 1, sizeof(unsigned long), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	for (i = 0; i < last - first + 1; i++)
+		entry[i] = map->reg_defaults[first + i].def;
+
+	mas_lock(&mas);
+
+	mas_set_range(&mas, map->reg_defaults[first].reg,
+		      map->reg_defaults[last].reg);
+	ret = mas_store_gfp(&mas, entry, GFP_KERNEL);
+
+	mas_unlock(&mas);
+
+	if (ret)
+		kfree(entry);
+
+	return ret;
+}
+
 static int regcache_maple_init(struct regmap *map)
 {
 	struct maple_tree *mt;
 	int i;
 	int ret;
+	int range_start;
 
 	mt = kmalloc(sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -252,14 +282,30 @@ static int regcache_maple_init(struct regmap *map)
 
 	mt_init(mt);
 
-	for (i = 0; i < map->num_reg_defaults; i++) {
-		ret = regcache_maple_write(map,
-					   map->reg_defaults[i].reg,
-					   map->reg_defaults[i].def);
-		if (ret)
-			goto err;
+	if (!map->num_reg_defaults)
+		return 0;
+
+	range_start = 0;
+
+	/* Scan for ranges of contiguous registers */
+	for (i = 1; i < map->num_reg_defaults; i++) {
+		if (map->reg_defaults[i].reg !=
+		    map->reg_defaults[i - 1].reg + 1) {
+			ret = regcache_maple_insert_block(map, range_start,
+							  i - 1);
+			if (ret != 0)
+				goto err;
+
+			range_start = i;
+		}
 	}
 
+	/* Add the last block */
+	ret = regcache_maple_insert_block(map, range_start,
+					  map->num_reg_defaults - 1);
+	if (ret != 0)
+		goto err;
+
 	return 0;
 
 err:

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230523-regcache-maple-load-defaults-f752b78d08ea

Best regards,
-- 
Mark Brown <broonie@kernel.org>

