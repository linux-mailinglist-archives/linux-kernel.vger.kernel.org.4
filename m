Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6DF666AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 06:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjALFIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 00:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbjALFIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:08:13 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28244E419
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:08:05 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e129so8627344iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh12tmNLmhb1OnKgUYkRMPDW2mygi0EIvrRRXI50tXs=;
        b=fb3lIBVeWwwRextTHiK1gp7PtClYIqS2sXPPiOrUElG4bRbSNCRcHQmfkrqhZIHEXG
         13IgfR12eAA0QDzrhIWwVu+Dhx77yNRoxZ++RRtcxJrhgb6UEoHHWl2ndcpeEFl967eX
         y+A9IfXHbGDDmZ0BCCvO7C1VQedUfnIvSMUvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh12tmNLmhb1OnKgUYkRMPDW2mygi0EIvrRRXI50tXs=;
        b=ErxG0QVZxDZYZNmQEArrPqJo9UrPWvMKJnm+96Ju68aMa+uc/sw/LwzoqnaOlwc7tu
         4Scl9j8p5NcSHDAExO/miqTNDmFobEx4BK/vmsmXAzgiA50n2+1DqUU4OmIrG/cyclH7
         ZGIGiIGR/xoTNPZnKQJWG93K4TvH9GEAJHOh736rVdF26RYBgmC7RJjFY/3ULhFwIjSm
         Zi4DRjvJhzjzNEWcC3FNeISEnjv+r2gUN+mthBt95EKVEx41MFu7N8g45R6ZCF76XCFv
         MGFghJUbyCwI50c4hLX5u4kLELv3Y6qKHk/PVR3iSzmnDTmXnu2f8bfmITYD1qcQVAcT
         Ahew==
X-Gm-Message-State: AFqh2kpi6Dz45JC0/azW8e0N8AnUoA8n+w0bOzvamfyKSkTfXt8Yf04K
        1mihf64+nQ0oIXs9mVacRB8XsESfJDXuujwm+HM0pQ==
X-Google-Smtp-Source: AMrXdXvtSakCSG+vvcHya43d56b1WXoGfexMsa7UOT6VgRISZq9Vz8XlFbhcAobzfgZRl06IteKU/yZJHASpwe0/Zhc=
X-Received: by 2002:a6b:7a0a:0:b0:6e9:b3db:b5ce with SMTP id
 h10-20020a6b7a0a000000b006e9b3dbb5cemr6904887iom.179.1673500085158; Wed, 11
 Jan 2023 21:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org> <61ba2880-6784-1014-a7a2-a1eecc4e810e@linaro.org>
In-Reply-To: <61ba2880-6784-1014-a7a2-a1eecc4e810e@linaro.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 12 Jan 2023 13:07:54 +0800
Message-ID: <CAEXTbpeFJ-DuxuDk=QbC-hh+KayNY8rpEi7Q6zPge6PRhxkO0w@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Register Type-C mode-switch in DP bridge endpoints
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>
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

Hi Dmitry,

On Thu, Jan 12, 2023 at 12:34 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 12/01/2023 06:20, Pin-yen Lin wrote:
> >
> > This series introduces bindings for anx7625/it6505 to register Type-C
> > mode-switch in their output endpoints, and use data-lanes property to
> > describe the pin connections.
>
> Please cc everybody on all patches. Having received just a single patch
> made me spend time on having to look them up on lore.

Sorry about that. I'll prevent that in the future series.

