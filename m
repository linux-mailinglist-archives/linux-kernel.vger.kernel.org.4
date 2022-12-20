Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2267D652225
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiLTOOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLTOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:14:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154B231
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:14:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7816146E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E21DC433D2;
        Tue, 20 Dec 2022 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545641;
        bh=cIGyHKTuCS/Vz5KNJx8REJ3tduNkZ8K9Gt4q4PtyC8U=;
        h=From:To:Cc:Subject:Date:From;
        b=D6BDL4+qcOjHM4dp6KlaZfoUh5/zCdKYUxyAuo5hRDC8So2zEBLpGeeRCIK43fKk1
         5SX14NLeKsygPRdArfGtxePFPFOQc8wLOHgkSHau64cwNfO8H0xK0H/d8yRmVwJtdE
         Paid6yWmazy/cp7qGKiTLK8mAvS6tBmoZNhrH8WLTRYSCy+ywQvXtgbGMI1Fa8UXww
         3HJgch1Pk6mvdWr3xYkwuv/H27BTl+yy3sf8a8QC2odJ8p0BJCfxH81WovA4JLkC8w
         z4Thajc0X7/5pyJxOPQadoKy/Tto7ARgV09i4H3n7mB6yLSyiwUMKwldHXuwnv1DD/
         9FR4gqX+T53hw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Date:   Tue, 20 Dec 2022 15:13:34 +0100
Message-Id: <20221220141352.1486360-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
fails to build, as it includes the shared CFI header:

include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
   62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.

linux/mtd/spi-nor.h does not actually need to include cfi.h, so
remove the inclusion here to fix the warning. This uncovers a
missing #include in spi-nor/core.c so add that there to
prevent a different build issue.

Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/spi-nor/core.c  | 1 +
 include/linux/mtd/spi-nor.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d8703d7dfd0a..d67c926bca8b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/math64.h>
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 25765556223a..a3f8cdca90c8 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -7,7 +7,6 @@
 #define __LINUX_MTD_SPI_NOR_H
 
 #include <linux/bitops.h>
-#include <linux/mtd/cfi.h>
 #include <linux/mtd/mtd.h>
 #include <linux/spi/spi-mem.h>
 
-- 
2.35.1

