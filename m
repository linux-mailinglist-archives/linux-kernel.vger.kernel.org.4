Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF795F85EC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJHPmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:42:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A14D16C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED91FCE0B7C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 15:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED758C433D6;
        Sat,  8 Oct 2022 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665243750;
        bh=hUl9Ho0IJ88P72RL1ppbkXwLy+WPe+oZZQz0xI2xYDw=;
        h=From:To:Cc:Subject:Date:From;
        b=J0BiuGPFwd4kYvHpLi+eaNh9DPlWtzoL5DsFoLt90zsG206VzVzqoW3SKT/HGht33
         2oBoyeyjJUa/MQ/CkH6ilj49ZpY4qoFutD1GTkNjyOUYMtCWBCKwHdVrhuIuC8D+NK
         bsD50hKFTPOUn37Ah2nuOgJ3AE6gnaUsh02pwui0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: remove devm_device_add_groups() and devm_device_remove_groups()
Date:   Sat,  8 Oct 2022 17:43:10 +0200
Message-Id: <20221008154310.278062-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3814; i=gregkh@linuxfoundation.org; h=from:subject; bh=hUl9Ho0IJ88P72RL1ppbkXwLy+WPe+oZZQz0xI2xYDw=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmOs3r685+obvFUaC8RFVyzbX2U6oyFe/yVthWbrlzWp7ZZ 0O9JRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkgjnDgjY1tVnm5W1Fm6PWyhUm2z YYJgnEMyxYtvrdjtBmpwrzwMLjh1LrLvU7bVoGAA==
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

There are no more in-kernel users of these functions, and no drivers
should be ever using them anyway, so remove them as they are not needed.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    | 62 ------------------------------------------
 include/linux/device.h |  4 ---
 2 files changed, 66 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d02501933467..219826bbd2b6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2599,15 +2599,6 @@ static void devm_attr_group_remove(struct device *dev, void *res)
 	sysfs_remove_group(&dev->kobj, group);
 }
 
-static void devm_attr_groups_remove(struct device *dev, void *res)
-{
-	union device_attr_group_devres *devres = res;
-	const struct attribute_group **groups = devres->groups;
-
-	dev_dbg(dev, "%s: removing groups %p\n", __func__, groups);
-	sysfs_remove_groups(&dev->kobj, groups);
-}
-
 /**
  * devm_device_add_group - given a device, create a managed attribute group
  * @dev:	The device to create the group for
@@ -2657,59 +2648,6 @@ void devm_device_remove_group(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_device_remove_group);
 
-/**
- * devm_device_add_groups - create a bunch of managed attribute groups
- * @dev:	The device to create the group for
- * @groups:	The attribute groups to create, NULL terminated
- *
- * This function creates a bunch of managed attribute groups.  If an error
- * occurs when creating a group, all previously created groups will be
- * removed, unwinding everything back to the original state when this
- * function was called.  It will explicitly warn and error if any of the
- * attribute files being created already exist.
- *
- * Returns 0 on success or error code from sysfs_create_group on failure.
- */
-int devm_device_add_groups(struct device *dev,
-			   const struct attribute_group **groups)
-{
-	union device_attr_group_devres *devres;
-	int error;
-
-	devres = devres_alloc(devm_attr_groups_remove,
-			      sizeof(*devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
-
-	error = sysfs_create_groups(&dev->kobj, groups);
-	if (error) {
-		devres_free(devres);
-		return error;
-	}
-
-	devres->groups = groups;
-	devres_add(dev, devres);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devm_device_add_groups);
-
-/**
- * devm_device_remove_groups - remove a list of managed groups
- *
- * @dev:	The device for the groups to be removed from
- * @groups:	NULL terminated list of groups to be removed
- *
- * If groups is not NULL, remove the specified groups from the device.
- */
-void devm_device_remove_groups(struct device *dev,
-			       const struct attribute_group **groups)
-{
-	WARN_ON(devres_release(dev, devm_attr_groups_remove,
-			       devm_attr_group_match,
-			       /* cast away const */ (void *)groups));
-}
-EXPORT_SYMBOL_GPL(devm_device_remove_groups);
-
 static int device_add_attrs(struct device *dev)
 {
 	struct class *class = dev->class;
diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..fe11db1fd062 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1044,10 +1044,6 @@ static inline void device_remove_group(struct device *dev,
 	return device_remove_groups(dev, groups);
 }
 
-int __must_check devm_device_add_groups(struct device *dev,
-					const struct attribute_group **groups);
-void devm_device_remove_groups(struct device *dev,
-			       const struct attribute_group **groups);
 int __must_check devm_device_add_group(struct device *dev,
 				       const struct attribute_group *grp);
 void devm_device_remove_group(struct device *dev,
-- 
2.38.0

