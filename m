Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3516546A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiLVTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiLVTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:33:12 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87E17E1D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:33:11 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p8RJW-0004V0-0C;
        Thu, 22 Dec 2022 20:33:10 +0100
Date:   Thu, 22 Dec 2022 19:33:04 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] mtd: ubi: wire-up parent MTD device
Message-ID: <39de7617513dfae3a0183b74aac119fbdc5141e9.1671737443.git.daniel@makrotopia.org>
References: <cover.1671737443.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1671737443.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the device parent pointer of UBI devices to their lower MTD
device, typically an MTD partition or whole-chip device.

The most noticeable change is that in sysfs, previously ubi devices
would be could in /sys/devices/virtual/ubi while after this change they
would be correctly attached to their parent MTD device, e.g.

/sys/devices/platform/1100d000.spi/spi_master/spi1/spi1.0/mtd/mtd2/ubi0.

Locating UBI devices using /sys/class/ubi/ of course still works as
well.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 5e90a4423b699..0904eb40c95fa 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -915,6 +915,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 	ubi->dev.release = dev_release;
 	ubi->dev.class = &ubi_class;
 	ubi->dev.groups = ubi_dev_groups;
+	ubi->dev.parent = &mtd->dev;
 
 	ubi->mtd = mtd;
 	ubi->ubi_num = ubi_num;
-- 
2.39.0

