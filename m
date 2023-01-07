Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99049660D2A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjAGJQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAGJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:16:48 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0EE8409A
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:16:47 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id bp26so2206549ilb.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RW3tgbxJ4a2R6Lr3hH31QiBztWxbB+zFWSFDhcB5PzA=;
        b=KKfAvH6c6JEgsJOT6JY3oShOZFTY6igTfAUjUAfOvO3ZTBJILFDvW/q3p4JG0BSbDr
         K+YbSwq/zOnsJrBIbou5SGfbimt6dioyluqbq/pPcOoA+YAVcadHQdaZXpG9VwkfjrXq
         p0GnhAoCy+/LFON2ea16s1HP+P1sjTyceRnXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RW3tgbxJ4a2R6Lr3hH31QiBztWxbB+zFWSFDhcB5PzA=;
        b=u2wQjykZTLPX3e5MaF641Db125kJf1S50zvgPzmb5XqtzrTSJxG3uI6WbQWu0AhufP
         j9yPOT8dgo/caauIGtmPkCmKjti//B/HD1iBvnqlHiGa/yysQF3xa45uelgBNzVYOPzf
         +xaCW6oreIk494xMQhSbED2WSvdz3/muTwqQbmxIp0twu+vAPUYR+jX0iy9s7vgaqZeE
         wQxjxs12X5oOuqw8OEHBa+QoGTKaSqLcq7JV+a6j5M9badIsINIHfcN/oygQ6IWDnraB
         Y4YFSWl+6FlzEDzsDHfG1+hHMm7Q8RaXqt6KRTZJ4W6UhxR2fdiNS5dTDvJTycye9btw
         JR4Q==
X-Gm-Message-State: AFqh2koDFOTo00AZnqQwJ/dxI5DPvtYYOOxZEqTglHAtP3VHQ4KzBSRa
        kYNcZnESv+/NCewvuJLepbm112F/09cSbkQjOTMkFg==
X-Google-Smtp-Source: AMrXdXtBMzB4lO1Yn6qSZ1CSDd89k7nZTSy0I48BAfgZ30l48dPrz+xuh/08ZScwMOp5MGwUZ1rNJl0wH1TYIiXt25E=
X-Received: by 2002:a05:6e02:2141:b0:30d:8aeb:9b11 with SMTP id
 d1-20020a056e02214100b0030d8aeb9b11mr588524ilv.293.1673083006788; Sat, 07 Jan
 2023 01:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20230105132457.4125372-1-treapking@chromium.org>
 <20230105132457.4125372-4-treapking@chromium.org> <Y7bvnOLcuJvvp/v1@smile.fi.intel.com>
In-Reply-To: <Y7bvnOLcuJvvp/v1@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Sat, 7 Jan 2023 17:16:35 +0800
Message-ID: <CAEXTbpdg9C5pFVXo7fKSc_vWAczv_OthjbRA7DZVnENuNfwQfA@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] drm/display: Add Type-C switch helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
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

Hi Andy,

Thanks for the review.

On Thu, Jan 5, 2023 at 11:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 05, 2023 at 09:24:51PM +0800, Pin-yen Lin wrote:
> > Add helpers to register and unregister Type-C "switches" for bridges
> > capable of switching their output between two downstream devices.
> >
> > The helper registers USB Type-C mode switches when the "mode-switch"
> > and the "data-lanes" properties are available in Device Tree.
>
> ...
>
> > +     port_data->typec_mux = typec_mux_register(dev, &mux_desc);
> > +     if (IS_ERR(port_data->typec_mux)) {
> > +             ret = PTR_ERR(port_data->typec_mux);
> > +             dev_err(dev, "Mode switch register for port %d failed: %d\n",
> > +                     port_num, ret);
> > +     }
> > +
> > +     return ret;
>
> ...
>
> > +     struct device_node *sw;
>
> > +     int ret = 0;
>
> It's easy to break things if you squeeze more code in the future in this
> function, so I recommend to split assignment to be closer to its first user
> (see below).
>
> > +     for_each_child_of_node(port, sw) {
> > +             if (of_property_read_bool(sw, "mode-switch"))
> > +                     switch_desc->num_typec_switches++;
> > +     }
> > +
> > +     if (!switch_desc->num_typec_switches) {
> > +             dev_warn(dev, "No Type-C switches node found\n");
>
> > +             return ret;
>
> return 0;

Thanks for the suggestion. I'll update this in v8.
>
> > +     }
> > +
> > +     switch_desc->typec_ports = devm_kcalloc(
> > +             dev, switch_desc->num_typec_switches,
> > +             sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);
> > +
> > +     if (!switch_desc->typec_ports)
> > +             return -ENOMEM;
>
> > +     /* Register switches for each connector. */
> > +     for_each_child_of_node(port, sw) {
> > +             if (!of_property_read_bool(sw, "mode-switch"))
> > +                     continue;
> > +             ret = drm_dp_register_mode_switch(dev, sw, switch_desc, data, mux_set);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to register mode switch: %d\n", ret);
> > +                     of_node_put(sw);
> > +                     break;
> > +             }
> > +     }
>
> > +     if (ret)
> > +             drm_dp_unregister_typec_switches(switch_desc);
> > +
> > +     return ret;
>
> Why not adding a goto label?

I didn't know that goto label is preferred even when there are no
duplicated code blocks in the function.

I'll update this accordingly in v8.
>
>                 ret = drm_dp_register_mode_switch(dev, sw, switch_desc, data, mux_set);
>                 if (ret)
>                         goto err_unregister_typec_switches;
>
>         return 0;
>
> err_unregister_typec_switches:
>         of_node_put(sw);
>         drm_dp_unregister_typec_switches(switch_desc);
>         dev_err(dev, "Failed to register mode switch: %d\n", ret);
>         return ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Best regards,
Pin-yen
