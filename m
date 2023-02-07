Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C668B68CC28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBGBnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjBGBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:43:00 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D8435249
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id h16-20020a63df50000000b004f74bc0c71fso3575302pgj.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRJNJ021j7UgZ8yd2Te0gTbEExX2Q8vfI2YN74+S+Pk=;
        b=dNDuUGRBP6AHiDwbpmxQqlp5/eMem+cgKsBSstj04w5Bsq+orHEudVsHqovBJORYTD
         lDim37xAo+som1CvlE+uWlC5Wi3dO7dR/p372KByV/Rf81Et/iNkZgwEpriQTuskTcoZ
         FkT+rliRLGZaodn9xQ+a02TAQE3jwJ8WQssWp0Xlisqa6QXLET3Hx9LzqafJtwQ4YdI7
         FEtQL0oq01J2gNcCminYJYVwK+sL8QegmmG3kCUgRPPPGJq4UdbIH0DkEfmQ4i8LM+B3
         rkGkVMHqexDkL320QfVBECH7FMSBy7rTsmZg0oSpnNO5gE5wZ1VOPKZBlEzsYIqfaCAz
         MPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRJNJ021j7UgZ8yd2Te0gTbEExX2Q8vfI2YN74+S+Pk=;
        b=nflNjD0vKSeTkiwf7J1Qcu1zo3pzV3z1vNtJKTg24wF+USwpNkalH1hp2OwKnBlTwE
         WRhYby3tmqeGHgc5HYvdmlTrlk90JIXsyarB6gtNJV9AxnzkmwoFON5Xkq6RgRspMAHv
         UhyltK3zpDGm7OcVcXl31muYhCHjZDlv5a80eHSxPQJVPW0f1ZbjkV9H1pc9VG1j8F6F
         MQIoD+I57xXDoZQhKwvkkK8538zW9GgJFcwAIf29yyEZb5fgl85mnx1rLgfGX3GJOpgS
         ZFdfc0gwFef52Fedqt6HB4eSvmsJpGJ9MWUWU4P1xP/+ucMeJ9ixniyfR9FmuMoI65Xx
         x/+Q==
X-Gm-Message-State: AO0yUKW73QdqAPFJLm1AwCZf610nsp+raq/Q1BQEgaaXtHMd3N22NIIo
        CQLpS+jPxl55uCausrb/sCztI9bXCjkYmyU=
X-Google-Smtp-Source: AK7set+JD8rPeC2hegH4ejuI8kh9p9ED2NDjDjOz59Trt1oxF7eZ1XZzrFKU8beum79ewrCq/mRBfrIqCq4zX2k=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a63:9259:0:b0:4db:2ad4:5997 with SMTP id
 s25-20020a639259000000b004db2ad45997mr169546pgn.29.1675734152305; Mon, 06 Feb
 2023 17:42:32 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:42:00 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-9-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 08/12] driver core: fw_devlink: Make cycle detection more robust
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

fw_devlink could only detect a single and simple cycle because it relied
mainly on device link cycle detection code that only checked for cycles
between devices. The expectation was that the firmware wouldn't have
complicated cycles and multiple cycles between devices. That expectation
has been proven to be wrong.

For example, fw_devlink could handle:

+-+        +-+
|A+------> |B+
+-+        +++
 ^          |
 |          |
 +----------+

But it couldn't handle even something as "simple" as:

 +---------------------+
 |                     |
 v                     |
+-+        +-+        +++
|A+------> |B+------> |C|
+-+        +++        +-+
 ^          |
 |          |
 +----------+

But firmware has even more complicated cycles like:

    +---------------------+
    |                     |
    v                     |
   +-+       +---+       +++
+--+A+------>| B +-----> |C|<--+
|  +-+       ++--+       +++   |
|   ^         | ^         |    |
|   |         | |         |    |
|   +---------+ +---------+    |
|                              |
+------------------------------+

And this is without including parent child dependencies or nodes in the
cycle that are just firmware nodes that'll never have a struct device
created for them.

