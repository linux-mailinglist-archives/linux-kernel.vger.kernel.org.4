Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCE3632798
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiKUPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKUPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:14:08 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B3DCFA73;
        Mon, 21 Nov 2022 07:08:56 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 25C74230D;
        Mon, 21 Nov 2022 16:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669043334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ShPOxC+vc6kAIrStj2HW/8mEr6+lT3FK4X9HcTeMoPg=;
        b=IlQZyAYQe3hDv2l9ZeBmKXQKfgyanqyB4reG447B/lnDD+KEp2prY3rs7NN6MBwQIZTujf
        4+k0EtLtEjuLyHIlA84BP6Ljkw16yvuRd9bND2jqLLJyRiBWvUQGZHOxysCJy/6a0ZtZHn
        h4c2PbqpQthoCw+pX/ds8ufPoZNFnDDk8IGlURzWFyaogGzIhbYHbC3jFwEDWC4YLeM8oo
        JMSWuUjWARbv2CwwG5kuGfSbHMzROgcEP4UtO5bB4BoeCIHPtDyfiNOe5V9qIueDN9uUnO
        R3o3R0RWAh1nGrifXKUVI+aGoHu5c+vJ7YXmMdI254Lu8qqqNMm0xRpdGDqv7g==
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] regmap: add regmap_might_sleep()
Date:   Mon, 21 Nov 2022 16:08:42 +0100
Message-Id: <20221121150843.1562603-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the dawn of MMIO gpio-regmap users, it is desirable to let
gpio-regmap ask the regmap if it might sleep during an access so
it can pass that information to gpiochip. Add a new regmap_might_sleep()
to query the regmap.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/base/regmap/regmap.c | 13 +++++++++++++
 include/linux/regmap.h       |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c6d6d53e8cd3..d12d669157f2 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -3486,6 +3486,19 @@ int regmap_get_reg_stride(struct regmap *map)
 }
 EXPORT_SYMBOL_GPL(regmap_get_reg_stride);
 
+/**
+ * regmap_might_sleep() - Returns whether a regmap access might sleep.
+ *
+ * @map: Register map to operate on.
+ *
+ * Returns true if an access to the register might sleep, else false.
+ */
+bool regmap_might_sleep(struct regmap *map)
+{
+	return map->can_sleep;
+}
+EXPORT_SYMBOL_GPL(regmap_might_sleep);
+
 int regmap_parse_val(struct regmap *map, const void *buf,
 			unsigned int *val)
 {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index ca3434dca3a0..3faf5d5dbb26 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1219,6 +1219,7 @@ static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
 int regmap_get_val_bytes(struct regmap *map);
 int regmap_get_max_register(struct regmap *map);
 int regmap_get_reg_stride(struct regmap *map);
+bool regmap_might_sleep(struct regmap *map);
 int regmap_async_complete(struct regmap *map);
 bool regmap_can_raw_write(struct regmap *map);
 size_t regmap_get_raw_read_max(struct regmap *map);
@@ -1905,6 +1906,12 @@ static inline int regmap_get_reg_stride(struct regmap *map)
 	return -EINVAL;
 }
 
+static inline bool regmap_might_sleep(struct regmap *map)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return true;
+}
+
 static inline int regcache_sync(struct regmap *map)
 {
 	WARN_ONCE(1, "regmap API is disabled");
-- 
2.30.2

