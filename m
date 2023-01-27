Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D847A67DA47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjA0ALt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjA0ALr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:11:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86EC13D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:11:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so3645495ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h6fKpqor2jTotXSn3372bFcG4CpzS45+gNVV/kwVyH8=;
        b=T8nzXdhvva6D8ItxjLauAJb7Lyid2FP9CiV7mBEHmzqXkhpihBiea+Ioio0cAu8xfk
         38uctdNEzdnoayDngTT6u5jAB3K9SyCqO69ZHzu6SQIT4G1/4H8n5lUhteIFoEcLkrd/
         NC7bGETX0A7PnfR5ScrGUjnQD80Sz0m7kXCTUVUqTJKM5nBtRvjssVXvElskyh9nOA5B
         kSA2Howr4hDZAHM9Lbx9b8nMy3QluBCPXDiZJRb7hYpVpwWoEHcmduWXSpIpEiJh192d
         rm10BYlry79ywPtc9qUZQs6Ng4FGlUz3MjWb+CD/PKIna5stlSnhXFhB/d+N00jJdvc2
         wtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6fKpqor2jTotXSn3372bFcG4CpzS45+gNVV/kwVyH8=;
        b=RxQRnXjG/Tt+XZY+0YeLG6NV6PndepGXMAmvDx/KwmBPULwRdFhlUbFPQcszYETDGl
         iOmnbpgoHty6xYHy+lfVk5RgaKgjL58r14m6jGGtBI+0ElVVN6xfY2sf4yl30JPLBWKF
         2bSZGQ35odFEtcgzTwZ43tcp4pDvFWb/RU1r5KEscqbh7uaedk3oorRpeLWQUco7KQ83
         oS5wM3w762VCAJ/imNSDN8MCqa40bKjmEWA7D80/umX3uS9mP/F8ui+jCN2FE4N92oA7
         anOXxvI5PgM6Qoqc9UnxaJGMz8ZcVjXIA9lAVVTf0WvwPc38ZUx/nxvrRVgnU4Pg9Y7e
         TqQQ==
X-Gm-Message-State: AO0yUKUqXnAGZIroZsgByaBdHrkOkEJTzqwPyWdQV/Vpg0aW2wC5RpDj
        cVxeyAZinwUtBeaZG5Np8x5g1f4ajKoCY0c=
X-Google-Smtp-Source: AK7set8HC3iQRXqsprtDAE3CdIOQ7dDgidlu4bwwuFWNlmxmQapx1Ya/7QpSiTTdct3N5H90xaY9cR/X6RtO3kA=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a25:df86:0:b0:80b:7fa3:d33f with SMTP id
 w128-20020a25df86000000b0080b7fa3d33fmr1197459ybg.599.1674778304965; Thu, 26
 Jan 2023 16:11:44 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:27 -0800
Message-Id: <20230127001141.407071-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 00/11] fw_devlink improvements
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves fw_devlink in the following ways:

1. It no longer cares about a fwnode having a "compatible" property. It
   figures this our more dynamically. The only expectation is that
   fwnode that are converted to devices actually get probed by a driver
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

Sorry it took a while to roll in the fixes I gave in the v1 series
thread[1] into a v2 series.

Since I didn't make any additional changes on top of what I already gave
in the v1 thread and Dmitry is very eager to get this series going, I'm
sending it out without testing locally. I already tested these patches a
few months ago as part of the v1 series. So I don't expect any major
issues. I'll test them again on my end in the next few days and will
report here if I actually find anything wrong.

Tony, Naresh, Abel, Sudeep, Geert,

I got the following reviewed by's and tested by's a few months back, but
it's been 5 months since I sent out v1. So I wasn't sure if it was okay
to include them in the v2 commits. Let me know if you are okay with this
being included in the commits and/or if you want to test this series
again.

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Abel Vesa <abel.vesa@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Dmitry, Maxim(s), Miquel, Luca, Doug, Colin, Martin, Jean-Philippe,

I've Cc-ed you because I had pointed you to v1 of this series + the
patches in that thread at one point or another as a fix to some issue
you were facing. It'd appreciate it if you can test this series and
report any issues, or things it fixed and give Tested-bys.

In addition, if you can also apply a revert of this series[2] and delete
driver_deferred_probe_check_state() from your tree and see if you hit
any issues and report them, that'd be great too! I'm pretty sure some of
you will hit issues with that. I want to fix those next and then
revert[2].

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20220819221616.2107893-1-saravanak@google.com/
[3] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com/

v1 -> v2:
- Fixed Patch 1 to handle a corner case discussed in [3].
- New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 drivers.
- New patch 11 to add fw_devlink support for SCMI devices.

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

Saravana Kannan (11):
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

 drivers/base/core.c             | 443 +++++++++++++++++++++-----------
 drivers/firmware/arm_scmi/bus.c |   2 +
 drivers/gpio/gpiolib.c          |   6 +
 drivers/irqchip/irq-imx-gpcv2.c |   1 +
 drivers/of/property.c           |  84 +-----
 drivers/soc/imx/gpcv2.c         |   1 +
 drivers/soc/renesas/rcar-sysc.c |   2 +-
 include/linux/device.h          |   1 +
 include/linux/fwnode.h          |  12 +-
 9 files changed, 332 insertions(+), 220 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

