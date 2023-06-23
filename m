Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB09073BC26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjFWPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjFWPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:55:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5482129;
        Fri, 23 Jun 2023 08:54:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A82CC838;
        Fri, 23 Jun 2023 17:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687535660;
        bh=qEimjjGheFgbhWQXyKIsZNL1k704juka4xzkdRWfhmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0Bg9TXGisodDm3LzjjgUR+BvGhzJ/BuM8XmwOltXmcFnTJJiYuFF0XbkaaYKEq3I
         dcETVQ/tMoR7Um8MNvboCFmNnK/u6pbg4QlHMwOJsFsj5oFPv0r9VJKugekDlkIfR/
         +FuSEj9egekqCoYrBX0L2DzuZY6JP4JluaPGgMIk=
Date:   Fri, 23 Jun 2023 18:54:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/39] drm: renesas: shmobile: Use media bus formats in
 platform data
Message-ID: <20230623155456.GZ2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <3599b9ee249afea0e5b5ced45ab3523e17503d31.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3599b9ee249afea0e5b5ced45ab3523e17503d31.1687423204.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.


On Thu, Jun 22, 2023 at 11:21:34AM +0200, Geert Uytterhoeven wrote:
> Replace the custom shmob_drm_interface enumeration values with standard
> media bus formats.  This simplifies driver handling of bus formats and
> prepares for DT support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 52 +++++++++++++------
>  include/linux/platform_data/shmob_drm.h       | 13 +----
>  2 files changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index 1a1d66c6e817e227..e5be0ae99bd970be 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/media-bus-format.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -34,24 +35,45 @@
>  
>  static int shmob_drm_init_interface(struct shmob_drm_device *sdev)
>  {
> -	static const u32 ldmt1r[] = {
> -		[SHMOB_DRM_IFACE_RGB8] = LDMT1R_MIFTYP_RGB8,
> -		[SHMOB_DRM_IFACE_RGB9] = LDMT1R_MIFTYP_RGB9,
> -		[SHMOB_DRM_IFACE_RGB12A] = LDMT1R_MIFTYP_RGB12A,
> -		[SHMOB_DRM_IFACE_RGB12B] = LDMT1R_MIFTYP_RGB12B,
> -		[SHMOB_DRM_IFACE_RGB16] = LDMT1R_MIFTYP_RGB16,
> -		[SHMOB_DRM_IFACE_RGB18] = LDMT1R_MIFTYP_RGB18,
> -		[SHMOB_DRM_IFACE_RGB24] = LDMT1R_MIFTYP_RGB24,
> -		[SHMOB_DRM_IFACE_YUV422] = LDMT1R_MIFTYP_YCBCR,
> -	};
> -
> -	if (sdev->pdata->iface.interface >= ARRAY_SIZE(ldmt1r)) {
> -		dev_err(sdev->dev, "invalid interface type %u\n",
> -			sdev->pdata->iface.interface);
> +	switch (sdev->pdata->iface.bus_fmt) {
> +	case MEDIA_BUS_FMT_RGB888_3X8:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_RGB8;
> +		break;
> +
> +	case MEDIA_BUS_FMT_RGB666_2X9_BE:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_RGB9;
> +		break;
> +
> +	case MEDIA_BUS_FMT_RGB888_2X12_BE:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_RGB12A;
> +		break;
> +
> +	case MEDIA_BUS_FMT_RGB444_1X12:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_RGB12B;
> +		break;
> +
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_RGB16;
> +		break;
> +
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_RGB18;
> +		break;
> +
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_RGB24;
> +		break;
> +
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +		sdev->ldmt1r = LDMT1R_MIFTYP_YCBCR;
> +		break;
> +
> +	default:
> +		dev_err(sdev->dev, "invalid bus format 0x%x\n",
> +			sdev->pdata->iface.bus_fmt);
>  		return -EINVAL;
>  	}
>  
> -	sdev->ldmt1r = ldmt1r[sdev->pdata->iface.interface];
>  	return 0;
>  }
>  
> diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
> index f3cb19ff9f818aca..5047e66f0a6823ba 100644
> --- a/include/linux/platform_data/shmob_drm.h
> +++ b/include/linux/platform_data/shmob_drm.h
> @@ -18,17 +18,6 @@ enum shmob_drm_clk_source {
>  	SHMOB_DRM_CLK_EXTERNAL,
>  };
>  
> -enum shmob_drm_interface {
> -	SHMOB_DRM_IFACE_RGB8,		/* 24bpp, 8:8:8 */
> -	SHMOB_DRM_IFACE_RGB9,		/* 18bpp, 9:9 */
> -	SHMOB_DRM_IFACE_RGB12A,		/* 24bpp, 12:12 */
> -	SHMOB_DRM_IFACE_RGB12B,		/* 12bpp */
> -	SHMOB_DRM_IFACE_RGB16,		/* 16bpp */
> -	SHMOB_DRM_IFACE_RGB18,		/* 18bpp */
> -	SHMOB_DRM_IFACE_RGB24,		/* 24bpp */
> -	SHMOB_DRM_IFACE_YUV422,		/* 16bpp */
> -};
> -
>  struct shmob_drm_panel_data {
>  	unsigned int width_mm;		/* Panel width in mm */
>  	unsigned int height_mm;		/* Panel height in mm */
> @@ -36,7 +25,7 @@ struct shmob_drm_panel_data {
>  };
>  
>  struct shmob_drm_interface_data {
> -	enum shmob_drm_interface interface;
> +	unsigned int bus_fmt;		/* MEDIA_BUS_FMT_RGB888_* */
>  	unsigned int clk_div;
>  };
>  

-- 
Regards,

Laurent Pinchart
