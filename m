Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC1869FCB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBVUGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjBVUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:06:26 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567A2D14E;
        Wed, 22 Feb 2023 12:06:21 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id s26so35172857edw.11;
        Wed, 22 Feb 2023 12:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FrhnmpFXYJ2ruds7IcpiLVKaKCtCwhucB8NT2yoBtA=;
        b=ubCT1RNZBZ4WTO+YZ9Sm6+nzZRKEgxvVJvR/2LNJH8E/7Eo1892NEi4+KLgwWWX/q5
         do3lZJ4jdT8RjMsspIfmt/SB9NlyYC9/RVXd+DNdt3WsREP6Qr3vNGL8q4sEefxtTFiL
         34UC5J9gp59gF0FaDHUfjN2Doz9XGb8Wje/nirZXa+35KPCoEU5/SjyxTtykil9wcgIH
         S4Vn/ioPZsgMqU6Sqm8ZG5UybS2o5zrennC1D5zAdqYzevXVtJj1lhalgjPR7LP+SYHd
         u26XBT22bkXbsfwmKRisHCNng+QTHfSM2FlDLGlnyly2d6G09m/IeveHzao88QeVhRGH
         EEhQ==
X-Gm-Message-State: AO0yUKWIhSwu8baeSXZv7MTesmmFhmMpYJeGy0NGIkZnQZuUVtH8KPse
        JGd9iUW0Y2zMZsM7kHg6AXT1f8gjjIvIg0v8nlM=
X-Google-Smtp-Source: AK7set/po3VyktwxEsvJqz0FpIkkq7uzVUEz8zFA6NgPjaNe3NoxjdDwF5w8A3dbosoUaeENbiJ8bZNdJt2gAN+dbw0=
X-Received: by 2002:a17:906:3b84:b0:877:747d:1108 with SMTP id
 u4-20020a1709063b8400b00877747d1108mr8024476ejf.5.1677096380241; Wed, 22 Feb
 2023 12:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-7-daniel.lezcano@linaro.org> <CAJZ5v0gTmi7ZeDDdHWGWju4m3bv2366oVqSP1dGOT+3jLV-jaw@mail.gmail.com>
 <0889767f-d187-0cb4-895e-c149517b6636@linaro.org>
In-Reply-To: <0889767f-d187-0cb4-895e-c149517b6636@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 21:06:09 +0100
Message-ID: <CAJZ5v0h=UCOyJ88UgEdqch4NZK+DaT8jWnDaguQGNx-KOMhPPA@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] thermal: Don't use 'device' internal thermal
 zone structure field
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Balsam CHIHI <bchihi@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 9:00 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/02/2023 20:43, Rafael J. Wysocki wrote:
> > On Tue, Feb 21, 2023 at 7:07 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Some drivers are directly using the thermal zone's 'device' structure
> >> field.
> >>
> >> Use the driver device pointer instead of the thermal zone device when
> >> it is available.
> >>
> >> Remove the traces when they are duplicate with the traces in the core
> >> code.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS
> >> ---
>
> [ ... ]
>
> >>          thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
> >>
> >> -       dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
> >> +       dev_dbg(data->bgp->dev, "updated thermal zone %s\n",
> >>                  data->ti_thermal->type);
> >
> > The code before the change is more consistent, because it refers to
> > the same object in both instances.
> >
> > It looks like a type field accessor is needed, eg. thermal_zone_device_type()?
> >
> > Or move the debug message to thermal_zone_device_update()?
>
> Actually it is done on purpose because the patch 9 replaces the accesses
> to 'type' by 'id', the thermal_zone_device_type() accessor won't be needed.

Cool.

However, this is a change in behavior (albeit small) which doesn't
appear to be necessary.

What would be wrong with having a tz->type accessor too?
