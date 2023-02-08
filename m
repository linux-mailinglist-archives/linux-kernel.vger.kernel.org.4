Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47F68F140
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBHOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjBHOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:53:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A03F526E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B885616F0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC4BC433EF;
        Wed,  8 Feb 2023 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675867986;
        bh=cd86XYxF2jYpvg+aqqQ8j2VWQfPNvNV812fP3jecRts=;
        h=From:To:Cc:Subject:Date:From;
        b=HR9ntnbDGUbgd1pjhCQC4d9XISfQhZq2A6GjsBYm3TI/3cMcqCfWhkpiSoq0oKbVL
         jDdV5utgotZAQWp019D6/fLmR6aEg8yjzBKaq+ZBC7yURmh7fYL41wdYq1COPUCnkp
         Qu2hq2JBwcxUqsnKzAroZMSddM4LVTOHVOawT5gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3] mtd: spi-nor: fix memory leak when using debugfs_lookup()
Date:   Wed,  8 Feb 2023 15:53:01 +0100
Message-Id: <20230208145301.2169646-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3341; i=gregkh@linuxfoundation.org; h=from:subject; bh=cd86XYxF2jYpvg+aqqQ8j2VWQfPNvNV812fP3jecRts=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPt3vfZOJl9b5tYT03+pJRGZuwZZBr2OcsB4npU6q7bqnP LZ7SEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABMp5GGYZ9Yz471gBvs67r2uImGXdG fIPE6rY5ifn3CXlevcqVm7XzZOtp12YtWDzGmRAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To solve this, remove the
lookup and create the directory on the first device found, and then
remove it when the module is unloaded.

Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Michael Walle <michael@walle.cc>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3: create the directory the first time it is used, and then remove it
    if it is present when the module is unloaded.  More complex than v2,
    but correct.
v2: fix up to work when module is removed and added, making the fix
    much simpler.

 drivers/mtd/spi-nor/core.c    | 14 +++++++++++++-
 drivers/mtd/spi-nor/core.h    |  2 ++
 drivers/mtd/spi-nor/debugfs.c | 12 +++++++++---
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d67c926bca8b..adf85ce7fdb3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3335,7 +3335,19 @@ static struct spi_mem_driver spi_nor_driver = {
 	.remove = spi_nor_remove,
 	.shutdown = spi_nor_shutdown,
 };
-module_spi_mem_driver(spi_nor_driver);
+
+static int __init spi_nor_module_init(void)
+{
+	return spi_mem_driver_register(&spi_nor_driver);
+}
+module_init(spi_nor_module_init);
+
+static void __exit spi_nor_module_exit(void)
+{
+	spi_nor_debugfs_shutdown();
+	spi_mem_driver_unregister(&spi_nor_driver);
+}
+module_exit(spi_nor_module_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index f03b55cf7e6f..e62cd9964456 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -713,8 +713,10 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 
 #ifdef CONFIG_DEBUG_FS
 void spi_nor_debugfs_register(struct spi_nor *nor);
+void spi_nor_debugfs_shutdown(void);
 #else
 static inline void spi_nor_debugfs_register(struct spi_nor *nor) {}
+static inline void spi_nor_debugfs_shutdown(void) {}
 #endif
 
 #endif /* __LINUX_MTD_SPI_NOR_INTERNAL_H */
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index ff895f6758ea..cd9c2dc07509 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -226,13 +226,13 @@ static void spi_nor_debugfs_unregister(void *data)
 	nor->debugfs_root = NULL;
 }
 
+static struct dentry *rootdir;
+
 void spi_nor_debugfs_register(struct spi_nor *nor)
 {
-	struct dentry *rootdir, *d;
+	struct dentry *d;
 	int ret;
 
-	/* Create rootdir once. Will never be deleted again. */
-	rootdir = debugfs_lookup(SPI_NOR_DEBUGFS_ROOT, NULL);
 	if (!rootdir)
 		rootdir = debugfs_create_dir(SPI_NOR_DEBUGFS_ROOT, NULL);
 
@@ -247,3 +247,9 @@ void spi_nor_debugfs_register(struct spi_nor *nor)
 	debugfs_create_file("capabilities", 0444, d, nor,
 			    &spi_nor_capabilities_fops);
 }
+
+void spi_nor_debugfs_shutdown(void)
+{
+	if (rootdir)
+		debugfs_remove(rootdir);
+}
-- 
2.39.1

