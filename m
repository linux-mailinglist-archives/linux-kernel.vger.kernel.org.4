Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B368CC20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjBGBnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBGBmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:42:46 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE1816332
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:27 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id h16-20020a63df50000000b004f74bc0c71fso3575203pgj.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vpmPQ8JVcoFw6jzJt0l+ZlsP/nzUPWiHo9dJCqmqxg=;
        b=ZVUxcLXcuHpH7fPEW4j4omclrdQvGfH8R1Vewn8I0GThoas9mW+GLo2sjSyOKV3npY
         DsGQu11CHb6WnNb+y3GZPqWhQ6O3cz3xiYf037/sdq9nFz8XU64plVHqi0wGnHI/rnh2
         kDoKcQ3viwNlT96/A4ZecaIDJZMX2kMBpfxVlyPZFeajMa66cDDL9Mb1Ds/7UEUQwtJK
         R/Xs8z5ijn/Nd67K7O2YD2iruYwx4Q9hECaWntP7FJqQKrMrH+xfnF9gGv9X3lbFtL8X
         HEmJDslkFRhae3S1tV11iNbb6wmW0J8xAcXwhzislt+Z//qMzPcwqA3I9SL4dXDTfs2E
         DxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vpmPQ8JVcoFw6jzJt0l+ZlsP/nzUPWiHo9dJCqmqxg=;
        b=nCWenk9yiY593eXU8rwiJpLB++D4aGqr39cOGxOYJPwJEQ5Cxhhh4gzly1ydkMM5we
         +g5tp7K8dBRLbuzFB3VCDlJRzaJx5nipoLZIi3NiK7BF9k1AOY8weJggCsfoXTyXxBcs
         2zMEVppC//ilDQ+8uBwECYvQ1Jns2x4mEhoiclDM/F4HC1zWUJoo5CqC4MoHZyLViQMx
         E6UCqaSnqy13gxohQiLDvksIihTQzklgGb/O/+rtprZx/iXtzEcGX2/0TVFzmLl11YMH
         e2b1OA2rpBpfWPiyN7bcBzclDJ2xCvPMWJNWAnp2fWbpWCRLoDImatYAfM7r89NaI/M7
         fdKQ==
X-Gm-Message-State: AO0yUKXREaENX5oF7ZxWZyCwEpG/hzZD6sOi1Xbhd6cvDZNx8qDPhU/R
        vHKWc4qNadFOs3INU+anjHXJd2a4B0CAFZM=
X-Google-Smtp-Source: AK7set9NPOGC0oetOP/gaLFUP+MpzpqBfkZ8gulYNDZYMwFtOcGmzB6taII+HbQld9AZdrAJI3zqaMUoDmkG+Fo=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90a:49c8:b0:230:9fa1:8cbb with SMTP
 id l8-20020a17090a49c800b002309fa18cbbmr1636995pjm.78.1675734146756; Mon, 06
 Feb 2023 17:42:26 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:41:58 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-7-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 06/12] driver core: fw_devlink: Allow marking a fwnode link
 as being part of a cycle
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

To improve detection and handling of dependency cycles, we need to be
able to mark fwnode links as being part of cycles. fwnode links marked
as being part of a cycle should not block their consumers from probing.

Fixes: 2de9d8e0d2fe ("driver core: fw_devlink: Improve handling of cyclic dependencies")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/core.c    | 50 +++++++++++++++++++++++++++++++++---------
 include/linux/fwnode.h | 11 +++++++++-
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 071c454844d6..4869b6fdfeaf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -76,13 +76,15 @@ static bool fw_devlink_best_effort;
  * are ignored and there is no reference counting.
  */
 static int __fwnode_link_add(struct fwnode_handle *con,
-			     struct fwnode_handle *sup)
+			     struct fwnode_handle *sup, u8 flags)
 {
 	struct fwnode_link *link;
 
 	list_for_each_entry(link, &sup->consumers, s_hook)
-		if (link->consumer == con)
+		if (link->consumer == con) {
+			link->flags |= flags;
 			return 0;
+		}
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
@@ -92,6 +94,7 @@ static int __fwnode_link_add(struct fwnode_handle *con,
 	INIT_LIST_HEAD(&link->s_hook);
 	link->consumer = con;
 	INIT_LIST_HEAD(&link->c_hook);
+	link->flags = flags;
 
 	list_add(&link->s_hook, &sup->consumers);
 	list_add(&link->c_hook, &con->suppliers);
@@ -106,7 +109,7 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 	int ret;
 
 	mutex_lock(&fwnode_link_lock);
-	ret = __fwnode_link_add(con, sup);
+	ret = __fwnode_link_add(con, sup, 0);
 	mutex_unlock(&fwnode_link_lock);
 	return ret;
 }
@@ -126,6 +129,19 @@ static void __fwnode_link_del(struct fwnode_link *link)
 	kfree(link);
 }
 
