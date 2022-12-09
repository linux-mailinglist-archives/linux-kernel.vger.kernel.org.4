Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48300647B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLIBdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLIBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:33:28 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244D86F5C;
        Thu,  8 Dec 2022 17:33:27 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id 7EE852024C; Fri,  9 Dec 2022 09:33:22 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670549602;
        bh=IkGVS2PJsNQ8Fz8xWlYZQ0kWD9mENnWbK7wsUfipyCE=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=W5dBrtKGyoCUCd2wO3m9YX5eKIvbdHgOV3OvhM0Ad67I9VCz+f9jvHn3fP6Py9XEt
         B202ka2cyxF+FK/Ngv2HiV72noahjwOhwBnDtodvIM+zi6EItTEvw96JMQ5i9Gq8E9
         Gwrd/FlNL8JI7gBerXXviTKdteA7sRMvgQvFSFQgpBe7/7ZdtZp9rlcQWTEJbRsa9n
         0FEonYEXcpJaoR7j1CxT2GBNZ20qvzbWVX3cFT8Zh8B93qAxEDkketEB393+Y7rQE0
         OaTInq6Pb7QyZ/2tWUnijhtPWC9xNpsWrBF4JJHgIp9Kf5/Au1zEK3tYAB9EztKDc0
         E8w+Id42UfUZg==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC PATCH v2 2/3] regmap: mmio: allow reset control in a MMIO regmap
Date:   Fri,  9 Dec 2022 09:33:08 +0800
Message-Id: <20221209013309.407879-3-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221209013309.407879-1-jk@codeconstruct.com.au>
References: <20221209013309.407879-1-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A syscon device may need to be taken out of reset before functioning -
this change adds a facility to attach a reset control to a mmio regmap,
and performs the necessary deassert/assert operations on the reset
controller on attach/detach.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/base/regmap/regmap-mmio.c | 22 ++++++++++++++++++++++
 include/linux/regmap.h            |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 3ccdd86a97e7..e2611de73b42 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/reset.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/swab.h>
@@ -22,6 +23,8 @@ struct regmap_mmio_context {
 	bool attached_clk;
 	struct clk *clk;
 
+	struct reset_control *reset;
+
 	void (*reg_write)(struct regmap_mmio_context *ctx,
 			  unsigned int reg, unsigned int val);
 	unsigned int (*reg_read)(struct regmap_mmio_context *ctx,
@@ -633,4 +636,23 @@ void regmap_mmio_detach_clk(struct regmap *map)
 }
 EXPORT_SYMBOL_GPL(regmap_mmio_detach_clk);
 
+int regmap_mmio_attach_reset(struct regmap *map, struct reset_control *reset)
+{
+	struct regmap_mmio_context *ctx = map->bus_context;
+
+	ctx->reset = reset;
+
+	return reset_control_deassert(ctx->reset);
+}
+EXPORT_SYMBOL_GPL(regmap_mmio_attach_reset);
+
+void regmap_mmio_detach_reset(struct regmap *map)
+{
+	struct regmap_mmio_context *ctx = map->bus_context;
+
+	reset_control_assert(ctx->reset);
+	ctx->reset = NULL;
+}
+EXPORT_SYMBOL_GPL(regmap_mmio_detach_reset);
+
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index ca3434dca3a0..b0c7a747c06f 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -34,6 +34,7 @@ struct spmi_device;
 struct regmap;
 struct regmap_range_cfg;
 struct regmap_field;
+struct reset_control;
 struct snd_ac97;
 struct sdw_slave;
 
@@ -1150,6 +1151,8 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
 void regmap_mmio_detach_clk(struct regmap *map);
+int regmap_mmio_attach_reset(struct regmap *map, struct reset_control *reset);
+void regmap_mmio_detach_reset(struct regmap *map);
 void regmap_exit(struct regmap *map);
 int regmap_reinit_cache(struct regmap *map,
 			const struct regmap_config *config);
-- 
2.35.1

