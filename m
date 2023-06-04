Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A928A721494
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFDE0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFDE0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:26:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E43B1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 21:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C1DF60B9F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 04:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D2BC433D2;
        Sun,  4 Jun 2023 04:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685852762;
        bh=uTyogFEYDmuDrlKpwoWEIQcvVLMVsdGuObp2WIschWM=;
        h=From:To:Cc:Subject:Date:From;
        b=h0R8cHoKxQKwLauS8DpXnePYwHktmrLF7t9qxCVrt8ORJkWOCf9y4qAKZ5oZkuz2D
         erCDgn8wPDmV0pK1oFn65IWW/uB/llIjGiii5jSMV4n7Nlhv8GopbS0cEvGKue/rhb
         e+7EwayIBW4PZMIUfw8MMPAOHb2NDhKJOislwTtOs4Ylj9VLDsYp8AHNy+o+x59YfV
         1mK71oUtvPRU+e+jvCWi3J3gpGtnINWIKrEP+ugY6goUD1K0J4zOGEWNmdLBGGEPSG
         3ve0ZX/fZbM4OntSoZVUoV+SfG1Rri1X3R7nODSEVZXeNNsoHcLf4PDLZfy8liJYEz
         Fm6bCYWWtvB/w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Subject: [PATCH 1/2] mfd: rsmu: fix mixed module-builtin object
Date:   Sun,  4 Jun 2023 13:25:56 +0900
Message-Id: <20230604042557.900590-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_MFD_RSMU_I2C=m and CONFIG_MFD_RSMU_SPI=y (or vice versa),
rsmu_core.o is linked to a module and also to vmlinux even though the
expected CFLAGS are different between builtins and modules.

This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
Fixing mixed module-builtin objects").

Split rsmu-core into a separate module.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/mfd/Kconfig     | 8 ++++++--
 drivers/mfd/Makefile    | 6 ++++--
 drivers/mfd/rsmu_core.c | 3 +++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e90463c4441c..1b2eeb654e91 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2215,10 +2215,14 @@ config MFD_INTEL_M10_BMC_PMCI
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_RSMU_CORE
+	tristate
+	select MFD_CORE
+
 config MFD_RSMU_I2C
 	tristate "Renesas Synchronization Management Unit with I2C"
 	depends on I2C && OF
-	select MFD_CORE
+	select MFD_RSMU_CORE
 	select REGMAP_I2C
 	help
 	  Support for the Renesas Synchronization Management Unit, such as
@@ -2232,7 +2236,7 @@ config MFD_RSMU_I2C
 config MFD_RSMU_SPI
 	tristate "Renesas Synchronization Management Unit with SPI"
 	depends on SPI && OF
-	select MFD_CORE
+	select MFD_RSMU_CORE
 	select REGMAP_SPI
 	help
 	  Support for the Renesas Synchronization Management Unit, such as
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 1d2392f06f78..2a0e80f941a1 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -271,7 +271,9 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
 
-rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
-rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
+rsmu-core-objs			:= rsmu_core.o
+rsmu-i2c-objs			:= rsmu_i2c.o
+rsmu-spi-objs			:= rsmu_spi.o
+obj-$(CONFIG_MFD_RSMU_CORE)	+= rsmu-core.o
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu_core.c
index 29437fd0bd5b..5bf1e23a47e5 100644
--- a/drivers/mfd/rsmu_core.c
+++ b/drivers/mfd/rsmu_core.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas Company.
  */
 
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
@@ -78,11 +79,13 @@ int rsmu_core_init(struct rsmu_ddata *rsmu)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rsmu_core_init);
 
 void rsmu_core_exit(struct rsmu_ddata *rsmu)
 {
 	mutex_destroy(&rsmu->lock);
 }
+EXPORT_SYMBOL_GPL(rsmu_core_exit);
 
 MODULE_DESCRIPTION("Renesas SMU core driver");
 MODULE_LICENSE("GPL");
-- 
2.39.2

