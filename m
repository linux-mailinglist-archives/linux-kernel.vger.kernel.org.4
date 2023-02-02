Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2B6882A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjBBPfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjBBPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED2EB60;
        Thu,  2 Feb 2023 07:34:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77C96B821D8;
        Thu,  2 Feb 2023 15:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EBBC4339B;
        Thu,  2 Feb 2023 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351963;
        bh=W8DSv7qgYPkYexbSkX652KXx3YSfXCc85HIqh/JEfEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEAm3L+ScaUXx0lqCOkFb2NbfzMNsEb53lt2SHnoJq4EyD60t5/vFYWVHDVBrUZ/U
         bZcV1Ms0UAHrNOTa5V51qe0DVgjAh53fAEqSeGNA7n3Wib2XwUI47OLrmCtWd8Lcvw
         HDNo01wGlRLaffNIuQMvHNMO19ICuaWcZo+QZp1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] USB: ULPI: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:24 +0100
Message-Id: <20230202153235.2412790-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=gregkh@linuxfoundation.org; h=from:subject; bh=W8DSv7qgYPkYexbSkX652KXx3YSfXCc85HIqh/JEfEs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r0/UVkp89WAn02FrNf9z5yyC/X5mHn9oePvDzi0hp27y zk3z6YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJLMlhmB/+akPvxpemyzeIGJsq6U u+2h9wg5VhrkRdbeb3g1MsnloYhlfM9PVdI3CiDAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/ulpi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 67b780b256a9..a98b2108376a 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -271,7 +271,7 @@ static int ulpi_regs_show(struct seq_file *seq, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(ulpi_regs);
 
-#define ULPI_ROOT debugfs_lookup(KBUILD_MODNAME, NULL)
+static struct dentry *ulpi_root;
 
 static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 {
@@ -301,7 +301,7 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 		return ret;
 	}
 
-	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
+	root = debugfs_create_dir(dev_name(dev), ulpi_root);
 	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_fops);
 
 	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
@@ -349,8 +349,7 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
  */
 void ulpi_unregister_interface(struct ulpi *ulpi)
 {
-	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
-						ULPI_ROOT));
+	debugfs_lookup_and_remove(dev_name(&ulpi->dev), ulpi_root);
 	device_unregister(&ulpi->dev);
 }
 EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
@@ -360,12 +359,11 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
 static int __init ulpi_init(void)
 {
 	int ret;
-	struct dentry *root;
 
-	root = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	ulpi_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
 	ret = bus_register(&ulpi_bus);
 	if (ret)
-		debugfs_remove(root);
+		debugfs_remove(ulpi_root);
 	return ret;
 }
 subsys_initcall(ulpi_init);
@@ -373,7 +371,7 @@ subsys_initcall(ulpi_init);
 static void __exit ulpi_exit(void)
 {
 	bus_unregister(&ulpi_bus);
-	debugfs_remove_recursive(ULPI_ROOT);
+	debugfs_remove(ulpi_root);
 }
 module_exit(ulpi_exit);
 
-- 
2.39.1

