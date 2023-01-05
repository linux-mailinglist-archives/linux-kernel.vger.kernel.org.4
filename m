Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3965EDD0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjAENtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjAENtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:49:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8173F100
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:47:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F22861A8E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D14FC433F2;
        Thu,  5 Jan 2023 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926456;
        bh=g5Ktac+x1WGnROCjyNkddZbbPKWiUR9G99wt906iw8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gViws4OEe4zM6qcAS0UnXS2+/1WszliXtvKxww8VZLvGh98sQBsfici0N9eZxla9K
         ecWwuQNy64kkQ5m+503yV7Mr4GfjC4lRogui6olzhYA8eGwpnH8YVg1pd0gqbszlsK
         Ia7XTX3rFDgkez3DJmAIqM/9c3XSNHvYrqHUFXFxs86MhozWMtPDAuGv2HeatyVSKa
         bZjXe7swuB2k1P4RI9bAHLaI6xPVBA/E44hTVo57SmRpmuR0VfV6flGWJ9FqwaGJrl
         mCsvt57IhfFJmTHiyTgW0ZxyaGRPbsG+TNzTgEvFCXI+KvB8tEvmaeaX802mU9+d/R
         fi3IctlTmQaqA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 20/27] mtd: remove tmio_nand driver
Date:   Thu,  5 Jan 2023 14:46:15 +0100
Message-Id: <20230105134622.254560-21-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
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

With the TMIO MFD drivers gone, the NAND support is also
obsolete and can be removed.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/Kconfig     |   7 -
 drivers/mtd/nand/raw/Makefile    |   1 -
 drivers/mtd/nand/raw/tmio_nand.c | 533 -------------------------------
 3 files changed, 541 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/tmio_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 048b1c8f08ee..170f1185ddc4 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -193,13 +193,6 @@ config MTD_NAND_PASEMI
 	  Enables support for NAND Flash interface on PA Semi PWRficient
 	  based boards
 
-config MTD_NAND_TMIO
-	tristate "Toshiba Mobile IO NAND controller"
-	depends on MFD_TMIO
-	help
-	  Support for NAND flash connected to a Toshiba Mobile IO
-	  Controller in some PDAs, including the Sharp SL6000x.
-
 source "drivers/mtd/nand/raw/brcmnand/Kconfig"
 
 config MTD_NAND_BCM47XXNFLASH
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index fa1d00120310..917cdfb815b9 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -23,7 +23,6 @@ omap2_nand-objs := omap2.o
 obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_MARVELL)		+= marvell_nand.o
-obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
 obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
 obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
deleted file mode 100644
index 8f1a42bf199c..000000000000
-- 
2.39.0

