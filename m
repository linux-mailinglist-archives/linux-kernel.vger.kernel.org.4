Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAB736D32
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjFTNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjFTNWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:22:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E201BC0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687267328; x=1718803328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ioFas3xTWzb8p1vfOgeqS8+ZIZhYvxBAQPoT1srDwhE=;
  b=nOnClQV/m7RrmLVcfehPfOf5h5q2TnkgefqZxaS4N8dlRbNDQlE71mmS
   shEGREAy4VcGL4DNtCRB3CBKJf7290afzhyv5DjUhIJinoIwxxn8myqM2
   IlKwcI/I2WiRkQZRJMtjZllevgsadzs6ewzhymTFbeFEO6Ea7J5Wn/qxd
   mJAFngqHSb4v+SuaHvzX4MN91o1pbzGXlC14mNwWsjgH8qGeun9bDsY3k
   s1p7AvmBra70Cb380PZ1MPv6bHGOuA5JUzu8dox/v+pZGPRgLmEoRfrLh
   4IHidO+1OzESyVqfyvbS/nD7radZEcEn5EPDZCRFGV/rrs6321u2hlMSA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349588298"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="349588298"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691427007"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="691427007"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:20:04 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] mtd: call external _get and _put in right order
Date:   Tue, 20 Jun 2023 16:19:05 +0300
Message-Id: <20230620131905.648089-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620131905.648089-1-alexander.usyskin@intel.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTD provider provides mtd_info object to mtd subsystem.
With kref patch the mtd_info object can be alive after
provider released mtd device.
Fix calling order in _get and _put functions to allow
mtd provider to safely alloc and release mtd object.

Execute:
1) call external _get
2) get_module
3) add internal kref
in the get function and opposite order in the put one.

The _put_device callback should be the last in put
as the master struct memory may be freed in this callback.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/mtdcore.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 84bd1878367d..a5bc60013edf 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1227,21 +1227,20 @@ int __get_mtd_device(struct mtd_info *mtd)
 	struct mtd_info *master = mtd_get_master(mtd);
 	int err;
 
-	if (!try_module_get(master->owner))
-		return -ENODEV;
-
-	kref_get(&mtd->refcnt);
-
 	if (master->_get_device) {
 		err = master->_get_device(mtd);
-
-		if (err) {
-			kref_put(&mtd->refcnt, mtd_device_release);
-			module_put(master->owner);
+		if (err)
 			return err;
-		}
 	}
 
+	if (!try_module_get(master->owner)) {
+		if (master->_put_device)
+			master->_put_device(master);
+		return -ENODEV;
+	}
+
+	kref_get(&mtd->refcnt);
+
 	while (mtd->parent) {
 		if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) || mtd->parent != master)
 			kref_get(&mtd->parent->refcnt);
@@ -1338,13 +1337,14 @@ void __put_mtd_device(struct mtd_info *mtd)
 		mtd = parent;
 	}
 
-	if (master->_put_device)
-		master->_put_device(master);
+	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
+		kref_put(&master->refcnt, mtd_device_release);
 
 	module_put(master->owner);
 
-	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
-		kref_put(&master->refcnt, mtd_device_release);
+	/* must be the last as master can be freed in the _put_device */
+	if (master->_put_device)
+		master->_put_device(master);
 }
 EXPORT_SYMBOL_GPL(__put_mtd_device);
 
-- 
2.34.1

