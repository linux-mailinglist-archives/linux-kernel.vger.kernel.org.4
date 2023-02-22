Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95569F0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjBVIx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjBVIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:53:55 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51D51C590
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:53:53 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id bf15so3290355iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhYDKiCMl5Zg3kFJ82aJeKZFheHJkDNcW1JK/FBeLIU=;
        b=S46TMnd79hmJMjHu6YHoyiQ+If7OYb6jqppE2/V2/h32wVWi6nWdac/dC+ud2JAX82
         ngXeec568GkKEt7Pym7Jw3Ur53NqHZxEiqsqSgImaIuxbIIedIDCislExEzkuJ8FGR8w
         BLGw0ITffNiuHi9XD817RG27FpP7nMDzxmEb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhYDKiCMl5Zg3kFJ82aJeKZFheHJkDNcW1JK/FBeLIU=;
        b=XJZGN1KRNT4OW9Eyf7ipNbMoR2CHAYYX/tCsArGp4VHWl3HecM/n/BmjFDOXjQieTd
         83BqRL04ZqOXCSwsm3nAg5ujknf1RMHhbgOL6iMEIQ2r5P4m0wF+FIbc7w7seYeA7a4Q
         3vd70au1lWm0yfOCOQLTbCRp5drGDGfYmuAUraJerzwib6IDxDur4yZ28zmQyPmEcs39
         Lq7my1ElUd7T/psFv4r2ewCVU2xEhi+sgZgS3kQyQS6M/SNt+LbSxd8XIkPE+/IgyFtc
         ih5UkPB2vakwpy/Lm69GYIZBP3Sj3P96/w7XqYrHKm+CLmL7UUNFFXtPgDT5lcKj1hy9
         QTKg==
X-Gm-Message-State: AO0yUKVrSpLdH0M0KNJ0U8t+lkicc6xKfWE6ujZIJ1urCfAhbHe0/nPj
        8OLDzdS7LifTSDQ/B+Zad+J/ZCFVnp5yZgmSIzKE0g==
X-Google-Smtp-Source: AK7set95UIcEr36Pn+YUoHAt17RL/o3ns/Gdh3WG/t/+JidyKPagtbyfa6npb7tZMS4Qzo8ChxlIppfGbWczTO72XBY=
X-Received: by 2002:a5d:80da:0:b0:71a:5a1f:544c with SMTP id
 h26-20020a5d80da000000b0071a5a1f544cmr4867722ior.5.1677056033042; Wed, 22 Feb
 2023 00:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20230221095054.1868277-1-treapking@chromium.org>
 <20230221095054.1868277-4-treapking@chromium.org> <Y/SvhxgjTM2cYZa+@smile.fi.intel.com>
In-Reply-To: <Y/SvhxgjTM2cYZa+@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 22 Feb 2023 16:53:41 +0800
Message-ID: <CAEXTbpcOA06Cf-niurjM4_3Rx6xa9Pi+fuJHUQCKmwaJL2ibmA@mail.gmail.com>
Subject: Re: [PATCH v12 03/10] drm/display: Add Type-C switch helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Marek Vasut <marex@denx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        Allen Chen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>
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

On Tue, Feb 21, 2023 at 7:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 21, 2023 at 05:50:47PM +0800, Pin-yen Lin wrote:
> > Add helpers to register and unregister Type-C "switches" for bridges
> > capable of switching their output between two downstream devices.
> >
> > The helper registers USB Type-C mode switches when the "mode-switch"
> > and the "reg" properties are available in Device Tree.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ...
>
> > +     fwnode_for_each_typec_mode_switch(port, sw)
> > +             switch_desc->num_typec_switches++;
> > +
> > +     if (!switch_desc->num_typec_switches) {
> > +             dev_dbg(dev, "No Type-C switches node found\n");
> > +             return 0;
> > +     }
>
> What about
>
> static inline unsigned int typec_mode_switch_node_count(... *port)
> {
>         ... *sw;
>         unsigned int count = 0;
>
>         for_each_typec_mode_switch_node(port, sw)
>                 count++;
>
>         return count;
> }
>
>
> And then it seems something like
>
>         unsigned int count;
>
>         count = typec_mode_switch_node_count(port);
>         if (!count) {
>                 ...
>         }
>
>         _switches = count;
>
> ...
>
> > +     switch_desc->typec_ports = devm_kcalloc(
> > +             dev, switch_desc->num_typec_switches,
>
> Strange indentation.
>
> > +             sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);
>
> > +
>
> Redundant blank line.
>
> > +     if (!switch_desc->typec_ports)
> > +             return -ENOMEM;
>
> ...
>
> > +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
> > +{
> > +     int i;
>
> unsigned?
>
> > +     for (i = 0; i < switch_desc->num_typec_switches; i++)
> > +             typec_mux_unregister(switch_desc->typec_ports[i].typec_mux);
> > +}
>
> ...
>
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/usb/typec_mux.h>
>
> I don't see users of this.
> But a few forward declarations are missing.

I can put a `struct typec_mux_dev;` here, but there is also a usage of
typec_mux_set_fn_t.

Should I add the typedef into this header file as well?

Regards,
Pin-yen
>
> >  #include <drm/display/drm_dp.h>
> >  #include <drm/drm_connector.h>
>
> ...
>
> > +#define fwnode_for_each_typec_mode_switch(port, sw)  \
> > +     fwnode_for_each_child_node((port), (sw))        \
> > +             for_each_if(fwnode_property_present((sw), "mode-switch"))
>
> Please don't use fwnode namespace (see above), something like
>
> #define for_each_typec_mode_switch_node(port, sw)       \
>         ...
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
