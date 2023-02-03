Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C80688C14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBCAqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCAqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:46:07 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7F266010
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:46:02 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cr22so3988698qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A3ZdY21LXjE3PyX5fpTlE0/f6/GAdOiGr62nnKIP3aI=;
        b=XqmKvE/220WSzs0GhJ44A5LIXEmpXnCvVQd9D5uzyUIT3830BQHAqJwInbX68g1gOX
         48ZWklm9NO4kuHW00FcLFdeIknSgSmyrbbjZgFCCS2Tw2y8QXc0iRIm7jcY7UHd/ABe7
         SQoKqAlY8t5PtyHQkpA6HfrNiOJoTDO6RtgWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3ZdY21LXjE3PyX5fpTlE0/f6/GAdOiGr62nnKIP3aI=;
        b=NmSg3lMRPirkQuxiYkCarI/KHUK7v+eh4DcsgdKWabfeV+AhpOsLu0foYuGvOCOiDB
         2tIKw61bcWF4267Uy37l0Hxy/4/H7EwVnd0CyUp9Xwqys/fsUa6tiG9+Uo2m5cVqGPyu
         FemRblgOPsSw/LtX5oy/FwA6WIJJ6Fu0cW2zrDk5NwVuPlCzV7etvx/r/h7EzaIVO7yl
         2fVvIaR50CjB7AoiJlA5F8M8wHpkHvZRKieWARV18UaHT2y12EgbIssfUIopstnNDbVd
         BzYAOC1+ViIpTPHtULYQqDaPQTDW1ClXSpQmnUL6f2Kpn+mDeIo9v6z6vWXFpvBSq6vI
         szbg==
X-Gm-Message-State: AO0yUKUQCoSe3K7mnXBqGRy1AvlMmTH2BqysBVxvmzAoZ/WUEOZXjgWb
        jrhaHk7ZUm0rHEoH2vhGomp0//ReopRdg9CPWPg=
X-Google-Smtp-Source: AK7set8fRF66MmIyexsGEw7YjcZoVIqmbas53PZr+C7R1wTIUXcUkYioLaUXv88/cGaO36Tew6/t9Q==
X-Received: by 2002:a05:622a:1741:b0:3b6:92ce:b4f7 with SMTP id l1-20020a05622a174100b003b692ceb4f7mr12885427qtk.37.1675385161015;
        Thu, 02 Feb 2023 16:46:01 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id bi15-20020a05620a318f00b006e99290e83fsm754155qkb.107.2023.02.02.16.45.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 16:45:59 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id d132so4521448ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:45:58 -0800 (PST)
X-Received: by 2002:a25:9741:0:b0:804:3d1e:68af with SMTP id
 h1-20020a259741000000b008043d1e68afmr1156308ybo.258.1675385158481; Thu, 02
 Feb 2023 16:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20230120114313.2087015-1-john@metanate.com> <CAD=FV=UPD6c+NY8Ub37N7LmrRFpcr6gKOh0Os14DaKrf3bKo2A@mail.gmail.com>
 <Y8uo7vIcQ6caH9pu@ravnborg.org> <Y8wnswk++tvr9xMe@donbot> <Y81Px74OUYt21nj4@pendragon.ideasonboard.com>
 <Y856rWmtA4tQCcZz@donbot> <Y86wO8nvFbC81b1S@pendragon.ideasonboard.com>
