Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C259680B41
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbjA3KtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjA3Ks5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:48:57 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5C2E0E7;
        Mon, 30 Jan 2023 02:48:54 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D390DE0017;
        Mon, 30 Jan 2023 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675075732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzHSMHv3dQqwmrI3sIIweVUhA59SIPhf3LtT2+gMqwo=;
        b=MQEW+BWX07JMZKyk7WxIMNMKaml7A1vMbtjmGrh6EPmaJiv2WJRTQE06Ze6pOiCsOClePO
        exJH0V47FbkEzh/tXaUIsD6FeIdhx08yME4jZfjovH9zJk4vlXfnWUfBh4e38r+Is+QZGc
        83XnM7EpMzE28GXCmGX7PavPiIuUoNVTh4xSrkeQWeAVsrMYCd0XE24fv3YIP89J2duoiA
        XtfC0nU3RTq2vmjkpzrLpAKKFUlMYBpWl5WArV87flGN+O/lcdfS+nivatQ7y95vo/8YKW
        uxkn4gifipv2t7q8OUR/lbJEEdcUT2FgIQSxHiiqiDNNJGBpMPphBsrmrJJGBw==
Date:   Mon, 30 Jan 2023 11:48:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Tony Lindgren <tony@atomide.com>,
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
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
Message-ID: <20230130114839.379f08bd@xps-13>
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
References: <20230127001141.407071-1-saravanak@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim & Maxim,

saravanak@google.com wrote on Thu, 26 Jan 2023 16:11:27 -0800:

> This patch series improves fw_devlink in the following ways:
>=20
> 1. It no longer cares about a fwnode having a "compatible" property. It
>    figures this our more dynamically. The only expectation is that
>    fwnode that are converted to devices actually get probed by a driver
>    for the dependencies to be enforced correctly.
>=20
> 2. Finer grained dependency tracking. fw_devlink will now create device
>    links from the consumer to the actual resource's device (if it has one,
>    Eg: gpio_device) instead of the parent supplier device. This improves
>    things like async suspend/resume ordering, potentially remove the need
>    for frameworks to create device links, more parallelized async probing,
>    and better sync_state() tracking.
>=20
> 3. Handle hardware/software quirks where a child firmware node gets
>    populated as a device before its parent firmware node AND actually
>    supplies a non-optional resource to the parent firmware node's
>    device.
>=20
> 4. Way more robust at cycle handling (see patch for the insane cases).
>=20
> 5. Stops depending on OF_POPULATED to figure out some corner cases.
>=20
> 6. Simplifies the work that needs to be done by the firmware specific
>    code.
>=20
> Sorry it took a while to roll in the fixes I gave in the v1 series
> thread[1] into a v2 series.
>=20
> Since I didn't make any additional changes on top of what I already gave
> in the v1 thread and Dmitry is very eager to get this series going, I'm
> sending it out without testing locally. I already tested these patches a
> few months ago as part of the v1 series. So I don't expect any major
> issues. I'll test them again on my end in the next few days and will
> report here if I actually find anything wrong.
>=20
> Tony, Naresh, Abel, Sudeep, Geert,
>=20
> I got the following reviewed by's and tested by's a few months back, but
> it's been 5 months since I sent out v1. So I wasn't sure if it was okay
> to include them in the v2 commits. Let me know if you are okay with this
> being included in the commits and/or if you want to test this series
> again.
>=20
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Abel Vesa <abel.vesa@linaro.org>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Dmitry, Maxim(s), Miquel, Luca, Doug, Colin, Martin, Jean-Philippe,
>=20
> I've Cc-ed you because I had pointed you to v1 of this series + the
> patches in that thread at one point or another as a fix to some issue
> you were facing. It'd appreciate it if you can test this series and
> report any issues, or things it fixed and give Tested-bys.

Maxim & Maxim I would really appreciate if you could validate that the
original issue you had is solved with this version? I don't have any
hardware suffering from this issue.

> In addition, if you can also apply a revert of this series[2] and delete
> driver_deferred_probe_check_state() from your tree and see if you hit
> any issues and report them, that'd be great too! I'm pretty sure some of
> you will hit issues with that. I want to fix those next and then
> revert[2].
>=20
> Thanks,
> Saravana
>=20
> [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@goog=
le.com/
> [2] - https://lore.kernel.org/lkml/20220819221616.2107893-1-saravanak@goo=
gle.com/
> [3] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=3DMre5j_vkV=
mZojeiumUGG6QZQ@mail.gmail.com/
>=20
> v1 -> v2:
> - Fixed Patch 1 to handle a corner case discussed in [3].
> - New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 drivers.
> - New patch 11 to add fw_devlink support for SCMI devices.
>=20
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Maxim Kiselev <bigunclemax@gmail.com>
> Cc: Maxim Kochetkov <fido_max@inbox.ru>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Cc: Colin Foster <colin.foster@in-advantage.com>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> Cc: Jean-Philippe Brucker <jpb@kernel.org>
>=20
> Saravana Kannan (11):
>   driver core: fw_devlink: Don't purge child fwnode's consumer links
>   driver core: fw_devlink: Improve check for fwnode with no
>     device/driver
>   soc: renesas: Move away from using OF_POPULATED for fw_devlink
>   gpiolib: Clear the gpio_device's fwnode initialized flag before adding
>   driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
>   driver core: fw_devlink: Allow marking a fwnode link as being part of
>     a cycle
>   driver core: fw_devlink: Consolidate device link flag computation
>   driver core: fw_devlink: Make cycle detection more robust
>   of: property: Simplify of_link_to_phandle()
>   irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
>   firmware: arm_scmi: Set fwnode for the scmi_device
>=20
>  drivers/base/core.c             | 443 +++++++++++++++++++++-----------
>  drivers/firmware/arm_scmi/bus.c |   2 +
>  drivers/gpio/gpiolib.c          |   6 +
>  drivers/irqchip/irq-imx-gpcv2.c |   1 +
>  drivers/of/property.c           |  84 +-----
>  drivers/soc/imx/gpcv2.c         |   1 +
>  drivers/soc/renesas/rcar-sysc.c |   2 +-
>  include/linux/device.h          |   1 +
>  include/linux/fwnode.h          |  12 +-
>  9 files changed, 332 insertions(+), 220 deletions(-)
>=20


Thanks,
Miqu=C3=A8l
