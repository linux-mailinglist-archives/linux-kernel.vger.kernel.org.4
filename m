Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254E768CC1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBGBnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjBGBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:42:30 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FB35269
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:24 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a10-20020a17090a740a00b002307faf7db2so3237252pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzemyWsbe1874/35X2pGE6I7zLC/qObwAXplkSqm2aE=;
        b=b7u37IEj5Fvd6YXLTEOU720DHRSwTWNj09MbzD4MFmQBovqJgQg/oKrS1P046uOL3W
         wTyWtdFCoTfoIgRQeaARkhnceMX2583Jt9ShPGALCTgQifsrFvgU/DdEOZxYTEIquAsw
         HrxCZ06UNjYJMftUEHe1ow4Tv6q2XYScigicpVP27au4gdTVa6EeeO+wgmUNMe9cCEog
         LaNPQCCahp25YO89ePuDfYwQXExsNtfJ7zTvd1EnsoPpeBtfm+oghEapmUp893sivQJM
         0+clHCPHG1Hnj1tLQRTLevMmypFLA7Tn8AWn71fXIYRoOpq4aLcl0otIKMQmn6405jAT
         RNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzemyWsbe1874/35X2pGE6I7zLC/qObwAXplkSqm2aE=;
        b=V52jf0VhvI+wkMkD5Mr560j92oznDlHNA2d2N7socmVQIeyG+0mrjDEp+TXEYVM148
         Ce+rglVYNHYeAqnwhdrWnuNTSeQx2vZ6LyMhU6YeQTGk/YWWMhgYC3T0jDzk/ufd9DpX
         jo6e+00f4MW6c+yYGIqyvjiQhzVkDaMbE2W3GfDFOnNz0m9g0A7RT4XHVnjpQvSGeeoV
         Jj+BnVECSyNxkS7/S95GGNy/gkGwtpM5bEyvfPRnLV1UKB5g7I//QOuLGYuV+N28smw9
         WQxLQFmgSQza5zU/txSLRyReAa0WXQ0yxX5kRg3NNlcA/6PLaraXZVAbcGrDUZhXbECD
         kbVQ==
X-Gm-Message-State: AO0yUKXAp2vr+jFTC3vTW6uTmViahJEwieVdikCQorOe5acZhHovBMry
        QvddRZMcN5hP761Rzh77oV7T6As7j07Tdg4=
X-Google-Smtp-Source: AK7set+0IxdeFoc+Kn+E3OD6+a3ZeegbPKAGCsgRpOcmEvW2y10wLjL8U1hVM8p0ddZt3HY7VH3NvMmLcJc1hoM=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90a:148:b0:230:e030:844f with SMTP
 id z8-20020a17090a014800b00230e030844fmr409952pje.77.1675734143942; Mon, 06
 Feb 2023 17:42:23 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:41:57 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-6-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 05/12] driver core: fw_devlink: Add DL_FLAG_CYCLE support
 to device links
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_devlink uses DL_FLAG_SYNC_STATE_ONLY device link flag for two
purposes:

1. To allow a parent device to proxy its child device's dependency on a
   supplier so that the supplier doesn't get its sync_state() callback
   before the child device/consumer can be added and probed. In this
   usage scenario, we need to ignore cycles for ensure correctness of
   sync_state() callbacks.

2. When there are dependency cycles in firmware, we don't know which of
   those dependencies are valid. So, we have to ignore them all wrt
   probe ordering while still making sure the sync_state() callbacks
   come correctly.

However, when detecting dependency cycles, there can be multiple
dependency cycles between two devices that we need to detect. For
example:

A -> B -> A and A -> C -> B -> A.

To detect multiple cycles correct, we need to be able to differentiate
DL_FLAG_SYNC_STATE_ONLY device links used for (1) vs (2) above.

To allow this differentiation, add a DL_FLAG_CYCLE that can be use to
mark use case (2). We can then use the DL_FLAG_CYCLE to decide which
DL_FLAG_SYNC_STATE_ONLY device links to follow when looking for
dependency cycles.

