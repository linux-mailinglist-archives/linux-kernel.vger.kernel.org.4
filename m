Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1C6CB935
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjC1IU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjC1IUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:20:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5614844A2;
        Tue, 28 Mar 2023 01:20:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32S8K24k016605;
        Tue, 28 Mar 2023 03:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679991602;
        bh=/NuN0ahjnPMu7a6d126Tk/zT6PMRa24oU5YesNaIbyc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=MjRIytJeHk3wx6IBYbpOXbv7HXXuxU+lEa2Sx/Jb3VOcTX0EQwhR527rvdv7g0c0j
         j9lV1rzd/hcwjKJZfJ4+sARqW0ADPlKeXneAUrlqTM+xkb8CZO+acBYCIYgxZ+dVn/
         XD/s2fmEuBFz64V3vb7vMWUkJR552lG8oVW+EGyQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32S8K2m2033238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 03:20:02 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 03:20:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 03:20:02 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32S8JtlW073145;
        Tue, 28 Mar 2023 03:19:56 -0500
Message-ID: <08f5ad11-979d-8f4a-9dab-d51c5586703c@ti.com>
Date:   Tue, 28 Mar 2023 13:49:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 10/13] media: ti: Add CSI2RX support for J721E
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mripard@kernel.org>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <martyn.welch@collabora.com>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-11-vaishnav.a@ti.com>
 <20230324181425.GM18895@pendragon.ideasonboard.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230324181425.GM18895@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the review,

