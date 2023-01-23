Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF6677A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjAWMRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:17:05 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9817157
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=r80bla368F0mccCTC7Gf0OTNLE2fXe2B5th7gyHTqbQ=; b=rNaVX
        +nePtYTn0zLA92rms+XZn/2Fb2GrjoCDlFkcXj7slSMQ6FylnlZIHeF/tKHUX6asHca60R5TWMBPm
        b07leiFLb7JI25QN4kE1vo3Tu7r0ehnoLTZyL8LS7Mrdi1bivbEDgaMAM9jQ8C6POFWxXo0ZfmMfm
        axpmvoCEvY3ke7MzpcbtPRhby8TEPmfHis9xBAsRamqSR1JP7hbiJ9ANVa8nBSh/hxzIIKdgwCDWx
        A06+YP0TkK+s7e0E3nTrpOPMEEwaDymYt0myD+kOrP7AlH6dFygXLSEAcCDkbeci/RjSoSr39pDHl
        MitYnMIpVqBI1u5SfyQzbNd/yqVjQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pJvkk-0004BB-RI;
        Mon, 23 Jan 2023 12:16:46 +0000
Date:   Mon, 23 Jan 2023 12:16:45 +0000
From:   John Keeping <john@metanate.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Doug Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] drm/bridge: panel: Set orientation on panel_bridge
 connector
Message-ID: <Y856rWmtA4tQCcZz@donbot>
References: <20230120114313.2087015-1-john@metanate.com>
 <CAD=FV=UPD6c+NY8Ub37N7LmrRFpcr6gKOh0Os14DaKrf3bKo2A@mail.gmail.com>
 <Y8uo7vIcQ6caH9pu@ravnborg.org>
 <Y8wnswk++tvr9xMe@donbot>
 <Y81Px74OUYt21nj4@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y81Px74OUYt21nj4@pendragon.ideasonboard.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sun, Jan 22, 2023 at 05:01:27PM +0200, Laurent Pinchart wrote:
> On Sat, Jan 21, 2023 at 05:58:11PM +0000, John Keeping wrote:
> > On Sat, Jan 21, 2023 at 09:57:18AM +0100, Sam Ravnborg wrote:
> > > On Fri, Jan 20, 2023 at 01:44:38PM -0800, Doug Anderson wrote:
> > > > On Fri, Jan 20, 2023 at 3:43 AM John Keeping wrote:
> > > > >
> > > > > Commit 15b9ca1641f0 ("drm: Config orientation property if panel provides
> > > > > it") added a helper to set the panel panel orientation early but only
> > > > > connected this for drm_bridge_connector, which constructs a panel bridge
> > > > > with DRM_BRIDGE_ATTACH_NO_CONNECTOR and creates the connector itself.
> > > > >
> > > > > When the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is not specified and the
> > > > > panel_bridge creates its own connector the orientation is not set unless
> > > > > the panel does it in .get_modes which is too late and leads to a warning
> > > > > splat from __drm_mode_object_add() because the device is already
> > > > > registered.
> > > > >
> > > > > Call the necessary function to set add the orientation property when the
> > > > > connector is created so that it is available before the device is
> > > > > registered.
> > > > 
> > > > I have no huge objection to your patch and it looks OK to me. That
> > > > being said, my understanding is that:
> > > > 
> > > > 1. DRM_BRIDGE_ATTACH_NO_CONNECTOR is "the future" and not using the
> > > > flag is "deprecated".
> > >
> > > Correct.
> > > Could we take a look at how much is required to move the relevant driver
> > > to use DRM_BRIDGE_ATTACH_NO_CONNECTOR?
> > >
> > > If this is too much work now we may land this simple patch, but the
> > > preference is to move all drivers to the new bridge handling and thus
> > > asking display drivers to create the connector.
> 
> I fully agree with Doug and Sam here. Let's see if we can keep the yak
> shaving minimal :-)
> 
> > > What display driver are we dealing with here?
> > 
> > This is dw-mipi-dsi-rockchip which uses the component path in
> > dw-mipi-dsi (and, in fact, is the only driver using that mode of
> > dw-mipi-dsi).
> > 
> > I'm not familiar enough with DRM to say whether it's easy to convert to
> > DRM_BRIDGE_ATTACH_NO_CONNECTOR - should dw-mipi-dsi-rockchip be moving
> > to use dw-mipi-dsi as a bridge driver or should dw_mipi_dsi_bind() have
> > a drm_bridge_attach_flags argument?  But I'm happy to test patches if it
> > looks easy to convert to you :-)
> 
> I'd go for the former (use dw_mipi_dsi_probe() and acquire the DSI
> bridge with of_drm_find_bridge() instead of using the component
> framework) if possible, but I don't know how intrusive that would be.

I'm a bit confused about what's required since dw-mipi-dsi-rockchip
already uses dw_mipi_dsi_probe(), but I think moving away from the
component framework would be significant work as that's how the MIPI
subdriver fits in to the overall Rockchip display driver.

Any changes / modernisation to the Rockchip MIPI driver look like it
will take more time than I have available to spend on this, so I'd
really like to see this patch land as it's a simple fix to an existing
working code path.


John
