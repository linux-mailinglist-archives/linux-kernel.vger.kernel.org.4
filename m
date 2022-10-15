Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF55FFB76
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJOR3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJOR3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:29:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EA1F615
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 10:29:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EFDA480;
        Sat, 15 Oct 2022 19:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665854983;
        bh=Cpxftv70YRjRtiWqBhl77lTxBNOYifeMbq6wRStaWx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxU89CU4XAg/DORwBL5LFLqBISS+SRsDZ0m5mesuWjGziyFqH+akGoczHGc3b8eic
         8DTbi6mmxkxb+oiIA672IhpK4fcykeovz10g8ZCJeQEj5Ra9ozQHLLv3lBWXKd0Goi
         hAp7Pk/49GyMhcywoN74MoNjpw/nwjrPqXdPHVE0=
Date:   Sat, 15 Oct 2022 20:29:20 +0300
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
Subject: Re: [PATCH 4/7] drm/vc4: dpi: Support RGB565 format
Message-ID: <Y0rt8FIkRniuv0l4@pendragon.ideasonboard.com>
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
 <20221013-rpi-dpi-improvements-v1-4-8a7a96949cb0@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013-rpi-dpi-improvements-v1-4-8a7a96949cb0@cerno.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and Chris,

Thank you for the patch.

On Thu, Oct 13, 2022 at 11:56:48AM +0200, Maxime Ripard wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The RGB565 format with padding over 24 bits
> (MEDIA_BUS_FMT_RGB565_1X24_CPADHI) is supported by the vc4 DPI
> controller as "mode 3".  This is what the Geekworm MZP280 DPI display

The code below uses DPI_FORMAT_16BIT_565_RGB_2. Is that mode 3, or
should the commit message refer to mode 2 ?

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> uses, so let's add support for it in the DPI controller driver.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_dpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
> index 1f8f44b7b5a5..7da3dd1db50e 100644
> --- a/drivers/gpu/drm/vc4/vc4_dpi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dpi.c
> @@ -182,6 +182,10 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
>  				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_3,
>  						       DPI_FORMAT);
>  				break;
> +			case MEDIA_BUS_FMT_RGB565_1X24_CPADHI:
> +				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_2,
> +						       DPI_FORMAT);
> +				break;
>  			default:
>  				DRM_ERROR("Unknown media bus format %d\n",
>  					  bus_format);
> 

-- 
Regards,

Laurent Pinchart