In-Reply-To: <Y86wO8nvFbC81b1S@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Feb 2023 16:45:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UwMS86RKR9dqzOnjEhKxh=d=EJPfjcCOvWZMjVVQsmKw@mail.gmail.com>
Message-ID: <CAD=FV=UwMS86RKR9dqzOnjEhKxh=d=EJPfjcCOvWZMjVVQsmKw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: panel: Set orientation on panel_bridge connector
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     John Keeping <john@metanate.com>, Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 23, 2023 at 8:05 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi John,
>
> On Mon, Jan 23, 2023 at 12:16:45PM +0000, John Keeping wrote:
> > On Sun, Jan 22, 2023 at 05:01:27PM +0200, Laurent Pinchart wrote:
> > > On Sat, Jan 21, 2023 at 05:58:11PM +0000, John Keeping wrote:
> > > > On Sat, Jan 21, 2023 at 09:57:18AM +0100, Sam Ravnborg wrote:
> > > > > On Fri, Jan 20, 2023 at 01:44:38PM -0800, Doug Anderson wrote:
> > > > > > On Fri, Jan 20, 2023 at 3:43 AM John Keeping wrote:
> > > > > > >
> > > > > > > Commit 15b9ca1641f0 ("drm: Config orientation property if panel provides
> > > > > > > it") added a helper to set the panel panel orientation early but only
> > > > > > > connected this for drm_bridge_connector, which constructs a panel bridge
> > > > > > > with DRM_BRIDGE_ATTACH_NO_CONNECTOR and creates the connector itself.
> > > > > > >
> > > > > > > When the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is not specified and the
> > > > > > > panel_bridge creates its own connector the orientation is not set unless
> > > > > > > the panel does it in .get_modes which is too late and leads to a warning
> > > > > > > splat from __drm_mode_object_add() because the device is already
> > > > > > > registered.
> > > > > > >
> > > > > > > Call the necessary function to set add the orientation property when the
> > > > > > > connector is created so that it is available before the device is
> > > > > > > registered.
> > > > > >
> > > > > > I have no huge objection to your patch and it looks OK to me. That
> > > > > > being said, my understanding is that:
> > > > > >
> > > > > > 1. DRM_BRIDGE_ATTACH_NO_CONNECTOR is "the future" and not using the
> > > > > > flag is "deprecated".
> > > > >
> > > > > Correct.
> > > > > Could we take a look at how much is required to move the relevant driver
> > > > > to use DRM_BRIDGE_ATTACH_NO_CONNECTOR?
> > > > >
> > > > > If this is too much work now we may land this simple patch, but the
> > > > > preference is to move all drivers to the new bridge handling and thus
> > > > > asking display drivers to create the connector.
> > >
> > > I fully agree with Doug and Sam here. Let's see if we can keep the yak
> > > shaving minimal :-)
> > >
> > > > > What display driver are we dealing with here?
> > > >
> > > > This is dw-mipi-dsi-rockchip which uses the component path in
> > > > dw-mipi-dsi (and, in fact, is the only driver using that mode of
> > > > dw-mipi-dsi).
> > > >
> > > > I'm not familiar enough with DRM to say whether it's easy to convert to
> > > > DRM_BRIDGE_ATTACH_NO_CONNECTOR - should dw-mipi-dsi-rockchip be moving
> > > > to use dw-mipi-dsi as a bridge driver or should dw_mipi_dsi_bind() have
> > > > a drm_bridge_attach_flags argument?  But I'm happy to test patches if it
> > > > looks easy to convert to you :-)
> > >
> > > I'd go for the former (use dw_mipi_dsi_probe() and acquire the DSI
> > > bridge with of_drm_find_bridge() instead of using the component
> > > framework) if possible, but I don't know how intrusive that would be.
> >
> > I'm a bit confused about what's required since dw-mipi-dsi-rockchip
> > already uses dw_mipi_dsi_probe(),
>
> Indeed, my bad.
>
> > but I think moving away from the
> > component framework would be significant work as that's how the MIPI
> > subdriver fits in to the overall Rockchip display driver.
>
> It will be some work, yes. It however doesn't mean that the whole
> Rockchip display driver needs to move away from the component framework,
> it can be limited to the DSI encoder. It's not immediately clear to me
> why the DSI encoder uses the component framework in the first place, and
> if it would be difficult to move away from it.
>
> > Any changes / modernisation to the Rockchip MIPI driver look like it
> > will take more time than I have available to spend on this, so I'd
> > really like to see this patch land as it's a simple fix to an existing
> > working code path.
>
> So who volunteers for fixing it properly ? :-)
>
> I'll let Doug and Sam decide regarding mering this patch.

This thread seems to have gone silent.

I'm inclined to merge this patch (removing the "Fixes" tag) since it's
a one-line fix. While we want to encourage people to move to "the
future", it seems like it would be better to wait until someone is
trying to land something more intrusive than a 1-line fix before truly
forcing the issue.

I'll plan to merge the patch to drm-misc-next early next week assuming
there are no objections.

-Doug
