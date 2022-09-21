Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268065E561E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiIUWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIUWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:10:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EBA74D5;
        Wed, 21 Sep 2022 15:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A1BCCE1F99;
        Wed, 21 Sep 2022 22:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC275C433D7;
        Wed, 21 Sep 2022 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663798252;
        bh=+2dcsh6U86YXPRcXsm713bvwRn2unPZV3ef6JCbwu0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbtASwkEVz8s3MYG70czCb4Q3OKyfSy87gAZmcq2dlNyAK84ieWrqX6NJqVn+Dzh1
         DPuoaQSgZEsr0WOBgW408vXNK/wc+xIzKj9j+Pdu2vWHns8YJIsQssP84QSahCOf1d
         KgKTvVhKjX++Nn1N+IpAU47RAyrkkdpT+hHMP5UT6Y0paRILAbEZPZ168gf9NpUkj3
         LPWdTfFIn1wiUpSjkWvsRE4aDr6eif/nssqs0dKwkva7X2Xg54sQ++iOb3NnN7Py9P
         16jFywBDSrfcO3aZ30yNcUYB8U6qDGAOInAQy3s7w2DtXliX8TMmRlgF5ikrXGkaCT
         rT1QBjs0QGtfg==
Date:   Wed, 21 Sep 2022 17:10:49 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lee Jones <lee@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] power: supply: Add Lenovo Yoga C630 EC driver
Message-ID: <20220921221049.7gsnalyyh33a2fji@builder.lan>
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
 <20220810030500.2793882-3-bjorn.andersson@linaro.org>
 <20220913104545.2u6mcyy3bg4dp6ly@mercury.elektranox.org>
 <20220915212545.q6vxcnrffwr3buq2@builder.lan>
 <CAA8EJpoNyc1_eM7mi3D3s4voqLZFHvJtiBd_TOB4dmxcSpwdWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoNyc1_eM7mi3D3s4voqLZFHvJtiBd_TOB4dmxcSpwdWg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:53:42AM +0300, Dmitry Baryshkov wrote:
> On Fri, 16 Sept 2022 at 00:25, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Tue, Sep 13, 2022 at 12:45:45PM +0200, Sebastian Reichel wrote:
> > > Hi,
> > >
> > > [+Cc Lee Jones, DRI devel]
> > >
> > > On Tue, Aug 09, 2022 at 10:05:00PM -0500, Bjorn Andersson wrote:
> > > > The Qualcomm Snapdragon-based Lenovo Yoga C630 has some sort of EC
> > > > providing AC-adapter and battery status, as well as USB Type-C altmode
> > > > notifications for Displayport operation.
> > > >
> > > > The Yoga C630 ships with Windows, where these operations primarily are
> > > > implemented in ACPI, but due to various issues with the hardware
> > > > representation therein it's not possible to run Linux on this
> > > > information. As such this is a best-effort re-implementation of these
> > > > operations, based on the register map expressed in ACPI and a fair
> > > > amount of trial and error.
> > > >
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > > [...]
> > > > +   val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
> > > > +   if (val < 0)
> > > > +           goto out_unlock;
> > > > +   ec->unit_ma = val & LENOVO_EC_BAT_ATTR_UNIT_IS_MA;
> > > > +   if (!ec->unit_ma)
> > > > +           ec->scale = 1000;
> > > > +   else
> > > > +           ec->scale = 1;
> > >
> > > Since I'm not sure how much of information was gained by reverse
> > > engineering: Is this really milliamps vs microamps and not milliamps
> > > vs milliwatt? SBS batteries usually report either mA or mW.
> > >
> >
> > Unfortunately I don't know the answer to this.
> >
> > > > [...]
> > > > +   case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> > > > +           val->strval = "05072018";
> > > > +           break;
> > >
> > > why is this hardcoded? :)
> > >
> >
> > I don't know, but as Daniel suggests, it would make sense to just drop
> > it.
> >
> > > > [...]
> > > > +   device_for_each_child_node(dev, fwnode) {
> > > > +           ret = fwnode_property_read_u32(fwnode, "reg", &port);
> > > > +           if (ret < 0)
> > > > +                   continue;
> > > > +
> > > > +           /* Got multiple ports, but altmode is only possible on port 1 */
> > > > +           if (port != 1)
> > > > +                   continue;
> > > > +
> > > > +           ec->bridge.funcs = &yoga_c630_ec_bridge_funcs;
> > > > +           ec->bridge.of_node = to_of_node(fwnode);
> > > > +           ec->bridge.ops = DRM_BRIDGE_OP_HPD;
> > > > +           ec->bridge.type = DRM_MODE_CONNECTOR_USB;
> > > > +
> > > > +           ret = devm_drm_bridge_add(dev, &ec->bridge);
> > > > +           if (ret) {
> > > > +                   dev_err(dev, "failed to register drm bridge\n");
> > > > +                   fwnode_handle_put(fwnode);
> > > > +                   return ret;
> > > > +           }
> > >
> > > I wonder if DRM people want to see this in drivers/gpu/drm/bridge.
> > > Maybe it's better to make this a MFD driver?
> > >
> >
> > I did consider it, but it adds a whole bunch of boiler plate code
> > without a lot of benefit.
> >
> > There are a few other cases where I think it would make sense to have
> > drm bridges outside of drivers/gpu/drm, such as
> > drivers/usb/typec/altmodes/ and drivers/platform/chrome/...
> 
> What about a solution which might sound simpler than MFD: from your
> driver's probe() register a platform device which represents a drm
> bridge. Add drm_bridge driver for it into drivers/gpu/drm/bridges/.
> 

That is indeed simpler

But then rather than just calling drm_bridge_hpd_notify(status) we need
a new custom interface for this driver to call the other drive when
status changes and we waste 840 bytes just to track another struct
platform_device.

Perhaps that could be made generic, so we'd have "proxy_drm_bridge"
driver for drivers who implements a HPD drm_bridge but don't want to
implement that outside drivers/gpu/drm.

But this is just based on the assumption that the "DRM people" require
drm_bridges to only live in drivers/gpu/drm/. It's all one kernel and
the API is well defined, so I don't think there's a concrete problem to
solve.

Regards,
Bjorn
