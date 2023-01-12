Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6966872B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjALWol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjALWog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:44:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954E3DBC2;
        Thu, 12 Jan 2023 14:44:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B530DB82033;
        Thu, 12 Jan 2023 22:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C183C433A7;
        Thu, 12 Jan 2023 22:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673563472;
        bh=RZLYtFJIoNIntNiCGOCc4lXxK6kyJFOWbJdlQl+orIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Og3eCJpXAW9+ZU38sof7CYWlrMf7Rt6Bcb04DBOHbSKcTeD3ixNxj/ufyh/YOEKFA
         FZT9K/srjZ+rTDR6Ia7szASNz3c10bv+Ao/MvH/Oi57VWFx555XIIenukiESIzCw7m
         eqxlTlhfr689fZyep3R5ZqnHlepkB8Je0MT5dy4M5pglGR7u9D8eTNSqvnkTJwwBC/
         jH3EvLwBkaz9qKG/cF7IMZN7sDtNxEY0ar0nKookA4amAzPsXgfVRISaykLnx3Aw2p
         HmjR7bNa6AxvCQ7v0RltC3rlUH6USDdzSgNMug+vTNF9LzVx9t5jKkymxw/In/8TZU
         vGZp+ShjJNadg==
Received: by mail-ua1-f53.google.com with SMTP id z13so3821702uav.3;
        Thu, 12 Jan 2023 14:44:32 -0800 (PST)
X-Gm-Message-State: AFqh2kqEllK9gidQquhp5X/yTx+8t2hhEAS9uMrNAJ9vUlxrg7i5YB8/
        KrnQR3qh5yWtzzF3yznRIIH8zzOBpwcoFA8/Iw==
X-Google-Smtp-Source: AMrXdXtZFoVEyDLRv9F7lmdnJWvJEcg8OkSGQmcET+vTNr5A9PdUpV3f5sKnSRP8h0PLVSDCnsxex9XK6NUvoE/hp8Y=
X-Received: by 2002:ab0:76c1:0:b0:419:145a:dd46 with SMTP id
 w1-20020ab076c1000000b00419145add46mr8969043uaq.77.1673563471032; Thu, 12 Jan
 2023 14:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org>
In-Reply-To: <20230112042104.4107253-1-treapking@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Jan 2023 16:44:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+KGQH2qTpB6NmmOzid39-oKTzZZJNPF1ybKQu72LbJLw@mail.gmail.com>
Message-ID: <CAL_Jsq+KGQH2qTpB6NmmOzid39-oKTzZZJNPF1ybKQu72LbJLw@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Register Type-C mode-switch in DP bridge endpoints
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:21 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
>
> This series introduces bindings for anx7625/it6505 to register Type-C
> mode-switch in their output endpoints, and use data-lanes property to
> describe the pin connections.
>
> The first two patch modifies fwnode_graph_devcon_matches and
> cros_typec_init_ports to enable the registration of the switches.
>
> Patch 4~6 introduce the bindings for anx7625 and the corresponding driver
> modifications.
>
> Patch 7~9 add similar bindings and driver changes for it6505.
>
> v9: https://lore.kernel.org/all/20230109084101.265664-1-treapking@chromium.org/
> v8: https://lore.kernel.org/all/20230107102231.23682-1-treapking@chromium.org/
> v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
> v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
> v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/
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

4 versions in a week! Please slow down your pace. When you send a new
version, you move to the end of my review queue.

IIRC, these 2 chips are a bit different in what the mode switch or
muxing looks like. One had a built-in mux and the other doesn't? Do I
have to go research this again? No, you need to explain all this in
this series.

Rob
