Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337E68CC34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjBGBoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBGBnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:43:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1DE36464
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52423723b55so112077007b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6A/x+0p8PMNq+UMi21kh87Q0g2/Jiu6oRRXgMmXymQw=;
        b=L5SU9yrkdCoQISM+/wTwNBtt9so41vGiUxcF1ahsAlqhPaBFdZ9BDHj5PmwJYCl3t5
         yHWeuyzyFi1Vdpek1s61VTHHj+vCMUwdpIlXNVlAwD+q2ZgHmHT68Mgoisp0fKBP+9Ye
         AKuV+3jXCiNI4TvL5bTaYwjcjvjt6nHSeRli1b16m+nWjdvaQpCaLUzxcHWRE8E5TnS1
         d0NPJtXNewRsKNlQC1Z7BIw/LVmY8gig4kKT1UdBbSEKM0EGx8tI2Hg9ZraY7mst5nHt
         8sz2cJJNBzpaUhYmCNVGrSD9LOhg+ouviu7qdeJhnsPY9u5+SlS77RJ9No7k5rq3weF9
         /HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A/x+0p8PMNq+UMi21kh87Q0g2/Jiu6oRRXgMmXymQw=;
        b=1HLWhbpiRjQfnCiA4FzNHL6habIUgsRF1nyHC6gm7tvbE54THfMKJUq+BZONeUuVXY
         RyGKngur9RgezcXo2kY/CgAmffX2YwOzSZVpqDxszu3zZGE9j7kX50g3qvhT+2jSy1O1
         SAykAJTEAe3DD/JNtENKG9dMBiQLY4QFsmR1t0stJeAawwV3nXuuDfa/zuEomuc7ryUY
         1IX/xcScnC8EFAyeh5g/K7dQvq3OYWAcnvAihcB7AtxOFrWzlgTzG0sYINnmV1s2yagV
         RAnfdW+x/W4KVgVaDuTeuopl32x8gYqR6Y906HtI4PtK0evqRq7qohL5VR1zz4Ne651P
         Ip4w==
X-Gm-Message-State: AO0yUKXByYSfeDTmdGGf7ZagpdkYhHieTfcIcseypczNGzFuJHcyo8ry
        rfGW1vIic7JqDOQtpS6NqE1B63MxBfAW6ME=
X-Google-Smtp-Source: AK7set+GZlE4Povwj1RwyeX6tO9l13sdnFTxa+J8n89nUczFeQdItr8brE7AhM3WB/T2LWQ/yln8wcGWuiwenUI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a81:6146:0:b0:526:a392:c07e with SMTP id
 v67-20020a816146000000b00526a392c07emr128848ywb.106.1675734157775; Mon, 06
 Feb 2023 17:42:37 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:42:02 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-11-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 10/12] irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
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

Since this device is only partially initialized by the irqchip driver,
we need to mark the fwnode device as not initialized. This is to let
fw_devlink know that the device will be completely initialized at a
later point. That way, fw_devlink will continue to defer the probe of
the power domain consumers till the power domain driver successfully
binds to the struct device and completes the initialization of the
device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 1 +
 drivers/soc/imx/gpcv2.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index b9c22f764b4d..8a0e82067924 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	 * later the GPC power domain driver will not be skipped.
 	 */
 	of_node_clear_flag(node, OF_POPULATED);
+	fwnode_dev_initialized(domain->fwnode, false);
 	return 0;
 }
 
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 7a47d14fde44..4b3300b090a8 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1518,7 +1518,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx_pgc_power_down;
 
 		pd_pdev->dev.parent = dev;
-		pd_pdev->dev.of_node = np;
+		device_set_node(&pd_pdev->dev, of_fwnode_handle(np));
 
 		ret = platform_device_add(pd_pdev);
 		if (ret) {
-- 
2.39.1.519.gcb327c4b5f-goog

