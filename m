Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C487D5FFB74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJOR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:27:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50255275C8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 10:27:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A3D0480;
        Sat, 15 Oct 2022 19:27:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665854829;
        bh=eiQiH8zroSayUVnkdP1tcEEZ3b9arQTFKuV0xO9DL8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4vdH6WzRd476+zgFPcIahs6DfK3ttXeSiFQdrcyLQnlmJVeX4X8ymKtj7dckqDx5
         XP6tw6VLC4XqZQuT+yijVfLujZUL+hpcdNnAqOJuay6UmIlXtQm4RLTkdsQue5xX2n
         nIo2O6tQ3iCLNtm5qoxnGidF0nRopajV7JrextwM=
Date:   Sat, 15 Oct 2022 20:26:46 +0300
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
Subject: Re: [PATCH 5/7] drm/vc4: dpi: Support BGR666 formats
Message-ID: <Y0rtVpMROELzbApj@pendragon.ideasonboard.com>
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
 <20221013-rpi-dpi-improvements-v1-5-8a7a96949cb0@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013-rpi-dpi-improvements-v1-5-8a7a96949cb0@cerno.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and Joerg,

Thank you for the patch.

On Thu, Oct 13, 2022 at 11:56:49AM +0200, Maxime Ripard wrote:
> From: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> 
> The VC4 DPI output can support multiple BGR666 variants, but they were
> never added to the driver. Let's add the the support for those formats.
> 
> Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/vc4/vc4_dpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
> index 7da3dd1db50e..ecbe4cd87036 100644
> --- a/drivers/gpu/drm/vc4/vc4_dpi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dpi.c
> @@ -170,10 +170,16 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
>  				dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR,
>  						       DPI_ORDER);
>  				break;
> +			case MEDIA_BUS_FMT_BGR666_1X24_CPADHI:
> +				dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR, DPI_ORDER);
> +				fallthrough;
>  			case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
>  				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_2,
>  						       DPI_FORMAT);
>  				break;
> +			case MEDIA_BUS_FMT_BGR666_1X18:
> +				dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR, DPI_ORDER);
> +				fallthrough;
>  			case MEDIA_BUS_FMT_RGB666_1X18:
>  				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_1,
>  						       DPI_FORMAT);
> 

-- 
Regards,

Laurent Pinchart
