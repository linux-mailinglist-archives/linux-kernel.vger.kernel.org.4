Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0967DA6B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjA0AMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjA0AMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:12:10 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181673745
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:12:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5066df312d7so38550857b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmnKYDMGckXgFhZpaO7nCm5AdotTXCbrqCeB4/4reUA=;
        b=PMd9N+cUoBI1+XCPtZM2ZavRjj39Gr4Wu1cIhwZKLsDq5pNea8d1lUpCciqeA+bLAa
         nCCFzsn9qKyYHlK7D1T/jA0UEUfBjK8qExLyMdpyEJkyMLrNb7nADPR8lwT5chGAe5YR
         /KOdU5KwfpjOfxFXt3E7IZdVvJCqjPI2mfVi6w3CVFH238H+omoj38aOL9yEzSiNarqO
         hvh7/bGKNySXwNGvheklFu6dj9CGW+wZV0HZrtOqO+OPyJ9h0g64hLHeresmboIHBYMv
         qwKkLhTvCMXOuEEBvTJkV3CDQWCgj5yjbodPBKNwNY9a0JfquC0Td4cfASgqcC//XAQQ
         xikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmnKYDMGckXgFhZpaO7nCm5AdotTXCbrqCeB4/4reUA=;
        b=2RSvL73WQ/st59q49joUN6eJzmOHnYdgVbEubiIjjkynmz1EgU+0/kE/6wlnuO5weD
         Z8O83OPdmXkE6QrY7+Wo18fxETw3cxpbvMuOyZIgW9Y5etjVNqQtjXrRLBviMCbONxiz
         8cIxSO2ZshcEEvmDGjHlYpg0N+INTpSt2niZ5mFjonYBFKZ0YbcahojuRx+gM3tDBnUN
         FEDP5qDAZvhZf9vopqBgxbr00KahsD+mnGnAwMfOHe7s21I1HZ5dFEVz3QY0geX01I6v
         7pAfIU/6gx+rciuLugYPou9xcN6ahwL8inbhzR6xKf8xXejJG+2KYNNJF7xtm7gU6HdS
         PGeA==
X-Gm-Message-State: AFqh2kqQWu3/3jXkrGAk5lyc4PS1i9oB0OzmLgrjsL4K71GxMf0NSFI3
        Bw5Riy+TZDl0D3sh51dDYzuqdFvoVR5vpok=
X-Google-Smtp-Source: AMrXdXtccMFU5g8cqR4yhIhGpW4p3rK4cfzV+G3271lD029UOigJ8Rxd9pBUOt7tog+62UUFP2Au4t5UOIYQEts=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a81:a54a:0:b0:4fa:6bec:c7d4 with SMTP id
 v10-20020a81a54a000000b004fa6becc7d4mr4092908ywg.214.1674778322520; Thu, 26
 Jan 2023 16:12:02 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:34 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-8-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 07/11] driver core: fw_devlink: Consolidate device link
 flag computation
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

Consolidate the code that computes the flags to be used when creating a
device link from a fwnode link.

Fixes: 2de9d8e0d2fe ("driver core: fw_devlink: Improve handling of cyclic dependencies")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 28 +++++++++++++++-------------
 include/linux/fwnode.h |  1 -
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 82b29e9070bf..b61d5d86a600 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1726,8 +1726,11 @@ static int __init fw_devlink_strict_setup(char *arg)
 }
 early_param("fw_devlink.strict", fw_devlink_strict_setup);
 
-u32 fw_devlink_get_flags(void)
+static inline u32 fw_devlink_get_flags(u8 fwlink_flags)
 {
+	if (fwlink_flags & FWLINK_FLAG_CYCLE)
+		return FW_DEVLINK_FLAGS_PERMISSIVE | DL_FLAG_CYCLE;
+
 	return fw_devlink_flags;
 }
 
@@ -1937,7 +1940,7 @@ static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con: consumer device for the device link
  * @sup_handle: fwnode handle of supplier
- * @flags: devlink flags
+ * @link: fwnode link that's being converted to a device link
  *
  * This function will try to create a device link between the consumer device
  * @con and the supplier device represented by @sup_handle.
@@ -1954,10 +1957,17 @@ static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
  *  possible to do that in the future
  */
 static int fw_devlink_create_devlink(struct device *con,
-				     struct fwnode_handle *sup_handle, u32 flags)
+				     struct fwnode_handle *sup_handle,
+				     struct fwnode_link *link)
 {
 	struct device *sup_dev;
 	int ret = 0;
+	u32 flags;
+
+	if (con->fwnode == link->consumer)
+		flags = fw_devlink_get_flags(link->flags);
+	else
+		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
 	/*
 	 * In some cases, a device P might also be a supplier to its child node
@@ -2090,7 +2100,6 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 	struct fwnode_link *link, *tmp;
 
 	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
-		u32 dl_flags = fw_devlink_get_flags();
 		struct device *con_dev;
 		bool own_link = true;
 		int ret;
@@ -2120,14 +2129,13 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 				con_dev = NULL;
 			} else {
 				own_link = false;
-				dl_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 			}
 		}
 
 		if (!con_dev)
 			continue;
 
-		ret = fw_devlink_create_devlink(con_dev, fwnode, dl_flags);
+		ret = fw_devlink_create_devlink(con_dev, fwnode, link);
 		put_device(con_dev);
 		if (!own_link || ret == -EAGAIN)
 			continue;
@@ -2168,19 +2176,13 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 	bool own_link = (dev->fwnode == fwnode);
 	struct fwnode_link *link, *tmp;
 	struct fwnode_handle *child = NULL;
-	u32 dl_flags;
-
-	if (own_link)
-		dl_flags = fw_devlink_get_flags();
-	else
-		dl_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
 	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
 		int ret;
 		struct device *sup_dev;
 		struct fwnode_handle *sup = link->supplier;
 
-		ret = fw_devlink_create_devlink(dev, sup, dl_flags);
+		ret = fw_devlink_create_devlink(dev, sup, link);
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index fdf2ee0285b7..5700451b300f 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -207,7 +207,6 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
 }
 
-extern u32 fw_devlink_get_flags(void);
 extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
-- 
2.39.1.456.gfc5497dd1b-goog