>
> >
> > The first two patch modifies fwnode_graph_devcon_matches and
> > cros_typec_init_ports to enable the registration of the switches.
> >
> > Patch 4~6 introduce the bindings for anx7625 and the corresponding driver
> > modifications.
> >
> > Patch 7~9 add similar bindings and driver changes for it6505.
> >
> > v9: https://lore.kernel.org/all/20230109084101.265664-1-treapking@chromium.org/
> > v8: https://lore.kernel.org/all/20230107102231.23682-1-treapking@chromium.org/
> > v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
> > v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
> > v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/
> >
> > Changes in v10:
> > - Collected Reviewed-by and Tested-by tags
> > - Replaced "void *" with "typec_mux_set_fn_t" for mux_set callbacks
> > - Print out the node name when errors on parsing DT
> > - Use dev_dbg instead of dev_warn when no Type-C switch nodes available
> > - Made the return path of drm_dp_register_mode_switch clearer
> > - Added a TODO for implementing orientation switch for anx7625
> > - Updated the commit message for the absence of orientation switch
> > - Fixed typo in the commit message
> >
> > Changes in v9:
> > - Collected Reviewed-by tag
> > - Fixed subject prefix again
> > - Changed the naming of the example node for it6505
> >
> > Changes in v8:
> > - Fixed the build issue when CONFIG_TYPEC=m
> > - Fixed some style issues
> > - Fixed the subject prefixes for the bindings patch
> > - Fixed the bindings for data-lanes properties
> >
> > Changes in v7:
> > - Fix the long comment lines
> > - Extracted the common codes to a helper function
> > - Fixed style issues in anx7625 driver
> > - Removed DT property validation in anx7625 driver.
> > - Fixed style issues in it6505 driver
> > - Removed the redundant sleep in it6505 driver
> > - Removed DT property validation in it6505 driver
> > - Rebased to drm-misc-next
> > - Fixed indentations in bindings patches
> > - Added a new patch to fix indentations in Kconfig
> >
> > Changes in v6:
> > - Changed it6505_typec_mux_set callback function to accommodate with
> >    the latest drm-misc patches
> > - Changed the driver implementation to accommodate with the new binding
> > - Dropped typec-switch binding and use endpoints and data-lanes properties
> >    to describe the pin connections
> > - Added new patches (patch 1,2,4) to fix probing issues
> > - Changed the bindings of it6505/anx7625 and modified the drivers
> >    accordingly
> > - Merged it6505/anx7625 driver changes into a single patch
> >
> > Pin-yen Lin (7):
> >    drm/display: Add Type-C switch helpers
> >    dt-bindings: display: bridge: anx7625: Add mode-switch support
> >    drm/bridge: anx7625: Check for Type-C during panel registration
> >    drm/bridge: anx7625: Register Type C mode switches
> >    dt-bindings: display: bridge: it6505: Add mode-switch support
> >    drm/bridge: it6505: Fix Kconfig indentation
> >    drm/bridge: it6505: Register Type C mode switches
> >
> > Prashant Malani (2):
> >    device property: Add remote endpoint to devcon matcher
> >    platform/chrome: cros_ec_typec: Purge blocking switch devlinks
> >
> >   .../display/bridge/analogix,anx7625.yaml      |  99 ++++++++++++-
> >   .../bindings/display/bridge/ite,it6505.yaml   |  93 ++++++++++--
> >   drivers/base/property.c                       |  15 ++
> >   drivers/gpu/drm/bridge/Kconfig                |  21 +--
> >   drivers/gpu/drm/bridge/analogix/Kconfig       |   1 +
> >   drivers/gpu/drm/bridge/analogix/anx7625.c     | 105 +++++++++++++-
> >   drivers/gpu/drm/bridge/analogix/anx7625.h     |  13 ++
> >   drivers/gpu/drm/bridge/ite-it6505.c           | 119 +++++++++++++++-
> >   drivers/gpu/drm/display/drm_dp_helper.c       | 134 ++++++++++++++++++
> >   drivers/platform/chrome/cros_ec_typec.c       |  10 ++
> >   include/drm/display/drm_dp_helper.h           |  17 +++
> >   11 files changed, 598 insertions(+), 29 deletions(-)
> >
>
> --
> With best wishes
> Dmitry
>

Thanks and regards,
Pin-yen
