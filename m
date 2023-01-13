Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2466902A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjAMIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbjAMIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:10:09 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648321A5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:09:22 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i70so967540ioa.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W0+4RXTlK0IqIB9mYO3YSmFVYM13UL+Gup7cLGu7Nzw=;
        b=Fmn00t90xJPmYNPJkrLBinV7c53WSSG1nRO2CEfpjlJfQU2BIZzTmdL1R0NOTFpb9Q
         eR4ku2xTE6T2EWT8UoP4xt9FpbjU/g5bDKOeEHDAIe56Fp+yotzNdcp0EKF8GTBsTCkt
         /hm6KiUd+IhQWCRDMH7pa5M0uSbadJuDDgiOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0+4RXTlK0IqIB9mYO3YSmFVYM13UL+Gup7cLGu7Nzw=;
        b=A7D0Uq0Tmsj50bVZNNwA3WRpxR5B3gVZPjQy2B4NP2tI0dSeN8syhxDvyfZhjK3CuP
         xzH6M9mFvz6HLKy4wUxygakG5Unt+OTtf3ZdrLNOpIpt93zNY7ag/c9KSE1dhTF8HfIk
         PaLUUKHmZ/AnxpF8hFCIGmyoBHNWJdYIhcy4lMwR5TkAvatw3EU+2R7BC1TEHSvdzldk
         62u1Xmly8eA0kieIjJoQat3sakWwnJ0xHZUJqMHZ86chwaqWkx/TvdJnm65DM8MnQ6JL
         SAHOKV16OZv+45XvXoTj4y0xWPidAzGhNFW0zKK4YN73OBv4/lhzHmpbl72p7hHg3xx8
         Myng==
X-Gm-Message-State: AFqh2kphywxOFRDNVoLKBOHnZEMh/+BVVfGK0YP9J7hblGGJnjfHwYk7
        AKZHGK+6qbWkQ4dat5kxHV0zz3gFi775IDCUc892Rw==
X-Google-Smtp-Source: AMrXdXso2wCwKI04DP0Jnwsw8O26tdW8R7cqrPXE3TghshxleDtAvafXMMve9LCUvK+myYIiIF3cGOotr7mepvIezU0=
X-Received: by 2002:a05:6638:1a7:b0:38a:3770:2fa2 with SMTP id
 b7-20020a05663801a700b0038a37702fa2mr7649958jaq.208.1673597361628; Fri, 13
 Jan 2023 00:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org> <CAL_Jsq+KGQH2qTpB6NmmOzid39-oKTzZZJNPF1ybKQu72LbJLw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+KGQH2qTpB6NmmOzid39-oKTzZZJNPF1ybKQu72LbJLw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 13 Jan 2023 16:09:10 +0800
Message-ID: <CAEXTbpfvGrBWjGV9VcRiuTHo4eVqrFM9qEpvq5CPXEWk=4z+dQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Register Type-C mode-switch in DP bridge endpoints
To:     Rob Herring <robh+dt@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jan 13, 2023 at 6:44 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Jan 11, 2023 at 10:21 PM Pin-yen Lin <treapking@chromium.org> wrote:
> >
> >
> > This series introduces bindings for anx7625/it6505 to register Type-C
> > mode-switch in their output endpoints, and use data-lanes property to
> > describe the pin connections.
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
>
> 4 versions in a week! Please slow down your pace. When you send a new
> version, you move to the end of my review queue.

I see. I'll keep this in mind in the future series.
>
> IIRC, these 2 chips are a bit different in what the mode switch or
> muxing looks like. One had a built-in mux and the other doesn't? Do I
> have to go research this again? No, you need to explain all this in
> this series.

Yes, anx7625 has a built-in mux while it6505 doesn't, but it's for
another use case.

IIUC the built-in mux in anx7625 is designed for automatically
switching between two orientations of a single Type-C connector, and
in that case we might need to register an orientation switch. But we
don't have hardware for this use case.

The use case this series aimed is having two downstreams for the
bridges, and registering two mode switches to switch between them. In
this use case, the built-in mux of anx7625 is not used and the
behavior of the switches is the same as it6505.

Explanations and TODOs have been added in the anx7625 driver change. I
can also mention this in the cover letter in the future series and
please let me know if anything is not clear for you.

>
> Rob

Thanks and regards,
Pin-yen