On 24/03/23 23:44, Laurent Pinchart wrote:
> Hi Vaishnav,
> 
> Thank you for the patch.
> 
> On Tue, Mar 14, 2023 at 05:25:13PM +0530, Vaishnav Achath wrote:
>> From: Pratyush Yadav <p.yadav@ti.com>
>>
>> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
>> capture over a CSI-2 bus.
>>
>> The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
>> the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
>> called the SHIM layer. It takes in data from stream 0, repacks it, and
>> sends it to memory over PSI-L DMA.
>>
>> This driver acts as the "front end" to V4L2 client applications. It
>> implements the required ioctls and buffer operations, passes the
>> necessary calls on to the bridge, programs the SHIM layer, and performs
>> DMA via the dmaengine API to finally return the data to a buffer
>> supplied by the application.
>>
>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>
>> Changes in v7:
>> - Fix incorrect value written in SHIM_PSI_CFG0_DST_TAG
>> - Drop support for 2X8 formats.
>> - Update maintainer to Vaishnav as Pratyush moved out of TI.
>> - Address Sakari's review comments:
>> - Update MAX_HEIGHT_LINES, MAX_WIDTH_BYTES to prevent overflow.
>> - Assign dma_slave_config during declaration, drop memset().
>> - dma_release_channel() on slave_config failure.
>> - provide entity ops for the vdev entity with link_validate().
>> - mutex_destroy() on ti_csi2rx_probe failure path.
>> - Drop busy check in remove().
>> - mutex_destroy() in ti_csi2rx_remove().
>> - Address Laurent's review comments:
>> - Update entries in Makefile in alphabetical order.
>> - include headers in alphabetical order.
>> - Drop redundant CSI DT defines and use from media/mipi-csi2.h.
>> - Rename csi_df to csi_dt.
>> - Drop v4l2_colorspace from ti_csi2rx_fmt and set default in
>>   ti_csi2rx_v4l2_init()
>> - Adjust field and not return EINVAL in ti_csi2rx_try_fmt_vid_cap().
>> - inline ti_csi2rx_video_register().
>> - start DMA before starting source subdev.
>> - move buffer cleanup to separate function ti_csi2rx_cleanup_buffers()
>>   to be used in ti_csi2rx_stop_streaming() and ti_csi2rx_start_streaming()
>>   failure path.
>> - Drop VB2_USERPTR, VB2_READ and V4L2_CAP_READWRITE.
>>
>> Changes in v5:
>> - Add dependency on PHY_CADENCE_DPHY_RX instead of PHY_CADENCE_DPHY
>>   since the Rx mode DPHY now has a separate driver.
>> - Drop ti_csi2rx_validate_pipeline(). Pipeline validation should be done
>>   at media_pipeline_start().
>> - Do not assign flags.
>> - Fix error handling in ti_csi2rx_start_streaming(). Free up vb2 buffers
>>   when media_pipeline_start() fails.
>>
>> Changes in v4:
>> - Acquire the media device's graph_mutex before starting the graph walk.
>> - Call media_graph_walk_init() and media_graph_walk_cleanup() when
>>   starting and ending the graph walk respectively.
>> - Reduce max frame height and width in enum_framesizes. Currently they
>>   are set to UINT_MAX but they must be a multiple of step_width, so they
>>   need to be rounded down. Also, these values are absurdly large which
>>   causes some userspace applications like gstreamer to trip up. While it
>>   is not generally right to change the kernel for an application bug, it
>>   is not such a big deal here. This change is replacing one set of
>>   absurdly large arbitrary values with another set of smaller but still
>>   absurdly large arbitrary values. Both limits are unlikely to be hit in
>>   practice.
>>
>> Changes in v3:
>> - Move DMA related fields in struct ti_csi2rx_dma.
>> - Protect DMA buffer queue with a spinlock to make sure the queue buffer
>>   and DMA callback don't race on it.
>> - Track the current DMA state. It might go idle because of a lack of
>>   buffers. This state can be used to restart it if needed.
>> - Do not include the current buffer in the pending queue. It is slightly
>>   better modelling than leaving it at the head of the pending queue.
>> - Use the buffer as the callback argument, and add a reference to csi in it.
>> - If queueing a buffer to DMA fails, the buffer gets leaked and DMA gets
>>   stalled with. Instead, report the error to vb2 and queue the next
>>   buffer in the pending queue.
>> - DMA gets stalled if we run out of buffers since the callback is the
>>   only one that fires subsequent transfers and it is no longer being
>>   called. Check for that when queueing buffers and restart DMA if
>>   needed.
>> - Do not put of node until we are done using the fwnode.
>> - Set inital format to UYVY 640x480.
>>
>> Changes in v2:
>> - Use dmaengine_get_dma_device() instead of directly accessing
>>   dma->device->dev.
>> - Do not set dst_addr_width when configuring slave DMA.
>> - Move to a separate subdir and rename to j721e-csi2rx.c
>> - Convert compatible to ti,j721e-csi2rx.
>> - Move to use Media Controller centric APIs.
>> - Improve cleanup in probe when one of the steps fails.
>> - Add colorspace to formats database.
>> - Set hw_revision on media_device.
>> - Move video device initialization to probe time instead of register time.
>>
>>  MAINTAINERS                                   |    6 +
>>  drivers/media/platform/ti/Kconfig             |   12 +
>>  drivers/media/platform/ti/Makefile            |    1 +
>>  .../media/platform/ti/j721e-csi2rx/Makefile   |    2 +
>>  .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 1022 +++++++++++++++++
>>  5 files changed, 1043 insertions(+)
>>  create mode 100644 drivers/media/platform/ti/j721e-csi2rx/Makefile
>>  create mode 100644 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2892858cb040..69c2b0f48073 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20901,6 +20901,12 @@ S:	Odd Fixes
>>  F:	drivers/clk/ti/
>>  F:	include/linux/clk/ti.h
>>  
>> +TI J721E CSI2RX DRIVER
>> +M:	Vaishnav Achath <vaishnav.a@ti.com>
>> +L:	linux-media@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/media/platform/ti/j721e-csi2rx/
>> +
>>  TI DAVINCI MACHINE SUPPORT
>>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>> diff --git a/drivers/media/platform/ti/Kconfig b/drivers/media/platform/ti/Kconfig
>> index e1ab56c3be1f..42c908f6e1ae 100644
>> --- a/drivers/media/platform/ti/Kconfig
>> +++ b/drivers/media/platform/ti/Kconfig
>> @@ -63,6 +63,18 @@ config VIDEO_TI_VPE_DEBUG
>>  	help
>>  	  Enable debug messages on VPE driver.
>>  
>> +config VIDEO_TI_J721E_CSI2RX
>> +	tristate "TI J721E CSI2RX wrapper layer driver"
>> +	depends on VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
>> +	depends on MEDIA_SUPPORT && MEDIA_CONTROLLER
>> +	depends on PHY_CADENCE_DPHY_RX && VIDEO_CADENCE_CSI2RX
>> +	depends on ARCH_K3 || COMPILE_TEST
>> +	select VIDEOBUF2_DMA_CONTIG
>> +	select V4L2_FWNODE
>> +	help
>> +	  Support for TI CSI2RX wrapper layer. This just enables the wrapper driver.
>> +	  The Cadence CSI2RX bridge driver needs to be enabled separately.
>> +
>>  source "drivers/media/platform/ti/am437x/Kconfig"
>>  source "drivers/media/platform/ti/davinci/Kconfig"
>>  source "drivers/media/platform/ti/omap/Kconfig"
>> diff --git a/drivers/media/platform/ti/Makefile b/drivers/media/platform/ti/Makefile
>> index 98c5fe5c40d6..8a2f74c9380e 100644
>> --- a/drivers/media/platform/ti/Makefile
>> +++ b/drivers/media/platform/ti/Makefile
>> @@ -3,5 +3,6 @@ obj-y += am437x/
>>  obj-y += cal/
>>  obj-y += vpe/
>>  obj-y += davinci/
>> +obj-y += j721e-csi2rx/
>>  obj-y += omap/
>>  obj-y += omap3isp/
>> diff --git a/drivers/media/platform/ti/j721e-csi2rx/Makefile b/drivers/media/platform/ti/j721e-csi2rx/Makefile
>> new file mode 100644
>> index 000000000000..377afc1d6280
>> --- /dev/null
>> +++ b/drivers/media/platform/ti/j721e-csi2rx/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_VIDEO_TI_J721E_CSI2RX) += j721e-csi2rx.o
>> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> new file mode 100644
>> index 000000000000..0c8dad049f5b
>> --- /dev/null
>> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> @@ -0,0 +1,1022 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * TI CSI2 RX driver.
>> + *
>> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
>> + *
>> + * Author: Pratyush Yadav <p.yadav@ti.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <media/mipi-csi2.h>
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-ioctl.h>
>> +#include <media/videobuf2-dma-contig.h>
>> +
>> +#define TI_CSI2RX_MODULE_NAME		"j721e-csi2rx"
>> +
>> +#define SHIM_CNTL			0x10
>> +#define SHIM_CNTL_PIX_RST		BIT(0)
>> +
>> +#define SHIM_DMACNTX			0x20
>> +#define SHIM_DMACNTX_EN			BIT(31)
>> +#define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
>> +#define SHIM_DMACNTX_FMT		GENMASK(5, 0)
>> +#define SHIM_DMACNTX_UYVY		0
>> +#define SHIM_DMACNTX_VYUY		1
>> +#define SHIM_DMACNTX_YUYV		2
>> +#define SHIM_DMACNTX_YVYU		3
>> +
>> +#define SHIM_PSI_CFG0			0x24
>> +#define SHIM_PSI_CFG0_SRC_TAG		GENMASK(15, 0)
>> +#define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 15)
>> +
>> +#define PSIL_WORD_SIZE_BYTES		16
>> +/*
>> + * There are no hard limits on the width or height. The DMA engine can handle
>> + * all sizes. The max width and height are arbitrary numbers for this driver.
>> + * Use 16K * 16K as the arbitrary limit. It is large enough that it is unlikely
>> + * the limit will be hit in practice.
>> + */
>> +#define MAX_WIDTH_BYTES			SZ_16K
>> +#define MAX_HEIGHT_LINES		SZ_16K
>> +
>> +struct ti_csi2rx_fmt {
>> +	u32				fourcc;	/* Four character code. */
>> +	u32				code;	/* Mbus code. */
>> +	u32				csi_dt;	/* CSI Data type. */
>> +	u8				bpp;	/* Bits per pixel. */
>> +};
>> +
>> +struct ti_csi2rx_buffer {
>> +	/* Common v4l2 buffer. Must be first. */
>> +	struct vb2_v4l2_buffer		vb;
>> +	struct list_head		list;
>> +	struct ti_csi2rx_dev		*csi;
>> +};
>> +
>> +enum ti_csi2rx_dma_state {
>> +	TI_CSI2RX_DMA_STOPPED,	/* Streaming not started yet. */
>> +	TI_CSI2RX_DMA_IDLE,	/* Streaming but no pending DMA operation. */
>> +	TI_CSI2RX_DMA_ACTIVE,	/* Streaming and pending DMA operation. */
>> +};
>> +
>> +struct ti_csi2rx_dma {
>> +	/* Protects all fields in this struct. */
>> +	spinlock_t			lock;
>> +	struct dma_chan			*chan;
>> +	/* Buffers queued to the driver, waiting to be processed by DMA. */
>> +	struct list_head		queue;
>> +	enum ti_csi2rx_dma_state	state;
>> +	/*
>> +	 * Current buffer being processed by DMA. NULL if no buffer is being
>> +	 * processed.
>> +	 */
>> +	struct ti_csi2rx_buffer		*curr;
>> +};
>> +
>> +struct ti_csi2rx_dev {
>> +	struct device			*dev;
>> +	void __iomem			*shim;
>> +	struct v4l2_device		v4l2_dev;
>> +	struct video_device		vdev;
>> +	struct media_device		mdev;
>> +	struct media_pipeline		pipe;
>> +	struct media_pad		pad;
>> +	struct v4l2_async_notifier	notifier;
>> +	struct v4l2_subdev		*subdev;
>> +	struct vb2_queue		vidq;
>> +	struct mutex			mutex; /* To serialize ioctls. */
>> +	struct v4l2_format		v_fmt;
>> +	struct ti_csi2rx_dma		dma;
>> +	u32				sequence;
>> +};
>> +
>> +static const struct ti_csi2rx_fmt formats[] = {
>> +	{
>> +		.fourcc			= V4L2_PIX_FMT_YUYV,
>> +		.code			= MEDIA_BUS_FMT_YUYV8_1X16,
>> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
>> +		.bpp			= 16,
>> +	}, {
>> +		.fourcc			= V4L2_PIX_FMT_UYVY,
>> +		.code			= MEDIA_BUS_FMT_UYVY8_1X16,
>> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
>> +		.bpp			= 16,
>> +	}, {
>> +		.fourcc			= V4L2_PIX_FMT_YVYU,
>> +		.code			= MEDIA_BUS_FMT_YVYU8_1X16,
>> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
>> +		.bpp			= 16,
>> +	}, {
>> +		.fourcc			= V4L2_PIX_FMT_VYUY,
>> +		.code			= MEDIA_BUS_FMT_VYUY8_1X16,
>> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
>> +		.bpp			= 16,
>> +	},
>> +
>> +	/* More formats can be supported but they are not listed for now. */
>> +};
>> +
>> +static const unsigned int num_formats = ARRAY_SIZE(formats);
>> +
>> +/* Forward declaration needed by ti_csi2rx_dma_callback. */
>> +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
>> +			       struct ti_csi2rx_buffer *buf);
>> +
>> +static const struct ti_csi2rx_fmt *find_format_by_pix(u32 pixelformat)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < num_formats; i++) {
>> +		if (formats[i].fourcc == pixelformat)
>> +			return &formats[i];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static const struct ti_csi2rx_fmt *find_format_by_code(u32 code)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < num_formats; i++) {
>> +		if (formats[i].code == code)
>> +			return &formats[i];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static void ti_csi2rx_fill_fmt(const struct ti_csi2rx_fmt *csi_fmt,
>> +			       struct v4l2_format *v4l2_fmt)
>> +{
>> +	struct v4l2_pix_format *pix = &v4l2_fmt->fmt.pix;
>> +	unsigned int pixels_in_word;
>> +	u8 bpp = csi_fmt->bpp;
>> +	u32 bpl;
>> +
>> +	/* TODO: Figure this out. */
> 
> Figure what out ? :-) Please expand this comment to explain what needs
> to be done.
> 

Will fix this in next revision.

>> +
>> +	pixels_in_word = PSIL_WORD_SIZE_BYTES * 8 / bpp;
>> +
>> +	pix->width = clamp_t(unsigned int, pix->width,
>> +			     pixels_in_word,
>> +			     MAX_WIDTH_BYTES * 8 / bpp);
>> +	pix->width = rounddown(pix->width, pixels_in_word);
>> +
>> +	pix->height = clamp_t(unsigned int, pix->height, 1, MAX_HEIGHT_LINES);
>> +
>> +	v4l2_fmt->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +	pix->pixelformat = csi_fmt->fourcc;
>> +	pix->colorspace = V4L2_COLORSPACE_SRGB;
>> +	pix->sizeimage = pix->height * pix->width * (bpp / 8);
>> +
>> +	bpl = (pix->width * ALIGN(bpp, 8)) >> 3;
>> +	pix->bytesperline = ALIGN(bpl, 16);
>> +}
>> +
>> +static int ti_csi2rx_querycap(struct file *file, void *priv,
>> +			      struct v4l2_capability *cap)
>> +{
>> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
>> +
>> +	strscpy(cap->driver, TI_CSI2RX_MODULE_NAME, sizeof(cap->driver));
>> +	strscpy(cap->card, TI_CSI2RX_MODULE_NAME, sizeof(cap->card));
>> +
>> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
>> +		 dev_name(csi->dev));
> 
> https://lore.kernel.org/linux-media/20220122163656.168440-1-sakari.ailus@linux.intel.com/
> has been merged in v5.19, so you don't need to set bus_info manually
> anymore.
> 

