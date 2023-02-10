Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B016E69264A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBJT1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjBJT1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:27:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C075463109
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:27:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so10962762pjq.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwrUc84I/sw9tW3rFINcSrPClBVAQXnQCQkcXqCJwLw=;
        b=hQAxFU0UWDL+c15mTPMopFsa+DtSgaC7lA9lDiZRF+/FBqEeZ1Sy6LFHOtrrmF7Sd2
         v3IQ4IcAubIN0sr/1IcMzervGsBGnx/9uVGBupdYwT7CYjSfUyh2ey92RUSzoBbbgpYn
         0yrTbvmX6Y5z5uGK5Fr3w7qB8YcpBQwxPf068+nJTDp3fMtnUOry570Pkrgu+Z0vJX0T
         /oD0wDMz7A461CTNkbVBFXvkA3x1tdf1xcy/8c23ZzOgsoyCkwyAxKek0E8ib8LB8umD
         JbVUcVsa0e4608OvA+Dgszfc0dcvb4K/Bn/gnpXg2T2gMtByW8tFjWx/0j/YrIp98Bph
         Jh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwrUc84I/sw9tW3rFINcSrPClBVAQXnQCQkcXqCJwLw=;
        b=LHNQV3rklEvgdJXmzCss0QgoRB7z557qYvDWkBGLujERx7fWbCNY7ZKm003RxBrqzW
         DyymPuyUKY6jmzMLux5hXxA6l3G6VQIlm1X/R+uL2Skw6beeXEhvKjh6SiIjVpISMWlG
         7zZ5Nnu9gu65bZAq4m1zZ/d5OGh7xUMKoC7byndXc1CpiipqjJq8qbrj8fw0TzgpHboC
         oJca4THgCFxekeiUaTyhR3VZKSdxvfjXQ0EmxQ30QuifQLEWjAYbZrfj+LT/i2ijcHWe
         d3vgQSnD2ebSIW1yR3LSkPuioPjGTyAoBBB9qNOBX60AR/MoWFx/74JgZhQRBxRjHybD
         AQSQ==
X-Gm-Message-State: AO0yUKV5LhOH1x9ypg2aVrFu6U4xyJV5hAeXXZcQ0G/1x+CML0PfUEMB
        IG5H6G/8MLMoq+fuVVrHbTiny8SkThLeAsP7sgT7iQ==
X-Google-Smtp-Source: AK7set8YqUGIKC41zQQA+imGuckADHerNWZeukO+5tCxdqLGYKK3iW3D9WDbQqKroQBsftoX1HY4I+fjcAkwH4jn0w0=
X-Received: by 2002:a17:90a:f018:b0:230:9e2a:ebd8 with SMTP id
 bt24-20020a17090af01800b002309e2aebd8mr2796418pjb.48.1676057267896; Fri, 10
 Feb 2023 11:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com> <20230210101333.h2e7hcl3ylsoh6fy@skbuf>
In-Reply-To: <20230210101333.h2e7hcl3ylsoh6fy@skbuf>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Feb 2023 11:27:11 -0800
Message-ID: <CAGETcx_SQJ1q_f8r+zKATF-EEb0P-T_ot15AQ1x1Vc_3h=XfCw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
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
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
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
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 2:13 AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> Hi Saravana,
>
> On Mon, Feb 06, 2023 at 05:41:52PM -0800, Saravana Kannan wrote:
> > Vladimir,
> >
> > Ccing you because DSA's and fw_devlink have known/existing problems
> > (still in my TODOs to fix). But I want to make sure this series doesn't
> > cause additional problems for DSA.
> >
> > All,
> >
> > This patch series improves fw_devlink in the following ways:
> >
> > 1. It no longer cares about a fwnode having a "compatible" property. It
> >    figures this out more dynamically. The only expectation is that
> >    fwnodes that are converted to devices actually get probed by a driver
> >    for the dependencies to be enforced correctly.
> >
> > 2. Finer grained dependency tracking. fw_devlink will now create device
> >    links from the consumer to the actual resource's device (if it has one,
> >    Eg: gpio_device) instead of the parent supplier device. This improves
> >    things like async suspend/resume ordering, potentially remove the need
> >    for frameworks to create device links, more parallelized async probing,
> >    and better sync_state() tracking.
> >
> > 3. Handle hardware/software quirks where a child firmware node gets
> >    populated as a device before its parent firmware node AND actually
> >    supplies a non-optional resource to the parent firmware node's
> >    device.
> >
> > 4. Way more robust at cycle handling (see patch for the insane cases).
> >
> > 5. Stops depending on OF_POPULATED to figure out some corner cases.
> >
> > 6. Simplifies the work that needs to be done by the firmware specific
> >    code.
> >
> > The v3 series has gone through my usual testing on my end and looks good
> > to me.
>
> Booted on an NXP LS1028A (arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts)
> and a Turris MOX (arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts)
> with no observed regressions.

Thanks for testing Vladimir!

> Is there something specific you would like
> me to test?


Not really, I just want to make sure the common DSA architectures
don't hit any regression. In the hardware you tested, are there cases
of PHYs where the supplier is the parent MDIO? I remember that being
the only case where I needed special casing
(FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) in fw_devlink -- so it'll be
good to make sure I didn't accidentally break anything there.


-Saravana
