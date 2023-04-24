Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48866EC87D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDXJMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjDXJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:12:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A8E76;
        Mon, 24 Apr 2023 02:11:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68EB79DE;
        Mon, 24 Apr 2023 11:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682327507;
        bh=JttGT14krNRj5WYQKdQI7bhCw/cOBk/ZkWpXFncAIpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWWKK+BZL+C7MgV3YcFmIMKYEnjNsg7Mf91X2aIHJlyrWt1QJwBvoloZEgVMQFTBA
         R2nj+k83UMoPtkEQZK6h/dxUYGD7HyiTygZPC1362dh8z4SR5hmpqGqs0ZCNDlxQAG
         lzLvjaLi1g6T9atDtnceUCksIvN9SEFQMzvA4fcY=
Date:   Mon, 24 Apr 2023 12:12:09 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        slongerbeam@gmail.com, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, rmfrfs@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: imx: Unstage the imx8mq-mipi-csi2 driver
Message-ID: <20230424091209.GC14888@pendragon.ideasonboard.com>
References: <20230424082945.2580298-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230424082945.2580298-1-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Mon, Apr 24, 2023 at 10:29:45AM +0200, Martin Kepplinger wrote:
> The imx8mq-mipi-csi2 mipi receiver driver is used and maintained. There

s/mipi/MIPI CSI-2/

> is no reason to keep it in staging. The accompanying CSI bridge driver that
> uses it is in drivers/media/platform/nxp as well.
> 
> One TODO is to get rid of csi_state's "state" and "lock" variables. Especially
> make sure suspend/resume is working without them. That can very well be worked
> on from the new location.
> 
> Add a MAINTAINERS section for the imx8mq-mipi-csi2 mipi receiver driver.
> It shares the CSI Bridge driver with the one from imx7 and imx8mm so the
> sections overlap a bit.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  MAINTAINERS                                         | 13 +++++++++++++
>  drivers/media/platform/nxp/Kconfig                  | 11 +++++++++++
>  drivers/media/platform/nxp/Makefile                 |  1 +
>  .../imx => media/platform/nxp}/imx8mq-mipi-csi2.c   |  0
>  drivers/staging/media/imx/Kconfig                   | 12 +-----------
>  drivers/staging/media/imx/Makefile                  |  2 --
>  6 files changed, 26 insertions(+), 13 deletions(-)
>  rename drivers/{staging/media/imx => media/platform/nxp}/imx8mq-mipi-csi2.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f50945bb7d1b..fcd48408fc1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12919,6 +12919,19 @@ F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
>  F:	drivers/media/platform/nxp/imx-mipi-csis.c
>  F:	drivers/media/platform/nxp/imx7-media-csi.c
>  
> +MEDIA DRIVERS FOR FREESCALE IMX8MQ
> +M:	Martin Kepplinger <martin.kepplinger@puri.sm>
> +R:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +R:	Purism Kernel Team <kernel@puri.sm>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/admin-guide/media/imx7.rst
> +F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
> +F:	Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> +F:	drivers/media/platform/nxp/imx7-media-csi.c
> +F:	drivers/media/platform/nxp/imx8mq-mipi-csi.c
> +

I'm not sure overlaps will be properly supported by all tools. I'd
rather avoid them. You can either

- Add this driver to the existing "MEDIA DRIVERS FOR FREESCALE IMX7"
  section (possibly renaming it to 'IMX7/8'), and add yourself as a
  maintainer to that section if desired.

- Create a new section as you're doing here, with just the CSI-2
  receiver driver in it.

Additionally, I'd rename the "MEDIA DRIVERS FOR FREESCALE IMX" entry to
"MEDIA DRIVERS FOR FREESCALE IMX5/6". This could be done in a separate
patch though.

>  MEDIA DRIVERS FOR HELENE
>  M:	Abylay Ospan <aospan@netup.ru>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/nxp/Kconfig
> index a0ca6b297fb8..efa985ec8a5f 100644
> --- a/drivers/media/platform/nxp/Kconfig
> +++ b/drivers/media/platform/nxp/Kconfig
> @@ -28,6 +28,17 @@ config VIDEO_IMX_MIPI_CSIS
>  	  Video4Linux2 sub-device driver for the MIPI CSI-2 CSIS receiver
>  	  v3.3/v3.6.3 found on some i.MX7 and i.MX8 SoCs.
>  
> +config VIDEO_IMX8MQ_MIPI_CSI2

