Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75056546BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiLVTe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiLVTeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:34:04 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4227CD4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:33:38 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p8RJw-0004VD-2o;
        Thu, 22 Dec 2022 20:33:37 +0100
Date:   Thu, 22 Dec 2022 19:33:31 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] mtd: ubi: block: wire-up device parent
Message-ID: <b60c5e252c34d12754cde09b25d3028690aa12e3.1671737443.git.daniel@makrotopia.org>
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

ubiblock devices were previously only identifyable by their name, but
not connected to their parent UBI volume device e.g. in sysfs.
Properly parent ubiblock device as descendant of a UBI volume device
to reflect device model hierachy.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/block.c | 2 +-
 drivers/mtd/ubi/kapi.c  | 1 +
 include/linux/mtd/ubi.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index d725215ae66e5..e99b29ba48dc4 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -455,7 +455,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	list_add_tail(&dev->list, &ubiblock_devices);
 
 	/* Must be the last step: anyone can call file ops from now on */
-	ret = add_disk(dev->gd);
+	ret = device_add_disk(vi->dev, dev->gd, NULL);
 	if (ret)
 		goto out_destroy_wq;
 
diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index 0fce99ff29b58..5db653eacbd45 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -79,6 +79,7 @@ void ubi_do_get_volume_info(struct ubi_device *ubi, struct ubi_volume *vol,
 	vi->name_len = vol->name_len;
 	vi->name = vol->name;
 	vi->cdev = vol->cdev.dev;
+	vi->dev = &vol->dev;
 }
 
 /**
diff --git a/include/linux/mtd/ubi.h b/include/linux/mtd/ubi.h
index 7d48ea368c5e5..a529347fd75b2 100644
--- a/include/linux/mtd/ubi.h
+++ b/include/linux/mtd/ubi.h
@@ -110,6 +110,7 @@ struct ubi_volume_info {
 	int name_len;
 	const char *name;
 	dev_t cdev;
+	struct device *dev;
 };
 
 /**
-- 
2.39.0

