Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CFA68CC3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBGBoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjBGBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:43:20 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C736694
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:50 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x9-20020aa79409000000b00593a1f7c3d8so7367802pfo.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qO7SA/IWYPEhdvQ3bg5afBtNBnjngejmFoW2WqOrddI=;
        b=GazeBruttlU5oTI33IWVV1tAUn4JRdRTAmGz0onik+n6U1T5h3g5Eqk7gGdOGMDK/b
         pISWVmhqDorcgwiUsTtbwUhwsXkQBy9FbOADGd10qeFLJKcjSWm9FlwkrDf0YSZnQ9+5
         MlI9mebazN/CBNgen9ENy7akZji0sNSLpJDHAKCcuu7sotue0FW2RA5Bj0NTsc48DOU1
         BJ2j+WUhTu8DoyxWUtbwaehDC8ppns7BWt2T/8qAizu6/ITBGfNfqXYJKkF1ZM6CyRxn
         ZcscZDUsMpAZKiRckNDj1rDjE8L096aAxpbX+tYBH1Uk2VlibG8o8TaOGQfpibf5qmCu
         A4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qO7SA/IWYPEhdvQ3bg5afBtNBnjngejmFoW2WqOrddI=;
        b=LlzMMhv4LL34dxB6YU1mOH88h7taUI6QaXWD3e1dOYIq7axSnJChziCT2tcrvpUP1W
         sJuHwegH+mG86ZqUMT9r4D3/AO50fSY2itJ9MAJQus73AsK18ai9JIKqDWqNZHmGEEpP
         HUXkD5PbnveSxYwSUSmOXXJkVoQneK0YdwLg6kWd1hCUYH72NVcmY/8BQLji6AHEzp2C
         MlgkxRTvYrk+vYTo3CGsk9H0+yVtNSWAWT6ncGuTfTGXaDSADyoIoI5uClUturrhyTCL
         CudLDy7MXlUtfW6ObTOOenLAmwMW00e2J0Vf6lbToZyXmjgsH/MMbbSSt1OfKzZi9/Kv
         RSXQ==
X-Gm-Message-State: AO0yUKUJlF3vK+hKp5YafeEIfY8Dt78W35Ao3k6RuQN/u24XpxDjaobO
        v+K76AXwdLJCD3oqHP3JBexK/0c2V8RzX28=
X-Google-Smtp-Source: AK7set8CF2GrP/NVxAgKrUj8AGlYPMKVoXXaqrQpeXZ8O8WzceQ78vPHdt/Q5BozlBJGRB5LWE1p0PTeySIpdfY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a63:7304:0:b0:4da:d745:98dd with SMTP id
 o4-20020a637304000000b004dad74598ddmr170930pgc.62.1675734160457; Mon, 06 Feb
 2023 17:42:40 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:42:03 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-12-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 11/12] firmware: arm_scmi: Set fwnode for the scmi_device
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

This allows fw_devlink to track and enforce supplier-consumer
dependencies for scmi_device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 35bb70724d44..cc2eba067575 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/of.h>
 
 #include "common.h"
 
@@ -191,7 +192,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 	scmi_dev->id = id;
 	scmi_dev->protocol_id = protocol;
 	scmi_dev->dev.parent = parent;
-	scmi_dev->dev.of_node = np;
+	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
 	scmi_dev->dev.bus = &scmi_bus_type;
 	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
-- 
2.39.1.519.gcb327c4b5f-goog

