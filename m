Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4693368CC3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjBGBoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBGBnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:43:22 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4EC366A5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:51 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m5-20020a17090a414500b00230c1a511a5so1681236pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YX1zBRfC33D3rDRElKAdT20jJS5RQeSlv0JzqWYnjho=;
        b=UGmq1xHhmv8QgalRGnvex5vaBwzzKCS6zloJhLFOA04JYhf7s2xljRYpy9kTAoNsHa
         iBC98QSDMciwj7mZAoPpI2usajIcl1gF62f5Z4nG2GjxXwW1tEOTSt3uCwYi8iyDdG37
         BQfwQH+F5b5B8hHp73/BToUo9eBPbPtsoJG7VHsq9ww2xJmU91i6mybd4OadC8hcmn4L
         z/JS/fusQ1z+bJZfl9x8ljB4BFuvxFXBUNKd3sGG9GJYtq6qpJhSHd3ZvicyZg0osOk+
         QxgZAlVpjyrodYVEXosDI3FM0qnhjaVmzWT6ld85NejZtUeLAUKpBMz5nIKrGLcp4W86
         p/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YX1zBRfC33D3rDRElKAdT20jJS5RQeSlv0JzqWYnjho=;
        b=Gs/7ePtjMFcsv4+d1pWi52tpnkBtvgFJT7Tfr1X2b1VVLbfwc/XXcWs+aKuNZ88wkg
         p7j2MHZCpKCTagKwQSyMBKSR5Oi/cY9n1Ehv7mwD2qn4R4y/fll3m0HBS1lZUrHXuMCe
         5svpZLZV3yilY9jm/GyUbpML7G0j6B4o0XKREZ1YhhFlrPKlAOgpyFvGlXmWWnB7CFXo
         mcs2pe+2ymKUz4YAh9FmV68kGqWkMaZI0VFqtPjUMmx+YYY53YTQ3RsE24J3cvaRrZxm
         Jrec1BUcF4ZDrGT6XWuiDcnuli6n/3iN2/PLgQUo/NicqWUnbW2vH/MGCrTG6iFql5YT
         qjGg==
X-Gm-Message-State: AO0yUKUTdoJak5Ps9gJQ7IOaMXfQNLomXM1UMMnabFMg/wEDKrqVK8xk
        Zn4qzE8+poXG2qgu2rOorAeY35DQXoZrqS4=
X-Google-Smtp-Source: AK7set8Gcli9J3BzSmSCx9wcmgEyp38uzEhI1HIWAsHDVULR2jB9pwdeXZpjU2A6RPq1Ak9f9gnun0I1Kq/a1mU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90a:1d4e:b0:230:ae97:c349 with SMTP
 id u14-20020a17090a1d4e00b00230ae97c349mr441075pju.8.1675734163194; Mon, 06
 Feb 2023 17:42:43 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:42:04 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-13-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 12/12] mtd: mtdpart: Don't create platform device that'll
 never probe
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

These "nvmem-cells" platform devices never get probed because there's no
platform driver for it and it's never used anywhere else. So it's a
waste of memory. These devices also cause fw_devlink to block nvmem
consumers of "nvmem-cells" partition from probing because the supplier
device never probes.

So stop creating platform devices for nvmem-cells partitions to avoid
wasting memory and to avoid blocking probing of consumers.

Reported-by: Maxim Kiselev <bigunclemax@gmail.com>
Fixes: bcdf0315a61a ("mtd: call of_platform_populate() for MTD partitions")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/mtd/mtdpart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index d442fa94c872..85f5ee6f06fc 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -577,6 +577,7 @@ static int mtd_part_of_parse(struct mtd_info *master,
 {
 	struct mtd_part_parser *parser;
 	struct device_node *np;
+	struct device_node *child;
 	struct property *prop;
 	struct device *dev;
 	const char *compat;
@@ -594,6 +595,15 @@ static int mtd_part_of_parse(struct mtd_info *master,
 	else
 		np = of_get_child_by_name(np, "partitions");
 
+	/*
+	 * Don't create devices that are added to a bus but will never get
+	 * probed. That'll cause fw_devlink to block probing of consumers of
+	 * this partition until the partition device is probed.
+	 */
+	for_each_child_of_node(np, child)
+		if (of_device_is_compatible(child, "nvmem-cells"))
+			of_node_set_flag(child, OF_POPULATED);
+
 	of_property_for_each_string(np, "compatible", prop, compat) {
 		parser = mtd_part_get_compatible_parser(compat);
 		if (!parser)
-- 
2.39.1.519.gcb327c4b5f-goog

