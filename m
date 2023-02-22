Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1369EE22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBVFFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBVFFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:05:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0A35260
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:05:25 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b16so2167878iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fnu1EJD881ilgzbXP/u2M6qiohAhxhnaJqCCnJN+Tk8=;
        b=FubYbTKjUQHr3cEQiX3cMJOQw4FfCE/OMOouqh/l8wKE33FVwKwsXJcZPCVlJOgruk
         TwqXvfjx8dAxXtopRpr/7I3tGJw6wGnLplPO44Jf7qPfUZiBkStTGzavNICWu6K4/ijQ
         t56/tUtwbEDOBpuFgeHcQRqgq9PseVi3JLl2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fnu1EJD881ilgzbXP/u2M6qiohAhxhnaJqCCnJN+Tk8=;
        b=CF9YzO2g9WoS2u4g5EJOuv5/+2iB9nxKpvMUsbWkpD6+O3iEbcFdI3BKndIMBCgPSS
         Jq9uuq26vZKKVpWR2A7Ekh3tCdoAoYrhpOnURTFIXenjh2c7G4grZ2/VFVaS8YUKcoiB
         dunfuYy9gO7MMwZKahmUkzl+5Qa/b2mMaAhIB/+mXT106C75SSqPb26hQpFoOYRqUcUN
         ZheIL4eaBnWD1KTy7VhqSUwZR6uG05Y7wWZjqOCXyd/0nYUkbY8+iXn3+46/9qd4Gul4
         u+VmKjPtTJrhBRdhB93XWJqddJxQfX8JQPeHGSK7M/l44Le/r+OFxbimVCPrP1jOLdMn
         T1YA==
X-Gm-Message-State: AO0yUKV95x2w2bMU3+ol48TPYB06mhrLB4Vk+65siIsmc4aEXwVEYnSt
        fOHI1RliQPlXtHRm0yH13acms3YYithsItopAxPrQarFGAaCHQ==
X-Google-Smtp-Source: AK7set9WiTsncAk01hPHPcRR1sXgR4N/+7kuisg+5cf5ZRp0qNCei8CeQdAbEZCvfHwnyW5W1nH1RQwFgy87puMdlp0=
X-Received: by 2002:a5d:80da:0:b0:71a:5a1f:544c with SMTP id
 h26-20020a5d80da000000b0071a5a1f544cmr4719763ior.5.1677042324712; Tue, 21 Feb
 2023 21:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20230221095054.1868277-1-treapking@chromium.org>
 <20230221095054.1868277-8-treapking@chromium.org> <Y/SstDfugez4/Qx4@smile.fi.intel.com>
In-Reply-To: <Y/SstDfugez4/Qx4@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 22 Feb 2023 13:05:13 +0800
Message-ID: <CAEXTbpeObyd1uKd3Qp9c3A9z9BX8R_SiH7okVrgmV+fMfaRaYQ@mail.gmail.com>
Subject: Re: [PATCH v12 07/10] drm/bridge: anx7625: Register Type C mode switches
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
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
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

Hi Andy,

Thanks for the review.

On Tue, Feb 21, 2023 at 7:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 21, 2023 at 05:50:51PM +0800, Pin-yen Lin wrote:
> > Register USB Type-C mode switches when the "mode-switch" property and
> > relevant ports are available in Device Tree. Configure the crosspoint
> > switch based on the entered alternate mode for a specific Type-C
> > connector.
> >
> > Crosspoint switch can also be used for switching the output signal for
> > different orientations of a single USB Type-C connector, but the
> > orientation switch is not implemented yet. A TODO is added for this.
>
> ...
>
> > +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> > +{
> > +     int i;
>
> unsigned?
>
> + Blank line.
>
> > +     /* Check if both ports available and do nothing to retain the current one */
> > +     if (ctx->port_data[0].dp_connected && ctx->port_data[1].dp_connected)
> > +             return;
> > +
> > +     for (i = 0; i < 2; i++) {
> > +             if (ctx->port_data[i].dp_connected)
> > +                     anx7625_set_crosspoint_switch(ctx,
> > +                                                   ctx->port_data[i].orientation);
> > +     }
> > +}
>
> ...
>
> > +     ctx->port_data[port->port_num].dp_connected =
> > +             state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
>
> I would move the first parameter of && to the separate line for slightly better
> readability.
>
> > +             state->alt->mode == USB_TYPEC_DP_MODE;
>
> ...
>
> > +     for (i = 0; i < switch_desc->num_typec_switches; i++) {
> > +             struct drm_dp_typec_port_data *port = &switch_desc->typec_ports[i];
> > +             struct fwnode_handle *fwnode = port->fwnode;
> > +
> > +             num_lanes = fwnode_property_count_u32(fwnode, "data-lanes");
>
> > +
>
> Redundant blank line.
>
> > +             if (num_lanes < 0) {
> > +                     dev_err(dev,
> > +                             "Error on getting data lanes count from %pfwP: %d\n",
> > +                             fwnode, num_lanes);
>
> > +                     ret = num_lanes;
>
> Can be written differently:
>
> > +                     goto unregister_mux;
> > +             }
>
>                 ret = ...
>                 if (ret < 0) {
>                         ...
>                 }
>                 num_lanes = ret;
>
>
> What if it's 0?

The binding does not allow that, so I don't think we should check it here.

I'll address other comments in the next version.

Regards,
Pin-yen
>
> > +             ret = fwnode_property_read_u32_array(fwnode, "data-lanes",
> > +                                                  dp_lanes, num_lanes);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "Failed to read the data-lanes variable: %d\n",
> > +                             ret);
> > +                     goto unregister_mux;
> > +             }
> > +
> > +             ctx->port_data[i].orientation = (dp_lanes[0] / 2 == 0) ?
> > +                     TYPEC_ORIENTATION_REVERSE : TYPEC_ORIENTATION_NORMAL;
> > +             ctx->port_data[i].dp_connected = false;
> > +     }
> > +     complete_all(&ctx->mux_register);
> > +
> > +     return 0;
> > +
> > +unregister_mux:
> > +     complete_all(&ctx->mux_register);
> > +     anx7625_unregister_typec_switches(ctx);
> > +     return ret;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