+/**
+ * __fwnode_link_cycle - Mark a fwnode link as being part of a cycle.
+ * @link: the fwnode_link to be marked
+ *
+ * The fwnode_link_lock needs to be held when this function is called.
+ */
+static void __fwnode_link_cycle(struct fwnode_link *link)
+{
+	pr_debug("%pfwf: Relaxing link with %pfwf\n",
+		 link->consumer, link->supplier);
+	link->flags |= FWLINK_FLAG_CYCLE;
+}
+
 /**
  * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
  * @fwnode: fwnode whose supplier links need to be deleted
@@ -199,7 +215,7 @@ static void __fwnode_links_move_consumers(struct fwnode_handle *from,
 	struct fwnode_link *link, *tmp;
 
 	list_for_each_entry_safe(link, tmp, &from->consumers, s_hook) {
-		__fwnode_link_add(link->consumer, to);
+		__fwnode_link_add(link->consumer, to, link->flags);
 		__fwnode_link_del(link);
 	}
 }
@@ -1041,6 +1057,21 @@ static bool dev_is_best_effort(struct device *dev)
 		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
 }
 
+static struct fwnode_handle *fwnode_links_check_suppliers(
+						struct fwnode_handle *fwnode)
+{
+	struct fwnode_link *link;
+
+	if (!fwnode || fw_devlink_is_permissive())
+		return NULL;
+
+	list_for_each_entry(link, &fwnode->suppliers, c_hook)
+		if (!(link->flags & FWLINK_FLAG_CYCLE))
+			return link->supplier;
+
+	return NULL;
+}
+
 /**
  * device_links_check_suppliers - Check presence of supplier drivers.
  * @dev: Consumer device.
@@ -1068,11 +1099,8 @@ int device_links_check_suppliers(struct device *dev)
 	 * probe.
 	 */
 	mutex_lock(&fwnode_link_lock);
-	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
-	    !fw_devlink_is_permissive()) {
-		sup_fw = list_first_entry(&dev->fwnode->suppliers,
-					  struct fwnode_link,
-					  c_hook)->supplier;
+	sup_fw = fwnode_links_check_suppliers(dev->fwnode);
+	if (sup_fw) {
 		if (!dev_is_best_effort(dev)) {
 			fwnode_ret = -EPROBE_DEFER;
 			dev_err_probe(dev, -EPROBE_DEFER,
@@ -1261,7 +1289,9 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 	bool val;
 
 	device_lock(dev);
-	val = !list_empty(&dev->fwnode->suppliers);
+	mutex_lock(&fwnode_link_lock);
+	val = !!fwnode_links_check_suppliers(dev->fwnode);
+	mutex_unlock(&fwnode_link_lock);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 89b9bdfca925..fdf2ee0285b7 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -18,7 +18,7 @@ struct fwnode_operations;
 struct device;
 
 /*
- * fwnode link flags
+ * fwnode flags
  *
  * LINKS_ADDED:	The fwnode has already be parsed to add fwnode links.
  * NOT_DEVICE:	The fwnode will never be populated as a struct device.
@@ -36,6 +36,7 @@ struct device;
 #define FWNODE_FLAG_INITIALIZED			BIT(2)
 #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
 #define FWNODE_FLAG_BEST_EFFORT			BIT(4)
+#define FWNODE_FLAG_VISITED			BIT(5)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -46,11 +47,19 @@ struct fwnode_handle {
 	u8 flags;
 };
 
+/*
+ * fwnode link flags
+ *
+ * CYCLE:	The fwnode link is part of a cycle. Don't defer probe.
+ */
+#define FWLINK_FLAG_CYCLE			BIT(0)
+
 struct fwnode_link {
 	struct fwnode_handle *supplier;
 	struct list_head s_hook;
 	struct fwnode_handle *consumer;
 	struct list_head c_hook;
+	u8 flags;
 };
 
 /**
-- 
2.39.1.519.gcb327c4b5f-goog

