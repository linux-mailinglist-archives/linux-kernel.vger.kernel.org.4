Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196FE68ED9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjBHLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBHLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38028241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB05B81BA8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F15CC4339B;
        Wed,  8 Feb 2023 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854848;
        bh=B7WITxVzELZ3wop+vrAk9NTxAUXnX7ba5996lVEFsFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVaV2kT6gNoihEJxAuOAnBYRCGOgnC9+WZOJSNBT5tJGyt2sOq4DTtipk5KNc5sPj
         S0WpZWO2XpEMRhuyx86ihS7rpKo9L6pgSsmMNKTwiWFtuu4KXjAzkH4PTfbi0aQcuS
         v1DXYosI8YEEPKJFtInKZHjeFonjZK5VqC7QIxGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 17/21] driver core: remove private pointer from struct bus_type
Date:   Wed,  8 Feb 2023 12:13:26 +0100
Message-Id: <20230208111330.439504-18-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=gregkh@linuxfoundation.org; h=from:subject; bh=B7WITxVzELZ3wop+vrAk9NTxAUXnX7ba5996lVEFsFU=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm29uX7Khc97OT+/S58nqCRc9cW1xD1Z4Zb3zJrN0wPKZ 7ZH7O2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiT4IZ5mdfFX5l2r7j8JWf2zkqnu eV3frLHMKwYF3KniDb6uBLLQ5zTbxTsi6fZPJxBgA=
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

Now that the driver code has been refactored to not rely on the pointer
from a struct bus_type to the private structure it can be safely removed
from the structure entirely.

This will allow most bus_type structures to now be marked as const.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 4 ----
 include/linux/device/bus.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 481fb3f41a42..76cfe9cbf3bd 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -205,11 +205,9 @@ EXPORT_SYMBOL_GPL(bus_remove_file);
 static void bus_release(struct kobject *kobj)
 {
 	struct subsys_private *priv = to_subsys_private(kobj);
-	struct bus_type *bus = priv->bus;
 
 	lockdep_unregister_key(&priv->lock_key);
 	kfree(priv);
-	bus->p = NULL;
 }
 
 static struct kobj_type bus_ktype = {
@@ -854,7 +852,6 @@ int bus_register(struct bus_type *bus)
 		return -ENOMEM;
 
 	priv->bus = bus;
-	bus->p = priv;
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&priv->bus_notifier);
 
@@ -917,7 +914,6 @@ int bus_register(struct bus_type *bus)
 	kset_unregister(&priv->subsys);
 out:
 	kfree(priv);
-	bus->p = NULL;
 	return retval;
 }
 EXPORT_SYMBOL_GPL(bus_register);
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index f6537f5fc535..22bf63469275 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -66,8 +66,6 @@ struct fwnode_handle;
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
  *              driver implementations to a bus and allow the driver to do
  *              bus-specific setup
- * @p:		The private data of the driver core, only the driver core can
- *		touch this.
  * @lock_key:	Lock class key for use by the lock validator
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
@@ -111,8 +109,6 @@ struct bus_type {
 
 	const struct iommu_ops *iommu_ops;
 
-	struct subsys_private *p;
-
 	bool need_parent_lock;
 };
 
-- 
2.39.1

