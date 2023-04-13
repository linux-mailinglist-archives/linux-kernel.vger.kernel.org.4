Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1766E1627
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDMUze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDMUzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05083EA;
        Thu, 13 Apr 2023 13:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AA6664087;
        Thu, 13 Apr 2023 20:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3633DC433D2;
        Thu, 13 Apr 2023 20:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681419329;
        bh=t1d7XeNgX5GcZlgi+EOqXCN2JRp9UZEAZxIDR7stXlg=;
        h=From:To:Cc:Subject:Date:From;
        b=NpjGVP9F/j3kBb2SYkuDj4UxY1EOCIStQoa0yfA8FzoL7o/rcspzD5AlIQluXzf1u
         sSfVe1OKg8s7Q4P9uI6d141Isxd6ZawBdhJgCuJWkM/ew4YCSLpObBCUoRXpJMLMqx
         +ZY6/wAnvqU8gu+eCK6fqhfnCxlgW65/PpDJ5TKzOWIOl6JakVNCmBXwUwZ0P0rS9b
         NoSgNTAfejpi6DRsi8Er717h0XTIVuaddtLtwxOSryZD17iwFSLBZI5Ner1Pz5KSla
         BUtZUB6/bR/bP1jB3+J2Uz+pRHKtsNKRpMT7jU47Vk5TsME/VP7Do3FhcbDIvNPSwa
         +H+Zs4Z9JDQhw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Tommaso Merciai <tomm.merciai@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: [PATCH] clk: starfive: Avoid casting iomem pointers
Date:   Thu, 13 Apr 2023 13:55:28 -0700
Message-ID: <20230413205528.4044216-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use a wrapper struct for the auxiliary_device made in
jh7110_reset_controller_register() so that we can stop casting iomem
pointers. The casts trip up tools like sparse, and make for some awkward
casts that are largely unnecessary. While we're here, change the
allocation from devm and actually free the auxiliary_device memory in
the release function. This avoids any use after free problems where the
parent device driver is unbound from the device but the
auxiliuary_device is still in use accessing devm freed memory.

Cc: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

I can take this via clk tree.

 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 15 ++++++++++++---
 drivers/reset/starfive/reset-starfive-jh7110.c |  9 ++++++---
 include/soc/starfive/reset-starfive-jh71x0.h   | 17 +++++++++++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 include/soc/starfive/reset-starfive-jh71x0.h

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 5ec210644e1d..851b93d0f371 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -11,6 +11,9 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <soc/starfive/reset-starfive-jh71x0.h>
 
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
 
@@ -335,26 +338,32 @@ static void jh7110_reset_unregister_adev(void *_adev)
 	struct auxiliary_device *adev = _adev;
 
 	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
 }
 
 static void jh7110_reset_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
 
-	auxiliary_device_uninit(adev);
+	kfree(rdev);
 }
 
 int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id)
 {
+	struct jh71x0_reset_adev *rdev;
 	struct auxiliary_device *adev;
 	int ret;
 
-	adev = devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
-	if (!adev)
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
 		return -ENOMEM;
 
+	rdev->base = priv->base;
+
+	adev = &rdev->adev;
 	adev->name = adev_name;
 	adev->dev.parent = priv->dev;
 	adev->dev.release = jh7110_reset_adev_release;
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index c1b3a490d951..2d26ae95c8cc 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -7,6 +7,8 @@
 
 #include <linux/auxiliary_bus.h>
 
+#include <soc/starfive/reset-starfive-jh71x0.h>
+
 #include "reset-starfive-jh71x0.h"
 
 #include <dt-bindings/reset/starfive,jh7110-crg.h>
@@ -33,14 +35,15 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
 	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
-	void __iomem **base = (void __iomem **)dev_get_drvdata(adev->dev.parent);
+	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	void __iomem *base = rdev->base;
 
 	if (!info || !base)
 		return -ENODEV;
 
 	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
-					      *base + info->assert_offset,
-					      *base + info->status_offset,
+					      base + info->assert_offset,
+					      base + info->status_offset,
 					      NULL,
 					      info->nr_resets,
 					      NULL);
diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/starfive/reset-starfive-jh71x0.h
new file mode 100644
index 000000000000..47b486ececc5
--- /dev/null
+++ b/include/soc/starfive/reset-starfive-jh71x0.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_STARFIVE_RESET_JH71X0_H
+#define __SOC_STARFIVE_RESET_JH71X0_H
+
+#include <linux/auxiliary_bus.h>
+#include <linux/compiler_types.h>
+#include <linux/container_of.h>
+
+struct jh71x0_reset_adev {
+	void __iomem *base;
+	struct auxiliary_device adev;
+};
+
+#define to_jh71x0_reset_adev(_adev) \
+	container_of((_adev), struct jh71x0_reset_adev, adev)
+
+#endif

base-commit: 601e5d464d535d655917c2cfb29c394d367fb676
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

