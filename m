Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8429631F16
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKULGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKULGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:06:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF254D5C6;
        Mon, 21 Nov 2022 03:06:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDB97987;
        Mon, 21 Nov 2022 12:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669028758;
        bh=CRsuPPp/rz/2yZHYDzg/vVFiNGe9BG69gDQqmUZnqTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6z6tOPSuRF7tgvaSuFO1EfY+KocDEQOlejpoJvsQSLTlVRDtiFgNS4/RT6CWcN5L
         av4ONf4WyiJYnIQHRa0U8usMGNpJsMOYk6oH6V42JFp6+MiNQ/PYOMqdrCW10L8pfF
         qVDEaMaUuKV+vQt/zAfMLaHz3lrPBYJ6FIND6wUg=
Date:   Mon, 21 Nov 2022 13:05:43 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sathyakam M <sathya@samsung.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        jernej.skrabec@gmail.com, ming.qian@nxp.com, digetx@gmail.com,
        jacopo@jmondi.org, pankaj.dubey@samsung.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] media: fsd: add MIPI CSI2 Rx controller driver
Message-ID: <Y3tbh/8MH1lSJHZz@pendragon.ideasonboard.com>
References: <cover.1668963790.git.sathya@samsung.com>
 <CGME20221121044855epcas5p3ef93576acdcdb6e4feba63c15917d9de@epcas5p3.samsung.com>
 <7e7832c16925386b771ddb7e00e08661115aa0ea.1668963790.git.sathya@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e7832c16925386b771ddb7e00e08661115aa0ea.1668963790.git.sathya@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathyakam,

Thank you for the patch.

On Mon, Nov 21, 2022 at 10:23:59AM +0530, Sathyakam M wrote:
> The FSD MIPI CSI2 Rx controller is compliant to MIPI CSI2 v1.3 and
> D-PHY v1.2 specifications.
> 
> There are up to maximum 4 data lanes (default).
> Controls are provided for User to change number of lanes if needed.
> 
> Both the video and v4l-subdev instances are exposed to the user
> under /dev directory.
> 
> The driver can be built as a loadable module or as a platform_driver.
> 
> Signed-off-by: Sathyakam M <sathya@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sathyakam M <sathya@samsung.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Ming Qian <ming.qian@nxp.com>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Cc: Pankaj Kumar Dubey <pankaj.dubey@samsung.com>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../media/drivers/fsd-csis-uapi.rst           |   78 +
>  MAINTAINERS                                   |    1 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/fsd/Kconfig            |   73 +
>  drivers/media/platform/fsd/Makefile           |    1 +
>  drivers/media/platform/fsd/fsd-csis.c         | 2664 +++++++++++++++++
>  drivers/media/platform/fsd/fsd-csis.h         |  785 +++++
>  include/uapi/linux/fsd-csis.h                 |   19 +
>  include/uapi/linux/v4l2-controls.h            |    5 +
>  10 files changed, 3628 insertions(+)
>  create mode 100644 Documentation/userspace-api/media/drivers/fsd-csis-uapi.rst
>  create mode 100644 drivers/media/platform/fsd/Kconfig
>  create mode 100644 drivers/media/platform/fsd/Makefile
>  create mode 100644 drivers/media/platform/fsd/fsd-csis.c
>  create mode 100644 drivers/media/platform/fsd/fsd-csis.h
>  create mode 100644 include/uapi/linux/fsd-csis.h
> 
> diff --git a/Documentation/userspace-api/media/drivers/fsd-csis-uapi.rst b/Documentation/userspace-api/media/drivers/fsd-csis-uapi.rst
> new file mode 100644
> index 000000000000..6d714e9c5d45
> --- /dev/null
> +++ b/Documentation/userspace-api/media/drivers/fsd-csis-uapi.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +FSD MIPI CSI2 Rx Controller driver
> +==================================
> +
> +The CSI2 Rx Controller driver is compliant to MIPI CSI2 v1.3, MIPI D-PHY v1.2 specifications.
> +The controller receives images over a 4 lane D-PHY interface.
> +A single D-PHY interface is shared among 4 CSI2 Rx controllers.

Looking at the driver, this also bundles a DMA engine. Furthermore, the
registers show that the CSI-2 RX is a Samsung CSIS, which is already
supported by drivers/media/platform/nxp/imx-mipi-csis.c. This driver
should be split in two, with this driver handling the DMA engine only,
using the imx-mipi-csis.c driver to handle the CSIS and expose it as a
subdev.

> +
> +
> +Private IOCTLs
> +~~~~~~~~~~~~~~
> +
> +The FSD CSI2 Rx Controller implements below private IOCTLs
> +
> +VIDIOC_CSIS_DMA_SKIP
> +^^^^^^^^^^^^^^^^^^^^
> +
> +Argument: struct dma_skip_str
> +
> +**Description**:
> +
> +        The DMA controller can be configured to skip incoming frames
> +        from being written to memory when needed. e.g. when user application
> +        needs bandwidth control without reconfiguring camera sensor.
> +
> +**Return value**:
> +
> +       On success 0 is returned. On error -1 is returned and errno is set
> +       appropriately.
> +
> +**Data types**:
> +
> +.. code-block:: none
> +
> +        * struct dma_skip_str
> +
> +        __u32   ta      turn around pointer varibale
> +        __u32   sseq    dma skip sequence variable
> +        __u32   en      dma skip enable
> +        __u32   vc      virtual channel

Custom ioctls require an open-source userspace to showcase their usage.
Implementation of a test tool is not enough, this must be part of a real
userspace framework. libcamera is a good option, but other options may
be possible.

> +
> +
> +Custom controls
> +~~~~~~~~~~~~~~~
> +
> +FSD CSI2 Rx controller implements below custom cotrols
> +
> +V4L2_CID_USER_FSD_CSIS_NO_OF_LANE
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Argument: struct v4l2_control
> +
> +**Description**:
> +
> +        The D-PHY interface can be configured to receive streaming
> +        on data lanes between 1 to 4 (inclusive). User applications
> +        can set the desired number of lanes with this control using
> +        the video device interface
> +
> +**Return value**:
> +
> +       On success 0 is returned. On error -1 is returned and errno is set
> +       appropriately.
> +
> +**Data types**:
> +
> +.. code-block:: none
> +
> +        * struct v4l2_control
> +
> +        __u32   id      V4L2_CID_USER_FSD_CSIS_NO_OF_LANE
> +        __s32   value   1 to 4 (inclusive)

Why should this be set from userspace, and not from within the kernel ?
Does the value need to change depending on the configuration of the
CSI-2 source ? If so, you could use a subdev operation to query the
number of lanes used by the sensor when starting streaming.

