Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7564568ED9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjBHLPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjBHLOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565525287
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DC58B81D46
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601A0C433EF;
        Wed,  8 Feb 2023 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854856;
        bh=w9Cbdmyoaf/JjLBQ3AYuTmJo0QBEtgY2/LDU7YMGqM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDO6knpCYdYAoJEPiZsetV8zbmyISrvcV1KILG9NVE1Ut82GnA+DFFpfiZqCiGSJ1
         YCWhuJvETsoHsohDqHDXJWgNni9zoBEoV25vrSwFjRuKc/CSmN3p2rSZqahWCEKFNV
         4Vdoi2BXRHSmQV/sM0ml0VIAKdZ+bHb9tXxFZYE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 02/21] driver core: bus: implement bus_get/put() without the private pointer
Date:   Wed,  8 Feb 2023 12:13:11 +0100
Message-Id: <20230208111330.439504-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3559; i=gregkh@linuxfoundation.org; h=from:subject; bh=w9Cbdmyoaf/JjLBQ3AYuTmJo0QBEtgY2/LDU7YMGqM0=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm6/9nOOb+emMcd66ArG3Luu4nytyrk6//O7lg9tLZm+e kbzockcsC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMZNpXhgXtTGdfnEjZ9Va7V4mDS/ El14Jndi0MC/p+Z8vYB/p3O5SnedZ3N1+zfH7rGwA=
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

In the quest to make 'struct bus_type' constant and in read-only memory,
we need to stop using the private pointer to the subsys_private
structure.  First step in doing this is to create a helper function that
turns a 'struct bus_type' into 'struct subsys_private' called
bus_to_subsys().

bus_to_subsys() walks the list of registered busses in the system and
finds the matching one based on the pointer to the bus_type itself.  As
this is a short list, and this function is not on any fast path, it
should not be noticable.

Implement bus_get() and bus_put() using this new helper function.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 61 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index aa70b3a7d778..d346afa4645c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -24,6 +24,9 @@
 /* /sys/devices/system */
 static struct kset *system_kset;
 
+/* /sys/bus */
+static struct kset *bus_kset;
+
 #define to_bus_attr(_attr) container_of(_attr, struct bus_attribute, attr)
 
 /*
@@ -39,19 +42,63 @@ static struct kset *system_kset;
 static int __must_check bus_rescan_devices_helper(struct device *dev,
 						void *data);
 
+/**
+ * bus_to_subsys - Turn a struct bus_type into a struct subsys_private
+ *
+ * @bus: pointer to the struct bus_type to look up
+ *
+ * The driver core internals needs to work on the subsys_private structure, not
+ * the external struct bus_type pointer.  This function walks the list of
+ * registered busses in the system and finds the matching one and returns the
+ * internal struct subsys_private that relates to that bus.
+ *
+ * Note, the reference count of the return value is INCREMENTED if it is not
+ * NULL.  A call to subsys_put() must be done when finished with the pointer in
+ * order for it to be properly freed.
+ */
+static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
+{
+	struct subsys_private *sp = NULL;
+	struct kobject *kobj;
+
+	if (!bus)
+		return NULL;
+
+	spin_lock(&bus_kset->list_lock);
+
+	if (list_empty(&bus_kset->list))
+		goto done;
+
+	list_for_each_entry(kobj, &bus_kset->list, entry) {
+		struct kset *kset = container_of(kobj, struct kset, kobj);
+
+		sp = container_of_const(kset, struct subsys_private, subsys);
+		if (sp->bus == bus)
+			goto done;
+	}
+	sp = NULL;
+done:
+	sp = subsys_get(sp);
+	spin_unlock(&bus_kset->list_lock);
+	return sp;
+}
+
 static struct bus_type *bus_get(struct bus_type *bus)
 {
-	if (bus) {
-		kset_get(&bus->p->subsys);
+	struct subsys_private *sp = bus_to_subsys(bus);
+
+	if (sp)
 		return bus;
-	}
 	return NULL;
 }
 
-static void bus_put(struct bus_type *bus)
+static void bus_put(const struct bus_type *bus)
 {
-	if (bus)
-		kset_put(&bus->p->subsys);
+	struct subsys_private *sp = bus_to_subsys(bus);
+
+	/* two puts are required as the call to bus_to_subsys incremented it again */
+	subsys_put(sp);
+	subsys_put(sp);
 }
 
 static ssize_t drv_attr_show(struct kobject *kobj, struct attribute *attr,
@@ -177,8 +224,6 @@ static const struct kset_uevent_ops bus_uevent_ops = {
 	.filter = bus_uevent_filter,
 };
 
-static struct kset *bus_kset;
-
 /* Manually detach a device from its associated driver. */
 static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 			    size_t count)
-- 
2.39.1

