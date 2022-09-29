Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2480C5F016A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiI2XdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiI2XdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:33:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD9148A38
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:33:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5C8747C;
        Fri, 30 Sep 2022 01:33:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664494389;
        bh=rsXQPfoODOoV2YweOgK8vKwcfwOCqbxKs2G25NITsXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wm76qp2D4KHujb8qnUUTH+dm4zmzZn2BKqGocvRED6/EcWRUtfKQUnL8Cm+vxm/Xm
         NY4r/893XoVIsInA/tSKO3nseZpmblPZ5ojyodhs3mfwPIBZBNUZ/kzx30uFHZd+lX
         6IFzsk5SGu61QuHzRQqGGr49o3TStmnpvwfY/nWM=
Date:   Fri, 30 Sep 2022 02:33:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Rodin <mrodin@de.adit-jv.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        michael@rodin.online, erosca@de.adit-jv.com
Subject: Re: [PATCH] drm: do not call detect for connectors which are forced
 on
Message-ID: <YzYrNJbfGcch1UtX@pendragon.ideasonboard.com>
References: <20220826091121.389315-1-mrodin@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826091121.389315-1-mrodin@de.adit-jv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

Thank you for the patch. Sorry for the late reply, I wasn't on the CC
list so I didn't notice it.

On Fri, Aug 26, 2022 at 11:11:21AM +0200, Michael Rodin wrote:
> "detect" should not be called and its return value shall not be used when a
> connector is forced as hinted in the commit d50ba256b5f1 ("drm/kms: start
> adding command line interface using fb.") and the commit 6fe14acd496e
> ("drm: Document drm_connector_funcs"). One negative side effect of doing
> this is observed on the RCar3 SoCs which use the dw-hdmi driver. It
> continues executing drm_helper_hpd_irq_event even if its connector is
> forced to ON. As consequence drm_helper_hpd_irq_event calls "detect" so the
> connector status is updated to "disconnected":
> 
> [  420.201527] [drm:drm_helper_hpd_irq_event] [CONNECTOR:76:HDMI-A-1] status updated from connected to disconnected
> 
> This status is corrected by drm_helper_probe_single_connector_modes shortly
> after this because this function checks if a connector is forced:
> 
> [  420.218703] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:76:HDMI-A-1] status updated from disconnected to connected
> 
> To avoid similar issues this commit adapts functions which call "detect"
> so they check if a connector is forced and return the correct status.
> 
> Fixes: 949f08862d66 ("drm: Make the connector .detect() callback optional")

Is this really the right fixes tag ? The call to .detect() in
drm_helper_hpd_irq_event() predates that commit.

> Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index bb427c5a4f1f..1691047d0472 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -289,7 +289,12 @@ drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
>  retry:
>  	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex, &ctx);
>  	if (!ret) {
> -		if (funcs->detect_ctx)
> +		if (connector->force == DRM_FORCE_ON ||
> +		    connector->force == DRM_FORCE_ON_DIGITAL)
> +			ret = connector_status_connected;
> +		else if (connector->force == DRM_FORCE_OFF)
> +			ret = connector_status_disconnected;
> +		else if (funcs->detect_ctx)
>  			ret = funcs->detect_ctx(connector, &ctx, force);
>  		else if (connector->funcs->detect)
>  			ret = connector->funcs->detect(connector, force);
> @@ -340,7 +345,14 @@ drm_helper_probe_detect(struct drm_connector *connector,
>  	if (ret)
>  		return ret;
>  
> -	if (funcs->detect_ctx)
> +	if (connector->force == DRM_FORCE_ON ||
> +	    connector->force == DRM_FORCE_ON_DIGITAL)
> +		ret = connector_status_connected;
> +	else if (connector->force == DRM_FORCE_OFF)
> +		ret = connector_status_disconnected;
> +	else if (funcs->detect_ctx)
> +		ret = funcs->detect_ctx(connector, ctx, force);
> +	else if (funcs->detect_ctx)
>  		ret = funcs->detect_ctx(connector, ctx, force);

Those two conditions are identical.

>  	else if (connector->funcs->detect)
>  		ret = connector->funcs->detect(connector, force);

The same logic is used in two places in this patch. Could this be
factored out to a separate function ? It may even be possible to
refactor drm_helper_probe_detect() and drm_helper_probe_detect_ctx() to
share more code between the two functions.

This being said, I'm not sure this is the right fix. Beside the i915 and
nouveau drivers, the only callers of drm_helper_probe_detect() are
drm_helper_probe_single_connector_modes(), output_poll_execute() and
check_connector_changed() in this file. The first two functions already
check connector->force and skip the call to drm_helper_probe_detect() if
the connector is forced. Only check_connector_changed() is missing that
check. Wouldn't it be simpler to return false in that function if
connector->force is set ?

Another question is whether it is valid for the dw-hdmi driver to call
drm_helper_hpd_irq_event() when the connector status is forced.
Shouldn't HPD events be ignored in that case ?

The detection code has grown quite complex over time, I would really
appreciate input from Maxime and Maarten on this.

-- 
Regards,

Laurent Pinchart
