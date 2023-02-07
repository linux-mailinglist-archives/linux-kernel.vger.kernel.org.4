Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC4B68CC03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBGBmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjBGBmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:42:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C310A9A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:42:11 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 144-20020a621896000000b0059e73803cdcso3164457pfy.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Lzwmfi68lbdrUMbtc6adBz2FR099zCl1IbhLNZPH1k=;
        b=AiCfxSp7rvYdlgl0hl4blBlUcDhKmP2ipQWAy9D+v4OffGK0tOAZAVe6vj1m5Qqb1N
         EjVKK0seT/KHqRY31wLEaQnNOfPf2YnCeLt3UYVQcttmFjIdZOKxHDXNZbOFbd6VC/Qs
         YNWCMN8S77uoudgWgBuiUlIQHmrkrOS93xAFfs/JCgWixMPTZKa7k1u41pU7om9nNL9z
         xPGzdgebPBxzGe2RJ+Q4NwYLmakenKFtNcj/xZeImi7KWdRpF2+9iQmiJWyzIbJMCV4D
         E4rbGyjlteWJX7skmBf/WRPXHpbjKXCwbF2v1IQwRsB/gvBU/gqaLXL7ZiasmH3GDDgW
         1JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Lzwmfi68lbdrUMbtc6adBz2FR099zCl1IbhLNZPH1k=;
        b=d4h0L1sdVIuUFdFnVViP0rR0K3B8+1x36tREmKSfX6KMZiOIPQ67TSj5JNpFl6H1i9
         MlAjX2ppDvK2MZKGBmNlDRcnR/nGtZQNMxs9hfYnPo9VEKYapoRelfOcU5r3PWUf8N+L
         AHbeliMX0cJxWFxWvzL1ea/QFRECmbhn7rPYyuOUEvCzZuQF8DnV8x3rvU3EU6u2cFd8
         bWxDK7Z9kw4bdVx+Atjx4W8GDBsVgSHAgc+8dm51LP255PhAlz00iOepDUYTrrSo4Nmk
         pZaoKxps3LHsOwmOhOfDcNUELSqh1nohI6lKa6fxx9K6aHHdi2NahTPhGgxAHG5+JOm6
         FMmA==
X-Gm-Message-State: AO0yUKVdiiW0vzN4hyfBOVsItovAX0UVsj9b8jye08fw6UHn0fX4Xw+O
        68wKNXAJse48OP/G85fW5A8LBfuApRAKv8I=
X-Google-Smtp-Source: AK7set+EAwfeBS4EZdincaahfqhxKjG9TUS0REB1NbACugqOxKLsnOyVz3Xl+5qV5fiy7WsvyHpw/x+7WRzIigU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90a:5a05:b0:22c:46e:6510 with SMTP
 id b5-20020a17090a5a0500b0022c046e6510mr459339pjd.9.1675734130693; Mon, 06
 Feb 2023 17:42:10 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:41:52 -0800
Message-Id: <20230207014207.1678715-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 00/12] fw_devlink improvements
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

Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
Jean-Philippe,

Can I get your Tested-by's for this v3 series please?

Vladimir,

Ccing you because DSA's and fw_devlink have known/existing problems
(still in my TODOs to fix). But I want to make sure this series doesn't
cause additional problems for DSA.

All,

This patch series improves fw_devlink in the following ways:

1. It no longer cares about a fwnode having a "compatible" property. It
   figures this out more dynamically. The only expectation is that
   fwnodes that are converted to devices actually get probed by a driver
   for the dependencies to be enforced correctly.

2. Finer grained dependency tracking. fw_devlink will now create device
   links from the consumer to the actual resource's device (if it has one,
   Eg: gpio_device) instead of the parent supplier device. This improves
   things like async suspend/resume ordering, potentially remove the need
   for frameworks to create device links, more parallelized async probing,
   and better sync_state() tracking.

3. Handle hardware/software quirks where a child firmware node gets
   populated as a device before its parent firmware node AND actually
   supplies a non-optional resource to the parent firmware node's
   device.

4. Way more robust at cycle handling (see patch for the insane cases).

5. Stops depending on OF_POPULATED to figure out some corner cases.

6. Simplifies the work that needs to be done by the firmware specific
   code.

The v3 series has gone through my usual testing on my end and looks good
to me.

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com/

v1 -> v2:
- Fixed Patch 1 to handle a corner case discussed in [2].
- New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 drivers.
- New patch 11 to add fw_devlink support for SCMI devices.

v2 -> v3:
- Addressed most of Andy's comments in v2
- Added Colin and Sudeep's Tested-by for the series (except the imx and
  renesas patches)
- Added Sudeep's Acked-by for the scmi patch.
- Added Geert's Reviewed-by for the renesas patch.
- Fixed gpiolib crash reported by Naresh.
- Patch 6: Fix __fwnode_links_move_consumers() to preserve fwnode link flags.
- New Patch 12 to fix nvmem-cells issue reported by Maxim(s)/Miquel.
- Deleted some stale function doc in Patch 8

Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Stultz <jstultz@google.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maxim Kiselev <bigunclemax@gmail.com>
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: Colin Foster <colin.foster@in-advantage.com>
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
Cc: Jean-Philippe Brucker <jpb@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>

Saravana Kannan (12):
  driver core: fw_devlink: Don't purge child fwnode's consumer links
  driver core: fw_devlink: Improve check for fwnode with no
    device/driver
  soc: renesas: Move away from using OF_POPULATED for fw_devlink
  gpiolib: Clear the gpio_device's fwnode initialized flag before adding
  driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
  driver core: fw_devlink: Allow marking a fwnode link as being part of
    a cycle
  driver core: fw_devlink: Consolidate device link flag computation
  driver core: fw_devlink: Make cycle detection more robust
  of: property: Simplify of_link_to_phandle()
  irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
  firmware: arm_scmi: Set fwnode for the scmi_device
  mtd: mtdpart: Don't create platform device that'll never probe

 drivers/base/core.c             | 449 +++++++++++++++++++++-----------
 drivers/firmware/arm_scmi/bus.c |   3 +-
 drivers/gpio/gpiolib.c          |   7 +
 drivers/irqchip/irq-imx-gpcv2.c |   1 +
 drivers/mtd/mtdpart.c           |  10 +
 drivers/of/property.c           |  84 +-----
 drivers/soc/imx/gpcv2.c         |   2 +-
 drivers/soc/renesas/rcar-sysc.c |   2 +-
 include/linux/device.h          |   1 +
 include/linux/fwnode.h          |  12 +-
 10 files changed, 344 insertions(+), 227 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog

