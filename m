Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0568CC16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBGBmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjBGBm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:42:28 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003343527E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:21 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f19-20020a631013000000b004e8c27fa528so5951357pgl.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORUuC30mhLyGGOfOGNQGmV2Hk9NLu8NgqlPyUePgVtw=;
        b=W3ks5YEw7SKIgSIZBtQHBL9lJVPSdYZt5YLLOMNiqg39kU3nN1EI6XuA+B32uaPZGb
         v5zyhRmRRHO+O/PDHZr10O4cRAMqIo+F89AcNblg/s/+76O4QIK+2qBAbUZrxge36Zai
         oUQ3lkDhN+g7lBRIxR1KVI98eol03ANv+ysGxNp9Jy33gMZ7+KWT14YWjTKmLM4h0Sde
         uDNF/Fk2U8cuXtdVSlDGUvhsCS+fTpqnyi3ghq5nNuitlb38EuGaeD8xzBpXE/R4GDSO
         N9LcyuvRftt3ULpiqwLSIoYSZ3EjoLNyWNXZS4LCua4bI5CqUx3cJx+UrAWXqFnajwKW
         grxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORUuC30mhLyGGOfOGNQGmV2Hk9NLu8NgqlPyUePgVtw=;
        b=xCK8AzHkAvRfWtmyO9UKf/En7k7dlrLmXaSzNwW4H+ewmIP9SMRGclUJW5VqZ1gEOq
         gvtil3TFhOrivnsIJeOcTxbJcMue8UBM9VgENn0cJVzDwmj97QzCbcCoiwyemTwNX55S
         hmfnDkff1RB1QbMGdq1Ky0icq4THWj6F2yHGpDtrijaEQlOAjqb7trY6mpL1UTQ2WnbO
         b+ftDYBsAYnSZZtv9kTJK1faC61KZN2gG3ERFaeOOY0Xzwn14LfxvghZMYQLtN7c+Vyz
         aQusTxd2JIUUVBWaIWElyTxDbLA6pZImW0jlWedbhPcNBVoSPJrjEgJbcQTgtD6pw7ie
         FT6Q==
X-Gm-Message-State: AO0yUKXzYSis4S8oSYY72h70aS7DWqjUQDn5/xZrTHSA+BE9pv+IYKnW
        7xzkX42wAunEIkz6x1WgDPZz0Qbip7YcBUI=
X-Google-Smtp-Source: AK7set8txtYYhJ0J+28pL4WUJBO9Kkr3uP9QQWYQBMNjYhLp0mg9chNGGE1J5xNq3IdUI/epAkGwDw5ZAcogFH0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90a:3f8f:b0:230:792d:7519 with SMTP
 id m15-20020a17090a3f8f00b00230792d7519mr425744pjc.22.1675734141281; Mon, 06
 Feb 2023 17:42:21 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:41:56 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-5-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 04/12] gpiolib: Clear the gpio_device's fwnode initialized
 flag before adding
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

Registering an irqdomain sets the flag for the fwnode. But having the
flag set when a device is added is interpreted by fw_devlink to mean the
device has already been initialized and will never probe. This prevents
fw_devlink from creating device links with the gpio_device as a
supplier. So, clear the flag before adding the device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/gpio/gpiolib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 939c776b9488..bdb9493857eb 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -578,6 +578,13 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 {
 	int ret;
 
+	/*
+	 * If fwnode doesn't belong to another device, it's safe to clear its
+	 * initialized flag.
+	 */
+	if (gdev->dev.fwnode && !gdev->dev.fwnode->dev)
+		fwnode_dev_initialized(gdev->dev.fwnode, false);
+
 	ret = gcdev_register(gdev, gpio_devt);
 	if (ret)
 		return ret;
-- 
2.39.1.519.gcb327c4b5f-goog

