Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA66E9803
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDTPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDTPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:06:24 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096224EC4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:06:21 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9FC03FF811;
        Thu, 20 Apr 2023 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682003180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q5b2SfWVwigN5Bg+YV5jVSODC8wLhGJDfoFWx/0bEwY=;
        b=Dps+ApLkPGFlan7Nnm52Azq0ZOt92NjZY69k1KoKzLATXtI4MQ6zxqL9/WCY5GEyYGdCQE
        Q1GgHiIQmaxfF1LEpXNCegTXKFuqbfbumX8oS4Sz92bNljFoOThv3y5W7Wwy9qIBoEYb95
        UGhsj5F0f929qB3S3eaPbk618eRnDGh99UIlVY0Q3UVp1C/Q8pNccd8HmR72+1sWQ6xczE
        oVj3VHUbxkSN5X2FzIsgMcgtV+DFYa3XlC4c5+t5zBKQ0DpdzJyMyC09G0zLn4iF+J9njN
        ELAL4oMTKC/SYNfy+j//ms/HOHoTBvcmC5oqIHpa/ArEEvMo4Ulgj5AOtZryXw==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        Lee Jones <lee@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexis.lothore@bootlin.com
Subject: [PATCH] regmap: don't check for alignment when using reg_shift
Date:   Thu, 20 Apr 2023 17:06:17 +0200
Message-Id: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On regmap consumers that require address translation through
up/downshifting, the alignment check in the regmap core doesn't take the
translation into account. This doesn't matter when downshifting the
register address, as any address that fits a given alignment requirement
will still meet it when downshifted (a 4-byte aligned address will
always also be 2-bytes aligned for example).

However, when upshifting, this check causes spurious errors, as it
occurs before the upshifting.

Therefore, we can just skip the alignment check when using
up/downshifting, as it's not relevant.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/base/regmap/regmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 167b3c73c13f..8eb26ac24356 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2022,7 +2022,7 @@ int regmap_write(struct regmap *map, unsigned int reg, unsigned int val)
 {
 	int ret;
 
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 
 	map->lock(map->lock_arg);
@@ -2049,7 +2049,7 @@ int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val)
 {
 	int ret;
 
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 
 	map->lock(map->lock_arg);
@@ -2264,7 +2264,7 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 	if (val_len == 0)
 		return -EINVAL;
@@ -2405,7 +2405,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	int ret = 0, i;
 	size_t val_bytes = map->format.val_bytes;
 
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 
 	/*
@@ -2644,7 +2644,7 @@ static int _regmap_multi_reg_write(struct regmap *map,
 			int reg = regs[i].reg;
 			if (!map->writeable_reg(map->dev, reg))
 				return -EINVAL;
-			if (!IS_ALIGNED(reg, map->reg_stride))
+			if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 				return -EINVAL;
 		}
 
@@ -2795,7 +2795,7 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 
 	map->lock(map->lock_arg);
@@ -2917,7 +2917,7 @@ int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val)
 {
 	int ret;
 
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 
 	map->lock(map->lock_arg);
@@ -2951,7 +2951,7 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 	if (val_count == 0)
 		return -EINVAL;
@@ -3046,7 +3046,7 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 	if (val_len == 0)
 		return -EINVAL;
@@ -3168,7 +3168,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 	size_t val_bytes = map->format.val_bytes;
 	bool vol = regmap_volatile_range(map, reg, val_count);
 
-	if (!IS_ALIGNED(reg, map->reg_stride))
+	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 	if (val_count == 0)
 		return -EINVAL;
-- 
2.39.2

