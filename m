Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC22B6DEFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDLI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDLI7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:59:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD393FA;
        Wed, 12 Apr 2023 01:59:17 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7451C616E;
        Wed, 12 Apr 2023 10:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681289954;
        bh=qV8JcF2r9ggW8P3RPvH7aMgjXjti7cuWwbusF0BQCNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmoOx7nivKW6v+Wl0gFefaJBdo9ADbBHoXVkp7mQTmja1swWG+AoRsa9RvTvDAfrx
         ceW1LKV83YTEavEbQV+NZFAfSs+ZMvKnb3aeYdCHEViH2XpSHAt89Cn8np/8DHbEoE
         CofEouaVdxDeG0dZCWIgA/l171AgTKmxgmUYTRAQ=
Date:   Wed, 12 Apr 2023 11:59:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Tony Lindgren <tony@atomide.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/omap: dsi: Fix deferred probe warnings
Message-ID: <20230412085926.GR11253@pendragon.ideasonboard.com>
References: <20230412073954.20601-1-tony@atomide.com>
 <20230412085044.GP11253@pendragon.ideasonboard.com>
 <2bf56c04-733b-24a5-a344-166a94cd51f7@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf56c04-733b-24a5-a344-166a94cd51f7@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:55:34AM +0300, Tomi Valkeinen wrote:
> On 12/04/2023 11:50, Laurent Pinchart wrote:
> > Hi Tony,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Apr 12, 2023 at 10:39:53AM +0300, Tony Lindgren wrote:
> >> We may not have dsi->dsidev initialized during probe, and that can
> >> lead into various dsi related warnings as omap_dsi_host_detach() gets
> >> called with dsi->dsidev set to NULL.
> >>
> >> The warnings can be "Fixed dependency cycle(s)" followed by a
> >> WARNING: CPU: 0 PID: 787 at drivers/gpu/drm/omapdrm/dss/dsi.c:4414.
> > 
> > How can this happen ? I assume .detach() can't be called without a
> > priori successful call to .attach(), that that sets dsi->dsidev.
> 
> I had a quick look, and the driver calls mipi_dsi_host_register() in 
> probe, and mipi_dsi_host_unregister() in remove.
> 
> mipi_dsi_host_unregister() always calls mipi_dsi_detach(), but I don't 
> think mipi_dsi_host_register() always calls attach, which happens later 
> when the peripheral probes.

Is this something that should be addressed in the DRM MIPI DSI helpers,
to only detach after an attach ?

> >> Let's fix the warnings by checking for a valid dsi->dsidev.
> >>
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> >> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> >> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> >> @@ -4411,7 +4411,7 @@ static int omap_dsi_host_detach(struct mipi_dsi_host *host,
> >>   {
> >>   	struct dsi_data *dsi = host_to_omap(host);
> >>   
> >> -	if (WARN_ON(dsi->dsidev != client))
> >> +	if (dsi->dsidev && WARN_ON(dsi->dsidev != client))
> >>   		return -EINVAL;
> >>   
> >>   	cancel_delayed_work_sync(&dsi->dsi_disable_work);

-- 
Regards,

Laurent Pinchart
