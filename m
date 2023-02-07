Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE468CC04
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjBGBmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBGBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:42:15 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE28EF92
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:13 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x26-20020aa793ba000000b0059a7d7fee19so3958654pff.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qilJcjCuMQ+UEcym7b4h9C92RRJ6Qj6pHG5dlY6nsNI=;
        b=W3xpeO/Rx34noJBz5nd6A4bxsUDyoqIhh7Cb2x3UmXZsoK8ED+AALcboiCZqoyinys
         1toeCq44NyFwUzZ+gzQLgSl+KCNP+GEf6kLLEg+JXta1FpZzeLUU2keUV7ERvssI1FOu
         hpIoNUBWt2EucoDAErFvCDxGsmVEr2TJ6EKK7+n9BQxjio75CJwBibBIhOgfvSYZL/gy
         afaIUUJIivpS9OSgOyPy1/Ekhq88quTU3lpmMYtruya4C6g0GeUFX8y9KkixEga6+mtF
         BrJdWYEvqyNBme4s39lZ7YjVtDKbb6Vre9yguxW8VdqTPi5yoBdDTn8iTA1PZhhsB6Kx
         CwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qilJcjCuMQ+UEcym7b4h9C92RRJ6Qj6pHG5dlY6nsNI=;
        b=XvCGKuAJqPzaOM4Qkhq+6g/0S1Od2a56KMifIWC+gzzcwSatdGFHSKZO4WE0r5IIVP
         WAAABKC6YLP8Nnyx7pd/8lsHKTdPw1MHEp27mx7WEThc/L5w0hrxv4EiTco2K4C25ZgD
         aJkd1BQo5fwjSbUgTn7Ylpx6C/cVRSUTDF5EKbabBTl8Bwi1blVY6kc1xSGQmM6Yp2Uk
         2RV0aCS8QG4OKMzXOMBAyJ8HMbu+UyHPNHo0nRMzqgGS0F1P+Pmh2yva0LC5eTsa2h/C
         xp5UrbhflvY6COu7/SveZH8W/LFd9mDWYCzdyT3Ch+KhDr0JOBQfDXvPmdm9O7mecVrI
         lf7Q==
X-Gm-Message-State: AO0yUKVPsBz8KpdKmyX63awEhvLBiEdM0HvWBOuIA05Kf7G7aj3/COWa
        DNnfo3Ek68VG3nDsAbj1Hj0x+iuR/OpIvwo=
X-Google-Smtp-Source: AK7set9WA6uQ/1FNztyQpvzAT03IkHDfAC4BORG9y1kTW3w7tVvng8KdB/nV5PiGcKyoyrHyfOxaYgRn3+dBCkM=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90a:bd04:b0:215:f80c:18e6 with SMTP
 id y4-20020a17090abd0400b00215f80c18e6mr4002191pjr.45.1675734133267; Mon, 06
 Feb 2023 17:42:13 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:41:53 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-2-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 01/12] driver core: fw_devlink: Don't purge child fwnode's
 consumer links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=" <rafal@milecki.pl>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device X is bound successfully to a driver, if it has a child
firmware node Y that doesn't have a struct device created by then, we
delete fwnode links where the child firmware node Y is the supplier. We
did this to avoid blocking the consumers of the child firmware node Y
from deferring probe indefinitely.

While that a step in the right direction, it's better to make the
consumers of the child firmware node Y to be consumers of the device X
because device X is probably implementing whatever functionality is
represented by child firmware node Y. By doing this, we capture the
device dependencies more accurately and ensure better
probe/suspend/resume ordering.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/core.c | 97 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..001e1914858d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -54,11 +54,12 @@ static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
 static bool fw_devlink_is_permissive(void);
+static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
 
 /**
- * fwnode_link_add - Create a link between two fwnode_handles.
+ * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
  * @sup: Supplier end of the link.
  *
@@ -74,22 +75,18 @@ static bool fw_devlink_best_effort;
  * Attempts to create duplicate links between the same pair of fwnode handles
  * are ignored and there is no reference counting.
  */
