Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C5703025
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbjEOOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:39:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A470118
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:39:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba712bb7b28so19229814276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684161570; x=1686753570;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iQt2xD4Tyz0Yhzd5TBrdbiAFY5NNn1tCgDgtG6xr5m8=;
        b=NooaQsGVumuG+a4dTBz8nmJyJCpiTGe2igypaqkasHCDRw8+nRf4VxBUjpKMwfrrcl
         TFWb8anHYXKg03BiEoNfjN28L8Nd83y7LIKHb+WsYoQedEARzO2rYUeueN+fO2xZ/KMj
         wfMYnLo2ufX8QWqDDyiXeQzbokss/Gl7HZnGEepHXr5++h5KYYUvNiV3laMIjfI1TTxK
         NRrpnjcQ3Fw3DP250OhwuTIBAFeSPaMSab9lZeIR9zp6xd6VkivPee0dKHsGgue+0J0C
         4c2m5y3U2QHzWin1vK56R0SejIpd97PAJ76wmECOTZSSEO/jMBk82z/OBiKAIAF+Oh1G
         4VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161570; x=1686753570;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQt2xD4Tyz0Yhzd5TBrdbiAFY5NNn1tCgDgtG6xr5m8=;
        b=RN2yV24i+yLGkYX3w4tO8e+SQknnHY1H2Z7j0uJcRECrfe/ThY0zq2quPcgR4VEfSD
         ATiHmtTSh1vEGgpBK6lAZabjGyDi+hjfJCdLCxEuTRRwA2QW8ppyQhIf+5MSsL+VatCy
         c8t91gKVnwGlKrNG9QAPnR0Z/gLJOTbOMk8xzmzBSvmGt4AZTFuElq/du2SaQ50CUXr+
         /mjHT2RaV2TmW6DQApG+5Z345Rdr3TrlJGZ1b8deeYclbHqwSWuOQbKEbYAKoVKN12FL
         RpxSG9Jw/PKbxQT1mTjh4pT27QreX9IHYaFlhN3LSlVQ//Zkg+lqdMKw6o2KXPhu6f87
         QO1w==
X-Gm-Message-State: AC+VfDxmzgGyBy1wS7BcoGppzZfM5tC9X09qRth7ca5TVbvG0WxT8a/f
        Lc6RtW8OIyeo0SU3v4ZATkgQ0io4zMjy
X-Google-Smtp-Source: ACHHUZ5vVl7kgT64SFjg9oT6YqdZEnoofPWGv4WW8UyEYB3pcXgKaT5Cs4aiBjU6499QjoMooBFKOcO++Hyu
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:d5d8:389:80ea:8fec])
 (user=jwylder job=sendgmr) by 2002:a05:690c:b9a:b0:55a:5e16:af7e with SMTP id
 ck26-20020a05690c0b9a00b0055a5e16af7emr26035402ywb.2.1684161570298; Mon, 15
 May 2023 07:39:30 -0700 (PDT)
Date:   Mon, 15 May 2023 09:39:26 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230515143927.973493-1-jwylder@google.com>
Subject: [PATCH] regmap: Account for register length when chunking
From:   Jim Wylder <jwylder@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Jim Wylder <jwylder@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when regmap_raw_write() splits the data, it uses the
max_raw_write value calculated from the bus.  For I2C, the actual
transmission will include that data plus the target register.
Since the register length is not included in the calculation of the data
chunk, the transmission will always exceed the maximum transmission
length.

To avoid this problem, add a flag in the regmap_bus structure to declare
that, for a given bus, the register length should be accounted for.  Set
the flag to true for I2C buses, and subtract the length of the register
from the maximum transmission value if the flag is set.

Signed-off-by: Jim Wylder <jwylder@google.com>
---
 drivers/base/regmap/regmap-i2c.c | 1 +
 drivers/base/regmap/regmap.c     | 8 ++++++--
 include/linux/regmap.h           | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 980e5ce6a3a35..793ff8ea3266d 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -198,6 +198,7 @@ static int regmap_i2c_read(void *context,
 }
 
 static const struct regmap_bus regmap_i2c = {
+	.reg_in_write = true,
 	.write = regmap_i2c_write,
 	.gather_write = regmap_i2c_gather_write,
 	.read = regmap_i2c_read,
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index db7851f0e3b8c..9de5f4b272aee 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2083,14 +2083,18 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
 	int ret, i;
+	size_t max_raw_write = map->max_raw_write;
 
 	if (!val_count)
 		return -EINVAL;
 
+	if ((map->bus) && (map->bus->reg_in_write))
+		max_raw_write -= map->format.reg_bytes;
+
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > map->max_raw_write)
-		chunk_regs = map->max_raw_write / val_bytes;
+	else if (max_raw_write && val_len > max_raw_write)
+		chunk_regs = max_raw_write / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index c2b9cc5db8241..20ac78d8777a3 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -556,6 +556,7 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @val_format_endian_default: Default endianness for formatted register
  *     values. Used when the regmap_config specifies DEFAULT. If this is
  *     DEFAULT, BIG is assumed.
+ * @reg_in_write: Does max_raw_write include register length.
  * @max_raw_read: Max raw read size that can be used on the bus.
  * @max_raw_write: Max raw write size that can be used on the bus.
  */
@@ -576,6 +577,7 @@ struct regmap_bus {
 	u8 read_flag_mask;
 	enum regmap_endian reg_format_endian_default;
 	enum regmap_endian val_format_endian_default;
+	bool reg_in_write;
 	size_t max_raw_read;
 	size_t max_raw_write;
 };

base-commit: ad2fd53a7870a395b8564697bef6c329d017c6c9
-- 
2.40.1.606.ga4b1b128d6-goog