VIDEO_IMX8MQ_MIPI_CSI2 goes before VIDEO_IMX_MIPI_CSIS in alphabetical
order.

> +	tristate "NXP i.MX8MQ MIPI CSI-2 receiver"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on VIDEO_DEV
> +	select MEDIA_CONTROLLER
> +	select V4L2_FWNODE
> +	select VIDEO_V4L2_SUBDEV_API
> +	help
> +	  Video4Linux2 driver for the MIPI CSI-2 receiver found on the i.MX8MQ
> +	  SoC. The i.MX8MQ CSI Bridge is the same as on i.MX7.

Drop the second sentence, it's irrelevant here.

> +
>  source "drivers/media/platform/nxp/imx8-isi/Kconfig"
>  
>  # mem2mem drivers
> diff --git a/drivers/media/platform/nxp/Makefile b/drivers/media/platform/nxp/Makefile
> index b8e672b75fed..4d90eb713652 100644
> --- a/drivers/media/platform/nxp/Makefile
> +++ b/drivers/media/platform/nxp/Makefile
> @@ -5,6 +5,7 @@ obj-y += imx-jpeg/
>  obj-y += imx8-isi/
>  
>  obj-$(CONFIG_VIDEO_IMX7_CSI) += imx7-media-csi.o
>  obj-$(CONFIG_VIDEO_IMX8MQ_MIPI_CSI2) += imx8mq-mipi-csi2.o
>  obj-$(CONFIG_VIDEO_IMX_MIPI_CSIS) += imx-mipi-csis.o
>  obj-$(CONFIG_VIDEO_IMX_PXP) += imx-pxp.o
>  obj-$(CONFIG_VIDEO_MX2_EMMAPRP) += mx2_emmaprp.o
> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> similarity index 100%
> rename from drivers/staging/media/imx/imx8mq-mipi-csi2.c
> rename to drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
> index 21fd79515042..5b393e29d29e 100644
> --- a/drivers/staging/media/imx/Kconfig
> +++ b/drivers/staging/media/imx/Kconfig
> @@ -15,7 +15,7 @@ config VIDEO_IMX_MEDIA
>  	  driver for the i.MX5/6 SOC.
>  
>  if VIDEO_IMX_MEDIA
> -menu "i.MX5/6/7/8 Media Sub devices"
> +menu "i.MX5/6 Media Sub devices"
>  
>  config VIDEO_IMX_CSI

I'm tempted to merge the VIDEO_IMX_MEDIA and VIDEO_IMX_CSI Kconfig
symbols. I'll send a patch to do so.

>  	tristate "i.MX5/6 Camera Sensor Interface driver"
> @@ -25,13 +25,3 @@ config VIDEO_IMX_CSI
>  	  A video4linux camera sensor interface driver for i.MX5/6.
>  endmenu
>  endif
> -
> -config VIDEO_IMX8MQ_MIPI_CSI2
> -	tristate "NXP i.MX8MQ MIPI CSI-2 receiver"
> -	depends on ARCH_MXC || COMPILE_TEST
> -	depends on VIDEO_DEV
> -	select MEDIA_CONTROLLER
> -	select V4L2_FWNODE
> -	select VIDEO_V4L2_SUBDEV_API
> -	help
> -	  V4L2 driver for the MIPI CSI-2 receiver found in the i.MX8MQ SoC.
> diff --git a/drivers/staging/media/imx/Makefile b/drivers/staging/media/imx/Makefile
> index 906a422aa656..b69951deff9a 100644
> --- a/drivers/staging/media/imx/Makefile
> +++ b/drivers/staging/media/imx/Makefile
> @@ -13,5 +13,3 @@ obj-$(CONFIG_VIDEO_IMX_MEDIA) += imx-media-common.o
>  obj-$(CONFIG_VIDEO_IMX_CSI) += imx6-media.o
>  obj-$(CONFIG_VIDEO_IMX_CSI) += imx6-media-csi.o
>  obj-$(CONFIG_VIDEO_IMX_CSI) += imx6-mipi-csi2.o
> -
> -obj-$(CONFIG_VIDEO_IMX8MQ_MIPI_CSI2) += imx8mq-mipi-csi2.o

-- 
Regards,

Laurent Pinchart
