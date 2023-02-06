Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3533C68B780
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBFIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBFIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:40:24 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1915CA8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:40:20 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id e9so11874828vsj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bxGBUMpZ6MlCuOf4ZGY5be1Z/6HawqxmEV6A7eKd+x8=;
        b=eb4aSDL3eeoPKmPKagfqCIsDqkldstB0QqhkBdstr/XyIHyHdDPeWkcERZl4gZP4wW
         aYh0I54j0tapjkNd4VT8+FGZJFNpZ0ySFiXDxg9vYibrt5bZt21LE1q6a++C7CFmbdRc
         AtL+ZeigRmZ3hIG2gZ3K2kRFcgoJVA130tk68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxGBUMpZ6MlCuOf4ZGY5be1Z/6HawqxmEV6A7eKd+x8=;
        b=YQUVIR50sFJy+tmN0Z/vAlFZ+MRbF2M14qLXdCBj8+LsmHZwfmIPrT+2iH0/nYZY7n
         kKofLlyUdig0KZ/y4yP0VVwbnAy0+A5RroZjToOOd0LO31PGp+oXTdM8DbtmRQVJFgsM
         NvKRHw1zMN8gXIFk1NaHy7ZLRdp4rTNrmId+DRQFN2TMKSYaBvGFxHUxsw9nP+IO+prt
         RTntn4glrWssAjlkaGOIzTtA/fdYvx/pA4YkRaZfbKCoT/bbcVfEsM3Lk8z2Z4dkGaot
         bjeOfLiyOXEpwSdMF2tvT75H0GXyFi1AJEqxjrLIZaZKkrd7tG2VccpFwU634KWFxDuq
         jbhg==
X-Gm-Message-State: AO0yUKUqaKYPuVC87wKlrA3sW1YOyc+COBdzLM6dKkVaftuIasYfc2Jx
        S20RYelf4mkGI54aItPrlrX8swhXHpREPMKRyxuUfw==
X-Google-Smtp-Source: AK7set/Nc+tRekf0h+tZTWStnrZoa/GmrslGQquHlfY8WRs6V9iTEWlJuxYA3EIydNHfm7RtpJMuutQEZD210Ih9vcw=
X-Received: by 2002:a05:6102:322a:b0:3fe:ae88:d22 with SMTP id
 x10-20020a056102322a00b003feae880d22mr2856750vsf.65.1675672819238; Mon, 06
 Feb 2023 00:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org>
In-Reply-To: <20230204133040.1236799-1-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 6 Feb 2023 16:40:07 +0800
Message-ID: <CAGXv+5FW8qYnBYJsf+gLEaEGnwunPFdjjVF9YUqDqCVAjXWuKA@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] Register Type-C mode-switch in DP bridge endpoints
To:     Pin-yen Lin <treapking@chromium.org>
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
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Jani Nikula <jani.nikula@intel.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Stephen Boyd <swboyd@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023 at 9:30 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
>
> This series introduces bindings for anx7625/it6505 to register Type-C
> mode-switch in their output endpoints, and use data-lanes property to
> describe the pin connections.
>
> This series is not directly related to the built-in mux in anx7625,
> which automatically switches between the two orientations of a single
> Type-C connector. This series adds support of registering mode switches
> for two downstream devices, while we use orientation switches for two
> orientations of the Type-C connector.
>
> The first two patch modifies fwnode_graph_devcon_matches and
> cros_typec_init_ports to enable the registration of the switches.
>
> Patch 4~6 introduce the bindings for anx7625 and the corresponding driver
> modifications.
>
> Patch 7~9 add similar bindings and driver changes for it6505.
>
> v10: https://lore.kernel.org/all/20230112042104.4107253-1-treapking@chromium.org/
> v9: https://lore.kernel.org/all/20230109084101.265664-1-treapking@chromium.org/
> v8: https://lore.kernel.org/all/20230107102231.23682-1-treapking@chromium.org/
> v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
> v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
> v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/
>
> Changes in v11:
> - Added missing fwnode_handle_put in drivers/base/property.c
> - Collected Acked-by tag
> - Use fwnode helpers instead of DT
> - Moved the helpers to a new file
> - Use "reg" instead of "data-lanes" to determine the port number
> - Updated the description of the endpoints in the bindings
> - Referenced video-interfaces.yaml instead for the endpoints binding
> - Removed duplicated definitions from inherited schema
> - Moved the "data-lanes" parsing logics to bridge drivers
> - Removed Kconfig dependencies for the bridge drivers
> - Updated the usage of the private bridge driver data
> - Added a clarification on the anx7625 built-in mux in the cover letter
>
> Changes in v10:
> - Collected Reviewed-by and Tested-by tags
> - Replaced "void *" with "typec_mux_set_fn_t" for mux_set callbacks
> - Print out the node name when errors on parsing DT
> - Use dev_dbg instead of dev_warn when no Type-C switch nodes available
> - Made the return path of drm_dp_register_mode_switch clearer
> - Added a TODO for implementing orientation switch for anx7625
> - Updated the commit message for the absence of orientation switch
> - Fixed typo in the commit message
>
> Changes in v9:
> - Collected Reviewed-by tag
> - Fixed subject prefix again
> - Changed the naming of the example node for it6505
>
> Changes in v8:
> - Fixed the build issue when CONFIG_TYPEC=m
> - Fixed some style issues
> - Fixed the subject prefixes for the bindings patch
> - Fixed the bindings for data-lanes properties
>
> Changes in v7:
> - Fix the long comment lines
> - Extracted the common codes to a helper function
> - Fixed style issues in anx7625 driver
> - Removed DT property validation in anx7625 driver.
> - Fixed style issues in it6505 driver
> - Removed the redundant sleep in it6505 driver
> - Removed DT property validation in it6505 driver
> - Rebased to drm-misc-next
> - Fixed indentations in bindings patches
> - Added a new patch to fix indentations in Kconfig
>
> Changes in v6:
> - Changed it6505_typec_mux_set callback function to accommodate with
>   the latest drm-misc patches
> - Changed the driver implementation to accommodate with the new binding
> - Dropped typec-switch binding and use endpoints and data-lanes properties
>   to describe the pin connections
> - Added new patches (patch 1,2,4) to fix probing issues
> - Changed the bindings of it6505/anx7625 and modified the drivers
>   accordingly
> - Merged it6505/anx7625 driver changes into a single patch
>
> Pin-yen Lin (7):
>   drm/display: Add Type-C switch helpers
>   dt-bindings: display: bridge: anx7625: Add mode-switch support
>   drm/bridge: anx7625: Check for Type-C during panel registration
>   drm/bridge: anx7625: Register Type C mode switches
>   dt-bindings: display: bridge: it6505: Add mode-switch support
>   drm/bridge: it6505: Fix Kconfig indentation
>   drm/bridge: it6505: Register Type C mode switches
>
> Prashant Malani (2):
>   device property: Add remote endpoint to devcon matcher
>   platform/chrome: cros_ec_typec: Purge blocking switch devlinks

Whole series is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8192-based Hayato for anx7625 and not-yet-upstreamed MT8186 device
for it6505.
