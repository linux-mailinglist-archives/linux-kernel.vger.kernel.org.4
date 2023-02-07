Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383D68CC0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBGBm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjBGBm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:42:26 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292916333
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:16 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x10-20020a17090a294a00b00230a1550be7so3531713pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rF935xJruDmZakfcqYl07qySBy4v0tdY/SRPeseRpYs=;
        b=nVLihGug+gPNpky+kL8lZ+ojXplNGe2YAeogfY96aFh2Qm/Qk1O3o22nE2SbLQGizJ
         IQUGcIv0V1RiPC3mFC95Ns51BBCdycBZmzZp1eBZeHMb3hEEexERUn9/qygKgFkVNpb0
         Diq/OdiPdmE0e1Mvqy6mPGaGFUAI0qc+AzilSeGTt20pgttfB2UI6oxiuR9XlQq9Felm
         iClxVp1dKr/FoyJc+rxT9XgQscF8UCsnjjVVGve0zIcTwL+GUrEfoISySe93O475VMth
         fWwpZNaXC0o8y1s1tvJPiWtm14hX9OdBngkkg5kHlfY9ArsLQ75uwryzy35mTFf3XSiq
         xXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rF935xJruDmZakfcqYl07qySBy4v0tdY/SRPeseRpYs=;
        b=ic7tJhgyuQMcJcf/mcmWEOQSbY1iG7/P9M/wVmUhFvzipDNVJvwTflOTFDGdcCFqs2
         MkAuWwItpSwGDIIRD4WahRQ8XO8aYI0xRgRyB+uKm4yFROlITV378oZkdsklOAMzUuNZ
         s3zsg37OURK6cx6D5MCBJOC/Gwp3xu4SN5Xx2zB85f2+oFeriYaCsS8QVtA1XNHph6OC
         Qz3xgudDWUq019ktw/JglrPYDdUlktlouNxBUJPxbt/WjQQ+l6iyrp0ITAGCBSwNF++e
         /rvZF+SWdaAjZnd36J2ls3IEFwriygupjAO6hzufvmaESqFyevR5lNuKz1m7j4zRI4jj
         evcQ==
X-Gm-Message-State: AO0yUKUFFSEHP2KoiQz2gaZpx8HveCtutLzymQU8cTvRyQEFSIUgThjt
        /6nswrVwYv3KtAVipqu52TOv2q+PIyY8AQc=
X-Google-Smtp-Source: AK7set9i7jgE6FpR3noUhzo8MnwFszLcteNew7Oyn7nbowkMqjNTsdQ07Wf9bCz+hy9cTEgusCXLrQQHzICPoq0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a63:7114:0:b0:476:f69c:2304 with SMTP id
 m20-20020a637114000000b00476f69c2304mr169807pgc.77.1675734135795; Mon, 06 Feb
 2023 17:42:15 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:41:54 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-3-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 02/12] driver core: fw_devlink: Improve check for fwnode
 with no device/driver
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

fw_devlink shouldn't defer the probe of a device to wait on a supplier
that'll never have a struct device or will never be probed by a driver.
We currently check if a supplier falls into this category, but don't
check its ancestors. We need to check the ancestors too because if the
ancestor will never probe, then the supplier will never probe either.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/core.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 001e1914858d..368bfd96b511 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1867,6 +1867,35 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 	return ret;
 }
 
+static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+	bool ret;
+
+	if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
+		return false;
+
+	dev = get_dev_from_fwnode(fwnode);
+	ret = !dev || dev->links.status == DL_DEV_NO_DRIVER;
+	put_device(dev);
+
+	return ret;
+}
+
+static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent;
+
+	fwnode_for_each_parent_node(fwnode, parent) {
+		if (fwnode_init_without_drv(parent)) {
+			fwnode_handle_put(parent);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con: consumer device for the device link
@@ -1948,9 +1977,16 @@ static int fw_devlink_create_devlink(struct device *con,
 		goto out;
 	}
 
-	/* Supplier that's already initialized without a struct device. */
-	if (sup_handle->flags & FWNODE_FLAG_INITIALIZED)
+	/*
+	 * Supplier or supplier's ancestor already initialized without a struct
+	 * device or being probed by a driver.
+	 */
+	if (fwnode_init_without_drv(sup_handle) ||
+	    fwnode_ancestor_init_without_drv(sup_handle)) {
+		dev_dbg(con, "Not linking %pfwP - Might never probe\n",
+			sup_handle);
 		return -EINVAL;
+	}
 
 	/*
 	 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
-- 
2.39.1.519.gcb327c4b5f-goog

