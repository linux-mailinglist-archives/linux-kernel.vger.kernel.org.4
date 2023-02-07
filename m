Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF268CC2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBGBnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjBGBnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:43:03 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2182436449
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:37 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h11-20020a056a00230b00b00593b9e6ee79so7249167pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHkn7URR+Wxf1z7FIYAyiZv9JLKLhxrUf9FZBGK7iDo=;
        b=X39XxihNmunqazOTpIkjvNwzLVqnqPsFSYGCONP99rFEEJQTw0YZGZIGdZ2G3+9vBn
         jLSmp7NH6muan+2mAEaSNl5yTC31b7Q5T/udBdAm9llcuJBX5oUbFtMr82F8YTjvEw2Q
         doJbf8H77vo5qapVNP6ot4Js78tZNZVyzlWLT3b2iKSUDPPQA+szJzHBSQRLwdPsZQW6
         I+1EE/BAl9hm3vZvs+d558fqJuGREAMebpGf7PWMwlbfgiVJvDcr+ymp2N4YVKoNN+NW
         P1oJl3asALANFBOisjnueYBs1keAmZXsNfAhWIe4VBy5tPGQ8fI9v7pI096EUfbmPWQy
         vqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHkn7URR+Wxf1z7FIYAyiZv9JLKLhxrUf9FZBGK7iDo=;
        b=uUzz/YxN3MvZaAq+Rz3ScSmwhVU/09bnJ4s6oquaKDcVgcE6I+MetiyUqUgdkBFv14
         z8KaZbQ9fEhhkfMCTPyWuoyQMozUeCo573xQg0xuAtKIWKifwS3+Ynlxtr0H9ek3L4N1
         gsz++ekj+3wPlXPY7VfQXi7pj1A+/xVrUd9kxFQ69+HIMswVIU/LkWvi+RwACRtyH2Dn
         OSELx7YKvZPeaoGgTxOaSJoo8K0zaxxDX1l0y/y2a3CjUbAqt4ABMO4LP6zbYlhX0iDe
         g5Aa3EjRbq19Fh6IsOBJNHSAsyC2eGVt0iFou5vH4uWiQSuwlbVHdsH+UDwuDzFJ2YXs
         i8dA==
X-Gm-Message-State: AO0yUKXR9obWKB9lFhOmRMSALrD6Ugj80HKmyVuUNfQOjU7kicsj4Ssc
        jSDXKLZF2tFRTYSAe1sAN4CmholdNBg0Vpc=
X-Google-Smtp-Source: AK7set9gap7iVtj70G9Lb/TrrQyg8mWjZcfTC68UXJ/UbN0WLTioSeWRqcHRtuDY/mEnQb4c6/HizBrhqtXfNvE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90b:198c:b0:230:ebc1:3ab3 with SMTP
 id mv12-20020a17090b198c00b00230ebc13ab3mr146048pjb.104.1675734154917; Mon,
 06 Feb 2023 17:42:34 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:42:01 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-10-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 09/12] of: property: Simplify of_link_to_phandle()
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
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
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
2.39.1.519.gcb327c4b5f-goog