The proper way to treat these devices it to not force any probe ordering
between them, while still enforce dependencies between node in the
cycles (A, B and C) and their consumers.

So this patch goes all out and just deals with all types of cycles. It
does this by:

1. Following dependencies across device links, parent-child and fwnode
   links.
2. When it find cycles, it mark the device links and fwnode links as
   such instead of just deleting them or making the indistinguishable
   from proxy SYNC_STATE_ONLY device links.

This way, when new nodes get added, we can immediately find and mark any
new cycles whether the new node is a device or firmware node.

Fixes: 2de9d8e0d2fe ("driver core: fw_devlink: Improve handling of cyclic dependencies")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/core.c | 248 +++++++++++++++++++++++---------------------
 1 file changed, 129 insertions(+), 119 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e4b60436a4a4..aaf79ea9647c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1866,47 +1866,6 @@ static void fw_devlink_unblock_consumers(struct device *dev)
 	device_links_write_unlock();
 }
 
-/**
- * fw_devlink_relax_cycle - Convert cyclic links to SYNC_STATE_ONLY links
- * @con: Device to check dependencies for.
- * @sup: Device to check against.
- *
- * Check if @sup depends on @con or any device dependent on it (its child or
- * its consumer etc).  When such a cyclic dependency is found, convert all
- * device links created solely by fw_devlink into SYNC_STATE_ONLY device links.
- * This is the equivalent of doing fw_devlink=permissive just between the
- * devices in the cycle. We need to do this because, at this point, fw_devlink
- * can't tell which of these dependencies is not a real dependency.
- *
- * Return 1 if a cycle is found. Otherwise, return 0.
- */
-static int fw_devlink_relax_cycle(struct device *con, void *sup)
-{
-	struct device_link *link;
-	int ret;
-
-	if (con == sup)
-		return 1;
-
-	ret = device_for_each_child(con, sup, fw_devlink_relax_cycle);
-	if (ret)
-		return ret;
-
-	list_for_each_entry(link, &con->links.consumers, s_node) {
-		if (!(link->flags & DL_FLAG_CYCLE) &&
-		    device_link_flag_is_sync_state_only(link->flags))
-			continue;
-
-		if (!fw_devlink_relax_cycle(link->consumer, sup))
-			continue;
-
-		ret = 1;
-
-		fw_devlink_relax_link(link);
-		link->flags |= DL_FLAG_CYCLE;
-	}
-	return ret;
-}
 
 static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
 {
@@ -1937,6 +1896,111 @@ static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
 	return false;
 }
 