> +
> +References
> +----------
> +
> +.. [#] include/uapi/linux/fsd-csis.h
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bbadba5888ab..c65bacd43f54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8386,6 +8386,7 @@ M:	Sathyakam M <sathya@samsung.com>
>  L:	linux-media@vger.kernel.org
>  S:	Orphan
>  F:	Documentation/devicetree/bindings/media/tesla-fsd-csis.yaml

I don't see this file in mainline, which tree is this patch based on ? I
also don't see patches 1-3 and 5 on the list, have I missed something ?

> +F:	drivers/media/platform/fsd/*
>  
>  FSI SUBSYSTEM
>  M:	Jeremy Kerr <jk@ozlabs.org>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index a9334263fa9b..b48ca5f78bdd 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -69,6 +69,7 @@ source "drivers/media/platform/aspeed/Kconfig"
>  source "drivers/media/platform/atmel/Kconfig"
>  source "drivers/media/platform/cadence/Kconfig"
>  source "drivers/media/platform/chips-media/Kconfig"
> +source "drivers/media/platform/fsd/Kconfig"
>  source "drivers/media/platform/intel/Kconfig"
>  source "drivers/media/platform/marvell/Kconfig"
>  source "drivers/media/platform/mediatek/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index a91f42024273..d73ab62ab0cf 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -12,6 +12,7 @@ obj-y += aspeed/
>  obj-y += atmel/
>  obj-y += cadence/
>  obj-y += chips-media/
> +obj-y += fsd/
>  obj-y += intel/
>  obj-y += marvell/
>  obj-y += mediatek/
> diff --git a/drivers/media/platform/fsd/Kconfig b/drivers/media/platform/fsd/Kconfig
> new file mode 100644
> index 000000000000..9ce44becf3ec
> --- /dev/null
> +++ b/drivers/media/platform/fsd/Kconfig
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# FSD MIPI CSI-2 Rx controller configurations
> +
> +config VIDEO_FSD_MIPI_CSIS
> +	tristate "FSD SoC MIPI-CSI2 Rx controller driver"
> +	depends on VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
> +	depends on HAS_DMA
> +	depends on OF
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE
> +	help
> +	  This is a V4L2 driver for FSD SoC MIPI-CSI2 Rx interface.
> +	  To compile this driver as a module, choose M here.
> +	  The module will be called fsd-csis.
> +	  Please select appropriate data rate for D-PHY configuration
> +
> +choice
> +	prompt "Select PHY control values"
> +	depends on VIDEO_FSD_MIPI_CSIS
> +	default FSD_CSI_1600_MEGA_BITS_PER_SEC
> +	help
> +	  Select D-PHY Common control values based on CSI Rx
> +	  bandwidth requirement.
> +	  The PHY parameters are set according to the
> +	  selected data rate.

This shouldn't be a compile-time option, but a runtime option (possibly
coming from DT).

> +
> +config FSD_CSI_800_MEGA_BITS_PER_SEC
> +	bool "800Mbps"
> +	help
> +	  D-PHY Common control values for 800Mbps.
> +	  If set FSD CSI2 Rx controller and the D-PHY are configured
> +	  for data rate up to 800Mbps over the 4 lane interface.
> +	  The D-PHY parameters for HS and Clock settle timings
> +	  are set accordingly.
> +
> +config FSD_CSI_1000_MEGA_BITS_PER_SEC
> +	bool "1000Mbps"
> +	help
> +	  D-PHY Common control values for 1000Mbps.
> +	  If set FSD CSI2 Rx controller and the D-PHY are configured
> +	  for data rate up to 1000Mbps over the 4 lane interface.
> +	  The D-PHY parameters for HS and Clock settle timings
> +	  are set accordingly.
> +
> +config FSD_CSI_1500_MEGA_BITS_PER_SEC
> +	bool "1500Mbps"
> +	help
> +	  D-PHY Common control values for 1500Mbps.
> +	  If set FSD CSI2 Rx controller and the D-PHY are configured
> +	  for data rate up to 1500Mbps over the 4 lane interface.
> +	  The D-PHY parameters for HS and Clock settle timings
> +	  are set accordingly.
> +
> +config FSD_CSI_1600_MEGA_BITS_PER_SEC
> +	bool "1600Mbps"
> +	help
> +	  D-PHY Common control values for 1600Mbps.
> +	  If set FSD CSI2 Rx controller and the D-PHY are configured
> +	  for data rate up to 1600Mbps over the 4 lane interface.
> +	  The D-PHY parameters for HS and Clock settle timings
> +	  are set accordingly.
> +
> +config FSD_CSI_2100_MEGA_BITS_PER_SEC
> +	bool "2100Mbps"
> +	help
> +	  D-PHY Common control values for 2100Mbps.
> +	  If set FSD CSI2 Rx controller and the D-PHY are configured
> +	  for data rate up to 2100Mbps over the 4 lane interface.
> +	  The D-PHY parameters for HS and Clock settle timings
> +	  are set accordingly.
> +
> +endchoice
> diff --git a/drivers/media/platform/fsd/Makefile b/drivers/media/platform/fsd/Makefile
> new file mode 100644
> index 000000000000..41d9e1ceb11c
> --- /dev/null
> +++ b/drivers/media/platform/fsd/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_VIDEO_FSD_MIPI_CSIS) += fsd-csis.o
> diff --git a/drivers/media/platform/fsd/fsd-csis.c b/drivers/media/platform/fsd/fsd-csis.c
> new file mode 100644
> index 000000000000..713c63c46f09
> --- /dev/null
> +++ b/drivers/media/platform/fsd/fsd-csis.c
> @@ -0,0 +1,2664 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FSD CSIS camera interface driver
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation
> + */
> +
> +#include <linux/uaccess.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioctl.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/videodev2.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/videobuf2-core.h>
> +#include <media/videobuf2-dma-contig.h>
> +#include <media/videobuf2-vmalloc.h>
> +
> +#include <uapi/linux/fsd-csis.h>
> +
> +#include "fsd-csis.h"
> +
> +#define FSD_CSIS_MODULE_NAME	"csis"
> +#define FSD_CSIS_MODULE_VERSION	"0.0.1"
> +
> +static unsigned int video_nr = -1;
> +module_param(video_nr, uint, 0644);
> +MODULE_PARM_DESC(video_nr, "videoX start number, -1 is autodetect");
> +
> +static unsigned int debug;
> +module_param(debug, uint, 0644);
> +MODULE_PARM_DESC(debug, "activities debug info");
> +
> +static atomic_t drv_instance = ATOMIC_INIT(0);
> +
> +/* fsd_csis_formats - array of image formats supported */
> +static const struct fsd_csis_fmt fsd_csis_formats[FSD_CSIS_MAX_FORMATS] = {
> +	{
> +		.name		= "RGB565",
> +		.fourcc		= V4L2_PIX_FMT_RGB565,
> +		.colorspace	= V4L2_COLORSPACE_SRGB,
> +		.code		= MEDIA_BUS_FMT_RGB565_1X16,
> +		.depth		= 16,
> +	}, {
> +		.name		= "RGB666",
> +		.fourcc		= V4L2_PIX_FMT_BGR666,
> +		.colorspace	= V4L2_COLORSPACE_SRGB,
> +		.code		= MEDIA_BUS_FMT_RGB666_1X18,
> +		.depth		= 18,
> +	}, {
> +		.name		= "RGB888-24",
> +		.fourcc		= V4L2_PIX_FMT_RGB24,
> +		.colorspace	= V4L2_COLORSPACE_SRGB,
> +		.code		= MEDIA_BUS_FMT_RGB888_1X24,
> +		.depth		= 24,
> +	}, {
> +		.name		= "RGB888-32",
> +		.fourcc		= V4L2_PIX_FMT_RGB32,
> +		.colorspace	= V4L2_COLORSPACE_SRGB,
> +		.code           = MEDIA_BUS_FMT_RGB888_1X32_PADHI,
> +		.depth		= 32,
> +	}, {
> +		.name		= "XRGB888",
> +		.fourcc         = V4L2_PIX_FMT_XRGB32,
> +		.colorspace     = V4L2_COLORSPACE_SRGB,
> +		.code           = MEDIA_BUS_FMT_RGB888_1X32_PADHI,
> +		.depth          = 32,
> +	}, {
> +		.name		= "UYVY-16",
> +		.fourcc		= V4L2_PIX_FMT_UYVY,
> +		.colorspace	= V4L2_COLORSPACE_RAW,
> +		.code		= MEDIA_BUS_FMT_UYVY8_2X8,
> +		.depth		= 16,
> +	}, {
> +		.name		= "YUV422-8",
> +		.fourcc		= V4L2_PIX_FMT_YUYV,
> +		.colorspace	= V4L2_COLORSPACE_RAW,
> +		.code		= MEDIA_BUS_FMT_VYUY8_2X8,
> +		.depth		= 16,
> +	}, {
> +		.name		= "SBGGR8",
> +		.fourcc         = V4L2_PIX_FMT_SBGGR8,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.depth          = 8,
> +	}, {
> +		.name		= "SGBRG8",
> +		.fourcc         = V4L2_PIX_FMT_SGBRG8,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.depth          = 8,
> +	}, {
> +		.name		= "SGRBG8",
> +		.fourcc         = V4L2_PIX_FMT_SGRBG8,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SGRBG8_1X8,
> +		.depth          = 8,
> +	}, {
> +		.name		= "SRGGB8",
> +		.fourcc         = V4L2_PIX_FMT_SRGGB8,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SRGGB8_1X8,
> +		.depth          = 8,
> +	}, {
> +		.name		= "SBGGR10",
> +		.fourcc         = V4L2_PIX_FMT_SBGGR10,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.depth          = 10,
> +	}, {
> +		.name		= "SGBRG10",
> +		.fourcc         = V4L2_PIX_FMT_SGBRG10,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.depth          = 10,
> +	}, {
> +		.name		= "SGRBG10",
> +		.fourcc         = V4L2_PIX_FMT_SGRBG10,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.depth          = 10,
> +	}, {
> +		.name		= "SRGGB10",
> +		.fourcc         = V4L2_PIX_FMT_SRGGB10,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.depth          = 10,
> +	}, {
> +		.name		= "SBGGR12",
> +		.fourcc         = V4L2_PIX_FMT_SBGGR12,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SBGGR12_1X12,
> +		.depth          = 12,
> +	}, {
> +		.name		= "SGBRG12",
> +		.fourcc         = V4L2_PIX_FMT_SGBRG12,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SGBRG12_1X12,
> +		.depth          = 12,
> +	}, {
> +		.name		= "SGRBG12",
> +		.fourcc         = V4L2_PIX_FMT_SGRBG12,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SGRBG12_1X12,
> +		.depth          = 12,
> +	}, {
> +		.name		= "SRGGB12",
> +		.fourcc         = V4L2_PIX_FMT_SRGGB12,
> +		.colorspace     = V4L2_COLORSPACE_RAW,
> +		.code           = MEDIA_BUS_FMT_SRGGB12_1X12,
> +		.depth          = 12,
> +	}, {
> +		.name		= "JPEG",
> +		.fourcc         = V4L2_PIX_FMT_JPEG,
> +		.colorspace     = V4L2_COLORSPACE_JPEG,
> +		.code           = MEDIA_BUS_FMT_JPEG_1X8,
> +		.depth          = 16,
> +	},
> +};
> +
> +/*
> + * fourcc_to_str() - Utility function to display fourcc
> + * @fmt: fourcc value of image format
> + * Return: string equevalent of fourcc value
> + */
> +static char *fourcc_to_str(u32 fmt)
> +{
> +	static unsigned char code[5];
> +
> +	code[0] = (unsigned char)(fmt & 0xff);
> +	code[1] = (unsigned char)((fmt >> 8) & 0xff);
> +	code[2] = (unsigned char)((fmt >> 16) & 0xff);
> +	code[3] = (unsigned char)((fmt >> 24) & 0xff);
> +	code[4] = '\0';
> +	return code;
> +}

Use the printk %p4CC format specifier instead.

> +
> +/*
> + *  timeperframe: min/max and default
> + */
> +static const struct v4l2_fract fsd_csis_tpf_default = {
> +	.numerator = 1001,
> +	.denominator = 30000
> +};
> +
> +/*
> + * fsd_csis_clear_vid_irqs() - clear the interrupt sources
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_clear_vid_irqs(struct fsd_csis_dev *dev)
> +{
> +	unsigned int int_src = 0;
> +
> +	int_src = readl(dev->base + CSIS_INT_SRC0);
> +	writel(int_src, dev->base + CSIS_INT_SRC0);
> +
> +	int_src = readl(dev->base + CSIS_INT_SRC1);
> +	writel(int_src, dev->base + CSIS_INT_SRC1);
> +}
> +
> +/*
> + * fsd_csis_disable_interrupts() - Disable the interrupt sources by masking
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_disable_irqs(struct fsd_csis_dev *dev)
> +{
> +	writel(CSIS_INT_MSK0_MASK_ALL, dev->base + CSIS_INT_MSK0);
> +	writel(CSIS_INT_MSK1_MASK_ALL, dev->base + CSIS_INT_MSK1);
> +}
> +
> +/*
> + * fsd_csis_enable_vid_irqs() - Enable the interrupt sources by unmasking
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_enable_vid_irqs(struct fsd_csis_dev *dev)
> +{
> +	writel(CSIS_INT_MSK0_ENABLE_ALL, dev->base + CSIS_INT_MSK0);
> +	writel(CSIS_INT_MSK1_ENABLE_ALL, dev->base + CSIS_INT_MSK1);
> +}
> +
> +/*
> + * fsd_csis_dphy_reset() - reset and release D-PHY i/f
> + * for the given csi
> + * @dev: pointer to fsd_csis_dev structure
> + * @reset: Reset enable/ disable
> + * Return: none
> + */
> +static void fsd_csis_dphy_reset(struct fsd_csis_dev *dev, bool reset)
> +{
> +	unsigned int dphy = 0, sw_resetn_dphy = 0x0;
> +
> +	/* There are 4 CSIs per each D-PHY i/f */
> +	dphy = dev->id / FSD_CSIS_NB_CSI_PER_PHY;
> +	regmap_read(dev->sysreg_map, SW_RESETEN_DPHY, &sw_resetn_dphy);
> +
> +	/*
> +	 * 0: reset
> +	 * 1: reset release
> +	 */
> +	if (reset)
> +		sw_resetn_dphy &= reset_bits(CSIS_SW_RESETEN_DPHY_MASK(dphy));
> +	else
> +		sw_resetn_dphy |= set_bits(CSIS_SW_RESETEN_DPHY, CSIS_SW_RESETEN_DPHY_MASK(dphy));
> +
> +	regmap_write(dev->sysreg_map, SW_RESETEN_DPHY, sw_resetn_dphy);
> +}
> +
> +/*
> + * fsd_csis_mipi_dphy_init() - initialize D-PHY slave rx parameters
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_mipi_dphy_init(struct fsd_csis_dev *dev)
> +{
> +	unsigned int dphy_sctrl = 0;
> +
> +	dphy_sctrl = readl(dev->base + PHY_SCTRL_H);
> +	dphy_sctrl &= reset_bits(SKEW_CAL_MAX_SKEW_CODE_CTRL_MASK | SKEW_CAL_EN_MASK);
> +	/* Enable Rx Skew calibration */
> +	dphy_sctrl |= set_bits(SKEW_CAL_EN, SKEW_CAL_EN_MASK);
> +	/* Set Rx Skew Calibratin to Max Code Control */
> +	dphy_sctrl |= set_bits(SKEW_CAL_MAX_SKEW_CODE_CTRL, SKEW_CAL_MAX_SKEW_CODE_CTRL_MASK);
> +	writel(dphy_sctrl, dev->base + PHY_SCTRL_H);
> +}
> +
> +/*
> + * fsd_csis_set_hs_settle() - set HSsettle[7:0] value for PHY
> + * @dev: pointer to fsd_csis_dev structure
> + * @hs_settle: HS-Rx Settle time
> + * Return: none
> + */
> +static void fsd_csis_set_hs_settle(struct fsd_csis_dev *dev, unsigned int hs_settle)
> +{
> +	u32 phy_cmn_ctrl;
> +
> +	phy_cmn_ctrl = readl(dev->base + PHY_CMN_CTRL);
> +	phy_cmn_ctrl &= reset_bits(HSSETTLE_MASK);
> +	phy_cmn_ctrl |= set_bits(hs_settle, HSSETTLE_MASK);
> +	writel(phy_cmn_ctrl, (dev->base + PHY_CMN_CTRL));
> +}
> +
> +/*
> + * fsd_csis_setclk_settle_ctl() - set slave clock lane settle time
> + * @dev: pointer to fsd_csis_dev structure
> + * @clksettlectl: T-CLK_SETTLE value
> + * Return: none
> + */
> +static void fsd_csis_setclk_settle_ctl(struct fsd_csis_dev *dev, unsigned int clksettlectl)
> +{
> +	u32 phy_cmn_ctrl;
> +
> +	phy_cmn_ctrl = readl(dev->base + PHY_CMN_CTRL);
> +	phy_cmn_ctrl &= reset_bits(S_CLKSETTLE_MASK);
> +	phy_cmn_ctrl |= set_bits(clksettlectl, S_CLKSETTLE_MASK);
> +	writel(phy_cmn_ctrl, (dev->base + PHY_CMN_CTRL));
> +}
> +
> +/*
> + * fsd_csis_enable_deskew_logic()- enable or disable DeSkew logic
> + * @dev: pointer to fsd_csis_dev structure
> + * @enable: boolean value enable = true/ disable = false
> + * Return: none
> + */
> +static void fsd_csis_enable_deskew_logic(struct fsd_csis_dev *dev, bool enable)
> +{
> +	u32 csis_cmn_ctrl;
> +
> +	/* CSIS de-skew logic */
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	csis_cmn_ctrl &= reset_bits(DESKEW_ENABLE_MASK);
> +
> +	if (enable)
> +		csis_cmn_ctrl |= set_bits(DESKEW_ENABLE, DESKEW_ENABLE_MASK);
> +	writel(csis_cmn_ctrl, (dev->base + CSIS_CMN_CTRL));
> +}
> +
> +/*
> + * fsd_csis_update_shadow_ctx() - update the CSI configuration
> + * @ctx: pointer to CSI context
> + * Return: none
> + */
> +static void fsd_csis_update_shadow_ctx(struct fsd_csis_ctx *ctx)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	u32 csis_cmn_ctrl, vc = ctx->virtual_channel;
> +
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	csis_cmn_ctrl |= set_bits(UPDATE_SHADOW, UPDATE_SHADOW_CH_MASK(vc));
> +	writel(csis_cmn_ctrl, (dev->base + CSIS_CMN_CTRL));
> +}
> +
> +/*
> + * fsd_csis_set_update_shadow_ctrl() - set the shadow registers update control
> + * @dev: pointer to csis device structure
> + * @update_shado_ctrl: boolean value to set or reset shadow control
> + * Return: none
> + */
> +static void fsd_csis_set_update_shadow_ctrl(struct fsd_csis_dev *dev, bool update)
> +{
> +	u32 csis_cmn_ctrl;
> +
> +	/* CSIS Update Shadow control */
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	csis_cmn_ctrl &= reset_bits(UPDATE_SHADOW_CTRL_MASK);
> +
> +	if (update)
> +		csis_cmn_ctrl |= set_bits(UPDATE_SHADOW_CTRL, UPDATE_SHADOW_CTRL_MASK);
> +	writel(csis_cmn_ctrl, (dev->base + CSIS_CMN_CTRL));
> +}
> +
> +/*
> + * fsd_csis_set_clkgate_trail() - set the trailing clocks for ISP i/f
> + * @ctx: csis context structure for this stream
> + * @clkgate_trail: number of trailing clocks
> + * Return: none
> + */
> +static void fsd_csis_set_clkgate_trail(struct fsd_csis_ctx *ctx, unsigned short clkgate_trail)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int csis_clk_ctrl, vc = ctx->virtual_channel;
> +
> +	csis_clk_ctrl = readl(dev->base + CSIS_CLK_CTRL);
> +	csis_clk_ctrl &= reset_bits(CLKGATE_TRAIL_MASK(vc));
> +	csis_clk_ctrl |= set_bits(clkgate_trail, CLKGATE_TRAIL_MASK(vc));
> +
> +	writel(csis_clk_ctrl, dev->base + CSIS_CLK_CTRL);
> +}
> +
> +/*
> + * fsd_csis_set_clkgate_en() - enable clock gating for Pixel clock
> + * @ctx: csis context structure for this stream
> + * @clk_gate_en: boolean value to enable or disable pixel clock gating
> + * Return: none
> + */
> +static void fsd_csis_set_clkgate_en(struct fsd_csis_ctx *ctx, bool clk_gate_en)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int csis_clk_ctrl, vc = ctx->virtual_channel;
> +
> +	csis_clk_ctrl = readl(dev->base + CSIS_CLK_CTRL);
> +	csis_clk_ctrl &= reset_bits(CLKGATE_EN_MASK(vc));
> +
> +	if (clk_gate_en)
> +		csis_clk_ctrl |= set_bits(CLKGATE_EN, CLKGATE_EN_MASK(vc));
> +
> +	writel(csis_clk_ctrl, dev->base + CSIS_CLK_CTRL);
> +}
> +
> +/*
> + * fsd_csis_set_vc_passing() - select the Virtual Channel for processing
> + * @ctx: csis context structure for this stream
> + * Return: none
> + */
> +static void fsd_csis_set_vc_passing(struct fsd_csis_ctx *ctx)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int vc_passing;
> +	unsigned int vc = ctx->virtual_channel;
> +
> +	vc_passing = readl(dev->base + VC_PASSING);
> +	vc_passing &= reset_bits(VC_PASSING_MASK);
> +	vc_passing |= set_bits(vc, VC_PASSING_MASK);
> +	vc_passing |= set_bits(VC_PASSING_ENABLE, VC_PASSING_ENABLE_MASK);
> +	writel(vc_passing, dev->base + VC_PASSING);
> +}
> +
> +/*
> + * fsd_csis_set_dma_clk() - set the number of trailing clocks for DMA clock gating
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_set_dma_clk(struct fsd_csis_dev *dev)
> +{
> +	unsigned int dma_clk_ctrl = 0x0;
> +
> +	dma_clk_ctrl = readl(dev->base + DMA_CLK_CTRL);
> +	dma_clk_ctrl &= reset_bits(DMA_CLK_GATE_EN_MASK);
> +	dma_clk_ctrl |= set_bits(DMA_CLK_GATE_TRAIL, DMA_CLK_GATE_TRAIL_MASK);
> +	writel(dma_clk_ctrl, dev->base + DMA_CLK_CTRL);
> +}
> +
> +/*
> + * fsd_csis_sw_reset() - Soft reset the CSI instance
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_sw_reset(struct fsd_csis_dev *dev)
> +{
> +	u32 csis_cmn_ctrl = 0;
> +
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +
> +	/* Disable CSI first */
> +	csis_cmn_ctrl &= reset_bits(CSI_EN_MASK);
> +	writel(csis_cmn_ctrl, dev->base + CSIS_CMN_CTRL);
> +
> +	/* SW Reset CSI */
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	csis_cmn_ctrl |= set_bits(SW_RESET, SW_RESET_MASK);
> +
> +	while (csis_cmn_ctrl & SW_RESET_MASK) {
> +		writel(csis_cmn_ctrl, dev->base + CSIS_CMN_CTRL);
> +		usleep_range(1000, 2000); /* Wait min 10ms, max 20ms */
> +		csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	}
> +}
> +
> +/*
> + * fsd_csis_set_num_of_datalane() - Configure the number of data lanes for use
> + * @dev: pointer to fsd_csis_dev structure
> + * @nb_data_lane: number of data lanes to configure
> + * Return: 0 or -EINVAL
> + */
> +static int fsd_csis_set_num_of_datalane(struct fsd_csis_dev *dev, unsigned int nb_data_lane)
> +{
> +	u32 csis_cmn_ctrl = 0, csis_nb_lane = nb_data_lane - 1;
> +
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	csis_cmn_ctrl &= reset_bits(LANE_NUMBER_MASK);
> +
> +	switch (csis_nb_lane) {
> +	case DATALANE0:
> +	case DATALANE1:
> +	case DATALANE2:
> +	case DATALANE3:
> +		csis_cmn_ctrl |= set_bits(csis_nb_lane, LANE_NUMBER_MASK);
> +		break;
> +	default:
> +		fsd_csis_err(dev, "Wrong number of data lanes %d to configure!\n", nb_data_lane);
> +		return -EINVAL;
> +	}
> +	writel(csis_cmn_ctrl, dev->base + CSIS_CMN_CTRL);
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_set_phy_on() - turn on or off the PHY
> + * @dev: pointer to fsd_csis_dev structure
> + * @nb_data_lane: number of data lanes in use by this CSI instance
> + * Return: none
> + */
> +static void fsd_csis_set_phy_on(struct fsd_csis_dev *dev, unsigned int nb_data_lane)
> +{
> +	u32 phy_cmn_ctrl;
> +
> +	phy_cmn_ctrl = readl(dev->base + PHY_CMN_CTRL);
> +	phy_cmn_ctrl &= reset_bits((ENABLE_DAT_MASK | S_BYTE_CLK_ENABLE_MASK | ENABLE_CLK_MASK));
> +	phy_cmn_ctrl |= set_bits(ENABLE_DAT(nb_data_lane), ENABLE_DAT_MASK);
> +	phy_cmn_ctrl |= set_bits(S_BYTE_CLK_ENABLE, S_BYTE_CLK_ENABLE_MASK);
> +	phy_cmn_ctrl |= set_bits(ENABLE_CLK, ENABLE_CLK_MASK);
> +	writel(phy_cmn_ctrl, dev->base + PHY_CMN_CTRL);
> +
> +	fsd_csis_dbg(3, dev, "Data lane %d phy_cmn_ctrl %x\n", nb_data_lane, phy_cmn_ctrl);
> +}
> +
> +/*
> + * fsd_csis_set_pixel_mode() - set pixel i/f OTF mode
> + * to single/dual/quad/octa pixel mode
> + * @ctx: pointer to CSI context
> + * @vc: virtual channel id
> + * @fmt: image format information
> + * Return: none
> + */
> +static void fsd_csis_set_pixel_mode(struct fsd_csis_ctx *ctx, unsigned int vc,
> +				    const struct fsd_csis_fmt *fmt)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int fourcc = fmt->fourcc;
> +	u32 isp_config_ch;
> +	unsigned int pixel_mode;
> +
> +	switch (fourcc) {
> +	case V4L2_PIX_FMT_SBGGR8:
> +	case V4L2_PIX_FMT_SGBRG8:
> +	case V4L2_PIX_FMT_SGRBG8:
> +	case V4L2_PIX_FMT_SRGGB8:
> +	case V4L2_PIX_FMT_YUYV:
> +	case V4L2_PIX_FMT_BGR666:
> +	case V4L2_PIX_FMT_RGB24:
> +		pixel_mode = QUAD_PIXEL_MODE;
> +		break;
> +	case V4L2_PIX_FMT_SBGGR10:
> +	case V4L2_PIX_FMT_SGBRG10:
> +	case V4L2_PIX_FMT_SGRBG10:
> +	case V4L2_PIX_FMT_SRGGB10:
> +	case V4L2_PIX_FMT_SBGGR12:
> +	case V4L2_PIX_FMT_SGBRG12:
> +	case V4L2_PIX_FMT_SGRBG12:
> +	case V4L2_PIX_FMT_SRGGB12:
> +	case V4L2_PIX_FMT_RGB565:
> +		pixel_mode = OCTA_PIXEL_MODE;
> +		break;
> +	default:
> +		pixel_mode = SINGLE_PIXEL_MODE;
> +		break;
> +	}
> +
> +	fsd_csis_ctx_dbg(3, ctx, "Selected PIXEL_MODE: %u\n", pixel_mode);
> +	isp_config_ch = readl(dev->base + ISP_CONFIG_CH0 + ISP_CH_OFFSET * vc);
> +	isp_config_ch &= reset_bits(PIXEL_MODE_MASK);
> +	isp_config_ch |= set_bits(pixel_mode, PIXEL_MODE_MASK);
> +	writel(isp_config_ch, dev->base + ISP_CONFIG_CH0 + ISP_CH_OFFSET * vc);
> +}
> +
> +/*
> + * fsd_csis_set_paralle_mode() - configure pixel alignmnet for OTF i/f
> + * @ctx: pointer to CSI context
> + * @data_align: parallel mode value indicating alignment
> + * Return: none
> + */
> +static void fsd_csis_set_paralle_mode(struct fsd_csis_ctx *ctx,
> +				      enum FSD_CSIS_PARALLEL_MODE data_align)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	u32 isp_config_ch, vc = ctx->virtual_channel;
> +
> +	isp_config_ch = readl(dev->base + ISP_CONFIG_CH0 + ISP_CH_OFFSET * vc);
> +	isp_config_ch &= reset_bits(PARALLEL_MODE_MASK);
> +	isp_config_ch |= set_bits(data_align, PARALLEL_MODE_MASK);
> +	writel(isp_config_ch, dev->base + ISP_CONFIG_CH0 + ISP_CH_OFFSET * vc);
> +}
> +
> +/*
> + * fsd_csis_set_img_fmt() - configure selected image format for streaming
> + * @ctx: pointer to CSI context
> + * @vc: virtual channel id
> + * @fmt: format to configure
> + * Return: none
> + */
> +static void fsd_csis_set_img_fmt(struct fsd_csis_ctx *ctx, unsigned int vc,
> +				 const struct fsd_csis_fmt *fmt)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int isp_config_ch, fourcc = fmt->fourcc;
> +
> +	isp_config_ch = readl(dev->base + ISP_CONFIG_CH0 + ISP_CH_OFFSET * vc);
> +	isp_config_ch &= reset_bits(DATAFORMAT_MASK);
> +
> +	switch (fourcc) {
> +	case V4L2_PIX_FMT_RGB565:
> +		/* RGB565 */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RGB565, DATAFORMAT_MASK);
> +		break;
> +	case V4L2_PIX_FMT_BGR666:
> +		/* RGB666 */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RGB666, DATAFORMAT_MASK);
> +		break;
> +	case V4L2_COLORSPACE_SRGB:
> +	case V4L2_PIX_FMT_XRGB32:
> +	case V4L2_PIX_FMT_RGB24:
> +	case V4L2_PIX_FMT_RGB32:
> +		/* RGB888 */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RGB888, DATAFORMAT_MASK);
> +		break;
> +	case V4L2_PIX_FMT_YUYV:
> +	case V4L2_PIX_FMT_UYVY:
> +		/* YUYV-16/YUV422-8, UYVY-16 / YUV 422 */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_YUV422_8, DATAFORMAT_MASK);
> +		fsd_csis_set_paralle_mode(ctx, FSD_CSIS_PARALLEL_MODE_OFF);
> +		break;
> +	case V4L2_PIX_FMT_SGBRG8:
> +	case V4L2_PIX_FMT_SGRBG8:
> +	case V4L2_PIX_FMT_SRGGB8:
> +		/* SGBRG8 / RAW8*/
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RAW8, DATAFORMAT_MASK);
> +		break;
> +	case V4L2_PIX_FMT_SBGGR10:
> +	case V4L2_PIX_FMT_SGBRG10:
> +	case V4L2_PIX_FMT_SGRBG10:
> +	case V4L2_PIX_FMT_SRGGB10:
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RAW10, DATAFORMAT_MASK);
> +		break;
> +	case V4L2_PIX_FMT_SBGGR12:
> +	case V4L2_PIX_FMT_SGBRG12:
> +	case V4L2_PIX_FMT_SGRBG12:
> +	case V4L2_PIX_FMT_SRGGB12:
> +		/* SRGGB12, SGRBG12, SGBRG12, SBGGR12 / RAW-12 */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RAW12, DATAFORMAT_MASK);
> +		fsd_csis_set_paralle_mode(ctx, FSD_CSIS_PARALLEL_MODE_OFF);
> +		break;
> +	case V4L2_PIX_FMT_SBGGR14P:
> +	case V4L2_PIX_FMT_SGBRG14P:
> +	case V4L2_PIX_FMT_SGRBG14P:
> +	case V4L2_PIX_FMT_SRGGB14P:
> +		/* SBGGR14, SGBRG14, SGRRBG14, SRGGB14 / RAW14 */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RAW14, DATAFORMAT_MASK);
> +		break;
> +	case V4L2_PIX_FMT_SGBRG16:
> +	case V4L2_PIX_FMT_SGRBG16:
> +	case V4L2_PIX_FMT_SRGGB16:
> +		/* SGBRG16, SGRBG16, SRGGB16 / RAW16 */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_RAW16, DATAFORMAT_MASK);
> +		break;
> +	case V4L2_PIX_FMT_JPEG:
> +		/* JPEG */
> +		isp_config_ch |= set_bits(ISP_DATA_FORMAT_USER_DEFINED_2, DATAFORMAT_MASK);
> +		break;
> +	default:
> +		fsd_csis_ctx_err(ctx, "image format %x not supported\n", fourcc);
> +		break;
> +	}
> +
> +	isp_config_ch &= reset_bits(VIRTUAL_CHANNEL_MASK);
> +	isp_config_ch |= set_bits(vc, VIRTUAL_CHANNEL_MASK);
> +	writel(isp_config_ch, dev->base + ISP_CONFIG_CH0 + ISP_CH_OFFSET * vc);
> +	fsd_csis_ctx_dbg(3, ctx, "format %x set\n", fourcc);
> +}
> +
> +/*
> + * fsd_csis_set_resolution() - configure selected resolution for streaming
> + * @ctx: pointer to CSI context
> + * @vc: virtual channel id
> + * @width: horizontal image resolution
> + * @height: vertical image resolution
> + * Return: none
> + */
> +static void fsd_csis_set_resolution(struct fsd_csis_ctx *ctx, unsigned int vc, unsigned int width,
> +				    unsigned int height)
> +{
> +	u32 isp_resol_ch = 0;
> +	struct fsd_csis_dev *dev = ctx->dev;
> +
> +	isp_resol_ch &= reset_bits((HRESOL_MASK | VRESOL_MASK));
> +	isp_resol_ch |= set_bits(width, HRESOL_MASK);
> +	isp_resol_ch |= set_bits(height, VRESOL_MASK);
> +	writel(isp_resol_ch, dev->base + ISP_RESOL_CH0 + ISP_CH_OFFSET * vc);
> +	fsd_csis_ctx_dbg(3, ctx, "resolution %08dx%08d set\n", width, height);
> +}
> +
> +/*
> + * fsd_csis_format_size() - set image size for selected resolution
> + * @ctx: pointer to CSI context
> + * @fmt: image format
> + * @f: format whose size to be updated
> + * Return: 0
> + */
> +static int fsd_csis_format_size(struct fsd_csis_ctx *ctx, const struct fsd_csis_fmt *fmt,
> +				struct v4l2_format *f)
> +{
> +	if (!fmt) {
> +		fsd_csis_ctx_err(ctx, "No format provided\n");
> +		return -EINVAL;
> +	}
> +
> +	v4l_bound_align_image(&f->fmt.pix.width, FSD_CSIS_WMIN, FSD_CSIS_WMAX, FSD_CSIS_WALIGN,
> +			      &f->fmt.pix.height, FSD_CSIS_HMIN, FSD_CSIS_HMAX, FSD_CSIS_HALIGN,
> +			      FSD_CSIS_SALIGN);
> +
> +	f->fmt.pix.bytesperline = bytes_per_line(f->fmt.pix.width, fmt->depth);
> +	f->fmt.pix.sizeimage = f->fmt.pix.height * f->fmt.pix.bytesperline;
> +	fsd_csis_set_resolution(ctx, ctx->virtual_channel, f->fmt.pix.width, f->fmt.pix.height);
> +
> +	fsd_csis_ctx_dbg(3, ctx, "fourcc %s width %d height %d bpl %d img size %d set\n",
> +			 fourcc_to_str(f->fmt.pix.pixelformat), f->fmt.pix.width, f->fmt.pix.height,
> +			 f->fmt.pix.bytesperline, f->fmt.pix.sizeimage);
> +
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_set_hsync_lintv_timing() - set Hsync_Lintv value for CSI
> + * @ctx: pointer to CSI context
> + * @vc: virtual channel id
> + * @hsync_lintv: interval between last falling of DVALID and falling of HSYNC
> + * Return: none
> + */
> +static void fsd_csis_set_hsync_lintv_timing(struct fsd_csis_ctx *ctx, unsigned int vc,
> +					    unsigned int hsync_lintv)
> +{
> +	u32 isp_sync_ch;
> +	struct fsd_csis_dev *dev = ctx->dev;
> +
> +	isp_sync_ch = readl(dev->base + ISP_SYNC_CH0 + ISP_CH_OFFSET * vc);
> +	isp_sync_ch &= reset_bits(HSYNC_LINTV_MASK);
> +	isp_sync_ch |= set_bits(hsync_lintv, HSYNC_LINTV_MASK);
> +	writel(isp_sync_ch, dev->base + ISP_SYNC_CH0 + ISP_CH_OFFSET * vc);
> +}
> +
> +/*
> + * fsd_csis_set_pack() - select DMA memory storing style
> + * @dev: pointer to fsd_csis_dev structure
> + * @vc: virtual channel id
> + * @dma_pack: 1: Memory storing style is 1 dimension/ 0: 2 Dimension
> + * Return: none
> + */
> +static void fsd_csis_set_pack(struct fsd_csis_dev *dev, u32 vc, enum FSD_CSIS_DMA_PACK dma_pack)
> +{
> +	u32 dma_fmt;
> +
> +	dma_fmt = readl(dev->base + DMA0_FMT + vc * DMA_ADDR_OFFSET);
> +	dma_fmt &= reset_bits(ACTIVE_DMA_PACK_MASK);
> +	dma_fmt |= set_bits(dma_pack, ACTIVE_DMA_PACK_MASK);
> +	writel(dma_fmt, dev->base + DMA0_FMT + vc * DMA_ADDR_OFFSET);
> +}
> +
> +/*
> + * fsd_csis_set_dma_dump() - set DMA dump OTF output without realigning
> + * @dev: pointer to fsd_csis_dev structure
> + * @vc: virtual channel id
> + * @set_dump: boolean value enable = true/ disable = false
> + * Return: none
> + */
> +static void fsd_csis_set_dma_dump(struct fsd_csis_dev *dev, unsigned int vc, bool set_dump)
> +{
> +	u32 dma_fmt;
> +
> +	dma_fmt = readl(dev->base + DMA0_FMT + vc * DMA_ADDR_OFFSET);
> +	dma_fmt &= reset_bits(DMA_DUMP_MASK);
> +
> +	if (set_dump)
> +		dma_fmt |= set_bits(DMA_DUMP_OTF, DMA_DUMP_MASK);
> +
> +	writel(dma_fmt, dev->base + DMA0_FMT + vc * DMA_ADDR_OFFSET);
> +}
> +
> +/*
> + * fsd_csis_set_dma_dimension() - set DMA memory storing style
> + * @dev: pointer to fsd_csis_dev structure
> + * @vc: virtual channel id
> + * @set_dim: 0: Normal (2D DMA)/ 1: 1D DMA
> + * Return: none
> + */
> +static void fsd_csis_set_dma_dimension(struct fsd_csis_dev *dev, unsigned int vc, bool set_dim)
> +{
> +	u32 dma_fmt;
> +
> +	dma_fmt = readl(dev->base + DMA0_FMT + vc * DMA_ADDR_OFFSET);
> +	dma_fmt &= reset_bits(ACTIVE_DMA_DIM_MASK);
> +
> +	if (set_dim)
> +		dma_fmt |= set_bits(DMA_DIM_1D, ACTIVE_DMA_DIM_MASK);
> +
> +	writel(dma_fmt, dev->base + DMA0_FMT + vc * DMA_ADDR_OFFSET);
> +}
> +
> +/*
> + * fsd_csis_set_dma_format() - set DMA format based
> + * on selected image format
> + * @ctx: pointer to CSI context
> + * @fmt: image format
> + * Return: none
> + */
> +static void fsd_csis_set_dma_format(struct fsd_csis_ctx *ctx, const struct fsd_csis_fmt *fmt)
> +{
> +	unsigned int fourcc = fmt->fourcc;
> +
> +	switch (fourcc) {
> +	case V4L2_PIX_FMT_SBGGR10:
> +	case V4L2_PIX_FMT_SGBRG10:
> +	case V4L2_PIX_FMT_SGRBG10:
> +	case V4L2_PIX_FMT_SRGGB10:
> +		fsd_csis_set_pack(ctx->dev, ctx->virtual_channel, DMA_PACK_10);
> +		break;
> +	case V4L2_PIX_FMT_SBGGR12:
> +	case V4L2_PIX_FMT_SGBRG12:
> +	case V4L2_PIX_FMT_SGRBG12:
> +	case V4L2_PIX_FMT_SRGGB12:
> +		fsd_csis_set_pack(ctx->dev, ctx->virtual_channel, DMA_PACK_12);
> +		break;
> +	case V4L2_PIX_FMT_SBGGR14P:
> +		fsd_csis_set_pack(ctx->dev, ctx->virtual_channel, DMA_PACK_14);
> +		break;
> +	case V4L2_PIX_FMT_BGR666:
> +		fsd_csis_set_pack(ctx->dev, ctx->virtual_channel, DMA_PACK_18);
> +		break;
> +	default:
> +		/* Default DMA_PACK_NORMAL will be used */
> +		break;
> +	}
> +
> +	fsd_csis_set_dma_dump(ctx->dev, ctx->virtual_channel, false);
> +	fsd_csis_set_dma_dimension(ctx->dev, ctx->virtual_channel, false);
> +}
> +
> +/*
> + * fsd_csis_dma_enable() - enable/disable DMA
> + * @ctx: pointer to CSI context
> + * @en_dma: boolean value enable = true/ disable = false
> + * Return: none
> + */
> +static void fsd_csis_dma_enable(struct fsd_csis_ctx *ctx, bool en_dma)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int dma_ctrl, vc = ctx->virtual_channel;
> +
> +	dma_ctrl = readl(dev->base + DMA0_CTRL + DMA_CH_OFFSET * vc);
> +	/* DMA disable = 'b1, enable = 'b0 */
> +	dma_ctrl |= set_bits(DMA_DISABLE, DMA_DISABLE_MASK);
> +
> +	if (en_dma)
> +		dma_ctrl &= reset_bits(DMA_DISABLE_MASK);
> +	writel(dma_ctrl, dev->base + DMA0_CTRL + DMA_CH_OFFSET * vc);
> +}
> +
> +/*
> + * fsd_csis_set_interleave_mode() - set interleaving mode
> + * @dev: pointer to fsd_csis_dev structure
> + * @fsd_csis_interleave_mode: interleave mode value
> + * Return: none
> + */
> +static void fsd_csis_set_interleave_mode(struct fsd_csis_dev *dev,
> +					 enum FSD_CSIS_INTERLEAVE csis_interleave_mode)
> +{
> +	u32 csis_cmn_ctrl;
> +
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	csis_cmn_ctrl &= reset_bits(INTERLEAVE_MODE_MASK);
> +	csis_cmn_ctrl |= set_bits(csis_interleave_mode, INTERLEAVE_MODE_MASK);
> +	writel(csis_cmn_ctrl, dev->base + CSIS_CMN_CTRL);
> +}
> +
> +/*
> + * fsd_csis_enable_irqs_for_ctx() - enable interrupts for CSI context
> + * @ctx: pointer to CSI context
> + * Return: none
> + */
> +static void fsd_csis_enable_irqs_for_ctx(struct fsd_csis_ctx *ctx)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int int_mask, vc = ctx->virtual_channel;
> +
> +	int_mask = readl(dev->base + CSIS_INT_MSK0);
> +	int_mask |= set_bits(ERR_SOT_HS_ENABLE, ERR_SOT_HS_CH_MASK(vc));
> +	int_mask |= set_bits(ERR_LOST_FS_ENABLE, ERR_LOST_FS_CH_MASK(vc));
> +	int_mask |= set_bits(ERR_LOST_FE_ENABLE, ERR_LOST_FE_CH_MASK(vc));
> +	writel(int_mask, dev->base + CSIS_INT_MSK0);
> +
> +	int_mask = readl(dev->base + CSIS_INT_MSK1);
> +	int_mask |= set_bits(DMA_OTF_OVERLAP_ENABLE, DMA_OTF_OVERLAP_CH_MASK(vc));
> +	int_mask |= set_bits(DMA_FRM_END_ENABLE, DMA_FRM_END_CH_MASK(vc));
> +	int_mask |= set_bits(DMA_ABORT_ENABLE, DMA_ABORT_DONE_MASK);
> +	int_mask |= set_bits(DMA_ERROR_ENABLE, DMA_ERROR_MASK);
> +	writel(int_mask, dev->base + CSIS_INT_MSK1);
> +}
> +
> +/*
> + * fsd_csis_disable_irqs_for_ctx() - disable interrupts for CSI context
> + * @ctx: pointer to CSI context
> + * Return: none
> + */
> +static void fsd_csis_disable_irqs_for_ctx(struct fsd_csis_ctx *ctx)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int int_mask, vc = ctx->virtual_channel;
> +
> +	int_mask = readl(dev->base + CSIS_INT_MSK0);
> +	int_mask &= reset_bits(FRAMESTART_CH_MASK(vc));
> +	int_mask &= reset_bits(FRAMEEND_CH_MASK(vc));
> +	int_mask &= reset_bits(ERR_SOT_HS_CH_MASK(vc));
> +	int_mask &= reset_bits(ERR_LOST_FS_CH_MASK(vc));
> +	int_mask &= reset_bits(ERR_LOST_FE_CH_MASK(vc));
> +	writel(int_mask, dev->base + CSIS_INT_MSK0);
> +
> +	int_mask = readl(dev->base + CSIS_INT_MSK1);
> +	int_mask &= reset_bits(DMA_OTF_OVERLAP_CH_MASK(vc));
> +	int_mask &= reset_bits(DMA_FRM_END_CH_MASK(vc));
> +	int_mask &= reset_bits(LINE_END_CH_MASK(vc));
> +	int_mask &= reset_bits(DMA_ABORT_DONE_MASK);
> +	int_mask &= reset_bits(DMA_ERROR_MASK);
> +	writel(int_mask, dev->base + CSIS_INT_MSK1);
> +}
> +
> +/*
> + * fsd_csis_dma_set_vid_base_addr() - set the DMA address for streaming
> + * @ctx: pointer to CSI context
> + * @frm_no: frame number for which DMA address to be set
> + * @addr: address to use by CSI DMA
> + * Return: none
> + */
> +static void fsd_csis_dma_set_vid_base_addr(struct fsd_csis_ctx *ctx, int frm_no, unsigned long addr)
> +{
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	unsigned int vc = ctx->virtual_channel;
> +	unsigned int dma_addr = 0;
> +
> +	dma_addr = DMA0_ADDR1 + DMA_CH_OFFSET * vc;
> +	dma_addr = dma_addr + (frm_no * 4);
> +	mutex_lock(&dev->mutex_csis_dma_reg);
> +	writel(addr, dev->base + dma_addr);
> +	mutex_unlock(&dev->mutex_csis_dma_reg);
> +}
> +
> +/*
> + * fsd_csis_ip_configure() - configure CSI instance for streaming
> + * @ctx: pointer to fsd_csis_ctx structure
> + * Return: 0 on success. error value otherwise
> + */
> +static void fsd_csis_ip_configure(struct fsd_csis_ctx *ctx)
> +{
> +	unsigned int i;
> +	struct fsd_csis_dev *dev;
> +
> +	dev = ctx->dev;
> +	/*
> +	 * Caution: CSI is reset every time during configuration
> +	 * as recommended by initialization sequence.
> +	 * In multi-stream scenario, reset should be avoided and
> +	 * only format related configuration should be done
> +	 */
> +	fsd_csis_dphy_reset(dev, true);
> +	fsd_csis_sw_reset(dev);
> +	fsd_csis_mipi_dphy_init(dev);
> +	fsd_csis_set_vc_passing(ctx);
> +
> +	if (!dev->nb_data_lane)
> +		dev->nb_data_lane = ctx->endpoint.bus.mipi_csi2.num_data_lanes;
> +	fsd_csis_set_interleave_mode(dev, VC_DT_BOTH);
> +	fsd_csis_set_update_shadow_ctrl(dev, true);
> +
> +	/* DeSkew logic is needed when data lane speed is above or equal to 1500Mbps */
> +	if (dev->lane_speed >= 1500)
> +		fsd_csis_enable_deskew_logic(dev, true);
> +	fsd_csis_set_hs_settle(dev, S_HSSETTLECTL_VAL);
> +	fsd_csis_setclk_settle_ctl(dev, S_CLKSETTLECTL_VAL);
> +	fsd_csis_set_num_of_datalane(dev, dev->nb_data_lane);
> +
> +	for (i = 0; i < FSD_CSIS_MAX_VC; i++) {
> +		if (dev->ctx[i]) {
> +			fsd_csis_set_clkgate_en(dev->ctx[i], true);
> +			fsd_csis_set_clkgate_trail(dev->ctx[i], CLKGATE_TRAIL_VAL);
> +		}
> +	}
> +
> +	fsd_csis_set_phy_on(dev, dev->nb_data_lane);
> +
> +	for (i = 0; i < FSD_CSIS_MAX_VC; i++) {
> +		struct fsd_csis_ctx *temp_ctx = ctx->dev->ctx[i];
> +
> +		if (temp_ctx) {
> +			fsd_csis_set_pixel_mode(temp_ctx, temp_ctx->virtual_channel, temp_ctx->fmt);
> +			fsd_csis_set_img_fmt(temp_ctx, temp_ctx->virtual_channel, temp_ctx->fmt);
> +			fsd_csis_format_size(temp_ctx, temp_ctx->fmt, &temp_ctx->v_fmt);
> +			fsd_csis_set_hsync_lintv_timing(temp_ctx, temp_ctx->virtual_channel,
> +							HSYNC_LINTV);
> +			fsd_csis_set_dma_format(temp_ctx, temp_ctx->fmt);
> +			fsd_csis_update_shadow_ctx(temp_ctx);
> +			fsd_csis_dma_enable(temp_ctx, false);
> +		}
> +	}
> +
> +	fsd_csis_set_dma_clk(dev);
> +	fsd_csis_dphy_reset(dev, false);
> +	fsd_csis_clear_vid_irqs(dev);
> +
> +	for (i = 0; i < FSD_CSIS_MAX_VC; i++) {
> +		struct fsd_csis_ctx *temp_ctx = ctx->dev->ctx[i];
> +
> +		if (temp_ctx && ctx_stream_enabled(temp_ctx))
> +			fsd_csis_enable_irqs_for_ctx(temp_ctx);
> +	}
> +}
> +
> +/*
> + * fsd_csis_irq_handler() - interrupt handler for CSI instance
> + * @irq_csis: interrupt number of this CSI instance
> + * @data: device structure of the CSI instance
> + * Return: IRQ_HANDLED
> + */
> +static irqreturn_t fsd_csis_irq_handler(int irq_csis, void *data)
> +{
> +	struct fsd_csis_dev *dev;
> +	struct fsd_csis_ctx *ctx;
> +	int vc;
> +	unsigned int int_src0 = 0x0, int_src1 = 0x0;
> +	unsigned int dma_frame_end = 0x0;
> +	unsigned int dma_frame_end_vc = 0x0;
> +	unsigned int int0_err = 0x0, int1_err = 0x0;
> +	unsigned int dma_error_code = 0x0, dma_error_vc = 0;
> +
> +	dev = data;
> +	int_src0 = readl(dev->base + CSIS_INT_SRC0);
> +	int_src1 = readl(dev->base + CSIS_INT_SRC1);
> +	int0_err = get_bits(int_src0, CSIS_INT_SRC0_ERR_ALL_MASK);
> +	int1_err = get_bits(int_src1, CSIS_INT_SRC1_ERR_ALL_MASK);
> +	dma_frame_end = get_bits(int_src1, DMA_FRM_END_MASK);
> +
> +	if (dma_frame_end || int1_err) {
> +		for (vc = 0; vc < FSD_CSIS_MAX_VC; vc++) {
> +			dma_frame_end_vc = (dma_frame_end >> vc) & 0x01;
> +			ctx = dev->ctx[vc];
> +
> +			if (ctx) {
> +				if (int1_err) {
> +					dma_error_vc = get_bits(int_src1,
> +								DMA_OTF_OVERLAP_CH_MASK(vc));
> +					if (get_bits(int_src1, DMA_ERROR_MASK)) {
> +						dma_error_code = get_bits(int_src1, DMA_ERR_CODE);
> +						dma_error_vc |= get_bits(dma_error_code,
> +									 (DMAFIFO_FULL_MASK |
> +									  TRXFIFO_FULL_MASK));
> +						dma_error_vc |= get_bits(dma_error_code,
> +									 BRESP_ERROR_CH_MASK(vc));
> +					}
> +				}
> +
> +				if (dma_frame_end_vc || dma_error_vc) {
> +					ctx->dma_error = dma_error_vc;
> +					schedule_work(&ctx->csis_ctx_work);
> +				}
> +			}
> +		}
> +	}
> +
> +	if (int0_err)
> +		fsd_csis_dbg(1, dev, "CSIS_INT_SRC0 ERRORS OCCURRED!: %08x\n", int0_err);
> +
> +	if (int1_err)
> +		fsd_csis_dbg(1, dev, "DMA ERRORS OCCURRED!: %08x\n", int1_err);
> +
> +	/* clear the interrupts */
> +	writel(int_src0, dev->base + CSIS_INT_SRC0);
> +	writel(int_src1, dev->base + CSIS_INT_SRC1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * fsd_csis_add_to_ring_buffer() - add vb2 buffer to DMA
> + * @ctx: pointer to CSI context
> + * @buf: pointer to fsd_csis_buffer structure
> + * @index: index of DMA buffer address
> + * Return: none
> + */
> +static void fsd_csis_add_to_ring_buffer(struct fsd_csis_ctx *ctx,
> +					struct fsd_csis_buffer *buf, u8 index)
> +{
> +	ctx->frame[index] = buf;
> +	ctx->frame_addr[index] = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> +	fsd_csis_dma_set_vid_base_addr(ctx, index, ctx->frame_addr[index]);
> +}
> +
> +/*
> + * fsd_csis_irq_worker() - worker thread processing receieved image in DMA
> + * @work: pointer to work_struct
> + * Return: none
> + */
> +static void fsd_csis_irq_worker(struct work_struct *work)
> +{
> +	struct fsd_csis_ctx *ctx =
> +		container_of(work, struct fsd_csis_ctx, csis_ctx_work);
> +	struct fsd_csis_buffer *buf_from;
> +	struct fsd_csis_buffer *buf_to;
> +	struct fsd_csis_dmaqueue *vidq = &ctx->vidq;
> +	unsigned int i;
> +
> +	if (atomic_read(&ctx->end_irq_worker) == 0)
> +		return;
> +
> +	ctx->current_dma_ptr = fsd_csis_current_dma_ptr(ctx);
> +	ctx->current_frame_counter = fsd_csis_current_frame_counter(ctx);
> +
> +	if (ctx->dma_error) {
> +		ctx->prev_dma_ptr = ctx->current_dma_ptr;
> +		goto update_prev_counters;
> +	}
> +
> +	if (ctx->current_dma_ptr >= ctx->prev_dma_ptr)
> +		ctx->number_of_ready_bufs = ctx->current_dma_ptr - ctx->prev_dma_ptr;
> +	else
> +		ctx->number_of_ready_bufs = FSD_CSIS_NB_DMA_OUT_CH - ctx->prev_dma_ptr +
> +					    ctx->current_dma_ptr;
> +
> +	for (i = 0; i < ctx->number_of_ready_bufs; i++) {
> +		ctx->prev_dma_ptr = (ctx->prev_dma_ptr + 1) % FSD_CSIS_NB_DMA_OUT_CH;
> +
> +		mutex_lock(&ctx->mutex_buf);
> +
> +		/*
> +		 * Before dequeuing buffer from DMA at least
> +		 * one buffer should be ready in vb2_queue
> +		 */
> +		if (list_empty(&vidq->active)) {
> +			mutex_unlock(&ctx->mutex_buf);
> +			fsd_csis_ctx_info(ctx, "active buffer queue empty\n");
> +			ctx->prev_dma_ptr = ctx->current_dma_ptr;
> +			goto update_prev_counters;
> +
> +		} else {
> +			buf_from = list_entry(vidq->active.next, struct fsd_csis_buffer, list);
> +			list_del(&buf_from->list);
> +		}
> +
> +		mutex_unlock(&ctx->mutex_buf);
> +		buf_to = ctx->frame[ctx->prev_dma_ptr];
> +		fsd_csis_add_to_ring_buffer(ctx, buf_from, ctx->prev_dma_ptr);
> +
> +		if (buf_to) {
> +			buf_to->vb.vb2_buf.timestamp = ktime_get_ns();
> +			vb2_buffer_done(&buf_to->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +		} else {
> +			fsd_csis_ctx_err(ctx, "DMA buffer pointer is not valid\n");
> +		}
> +	}
> +
> +update_prev_counters:
> +	ctx->prev_frame_counter = ctx->current_frame_counter;
> +}
> +
> +/*
> + * fsd_csis_ip_s_ctrl() - set new control value for CSI v4l2 device
> + * @ctrl: pointer to control value passed by user
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_ip_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct fsd_csis_dev *dev =
> +		container_of(ctrl->handler, struct fsd_csis_dev, ctrl_handler);
> +	int ret = 0;
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_USER_FSD_CSIS_NO_OF_LANE:
> +
> +		dev->nb_data_lane = ctrl->val;
> +		if (!dev->stream_enabled)
> +			ret = fsd_csis_set_num_of_datalane(dev, dev->nb_data_lane);
> +		else
> +			ret = -EBUSY;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * fsd_csis_enable() - enable CSI instance
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_enable(struct fsd_csis_dev *dev)
> +{
> +	u32 csis_cmn_ctrl = 0;
> +
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +	csis_cmn_ctrl |= set_bits(CSI_EN, CSI_EN_MASK);
> +	writel(csis_cmn_ctrl, (dev->base + CSIS_CMN_CTRL));
> +
> +	fsd_csis_enable_vid_irqs(dev);
> +}
> +
> +/*
> + * fsd_csis_disable() - disable CSI instance
> + * @dev: pointer to fsd_csis_dev structure
> + * Return: none
> + */
> +static void fsd_csis_disable(struct fsd_csis_dev *dev)
> +{
> +	u32 csis_cmn_ctrl = 0, i;
> +
> +	for (i = 0; i < FSD_CSIS_MAX_VC; i++) {
> +		if (dev->ctx[i])
> +			fsd_csis_dma_enable(dev->ctx[i], false);
> +	}
> +
> +	csis_cmn_ctrl = readl(dev->base + CSIS_CMN_CTRL);
> +
> +	/* Disable CSI */
> +	csis_cmn_ctrl &= reset_bits(CSI_EN_MASK);
> +	writel(csis_cmn_ctrl, (dev->base + CSIS_CMN_CTRL));
> +}
> +
> +/*
> + * find_format_by_pix() - find matching fourcc value of
> + * context for given v4l2 pixel format
> + * @ctx: pointer to CSI context
> + * @pixelformat: pixel format to find
> + * Return: pointer to csi_fmt on success, NULL otherwise
> + */
> +static const struct fsd_csis_fmt *find_format_by_pix(struct fsd_csis_ctx *ctx,
> +						     unsigned int pixelformat)
> +{
> +	const struct fsd_csis_fmt *fmt;
> +	unsigned int i;
> +
> +	for (i = 0; i < ctx->num_active_fmt; i++) {
> +		fmt = ctx->active_fmt[i];
> +
> +		if (fmt->fourcc == pixelformat)
> +			return fmt;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * find_format_by_code() - find matching media bus code of
> + * context for given v4l2 pixel format
> + * @ctx: pointer to CSI context
> + * @pixelformat: pixel format to find
> + * Return: pointer to fsd_csis_fmt structure on success, NULL otherwise
> + */
> +static const struct fsd_csis_fmt *find_format_by_code(struct fsd_csis_ctx *ctx,
> +						      unsigned int pixelformat)
> +{
> +	const struct fsd_csis_fmt *fmt;
> +	unsigned int i;
> +
> +	for (i = 0; i < ctx->num_active_fmt; i++) {
> +		fmt = ctx->active_fmt[i];
> +
> +		if (fmt->code == pixelformat)
> +			return fmt;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline struct fsd_csis_ctx *notifier_to_ctx(struct v4l2_async_notifier *n)
> +{
> +	return container_of(n, struct fsd_csis_ctx, notifier);
> +}
> +
> +/*
> + * fsd_csis_subdev_get_format() - get the sensor sub device format
> + * @ctx: pointer to CSI context
> + * @frmfmt: out parameter filled with subdev format
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_subdev_get_format(struct fsd_csis_ctx *ctx, struct v4l2_mbus_framefmt *frmfmt)
> +{
> +	struct v4l2_subdev_format sd_fmt;
> +	struct v4l2_mbus_framefmt *mbus_fmt = &sd_fmt.format;
> +	int ret;
> +
> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad = 0;
> +
> +	ret = v4l2_subdev_call(ctx->sensor, pad, get_fmt, NULL, &sd_fmt);
> +
> +	if (ret)
> +		return ret;
> +	*frmfmt = *mbus_fmt;
> +	fsd_csis_ctx_dbg(3, ctx, "%dx%d code:%04X\n", frmfmt->width, frmfmt->height, frmfmt->code);
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_subdev_set_format() - set the sensor sub device format
> + * @ctx: pointer to CSI context
> + * @frmfmt: subdev format to set
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_subdev_set_format(struct fsd_csis_ctx *ctx, struct v4l2_mbus_framefmt *frmfmt)
> +{
> +	struct v4l2_subdev_format sd_fmt;
> +	struct v4l2_mbus_framefmt *mbus_fmt = &sd_fmt.format;
> +	int ret;
> +
> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad = 0;
> +	*mbus_fmt = *frmfmt;
> +
> +	ret = v4l2_subdev_call(ctx->sensor, pad, set_fmt, NULL, &sd_fmt);
> +
> +	if (ret)
> +		return ret;
> +	*frmfmt = *mbus_fmt;
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_querycap() - provide v4l2_capability information
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @cap: out parameter filled with driver information
> + * Return: 0
> + */
> +static int fsd_csis_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +
> +	strscpy(cap->driver, FSD_CSIS_MODULE_NAME, sizeof(cap->driver));
> +	strscpy(cap->card, FSD_CSIS_MODULE_NAME, sizeof(cap->card));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s", ctx->v4l2_dev->name);
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_enum_fmt_vid_cap() - enumerate v4l2 format information
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @f: out parameter with enumerated format information
> + * Return: 0
> + */
> +static int fsd_csis_enum_fmt_vid_cap(struct file *file, void *priv, struct v4l2_fmtdesc *f)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +	const struct fsd_csis_fmt *fmt = NULL;
> +
> +	if (f->index >= ctx->num_active_fmt)
> +		return -EINVAL;
> +
> +	fmt = ctx->active_fmt[f->index];
> +	f->pixelformat = fmt->fourcc;
> +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_try_fmt_vid_cap() - try image format to set
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @f: format to try. Can be overwrittenwith driver supported values.
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_try_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +	const struct fsd_csis_fmt *fmt;
> +	struct v4l2_subdev_frame_size_enum fse;
> +	int ret, found;
> +
> +	fmt = find_format_by_pix(ctx, f->fmt.pix.pixelformat);
> +
> +	if (!fmt) {
> +		fsd_csis_ctx_info(ctx,
> +				  "Fourcc format 0x%08x not found, setting active format 0x%08x\n",
> +				  f->fmt.pix.pixelformat, ctx->active_fmt[0]->fourcc);
> +
> +		/* Just get the first one enumerated */
> +		fmt = ctx->active_fmt[0];
> +		f->fmt.pix.pixelformat = fmt->fourcc;
> +		f->fmt.pix.colorspace = fmt->colorspace;
> +	}
> +
> +	f->fmt.pix.field = ctx->v_fmt.fmt.pix.field;
> +
> +	/* check for / find a valid width, height */
> +	ret = 0;
> +	found = false;
> +	fse.pad = 0;
> +	fse.code = fmt->code;
> +	fse.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +
> +	/* loop through supported frame sizes by sensor
> +	 * if there are none -EINVAL is returned from the sub-device
> +	 */
> +	for (fse.index = 0; ; fse.index++) {
> +		ret = v4l2_subdev_call(ctx->sensor, pad, enum_frame_size, NULL, &fse);
> +
> +		if (ret)
> +			break;
> +
> +		if (f->fmt.pix.width == fse.max_width && f->fmt.pix.height == fse.max_height) {
> +			found = true;
> +			break;
> +		} else if (f->fmt.pix.width <= fse.max_width &&
> +			    f->fmt.pix.height >= fse.min_height &&
> +			    f->fmt.pix.height <= fse.min_height) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		fsd_csis_ctx_info(ctx, "Width %d Height %d not supported! Setting to %dx%d\n",
> +				  f->fmt.pix.width, f->fmt.pix.height, ctx->v_fmt.fmt.pix.width,
> +				  ctx->v_fmt.fmt.pix.height);
> +		/* use existing values as default */
> +		f->fmt.pix.width = ctx->v_fmt.fmt.pix.width;
> +		f->fmt.pix.height = ctx->v_fmt.fmt.pix.height;
> +	}
> +
> +	fsd_csis_format_size(ctx, fmt, f);
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_s_fmt_vid_cap() - set format to use
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @f: format to set
> + * Return: 0 on success. error value otherwisen
> + */
> +static int fsd_csis_s_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +	struct vb2_queue *q = &ctx->vb_vidq;
> +	const struct fsd_csis_fmt *fmt;
> +	struct v4l2_mbus_framefmt mbus_fmt;
> +	int ret;
> +
> +	if (vb2_is_busy(q)) {
> +		fsd_csis_ctx_dbg(3, ctx, "device busy: %d\n", q->num_buffers);
> +		return -EBUSY;
> +	}
> +
> +	ret = fsd_csis_try_fmt_vid_cap(file, priv, f);
> +
> +	if (ret < 0) {
> +		fsd_csis_ctx_err(ctx, "%x try format failed\n", f->fmt.pix.pixelformat);
> +		return ret;
> +	}
> +
> +	fmt = find_format_by_pix(ctx, f->fmt.pix.pixelformat);
> +
> +	if (!fmt) {
> +		fsd_csis_ctx_err(ctx, "Fourcc format (0x%08x) not found\n", f->fmt.pix.pixelformat);
> +		return -EINVAL;
> +	}
> +
> +	v4l2_fill_mbus_format(&mbus_fmt, &f->fmt.pix, fmt->code);
> +
> +	ret = fsd_csis_subdev_set_format(ctx, &mbus_fmt);
> +
> +	if (ret) {
> +		fsd_csis_ctx_err(ctx, "%x not supported by subdev\n", f->fmt.pix.pixelformat);
> +		return ret;
> +	}
> +
> +	if (mbus_fmt.code != fmt->code) {
> +		fsd_csis_ctx_dbg(3, ctx, "changed format! This should not happen.\n");
> +		return -EINVAL;
> +	}
> +
> +	v4l2_fill_pix_format(&ctx->v_fmt.fmt.pix, &mbus_fmt);
> +	ctx->v_fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	ctx->v_fmt.fmt.pix.pixelformat = fmt->fourcc;
> +	ctx->v_fmt.fmt.pix.colorspace = fmt->colorspace;
> +	ctx->fmt = fmt;
> +	ctx->m_fmt = mbus_fmt;
> +
> +	fsd_csis_ip_configure(ctx);
> +	*f = ctx->v_fmt;
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_g_fmt_vid_cap() - get current format in use
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @f: out parameter filled format information
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_g_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +
> +	*f = ctx->v_fmt;
> +
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_enum_framesizes() - enumerate frame sizes
> + * @file: pointer to file structure of v4l2 device
> + * @fh: pointer to file handle
> + * @fsize: enumerated frame sizes
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_enum_framesizes(struct file *file, void *fh, struct v4l2_frmsizeenum *fsize)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +	const struct fsd_csis_fmt *fmt;
> +	struct v4l2_subdev_frame_size_enum fse;
> +	int ret;
> +
> +	fmt = find_format_by_pix(ctx, fsize->pixel_format);
> +
> +	if (!fmt) {
> +		fsd_csis_ctx_err(ctx, "Invalid pixel code: %x\n", fsize->pixel_format);
> +		return -EINVAL;
> +	}
> +
> +	fse.index = fsize->index;
> +	fse.pad = 0;
> +	fse.code = fmt->code;
> +
> +	ret = v4l2_subdev_call(ctx->sensor, pad, enum_frame_size, NULL, &fse);
> +
> +	if (ret)
> +		return ret;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fsize->discrete.width = fse.max_width;
> +	fsize->discrete.height = fse.max_height;
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_enum_frameintervals() - enumerate frame intervals
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @fival: enumerated frame interval information
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_enum_frameintervals(struct file *file, void *priv,
> +					struct v4l2_frmivalenum *fival)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +	const struct fsd_csis_fmt *fmt;
> +	struct v4l2_subdev_frame_interval_enum fie = {
> +		.index = fival->index,
> +		.width = fival->width,
> +		.height = fival->height,
> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
> +	};
> +	int ret;
> +
> +	fmt = find_format_by_pix(ctx, fival->pixel_format);
> +
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fie.code = fmt->code;
> +	ret = v4l2_subdev_call(ctx->sensor, pad, enum_frame_interval, NULL, &fie);
> +
> +	if (ret)
> +		return ret;
> +
> +	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
> +	fival->discrete = fie.interval;
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_enum_input() - enumerate video input information
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @inp: video input information
> + * Return: 0
> + */
> +static int fsd_csis_enum_input(struct file *file, void *priv, struct v4l2_input *inp)
> +{
> +	if (inp->index >= FSD_CSIS_NB_INPUT)
> +		return -EINVAL;
> +
> +	inp->type = V4L2_INPUT_TYPE_CAMERA;
> +	snprintf(inp->name, sizeof(inp->name), "Camera %u\n", inp->index);
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_g_input() - get video input number
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @i: video input number
> + * Return: 0
> + */
> +static int fsd_csis_g_input(struct file *file, void *priv, unsigned int *i)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +
> +	*i = ctx->input;
> +
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_s_input() - select video input
> + * @file: pointer to file structure of v4l2 device
> + * @priv: file handle of v4l2 device
> + * @i: video input number
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_s_input(struct file *file, void *priv, unsigned int i)
> +{
> +	struct fsd_csis_ctx *ctx = video_drvdata(file);
> +
> +	if (i >= FSD_CSIS_NB_INPUT)
> +		return -EINVAL;
> +	ctx->input = i;
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_queue_setup() - sets up the number of buffers,
> + * planes and size required for selected image format
> + * @vq: vb2 bufffer queue in use
> + * Return: 0
> + */
> +static int fsd_csis_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
> +				unsigned int *nplanes, unsigned int sizes[],
> +				struct device *alloc_devs[])
> +{
> +	struct fsd_csis_ctx *ctx = vb2_get_drv_priv(vq);
> +	unsigned int size = ctx->v_fmt.fmt.pix.sizeimage;
> +
> +	if (*nplanes) {
> +		if (sizes[0] < size)
> +			return -EINVAL;
> +		size = sizes[0];
> +	}
> +
> +	*nplanes = 1;
> +	sizes[0] = size;
> +	fsd_csis_ctx_dbg(3, ctx, "nbuffers %d size %d\n", *nbuffers, sizes[0]);
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_buffer_prepare() - initialize and validate
> + * the buffer size before queueing
> + * @vb: pointer to vb2_buffer in use
> + * Return: 0 or -EINVAL
> + */
> +static int fsd_csis_buffer_prepare(struct vb2_buffer *vb)
> +{
> +	struct fsd_csis_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> +	struct fsd_csis_buffer *buf = container_of(vb, struct fsd_csis_buffer,
> +			vb.vb2_buf);
> +	unsigned long size, plane_size = 0;
> +
> +	if (WARN_ON(!ctx->fmt))
> +		return -EINVAL;
> +
> +	size = ctx->v_fmt.fmt.pix.sizeimage;
> +	plane_size = vb2_plane_size(vb, 0);
> +
> +	if (plane_size < size) {
> +		fsd_csis_ctx_err(ctx, "Data will not fit into plane (%lu < %lu)\n", plane_size,
> +				 size);
> +		return -EINVAL;
> +	}
> +
> +	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, size);
> +
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_buffer_queue() - pass the buffer vb to CSI for streaming
> + * @vb: pointer to vb2_buffer in use
> + * Return: none
> + */
> +static void fsd_csis_buffer_queue(struct vb2_buffer *vb)
> +{
> +	struct fsd_csis_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> +	struct fsd_csis_buffer *buf =
> +		container_of(vb, struct fsd_csis_buffer, vb.vb2_buf);
> +	struct fsd_csis_dmaqueue *vidq = &ctx->vidq;
> +
> +	mutex_lock(&ctx->mutex_buf);
> +	list_add_tail(&buf->list, &vidq->active);
> +	buf->sequence = ctx->sequence++;
> +	mutex_unlock(&ctx->mutex_buf);
> +}
> +
> +/*
> + * fsd_csis_start_streaming() - enter streaming for the CSI context
> + * @q: pointer to vb2_queue in use
> + * @count: number of already queued buffers
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_start_streaming(struct vb2_queue *q, unsigned int count)
> +{
> +	struct fsd_csis_ctx *ctx = vb2_get_drv_priv(q);
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	struct fsd_csis_dmaqueue *vidq = &ctx->vidq;
> +	struct fsd_csis_buffer *buf, *tmp;
> +	int i, ret;
> +	u64 t_stamp;
> +
> +	for (i = 0; i < FSD_CSIS_NB_DMA_OUT_CH; i++) {
> +		mutex_lock(&ctx->mutex_buf);
> +
> +		if (list_empty(&vidq->active)) {
> +			mutex_unlock(&ctx->mutex_buf);
> +			fsd_csis_ctx_err(ctx, "Active buffer queue empty!\n");
> +			return -EIO;
> +		}
> +
> +		buf = list_entry(vidq->active.next, struct fsd_csis_buffer, list);
> +		list_del(&buf->list);
> +		fsd_csis_add_to_ring_buffer(ctx, buf, i);
> +		mutex_unlock(&ctx->mutex_buf);
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev->device);
> +
> +	if (ret < 0)
> +		goto error_stop;
> +	/*
> +	 * save last frame counter and dma pointer location
> +	 * just before enabling dma
> +	 */
> +	ctx->prev_dma_ptr = fsd_csis_current_dma_ptr(ctx);
> +	ctx->prev_frame_counter = fsd_csis_current_frame_counter(ctx);
> +	ctx->current_frame_counter = ctx->prev_frame_counter;
> +	fsd_csis_clear_vid_irqs(dev);
> +	fsd_csis_dma_enable(ctx, true);
> +	dev->stream_enabled |= (1 << ctx->virtual_channel);
> +
> +	ret = v4l2_subdev_call(ctx->sensor, video, s_stream, 1);
> +
> +	if (ret) {
> +		fsd_csis_ctx_err(ctx, "subdev start streaming failed! : %d\n", ret);
> +		goto error_stop;
> +	}
> +	atomic_set(&ctx->end_irq_worker, 1);
> +	fsd_csis_enable_irqs_for_ctx(ctx);
> +	fsd_csis_enable(dev);
> +	fsd_csis_ctx_info(ctx, "stream start vc %d\n", ctx->virtual_channel);
> +
> +	return 0;
> +
> +error_stop:
> +	fsd_csis_dma_enable(ctx, false);
> +	pm_runtime_put_sync(dev->device);
> +	dev->stream_enabled &= (~(1 << ctx->virtual_channel));
> +	t_stamp = ktime_get_ns();
> +
> +	list_for_each_entry_safe(buf, tmp, &vidq->active, list) {
> +		list_del(&buf->list);
> +		buf->vb.vb2_buf.timestamp = t_stamp;
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +	}
> +	return ret;
> +}
> +
> +/*
> + * fsd_csis_stop_streaming() - stop streaming for CSI context
> + * @q: pointer to vb2_queue in use
> + * Return: none
> + */
> +static void fsd_csis_stop_streaming(struct vb2_queue *q)
> +{
> +	struct fsd_csis_ctx *ctx = vb2_get_drv_priv(q);
> +	struct fsd_csis_dev *dev = ctx->dev;
> +	struct fsd_csis_dmaqueue *vidq = &ctx->vidq;
> +	struct fsd_csis_buffer *buf, *tmp;
> +	unsigned int timeout_cnt = 0;
> +	int i;
> +	void __iomem *dma_act_ctrl = 0;
> +	u64 t_stamp;
> +
> +	fsd_csis_dma_enable(ctx, false);
> +	dev->stream_enabled &= (~(1 << ctx->virtual_channel));
> +	fsd_csis_disable(dev);
> +	fsd_csis_disable_irqs_for_ctx(ctx);
> +	atomic_set(&ctx->end_irq_worker, 0);
> +
> +	/* Wait for DMA Operation to finish */
> +	dma_act_ctrl = dev->base + DMA0_ACT_CTRL + DMA_CH_OFFSET * ctx->virtual_channel;
> +
> +	while ((readl(dma_act_ctrl) & 0x1) == 0x0) {
> +		if (timeout_cnt > 50) {
> +			fsd_csis_warn(dev, "DMA did not finish in 500ms.\n");
> +			break;
> +		}
> +		usleep_range(10000, 20000); /* Wait min 10ms, max 20ms */
> +		timeout_cnt++;
> +	}
> +
> +	/*
> +	 * If DMA operation still exists after disabled IRQ, it will
> +	 * update dma_done part in interrupt source register. For next
> +	 * streaming session, this could be interpreted as current session's
> +	 * first frame done. To prevent this incorrect dma_done receiving,
> +	 * clear the interrupt source register here.
> +	 */
> +	fsd_csis_clear_vid_irqs(dev);
> +
> +	if (v4l2_subdev_call(ctx->sensor, video, s_stream, 0))
> +		fsd_csis_ctx_err(ctx, "Failed to disable streaming in subdev\n");
> +	fsd_csis_ctx_info(ctx, "stream stop vc %d\n", ctx->virtual_channel);
> +
> +	pm_runtime_put_sync(dev->device);
> +
> +	/* Release all active buffers */
> +	mutex_lock(&ctx->mutex_buf);
> +
> +	t_stamp = ktime_get_ns();
> +	list_for_each_entry_safe(buf, tmp, &vidq->active, list) {
> +		list_del(&buf->list);
> +		buf->vb.vb2_buf.timestamp = t_stamp;
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +	}
> +	mutex_unlock(&ctx->mutex_buf);
> +
> +	for (i = 0; i < FSD_CSIS_NB_DMA_OUT_CH; i++) {
> +		buf = ctx->frame[i];
> +
> +		if (buf) {
> +			buf->vb.vb2_buf.timestamp = t_stamp;
> +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +		}
> +	}
> +}
> +
> +/*
> + * Videobuf operations
> + */
> +static const struct vb2_ops fsd_csis_video_ops = {
> +	.queue_setup		= fsd_csis_queue_setup,
> +	.wait_prepare		= vb2_ops_wait_prepare,
> +	.wait_finish		= vb2_ops_wait_finish,
> +	.buf_prepare		= fsd_csis_buffer_prepare,
> +	.start_streaming	= fsd_csis_start_streaming,
> +	.stop_streaming		= fsd_csis_stop_streaming,
> +	.buf_queue		= fsd_csis_buffer_queue,
> +};
> +
> +static int fsd_csis_runtime_pm(struct fsd_csis_dev *dev, int on)
> +{
> +	int i, j, ret = 0;
> +
> +	if (on) {
> +		if (!dev->ip_is_on) {
> +			ret = pm_runtime_get_sync(dev->device);
> +
> +			for (i = 0; i < dev->nb_clocks; i++) {
> +				ret = clk_prepare_enable(dev->clk[i]);
> +
> +				if (ret) {
> +					fsd_csis_err(dev, "clock %d enable Failed\n", i);
> +					for (j = 0; j < i; j++)
> +						clk_disable(dev->clk[j]);
> +					pm_runtime_put_sync(dev->device);
> +					return ret;
> +				}
> +			}
> +			enable_irq(dev->irq);
> +			dev->ip_is_on = true;
> +		}
> +
> +	} else {
> +		if (!dev->stream_enabled && dev->ip_is_on) {
> +			disable_irq(dev->irq);
> +
> +			for (i = 0; i < dev->nb_clocks; i++)
> +				clk_disable(dev->clk[i]);
> +			pm_runtime_put_sync(dev->device);
> +			dev->ip_is_on = false;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct v4l2_ctrl_ops fsd_csis_ip_ctrl_ops = {
> +	.s_ctrl	= fsd_csis_ip_s_ctrl,
> +};
> +
> +static const struct v4l2_ctrl_config fsd_csis_ip_set_nb_lane = {
> +	.ops	= &fsd_csis_ip_ctrl_ops,
> +	.id	= V4L2_CID_USER_FSD_CSIS_NO_OF_LANE,
> +	.name	= "Set number of lanes for CSIS Rx controller",
> +	.type	= V4L2_CTRL_TYPE_INTEGER,
> +	.min	= 1,
> +	.max	= 4,
> +	.step	= 1,
> +	.def	= 4,
> +};
> +
> +/*
> + * fsd_csis_ctrl_notify() - get notified of controls of video device
> + * @ctrl: pointer to control value passed by user
> + * @priv: private data (pointer to struct fsd_csis_dev instance)
> + * Return: None
> + */
> +static void fsd_csis_ctrl_notify(struct v4l2_ctrl *ctrl, void *priv)
> +{
> +	struct fsd_csis_dev *dev = priv;
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_USER_FSD_CSIS_NO_OF_LANE:
> +		dev->nb_data_lane = ctrl->val;
> +		if (!dev->stream_enabled)
> +			fsd_csis_set_num_of_datalane(dev, dev->nb_data_lane);
> +		break;
> +	}
> +}
> +
> +/*
> + * fsd_csis_async_complete() - complete binding and register sensor sub device
> + * @notifier: v4l2 device notifier
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_async_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct fsd_csis_ctx *ctx = notifier_to_ctx(notifier);
> +	const struct fsd_csis_fmt *fmt;
> +	struct v4l2_mbus_framefmt mbus_fmt;
> +	int ret;
> +
> +	ret = fsd_csis_subdev_get_format(ctx, &mbus_fmt);
> +
> +	if (ret) {
> +		fsd_csis_ctx_err(ctx, "fsd_csis_subdev_get_format failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	fmt = find_format_by_code(ctx, mbus_fmt.code);
> +
> +	if (!fmt) {
> +		fsd_csis_ctx_err(ctx, "mubs code 0x%08X not found\n", mbus_fmt.code);
> +		return -EINVAL;
> +	}
> +
> +	/* Save current subdev format */
> +	v4l2_fill_pix_format(&ctx->v_fmt.fmt.pix, &mbus_fmt);
> +	ctx->v_fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	ctx->v_fmt.fmt.pix.pixelformat  = fmt->fourcc;
> +	ctx->v_fmt.fmt.pix.field = V4L2_FIELD_NONE;
> +	ctx->v_fmt.fmt.pix.colorspace = fmt->colorspace;
> +	ctx->v_fmt.fmt.pix.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> +	ctx->v_fmt.fmt.pix.quantization = V4L2_QUANTIZATION_DEFAULT;
> +	ctx->v_fmt.fmt.pix.xfer_func = V4L2_XFER_FUNC_SRGB;
> +	fsd_csis_format_size(ctx, fmt, &ctx->v_fmt);
> +	ctx->fmt = fmt;
> +	ctx->m_fmt = mbus_fmt;
> +	return 0;
> +}
> +
> +/*
> + * fsd_csis_fop_open() - open CSI v4l2 device
> + * @filp: pointer to file structure
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_fop_open(struct file *filp)
> +{
> +	struct fsd_csis_ctx *ctx;
> +	int ret = -ENODEV;
> +	struct vb2_queue *q;
> +
> +	ctx = video_drvdata(filp);
> +
> +	if (ctx) {
> +		q = &ctx->vb_vidq;
> +
> +		if (vb2_is_busy(q)) {
> +			fsd_csis_ctx_dbg(3, ctx, "device busy\n");
> +			return -EBUSY;
> +		}
> +		ret = v4l2_fh_open(filp);
> +
> +		if (ret)
> +			return ret;
> +		ret = fsd_csis_runtime_pm(ctx->dev, 1);
> +	}
> +	return ret;
> +}
> +
> +/*
> + * fsd_csis_fop_release() - release the file pertaining to CSI v4l2 device
> + * @filp: pointer to file structure
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_fop_release(struct file *filp)
> +{
> +	struct fsd_csis_ctx *ctx;
> +	int ret;
> +
> +	ret = vb2_fop_release(filp);
> +
> +	if (ret)
> +		return ret;
> +	ctx = video_drvdata(filp);
> +	ret = fsd_csis_runtime_pm(ctx->dev, 0);
> +	return ret;
> +}
> +
> +/*
> + * Video device ioctls
> + */
> +static const struct v4l2_ioctl_ops fsd_csis_ioctl_ops = {
> +	/* VIDIOC_QUERYCAP handler */
> +	.vidioc_querycap      = fsd_csis_querycap,
> +
> +	/* VIDIOC_ENUM_FMT handlers */
> +	.vidioc_enum_fmt_vid_cap  = fsd_csis_enum_fmt_vid_cap,
> +
> +	/* VIDIOC_G_FMT handlers */
> +	.vidioc_g_fmt_vid_cap     = fsd_csis_g_fmt_vid_cap,
> +
> +	/* VIDIOC_S_FMT handlers */
> +	.vidioc_s_fmt_vid_cap     = fsd_csis_s_fmt_vid_cap,
> +
> +	/* VIDIOC_TRY_FMT handlers */
> +	.vidioc_try_fmt_vid_cap   = fsd_csis_try_fmt_vid_cap,
> +
> +	/* Buffer handlers */
> +	.vidioc_reqbufs       = vb2_ioctl_reqbufs,
> +	.vidioc_querybuf      = vb2_ioctl_querybuf,
> +	.vidioc_qbuf          = vb2_ioctl_qbuf,
> +	.vidioc_expbuf	      = vb2_ioctl_expbuf,
> +	.vidioc_dqbuf         = vb2_ioctl_dqbuf,
> +	.vidioc_create_bufs   = vb2_ioctl_create_bufs,
> +	.vidioc_prepare_buf   = vb2_ioctl_prepare_buf,
> +
> +	/* Stream on/off */
> +	.vidioc_streamon      = vb2_ioctl_streamon,
> +	.vidioc_streamoff     = vb2_ioctl_streamoff,
> +
> +	/* Input handling */
> +	.vidioc_enum_input    = fsd_csis_enum_input,
> +	.vidioc_g_input       = fsd_csis_g_input,
> +	.vidioc_s_input       = fsd_csis_s_input,
> +
> +	/* Sliced VBI cap */
> +	.vidioc_log_status    = v4l2_ctrl_log_status,
> +
> +	/* Debugging ioctls */
> +	.vidioc_enum_framesizes   = fsd_csis_enum_framesizes,
> +	.vidioc_enum_frameintervals = fsd_csis_enum_frameintervals,
> +
> +	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> +	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
> +};
> +
> +/*
> + * V4L2 File operations
> + */
> +static const struct v4l2_file_operations fsd_csis_fops = {
> +	.owner		= THIS_MODULE,
> +	.read           = vb2_fop_read,
> +	.poll		= vb2_fop_poll,
> +	.unlocked_ioctl = video_ioctl2,
> +	.mmap           = vb2_fop_mmap,
> +	.open           = fsd_csis_fop_open,
> +	.release        = fsd_csis_fop_release,
> +};
> +
> +static struct video_device fsd_csis_videodev = {
> +	.fops		= &fsd_csis_fops,
> +	.device_caps	= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING | V4L2_CAP_READWRITE,

No READWRITE please, that's deprecated for this kind of use case.

> +	.name		= FSD_CSIS_MODULE_NAME,
> +	.minor		= -1,
> +	.release	= video_device_release_empty,
> +	.ioctl_ops	= &fsd_csis_ioctl_ops,
> +};
> +
> +/*
> + * fsd_csis_complete_ctx() -
> + * @ctx: pointer to CSI context
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_complete_ctx(struct fsd_csis_ctx *ctx)
> +{
> +	struct video_device *vdev;
> +	struct vb2_queue *q;
> +	int ret;
> +
> +	ret = v4l2_device_register_subdev_nodes(ctx->v4l2_dev);
> +
> +	if (ret)
> +		v4l2_warn(ctx->v4l2_dev, "V4L2 register subdev nodes failed: %d\n", ret);
> +
> +	ctx->timesperframe = fsd_csis_tpf_default;
> +
> +	/* initialize locks */
> +	mutex_init(&ctx->mutex);
> +	mutex_init(&ctx->mutex_buf);
> +
> +	/* initialize vb2_queue */
> +	q = &ctx->vb_vidq;
> +	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ | VB2_USERPTR;

Same here, and no USERPTR either.

> +	q->drv_priv = ctx;
> +	q->buf_struct_size = sizeof(struct fsd_csis_buffer);
> +	q->ops = &fsd_csis_video_ops;
> +	q->mem_ops = &vb2_dma_contig_memops;
> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->lock = &ctx->mutex;
> +	q->min_buffers_needed = FSD_CSIS_NB_MIN_CH;
> +	q->dev = ctx->dev->device;
> +	dma_set_coherent_mask(ctx->dev->device, DMA_BIT_MASK(FSD_CSIS_DMA_COHERENT_MASK_SIZE));
> +
> +	ret = vb2_queue_init(q);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* initialize video DMA queue */
> +	INIT_LIST_HEAD(&ctx->vidq.active);
> +
> +	vdev = &ctx->vdev;
> +	*vdev = fsd_csis_videodev;
> +	vdev->v4l2_dev = ctx->v4l2_dev;
> +	vdev->queue = q;
> +	video_set_drvdata(vdev, ctx);
> +
> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, video_nr);
> +
> +	if (ret)
> +		return ret;
> +
> +	v4l2_info(ctx->v4l2_dev, "Video device registered as %s\n", video_device_node_name(vdev));
> +	return ret;
> +}
> +
> +/*
> + * fsd_csis_async_bound() -
> + * @notifier:
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_async_bound(struct v4l2_async_notifier *notifier, struct v4l2_subdev *subdev,
> +				struct v4l2_async_subdev *asd)
> +{
> +	struct fsd_csis_dev *dev = NULL;
> +	struct fsd_csis_ctx *ctx = notifier_to_ctx(notifier);
> +	const struct fsd_csis_fmt *fmt;
> +	struct v4l2_subdev_mbus_code_enum mbus_code;
> +	int i, j, k, ret = 0;
> +
> +	dev = ctx->dev;
> +
> +	/* each of dev->ctx have their own asd and sensor subdevs */
> +	if (ctx->asd.match.fwnode ==
> +			of_fwnode_handle(subdev->dev->of_node)) {
> +		ctx->sensor = subdev;
> +	} else {
> +		fsd_csis_ctx_err(ctx, "No matching sensor node for found!\n");
> +		return -ENODEV;
> +	}
> +
> +	v4l2_set_subdev_hostdata(subdev, ctx);
> +
> +	v4l2_info(ctx->v4l2_dev, "Hooked sensor subdevice: %s to parent\n", subdev->name);
> +
> +	/* Enumerate subdevice formates and enable matching csis formats */
> +	ctx->num_active_fmt = 0;
> +
> +	for (i = 0, j = 0; ret != -EINVAL; ++j) {
> +		memset(&mbus_code, 0, sizeof(mbus_code));
> +		mbus_code.index = j;
> +		mbus_code.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +		ret = v4l2_subdev_call(subdev, pad, enum_mbus_code, NULL, &mbus_code);
> +
> +		if (ret)
> +			continue;
> +
> +		for (k = 0; k < ARRAY_SIZE(fsd_csis_formats); k++) {
> +			fmt = &fsd_csis_formats[k];
> +
> +			if (mbus_code.code == fmt->code) {
> +				ctx->active_fmt[i] = fmt;
> +				ctx->num_active_fmt = ++i;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (!i)
> +		fsd_csis_ctx_err(ctx, "No matching format found by subdev %s\n", subdev->name);
> +	ret = fsd_csis_complete_ctx(ctx);
> +
> +	if (ret) {
> +		fsd_csis_ctx_err(ctx, "Failed to register video device for csis%d-%d\n",
> +				 dev->id, ctx->virtual_channel);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_async_notifier_operations fsd_csis_async_notifier_ops = {
> +	.bound = fsd_csis_async_bound,
> +	.complete = fsd_csis_async_complete,
> +};
> +
> +/*
> + * of_get_next_port() -
> + * @parent: struct device_node
> + * Return: pointer to the device node on success, NULL value otherwise
> + */
> +static struct device_node *of_get_next_port(const struct device_node *parent,
> +					    struct device_node *prev)
> +{
> +	struct device_node *port = NULL;
> +
> +	if (!parent)
> +		return NULL;
> +
> +	if (!prev) {
> +		struct device_node *ports;
> +		/*
> +		 * It's the first csis, we have to find a port subnode
> +		 * within this node or within an optional 'ports' node.
> +		 */
> +		ports = of_get_child_by_name(parent, "ports");
> +
> +		if (ports)
> +			parent = ports;
> +
> +		port = of_get_child_by_name(parent, "port");
> +		/* release the 'ports' node */
> +		of_node_put(ports);
> +	} else {
> +		struct device_node *ports;
> +
> +		ports = of_get_parent(prev);
> +
> +		if (!ports)
> +			return NULL;
> +
> +		do {
> +			port = of_get_next_child(ports, prev);
> +
> +			if (!port) {
> +				of_node_put(ports);
> +				return NULL;
> +			}
> +			prev = port;
> +		} while (!of_node_name_eq(port, "port"));
> +		of_node_put(ports);
> +	}
> +	return port;
> +}
> +
> +/*
> + * of_get_next_endpoint() -
> + * @parent: pointer to struct device_node
> + * Return: pointer to the device node on success, NULL value otherwise
> + */
> +static struct device_node *of_get_next_endpoint(const struct device_node *parent,
> +						struct device_node *prev)
> +{
> +	struct device_node *ep = NULL;
> +
> +	if (!parent)
> +		return NULL;
> +
> +	do {
> +		ep = of_get_next_child(parent, prev);
> +
> +		if (!ep)
> +			return NULL;
> +		prev = ep;
> +	} while (!of_node_name_eq(ep, "endpoint"));
> +
> +	return ep;
> +}
> +
> +/*
> + * of_create_fsd_csis_context() - Parse the device node for local (csis port)
> + * and remote endpoint (sensor node) properties.
> + * Fill the sensor node properties into V4L2 endpoint descriptor
> + * for later use
> + * @ctx: pointer to CSI context
> + * @inst: CSI instance virtual channel ID for which CSI context is to be
> + * created
> + * Return: 0 on success. error value otherwise
> + */
> +static int of_create_fsd_csis_context(struct fsd_csis_ctx *ctx, int inst)
> +{
> +	struct device *device = ctx->dev->device;
> +	struct device_node *parent_node = NULL, *port = NULL, *ep_node = NULL,
> +			   *remote_ep = NULL, *sensor_node = NULL;
> +	struct v4l2_fwnode_endpoint *endpoint;
> +	struct v4l2_async_subdev *asd;
> +	int ret = 0, i;
> +	unsigned int regval = 0x0;
> +	bool found_port = false;
> +
> +	parent_node = device->of_node;
> +	endpoint = &ctx->endpoint;
> +
> +	for (i = 0; i < FSD_CSIS_MAX_VC; i++) {
> +		port = of_get_next_port(parent_node, port);
> +
> +		if (!port) {
> +			ret = -ENODEV;
> +			goto cleanup_exit;
> +		}
> +
> +		of_property_read_u32(port, "reg", &regval);
> +
> +		if (regval == inst) {
> +			found_port = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found_port) {
> +		ret = -ENODEV;
> +		fsd_csis_dbg(2, ctx->dev, "no matching port %d found\n", inst);
> +		goto cleanup_exit;
> +	}
> +
> +	ep_node = of_get_next_endpoint(port, ep_node);
> +
> +	if (!ep_node) {
> +		fsd_csis_err(ctx->dev, "get endpoint failed: %ld\n", PTR_ERR(port));
> +		ret = -ENODEV;
> +		goto cleanup_exit;
> +	}
> +
> +	sensor_node = of_graph_get_remote_port_parent(ep_node);
> +
> +	if (!sensor_node) {
> +		fsd_csis_err(ctx->dev, "get sensor node failed: %ld\n", PTR_ERR(sensor_node));
> +		ret = -ENODEV;
> +		goto cleanup_exit;
> +	}
> +
> +	remote_ep = of_parse_phandle(ep_node, "remote-endpoint", 0);
> +
> +	if (!remote_ep) {
> +		fsd_csis_err(ctx->dev, "get remote endpoint failed %ld\n", PTR_ERR(remote_ep));
> +		ret = -ENODEV;
> +		goto cleanup_exit;
> +	}
> +
> +	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(remote_ep), endpoint);
> +
> +	if (ret) {
> +		fsd_csis_err(ctx->dev, "parse endpoint failed: %ld\n", PTR_ERR(remote_ep));
> +		ret = -ENODEV;
> +		goto cleanup_exit;
> +	}
> +
> +	/* Store virtual channel id */
> +	ctx->virtual_channel = inst;
> +
> +	asd = &ctx->asd;
> +	asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
> +	asd->match.fwnode = of_fwnode_handle(sensor_node);
> +
> +	v4l2_async_nf_init(&ctx->notifier);
> +
> +	ret = __v4l2_async_nf_add_subdev(&ctx->notifier, asd);
> +
> +	if (ret) {
> +		fsd_csis_err(ctx->dev, "add asd to notifier fail: %d", ret);
> +		goto cleanup_exit;
> +	}
> +
> +	sensor_node = NULL;
> +
> +cleanup_exit:
> +
> +	if (!remote_ep)
> +		of_node_put(remote_ep);
> +
> +	if (!sensor_node)
> +		of_node_put(sensor_node);
> +
> +	if (!ep_node)
> +		of_node_put(ep_node);
> +
> +	if (!port)
> +		of_node_put(port);
> +	return ret;
> +}
> +
> +/*
> + * fsd_csis_create_context() - create CSI context for virtual channel
> + * @dev: pointer to fsd_csis_dev structure
> + * @inst: value of virtual channel
> + * Return: pointer to CSI context structure on success, NULL value otherwise
> + */
> +static struct fsd_csis_ctx *fsd_csis_create_context(struct fsd_csis_dev *dev, int inst)
> +{
> +	struct fsd_csis_ctx *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev->device, sizeof(*ctx), GFP_KERNEL);
> +
> +	if (!ctx)
> +		return NULL;
> +	ctx->dev = dev;
> +	ret = of_create_fsd_csis_context(ctx, inst);
> +
> +	if (ret)
> +		goto free_ctx;
> +
> +	ctx->v4l2_dev = &dev->v4l2_dev;
> +	ctx->notifier.ops = &fsd_csis_async_notifier_ops;
> +	ret = v4l2_async_nf_register(ctx->v4l2_dev, &ctx->notifier);
> +
> +	if (ret < 0) {
> +		fsd_csis_ctx_err(ctx, "async notifer register failed: %d\n", ret);
> +		v4l2_async_nf_cleanup(&ctx->notifier);
> +		goto unregister_device;
> +	}
> +
> +	ctx->dev->stream_enabled &= (~(1 << ctx->virtual_channel));
> +	ctx->sequence = 0;
> +	return ctx;
> +
> +unregister_device:
> +	v4l2_device_unregister(ctx->v4l2_dev);
> +
> +free_ctx:
> +	devm_kfree(dev->device, ctx);
> +	return NULL;
> +}
> +
> +/*
> + * fsd_csis_delete_context() - delete the contextx instances
> + * @dev: pointer to fds_csis_dev structure
> + * Return: None
> + */
> +static void fsd_csis_delete_context(struct fsd_csis_dev *dev)
> +{
> +	int i;
> +	struct fsd_csis_ctx *ctx;
> +
> +	for (i = 0; i < FSD_CSIS_MAX_VC; i++) {
> +		ctx = dev->ctx[i];
> +
> +		if (ctx) {
> +			fsd_csis_ctx_dbg(3, ctx, "unregistering %s\n",
> +					 video_device_node_name(&ctx->vdev));
> +			v4l2_async_nf_unregister(&ctx->notifier);
> +			video_unregister_device(&ctx->vdev);
> +			cancel_work_sync(&dev->ctx[i]->csis_ctx_work);
> +			mutex_destroy(&ctx->mutex);
> +			mutex_destroy(&ctx->mutex_buf);
> +			devm_kfree(dev->device, ctx);
> +		}
> +		dev->ctx[i] = NULL;
> +	}
> +}
> +
> +/*
> + * fsd_csis_probe() - CSI driver probe method
> + * @pdev: pointer to platform_device structure for CSI driver
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_probe(struct platform_device *pdev)
> +{
> +	struct fsd_csis_dev *dev;
> +	int i, ret = 0;
> +	unsigned int irq;
> +	char name[24];
> +	struct resource *res;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	/* save struct device information */
> +	dev->device = &pdev->dev;
> +	dev->id = of_alias_get_id(pdev->dev.of_node, "csis");
> +	dev->info = of_device_get_match_data(dev->device);
> +
> +	/* Get Register and DMA resources, IRQ */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!res) {
> +		dev_err(dev->device, "get register base failed\n");
> +		return -ENODEV;
> +	}
> +	dev->base = devm_ioremap_resource(dev->device, res);
> +
> +	if (IS_ERR(dev->base))
> +		return PTR_ERR(dev->base);
> +
> +	dev->sysreg_map = syscon_regmap_lookup_by_phandle(dev->device->of_node, "sysreg_csi");
> +
> +	if (IS_ERR(dev->sysreg_map)) {
> +		ret = PTR_ERR(dev->sysreg_map);
> +		dev_err(&pdev->dev, "sysreg map failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev->device, irq, fsd_csis_irq_handler, 0,
> +			       dev_name(dev->device), dev);
> +
> +	if (ret) {
> +		dev_err(dev->device, "IRQ %d get failed: %d\n", irq, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < dev->info->nb_clocks; i++) {
> +		snprintf(name, sizeof(name), "csis-%s", dev->info->clk_names[i]);
> +		dev->clk[i] = devm_clk_get(dev->device, name);
> +
> +		if (IS_ERR(dev->clk[i])) {
> +			ret = PTR_ERR(dev->clk[i]);
> +			dev_err(dev->device, "Clock %s get failed: %d\n", name, ret);
> +			return ret;
> +		}
> +		dev->nb_clocks++;
> +		pr_debug("%s clock added\n", name);
> +	}
> +
> +	platform_set_drvdata(pdev, dev);
> +	mutex_init(&dev->mutex_csis_dma_reg);
> +
> +	/* set pseudo v4l2 device name for use in printk */
> +	v4l2_device_set_name(&dev->v4l2_dev, FSD_CSIS_MODULE_NAME, &drv_instance);
> +	ret = v4l2_device_register(dev->device, &dev->v4l2_dev);
> +
> +	if (ret < 0) {
> +		v4l2_err(&dev->v4l2_dev, "register v4l2_device failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = v4l2_ctrl_handler_init(&dev->ctrl_handler, 1);
> +
> +	if (ret)
> +		v4l2_err(&dev->v4l2_dev, "control handler init failed: %d\n", ret);
> +
> +	v4l2_ctrl_new_custom(&dev->ctrl_handler, &fsd_csis_ip_set_nb_lane, NULL);
> +
> +	if (dev->ctrl_handler.error) {
> +		ret = dev->ctrl_handler.error;
> +		v4l2_err(&dev->v4l2_dev, "add control for setting CSIS Rx lanes failed: %d\n", ret);
> +		goto unregister_device;
> +	}
> +
> +	v4l2_ctrl_notify(v4l2_ctrl_find(&dev->ctrl_handler, V4L2_CID_USER_FSD_CSIS_NO_OF_LANE),
> +			 fsd_csis_ctrl_notify, dev);
> +	dev->v4l2_dev.ctrl_handler = &dev->ctrl_handler;
> +	v4l2_ctrl_handler_setup(&dev->ctrl_handler);
> +
> +	for (i = 0; i < FSD_CSIS_MAX_VC; i++) {
> +		dev->ctx[i] = fsd_csis_create_context(dev, i);
> +
> +		if (dev->ctx[i])
> +			INIT_WORK(&dev->ctx[i]->csis_ctx_work, fsd_csis_irq_worker);
> +	}
> +
> +	dev->ip_is_on = false;
> +	dev->lane_speed = FSD_CSIS_RX_BW;
> +	pm_runtime_enable(dev->device);
> +	ret = pm_runtime_resume_and_get(dev->device);
> +
> +	if (ret)
> +		goto runtime_disable;
> +	pm_runtime_put_sync(dev->device);
> +	return 0;
> +
> +runtime_disable:
> +	pm_runtime_disable(dev->device);
> +
> +unregister_device:
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +	fsd_csis_delete_context(dev);
> +
> +	return ret;
> +}
> +
> +/*
> + * fsd_csis_remove() - CSI device remove mothod
> + * @pdev: pointer to platform_device structure
> + * Return: 0 on success. error value otherwise
> + */
> +static int fsd_csis_remove(struct platform_device *pdev)
> +{
> +	struct fsd_csis_dev *dev =
> +		(struct fsd_csis_dev *)platform_get_drvdata(pdev);
> +	int ret;
> +
> +	fsd_csis_disable(dev);
> +	ret = pm_runtime_resume_and_get(dev->device);
> +
> +	v4l2_ctrl_handler_free(&dev->ctrl_handler);
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +
> +	fsd_csis_delete_context(dev);
> +	mutex_destroy(&dev->mutex_csis_dma_reg);
> +
> +	if (ret >= 0)
> +		pm_runtime_put_sync(dev->device);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static void fsd_csis_shutdown(struct platform_device *pdev)
> +{
> +	struct fsd_csis_dev *dev =
> +		(struct fsd_csis_dev *)platform_get_drvdata(pdev);
> +
> +	fsd_csis_disable_irqs(dev);
> +	fsd_csis_disable(dev);
> +}
> +
> +static struct fsd_csis_dev_info fsd_csis_dev_info_v4_3 = {
> +	.version	= FSD_CSIS_VERSION_4_3,
> +	.nb_clocks	= 1,
> +	.clk_names	= { "aclk" },
> +};
> +
> +static const struct of_device_id fsd_csis_of_match[] = {
> +	{
> +		.compatible = "tesla,fsd-csis",
> +		.data = &fsd_csis_dev_info_v4_3,
> +	},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, fsd_csis_of_match);
> +
> +static struct platform_driver fsd_csis_driver = {
> +	.probe		= fsd_csis_probe,
> +	.remove		= fsd_csis_remove,
> +	.shutdown	= fsd_csis_shutdown,
> +	.driver		= {
> +		.name	= FSD_CSIS_MODULE_NAME,
> +		.of_match_table	= of_match_ptr(fsd_csis_of_match),
> +	},
> +};
> +
> +module_platform_driver(fsd_csis_driver);
> +
> +MODULE_DESCRIPTION("FSD CSIS Driver");
> +MODULE_AUTHOR("Sathyakam M, <sathya@samsung.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(FSD_CSIS_MODULE_VERSION);
> diff --git a/drivers/media/platform/fsd/fsd-csis.h b/drivers/media/platform/fsd/fsd-csis.h
> new file mode 100644
> index 000000000000..b990da903f87
> --- /dev/null
> +++ b/drivers/media/platform/fsd/fsd-csis.h
> @@ -0,0 +1,785 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * FSD CSIS camera interface driver
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation
> + */
> +
> +#ifndef _FSD_CSIS_H
> +#define _FSD_CSIS_H
> +
> +/* Select D-PHY control values for FSD CSI Rx controller */
> +#if defined(CONFIG_FSD_CSI_2100_MEGA_BITS_PER_SEC)
> +
> +/* PHY control values for 2100 Mbps */
> +#define S_CLKSETTLECTL_VAL			0x00
> +#define S_HSSETTLECTL_VAL			0x2e
> +#define FSD_CSIS_RX_BW				2100
> +
> +#elif defined(CONFIG_FSD_CSI_1600_MEGA_BITS_PER_SEC)
> +
> +/* PHY control values 1600 Mbps */
> +#define S_CLKSETTLECTL_VAL			0x00
> +#define S_HSSETTLECTL_VAL			0x23
> +#define FSD_CSIS_RX_BW				1600
> +
> +#elif defined(CONFIG_FSD_CSI_1500_MEGA_BITS_PER_SEC)
> +
> +/* PHY control values for 1500 Mbps */
> +#define S_CLKSETTLECTL_VAL			0x00
> +#define S_HSSETTLECTL_VAL			0x21
> +#define FSD_CSIS_RX_BW				1500
> +
> +#elif defined(CONFIG_FSD_CSI_1000_MEGA_BITS_PER_SEC)
> +
> +/* PHY control values for 1000 Mbps */
> +#define S_CLKSETTLECTL_VAL			0x00
> +#define S_HSSETTLECTL_VAL			0x16
> +#define FSD_CSIS_RX_BW				1000
> +
> +#else
> +
> +/* PHY control values for 800 Mbps and below */
> +#define S_CLKSETTLECTL_VAL			0x00
> +#define S_HSSETTLECTL_VAL			0x11
> +#define FSD_CSIS_RX_BW				800
> +
> +#endif
> +
> +#define HSYNC_LINTV				0x20
> +#define CLKGATE_TRAIL_VAL			0x07
> +#define DMA_CLK_GATE_TRAIL			0x07
> +
> +/* SYSREG_CSI offsets */
> +#define SW_RESETEN_DPHY				0x40c
> +
> +#define CSIS_SW_RESETEN_DPHY			0x1
> +#define CSIS_SW_RESETEN_DPHY_MASK(phy)		BIT_MASK(phy)
> +
> +/*
> + * CSI register offsets
> + * (Refer to sf_csis_v6p00 sheet of SFR doc)
> + */
> +#define CSIS_VERSION				0x0000
> +#define CSIS_CMN_CTRL				0x0004
> +#define CSIS_CLK_CTRL				0x0008
> +#define CSIS_INT_MSK0				0x0010
> +#define CSIS_INT_SRC0				0x0014
> +#define CSIS_INT_MSK1				0x0018
> +#define CSIS_INT_SRC1				0x001c
> +#define PHY_STATUS				0x0020
> +#define PHY_CMN_CTRL				0x0024
> +#define PHY_BCTRL_L				0x0030
> +#define PHY_BCTRL_H				0x0034
> +#define PHY_SCTRL_L				0x0038
> +#define PHY_SCTRL_H				0x003c
> +#define ISP_CONFIG_CH0				0x0040
> +#define ISP_RESOL_CH0				0x0044
> +#define ISP_SYNC_CH0				0x0048
> +#define ISP_CONFIG_CH1				0x0050
> +#define ISP_RESOL_CH1				0x0054
> +#define ISP_SYNC_CH1				0x0058
> +#define ISP_CONFIG_CH2				0x0060
> +#define ISP_RESOL_CH2				0x0064
> +#define ISP_SYNC_CH2				0x0068
> +#define ISP_CONFIG_CH3				0x0070
> +#define ISP_RESOL_CH3				0x0074
> +#define ISP_SYNC_CH3				0x0078
> +#define SDW_CONFIG_CH0				0x0080
> +#define SDW_RESOL_CH0				0x0084
> +#define SDW_SYNC_CH0				0x0088
> +#define SDW_CONFIG_CH1				0x0090
> +#define SDW_RESOL_CH1				0x0094
> +#define SDW_SYNC_CH1				0x0098
> +#define SDW_CONFIG_CH2				0x00a0
> +#define SDW_RESOL_CH2				0x00a4
> +#define SDW_SYNC_CH2				0x00a8
> +#define SDW_CONFIG_CH3				0x00b0
> +#define SDW_RESOL_CH3				0x00b4
> +#define SDW_SYNC_CH3				0x00b8
> +#define FRM_CNT_CH0				0x0100
> +#define FRM_CNT_CH1				0x0104
> +#define FRM_CNT_CH2				0x0108
> +#define FRM_CNT_CH3				0x010c
> +#define LINE_INTR_CH0				0x0110
> +#define LINE_INTR_CH1				0x0114
> +#define LINE_INTR_CH2				0x0118
> +#define LINE_INTR_CH3				0x011c
> +#define VC_PASSING				0x0120
> +#define DMA0_CTRL				0x1000
> +#define DMA0_FMT				0x1004
> +#define DMA0_SKIP				0x1008
> +#define DMA0_ADDR1				0x1010
> +#define DMA0_ADDR2				0x1014
> +#define DMA0_ADDR3				0x1018
> +#define DMA0_ADDR4				0x101c
> +#define DMA0_ADDR5				0x1020
> +#define DMA0_ADDR6				0x1024
> +#define DMA0_ADDR7				0x1028
> +#define DMA0_ADDR8				0x102c
> +#define DMA0_ACT_CTRL				0x1030
> +#define DMA0_ACT_FMT				0x1034
> +#define DMA0_ACT_SKIP				0x1038
> +#define DMA0_BYTE_CNT				0x1040
> +#define DMA1_CTRL				0x1100
> +#define DMA1_FMT				0x1104
> +#define DMA1_SKIP				0x1108
> +#define DMA1_ADDR1				0x1110
> +#define DMA1_ADDR2				0x1114
> +#define DMA1_ADDR3				0x1118
> +#define DMA1_ADDR4				0x111c
> +#define DMA1_ADDR5				0x1120
> +#define DMA1_ADDR6				0x1124
> +#define DMA1_ADDR7				0x1128
> +#define DMA1_ADDR8				0x112c
> +#define DMA1_ACT_CTRL				0x1130
> +#define DMA1_ACT_FMT				0x1134
> +#define DMA1_BYTE_CNT				0x1140
> +#define DMA2_CTRL				0x1200
> +#define DMA2_FMT				0x1204
> +#define DMA2_SKIP				0x1208
> +#define DMA2_ADDR1				0x1210
> +#define DMA2_ADDR2				0x1214
> +#define DMA2_ADDR3				0x1218
> +#define DMA2_ADDR4				0x121c
> +#define DMA2_ADDR5				0x1220
> +#define DMA2_ADDR6				0x1224
> +#define DMA2_ADDR7				0x1228
> +#define DMA2_ADDR8				0x122c
> +#define DMA2_ACT_CTRL				0x1230
> +#define DMA2_ACT_FMT				0x1234
> +#define DMA2_ACT_SKIP				0x1238
> +#define DMA2_BYTE_CNT				0x1240
> +#define DMA3_CTRL				0x1300
> +#define DMA3_FMT				0x1304
> +#define DMA3_SKIP				0x1308
> +#define DMA3_ADDR1				0x1310
> +#define DMA3_ADDR2				0x1314
> +#define DMA3_ADDR3				0x1318
> +#define DMA3_ADDR4				0x131c
> +#define DMA3_ADDR5				0x1320
> +#define DMA3_ADDR6				0x1324
> +#define DMA3_ADDR7				0x1328
> +#define DMA3_ADDR8				0x132c
> +#define DMA3_ACT_CTRL				0x1330
> +#define DMA3_ACT_FMT				0x1334
> +#define DMA3_ACT_SKIP				0x1338
> +#define DMA3_BYTE_CNT				0x1340
> +#define DMA_CMN_CTRL				0x1400
> +#define DMA_ERR_CODE				0x1404
> +#define DMA_CLK_CTRL				0x1408
> +#define DMA_AWUSER				0x140c
> +#define DBG_AXIM_INFO				0x1440
> +#define DBG_TRXFIFO_INFO			0x1444
> +#define DBG_DMAFIFO_INFO			0x1448
> +
> +/*
> + * Register bit mask and set values
> + * Mask is defined for each register field from most to lower significant bits
> + * Register field set values are expressed in hex values
> + */
> +/* CSIS_VERSION */
> +#define CSIS_VERSION_MASK			GENMASK(31, 0)
> +
> +/* FSD CSI controller version 4.3 */
> +#define FSD_CSIS_VERSION_4_3			(0x04030002)
> +
> +/* CSIS_CMN_CTRL (CSIS Common Control) */
> +#define UPDATE_SHADOW_CH_MASK(ch)		BIT_MASK(16 + (ch))
> +#define DESKEW_LEVEL_MASK			GENMASK(15, 13)
> +#define DESKEW_ENABLE_MASK			BIT_MASK(12)
> +#define INTERLEAVE_MODE_MASK			GENMASK(11, 10)
> +#define LANE_NUMBER_MASK			GENMASK(9, 8)
> +#define UPDATE_SHADOW_CTRL_MASK			BIT_MASK(2)
> +#define SW_RESET_MASK				BIT_MASK(1)
> +#define CSI_EN_MASK				BIT_MASK(0)
> +
> +#define UPDATE_SHADOW				0x1
> +#define DESKEW_LEVEL				0x2
> +#define DESKEW_ENABLE				0x1
> +#define UPDATE_SHADOW_CTRL			0x1
> +#define SW_RESET				0x1
> +#define CSI_EN					0x1U
> +
> +/* CSIS_CLK_CTRL (CSIS Clock Control) */
> +#define CLKGATE_TRAIL_MASK(ch)			GENMASK(19 + 4 * (ch), 16 + 4 * (ch))
> +#define CLKGATE_EN_MASK(ch)			BIT_MASK(4 + (ch))
> +
> +#define CLKGATE_EN				0x1
> +
> +/* CSIS_INT_MSK0 (Interrupt Mask register 0) */
> +#define FRAMESTART_MASK				GENMASK(27, 24)
> +#define FRAMEEND_MASK				GENMASK(23, 20)
> +#define ERR_SOT_HS_MASK				GENMASK(19, 16)
> +#define ERR_LOST_FS_MASK			GENMASK(15, 12)
> +#define ERR_LOST_FE_MASK			GENMASK(11, 8)
> +#define ERR_OVER_MASK				BIT_MASK(4)
> +#define ERR_WRONG_CFG_MASK			BIT_MASK(3)
> +#define ERR_ECC_MASK				BIT_MASK(2)
> +#define ERR_CRC_MASK				BIT_MASK(1)
> +#define ERR_ID_MASK				BIT_MASK(0)
> +#define CSIS_INT_MSK0_ALL_MASK			GENMASK(27, 0)
> +
> +#define FRAMESTART_CH_MASK(ch)			BIT_MASK((ch) + 24)
> +#define FRAMEEND_CH_MASK(ch)			BIT_MASK((ch) + 20)
> +#define ERR_SOT_HS_CH_MASK(ch)			BIT_MASK((ch) + 16)
> +#define ERR_LOST_FS_CH_MASK(ch)			BIT_MASK((ch) + 12)
> +#define ERR_LOST_FE_CH_MASK(ch)			BIT_MASK((ch) + 8)
> +
> +#define FRAMESTART_ENABLE			0x1
> +#define FRAMEEND_ENABLE				0x1
> +#define ERR_SOT_HS_ENABLE			0x1
> +#define ERR_LOST_FS_ENABLE			0x1
> +#define ERR_LOST_FE_ENABLE			0x1
> +
> +/*
> + * Writing 1 will enable interrupt (Unmask)
> + * Writing 0 will disable interrupt (mask)
> + */
> +#define CSIS_INT_MSK0_ENABLE_ALL		(~0)
> +#define CSIS_INT_MSK0_MASK_ALL			(0)
> +
> +/* CSIS_INT_SRC0 (Interrupt Source register 0) */
> +#define CSIS_INT_SRC0_ERR_ALL_MASK		(GENMASK(19, 8) | GENMASK(4, 0))
> +
> +/*
> + * CSIS_INT_SRC1 (Interrupt Source register 1)
> + * CSIS_INT_MSK1 (Interrupt Mask register 1)
> + */
> +#define DMA_OTF_OVERLAP_MASK			GENMASK(17, 14)
> +#define DMA_ABORT_DONE_MASK			BIT_MASK(13)
> +#define DMA_ERROR_MASK				BIT_MASK(12)
> +#define DMA_FRM_END_MASK			GENMASK(11, 8)
> +#define DMA_FRM_START_MASK			GENMASK(7, 4)
> +#define LINE_END_MASK				GENMASK(3, 0)
> +
> +#define DMA_OTF_OVERLAP_CH_MASK(ch)		BIT_MASK((ch) + 14)
> +#define DMA_FRM_END_CH_MASK(ch)			BIT_MASK((ch) + 8)
> +#define DMA_FRM_START_CH_MASK(ch)		BIT_MASK((ch) + 4)
> +#define LINE_END_CH_MASK(ch)			BIT_MASK(ch)
> +
> +#define DMA_ABORT_ENABLE			0x1
> +#define DMA_ERROR_ENABLE			0x1
> +#define DMA_OTF_OVERLAP_ENABLE			0x1
> +#define DMA_FRM_END_ENABLE			0x1
> +#define DMA_FRM_START_ENABLE			0x1
> +#define LINE_END_CH_ENABLE			0x1
> +
> +#define CSIS_INT_SRC1_ERR_ALL_MASK		GENMASK(17, 12)
> +
> +/*
> + * Writing 1 will enable interrupt (Unmask)
> + * Writing 0 will disable interrupt (mask)
> + */
> +#define CSIS_INT_MASK_ENABLE			0x1
> +#define CSIS_INT_MSK1_ENABLE_ALL		(~0)
> +#define CSIS_INT_MSK1_MASK_ALL			(0)
> +
> +/* PHY_STATUS */
> +#define PHY_STATUS_ULPSDAT_MASK			GENMASK(11, 8)
> +#define PHY_STATUS_STOPSTATEDAT_MASK		GENMASK(7, 4)
> +#define PHY_STATUS_ULPSCLK_MASK			BIT_MASK(1)
> +#define PHY_STATUS_STOPSTATECLK_MASK		BIT_MASK(0)
> +
> +/* PHY_CMN_CTRL (PHY common control) */
> +#define HSSETTLE_MASK				GENMASK(31, 24)
> +#define S_CLKSETTLE_MASK			GENMASK(23, 22)
> +#define S_BYTE_CLK_ENABLE_MASK			BIT_MASK(21)
> +#define S_DPDN_SWAP_CLK_MASK			BIT_MASK(6)
> +#define S_DPDN_SWAP_DAT_MASK			BIT_MASK(5)
> +#define ENABLE_DAT_MASK				GENMASK(4, 1)
> +#define ENABLE_CLK_MASK				BIT_MASK(0)
> +
> +/* PHY BCTRL_L */
> +#define PHY_BCTRL_L_BPHYCTRL_MASK		GENMASK(31, 0)
> +
> +/* PHY BCTRL_H */
> +#define PHY_BCTRL_H_BPHYCTRL_MASK		GENMASK(31, 0)
> +
> +/* PHY SCTRL_L */
> +#define PHY_SCTRL_L_SPHYCTRL_MASK		GENMASK(31, 0)
> +
> +/* PHY SCTRL_H */
> +#define SKEW_CAL_MAX_SKEW_CODE_CTRL_MASK	GENMASK(7, 2)
> +#define SKEW_CAL_EN_MASK			BIT_MASK(1)
> +
> +#define SKEW_CAL_MAX_SKEW_CODE_CTRL		0x24
> +#define SKEW_CAL_EN				0x1
> +
> +/*
> + * ISP_CONFIG_CH0~3 (ISP configuration register CH0~3)
> + * SDW_CONFIG_CH0~3 (Shadow configuration register of CH0~3)
> + */
> +#define PIXEL_MODE_MASK				GENMASK(13, 12)
> +#define PARALLEL_MODE_MASK			BIT_MASK(11)
> +#define RGB_SWAP_MASK				BIT_MASK(10)
> +#define DATAFORMAT_MASK				GENMASK(7, 2)
> +#define VIRTUAL_CHANNEL_MASK			GENMASK(1, 0)
> +
> +#define ISP_CONFIG_CH_OFFSET			0x10
> +
> +/*
> + * ISP_RESOL_CH0~3 (ISP Resolution register CH0~3)
> + * SDW_RESOL_CH0~3 (Shadow resolution register of CH0~3)
> + */
> +#define VRESOL_MASK				GENMASK(31, 16)
> +#define HRESOL_MASK				GENMASK(15, 0)
> +
> +/*
> + * ISP_SYNC_CH0!3 (ISP Sync register CH0~3)
> + * SDW_SYNC_CH0~31 Shadow Sync register CH0~3
> + */
> +#define HSYNC_LINTV_MASK			GENMASK(23, 18)
> +
> +/* FRM_CNT_CH0~3 (Frame counter of CH0~3) */
> +#define FRM_CNT_CH_MASK				GENMASK(31, 0)
> +#define FRM_CNT_CH_OFFSET			0x4
> +
> +/* LINE_INTR_CH0~3 (Line interrupt configuration CH0~3) */
> +#define LINE_INTR_CH_MASK			GENMASK(31, 0)
> +#define LINE_INTR_CH_MUL			0x4
> +
> +/* VC_PASSING (VC Passing configuration) */
> +#define VC_PASSING_MASK				GENMASK(9, 8)
> +#define VC_PASSING_ENABLE_MASK			BIT_MASK(7)
> +#define VC_PASSING_ENABLE			0x1
> +
> +#define DMA_ADDR_OFFSET				0x100
> +
> +/* DMA_CTRL (DMA0~3 Control) */
> +#define DMA_UPDT_SKIPPTR_MASK			GENMASK(7, 5)
> +#define DMA_UPDT_FRAMEPTR_MASK			GENMASK(4, 2)
> +#define DMA_UPDT_PTR_EN_MASK			BIT_MASK(1)
> +#define DMA_DISABLE_MASK			BIT_MASK(0)
> +
> +#define DMA_DISABLE				0x1
> +
> +/* DMA_FMT  (DMA0~3 Output Format) */
> +#define DMA_PACK_MASK				GENMASK(17, 16)
> +#define DMA_DIM_MASK				BIT_MASK(15)
> +#define DMA_DUMP_MASK				BIT_MASK(13)
> +#define DMA_BYTESWAP_MASK			BIT_MASK(12)
> +
> +enum FSD_CSIS_DMA_PACK {
> +	DMA_PACK_NORMAL,
> +	DMA_PACK_10,
> +	DMA_PACK_12,
> +	DMA_PACK_14,
> +	DMA_PACK_18,
> +	DMA_PACK_20,
> +};
> +
> +#define DMA_DIM_1D				0x1
> +#define DMA_DIM_2D				0x0
> +#define DMA_DUMP_OTF				0x1
> +#define DMA_DUMP_NORMAL				0x0
> +#define DMA_BYTESWAP_REVERSE			0x1
> +#define DMA_BYTESWAP_REGULAR			0x0
> +
> +/* DMA_SKIP (DMA0~3 skip) */
> +#define DMA_SKIP_EN_MASK			BIT_MASK(31)
> +#define DMA_SKIP_TURNPTR_MASK			GENMASK(18, 16)
> +#define DMA_SKIP_SEQ_MASK			GENMASK(7, 0)
> +
> +#define DMA_SKIP_ENABLE				0x1
> +
> +/* DMA_ADDR (DMA0~3 Address) */
> +#define DMA_ADDR1_MASK				GENMASK(31, 0)
> +
> +/* DMA_ACT_CTRL (DMA_0_3 ACT control) */
> +#define ACTIVE_DMA_ABORTED_MASK			BIT_MASK(8)
> +#define ACTIVE_DMA_SKIPPTR_MASK			GENMASK(7, 5)
> +#define ACTIVE_DMA_FRAMEPTR_MASK		GENMASK(4, 2)
> +#define ACTIVE_DMA_DISABLE_MASK			BIT_MASK(0)
> +
> +/* DMA_ACT_FMT (DMA0~3 ACT format) */
> +#define ACTIVE_DMA_PACK_MASK			GENMASK(17, 16)
> +#define ACTIVE_DMA_DIM_MASK			BIT_MASK(15)
> +#define ACTIVE_DMA_DUMP_MASK			BIT_MASK(13)
> +#define ACTIVE_DMA_BYTESWAP_MASK		BIT_MASK(12)
> +
> +/* DMA_ACT_SKIP (DMA0~3 ACT skip) */
> +#define ACTIVE_DMA_SKIP_EN_MASK			BIT_MASK(31)
> +#define ACTIVE_DMA_SKIP_TURNPTR_MASK		GENMASK(18, 16)
> +#define ACTIVE_DMA_SKIP_SEQ_MASK		GENMASK(7, 0)
> +
> +/* DMA_FRM_BYTE_CNT (DMA0~3 Frame byte count) */
> +#define DMA_FRM_BYTE_CNT_MASK			GENMASK(31, 0)
> +
> +/* DMA_CMN_CTRL (DMA Common control) */
> +#define DMA_ABORT_REQ_MASK			BIT_MASK(0)
> +#define DMA_FRM_LOCK_EN				1
> +
> +/* DMA_ERR_CODE (DMA Error code) */
> +#define DMAFIFO_FULL_MASK			BIT_MASK(5)
> +#define TRXFIFO_FULL_MASK			BIT_MASK(4)
> +#define BRESP_ERROR_CH_MASK(ch)			BIT_MASK(ch)
> +
> +/* DMA_CLK_CTRL (DMA Clock control) */
> +#define DMA_CLK_GATE_TRAIL_MASK			GENMASK(4, 1)
> +#define DMA_CLK_GATE_EN_MASK			BIT_MASK(0)
> +
> +#define DMA_CLK_GATE_ENABLE			0x1
> +
> +/* DMA_AWUSER (DMA AWUSER) */
> +#define DMA_AWUSER_MASK				GENMASK(3, 0)
> +
> +/* DBG_AXIM_INFO (Debug AXIM Info) */
> +#define DBG_AXIM_WCNT_MASK			GENMASK(11, 7)
> +#define DBG_AXIM_AWCNT_MASK			GENMASK(6, 2)
> +#define DBG_AXIM_STATE_MASK			GENMASK(1, 0)
> +
> +/* DBG_TRXFIFO_INFO (Debug TRXFIFO Info) */
> +#define TRXFIFO_MAX_WCNT_MASK			GENMASK(31, 16)
> +#define TRXFIFO_CUR_WCNT_MASK			GENMASK(15, 0)
> +
> +/* DBG_DMAFIFO_INFO (Debug DMA FIFO Info) */
> +#define DMAFIFO_MAX_WCNT_MASK			GENMASK(31, 16)
> +#define DMAFIFO_CUR_WCNT_MASK			GENMASK(15, 0)
> +
> +#define DMA_CLK_GATE_ENABLE			0x1
> +
> +#define FSD_CSIS_NB_CSI_PER_PHY			4
> +#define FSD_CSIS_MAX_VC				4
> +#define FSD_CSIS_NB_CLOCK			1
> +#define FSD_CSIS_DMA_COHERENT_MASK_SIZE		32
> +
> +#define FSD_CSIS_WMIN				48
> +#define FSD_CSIS_WMAX				1920
> +#define FSD_CSIS_HMIN				32
> +#define FSD_CSIS_HMAX				1200
> +#define FSD_CSIS_WALIGN				2
> +#define FSD_CSIS_HALIGN				0
> +#define FSD_CSIS_SALIGN				0
> +
> +#define FSD_CSIS_NB_INPUT			1
> +#define FSD_CSIS_NB_MIN_CH			1
> +#define FSD_CSIS_NB_DMA_OUT_CH			8
> +
> +/* There are ACLK, PCLK clocks for each CSI block */
> +#define MAX_FSD_CSIS_CLOKCS			2
> +
> +#define DPHYON_DATA3				BIT(DATALANE3)
> +#define DPHYON_DATA2				BIT(DATALANE2)
> +#define DPHYON_DATA1				BIT(DATALANE1)
> +#define DPHYON_DATA0				BIT(DATALANE0)
> +
> +/* PHY Common control registers */
> +#define S_BYTE_CLK_ENABLE			0x1
> +#define S_DPDN_SWAP_CLK_ENABLE			0x1
> +#define S_DPDN_SWAP_DAT_ENABLE			0x1
> +#define ENABLE_DAT(nb)				((1 << (nb)) - 1)
> +#define ENABLE_CLK				0x1
> +
> +/*
> + * DMA Channel registers
> + */
> +#define DMA_CH_OFFSET				0x100
> +#define DMA_FRAME_ADDR_OFFSET			0x4
> +
> +/*
> + * Frame Counter registers
> + */
> +#define FRM_CNT_CH_OFFSET			0x4
> +
> +/*
> + * ISP configuration related registers
> + */
> +#define ISP_CH_OFFSET				0x10
> +
> +#define ISP_PIXEL_MODE_SINGLE			0x0
> +#define ISP_PIXEL_MODE_DUAL			0x1
> +#define ISP_PIXEL_MODE_QUAD			0x0
> +#define ISP_PIXEL_MODE_OCTA			0x3
> +#define ISP_CONFIG_RGB_SWAP			0x1
> +#define ISP_DATA_FORMAT_YUV420_8		0x18
> +#define ISP_DATA_FORMAT_YUV420_10		0x19
> +#define ISP_DATA_FORMAT_YUV420_8_LEGACY		0x1A
> +#define ISP_DATA_FORMAT_YUV420_8_CSPS		0x1C
> +#define ISP_DATA_FORMAT_YUV420_10_CSPS		0x1D
> +#define ISP_DATA_FORMAT_YUV422_8		0x1E
> +#define ISP_DATA_FORMAT_YUV422_10		0x1F
> +#define ISP_DATA_FORMAT_RGB565			0x22
> +#define ISP_DATA_FORMAT_RGB666			0x23
> +#define ISP_DATA_FORMAT_RGB888			0x24
> +#define ISP_DATA_FORMAT_RAW6			0x28
> +#define ISP_DATA_FORMAT_RAW7			0x29
> +#define ISP_DATA_FORMAT_RAW8			0x2A
> +#define ISP_DATA_FORMAT_RAW10			0x2B
> +#define ISP_DATA_FORMAT_RAW12			0x2C
> +#define ISP_DATA_FORMAT_RAW14			0x2D
> +#define ISP_DATA_FORMAT_RAW16			0x2E
> +#define ISP_DATA_FORMAT_RAW20			0x2F
> +#define ISP_DATA_FORMAT_USER_DEFINED_1		0x30
> +#define ISP_DATA_FORMAT_USER_DEFINED_2		0x31
> +#define ISP_DATA_FORMAT_USER_DEFINED_3		0x32
> +#define ISP_DATA_FORMAT_USER_DEFINED_4		0x33
> +#define ISP_DATA_FORMAT_USER_DEFINED_5		0x34
> +#define ISP_DATA_FORMAT_USER_DEFINED_6		0x35
> +#define ISP_DATA_FORMAT_USER_DEFINED_7		0x36
> +#define ISP_DATA_FORMAT_USER_DEFINED_8		0x37
> +
> +/*
> + * fsd_csis_fmt - structure holding the formats supported in CSI instance
> + * @name: string indicating name of format
> + * @fourcc: fourcc value of this format
> + * @colorspace: v4l2 colorspace for this format
> + * @code: media bus code for this format
> + * @depth: bits per pixel used for thsi format
> + */
> +struct fsd_csis_fmt {
> +	char name[32];
> +	u32 fourcc;
> +	u32 colorspace;
> +	u32 code;
> +	u32 depth;
> +};
> +
> +#define FSD_CSIS_MAX_FORMATS			20
> +
> +/*
> + * fsd_csis_buffer - buffer for one video frame
> + * @vb: video buffer information for v4l2
> + * @list: list of buffers to be used in VB2 operations
> + * @fmt: image format being used for this buffer
> + * @sequence: number indicating sequence in stream
> + */
> +struct fsd_csis_buffer {
> +	/* common v4l buffer stuff -- must be first */
> +	struct vb2_v4l2_buffer vb;
> +	struct list_head list;
> +	const struct fsd_csis_fmt *fmt;
> +	unsigned long sequence;
> +};
> +
> +/*
> + * csis_dmaqueue - DMA buffer queue of avalailable buffers for streaming
> + * @active: list of buffers avalailable for DMA
> + */
> +struct fsd_csis_dmaqueue {
> +	struct list_head active;
> +};
> +
> +enum {
> +	DPHY_MODE,
> +	CPHY_MODE
> +};
> +
> +enum FSD_CSIS_DATA {
> +	DATALANE0 = 0,
> +	DATALANE1,
> +	DATALANE2,
> +	DATALANE3
> +};
> +
> +enum FSD_CSIS_INTERLEAVE {
> +	VC0_ONLY = 0,
> +	DT_ONLY,
> +	VC_ONLY,
> +	VC_DT_BOTH
> +};
> +
> +enum FSD_CSIS_PIXEL_MODE {
> +	SINGLE_PIXEL_MODE,
> +	DUAL_PIXEL_MODE,
> +	QUAD_PIXEL_MODE,
> +	OCTA_PIXEL_MODE
> +};
> +
> +enum FSD_CSIS_PARALLEL_MODE {
> +	FSD_CSIS_PARALLEL_MODE_OFF,
> +	FSD_CSIS_PARALLEL_MODE_32_BIT,
> +	FSD_CSIS_PARALLEL_MODE_64_BIT,
> +	FSD_CSIS_PARALLEL_MODE_128_BIT
> +};
> +
> +/*
> + * fsd_csis_dev - CSI device structure. One for each CSI instance
> + * @device: pointer to core device structure provided by platform_device
> + * @info: device specific information (e.g. version)
> + * @ctx: CSIS context describing the individual stream and device properties.
> + * There is one context per virtual channel
> + * @clk: CSIS clocks that need to be set for streaming
> + * @v4l2_dev: V4L2 device instance for this CSIS I/F
> + * @ctrl_handler: Control handler to set Number of lanes, and lane configuration
> + * @mutex_csis_dma_reg: synchronization lock to update DMA addresses
> + * @id: this CSI device id
> + * @nb_data_lane: number of CSI data lanes in use for this CSI instance
> + * @nb_clocks: number of clocks to be prepared for CSI enable
> + * @base: base address of this CSI instance SFR
> + * @phy_base: base address of DC-PHY interface of this CSI instance
> + * @lane_speed: data rate at which CSI Rx lane is operating (in Mbps for D-PHY, Msps for C-PHY)
> + * @irq: interrupt number for this CSI instance
> + * @ip_is_on: boolean value indicating CSI instance is turned on
> + * @csis_sysreg_base: SYSREG_CSI base to set DC-PHY reset
> + * @stream_enabled: indicates if streaming is in progress
> + */
> +struct fsd_csis_dev {
> +	struct device *device;
> +	const struct fsd_csis_dev_info *info;
> +	struct fsd_csis_ctx *ctx[FSD_CSIS_MAX_VC];
> +	struct clk *clk[FSD_CSIS_NB_CLOCK];
> +	struct v4l2_device v4l2_dev;
> +	struct v4l2_ctrl_handler ctrl_handler;
> +	/* lock for adding VB2 buffers for DMA */
> +	struct mutex mutex_csis_dma_reg;
> +	unsigned int id;
> +	unsigned int nb_data_lane;
> +	unsigned int nb_clocks;
> +	void __iomem *base;
> +	void __iomem *phy_base;

This seems unused.

> +	struct regmap *sysreg_map;
> +	unsigned int lane_speed;
> +	int irq;
> +	bool ip_is_on;
> +	unsigned int stream_enabled;
> +};
> +
> +/*
> + * fsd_csis_ctx - CSI context information for stream in use
> + * @dev: pointer to parent device structure containing this context
> + * @mutex: VB2 Queue lock
> + * @mutex_buf: synchrnization lock used between VB2 buffer operations and the DMA queue
> + * @end_irq_worker: flag to allow IRQ worker thread to process stream buffers
> + * @input: input number to use VIDIOC_S_INPUT/VIDIOC_G_INPUT ioctls
> + * @v4l2_dev: v4l2 device instance for this context
> + * @sensor: Sub device to interface with sensor (1 for each CSIS I/F Channel)
> + * @vdev: video device node representing this stream
> + * @endpoint: fwnode graph endpoint for this CSI port
> + * @fh: handle for v4l2 file operations
> + * @timesperframe: minimum and maximum fps
> + * @vb_vidq: vb2 queue for this context
> + * @asd: Asynchronous sub device instances to bind
> + * @notifier: Notifier to bind sub device nodes
> + * @virtual_channel: CSI Virtual Channel ID in use
> + * @fmt: image format in use for this context
> + * @v_fmt: Used to store current pixel format
> + * @m_fmt: Used to store current mbus frame format
> + * @active_fmt: array of formats as supported by CSI and image sensor
> + * @num_active_fmt: number of active formats as given in active_fmt
> + * @vidq: video buffer queue being used by CSI DMA
> + * @frame: array of CSI buffers
> + * @frame_addr: array of DMA addresses of the CSI buffers
> + * @num_reqbufs: number of buffers as requested by user
> + * @prev_dma_ptr: previous DMA frame counter value
> + * @current_dma_ptr: present DMA frame counter value
> + * @number_of_ready_bufs: number of vb2 buffers available to be added to active list
> + * @prev_frame_counter: previous CSI frame counter value
> + * @current_frame_counter: current CSI frame counter value
> + * @csis_ctx_work: bottom half work queue structure used between
> + * CSI interrupt handler and streaming operations
> + * @sequence: number indicating sequence in stream
> + */
> +struct fsd_csis_ctx {
> +	struct fsd_csis_dev *dev;
> +	/* lock for vb2_queue buffers */
> +	struct mutex mutex;
> +	/**
> +	 * lock to synchronize buffer access between worker thread
> +	 * and buffer add/delete operations
> +	 */
> +	struct mutex mutex_buf;
> +	atomic_t end_irq_worker;
> +	unsigned int input;
> +	struct v4l2_device *v4l2_dev;
> +	struct v4l2_subdev *sensor;
> +	struct video_device vdev;
> +	struct v4l2_fwnode_endpoint endpoint;
> +	struct v4l2_fh fh;
> +	struct v4l2_fract timesperframe;
> +	struct vb2_queue vb_vidq;
> +	struct v4l2_async_subdev asd;
> +	struct v4l2_async_notifier notifier;
> +	unsigned int virtual_channel;
> +	const struct fsd_csis_fmt *fmt;
> +	struct v4l2_format v_fmt;
> +	struct v4l2_mbus_framefmt m_fmt;
> +	const struct fsd_csis_fmt *active_fmt[FSD_CSIS_MAX_FORMATS];
> +	unsigned int num_active_fmt;
> +	struct fsd_csis_dmaqueue vidq;
> +	struct fsd_csis_buffer *frame[FSD_CSIS_NB_DMA_OUT_CH];
> +	u64 frame_addr[FSD_CSIS_NB_DMA_OUT_CH];
> +	u8 prev_dma_ptr;
> +	u8 current_dma_ptr;
> +	u8 number_of_ready_bufs;
> +	u32 prev_frame_counter;
> +	u32 current_frame_counter;
> +	unsigned long sequence;
> +	u32 dma_error;
> +	struct work_struct csis_ctx_work;
> +};
> +
> +/*
> + * fsd_csis_dev_info - CSIS device information
> + * @version: FSD CSIS IP version
> + * @nb_clocks: number of clocks needed for the driver
> + * @clk_names: clock names
> + */
> +struct fsd_csis_dev_info {
> +	unsigned int	version;
> +	unsigned int	nb_clocks;
> +	const char	*clk_names[MAX_FSD_CSIS_CLOKCS];
> +};
> +
> +static inline unsigned int get_bits(unsigned int val, unsigned int mask)
> +{
> +	u32 value = val;
> +
> +	value &= mask;
> +	value >>= (ffs(mask) - 1);
> +	return value;
> +}
> +
> +static inline unsigned int set_bits(unsigned int val, unsigned int mask)
> +{
> +	u32 value = val;
> +
> +	value <<= (ffs(mask) - 1);
> +	value &= mask;
> +	return value;
> +}
> +
> +#define reset_bits(mask)			(~(mask))
> +
> +static inline unsigned char fsd_csis_current_dma_ptr(struct fsd_csis_ctx *ctx)
> +{
> +	unsigned int dma_act_ctrl = 0;
> +
> +	dma_act_ctrl = readl(ctx->dev->base + DMA0_ACT_CTRL + DMA_CH_OFFSET * ctx->virtual_channel);
> +	return get_bits(dma_act_ctrl, ACTIVE_DMA_FRAMEPTR_MASK);
> +}
> +
> +static inline unsigned int fsd_csis_current_frame_counter(struct fsd_csis_ctx *ctx)
> +{
> +	return readl(ctx->dev->base + FRM_CNT_CH0 + FRM_CNT_CH_OFFSET * ctx->virtual_channel);
> +}
> +
> +#define ctx_stream_enabled(ctx)			((ctx)->dev->stream_enabled & \
> +							(1 << (ctx)->virtual_channel))
> +
> +#define fsd_csis_dbg(level, dev, fmt, arg...)   \
> +		v4l2_dbg(level, debug, &(dev)->v4l2_dev, fmt, ##arg)
> +
> +#define fsd_csis_warn(dev, fmt, arg...) \
> +		v4l2_warn(&(dev)->v4l2_dev, fmt, ##arg)
> +
> +#define fsd_csis_info(dev, fmt, arg...) \
> +		v4l2_info(&(dev)->v4l2_dev, fmt, ##arg)
> +
> +#define fsd_csis_err(dev, fmt, arg...)  \
> +		v4l2_err(&(dev)->v4l2_dev, fmt, ##arg)
> +
> +#define fsd_csis_ctx_dbg(level, ctx, fmt, arg...)	\
> +		v4l2_dbg(level, debug, (ctx)->v4l2_dev, fmt, ##arg)
> +
> +#define fsd_csis_ctx_info(ctx, fmt, arg...)      \
> +		v4l2_info((ctx)->v4l2_dev, fmt, ##arg)
> +
> +#define fsd_csis_ctx_err(ctx, fmt, arg...)       \
> +		v4l2_err((ctx)->v4l2_dev, fmt, ##arg)

Let's not reinvent the wheel, and use dev_dbg(), dev_info(), ...
explicitly in the code instead.

> +
> +#define bytes_per_line(width, bpp)	DIV_ROUND_UP((width) * (bpp), 8)
> +

Any reason for all these functions and macros to be in the header
instead of the .c file ?

> +#endif /* _FSD_CSIS_H */
> diff --git a/include/uapi/linux/fsd-csis.h b/include/uapi/linux/fsd-csis.h
> new file mode 100644
> index 000000000000..ea90f805ad96
> --- /dev/null
> +++ b/include/uapi/linux/fsd-csis.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * FSD MIPI CSI2 Rx controller - User-space API
> + */
> +#ifndef __LINUX_FSD_CSIS_H_
> +#define __LINUX_FSD_CSIS_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +#include <linux/v4l2-controls.h>
> +
> +/*
> + * Custom controls
> + *
> + * V4L2_CID_USER_FSD_CSIS_NO_OF_LANE: Set number of D-PHY data lanes (1~4)
> + */
> +#define V4L2_CID_USER_FSD_CSIS_NO_OF_LANE	(V4L2_CID_USER_FSD_CSIS_BASE + 0)
> +
> +#endif /* __LINUX_FSD_CSIS_H_ */
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index b5e7d082b8ad..e9b1dc242cb1 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -231,6 +231,11 @@ enum v4l2_colorfx {
>   */
>  #define V4L2_CID_USER_DW100_BASE		(V4L2_CID_USER_BASE + 0x1190)
>  
> +/* The base for the fsd CSI driver controls.
> + * We reserve 16 controls for this driver.
> + */
> +#define V4L2_CID_USER_FSD_CSIS_BASE		(V4L2_CID_USER_BASE + 0x10a0)
> +
>  /* MPEG-class control IDs */
>  /* The MPEG controls are applicable to all codec controls
>   * and the 'MPEG' part of the define is historical */

-- 
Regards,

Laurent Pinchart