Fixes: 2de9d8e0d2fe ("driver core: fw_devlink: Improve handling of cyclic dependencies")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/core.c    | 28 ++++++++++++++++++----------
 include/linux/device.h |  1 +
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 368bfd96b511..071c454844d6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -322,6 +322,12 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 	return false;
 }
 
+static inline bool device_link_flag_is_sync_state_only(u32 flags)
+{
+	return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE)) ==
+		(DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);
+}
+
 /**
  * device_is_dependent - Check if one device depends on another one
  * @dev: Device to check dependencies for.
@@ -348,8 +354,7 @@ int device_is_dependent(struct device *dev, void *target)
 		return ret;
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if ((link->flags & ~DL_FLAG_INFERRED) ==
-		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if (device_link_flag_is_sync_state_only(link->flags))
 			continue;
 
 		if (link->consumer == target)
@@ -422,8 +427,7 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 
 	device_for_each_child(dev, NULL, device_reorder_to_tail);
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if ((link->flags & ~DL_FLAG_INFERRED) ==
-		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if (device_link_flag_is_sync_state_only(link->flags))
 			continue;
 		device_reorder_to_tail(link->consumer, NULL);
 	}
@@ -684,7 +688,8 @@ postcore_initcall(devlink_class_init);
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER  | \
 			       DL_FLAG_SYNC_STATE_ONLY | \
-			       DL_FLAG_INFERRED)
+			       DL_FLAG_INFERRED | \
+			       DL_FLAG_CYCLE)
 
 #define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
 			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
@@ -753,8 +758,6 @@ struct device_link *device_link_add(struct device *consumer,
 	if (!consumer || !supplier || consumer == supplier ||
 	    flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
-	    (flags & DL_FLAG_SYNC_STATE_ONLY &&
-	     (flags & ~DL_FLAG_INFERRED) != DL_FLAG_SYNC_STATE_ONLY) ||
 	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
 	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
 		      DL_FLAG_AUTOREMOVE_SUPPLIER)))
@@ -770,6 +773,10 @@ struct device_link *device_link_add(struct device *consumer,
 	if (!(flags & DL_FLAG_STATELESS))
 		flags |= DL_FLAG_MANAGED;
 
+	if (flags & DL_FLAG_SYNC_STATE_ONLY &&
+	    !device_link_flag_is_sync_state_only(flags))
+		return NULL;
+
 	device_links_write_lock();
 	device_pm_lock();
 
@@ -1729,7 +1736,7 @@ static void fw_devlink_relax_link(struct device_link *link)
 	if (!(link->flags & DL_FLAG_INFERRED))
 		return;
 
-	if (link->flags == (DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE))
+	if (device_link_flag_is_sync_state_only(link->flags))
 		return;
 
 	pm_runtime_drop_link(link);
@@ -1853,8 +1860,8 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 		return ret;
 
 	list_for_each_entry(link, &con->links.consumers, s_node) {
-		if ((link->flags & ~DL_FLAG_INFERRED) ==
-		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if (!(link->flags & DL_FLAG_CYCLE) &&
+		    device_link_flag_is_sync_state_only(link->flags))
 			continue;
 
 		if (!fw_devlink_relax_cycle(link->consumer, sup))
@@ -1863,6 +1870,7 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 		ret = 1;
 
 		fw_devlink_relax_link(link);
+		link->flags |= DL_FLAG_CYCLE;
 	}
 	return ret;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..f4d20655d2d7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -328,6 +328,7 @@ enum device_link_state {
 #define DL_FLAG_MANAGED			BIT(6)
 #define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
 #define DL_FLAG_INFERRED		BIT(8)
+#define DL_FLAG_CYCLE			BIT(9)
 
 /**
  * enum dl_dev_state - Device driver presence tracking information.
-- 
2.39.1.519.gcb327c4b5f-goog