-int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
+static int __fwnode_link_add(struct fwnode_handle *con,
+			     struct fwnode_handle *sup)
 {
 	struct fwnode_link *link;
-	int ret = 0;
-
-	mutex_lock(&fwnode_link_lock);
 
 	list_for_each_entry(link, &sup->consumers, s_hook)
 		if (link->consumer == con)
-			goto out;
+			return 0;
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
-	if (!link) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!link)
+		return -ENOMEM;
 
 	link->supplier = sup;
 	INIT_LIST_HEAD(&link->s_hook);
@@ -100,9 +97,17 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 	list_add(&link->c_hook, &con->suppliers);
 	pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
 		 con, sup);
-out:
-	mutex_unlock(&fwnode_link_lock);
 
+	return 0;
+}
+
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
+{
+	int ret;
+
+	mutex_lock(&fwnode_link_lock);
+	ret = __fwnode_link_add(con, sup);
+	mutex_unlock(&fwnode_link_lock);
 	return ret;
 }
 
@@ -181,6 +186,51 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
 
+/**
+ * __fwnode_links_move_consumers - Move consumer from @from to @to fwnode_handle
+ * @from: move consumers away from this fwnode
+ * @to: move consumers to this fwnode
+ *
+ * Move all consumer links from @from fwnode to @to fwnode.
+ */
+static void __fwnode_links_move_consumers(struct fwnode_handle *from,
+					  struct fwnode_handle *to)
+{
+	struct fwnode_link *link, *tmp;
+
+	list_for_each_entry_safe(link, tmp, &from->consumers, s_hook) {
+		__fwnode_link_add(link->consumer, to);
+		__fwnode_link_del(link);
+	}
+}
+
+/**
+ * __fw_devlink_pickup_dangling_consumers - Pick up dangling consumers
+ * @fwnode: fwnode from which to pick up dangling consumers
+ * @new_sup: fwnode of new supplier
+ *
+ * If the @fwnode has a corresponding struct device and the device supports
+ * probing (that is, added to a bus), then we want to let fw_devlink create
+ * MANAGED device links to this device, so leave @fwnode and its descendant's
+ * fwnode links alone.
+ *
+ * Otherwise, move its consumers to the new supplier @new_sup.
+ */
+static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
+						   struct fwnode_handle *new_sup)
+{
+	struct fwnode_handle *child;
+
+	if (fwnode->dev && fwnode->dev->bus)
+		return;
+
+	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	__fwnode_links_move_consumers(fwnode, new_sup);
+
+	fwnode_for_each_available_child_node(fwnode, child)
+		__fw_devlink_pickup_dangling_consumers(child, new_sup);
+}
+
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
@@ -1267,16 +1317,23 @@ void device_links_driver_bound(struct device *dev)
 	 * them. So, fw_devlink no longer needs to create device links to any
 	 * of the device's suppliers.
 	 *
-	 * Also, if a child firmware node of this bound device is not added as
-	 * a device by now, assume it is never going to be added and make sure
-	 * other devices don't defer probe indefinitely by waiting for such a
-	 * child device.
+	 * Also, if a child firmware node of this bound device is not added as a
+	 * device by now, assume it is never going to be added. Make this bound
+	 * device the fallback supplier to the dangling consumers of the child
+	 * firmware node because this bound device is probably implementing the
+	 * child firmware node functionality and we don't want the dangling
+	 * consumers to defer probe indefinitely waiting for a device for the
+	 * child firmware node.
 	 */
 	if (dev->fwnode && dev->fwnode->dev == dev) {
 		struct fwnode_handle *child;
 		fwnode_links_purge_suppliers(dev->fwnode);
+		mutex_lock(&fwnode_link_lock);
 		fwnode_for_each_available_child_node(dev->fwnode, child)
-			fw_devlink_purge_absent_suppliers(child);
+			__fw_devlink_pickup_dangling_consumers(child,
+							       dev->fwnode);
+		__fw_devlink_link_to_consumers(dev);
+		mutex_unlock(&fwnode_link_lock);
 	}
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
@@ -1855,7 +1912,11 @@ static int fw_devlink_create_devlink(struct device *con,
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
-	sup_dev = get_dev_from_fwnode(sup_handle);
+	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
+		sup_dev = fwnode_get_next_parent_dev(sup_handle);
+	else
+		sup_dev = get_dev_from_fwnode(sup_handle);
+
 	if (sup_dev) {
 		/*
 		 * If it's one of those drivers that don't actually bind to
-- 
2.39.1.519.gcb327c4b5f-goog