Okay, I will update here and the rest of the places for this change.

>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
>> +				      struct v4l2_fmtdesc *f)
>> +{
>> +	if (f->index >= num_formats)
>> +		return -EINVAL;
>> +
>> +	memset(f->reserved, 0, sizeof(f->reserved));
>> +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +	f->pixelformat = formats[f->index].fourcc;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_g_fmt_vid_cap(struct file *file, void *prov,
>> +				   struct v4l2_format *f)
>> +{
>> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
>> +
>> +	*f = csi->v_fmt;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_try_fmt_vid_cap(struct file *file, void *priv,
>> +				     struct v4l2_format *f)
>> +{
>> +	const struct ti_csi2rx_fmt *fmt;
>> +
>> +	/*
>> +	 * Default to the first format if the requested pixel format code isn't
>> +	 * supported.
>> +	 */
>> +	fmt = find_format_by_pix(f->fmt.pix.pixelformat);
>> +	if (!fmt)
>> +		fmt = &formats[0];
>> +
>> +	if (f->fmt.pix.field == V4L2_FIELD_ANY)
>> +		f->fmt.pix.field = V4L2_FIELD_NONE;
>> +
>> +	if (f->fmt.pix.field != V4L2_FIELD_NONE)
>> +		/* Interlaced formats are not supported. */
>> +		f->fmt.pix.field = V4L2_FIELD_NONE;
>> +
>> +	ti_csi2rx_fill_fmt(fmt, f);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_s_fmt_vid_cap(struct file *file, void *priv,
>> +				   struct v4l2_format *f)
>> +{
>> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
>> +	struct vb2_queue *q = &csi->vidq;
>> +	int ret;
>> +
>> +	if (vb2_is_busy(q))
>> +		return -EBUSY;
>> +
>> +	ret = ti_csi2rx_try_fmt_vid_cap(file, priv, f);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	csi->v_fmt = *f;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_enum_framesizes(struct file *file, void *fh,
>> +				     struct v4l2_frmsizeenum *fsize)
>> +{
>> +	const struct ti_csi2rx_fmt *fmt;
>> +	unsigned int pixels_in_word;
>> +	u8 bpp;
>> +
>> +	fmt = find_format_by_pix(fsize->pixel_format);
>> +	if (!fmt)
>> +		return -EINVAL;
>> +
>> +	bpp = ALIGN(fmt->bpp, 8);
>> +
>> +	/*
>> +	 * Number of pixels in one PSI-L word. The transfer happens in multiples
>> +	 * of PSI-L word sizes.
>> +	 */
>> +	pixels_in_word = PSIL_WORD_SIZE_BYTES * 8 / bpp;
>> +
>> +	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
>> +	fsize->stepwise.min_width = pixels_in_word;
>> +	fsize->stepwise.max_width = rounddown(MAX_WIDTH_BYTES * 8 / bpp,
>> +					      pixels_in_word);
>> +	fsize->stepwise.step_width = pixels_in_word;
>> +	fsize->stepwise.min_height = 1;
>> +	fsize->stepwise.max_height = MAX_HEIGHT_LINES;
>> +	fsize->stepwise.step_height = 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct v4l2_ioctl_ops csi_ioctl_ops = {
>> +	.vidioc_querycap      = ti_csi2rx_querycap,
>> +	.vidioc_enum_fmt_vid_cap = ti_csi2rx_enum_fmt_vid_cap,
>> +	.vidioc_try_fmt_vid_cap = ti_csi2rx_try_fmt_vid_cap,
>> +	.vidioc_g_fmt_vid_cap = ti_csi2rx_g_fmt_vid_cap,
>> +	.vidioc_s_fmt_vid_cap = ti_csi2rx_s_fmt_vid_cap,
>> +	.vidioc_enum_framesizes = ti_csi2rx_enum_framesizes,
>> +	.vidioc_reqbufs       = vb2_ioctl_reqbufs,
>> +	.vidioc_create_bufs   = vb2_ioctl_create_bufs,
>> +	.vidioc_prepare_buf   = vb2_ioctl_prepare_buf,
>> +	.vidioc_querybuf      = vb2_ioctl_querybuf,
>> +	.vidioc_qbuf          = vb2_ioctl_qbuf,
>> +	.vidioc_dqbuf         = vb2_ioctl_dqbuf,
>> +	.vidioc_expbuf        = vb2_ioctl_expbuf,
>> +	.vidioc_streamon      = vb2_ioctl_streamon,
>> +	.vidioc_streamoff     = vb2_ioctl_streamoff,
>> +};
>> +
>> +static const struct v4l2_file_operations csi_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = v4l2_fh_open,
>> +	.release = vb2_fop_release,
>> +	.read = vb2_fop_read,
>> +	.poll = vb2_fop_poll,
>> +	.unlocked_ioctl = video_ioctl2,
>> +	.mmap = vb2_fop_mmap,
>> +};
>> +
>> +static inline int ti_csi2rx_video_register(struct ti_csi2rx_dev *csi)
> 
> You can drop the "inline" keyword, the compiler will inline the function
> automatically if it believes it makes sense.
> 

Will fix in next revision.

>> +{
>> +	struct video_device *vdev = &csi->vdev;
>> +	int ret, src_pad;
>> +
>> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	src_pad = media_entity_get_fwnode_pad(&csi->subdev->entity,
>> +					      csi->subdev->fwnode,
>> +					      MEDIA_PAD_FL_SOURCE);
>> +	if (src_pad < 0) {
>> +		dev_err(csi->dev, "Couldn't find source pad for subdev\n");
>> +		return src_pad;
>> +	}
>> +
>> +	ret = media_create_pad_link(&csi->subdev->entity, src_pad,
>> +				    &vdev->entity, 0,
>> +				    MEDIA_LNK_FL_IMMUTABLE |
>> +				    MEDIA_LNK_FL_ENABLED);
>> +	if (ret) {
>> +		video_unregister_device(vdev);
>> +		return ret;
>> +	}
> 
> I've sent a patch that makes v4l2_create_fwnode_links_to_pad() usable
> when the sink is not a subdev. Could you test it to see if it can
> simplify this function ?
> 

Sure, I am testing the changes now.

>> +
>> +	return 0;
>> +}
>> +
>> +static int csi_async_notifier_bound(struct v4l2_async_notifier *notifier,
>> +				    struct v4l2_subdev *subdev,
>> +				    struct v4l2_async_subdev *asd)
>> +{
>> +	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
>> +
>> +	csi->subdev = subdev;
>> +
>> +	return 0;
>> +}
>> +
>> +static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
>> +{
>> +	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
>> +	int ret;
>> +
>> +	ret = ti_csi2rx_video_register(csi);
> 
> I commented on the previous version with
> 
>   I would inline the ti_csi2rx_video_register() function here, it's not
>   large, and it's only called in a single place.
> 
> which I assume you've understood as asking for the "inline" keyword
> above. What I meant was to take the contents of the
> ti_csi2rx_video_register() function and move them into this function.
> 

Understood now, Thanks for clarifying.

>> +	if (ret)
>> +		return ret;
>> +
>> +	return v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
>> +}
>> +
>> +static const struct v4l2_async_notifier_operations csi_async_notifier_ops = {
>> +	.bound = csi_async_notifier_bound,
>> +	.complete = csi_async_notifier_complete,
>> +};
>> +
>> +static int ti_csi2rx_init_subdev(struct ti_csi2rx_dev *csi)
>> +{
>> +	struct fwnode_handle *fwnode;
>> +	struct v4l2_async_subdev *asd;
>> +	struct device_node *node;
>> +	int ret;
>> +
>> +	node = of_get_child_by_name(csi->dev->of_node, "csi-bridge");
>> +	if (!node)
>> +		return -EINVAL;
>> +
>> +	fwnode = of_fwnode_handle(node);
>> +	if (!fwnode) {
>> +		of_node_put(node);
>> +		return -EINVAL;
>> +	}
>> +
>> +	v4l2_async_nf_init(&csi->notifier);
>> +	csi->notifier.ops = &csi_async_notifier_ops;
>> +
>> +	asd = v4l2_async_nf_add_fwnode(&csi->notifier, fwnode,
>> +				       struct v4l2_async_subdev);
>> +	of_node_put(node);
>> +	if (IS_ERR(asd)) {
>> +		v4l2_async_nf_cleanup(&csi->notifier);
>> +		return PTR_ERR(asd);
>> +	}
>> +
>> +	ret = v4l2_async_nf_register(&csi->v4l2_dev, &csi->notifier);
>> +	if (ret) {
>> +		v4l2_async_nf_cleanup(&csi->notifier);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void ti_csi2rx_setup_shim(struct ti_csi2rx_dev *csi)
>> +{
>> +	const struct ti_csi2rx_fmt *fmt;
>> +	unsigned int reg;
>> +
>> +	fmt = find_format_by_pix(csi->v_fmt.fmt.pix.pixelformat);
>> +	if (!fmt) {
>> +		dev_err(csi->dev, "Unknown format\n");
>> +		return;
>> +	}
>> +
>> +	/* De-assert the pixel interface reset. */
>> +	reg = SHIM_CNTL_PIX_RST;
>> +	writel(reg, csi->shim + SHIM_CNTL);
>> +
>> +	reg = SHIM_DMACNTX_EN;
>> +	reg |= FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
>> +
>> +	/*
>> +	 * Using the values from the documentation gives incorrect ordering for
>> +	 * the luma and chroma components. In practice, the "reverse" format
>> +	 * gives the correct image. So for example, if the image is in UYVY, the
>> +	 * reverse would be YVYU.
>> +	 */
>> +	switch (fmt->fourcc) {
>> +	case V4L2_PIX_FMT_UYVY:
>> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
>> +					SHIM_DMACNTX_YVYU);
>> +		break;
>> +	case V4L2_PIX_FMT_VYUY:
>> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
>> +					SHIM_DMACNTX_YUYV);
>> +		break;
>> +	case V4L2_PIX_FMT_YUYV:
>> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
>> +					SHIM_DMACNTX_VYUY);
>> +		break;
>> +	case V4L2_PIX_FMT_YVYU:
>> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
>> +					SHIM_DMACNTX_UYVY);
>> +		break;
>> +	default:
>> +		/* Ignore if not YUV 4:2:2 */
>> +		break;
>> +	}
>> +
>> +	writel(reg, csi->shim + SHIM_DMACNTX);
>> +
>> +	reg = FIELD_PREP(SHIM_PSI_CFG0_SRC_TAG, 0) |
>> +	      FIELD_PREP(SHIM_PSI_CFG0_DST_TAG, 0);
>> +	writel(reg, csi->shim + SHIM_PSI_CFG0);
>> +}
>> +
>> +static void ti_csi2rx_dma_callback(void *param)
>> +{
>> +	struct ti_csi2rx_buffer *buf = param;
>> +	struct ti_csi2rx_dev *csi = buf->csi;
>> +	struct ti_csi2rx_dma *dma = &csi->dma;
>> +	unsigned long flags;
>> +
>> +	buf->vb.vb2_buf.timestamp = ktime_get_ns();
>> +	buf->vb.sequence = csi->sequence++;
> 
> In a reply to the previous version, Pratyush mentioned that there is a
> register in the CSI2RX core that provides the frame number. While it may
> not be very straightforward to get the information from there, it would
> still be desirable. Could you please add a TODO comment to record this ?
> 

I will add the TODO to mention this, I think Pratyush was referring to the
MONITOR registers in the CSI2RX core, the approach would work fine for single
stream, but since the monitor registers can only monitor a single virtual
channel at a time this changes cannot be scaled for multi-stream support.

> 	/*
> 	 * TODO: Derive the sequence number from the CSI2RX frame number
> 	 * hardware register.
> 	 */
> 
>> +
>> +	spin_lock_irqsave(&dma->lock, flags);
>> +
>> +	WARN_ON(dma->curr != buf);
>> +	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
>> +
>> +	/* If there are more buffers to process then start their transfer. */
>> +	dma->curr = NULL;
>> +	while (!list_empty(&dma->queue)) {
>> +		buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
>> +		list_del(&buf->list);
>> +
>> +		if (ti_csi2rx_start_dma(csi, buf)) {
>> +			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
>> +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
>> +		} else {
>> +			dma->curr = buf;
>> +			break;
> 
> In the same reply, Pratyush also mentioned that all pending buffers
> should be queued to the DMA engine here.
> 

I will add the change for queueing all pending buffers in the next revision,
sorry, this was missed.

>> +		}
>> +	}
>> +
>> +	if (!dma->curr)
>> +		dma->state = TI_CSI2RX_DMA_IDLE;
>> +
>> +	spin_unlock_irqrestore(&dma->lock, flags);
>> +}
>> +
>> +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
>> +			       struct ti_csi2rx_buffer *buf)
>> +{
>> +	unsigned long addr;
>> +	struct dma_async_tx_descriptor *desc;
>> +	size_t len = csi->v_fmt.fmt.pix.sizeimage;
>> +	dma_cookie_t cookie;
>> +	int ret = 0;
>> +
>> +	addr = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
>> +	desc = dmaengine_prep_slave_single(csi->dma.chan, addr, len,
>> +					   DMA_DEV_TO_MEM,
>> +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> +	if (!desc)
>> +		return -EIO;
>> +
>> +	desc->callback = ti_csi2rx_dma_callback;
>> +	desc->callback_param = buf;
>> +
>> +	cookie = dmaengine_submit(desc);
>> +	ret = dma_submit_error(cookie);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dma_async_issue_pending(csi->dma.chan);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_dev *csi,
>> +				      enum vb2_buffer_state state)
>> +{
>> +	struct ti_csi2rx_dma *dma = &csi->dma;
>> +	struct ti_csi2rx_buffer *buf = NULL, *tmp;
> 
> No need to initialize buf to NULL.
> 
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&dma->lock, flags);
>> +	list_for_each_entry_safe(buf, tmp, &csi->dma.queue, list) {
>> +		list_del(&buf->list);
>> +		vb2_buffer_done(&buf->vb.vb2_buf, state);
>> +	}
>> +
>> +	if (dma->curr)
>> +		vb2_buffer_done(&dma->curr->vb.vb2_buf, state);
>> +
>> +	dma->curr = NULL;
>> +	dma->state = TI_CSI2RX_DMA_STOPPED;
>> +	spin_unlock_irqrestore(&dma->lock, flags);
>> +}
>> +
>> +static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
>> +				 unsigned int *nplanes, unsigned int sizes[],
>> +				 struct device *alloc_devs[])
>> +{
>> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(q);
>> +	unsigned int size = csi->v_fmt.fmt.pix.sizeimage;
>> +
>> +	if (*nplanes) {
>> +		if (sizes[0] < size)
>> +			return -EINVAL;
>> +		size = sizes[0];
>> +	}
>> +
>> +	*nplanes = 1;
>> +	sizes[0] = size;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_buffer_prepare(struct vb2_buffer *vb)
>> +{
>> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vb->vb2_queue);
>> +	unsigned long size = csi->v_fmt.fmt.pix.sizeimage;
>> +
>> +	if (vb2_plane_size(vb, 0) < size) {
>> +		dev_err(csi->dev, "Data will not fit into plane\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	vb2_set_plane_payload(vb, 0, size);
>> +	return 0;
>> +}
>> +
>> +static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
>> +{
>> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vb->vb2_queue);
>> +	struct ti_csi2rx_buffer *buf;
>> +	struct ti_csi2rx_dma *dma = &csi->dma;
>> +	unsigned long flags = 0;
>> +	int ret;
>> +
>> +	buf = container_of(vb, struct ti_csi2rx_buffer, vb.vb2_buf);
>> +	buf->csi = csi;
>> +
>> +	spin_lock_irqsave(&dma->lock, flags);
>> +	/*
>> +	 * Usually the DMA callback takes care of queueing the pending buffers.
>> +	 * But if DMA has stalled due to lack of buffers, restart it now.
>> +	 */
>> +	if (dma->state == TI_CSI2RX_DMA_IDLE) {
>> +		ret = ti_csi2rx_start_dma(csi, buf);
>> +		if (ret) {
>> +			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
>> +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
>> +			goto unlock;
>> +		}
>> +
>> +		dma->curr = buf;
>> +		dma->state = TI_CSI2RX_DMA_ACTIVE;
>> +	} else {
>> +		list_add_tail(&buf->list, &dma->queue);
>> +	}
>> +
>> +unlock:
>> +	spin_unlock_irqrestore(&dma->lock, flags);
>> +}
>> +
>> +static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
>> +{
>> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
>> +	struct ti_csi2rx_dma *dma = &csi->dma;
>> +	struct ti_csi2rx_buffer *buf;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	spin_lock_irqsave(&dma->lock, flags);
>> +	if (list_empty(&dma->queue))
>> +		ret = -EIO;
>> +	spin_unlock_irqrestore(&dma->lock, flags);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = media_pipeline_start(&csi->vdev.entity.pads[0], &csi->pipe);
> 
> Please use the video_device_pipeline_start() helper for video nodes.
> Same for media_pipeline_stop(), there's now
> video_device_pipeline_stop().
> 

will update in next revision.

>> +	if (ret)
>> +		goto err;
>> +
>> +	ti_csi2rx_setup_shim(csi);
>> +
>> +	csi->sequence = 0;
>> +
>> +	spin_lock_irqsave(&dma->lock, flags);
>> +	buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
>> +	list_del(&buf->list);
>> +	dma->state = TI_CSI2RX_DMA_ACTIVE;
>> +	dma->curr = buf;
>> +
>> +	ret = ti_csi2rx_start_dma(csi, buf);
>> +	if (ret) {
>> +		dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
>> +		spin_unlock_irqrestore(&dma->lock, flags);
>> +		goto err_pipeline;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&dma->lock, flags);
>> +
>> +	ret = v4l2_subdev_call(csi->subdev, video, s_stream, 1);
>> +	if (ret)
>> +		goto err_dma;
>> +
>> +	return 0;
>> +
>> +err_dma:
>> +	dmaengine_terminate_sync(csi->dma.chan);
>> +	writel(0, csi->shim + SHIM_DMACNTX);
>> +err_pipeline:
>> +	media_pipeline_stop(&csi->vdev.entity.pads[0]);
>> +err:
>> +	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_QUEUED);
>> +	return ret;
>> +}
>> +
>> +static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
>> +{
>> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
>> +	int ret;
>> +
>> +	media_pipeline_stop(&csi->vdev.entity.pads[0]);
>> +
>> +	ret = v4l2_subdev_call(csi->subdev, video, s_stream, 0);
>> +	if (ret)
>> +		dev_err(csi->dev, "Failed to stop subdev stream\n");
>> +
>> +	writel(0, csi->shim + SHIM_CNTL);
>> +
>> +	ret = dmaengine_terminate_sync(csi->dma.chan);
>> +	if (ret)
>> +		dev_err(csi->dev, "Failed to stop DMA: %d\n", ret);
>> +
>> +	writel(0, csi->shim + SHIM_DMACNTX);
>> +
>> +	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_ERROR);
>> +}
>> +
>> +static const struct vb2_ops csi_vb2_qops = {
>> +	.queue_setup = ti_csi2rx_queue_setup,
>> +	.buf_prepare = ti_csi2rx_buffer_prepare,
>> +	.buf_queue = ti_csi2rx_buffer_queue,
>> +	.start_streaming = ti_csi2rx_start_streaming,
>> +	.stop_streaming = ti_csi2rx_stop_streaming,
>> +	.wait_prepare = vb2_ops_wait_prepare,
>> +	.wait_finish = vb2_ops_wait_finish,
>> +};
>> +
>> +static int ti_csi2rx_init_vb2q(struct ti_csi2rx_dev *csi)
>> +{
>> +	struct vb2_queue *q = &csi->vidq;
>> +	int ret;
>> +
>> +	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
> 
> Support for VB2_READ is not recommended as it's very inefficient. Please
> drop it.
> 
>> +	q->drv_priv = csi;
>> +	q->buf_struct_size = sizeof(struct ti_csi2rx_buffer);
>> +	q->ops = &csi_vb2_qops;
>> +	q->mem_ops = &vb2_dma_contig_memops;
>> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>> +	q->dev = dmaengine_get_dma_device(csi->dma.chan);
>> +	q->lock = &csi->mutex;
>> +	q->min_buffers_needed = 1;
>> +
>> +	ret = vb2_queue_init(q);
>> +	if (ret)
>> +		return ret;
>> +
>> +	csi->vdev.queue = q;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_link_validate_get_fmt(struct media_pad *pad,
>> +					   struct v4l2_subdev_format *fmt)
>> +{
>> +	if (is_media_entity_v4l2_subdev(pad->entity)) {
>> +		struct v4l2_subdev *sd =
>> +			media_entity_to_v4l2_subdev(pad->entity);
>> +
>> +		fmt->which = V4L2_SUBDEV_FORMAT_ACTIVE;
>> +		fmt->pad = pad->index;
>> +		return v4l2_subdev_call(sd, pad, get_fmt, NULL, fmt);
> 
> This will crash with any source that uses the subdev active state. You
> can't pass NULL for the state here.
> 
> How about exporting v4l2_subdev_link_validate_get_format() instead, to
> replace this function ?
> 

Yes, will update this.

>> +	}
>> +
>> +	WARN(pad->entity->function != MEDIA_ENT_F_IO_V4L,
>> +	     "Driver bug! Wrong media entity type 0x%08x, entity %s\n",
>> +	     pad->entity->function, pad->entity->name);
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ti_csi2rx_link_validate(struct media_link *link)
>> +{
>> +	struct media_entity *entity = link->sink->entity;
>> +	struct video_device *vdev = media_entity_to_video_device(entity);
>> +	struct ti_csi2rx_dev *csi = container_of(vdev, struct ti_csi2rx_dev, vdev);
>> +	struct v4l2_pix_format *csi_fmt = &csi->v_fmt.fmt.pix;
>> +	struct v4l2_subdev_format source_fmt;
>> +	const struct ti_csi2rx_fmt *ti_fmt;
>> +	int ret;
>> +
>> +	if (!(link->flags & MEDIA_LNK_FL_ENABLED)) {
>> +		dev_info(csi->dev, "video node %s pad not connected\n",
>> +			 vdev->name);
>> +		return -ENOTCONN;
>> +	}
> 
> This can't happen, __media_pipeline_start() skips links that are not
> enabled before calling .link_validate().
> 

Got it, will drop the check.

>> +
>> +	ret = ti_csi2rx_link_validate_get_fmt(link->source, &source_fmt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (source_fmt.format.width != csi_fmt->width) {
>> +		dev_err(csi->dev, "Width does not match (source %u, sink %u)\n",
>> +			source_fmt.format.width, csi_fmt->width);
> 
> Make it dev_dbg(), we don't want to output error messages in the kernel
> log for something that can be easily triggered by userspace. Same below.
> 

Will update these to dev_dbg().

>> +		return -EPIPE;
>> +	}
>> +
>> +	if (source_fmt.format.height != csi_fmt->height) {
>> +		dev_err(csi->dev, "Height does not match (source %u, sink %u)\n",
>> +			source_fmt.format.height, csi_fmt->height);
>> +		return -EPIPE;
>> +	}
>> +
>> +	if (source_fmt.format.field != csi_fmt->field &&
>> +	    csi_fmt->field != V4L2_FIELD_NONE) {
>> +		dev_err(csi->dev, "Field does not match (source %u, sink %u)\n",
>> +			source_fmt.format.field, csi_fmt->field);
>> +		return -EPIPE;
>> +	}
>> +
>> +	ti_fmt = find_format_by_code(source_fmt.format.code);
>> +	if (!ti_fmt) {
>> +		dev_err(csi->dev, "Media bus format 0x%x not supported\n",
>> +			source_fmt.format.code);
>> +		return -EPIPE;
>> +	}
>> +
>> +	if (source_fmt.format.code == MEDIA_BUS_FMT_YUYV8_2X8 ||
>> +	    source_fmt.format.code == MEDIA_BUS_FMT_VYUY8_2X8 ||
>> +	    source_fmt.format.code == MEDIA_BUS_FMT_YVYU8_2X8) {
> 
> Those three formats are not listed in the ti_csi2rx_fmt formats array,
> so find_format_by_code() will have returned NULL already, and this check
> can never be true.

will fix this in next revision, this was missed while dropping support for 2X8
formats from previous revision.

> 
>> +		dev_err(csi->dev,
>> +			"Only UYVY input allowed for YUV422 8-bit. Output format can be configured.\n");
>> +		return -EPIPE;
>> +	}
>> +
>> +	if (source_fmt.format.code != ti_fmt->code) {
> 
> That can never be true, as ti_fmt is looked up based on
> source_fmt.format.code. Did you mean to check if ti_fmt->fourcc ==
> csi->v_fmt.fmt.pix.pixelformat ?
> 

Yes the above the check will never be hit, I will update the check to
ti_fmt->fourcc == csi->v_fmt.fmt.pix.pixelformat in next revision.

I will address the rest of the review comments and send next revision with the
updates.

-- 
Thanks and Regards,
Vaishnav

>> +		dev_err(csi->dev,
>> +			"Cannot transform source fmt 0x%x to sink fmt 0x%x\n",
>> +			source_fmt.format.code, ti_fmt->code);
>> +		return -EPIPE;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct media_entity_operations ti_csi2rx_video_entity_ops = {
>> +	.link_validate = ti_csi2rx_link_validate,
>> +};
>> +
>> +static int ti_csi2rx_init_dma(struct ti_csi2rx_dev *csi)
>> +{
>> +	struct dma_slave_config cfg = {
>> +		.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES };
> 
> 	struct dma_slave_config cfg = {
> 		.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES,
> 	};
> 
>> +	int ret;
>> +
>> +	INIT_LIST_HEAD(&csi->dma.queue);
>> +	spin_lock_init(&csi->dma.lock);
>> +
>> +	csi->dma.state = TI_CSI2RX_DMA_STOPPED;
>> +
>> +	csi->dma.chan = dma_request_chan(csi->dev, "rx0");
>> +	if (IS_ERR(csi->dma.chan))
>> +		return PTR_ERR(csi->dma.chan);
>> +
>> +	ret = dmaengine_slave_config(csi->dma.chan, &cfg);
>> +	if (ret) {
>> +		dma_release_channel(csi->dma.chan);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
>> +{
>> +	struct media_device *mdev = &csi->mdev;
>> +	struct video_device *vdev = &csi->vdev;
>> +	const struct ti_csi2rx_fmt *fmt;
>> +	struct v4l2_pix_format *pix_fmt = &csi->v_fmt.fmt.pix;
>> +	int ret;
>> +
>> +	fmt = find_format_by_pix(V4L2_PIX_FMT_UYVY);
>> +	if (!fmt)
>> +		return -EINVAL;
>> +
>> +	pix_fmt->width = 640;
>> +	pix_fmt->height = 480;
>> +	pix_fmt->field = V4L2_FIELD_NONE;
>> +
>> +	ti_csi2rx_fill_fmt(fmt, &csi->v_fmt);
>> +
>> +	mdev->dev = csi->dev;
>> +	mdev->hw_revision = 1;
>> +	strscpy(mdev->model, "TI-CSI2RX", sizeof(mdev->model));
>> +	snprintf(mdev->bus_info, sizeof(mdev->bus_info), "platform:%s",
>> +		 dev_name(mdev->dev));
> 
> You can drop manual setting of bus_info here too.
> 
>> +
>> +	media_device_init(mdev);
>> +
>> +	strscpy(vdev->name, TI_CSI2RX_MODULE_NAME, sizeof(vdev->name));
>> +	vdev->v4l2_dev = &csi->v4l2_dev;
>> +	vdev->vfl_dir = VFL_DIR_RX;
>> +	vdev->fops = &csi_fops;
>> +	vdev->ioctl_ops = &csi_ioctl_ops;
>> +	vdev->release = video_device_release_empty;
>> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
>> +			    V4L2_CAP_IO_MC;
>> +	vdev->lock = &csi->mutex;
>> +	video_set_drvdata(vdev, csi);
>> +
>> +	csi->pad.flags = MEDIA_PAD_FL_SINK;
>> +	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
>> +	ret = media_entity_pads_init(&csi->vdev.entity, 1, &csi->pad);
>> +	if (ret)
>> +		return ret;
>> +
>> +	csi->v4l2_dev.mdev = mdev;
>> +
>> +	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = media_device_register(mdev);
>> +	if (ret) {
>> +		v4l2_device_unregister(&csi->v4l2_dev);
>> +		media_device_cleanup(mdev);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void ti_csi2rx_cleanup_dma(struct ti_csi2rx_dev *csi)
>> +{
>> +	dma_release_channel(csi->dma.chan);
>> +}
>> +
>> +static void ti_csi2rx_cleanup_v4l2(struct ti_csi2rx_dev *csi)
>> +{
>> +	media_device_unregister(&csi->mdev);
>> +	v4l2_device_unregister(&csi->v4l2_dev);
>> +	media_device_cleanup(&csi->mdev);
>> +}
>> +
>> +static void ti_csi2rx_cleanup_subdev(struct ti_csi2rx_dev *csi)
>> +{
>> +	v4l2_async_nf_unregister(&csi->notifier);
>> +	v4l2_async_nf_cleanup(&csi->notifier);
>> +}
>> +
>> +static void ti_csi2rx_cleanup_vb2q(struct ti_csi2rx_dev *csi)
>> +{
>> +	vb2_queue_release(&csi->vidq);
>> +}
>> +
>> +static int ti_csi2rx_probe(struct platform_device *pdev)
>> +{
>> +	struct ti_csi2rx_dev *csi;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
>> +	if (!csi)
>> +		return -ENOMEM;
>> +
>> +	csi->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, csi);
>> +
>> +	mutex_init(&csi->mutex);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	csi->shim = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(csi->shim)) {
>> +		ret = PTR_ERR(csi->shim);
>> +		goto err_mutex;
>> +	}
>> +
>> +	ret = ti_csi2rx_init_dma(csi);
>> +	if (ret)
>> +		goto err_mutex;
>> +
>> +	ret = ti_csi2rx_v4l2_init(csi);
>> +	if (ret)
>> +		goto err_dma;
>> +
>> +	ret = ti_csi2rx_init_vb2q(csi);
>> +	if (ret)
>> +		goto err_v4l2;
>> +
>> +	ret = ti_csi2rx_init_subdev(csi);
>> +	if (ret)
>> +		goto err_vb2q;
>> +
>> +	ret = of_platform_populate(csi->dev->of_node, NULL, NULL, csi->dev);
>> +	if (ret) {
>> +		dev_err(csi->dev, "Failed to create children: %d\n", ret);
>> +		goto err_subdev;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_subdev:
>> +	ti_csi2rx_cleanup_subdev(csi);
>> +err_vb2q:
>> +	ti_csi2rx_cleanup_vb2q(csi);
>> +err_v4l2:
>> +	ti_csi2rx_cleanup_v4l2(csi);
>> +err_dma:
>> +	ti_csi2rx_cleanup_dma(csi);
>> +err_mutex:
>> +	mutex_destroy(&csi->mutex);
>> +	return ret;
>> +}
>> +
>> +static int ti_csi2rx_remove(struct platform_device *pdev)
>> +{
>> +	struct ti_csi2rx_dev *csi = platform_get_drvdata(pdev);
>> +
>> +	video_unregister_device(&csi->vdev);
>> +
>> +	ti_csi2rx_cleanup_vb2q(csi);
>> +	ti_csi2rx_cleanup_subdev(csi);
>> +	ti_csi2rx_cleanup_v4l2(csi);
>> +	ti_csi2rx_cleanup_dma(csi);
>> +
>> +	mutex_destroy(&csi->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id ti_csi2rx_of_match[] = {
>> +	{ .compatible = "ti,j721e-csi2rx", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ti_csi2rx_of_match);
>> +
>> +static struct platform_driver ti_csi2rx_pdrv = {
>> +	.probe = ti_csi2rx_probe,
>> +	.remove = ti_csi2rx_remove,
>> +	.driver = {
>> +		.name = TI_CSI2RX_MODULE_NAME,
>> +		.of_match_table = ti_csi2rx_of_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(ti_csi2rx_pdrv);
>> +
>> +MODULE_DESCRIPTION("TI J721E CSI2 RX Driver");
>> +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
>> +MODULE_LICENSE("GPL");
> 
