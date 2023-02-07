Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C552968DD1A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBGPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjBGPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:34:43 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF1437B53
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:34:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id sa10so13666799ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rl1lFMsqmDVhtXhKfy18m6jDj/5z9y1kllSJsAsmfZk=;
        b=ES0aijgKys0wCbosVDBAOkP2lzjCjGfF1Exo8aTXmtS5T+xfsklQEnns8K7+3nqSbl
         W+j+3+WICSI8/lCYZZTsVE992b3PhptpJ/uUdWiTU0kHC12vtnIK3XtTmWIpqr92d2ab
         jriT1rcV3PSCEHsRPh5BHqA2LfESGaOyrD0sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rl1lFMsqmDVhtXhKfy18m6jDj/5z9y1kllSJsAsmfZk=;
        b=NgNCwliHEI4UTt6tKItL8t3HzPrPJdzwTNRU1RXpvHV1nR+CNcwWozvlQWDCGuwC6+
         hNRDlbirVa7boRQiAsHpl3KLuiUdsbe0GzuQzBpApvTIPPbyJmc+XyINO6Xtp0XVvUlT
         513z6TrcgZo+p23aR2UxoLLYKJjeiHPrLaaG5KRFdbR30Ou762G5rC303OnWpgk4QbJL
         IeXe18GKFHeOljPpjkexdKdpLItPZqnpoPWNc43ipdL8QNYPXfg0q3czKeZJAD7At38b
         AXOl1mztRz9VpCyKVcMV2osySpDPZvVYBKOiIKz/Vhj1G6tAbJDbr70UypRO7D9AHvIh
         pinA==
X-Gm-Message-State: AO0yUKUjFN8F17kvUuTOni+KW8yBUadeys8aWuE5IzlLEP72bfcFrjXl
        bNsiGSVvsxUo5YoaZ8fBRUbxBqdvDOWZy4V/8bE=
X-Google-Smtp-Source: AK7set/RtFEaZ2gAQEGtuMYd6K553EsQh4ti8AoJbMiMxWo7R/+JmR6FJgq5xRo3tL0+dL67cgC2jA==
X-Received: by 2002:a17:906:a18c:b0:88a:bb13:7329 with SMTP id s12-20020a170906a18c00b0088abb137329mr4112254ejy.53.1675784079667;
        Tue, 07 Feb 2023 07:34:39 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id ha4-20020a170906a88400b0088744fc7084sm7021090ejb.38.2023.02.07.07.34.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 07:34:39 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so13472614wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:34:39 -0800 (PST)
X-Received: by 2002:a05:600c:2f8f:b0:3d2:3e2a:d377 with SMTP id
 t15-20020a05600c2f8f00b003d23e2ad377mr327031wmn.118.1675783687736; Tue, 07
 Feb 2023 07:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Feb 2023 07:27:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UZxz-nHNsPO1P_W0MHFD8UDTvKXpFm1dSB+53NJaP2=w@mail.gmail.com>
Message-ID: <CAD=FV=UZxz-nHNsPO1P_W0MHFD8UDTvKXpFm1dSB+53NJaP2=w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 6, 2023 at 5:42 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
> Jean-Philippe,
>
> Can I get your Tested-by's for this v3 series please?
>
> Vladimir,
>
> Ccing you because DSA's and fw_devlink have known/existing problems
> (still in my TODOs to fix). But I want to make sure this series doesn't
> cause additional problems for DSA.
>
> All,
>
> This patch series improves fw_devlink in the following ways:
>
> 1. It no longer cares about a fwnode having a "compatible" property. It
>    figures this out more dynamically. The only expectation is that
>    fwnodes that are converted to devices actually get probed by a driver
>    for the dependencies to be enforced correctly.
>
> 2. Finer grained dependency tracking. fw_devlink will now create device
>    links from the consumer to the actual resource's device (if it has one,
>    Eg: gpio_device) instead of the parent supplier device. This improves
>    things like async suspend/resume ordering, potentially remove the need
>    for frameworks to create device links, more parallelized async probing,
>    and better sync_state() tracking.
>
> 3. Handle hardware/software quirks where a child firmware node gets
>    populated as a device before its parent firmware node AND actually
>    supplies a non-optional resource to the parent firmware node's
>    device.
>
> 4. Way more robust at cycle handling (see patch for the insane cases).
>
> 5. Stops depending on OF_POPULATED to figure out some corner cases.
>
> 6. Simplifies the work that needs to be done by the firmware specific
>    code.
>
> The v3 series has gone through my usual testing on my end and looks good
> to me.
>
> Thanks,
> Saravana
>
> [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
> [2] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com/
>
> v1 -> v2:
> - Fixed Patch 1 to handle a corner case discussed in [2].
> - New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 drivers.
> - New patch 11 to add fw_devlink support for SCMI devices.
>
> v2 -> v3:
> - Addressed most of Andy's comments in v2
> - Added Colin and Sudeep's Tested-by for the series (except the imx and
>   renesas patches)
> - Added Sudeep's Acked-by for the scmi patch.
> - Added Geert's Reviewed-by for the renesas patch.
> - Fixed gpiolib crash reported by Naresh.
> - Patch 6: Fix __fwnode_links_move_consumers() to preserve fwnode link flags.
> - New Patch 12 to fix nvmem-cells issue reported by Maxim(s)/Miquel.
> - Deleted some stale function doc in Patch 8
>
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
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> Saravana Kannan (12):
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
>   mtd: mtdpart: Don't create platform device that'll never probe

I tested the whole series together on several devices. I tried to test
on a wide variety since previous versions had broken due to all the
dependency cycles in the display and some of these devices used
different components in their display pipeline. I didn't do massive
testing but did confirm that basic devices came up, including display.

Devices tested with your v3 applied atop v6.2-rc7-11-g05ecb680708a:

* sc7180-trogdor-lazor (with ps8640 bridge), which had failed to bring
up the display on v2.

* sc7180-trogdor-lazor (with sn65dsi86 bridge)

* sc7180-trogdor-pazquel (with sn65dsi86 bridge)

* sc7180-trogdor-homestar (with ps8640 bridge)

* sc7180-trogdor-wormdingler

* sc7280-herobrine-villager

Tested-by: Douglas Anderson <dianders@chromium.org>
