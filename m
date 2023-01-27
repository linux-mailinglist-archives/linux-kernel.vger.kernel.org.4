Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980067DA77
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjA0ANH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0AMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:12:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226DF4ED0F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:12:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i17-20020a25bc11000000b007b59a5b74aaso3633424ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivP3XAPTaMslZ0S+XLyk7hnb7R+owb4t4qagKyvh274=;
        b=Oh5dmIBsL8VdvCphyPu6af2tpQO72hGjRz6FJiyXdF32XEcCHaYgj0Y11W4GTR3/V4
         dM1na1qjdkHVeLhBJ+nhNpdVpKRS1NkclC/SaC/umLbLFbrLM1k85mfWsfQosG536ZHF
         XKVwu7QeiTT0BC1vh34ak3IZCTgDZrALE8AIMxahzzuZea5RcqrqIHolZT1d8pHAvmK3
         dzR7m/0/S5a4YYGBR7dszeEtsl7JVkbsa/smTjJ+9rHheOkX3YNX2tw6so3sOACA1RoT
         /qU3O7IP23SOPbflr+9cXT59aR1IHKQDnM/l4aQ0g/AIODzyJYd7dDDfniw6gBc5sjLj
         0gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivP3XAPTaMslZ0S+XLyk7hnb7R+owb4t4qagKyvh274=;
        b=lKfK7P2Ywl+guTzsxLsnsPdiesCNlpGJLX1uPUWuKVzMUJXn5MDQbge31bbiLViHw6
         tBaBR+lUQTf0RK09pZxE8UKYRUZ0xiTOEjwjqvAm7dhLZ7qjOH0yARypPt3CJexJCHdH
         vYSkMg4wDQYt2q9PCK2PNeCDIIr837sJAACscNQvtC80v7ZkKqcahEc3SDBlEAapynA+
         US90yVaC1VmdahseQI1tmv04f4TSHdswpY+Dj928Li6889Arv0yfADXB9gkxvgKcCl4y
         DUNFYLslw6St8xia0g75B8c/UV6eI93IR6nUgGlrruImD7HaRfTG/VW1h4lPxSZ5RXRo
         ieLQ==
X-Gm-Message-State: AO0yUKWJvbo0Jr4GBW853eu7jxTRKaD1A+gE8ueXOGvXyjYuEU7XbOFR
        cdsr+zQpVAxDV08/ftFxasun2boJubQTSzY=
X-Google-Smtp-Source: AK7set+syxPr8xIlnVYPb+OoZVp9SPzH7ECkaBbaiIrgGJW8W5AL2JGqjxSUYEhwb9aiEN4TE1tz7/z+jEla25w=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a81:5d1:0:b0:506:69cb:8950 with SMTP id
 200-20020a8105d1000000b0050669cb8950mr1273793ywf.38.1674778327341; Thu, 26
 Jan 2023 16:12:07 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:36 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-10-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 09/11] of: property: Simplify of_link_to_phandle()
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

The driver core now:
- Has the parent device of a supplier pick up the consumers if the
  supplier never has a device created for it.
- Ignores a supplier if the supplier has no parent device and will never
  be probed by a driver

And already prevents creating a device link with the consumer as a
supplier of a parent.

So, we no longer need to find the "compatible" node of the supplier or
do any other checks in of_link_to_phandle(). We simply need to make sure
that the supplier is available in DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 84 +++++++------------------------------------
 1 file changed, 13 insertions(+), 71 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 134cfc980b70..c651aad6f34b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1062,20 +1062,6 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 	return of_device_get_match_data(dev);
 }
 
-static bool of_is_ancestor_of(struct device_node *test_ancestor,
-			      struct device_node *child)
-{
-	of_node_get(child);
-	while (child) {
-		if (child == test_ancestor) {
-			of_node_put(child);
-			return true;
-		}
-		child = of_get_next_parent(child);
-	}
-	return false;
-}
-
 static struct device_node *of_get_compat_node(struct device_node *np)
 {
 	of_node_get(np);
@@ -1106,71 +1092,27 @@ static struct device_node *of_get_compat_node_parent(struct device_node *np)
 	return node;
 }
 
-/**
- * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
- * @con_np: consumer device tree node
- * @sup_np: supplier device tree node
- *
- * Given a phandle to a supplier device tree node (@sup_np), this function
- * finds the device that owns the supplier device tree node and creates a
- * device link from @dev consumer device to the supplier device. This function
- * doesn't create device links for invalid scenarios such as trying to create a
- * link with a parent device as the consumer of its child device. In such
- * cases, it returns an error.
- *
- * Returns:
- * - 0 if fwnode link successfully created to supplier
- * - -EINVAL if the supplier link is invalid and should not be created
- * - -ENODEV if struct device will never be create for supplier
- */
-static int of_link_to_phandle(struct device_node *con_np,
+static void of_link_to_phandle(struct device_node *con_np,
 			      struct device_node *sup_np)
 {
-	struct device *sup_dev;
-	struct device_node *tmp_np = sup_np;
+	struct device_node *tmp_np = of_node_get(sup_np);
 
-	/*
-	 * Find the device node that contains the supplier phandle.  It may be
-	 * @sup_np or it may be an ancestor of @sup_np.
-	 */
-	sup_np = of_get_compat_node(sup_np);
-	if (!sup_np) {
-		pr_debug("Not linking %pOFP to %pOFP - No device\n",
-			 con_np, tmp_np);
-		return -ENODEV;
-	}
+	/* Check that sup_np and its ancestors are available. */
+	while (tmp_np) {
+		if (of_fwnode_handle(tmp_np)->dev) {
+			of_node_put(tmp_np);
+			break;
+		}
 
-	/*
-	 * Don't allow linking a device node as a consumer of one of its
-	 * descendant nodes. By definition, a child node can't be a functional
-	 * dependency for the parent node.
-	 */
-	if (of_is_ancestor_of(con_np, sup_np)) {
-		pr_debug("Not linking %pOFP to %pOFP - is descendant\n",
-			 con_np, sup_np);
-		of_node_put(sup_np);
-		return -EINVAL;
-	}
+		if (!of_device_is_available(tmp_np)) {
+			of_node_put(tmp_np);
+			return;
+		}
 
-	/*
-	 * Don't create links to "early devices" that won't have struct devices
-	 * created for them.
-	 */
-	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	if (!sup_dev &&
-	    (of_node_check_flag(sup_np, OF_POPULATED) ||
-	     sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
-		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
-			 con_np, sup_np);
-		of_node_put(sup_np);
-		return -ENODEV;
+		tmp_np = of_get_next_parent(tmp_np);
 	}
-	put_device(sup_dev);
 
 	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
-	of_node_put(sup_np);
-
-	return 0;
 }
 
 /**
-- 
2.39.1.456.gfc5497dd1b-goog

