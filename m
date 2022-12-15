Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904CA64DEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiLOQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLOQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:47:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732C165AF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:47:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7FC161E5D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C4C433D2;
        Thu, 15 Dec 2022 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122862;
        bh=YUTvOViTEdKdQKeqBkH6WtxB3+C/WVCbQ+PFsOp/k7A=;
        h=From:To:Cc:Subject:Date:From;
        b=GHcj65KDlzl2XP7NCHhDA9/5PbRr5c5TpqBNO2oZHVPX3VlO6lUQQ86MOX7miUv31
         PSzRVGAKRNyKtShtg3HycnqVY1bByzxKBtJ8vcvR7WMWlmfzymYJmpp1xtk9bVV+94
         FhNcOmAL4Gxhav9qeEchPQPN2OSfwlWMGehzeUjuPoQQADWFMFDhYEIM7EJCHYGLfB
         AxdcgABB7MQUf942DCp5c/YC3euz/myZakcuK1pyC7AIr9r6fLhZdVptV5QJ2sOKOM
         0JoHiPPlvPENSUMB+dMDaF9OmBPKvfJMVRoWnat7PpRUp76pZmtZegIKZZqAta6TU1
         az85nQ6b9vNtQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Claudius Heine <ch@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: dataflash: remove duplicate SPI ID table
Date:   Thu, 15 Dec 2022 17:47:30 +0100
Message-Id: <20221215164736.1315815-1-arnd@kernel.org>
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

Building with -Werror=override-init revealds that two patches added
the same device ID table to this driver:

drivers/mtd/devices/mtd_dataflash.c:946:27: error: initialized field overwritten [-Werror=override-init]
  946 |         .id_table       = dataflash_spi_ids,
      |                           ^~~~~~~~~~~~~~~~~
drivers/mtd/devices/mtd_dataflash.c:946:27: note: (near initialization for 'dataflash_driver.id_table')

Remove one of the copies.

Fixes: 27a030e87292 ("mtd: dataflash: Add device-tree SPI IDs")
Fixes: ac4f83482afb ("mtd: dataflash: Add SPI ID table")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/devices/mtd_dataflash.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 25bad4318305..3bbaa590c768 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -96,13 +96,6 @@ struct dataflash {
 	struct mtd_info		mtd;
 };
 
-static const struct spi_device_id dataflash_dev_ids[] = {
-	{ "at45" },
-	{ "dataflash" },
-	{ },
-};
-MODULE_DEVICE_TABLE(spi, dataflash_dev_ids);
-
 #ifdef CONFIG_OF
 static const struct of_device_id dataflash_dt_ids[] = {
 	{ .compatible = "atmel,at45", },
@@ -939,8 +932,6 @@ static struct spi_driver dataflash_driver = {
 		.name		= "mtd_dataflash",
 		.of_match_table = of_match_ptr(dataflash_dt_ids),
 	},
-	.id_table = dataflash_dev_ids,
-
 	.probe		= dataflash_probe,
 	.remove		= dataflash_remove,
 	.id_table	= dataflash_spi_ids,
-- 
2.35.1

