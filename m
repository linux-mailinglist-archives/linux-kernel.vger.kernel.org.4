Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3915FFB5F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJOROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJOROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:14:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB048A38
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 10:14:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9FCF7480;
        Sat, 15 Oct 2022 19:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665854041;
        bh=mlExtG3PX3BfXsQGa88t7dxFY/1l+czRQhArSgZe9Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZshcaZbPpeYrYKHrCqfYrfyJ0oMng/IGit7wXLru3zGYdIgD4Y9eTtYU14rr0rIt
         C9RRISG4SlPoz87rLi6p96KyGxLd9EO3dR6pgPgCT0eB20oiovZsTzUKv7dsl5bIIY
         quHMKLNAjEMp6uUhyHduCf0LmOHGJdKiClKMTtks=
Date:   Sat, 15 Oct 2022 20:13:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>, dri-devel@lists.freedesktop.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] drm/vc4: dpi: Change the default DPI format to being
 18bpp, not 24.
Message-ID: <Y0rqQu8Ztowj3/Gi@pendragon.ideasonboard.com>
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
 <20221013-rpi-dpi-improvements-v1-6-8a7a96949cb0@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013-rpi-dpi-improvements-v1-6-8a7a96949cb0@cerno.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime (and Dave),

Thank you for the patch.

On Thu, Oct 13, 2022 at 11:56:50AM +0200, Maxime Ripard wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> DPI hasn't really been used up until now, so the default has
> been meaningless.
> In theory we should be able to pass the desired format for the
> adjacent bridge chip through, but framework seems to be missing
> for that.

Doesn't the bridge infrastructure allow that ? Or maybe this commit
message was written a while ago, before it was possible ?

In any case, it would be nice to use the bus format exposed by the next
bridge in the chain, but that can be done in a subsequent step. The new
default seems reasonable.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> As the main device to use DPI is the VGA666 or Adafruit Kippah,
> both of which use RGB666, change the default to being RGB666 instead
> of RGB888.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_dpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
> index ecbe4cd87036..fdae02760b6d 100644
> --- a/drivers/gpu/drm/vc4/vc4_dpi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dpi.c
> @@ -150,8 +150,8 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
>  
> -	/* Default to 24bit if no connector or format found. */
> -	dpi_c |= VC4_SET_FIELD(DPI_FORMAT_24BIT_888_RGB, DPI_FORMAT);
> +	/* Default to 18bit if no connector or format found. */
> +	dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_1, DPI_FORMAT);
>  
>  	if (connector) {
>  		if (connector->display_info.num_bus_formats) {
> 

-- 
Regards,

Laurent Pinchart
