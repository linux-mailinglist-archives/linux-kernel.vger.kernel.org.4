Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B4A67DA52
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjA0AMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjA0AL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:11:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422666FA7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:11:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w70-20020a25df49000000b00803e799d7b1so3693549ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUy3vn0JsDKmhRuGP9+/K1d0/yH+PgOpjgx2vmihOA8=;
        b=CMhc9OyQizqhc5ly4bJTX2Z+Bridgomhtwlh4oD+Nl4FNpsWYeJjXbh2grwhhW4pQz
         hESsNvROwG3kH3WEu5JT9F6NZABhbDn7i+eaTHxg+5V/TkFQWvjlM6NZB5+73raHYZ4B
         sLWSTQ8Hpwc3psAi6mWaU/Mk61iRkuT18M5Vd8hThcTBT+7QulXGZRKn3iN6FA46zx9f
         kzrZesMEzxZSU2ClTBC5w+qQCTsS3jv9ajFAD5J6TQQTWU4nSy70G/2uuK4/u7wLxtcM
         V7cLcLtq2xU+2tvuhs4fkbCtIaZb2f19VAPVKMPZ4Tu67cLS0wytb/QHEXvIb+5TqOD1
         Onxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUy3vn0JsDKmhRuGP9+/K1d0/yH+PgOpjgx2vmihOA8=;
        b=ns5thA4taEwa2at/Bygadry3BjwpdetWr6pgWIuJ1mllEj7Q8MiZNwwgBZi22cvYfz
         zyvzXt/G9KNZ207vx6LkTbB9KWV+Cq3PUDWPn61j6DdOHuOEeYdIz/BbuXOQ6ttMfVhe
         J4EXj7wVVi3mgccNz9QTOEf+JKSAu/vPrmz2EzETXMCzN9qaNL2QcK9HzkVvTOpAOLwi
         VhdmFGp35A9ASlm+aT6Mll5wMD7QlLoCOibLPhoNh5qHSbkh/mLmaTrX9PKUYD37oiz3
         +hfGBiLiN6isKQND8i2hu1jJB6UbYZg/vrMO20fI/Tn6ZI9Ki6F2AWKQv45uzZ3jF/Rh
         qNog==
X-Gm-Message-State: AO0yUKUeD1h1zFm+FDhy8jqwfgkI3sRPRBVhBQUKHFsmU1lyMkx0Uc8i
        hPbRWxVGEcqBjfCW3jjaxRKJEmlL+rz02fA=
X-Google-Smtp-Source: AK7set8Dnw1IaAIc7yHxPQu47wes39pUphgYHS+WmBjxLBuDuO6D1xENyWQaTQZ6WPur8dwh0trpzpXbXX6ocxQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a0d:cacc:0:b0:506:3aca:6ff6 with SMTP id
 m195-20020a0dcacc000000b005063aca6ff6mr2161860ywd.213.1674778307328; Thu, 26
 Jan 2023 16:11:47 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:28 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-2-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 01/11] driver core: fw_devlink: Don't purge child fwnode's
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
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
---
 drivers/base/core.c | 97 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..b6d98cc82f26 100644
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
+	int ret = 0;
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
2.39.1.456.gfc5497dd1b-goog

