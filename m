Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667D468ED95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBHLPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjBHLOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFD303EB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04676B81BA8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9A6C433D2;
        Wed,  8 Feb 2023 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854877;
        bh=STXBzYRIQwSf/bys2o0xrmcAJbSk00T8I4RBfKL6Zbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/+lUkDZS9BnvFgRtMHh53lpSoh/LF/m65q1ZanJfF91f8ks3pLrH2mcmi5XqBxEY
         8wBa4j5bZrlDaS9gAlv59+ZsHqTtfGRS4HtRG5IhhHbijLdWuPd33qi+OqjxqTor+r
         PhAypxQD/hcxq3KvbO2PvosWZVbRfCJbCDN3XXzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 08/21] driver core: bus: subsys_interface_register/unregister() cleanups
Date:   Wed,  8 Feb 2023 12:13:17 +0100
Message-Id: <20230208111330.439504-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3914; i=gregkh@linuxfoundation.org; h=from:subject; bh=STXBzYRIQwSf/bys2o0xrmcAJbSk00T8I4RBfKL6Zbo=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm69/e/uvo3320WMf7+1pf3K50G6WgYls3LkZkna3b//6 +DphdkcsC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMRGohw4Jdu165tvP8YFbbH3P3bf GRrXdPRUUyzM/pCdLQ6I5mOni8mMv8oM4cgyUTswA=
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

Convert the subsys_interface_register and subsys_interface_unregister()
functions to use bus_to_subsys() and not use the back-pointer to the
private structure.

This also requires changing the parameters on subsys_dev_iter_init() to
iterate over the list properly.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 549e55dfbfda..deed62509a62 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1023,7 +1023,7 @@ struct subsys_dev_iter {
 /**
  * subsys_dev_iter_init - initialize subsys device iterator
  * @iter: subsys iterator to initialize
- * @subsys: the subsys we wanna iterate over
+ * @sp: the subsys private (i.e. bus) we wanna iterate over
  * @start: the device to start iterating from, if any
  * @type: device_type of the devices to iterate over, NULL for all
  *
@@ -1032,14 +1032,14 @@ struct subsys_dev_iter {
  * otherwise if it is NULL, the iteration starts at the beginning of
  * the list.
  */
-static void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *subsys,
+static void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct subsys_private *sp,
 				 struct device *start, const struct device_type *type)
 {
 	struct klist_node *start_knode = NULL;
 
 	if (start)
 		start_knode = &start->p->knode_bus;
-	klist_iter_init_node(&subsys->p->klist_devices, &iter->ki, start_knode);
+	klist_iter_init_node(&sp->klist_devices, &iter->ki, start_knode);
 	iter->type = type;
 }
 
@@ -1084,26 +1084,31 @@ static void subsys_dev_iter_exit(struct subsys_dev_iter *iter)
 
 int subsys_interface_register(struct subsys_interface *sif)
 {
-	struct bus_type *subsys;
+	struct subsys_private *sp;
 	struct subsys_dev_iter iter;
 	struct device *dev;
 
 	if (!sif || !sif->subsys)
 		return -ENODEV;
 
-	subsys = bus_get(sif->subsys);
-	if (!subsys)
+	sp = bus_to_subsys(sif->subsys);
+	if (!sp)
 		return -EINVAL;
 
-	mutex_lock(&subsys->p->mutex);
-	list_add_tail(&sif->node, &subsys->p->interfaces);
+	/*
+	 * Reference in sp is now incremented and will be dropped when
+	 * the interface is removed from the bus
+	 */
+
+	mutex_lock(&sp->mutex);
+	list_add_tail(&sif->node, &sp->interfaces);
 	if (sif->add_dev) {
-		subsys_dev_iter_init(&iter, subsys, NULL, NULL);
+		subsys_dev_iter_init(&iter, sp, NULL, NULL);
 		while ((dev = subsys_dev_iter_next(&iter)))
 			sif->add_dev(dev, sif);
 		subsys_dev_iter_exit(&iter);
 	}
-	mutex_unlock(&subsys->p->mutex);
+	mutex_unlock(&sp->mutex);
 
 	return 0;
 }
@@ -1111,26 +1116,34 @@ EXPORT_SYMBOL_GPL(subsys_interface_register);
 
 void subsys_interface_unregister(struct subsys_interface *sif)
 {
-	struct bus_type *subsys;
+	struct subsys_private *sp;
 	struct subsys_dev_iter iter;
 	struct device *dev;
 
 	if (!sif || !sif->subsys)
 		return;
 
-	subsys = sif->subsys;
+	sp = bus_to_subsys(sif->subsys);
+	if (!sp)
+		return;
 
-	mutex_lock(&subsys->p->mutex);
+	mutex_lock(&sp->mutex);
 	list_del_init(&sif->node);
 	if (sif->remove_dev) {
-		subsys_dev_iter_init(&iter, subsys, NULL, NULL);
+		subsys_dev_iter_init(&iter, sp, NULL, NULL);
 		while ((dev = subsys_dev_iter_next(&iter)))
 			sif->remove_dev(dev, sif);
 		subsys_dev_iter_exit(&iter);
 	}
-	mutex_unlock(&subsys->p->mutex);
+	mutex_unlock(&sp->mutex);
 
-	bus_put(subsys);
+	/*
+	 * Decrement the reference count twice, once for the bus_to_subsys()
+	 * call in the start of this function, and the second one from the
+	 * reference increment in subsys_interface_register()
+	 */
+	subsys_put(sp);
+	subsys_put(sp);
 }
 EXPORT_SYMBOL_GPL(subsys_interface_unregister);
 
-- 
2.39.1