+/**
+ * __fw_devlink_relax_cycles - Relax and mark dependency cycles.
+ * @con: Potential consumer device.
+ * @sup_handle: Potential supplier's fwnode.
+ *
+ * Needs to be called with fwnode_lock and device link lock held.
+ *
+ * Check if @sup_handle or any of its ancestors or suppliers direct/indirectly
+ * depend on @con. This function can detect multiple cyles between @sup_handle
+ * and @con. When such dependency cycles are found, convert all device links
+ * created solely by fw_devlink into SYNC_STATE_ONLY device links. Also, mark
+ * all fwnode links in the cycle with FWLINK_FLAG_CYCLE so that when they are
+ * converted into a device link in the future, they are created as
+ * SYNC_STATE_ONLY device links. This is the equivalent of doing
+ * fw_devlink=permissive just between the devices in the cycle. We need to do
+ * this because, at this point, fw_devlink can't tell which of these
+ * dependencies is not a real dependency.
+ *
+ * Return true if one or more cycles were found. Otherwise, return false.
+ */
+static bool __fw_devlink_relax_cycles(struct device *con,
+				 struct fwnode_handle *sup_handle)
+{
+	struct device *sup_dev = NULL, *par_dev = NULL;
+	struct fwnode_link *link;
+	struct device_link *dev_link;
+	bool ret = false;
+
+	if (!sup_handle)
+		return false;
+
+	/*
+	 * We aren't trying to find all cycles. Just a cycle between con and
+	 * sup_handle.
+	 */
+	if (sup_handle->flags & FWNODE_FLAG_VISITED)
+		return false;
+
+	sup_handle->flags |= FWNODE_FLAG_VISITED;
+
+	sup_dev = get_dev_from_fwnode(sup_handle);
+
+	/* Termination condition. */
+	if (sup_dev == con) {
+		ret = true;
+		goto out;
+	}
+
+	/*
+	 * If sup_dev is bound to a driver and @con hasn't started binding to a
+	 * driver, sup_dev can't be a consumer of @con. So, no need to check
+	 * further.
+	 */
+	if (sup_dev && sup_dev->links.status ==  DL_DEV_DRIVER_BOUND &&
+	    con->links.status == DL_DEV_NO_DRIVER) {
+		ret = false;
+		goto out;
+	}
+
+	list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
+		if (__fw_devlink_relax_cycles(con, link->supplier)) {
+			__fwnode_link_cycle(link);
+			ret = true;
+		}
+	}
+
+	/*
+	 * Give priority to device parent over fwnode parent to account for any
+	 * quirks in how fwnodes are converted to devices.
+	 */
+	if (sup_dev)
+		par_dev = get_device(sup_dev->parent);
+	else
+		par_dev = fwnode_get_next_parent_dev(sup_handle);
+
+	if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode))
+		ret = true;
+
+	if (!sup_dev)
+		goto out;
+
+	list_for_each_entry(dev_link, &sup_dev->links.suppliers, c_node) {
+		/*
+		 * Ignore a SYNC_STATE_ONLY flag only if it wasn't marked as
+		 * such due to a cycle.
+		 */
+		if (device_link_flag_is_sync_state_only(dev_link->flags) &&
+		    !(dev_link->flags & DL_FLAG_CYCLE))
+			continue;
+
+		if (__fw_devlink_relax_cycles(con,
+					      dev_link->supplier->fwnode)) {
+			fw_devlink_relax_link(dev_link);
+			dev_link->flags |= DL_FLAG_CYCLE;
+			ret = true;
+		}
+	}
+
+out:
+	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
+	put_device(sup_dev);
+	put_device(par_dev);
+	return ret;
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con: consumer device for the device link
@@ -1989,6 +2053,21 @@ static int fw_devlink_create_devlink(struct device *con,
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
+	/*
+	 * SYNC_STATE_ONLY device links don't block probing and supports cycles.
+	 * So cycle detection isn't necessary and shouldn't be done.
+	 */
+	if (!(flags & DL_FLAG_SYNC_STATE_ONLY)) {
+		device_links_write_lock();
+		if (__fw_devlink_relax_cycles(con, sup_handle)) {
+			__fwnode_link_cycle(link);
+			flags = fw_devlink_get_flags(link->flags);
+			dev_info(con, "Fixed dependency cycle(s) with %pfwf\n",
+				 sup_handle);
+		}
+		device_links_write_unlock();
+	}
+
 	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
 	else
@@ -2002,23 +2081,16 @@ static int fw_devlink_create_devlink(struct device *con,
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
 		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+			dev_dbg(con,
+				"Not linking %pfwf - dev might never probe\n",
+				sup_handle);
 			ret = -EINVAL;
 			goto out;
 		}
 
-		/*
-		 * If this fails, it is due to cycles in device links.  Just
-		 * give up on this link and treat it as invalid.
-		 */
-		if (!device_link_add(con, sup_dev, flags) &&
-		    !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
-			dev_info(con, "Fixing up cyclic dependency with %s\n",
-				 dev_name(sup_dev));
-			device_links_write_lock();
-			fw_devlink_relax_cycle(con, sup_dev);
-			device_links_write_unlock();
-			device_link_add(con, sup_dev,
-					FW_DEVLINK_FLAGS_PERMISSIVE);
+		if (!device_link_add(con, sup_dev, flags)) {
+			dev_err(con, "Failed to create device link with %s\n",
+				dev_name(sup_dev));
 			ret = -EINVAL;
 		}
 
@@ -2031,49 +2103,12 @@ static int fw_devlink_create_devlink(struct device *con,
 	 */
 	if (fwnode_init_without_drv(sup_handle) ||
 	    fwnode_ancestor_init_without_drv(sup_handle)) {
-		dev_dbg(con, "Not linking %pfwP - Might never probe\n",
+		dev_dbg(con, "Not linking %pfwf - might never become dev\n",
 			sup_handle);
 		return -EINVAL;
 	}
 
-	/*
-	 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
-	 * cycles. So cycle detection isn't necessary and shouldn't be
-	 * done.
-	 */
-	if (flags & DL_FLAG_SYNC_STATE_ONLY)
-		return -EAGAIN;
-
-	/*
-	 * If we can't find the supplier device from its fwnode, it might be
-	 * due to a cyclic dependency between fwnodes. Some of these cycles can
-	 * be broken by applying logic. Check for these types of cycles and
-	 * break them so that devices in the cycle probe properly.
-	 *
-	 * If the supplier's parent is dependent on the consumer, then the
-	 * consumer and supplier have a cyclic dependency. Since fw_devlink
-	 * can't tell which of the inferred dependencies are incorrect, don't
-	 * enforce probe ordering between any of the devices in this cyclic
-	 * dependency. Do this by relaxing all the fw_devlink device links in
-	 * this cycle and by treating the fwnode link between the consumer and
-	 * the supplier as an invalid dependency.
-	 */
-	sup_dev = fwnode_get_next_parent_dev(sup_handle);
-	if (sup_dev && device_is_dependent(con, sup_dev)) {
-		dev_info(con, "Fixing up cyclic dependency with %pfwP (%s)\n",
-			 sup_handle, dev_name(sup_dev));
-		device_links_write_lock();
-		fw_devlink_relax_cycle(con, sup_dev);
-		device_links_write_unlock();
-		ret = -EINVAL;
-	} else {
-		/*
-		 * Can't check for cycles or no cycles. So let's try
-		 * again later.
-		 */
-		ret = -EAGAIN;
-	}
-
+	ret = -EAGAIN;
 out:
 	put_device(sup_dev);
 	return ret;
@@ -2156,10 +2191,7 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
  *
  * The function creates normal (non-SYNC_STATE_ONLY) device links between @dev
  * and the real suppliers of @dev. Once these device links are created, the
- * fwnode links are deleted. When such device links are successfully created,
- * this function is called recursively on those supplier devices. This is
- * needed to detect and break some invalid cycles in fwnode links.  See
- * fw_devlink_create_devlink() for more details.
+ * fwnode links are deleted.
  *
  * In addition, it also looks at all the suppliers of the entire fwnode tree
  * because some of the child devices of @dev that have not been added yet
@@ -2180,7 +2212,6 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 
 	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
 		int ret;
-		struct device *sup_dev;
 		struct fwnode_handle *sup = link->supplier;
 
 		ret = fw_devlink_create_devlink(dev, sup, link);
@@ -2188,27 +2219,6 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 			continue;
 
 		__fwnode_link_del(link);
-
-		/* If no device link was created, nothing more to do. */
-		if (ret)
-			continue;
-
-		/*
-		 * If a device link was successfully created to a supplier, we
-		 * now need to try and link the supplier to all its suppliers.
-		 *
-		 * This is needed to detect and delete false dependencies in
-		 * fwnode links that haven't been converted to a device link
-		 * yet. See comments in fw_devlink_create_devlink() for more
-		 * details on the false dependency.
-		 *
-		 * Without deleting these false dependencies, some devices will
-		 * never probe because they'll keep waiting for their false
-		 * dependency fwnode links to be converted to device links.
-		 */
-		sup_dev = get_dev_from_fwnode(sup);
-		__fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
-		put_device(sup_dev);
 	}
 
 	/*
-- 
2.39.1.519.gcb327c4b5f-goog

