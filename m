Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CADE68ED90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBHLOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjBHLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:13:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89D241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06D83B81D46
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BADC433EF;
        Wed,  8 Feb 2023 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854833;
        bh=ychY1J5WSesr6sQtBQnxVfi2sV70iiUsiWGPmVif1VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSjFDmhsDRvMOxUhEZWiJFylPlTqVyX8IOgD+FhB9HC7NbIP0kYpCCK8OXTaYcj9v
         8so4eeW/i66cxK0Lr4ecSPKX+Vl1kzb6/1tsaYaSWpGfTKuvW0xf5/Iwqpi4d3hPUA
         I3BY6GRgWmT8mP3V/9jxJg7TuibMZExeS76g64Dg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 12/21] driver core: bus: bus iterator cleanups
Date:   Wed,  8 Feb 2023 12:13:21 +0100
Message-Id: <20230208111330.439504-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2685; i=gregkh@linuxfoundation.org; h=from:subject; bh=ychY1J5WSesr6sQtBQnxVfi2sV70iiUsiWGPmVif1VU=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm29Evz5zy2YWW5b2vfquX9KWs+NYsz7wcBxWYLK2dBX/ ULKrI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbiwsWwYHfaodlrHB8vZXz69fhmmw bJCO7D1xkWHOe6a7d2XcFsPs54Z6cdTb7WQfp1AA==
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

Convert the bus_for_each_dev(), bus_find_device, and bus_for_each_drv()
functions to use bus_to_subsys() and not use the back-pointer to the
private structure.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index b594804c716d..c007524151d2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -355,18 +355,20 @@ static struct device *next_device(struct klist_iter *i)
 int bus_for_each_dev(const struct bus_type *bus, struct device *start,
 		     void *data, int (*fn)(struct device *, void *))
 {
+	struct subsys_private *sp = bus_to_subsys(bus);
 	struct klist_iter i;
 	struct device *dev;
 	int error = 0;
 
-	if (!bus || !bus->p)
+	if (!sp)
 		return -EINVAL;
 
-	klist_iter_init_node(&bus->p->klist_devices, &i,
+	klist_iter_init_node(&sp->klist_devices, &i,
 			     (start ? &start->p->knode_bus : NULL));
 	while (!error && (dev = next_device(&i)))
 		error = fn(dev, data);
 	klist_iter_exit(&i);
+	subsys_put(sp);
 	return error;
 }
 EXPORT_SYMBOL_GPL(bus_for_each_dev);
@@ -390,18 +392,20 @@ struct device *bus_find_device(const struct bus_type *bus,
 			       struct device *start, const void *data,
 			       int (*match)(struct device *dev, const void *data))
 {
+	struct subsys_private *sp = bus_to_subsys(bus);
 	struct klist_iter i;
 	struct device *dev;
 
-	if (!bus || !bus->p)
+	if (!sp)
 		return NULL;
 
-	klist_iter_init_node(&bus->p->klist_devices, &i,
+	klist_iter_init_node(&sp->klist_devices, &i,
 			     (start ? &start->p->knode_bus : NULL));
 	while ((dev = next_device(&i)))
 		if (match(dev, data) && get_device(dev))
 			break;
 	klist_iter_exit(&i);
+	subsys_put(sp);
 	return dev;
 }
 EXPORT_SYMBOL_GPL(bus_find_device);
@@ -440,18 +444,20 @@ static struct device_driver *next_driver(struct klist_iter *i)
 int bus_for_each_drv(const struct bus_type *bus, struct device_driver *start,
 		     void *data, int (*fn)(struct device_driver *, void *))
 {
+	struct subsys_private *sp = bus_to_subsys(bus);
 	struct klist_iter i;
 	struct device_driver *drv;
 	int error = 0;
 
-	if (!bus)
+	if (!sp)
 		return -EINVAL;
 
-	klist_iter_init_node(&bus->p->klist_drivers, &i,
+	klist_iter_init_node(&sp->klist_drivers, &i,
 			     start ? &start->p->knode_bus : NULL);
 	while ((drv = next_driver(&i)) && !error)
 		error = fn(drv, data);
 	klist_iter_exit(&i);
+	subsys_put(sp);
 	return error;
 }
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
-- 
2.39.1

