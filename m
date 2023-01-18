Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E768670F51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjARBDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjARBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:03:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83F5B442;
        Tue, 17 Jan 2023 16:52:49 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63DAA10B;
        Wed, 18 Jan 2023 01:52:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674003165;
        bh=6rrt09MxNmurxQ7vQnMTKcIzI4DudFbHIC+qryuVPwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKOXwyRKNcMh+XGzE7DyVMoMbOKjt3Z8ONKvFpiUs7S8K/4uJLKasPzDao48GRLC0
         VX31ZA3c94dbz8xDtkCn0Iv0y32IraL3ZiJ1XMucFXxxZ2KOtp6lOWPd57TqJgB1dY
         uylMR0mwdvG14yXsgjJ2NDL+vC9pdh6bD/6w104w=
Date:   Wed, 18 Jan 2023 02:52:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Message-ID: <Y8dC3CvGtOo1IytD@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-3-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230111022433.25950-3-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

Thank you for the patch.

I'll comment on the high-level design first (with a few ad-hoc more
detailed comments here and there).

On Wed, Jan 11, 2023 at 11:24:29AM +0900, Yuji Ishikawa wrote:
> Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
> The interface device includes CSI2 Receiver,
> frame grabber, video DMAC and image signal processor.
> This patch provides operations to handle registers of HW listed above.
> 
> The Video DMACs have 32bit address space
> and currently corresponding IOMMU driver is not provided.
> Therefore, memory-block address for captured image is 32bit IOVA
> which is equal to 32bit-truncated phisical address.
> When the Visconti IOMMU driver (currently under development) is accepted,
> the hardware layer will use 32bit IOVA mapped by the attached IOMMU.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> ---
> Changelog v2:
> - Resend v1 because a patch exceeds size limit.
> 
> Changelog v3:
> - Adapted to media control framework
> - Introduced ISP subdevice, capture device
> - Remove private IOCTLs and add vendor specific V4L2 controls
> - Change function name avoiding camelcase and uppercase letters
> 
> Changelog v4:
> - Split patches because the v3 patch exceeds size limit 
> - Stop using ID number to identify driver instance:
>   - Use dynamically allocated structure to hold driver's context,
>     instead of static one indexed by ID number.
>   - Functions accept driver's context structure instead of ID number.
> 
> Changelog v5:
> - no change
> ---
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/visconti/Kconfig       |    9 +
>  drivers/media/platform/visconti/Makefile      |    8 +
>  drivers/media/platform/visconti/hwd_viif.c    | 1690 ++++++++++
>  drivers/media/platform/visconti/hwd_viif.h    |  710 +++++
>  .../media/platform/visconti/hwd_viif_csi2rx.c |  610 ++++
>  .../platform/visconti/hwd_viif_internal.h     |  340 ++
>  .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
>  include/uapi/linux/visconti_viif.h            | 1724 ++++++++++
>  10 files changed, 7895 insertions(+)
>  create mode 100644 drivers/media/platform/visconti/Kconfig
>  create mode 100644 drivers/media/platform/visconti/Makefile
>  create mode 100644 drivers/media/platform/visconti/hwd_viif.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
>  create mode 100644 include/uapi/linux/visconti_viif.h

This file split makes it quite hard to navigate and understand the
driver for people who are not familiar with it (at least for me) :-S It
would be nice to split the driver based on functional area, for instance
as follows:

- viif.c (or viif_drv.c): Top-level driver file, as already done in v5
- viif_csi2rx.c: CSI-2 receiver support code
- viif_l1isp.c: L1 ISP support
- viif_l2isp.c: L2 ISP support
- viif_capture.c: V4L2 video node support

Each of those files should have a corresponding header file to declare
functions and define the related macros and structures that are used by
*other* .c files. Macros and structures that are internal to a .c file
should be defined there.

- viif_reg.h: Register addresses and macros

I'm tempted to split the CSI-2 RX registers from viif_reg.h to
viif_csi2rx_reg.h.

As for the code currently stored in the hwd_*.c files, it could be kept
separate, or be integrated in the corresponding *.c file, up to you. If
you prefer keeping it separate, I would name the files viif_*_hw.c (e.g.
viif_csi2rx_hw.c).


I'll cut parts of the original part out of the reply, as the result
would be too large for the mailing list.

[snip]

>  # Please place here only ancillary drivers that aren't SoC-specific
> diff --git a/drivers/media/platform/visconti/Kconfig b/drivers/media/platform/visconti/Kconfig
> new file mode 100644
> index 00000000000..031e4610809
> --- /dev/null
> +++ b/drivers/media/platform/visconti/Kconfig
> @@ -0,0 +1,9 @@

Please add an SPDX header.

> +config VIDEO_VISCONTI_VIIF
> +	tristate "Visconti Camera Interface driver"
> +	depends on V4L_PLATFORM_DRIVERS && MEDIA_CONTROLLER && VIDEO_DEV
> +	depends on ARCH_VISCONTI
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE

You also need V4L2_ASYNC and VIDEO_V4L2_SUBDEV_API. Sort them
alphabetically:

	select V4L2_ASYNC
	select V4L2_FWNODE
	select VIDEOBUF2_DMA_CONTIG
	select VIDEO_V4L2_SUBDEV_API

> +	help
> +	  This is V4L2 driver for Toshiba Visconti Camera Interface driver
> +

[snip]

> diff --git a/drivers/media/platform/visconti/hwd_viif.c b/drivers/media/platform/visconti/hwd_viif.c
> new file mode 100644
> index 00000000000..260293fa4d0
> --- /dev/null
> +++ b/drivers/media/platform/visconti/hwd_viif.c
> @@ -0,0 +1,1690 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/* Toshiba Visconti Video Capture Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#include "hwd_viif.h"
> +#include "hwd_viif_internal.h"
> +
> +/* MIPI CSI2 DataType definition */
> +#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
> +#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
> +#define CSI2_DT_RGB565	  VISCONTI_CSI2_DT_RGB565
> +#define CSI2_DT_RGB888	  VISCONTI_CSI2_DT_RGB888
> +#define CSI2_DT_RAW8	  VISCONTI_CSI2_DT_RAW8
> +#define CSI2_DT_RAW10	  VISCONTI_CSI2_DT_RAW10
> +#define CSI2_DT_RAW12	  VISCONTI_CSI2_DT_RAW12
> +#define CSI2_DT_RAW14	  VISCONTI_CSI2_DT_RAW14

You can drop this and replace it with the macros defined in
include/media/mipi-csi2.h.

> +
> +struct hwd_viif_res *allocate_viif_res(struct device *dev, void *csi2host_vaddr,
> +				       void *capture_vaddr)
> +{
> +	struct hwd_viif_res *res = devm_kzalloc(dev, sizeof(struct hwd_viif_res), GFP_KERNEL);

Don't allocate this dynamically, it can be embedded in the viif_device
structure.

> +
> +	res->csi2host_reg = csi2host_vaddr;
> +	res->capture_reg = capture_vaddr;
> +	res->run_flag_main = (bool)false;
> +	return res;
> +}

[snip]

> +#define VDM_BIT_W00 BIT(0)
> +#define VDM_BIT_W01 BIT(1)
> +#define VDM_BIT_W02 BIT(2)
> +#define VDM_BIT_W03 BIT(3)
> +#define VDM_BIT_W04 BIT(4)
> +#define VDM_BIT_W05 BIT(5)
> +#define VDM_BIT_R00 BIT(0)
> +#define VDM_BIT_R01 BIT(1)
> +#define VDM_BIT_R02 BIT(2)
> +
> +#define VDM_ABORT_MASK_SUB_W  (VDM_BIT_W03 | VDM_BIT_W04 | VDM_BIT_W05)
> +#define VDM_ABORT_MASK_MAIN_W (VDM_BIT_W00 | VDM_BIT_W01 | VDM_BIT_W02)
> +#define VDM_ABORT_MASK_MAIN_R (VDM_BIT_R00 | VDM_BIT_R01 | VDM_BIT_R02)

None of these are used.

> +/**
> + * hwd_viif_l2_set_img_transmission() - Set image transfer condition of L2ISP
> + *
> + * @post_id: POST ID [0..1]
> + * @enable: or disable image transfer of MAIN unit. For more refer @ref hwd_viif_enable_flag.
> + * @src: Pointer to crop area information
> + * @out_process: Pointer to output process information
> + * @img: Pointer to output image information
> + * Return: 0 Operation completes successfully
> + * Return: -EINVAL Parameter error
> + * - [1] "post_id" or "enable" is out of range
> + * - [2] "src" or "out_process" is NULL when "enable" is HWD_VIIF_ENABLE
> + * - [3] "src" or "out_process" is not NULL when "enable" is HWD_VIIF_DISABLE
> + * - [4] Member of "src" is out of range
> + * - [5] "w" of "src" is not equal to 2 * "width" of "image"
> + *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
> + * - [6] "h" of "src" is not equal to 2 * "height" of "image"
> + *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
> + * - [7] "w" of "src" is not equal to "width" of "image"
> + *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
> + * - [8] "h" of "src" is not equal to "height" of "image"
> + *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
> + * - [9] Member of "out_process" is invalid
> + * - [10] "alpha" of "out_process" is not 0 when "format" of "img" is not HWD_VIIF_ARGB8888_PACKED
> + * - [11] "format" of "img" is not HWD_VIIF_ONE_COLOR_8 or HWD_VIIF_ONE_COLOR_16
> + *   when "select_color" of "out_process"
> + *   is HWD_VIIF_COLOR_Y_G, HWD_VIIF_COLOR_U_B or HWD_VIIF_COLOR_V_R
> + * - [12] Member of "img" is invalid
> + *
> + * see also: #hwd_viif_l2_set_roi_path
> + */
> +s32 hwd_viif_l2_set_img_transmission(struct hwd_viif_res *res, u32 post_id, u32 enable,
> +				     const struct hwd_viif_img_area *src,
> +				     const struct hwd_viif_out_process *out_process,
> +				     const struct hwd_viif_img *img)
> +{
> +	u32 pitch[HWD_VIIF_MAX_PLANE_NUM], img_start_addr[HWD_VIIF_MAX_PLANE_NUM];
> +	u32 i, val, loop, k, r[HWD_VIIF_MAX_PLANE_NUM];
> +	s32 ret = 0;
> +
> +	/* pitch alignment for planar or one color format */
> +	u32 pitch_align = 128U;

[snip]

> +	/* build DMAC parameter */
> +	switch (img->format) {
> +	case HWD_VIIF_YCBCR422_8_PACKED:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		loop = 1U;
> +		k = 2U;
> +		r[0] = 1U;
> +		pitch_align = 256U;
> +		break;
> +	case HWD_VIIF_RGB888_PACKED:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		loop = 1U;
> +		k = 3U;
> +		r[0] = 1U;
> +		pitch_align = 384U;
> +		break;
> +	case HWD_VIIF_ARGB8888_PACKED:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		loop = 1U;
> +		k = 4U;
> +		r[0] = 1U;
> +		pitch_align = 512U;
> +		break;
> +	case HWD_VIIF_ONE_COLOR_8:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		loop = 1U;
> +		k = 1U;
> +		r[0] = 1U;
> +		break;
> +	case HWD_VIIF_ONE_COLOR_16:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		loop = 1U;
> +		k = 2U;
> +		r[0] = 1U;
> +		break;
> +	case HWD_VIIF_YCBCR422_8_PLANAR:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> +		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		pitch[1] = img->pixelmap[1].pitch;
> +		pitch[2] = img->pixelmap[2].pitch;
> +		loop = HWD_VIIF_MAX_PLANE_NUM;
> +		k = 1U;
> +		r[0] = 1U;
> +		r[1] = 2U;
> +		r[2] = 2U;
> +		break;
> +	case HWD_VIIF_RGB888_YCBCR444_8_PLANAR:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> +		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		pitch[1] = img->pixelmap[1].pitch;
> +		pitch[2] = img->pixelmap[2].pitch;
> +		loop = HWD_VIIF_MAX_PLANE_NUM;
> +		k = 1U;
> +		r[0] = 1U;
> +		r[1] = 1U;
> +		r[2] = 1U;
> +		break;
> +	case HWD_VIIF_YCBCR422_16_PLANAR:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> +		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		pitch[1] = img->pixelmap[1].pitch;
> +		pitch[2] = img->pixelmap[2].pitch;
> +		loop = HWD_VIIF_MAX_PLANE_NUM;
> +		k = 2U;
> +		r[0] = 1U;
> +		r[1] = 2U;
> +		r[2] = 2U;
> +		break;
> +	case HWD_VIIF_RGB161616_YCBCR444_16_PLANAR:
> +		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> +		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> +		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> +		pitch[0] = img->pixelmap[0].pitch;
> +		pitch[1] = img->pixelmap[1].pitch;
> +		pitch[2] = img->pixelmap[2].pitch;
> +		loop = HWD_VIIF_MAX_PLANE_NUM;
> +		k = 2U;
> +		r[0] = 1U;
> +		r[1] = 1U;
> +		r[2] = 1U;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This is lots of code that could be replaced with static data. Create

struct viif_format_info {
	u32 format;
	unsigned int num_planes;
	unsigned int bpp;
	/* whatever other fields are needed */
};

in viif.h, and add to viif.c a static table of those

static const struct viif_format_info viif_formats[] = {
	{
		.format = HWD_VIIF_YCBCR422_8_PACKED,
		.num_planes = 1
		.bpp = 2,
	}, {
		...
	},
};

with a lookup function

const struct viif_format_info viif_format_info(u32 format)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(viif_formats); ++i) {
		if (viif_formats[i].format == format)
			return &viif_formats[i];
	}

	return NULL;
}

You can then use this wherever you need per-format information through
the driver. I suspect it will be useful to store other per-format
information, such as the V4L2 pixel format for instance.

Now that I wrote this, it seems you already have such a structure called
viif_fmt in a subsequent patch, with a static array. Move them to viif.c
and viif.h, extend the structure with the hardware format, are use it
through the driver.

> +
> +	for (i = 0; i < loop; i++) {
> +		val = max(((img->width * k) / r[i]), 128U);
> +		if (pitch[i] < val || pitch[i] > HWD_VIIF_MAX_PITCH_ISP ||
> +		    ((pitch[i] % pitch_align) != 0U) || ((img_start_addr[i] % 4U) != 0U)) {
> +			return -EINVAL;
> +		}
> +	}
> +
> +	writel(img_start_addr[0], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_G);
> +	writel(pitch[0], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_G);
> +	if (loop == HWD_VIIF_MAX_PLANE_NUM) {
> +		writel(img_start_addr[1],
> +		       &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_B);
> +		writel(img_start_addr[2],
> +		       &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_R);
> +		writel(pitch[1], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_B);
> +		writel(pitch[2], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_R);
> +	}
> +
> +	/* Set CROP */
> +	val = (src->y << 16U) | src->x;
> +	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_OFFSET);
> +	val = (src->h << 16U) | src->w;
> +	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_SIZE);
> +
> +	/* Set output process */
> +	writel(out_process->half_scale,
> +	       &res->capture_reg->l2isp.post[post_id].L2_POST_HALF_SCALE_EN);
> +	writel(out_process->select_color, &res->capture_reg->l2isp.post[post_id].L2_POST_C_SELECT);
> +	writel((u32)out_process->alpha, &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTALP);
> +	writel(img->format, &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTFMT);
> +
> +	/* Update ROI area and input to each POST */
> +	res->l2_roi_path_info.post_enable_flag[post_id] = true;
> +	res->l2_roi_path_info.post_crop_x[post_id] = src->x;
> +	res->l2_roi_path_info.post_crop_y[post_id] = src->y;
> +	res->l2_roi_path_info.post_crop_w[post_id] = src->w;
> +	res->l2_roi_path_info.post_crop_h[post_id] = src->h;
> +	hwd_viif_l2_set_roi_path(res);
> +
> +	return ret;
> +}

[snip]

> diff --git a/drivers/media/platform/visconti/hwd_viif.h b/drivers/media/platform/visconti/hwd_viif.h
> new file mode 100644
> index 00000000000..100afda8436
> --- /dev/null
> +++ b/drivers/media/platform/visconti/hwd_viif.h
> @@ -0,0 +1,710 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/* Toshiba Visconti Video Capture Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#ifndef HWD_VIIF_H
> +#define HWD_VIIF_H
> +
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +
> +#include <linux/visconti_viif.h>
> +
> +enum hwd_power_ctrl {
> +	HWD_POWER_OFF = 0, /**< Power off */
> +	HWD_POWER_ON /**< Power on  */
> +};

Not used.

> +
> +/* MIPI CSI2 Data Types */
> +#define VISCONTI_CSI2_DT_YUV4228B  0x1E
> +#define VISCONTI_CSI2_DT_YUV42210B 0x1F
> +#define VISCONTI_CSI2_DT_RGB565	   0x22
> +#define VISCONTI_CSI2_DT_RGB888	   0x24
> +#define VISCONTI_CSI2_DT_RAW8	   0x2A
> +#define VISCONTI_CSI2_DT_RAW10	   0x2B
> +#define VISCONTI_CSI2_DT_RAW12	   0x2C
> +#define VISCONTI_CSI2_DT_RAW14	   0x2D

You can drop this and replace it with the macros defined in
include/media/mipi-csi2.h.

> +
> +/* hwd_viif_enable_flag */
> +#define HWD_VIIF_DISABLE (0U)

No need for parentheses, here and below.

> +#define HWD_VIIF_ENABLE	 (1U)

false/true or 0/1 would be more readable in the code.

> +
> +/* hwd_viif_memory_sync_type */
> +#define HWD_VIIF_MEM_SYNC_INTERNAL (0U)
> +#define HWD_VIIF_MEM_SYNC_CSI2	   (1U)

This isn't used anywhere.

> +
> +/* hwd_viif_color_format */
> +#define HWD_VIIF_YCBCR422_8_PACKED	      (0U)
> +#define HWD_VIIF_RGB888_PACKED		      (1U)
> +#define HWD_VIIF_ARGB8888_PACKED	      (3U)
> +#define HWD_VIIF_YCBCR422_8_PLANAR	      (8U)
> +#define HWD_VIIF_RGB888_YCBCR444_8_PLANAR     (9U)
> +#define HWD_VIIF_ONE_COLOR_8		      (11U)
> +#define HWD_VIIF_YCBCR422_16_PLANAR	      (12U)
> +#define HWD_VIIF_RGB161616_YCBCR444_16_PLANAR (13U)
> +#define HWD_VIIF_ONE_COLOR_16		      (15U)

Could this be turned into an enum ?

enum hwd_viif_color_format {
	HWD_VIIF_YCBCR422_8_PACKED	       = 0U,
	HWD_VIIF_RGB888_PACKED		       = 1U,
	HWD_VIIF_ARGB8888_PACKED	       = 3U,
	HWD_VIIF_YCBCR422_8_PLANAR	       = 8U,
	HWD_VIIF_RGB888_YCBCR444_8_PLANAR      = 9U,
	HWD_VIIF_ONE_COLOR_8		       = 11U,
	HWD_VIIF_YCBCR422_16_PLANAR	       = 12U,
	HWD_VIIF_RGB161616_YCBCR444_16_PLANAR  = 13U,
	HWD_VIIF_ONE_COLOR_16		       = 15U,
};

Then you'll be able to use the enum in variables, function parameters
and structure fields, for instance

struct hwd_viif_img {
	u32 width;
	u32 height;
	enum hwd_viif_color_format format;
	struct hwd_viif_pixelmap pixelmap[3];
};

which will make it clearer through the code which types and values are
expected in a given place.

Same for all other macros where this would be applicable.

> +
> +/* hwd_viif_raw_pack_mode */
> +#define HWD_VIIF_RAWPACK_DISABLE  (0U)
> +#define HWD_VIIF_RAWPACK_MSBFIRST (2U)
> +#define HWD_VIIF_RAWPACK_LSBFIRST (3U)
> +
> +/* hwd_viif_yuv_conversion_mode */
> +#define HWD_VIIF_YUV_CONV_REPEAT	(0U)
> +#define HWD_VIIF_YUV_CONV_INTERPOLATION (1U)
> +
> +/* hwd_viif_gamma_table_mode */
> +#define HWD_VIIF_GAMMA_COMPRESSED (0U)
> +#define HWD_VIIF_GAMMA_LINEAR	  (1U)
> +
> +/* hwd_viif_output_color_mode */
> +#define HWD_VIIF_COLOR_Y_G     (0U)
> +#define HWD_VIIF_COLOR_U_B     (1U)
> +#define HWD_VIIF_COLOR_V_R     (2U)
> +#define HWD_VIIF_COLOR_YUV_RGB (4U)
> +
> +/* hwd_viif_hw_params */
> +#define HWD_VIIF_MAX_CH	       (6U)

This isn't used.

Could you go through this file and delete all the macros that are not
used and that you don't plan to use in the future ?

> +#define HWD_VIIF_MAX_PLANE_NUM (3U)

This is used inside the hwd_viif_l2_set_img_transmission() function
only. I'm really tempted to move definitions of macros that are local to
a function in the corresponding .c file, just before the function. This
file is huge, and quite difficult to read, anything that would shrink it
would be nice.

> +
> +/**
> + * enum hwd_viif_csi2_dphy - D-PHY Lane assignment
> + *
> + * specifies which line(L0-L3) is assigned to D0-D3
> + */
> +enum hwd_viif_csi2_dphy {
> +	HWD_VIIF_CSI2_DPHY_L0L1L2L3 = 0U,
> +	HWD_VIIF_CSI2_DPHY_L0L3L1L2 = 1U,
> +	HWD_VIIF_CSI2_DPHY_L0L2L3L1 = 2U,
> +	HWD_VIIF_CSI2_DPHY_L0L1L3L2 = 4U,
> +	HWD_VIIF_CSI2_DPHY_L0L3L2L1 = 5U,
> +	HWD_VIIF_CSI2_DPHY_L0L2L1L3 = 6U
> +};
> +
> +/* hwd_viif_csi2rx_cal_status */
> +#define HWD_VIIF_CSI2_CAL_NOT_DONE (0U)
> +#define HWD_VIIF_CSI2_CAL_SUCCESS  (1U)
> +#define HWD_VIIF_CSI2_CAL_FAIL	   (2U)

Custom error codes are usually frowned upon, especially when success is
signaled by a value other than 0. How about using 0 for success, -EAGAIN
for NOT_DONE, and -EIO for failure ? Same comment for other custom
status values, if any.

> +
> +/* hwd_viif_csi2rx_not_capture */
> +#define HWD_VIIF_CSI2_NOT_CAPTURE (-1) /**< csi2 not capture */

[snip]

> +
> +/* hwd_viif_l1_input_mode */
> +#define HWD_VIIF_L1_INPUT_HDR		  (0U)
> +#define HWD_VIIF_L1_INPUT_PWL		  (1U)
> +#define HWD_VIIF_L1_INPUT_SDR		  (2U)
> +#define HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT (3U)
> +#define HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT (4U)
> +
> +/* hwd_viif_l1_raw_color_filter_mode */
> +#define HWD_VIIF_L1_RAW_GR_R_B_GB (0U)
> +#define HWD_VIIF_L1_RAW_R_GR_GB_B (1U)
> +#define HWD_VIIF_L1_RAW_B_GB_GR_R (2U)
> +#define HWD_VIIF_L1_RAW_GB_B_R_GR (3U)
> +
> +/* hwd_viif_l1_input_interpolation_mode */
> +#define HWD_VIIF_L1_INPUT_INTERPOLATION_LINE  (0U)
> +#define HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL (1U)
> +
> +/* hwd_viif_l1_img_sens */
> +#define HWD_VIIF_L1_IMG_SENSITIVITY_HIGH       (0U)
> +#define HWD_VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED (1U)
> +#define HWD_VIIF_L1_IMG_SENSITIVITY_LOW	       (2U)
> +
> +/* hwd_viif_l1_dpc */
> +#define HWD_VIIF_L1_DPC_1PIXEL (0U)
> +#define HWD_VIIF_L1_DPC_2PIXEL (1U)
> +
> +/* hwd_viif_l1_rcnr_hry_type */
> +#define HWD_VIIF_L1_RCNR_LOW_RESOLUTION	       (0U)
> +#define HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION     (1U)
> +#define HWD_VIIF_L1_RCNR_HIGH_RESOLUTION       (2U)
> +#define HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION (3U)
> +
> +/* hwd_viif_l1_rcnr_msf_blend_ratio */
> +#define HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 (0U)
> +#define HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 (1U)
> +#define HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 (2U)
> +
> +/* hwd_viif_l1_hdrs */
> +#define HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE (0U)
> +#define HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE	   (1U)
> +
> +/* hwd_viif_l1_lsc_para_mag */
> +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH (0U)
> +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH (1U)
> +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND (2U)
> +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST  (3U)
> +
> +/* hwd_viif_l1_lsc_grid_mag */
> +#define HWD_VIIF_L1_GRID_COEF_GAIN_X1 (0U)
> +#define HWD_VIIF_L1_GRID_COEF_GAIN_X2 (1U)
> +
> +/* hwd_viif_l1_demosaic */
> +#define HWD_VIIF_L1_DEMOSAIC_ACPI (0U)
> +#define HWD_VIIF_L1_DEMOSAIC_DMG  (1U)
> +
> +/* hwd_viif_l1_awb_restart_cond */
> +/* macros for L1ISP condition to restart auto white balance */
> +#define HWD_VIIF_L1_AWB_RESTART_NO	 (0U)
> +#define HWD_VIIF_L1_AWB_RESTART_128FRAME (1U)
> +#define HWD_VIIF_L1_AWB_RESTART_64FRAME	 (2U)
> +#define HWD_VIIF_L1_AWB_RESTART_32FRAME	 (3U)
> +#define HWD_VIIF_L1_AWB_RESTART_16FRAME	 (4U)
> +#define HWD_VIIF_L1_AWB_RESTART_8FRAME	 (5U)
> +#define HWD_VIIF_L1_AWB_RESTART_4FRAME	 (6U)
> +#define HWD_VIIF_L1_AWB_RESTART_2FRAME	 (7U)
> +
> +/* hwd_viif_l1_awb_mag */
> +#define HWD_VIIF_L1_AWB_ONE_SECOND (0U)
> +#define HWD_VIIF_L1_AWB_X1	   (1U)
> +#define HWD_VIIF_L1_AWB_X2	   (2U)
> +#define HWD_VIIF_L1_AWB_X4	   (3U)
> +
> +/* hwd_viif_l1_awb_area_mode */
> +#define HWD_VIIF_L1_AWB_AREA_MODE0 (0U)
> +#define HWD_VIIF_L1_AWB_AREA_MODE1 (1U)
> +#define HWD_VIIF_L1_AWB_AREA_MODE2 (2U)
> +#define HWD_VIIF_L1_AWB_AREA_MODE3 (3U)
> +
> +/* hwd_viif_l1_hdrc_tone_type */
> +#define HWD_VIIF_L1_HDRC_TONE_USER   (0U)
> +#define HWD_VIIF_L1_HDRC_TONE_PRESET (1U)
> +
> +/* hwd_viif_l1_bin_mode */
> +#define HWD_VIIF_L1_HIST_BIN_MODE_LINEAR (0U)
> +#define HWD_VIIF_L1_HIST_BIN_MODE_LOG	 (1U)
> +
> +/* hwd_viif_l2_undist_mode */
> +#define HWD_VIIF_L2_UNDIST_POLY		(0U)
> +#define HWD_VIIF_L2_UNDIST_GRID		(1U)
> +#define HWD_VIIF_L2_UNDIST_POLY_TO_GRID (2U)
> +#define HWD_VIIF_L2_UNDIST_GRID_TO_POLY (3U)
> +
> +/**
> + * struct hwd_viif_csi2rx_line_err_target
> + *
> + * Virtual Channel and Data Type pair for CSI2RX line error monitor
> + *
> + * When 0 is set to dt, line error detection is disabled.
> + *
> + * * VC can be 0 .. 3
> + * * DT can be 0 or 0x10 .. 0x3F
> + */
> +#define VISCONTI_CSI2_ERROR_MONITORS_NUM 8
> +struct hwd_viif_csi2rx_line_err_target {
> +	u32 vc[VISCONTI_CSI2_ERROR_MONITORS_NUM];
> +	u32 dt[VISCONTI_CSI2_ERROR_MONITORS_NUM];
> +};
> +
> +/**
> + * struct hwd_viif_csi2rx_irq_mask
> + * @mask: mask setting for CSI2RX error interruption
> + *
> + * * mask[0]: D-PHY fatal error
> + * * mask[1]: Packet fatal error
> + * * mask[2]: Frame fatal error
> + * * mask[3]: D-PHY error
> + * * mask[4]: Packet error
> + * * mask[5]: Line error
> + */
> +#define VISCONTI_CSI2RX_IRQ_MASKS_NUM	      6
> +#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_FATAL   0
> +#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_FATAL 1
> +#define VISCONTI_CSI2RX_IRQ_MASK_FRAME_FATAL  2
> +#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_ERROR   3
> +#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_ERROR 4
> +#define VISCONTI_CSI2RX_IRQ_MASK_LINE_ERROR   5
> +struct hwd_viif_csi2rx_irq_mask {
> +	u32 mask[VISCONTI_CSI2RX_IRQ_MASKS_NUM];
> +};
> +
> +/**
> + * struct hwd_viif_csi2rx_packet - CSI2 packet information
> + * @word_count: word count included in one packet[byte] [0..16384]
> + * @packet_num: the number of packet included in one packet [0..8192]
> + *
> + * each element means as below.
> + * * [0]: embedded data of MAIN unit
> + * * [1]: long packet data of MAIN unit
> + * * [2]: embedded data of SUB unit
> + * * [3]: long packet data of SUB unit
> + *
> + * Regarding word_count of long packet data,
> + * word count of odd line needs to be set in case of DT = 0x18, 0x19, 0x1C or 0x1D.
> + */
> +#define VISCONTI_CSI2RX_PACKET_TYPES_NUM      4
> +#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN  0
> +#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN 1
> +#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB   2
> +#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB  3
> +struct hwd_viif_csi2rx_packet {
> +	u32 word_count[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
> +	u32 packet_num[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
> +};
> +
> +/**
> + * struct hwd_viif_pixelmap - pixelmap information
> + * @pmap_paddr: start address of pixel data(physical address). 4byte alignment.
> + * @pitch: pitch size of pixel map[byte]
> + *
> + * Condition of pitch in case of L2ISP output is as below.
> + * * max: 32704[byte]
> + * * min: the larger value of (active width of image * k / r) and 128[byte]
> + * * alignment: 64[byte]
> + *
> + * Condition of pitch in the other cases is as below.
> + * * max: 65536[byte]
> + * * min: active width of image * k / r[byte]
> + * * alignment: 4[byte]
> + *
> + * k is the size of 1 pixel and the value is as below.
> + * * HWD_VIIF_YCBCR422_8_PACKED: 2
> + * * HWD_VIIF_RGB888_PACKED: 3
> + * * HWD_VIIF_ARGB8888_PACKED: 4
> + * * HWD_VIIF_YCBCR422_8_PLANAR: 1
> + * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR: 1
> + * * HWD_VIIF_ONE_COLOR_8: 1
> + * * HWD_VIIF_YCBCR422_16_PLANAR: 2
> + * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR: 2
> + * * HWD_VIIF_ONE_COLOR_16: 2
> + *
> + * r is the correction factor for Cb or Cr of YCbCr422 planar and the value is as below.
> + * * YCbCr422 Cb-planar: 2
> + * * YCbCr422 Cr-planar: 2
> + * * others: 1
> + *
> + */
> +struct hwd_viif_pixelmap {
> +	uintptr_t pmap_paddr;
> +	u32 pitch;
> +};
> +
> +/**
> + * struct hwd_viif_img - image information
> + * @width: active width of image[pixel]
> + * * [128..5760](output from L2ISP)
> + * * [128..4096](input to MAIN unit(memory input))
> + * * [128..4096](output from SUB unit)
> + * * The value should be even.
> + *
> + * @height: active height of image[line]
> + * * [128..3240](output from L2ISP)
> + * * [128..2160](input to MAIN unit(memory input))
> + * * [128..2160](output from SUB unit)
> + * * The value should be even.
> + *
> + * @format: hwd_viif_color_format "color format"
> + * * Below color formats are supported for input and output of MAIN unit
> + * * HWD_VIIF_YCBCR422_8_PACKED
> + * * HWD_VIIF_RGB888_PACKED
> + * * HWD_VIIF_ARGB8888_PACKED
> + * * HWD_VIIF_YCBCR422_8_PLANAR
> + * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR
> + * * HWD_VIIF_ONE_COLOR_8
> + * * HWD_VIIF_YCBCR422_16_PLANAR
> + * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR
> + * * HWD_VIIF_ONE_COLOR_16
> + * * Below color formats are supported for output of SUB unit
> + * * HWD_VIIF_ONE_COLOR_8
> + * * HWD_VIIF_ONE_COLOR_16
> + *
> + * @pixelmap: pixelmap information
> + * * [0]: Y/G-planar, packed/Y/RAW
> + * * [1]: Cb/B-planar
> + * * [2]: Cr/R-planar
> + */
> +struct hwd_viif_img {
> +	u32 width;
> +	u32 height;
> +	u32 format;
> +	struct hwd_viif_pixelmap pixelmap[3];
> +};
> +
> +/**
> + * struct hwd_viif_input_img - input image information
> + * @pixel_clock: pixel clock [3375..600000] [kHz]. 0 needs to be set for long packet data.
> + * @htotal_size: horizontal total size
> + * * [143..65535] [pixel] for image data
> + * * [239..109225] [ns] for long packet data
> + * @hactive_size: horizontal active size [pixel]
> + * * [128..4096] without L1ISP
> + * * [640..3840] with L1ISP
> + * * The value should be even. In addition, the value should be a multiple of 8 with L1ISP
> + * * 0 needs to be set for the configuration of long packet data or SUB unit output.
> + * @vtotal_size: vertical total size [line]
> + * * [144..16383] for image data
> + * * 0 needs to be set for the configuration of long packet data.
> + * @vbp_size: vertical back porch size
> + * * [5..4095] [line] for image data
> + * * [5..4095] [the number of packet] for long packet data
> + * @vactive_size: vertical active size [line]
> + * * [128..2160] without L1ISP
> + * * [480..2160] with L1ISP
> + * * The value should be even.
> + * * 0 needs to be set for the configuration of long packet data.
> + * @interpolation_mode: input image interpolation mode for hwd_viif_l1_input_interpolation_mode
> + * * HWD_VIIF_L1_INPUT_INTERPOLATION_LINE needs to be set in the below cases.
> + * * image data(without L1ISP) or long packet data
> + * * image data or long packet data of SUB unit
> + * @input_num: the number of input images [1..3]
> + * * 1 needs to be set in the below cases.
> + * * image data(without L1ISP) or long packet data
> + * * image data or long packet data of SUB unit
> + * @hobc_width: the number of horizontal optical black pixels [0,16,32,64 or 128]
> + * * 0 needs to be set in the below cases.
> + * * in case of hobc_margin = 0
> + * * image data(without L1ISP) or long packet data
> + * * image data or long packet data of SUB unit
> + * @hobc_margin: the number of horizontal optical black margin[0..30] (even number)
> + * * 0 needs to be set in the below cases.
> + * * in case of hobc_width = 0
> + * * image data(without L1ISP) or long packet data
> + * * image data or long packet data of SUB unit
> + *
> + * Below conditions need to be satisfied.
> + * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_LINE:
> + *   (htotal_size > (hactive_size + hobc_width + hobc_margin)) &&
> + *   (vtotal_size > (vbp_size + vactive_size * input_num))
> + * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL:
> + *   (htotal_size > ((hactive_size + hobc_width + hobc_margin) * input_num)) &&
> + *   (vtotal_size > (vbp_size + vactive_size))
> + * * L1ISP is used:
> + *   vbp_size >= (54720[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 38 + ISST time
> + * * L1ISP is not used:
> + *   vbp_size >= (39360[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 16 + ISST time
> + *
> + * Note: L1ISP is used when RAW data is input to MAIN unit
> + */
> +struct hwd_viif_input_img {
> +	u32 pixel_clock;
> +	u32 htotal_size;
> +	u32 hactive_size;
> +	u32 vtotal_size;
> +	u32 vbp_size;
> +	u32 vactive_size;
> +	u32 interpolation_mode;
> +	u32 input_num;
> +	u32 hobc_width;
> +	u32 hobc_margin;
> +};
> +
> +/**
> + * struct hwd_viif_csc_param - color conversion information
> + * @r_cr_in_offset: input offset of R/Cr[pix value] [0x0..0x1FFFF]
> + * @g_y_in_offset: input offset of G/Y[pix value] [0x0..0x1FFFF]
> + * @b_cb_in_offset: input offset of B/Cb[pix value] [0x0..0x1FFFF]
> + * @coef: coefficient of matrix [0x0..0xFFFF]
> + * * [0] : c00(YG_YG), [1] : c01(UB_YG), [2] : c02(VR_YG),
> + * * [3] : c10(YG_UB), [4] : c11(UB_UB), [5] : c12(VR_UB),
> + * * [6] : c20(YG_VR), [7] : c21(UB_VR), [8] : c22(VR_VR)
> + * @r_cr_out_offset: output offset of R/Cr[pix value] [0x0..0x1FFFF]
> + * @g_y_out_offset: output offset of G/Y[pix value] [0x0..0x1FFFF]
> + * @b_cb_out_offset: output offset of B/Cb[pix value] [0x0..0x1FFFF]
> + */
> +struct hwd_viif_csc_param {
> +	u32 r_cr_in_offset;
> +	u32 g_y_in_offset;
> +	u32 b_cb_in_offset;
> +	u32 coef[9];
> +	u32 r_cr_out_offset;
> +	u32 g_y_out_offset;
> +	u32 b_cb_out_offset;
> +};
> +
> +/**
> + * struct hwd_viif_img_area - image area definition
> + * @x: x position [0..8062] [pixel]
> + * @y: y position [0..3966] [line]
> + * @w: image width [128..8190] [pixel]
> + * @h: image height [128..4094] [line]
> + */
> +struct hwd_viif_img_area {
> +	u32 x;
> +	u32 y;
> +	u32 w;
> +	u32 h;
> +};
> +
> +/**
> + * struct hwd_viif_out_process - configuration of output process of MAIN unit and L2ISP
> + * @half_scale: hwd_viif_enable_flag "enable or disable half scale"
> + * @select_color: hwd_viif_output_color_mode "select output color"
> + * @alpha: alpha value used in case of ARGB8888 output [0..255]
> + */
> +struct hwd_viif_out_process {
> +	u32 half_scale;
> +	u32 select_color;
> +	u8 alpha;
> +};
> +
> +/**
> + * struct hwd_viif_l1_lsc - HWD L1ISP lens shading correction parameters
> + * @lssc_parabola_param: parabola shading correction parameter
> + * * NULL: disable parabola shading correction
> + * * not NULL: enable parabola shading correction
> + * @lssc_grid_param: grid shading correction parameter
> + * * NULL: disable grid shading correction
> + * * not NULL: enable grid shading correction
> + * @lssc_pwhb_r_gain_max: maximum R gain of preset white balance correction
> + * @lssc_pwhb_r_gain_min: minimum R gain of preset white balance correction
> + * @lssc_pwhb_gr_gain_max: maximum Gr gain of preset white balance correction
> + * @lssc_pwhb_gr_gain_min: minimum Gr gain of preset white balance correction
> + * @lssc_pwhb_gb_gain_max: maximum Gb gain of preset white balance correction
> + * @lssc_pwhb_gb_gain_min: minimum Gb gain of preset white balance correction
> + * @lssc_pwhb_b_gain_max: maximum B gain of preset white balance correction
> + * @lssc_pwhb_b_gain_min: minimum B gain of preset white balance correction
> + *
> + * Range and accuracy of lssc_pwhb_xxx_gain_xxx are as below.
> + * - range: [0x0..0x7FF]
> + * - accuracy : 1/256
> + */
> +struct hwd_viif_l1_lsc {
> +	struct viif_l1_lsc_parabola_param *lssc_parabola_param;
> +	struct viif_l1_lsc_grid_param *lssc_grid_param;
> +	u32 lssc_pwhb_r_gain_max;
> +	u32 lssc_pwhb_r_gain_min;
> +	u32 lssc_pwhb_gr_gain_max;
> +	u32 lssc_pwhb_gr_gain_min;
> +	u32 lssc_pwhb_gb_gain_max;
> +	u32 lssc_pwhb_gb_gain_min;
> +	u32 lssc_pwhb_b_gain_max;
> +	u32 lssc_pwhb_b_gain_min;
> +};
> +
> +/**
> + * struct hwd_viif_l1_img_quality_adjustment - HWD L1ISP image quality adjustment parameters
> + * @coef_cb: Cb coefficient [0x0..0xffff] accuracy: 1/65536
> + * @coef_cr: Cr coefficient [0x0..0xffff] accuracy: 1/65536
> + * @brightness: brightness value [-32768..32767] (0 means off.)
> + * @linear_contrast: linear contrast value [0x0..0xff] accuracy: 1/128 (128 means off.)
> + * @*nonlinear_contrast: pointer to nonlinear contrast parameter
> + * @*lum_noise_reduction: pointer to luminance noise reduction parameter
> + * @*edge_enhancement: pointer to edge enhancement parameter
> + * @*uv_suppression: pointer to UV suppression parameter
> + * @*coring_suppression: pointer to coring suppression parameter
> + * @*edge_suppression: pointer to edge enhancement parameter
> + * @*color_level: pointer to color level adjustment parameter
> + * @color_noise_reduction_enable: enable/disable color noise reduction @ref hwd_viif_enable_flag
> + */
> +struct hwd_viif_l1_img_quality_adjustment {
> +	u16 coef_cb;
> +	u16 coef_cr;
> +	s16 brightness;
> +	u8 linear_contrast;
> +	struct viif_l1_nonlinear_contrast *nonlinear_contrast;
> +	struct viif_l1_lum_noise_reduction *lum_noise_reduction;
> +	struct viif_l1_edge_enhancement *edge_enhancement;
> +	struct viif_l1_uv_suppression *uv_suppression;
> +	struct viif_l1_coring_suppression *coring_suppression;
> +	struct viif_l1_edge_suppression *edge_suppression;
> +	struct viif_l1_color_level *color_level;
> +	u32 color_noise_reduction_enable;
> +};
> +
> +/**
> + * struct hwd_viif_l1_info - HWD L1ISP processing information
> + * @context_id: context id
> + * @ag_cont_hobc_high: analog gain for high sensitivity image of OBCC
> + * @ag_cont_hobc_middle_led: analog gain for middle sensitivity or led image of OBCC
> + * @ag_cont_hobc_low: analog gain for low sensitivity image of OBCC
> + * @ag_cont_abpc_high: analog gain for high sensitivity image of ABPC
> + * @ag_cont_abpc_middle_led: analog gain for middle sensitivity or led image of ABPC
> + * @ag_cont_abpc_low: analog gain for low sensitivity image of ABPC
> + * @ag_cont_rcnr_high: analog gain for high sensitivity image of RCNR
> + * @ag_cont_rcnr_middle_led: analog gain for middle sensitivity or led image of RCNR
> + * @ag_cont_rcnr_low: analog gain for low sensitivity image of RCNR
> + * @ag_cont_lssc: analog gain for LSSC
> + * @ag_cont_mpro: analog gain for color matrix correction
> + * @ag_cont_vpro: analog gain for image quality adjustment
> + * @dpc_defect_num_h:
> + *     the number of dynamically corrected defective pixel(high sensitivity image)
> + * @dpc_defect_num_m:
> + *     the number of dynamically corrected defective pixel(middle sensitivity or led image)
> + * @dpc_defect_num_l:
> + *     the number of dynamically corrected defective pixel(low sensitivity image)
> + * @hdrc_tnp_fb_smth_max: the maximum value of luminance information after smoothing filter at HDRC
> + * @avg_lum_weight: weighted average luminance value at average luminance generation
> + * @avg_lum_block[8][8]:
> + *     average luminance of each block [y][x]:
> + *     y means vertical position and x means horizontal position.
> + * @avg_lum_four_line_lum[4]:
> + *     4-lines average luminance. avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
> + * @avg_satur_pixnum: the number of saturated pixel at average luminance generation
> + * @avg_black_pixnum: the number of black pixel at average luminance generation
> + * @awb_ave_u: average U at AWHB [pixel]
> + * @awb_ave_v: average V at AWHB [pixel]
> + * @awb_accumulated_pixel: the number of accumulated pixel at AWHB
> + * @awb_gain_r: R gain applied in the next frame at AWHB
> + * @awb_gain_g: G gain applied in the next frame at AWHB
> + * @awb_gain_b: B gain applied in the next frame at AWHB
> + * @awb_status_u: status of U convergence at AWHB (true: converged, false: not converged)
> + * @awb_status_v: status of V convergence at AWHB (true: converged, false: not converged)
> + */
> +struct hwd_viif_l1_info {
> +	u32 context_id;
> +	u8 ag_cont_hobc_high;
> +	u8 ag_cont_hobc_middle_led;
> +	u8 ag_cont_hobc_low;
> +	u8 ag_cont_abpc_high;
> +	u8 ag_cont_abpc_middle_led;
> +	u8 ag_cont_abpc_low;
> +	u8 ag_cont_rcnr_high;
> +	u8 ag_cont_rcnr_middle_led;
> +	u8 ag_cont_rcnr_low;
> +	u8 ag_cont_lssc;
> +	u8 ag_cont_mpro;
> +	u8 ag_cont_vpro;
> +	u32 dpc_defect_num_h;
> +	u32 dpc_defect_num_m;
> +	u32 dpc_defect_num_l;
> +	u32 hdrc_tnp_fb_smth_max;
> +	u32 avg_lum_weight;
> +	u32 avg_lum_block[8][8];
> +	u32 avg_lum_four_line_lum[4];
> +	u16 avg_satur_pixnum;
> +	u16 avg_black_pixnum;
> +	u32 awb_ave_u;
> +	u32 awb_ave_v;
> +	u32 awb_accumulated_pixel;
> +	u32 awb_gain_r;
> +	u32 awb_gain_g;
> +	u32 awb_gain_b;
> +	bool awb_status_u;
> +	bool awb_status_v;
> +};
> +
> +/**
> + * struct hwd_viif_l2_gamma_table - HWD L2ISP Gamma table physical address
> + * @table[6]: table address(physical address) 4byte alignment
> + *
> + * relation between element and table is as below.
> + * * [0]: G/Y(1st table)
> + * * [1]: G/Y(2nd table)
> + * * [2]: B/U(1st table)
> + * * [3]: B/U(2nd table)
> + * * [4]: R/V(1st table)
> + * * [5]: R/V(2nd table)
> + *
> + * when 0 is set to table address, table transfer is disabled.
> + */
> +struct hwd_viif_l2_gamma_table {
> +	uintptr_t table[6];

Use dma_addr_t for fields that store DMA addresses. Same comment for all
the other usages of uintptr_t I think. While at it, don't name the
variables "paddr", those are not physical addresses but DMA addresses
(they can differ when an IOMMU is present). Use "dma_addr" or just
"addr" in variable names.

> +};

[snip]

> diff --git a/drivers/media/platform/visconti/hwd_viif_csi2rx.c b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
> new file mode 100644
> index 00000000000..f49869c5bdd
> --- /dev/null
> +++ b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/* Toshiba Visconti Video Capture Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/timekeeping.h>
> +#include "hwd_viif.h"
> +#include "hwd_viif_internal.h"
> +
> +#define CSI2_DT_YUV4208	  0x18
> +#define CSI2_DT_YUV42010  0x19
> +#define CSI2_DT_YUV4208L  0x1A
> +#define CSI2_DT_YUV4208C  0x1C
> +#define CSI2_DT_YUV42010C 0x1D
> +#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
> +#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
> +#define CSI2_DT_RGB444	  0x20
> +#define CSI2_DT_RGB555	  0x21
> +#define CSI2_DT_RGB565	  VISCONTI_CSI2_DT_RGB565
> +#define CSI2_DT_RGB666	  0x23
> +#define CSI2_DT_RGB888	  VISCONTI_CSI2_DT_RGB888
> +#define CSI2_DT_RAW8	  VISCONTI_CSI2_DT_RAW8
> +#define CSI2_DT_RAW10	  VISCONTI_CSI2_DT_RAW10
> +#define CSI2_DT_RAW12	  VISCONTI_CSI2_DT_RAW12
> +#define CSI2_DT_RAW14	  VISCONTI_CSI2_DT_RAW14

You can drop this and replace it with the macros defined in
include/media/mipi-csi2.h.

> +
> +#define TESTCTRL0_PHY_TESTCLK_1	     0x2
> +#define TESTCTRL0_PHY_TESTCLK_0	     0x0
> +#define TESTCTRL1_PHY_TESTEN	     0x10000
> +#define TESTCTRL1_PHY_TESTDOUT_SHIFT 8U
> +
> +/**
> + * write_dphy_param() - Write CSI2RX DPHY params
> + *
> + * @test_mode: test code address
> + * @test_in: test code data
> + * Return: None
> + */
> +static void write_dphy_param(u32 test_mode, u8 test_in, struct hwd_viif_res *res)
> +{
> +	/* select MSB address register */
> +	writel(TESTCTRL1_PHY_TESTEN, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +
> +	/* rise and clear the testclk */
> +	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +
> +	/* set MSB address of test_mode */
> +	writel(FIELD_GET(0xF00, test_mode), &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +
> +	/* rise and clear the testclk */
> +	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +
> +	/* select and set LSB address register */
> +	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
> +	       &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +
> +	/* rise and clear the testclk */
> +	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +
> +	/* set the test code data */
> +	writel((u32)test_in, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +
> +	/* rise and clear the testclk */
> +	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +}
> +
> +/**
> + * read_dphy_param() - Read CSI2RX DPHY params
> + *
> + * @test_mode: test code address
> + * Return: test code data
> + */
> +static u8 read_dphy_param(u32 test_mode, struct hwd_viif_res *res)
> +{
> +	u32 read_data;
> +
> +	/* select MSB address register */
> +	writel(TESTCTRL1_PHY_TESTEN, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +
> +	/* rise and clear the testclk */
> +	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +
> +	/* set MSB address of test_mode */
> +	writel(FIELD_GET(0xF00, test_mode), &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +
> +	/* rise and clear the testclk */
> +	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +
> +	/* select and set LSB address register */
> +	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
> +	       &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +
> +	/* rise and clear the testclk */
> +	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +
> +	/* read the test code data */
> +	read_data = readl(&res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> +	return (u8)(read_data >> TESTCTRL1_PHY_TESTDOUT_SHIFT);
> +}
> +
> +/**
> + * enum dphy_testcode - DPHY registers via the local communication path
> + */
> +enum dphy_testcode {
> +	DIG_RDWR_RX_SYS_0 = 0x001,
> +	DIG_RDWR_RX_SYS_1 = 0x002,
> +	DIG_RDWR_RX_SYS_3 = 0x004,
> +	DIG_RDWR_RX_SYS_7 = 0x008,
> +	DIG_RDWR_RX_RX_STARTUP_OVR_2 = 0x0E2,
> +	DIG_RDWR_RX_RX_STARTUP_OVR_3 = 0x0E3,
> +	DIG_RDWR_RX_RX_STARTUP_OVR_4 = 0x0E4,
> +	DIG_RDWR_RX_RX_STARTUP_OVR_5 = 0x0E5,
> +	DIG_RDWR_RX_CB_2 = 0x1AC,
> +	DIG_RD_RX_TERM_CAL_0 = 0x220,
> +	DIG_RD_RX_TERM_CAL_1 = 0x221,
> +	DIG_RD_RX_TERM_CAL_2 = 0x222,
> +	DIG_RDWR_RX_CLKLANE_LANE_6 = 0x307,
> +	DIG_RD_RX_CLKLANE_OFFSET_CAL_0 = 0x39D,
> +	DIG_RD_RX_LANE0_OFFSET_CAL_0 = 0x59F,
> +	DIG_RD_RX_LANE0_DDL_0 = 0x5E0,
> +	DIG_RD_RX_LANE1_OFFSET_CAL_0 = 0x79F,
> +	DIG_RD_RX_LANE1_DDL_0 = 0x7E0,
> +	DIG_RD_RX_LANE2_OFFSET_CAL_0 = 0x99F,
> +	DIG_RD_RX_LANE2_DDL_0 = 0x9E0,
> +	DIG_RD_RX_LANE3_OFFSET_CAL_0 = 0xB9F,
> +	DIG_RD_RX_LANE3_DDL_0 = 0xBE0,
> +};
> +
> +#define SYS_0_HSFREQRANGE_OVR  BIT(5)
> +#define SYS_7_RESERVED	       FIELD_PREP(0x1F, 0x0C)
> +#define SYS_7_DESKEW_POL       BIT(5)
> +#define STARTUP_OVR_4_CNTVAL   FIELD_PREP(0x70, 0x01)
> +#define STARTUP_OVR_4_DDL_EN   BIT(0)
> +#define STARTUP_OVR_5_BYPASS   BIT(0)
> +#define CB_2_LPRX_BIAS	       BIT(6)
> +#define CB_2_RESERVED	       FIELD_PREP(0x3F, 0x0B)
> +#define CLKLANE_RXHS_PULL_LONG BIT(7)
> +
> +static const struct hwd_viif_dphy_hs_info dphy_hs_info[] = {
> +	{ 80, 0x0, 0x1cc },   { 85, 0x10, 0x1cc },   { 95, 0x20, 0x1cc },   { 105, 0x30, 0x1cc },
> +	{ 115, 0x1, 0x1cc },  { 125, 0x11, 0x1cc },  { 135, 0x21, 0x1cc },  { 145, 0x31, 0x1cc },
> +	{ 155, 0x2, 0x1cc },  { 165, 0x12, 0x1cc },  { 175, 0x22, 0x1cc },  { 185, 0x32, 0x1cc },
> +	{ 198, 0x3, 0x1cc },  { 213, 0x13, 0x1cc },  { 228, 0x23, 0x1cc },  { 243, 0x33, 0x1cc },
> +	{ 263, 0x4, 0x1cc },  { 288, 0x14, 0x1cc },  { 313, 0x25, 0x1cc },  { 338, 0x35, 0x1cc },
> +	{ 375, 0x5, 0x1cc },  { 425, 0x16, 0x1cc },  { 475, 0x26, 0x1cc },  { 525, 0x37, 0x1cc },
> +	{ 575, 0x7, 0x1cc },  { 625, 0x18, 0x1cc },  { 675, 0x28, 0x1cc },  { 725, 0x39, 0x1cc },
> +	{ 775, 0x9, 0x1cc },  { 825, 0x19, 0x1cc },  { 875, 0x29, 0x1cc },  { 925, 0x3a, 0x1cc },
> +	{ 975, 0xa, 0x1cc },  { 1025, 0x1a, 0x1cc }, { 1075, 0x2a, 0x1cc }, { 1125, 0x3b, 0x1cc },
> +	{ 1175, 0xb, 0x1cc }, { 1225, 0x1b, 0x1cc }, { 1275, 0x2b, 0x1cc }, { 1325, 0x3c, 0x1cc },
> +	{ 1375, 0xc, 0x1cc }, { 1425, 0x1c, 0x1cc }, { 1475, 0x2c, 0x1cc }
> +};
> +
> +/**
> + * get_dphy_hs_transfer_info() - Get DPHY HS info from table
> + *
> + * @dphy_rate: DPHY clock in MHz
> + * @hsfreqrange: HS Frequency Range
> + * @osc_freq_target: OSC Frequency Target
> + * Return: None
> + */
> +static void get_dphy_hs_transfer_info(u32 dphy_rate, u32 *hsfreqrange, u32 *osc_freq_target,
> +				      struct hwd_viif_res *res)
> +{
> +	int table_size = ARRAY_SIZE(dphy_hs_info);
> +	int i;
> +
> +	for (i = 1; i < table_size; i++) {
> +		if (dphy_rate < dphy_hs_info[i].rate) {
> +			*hsfreqrange = dphy_hs_info[i - 1].hsfreqrange;
> +			*osc_freq_target = dphy_hs_info[i - 1].osc_freq_target;
> +			return;
> +		}
> +	}
> +
> +	/* not found; return the largest entry */
> +	*hsfreqrange = dphy_hs_info[table_size - 1].hsfreqrange;
> +	*osc_freq_target = dphy_hs_info[table_size - 1].osc_freq_target;
> +}
> +
> +/**
> + * hwd_viif_csi2rx_set_dphy_rate() - Set D-PHY rate
> + *
> + * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
> + * Return: None
> + */
> +static void hwd_viif_csi2rx_set_dphy_rate(u32 dphy_rate, struct hwd_viif_res *res)
> +{
> +	u32 hsfreqrange, osc_freq_target;
> +
> +	get_dphy_hs_transfer_info(dphy_rate, &hsfreqrange, &osc_freq_target, res);
> +
> +	write_dphy_param(DIG_RDWR_RX_SYS_1, (u8)hsfreqrange, res);
> +	write_dphy_param(DIG_RDWR_RX_SYS_0, SYS_0_HSFREQRANGE_OVR, res);
> +	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_5, STARTUP_OVR_5_BYPASS, res);
> +	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4, STARTUP_OVR_4_CNTVAL, res);
> +	write_dphy_param(DIG_RDWR_RX_CB_2, CB_2_LPRX_BIAS | CB_2_RESERVED, res);
> +	write_dphy_param(DIG_RDWR_RX_SYS_7, SYS_7_DESKEW_POL | SYS_7_RESERVED, res);
> +	write_dphy_param(DIG_RDWR_RX_CLKLANE_LANE_6, CLKLANE_RXHS_PULL_LONG, res);
> +	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_2, FIELD_GET(0xff, osc_freq_target), res);
> +	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_3, FIELD_GET(0xf00, osc_freq_target), res);
> +	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4, STARTUP_OVR_4_CNTVAL | STARTUP_OVR_4_DDL_EN,
> +			 res);
> +
> +	writel(HWD_VIIF_DPHY_CFG_CLK_25M, &res->capture_reg->sys.DPHY_FREQRANGE);
> +}
> +
> +/**
> + * check_dphy_calibration_status() - Check D-PHY calibration status
> + *
> + * @test_mode: test code related to calibration information
> + * @shift_val_err: shift value related to error information
> + * @shift_val_done: shift value related to done information
> + * Return: HWD_VIIF_CSI2_CAL_NOT_DONE calibration is not done(out of target or not completed)
> + * Return: HWD_VIIF_CSI2_CAL_FAIL calibration was failed
> + * Return: HWD_VIIF_CSI2_CAL_SUCCESS calibration was succeeded
> + */
> +static u32 check_dphy_calibration_status(u32 test_mode, u32 shift_val_err, u32 shift_val_done,
> +					 struct hwd_viif_res *res)
> +{
> +	u32 read_data = (u32)read_dphy_param(test_mode, res);
> +
> +	if (!(read_data & BIT(shift_val_done)))
> +		return HWD_VIIF_CSI2_CAL_NOT_DONE;
> +
> +	/* error check is not required for termination calibration with REXT(0x221) */
> +	if (test_mode == DIG_RD_RX_TERM_CAL_1)
> +		return HWD_VIIF_CSI2_CAL_SUCCESS;
> +
> +	/* done with error */
> +	if (read_data & BIT(shift_val_err))
> +		return HWD_VIIF_CSI2_CAL_FAIL;
> +
> +	return HWD_VIIF_CSI2_CAL_SUCCESS;
> +}
> +
> +/**
> + * hwd_viif_csi2rx_initialize() - Initialize CSI-2 RX driver
> + *
> + * @num_lane: [1..4](VIIF CH0-CH1)
> + * @lane_assign: lane connection. For more refer @ref hwd_viif_dphy_lane_assignment
> + * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
> + * @rext_calibration: enable or disable rext calibration.
> + *                    For more refer @ref hwd_viif_csi2rx_cal_status
> + * @err_target: Pointer to configuration for Line error detection.
> + * @mask: MASK of CSI-2 RX error interruption
> + * Return: 0 Operation completes successfully
> + * Return: -EINVAL Parameter error
> + * - [1] "num_lane", "lane_assign", "dphy_rate", "rext_calibration" or "input_mode" is out of range
> + * - [2] "err_target" is NULL
> + * - [3] member of "err_target" is invalid
> + */
> +s32 hwd_viif_csi2rx_initialize(struct hwd_viif_res *res, u32 num_lane, u32 lane_assign,
> +			       u32 dphy_rate, u32 rext_calibration,
> +			       const struct hwd_viif_csi2rx_line_err_target *err_target,
> +			       const struct hwd_viif_csi2rx_irq_mask *mask)
> +{
> +	u32 i, val;
> +
> +	if (num_lane == 0U || num_lane > 4U || lane_assign > HWD_VIIF_CSI2_DPHY_L0L2L1L3)
> +		return -EINVAL;
> +
> +	if (dphy_rate < HWD_VIIF_DPHY_MIN_DATA_RATE || dphy_rate > HWD_VIIF_DPHY_MAX_DATA_RATE ||
> +	    (rext_calibration != HWD_VIIF_ENABLE && rext_calibration != HWD_VIIF_DISABLE) ||
> +	    !err_target) {
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < 8U; i++) {
> +		if (err_target->vc[i] > HWD_VIIF_CSI2_MAX_VC ||
> +		    err_target->dt[i] > HWD_VIIF_CSI2_MAX_DT ||
> +		    (err_target->dt[i] < HWD_VIIF_CSI2_MIN_DT && err_target->dt[i] != 0U)) {
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* 1st phase of initialization */
> +	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_RESETN);
> +	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
> +	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
> +	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	ndelay(15U);
> +	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +
> +	/* Configure D-PHY frequency range */
> +	hwd_viif_csi2rx_set_dphy_rate(dphy_rate, res);
> +
> +	/* 2nd phase of initialization */
> +	writel((num_lane - 1U), &res->csi2host_reg->CSI2RX_NLANES);
> +	ndelay(5U);
> +
> +	/* configuration not to use rext */
> +	if (rext_calibration == HWD_VIIF_DISABLE) {
> +		write_dphy_param(0x004, 0x10, res);
> +		ndelay(5U);
> +	}
> +
> +	/* Release D-PHY from Reset */
> +	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
> +	ndelay(5U);
> +	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
> +
> +	/* configuration of line error target */
> +	val = (err_target->vc[3] << 30U) | (err_target->dt[3] << 24U) | (err_target->vc[2] << 22U) |
> +	      (err_target->dt[2] << 16U) | (err_target->vc[1] << 14U) | (err_target->dt[1] << 8U) |
> +	      (err_target->vc[0] << 6U) | (err_target->dt[0]);
> +	writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_1);
> +	val = (err_target->vc[7] << 30U) | (err_target->dt[7] << 24U) | (err_target->vc[6] << 22U) |
> +	      (err_target->dt[6] << 16U) | (err_target->vc[5] << 14U) | (err_target->dt[5] << 8U) |
> +	      (err_target->vc[4] << 6U) | (err_target->dt[4]);
> +	writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_2);
> +
> +	/* configuration of mask */
> +	writel(mask->mask[0], &res->csi2host_reg->CSI2RX_INT_MSK_PHY_FATAL);
> +	writel(mask->mask[1], &res->csi2host_reg->CSI2RX_INT_MSK_PKT_FATAL);
> +	writel(mask->mask[2], &res->csi2host_reg->CSI2RX_INT_MSK_FRAME_FATAL);
> +	writel(mask->mask[3], &res->csi2host_reg->CSI2RX_INT_MSK_PHY);
> +	writel(mask->mask[4], &res->csi2host_reg->CSI2RX_INT_MSK_PKT);
> +	writel(mask->mask[5], &res->csi2host_reg->CSI2RX_INT_MSK_LINE);
> +
> +	/* configuration of lane assignment */
> +	writel(lane_assign, &res->capture_reg->sys.DPHY_LANE);
> +
> +	return 0;
> +}
> +
> +/**
> + * hwd_viif_csi2rx_uninitialize() - Uninitialize CSI-2 RX driver
> + *
> + * Return: 0 Operation completes successfully
> + */
> +s32 hwd_viif_csi2rx_uninitialize(struct hwd_viif_res *res)
> +{
> +	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
> +	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
> +	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> +	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_RESETN);
> +
> +	return 0;
> +}
> +
> +#define PORT_SEL_MAIN_LONG  0
> +#define PORT_SEL_MAIN_EMBED 1
> +#define PORT_SEL_SUB_LONG   4
> +#define PORT_SEL_SUB_EMBED  5
> +
> +static void config_vdm_wport(struct hwd_viif_res *res, int port_sel, u32 height, u32 pitch)
> +{
> +	struct hwd_viif_vdm_write_port_reg *wport;
> +	u32 start_addr, end_addr;
> +
> +	wport = &res->capture_reg->vdm.w_port[port_sel];
> +
> +	writel(pitch, &wport->VDM_W_PITCH);
> +	writel(height, &wport->VDM_W_HEIGHT);
> +	start_addr = readl(&wport->VDM_W_STADR);
> +	end_addr = start_addr + pitch - 1U;
> +	writel(end_addr, &wport->VDM_W_ENDADR);
> +}

The VDM doesn't seem to belong to the CSI-2 RX, I would move this to a
different file.

> +
> +/**
> + * hwd_viif_csi2rx_start() - Start CSI-2 input
> + *
> + * @vc_main: control CSI-2 input of MAIN unit.
> + *           enable with configured VC: 0, 1, 2 or 3, keep disabling:
> + * @vc_sub: control CSI-2 input of SUB unit.
> + *          enable with configured VC: 0, 1, 2 or 3, keep disabling:
> + * @packet: Pointer to packet information of embedded data and long packet data
> + * Return: 0 Operation completes successfully
> + * Return: -EINVAL Parameter error
> + * HWD_VIIF_CSI2_NOT_CAPTURE
> + * HWD_VIIF_CSI2_NOT_CAPTURE
> + * - [1] "vc_main" or "vc_sub" is out of range
> + * - [2] member of "packet" is invalid
> + */
> +s32 hwd_viif_csi2rx_start(struct hwd_viif_res *res, s32 vc_main, s32 vc_sub,
> +			  const struct hwd_viif_csi2rx_packet *packet)
> +{
> +	u32 val, i, pitch, height, dt;
> +	u32 enable_vc0 = HWD_VIIF_DISABLE;
> +	u32 enable_vc1 = HWD_VIIF_DISABLE;
> +
> +	if (vc_main > 3 || vc_main < HWD_VIIF_CSI2_NOT_CAPTURE || vc_sub > 3 ||
> +	    vc_sub < HWD_VIIF_CSI2_NOT_CAPTURE) {
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < VISCONTI_CSI2RX_PACKET_TYPES_NUM; i++) {
> +		if (packet->word_count[i] > HWD_VIIF_CSI2_MAX_WORD_COUNT ||
> +		    packet->packet_num[i] > HWD_VIIF_CSI2_MAX_PACKET_NUM) {
> +			return -EINVAL;
> +		}
> +	}
> +
> +	writel(HWD_VIIF_INPUT_CSI2, &res->capture_reg->sys.IPORTM);
> +
> +	if (vc_main != HWD_VIIF_CSI2_NOT_CAPTURE) {
> +		writel((u32)vc_main, &res->capture_reg->sys.VCID0SELECT);
> +		enable_vc0 = HWD_VIIF_ENABLE;
> +	}
> +	if (vc_sub != HWD_VIIF_CSI2_NOT_CAPTURE) {
> +		writel((u32)vc_sub, &res->capture_reg->sys.VCID1SELECT);
> +		enable_vc1 = HWD_VIIF_ENABLE;
> +	}
> +
> +	/* configure Embedded Data transfer of MAIN unit */
> +	height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN];
> +	pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN], 4);
> +	config_vdm_wport(res, PORT_SEL_MAIN_EMBED, height, pitch);
> +
> +	/* configure Long Packet transfer of MAIN unit */
> +	dt = readl(&res->capture_reg->sys.IPORTM_OTHER);
> +	if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV4208C ||
> +	    dt == CSI2_DT_YUV42010C) {
> +		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN], 4) +
> +			ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN] * 2U, 4);
> +		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN] >> 1U;
> +	} else {
> +		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN], 4);
> +		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN];
> +	}
> +	config_vdm_wport(res, PORT_SEL_MAIN_LONG, height, pitch);
> +
> +	/* configure Embedded Data transfer of SUB unit */
> +	height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB];
> +	pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB], 4);
> +	config_vdm_wport(res, PORT_SEL_SUB_EMBED, height, pitch);
> +
> +	/* configure Long Packet transfer of SUB unit */
> +	dt = readl(&res->capture_reg->sys.IPORTS_OTHER);
> +	if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV42010 || dt == CSI2_DT_YUV4208C ||
> +	    dt == CSI2_DT_YUV42010C) {
> +		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB], 4) +
> +			ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB] * 2U, 4);
> +		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB] >> 1U;
> +	} else {
> +		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB], 4);
> +		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB];
> +	}
> +	config_vdm_wport(res, PORT_SEL_SUB_LONG, height, pitch);
> +
> +	/* Control VC port enable */
> +	val = enable_vc0 | (enable_vc1 << 4U);
> +	writel(val, &res->capture_reg->sys.VCPORTEN);
> +
> +	if (enable_vc0 == HWD_VIIF_ENABLE) {
> +		/* Update flag information for run status of MAIN unit */
> +		res->run_flag_main = true;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * hwd_viif_csi2rx_stop() - Stop CSI-2 input
> + *
> + * Return: 0 Operation completes successfully
> + * Return: -ETIMEDOUT Driver timeout error
> + */
> +s32 hwd_viif_csi2rx_stop(struct hwd_viif_res *res)
> +{
> +	u32 status_r, status_w, status_t, l2_status;
> +	u64 timeout_ns, cur_ns;
> +	bool run_flag = true;
> +	s32 ret = 0;
> +
> +	/* Disable auto transmission of register buffer */
> +	writel(0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
> +	writel(0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);

Same here, this doesn't belong to the CSI2RX. Same for VDMAC registers
below, and possibly some of the SYS registers (not sure about those).

Overall, the CSI2RX should be isolated in a subdev separate from the ISP
subdev, with a struct viif_csi2rx to model it. It should only control
the CSI2RX. I'm even tempted to move it to a separate driver, but that
maybe difficult due to usage of the SYS registers by the CSI2RX :-S

> +
> +	/* Wait for completion of register buffer transmission */
> +	udelay(HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME);
> +
> +	/* Stop all VCs, long packet input and emb data input of MAIN unit */
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.VCPORTEN);
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTM_OTHEREN);
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTM_EMBEN);
> +
> +	/* Stop image data input, long packet input and emb data input of SUB unit */
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_OTHEREN);
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_EMBEN);
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_IMGEN);
> +
> +	/* Stop VDMAC for all table ports, input ports and write ports */
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_T_ENABLE);
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_R_ENABLE);
> +	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_W_ENABLE);
> +
> +	/* Stop all groups(g00, g01 and g02) of VDMAC */
> +	writel(0x7, &res->capture_reg->vdm.VDM_ABORTSET);
> +
> +	timeout_ns = ktime_get_ns() + HWD_VIIF_WAIT_ABORT_COMPLETE_TIME * 1000;
> +
> +	do {
> +		/* Get VDMAC transfer status  */
> +		status_r = readl(&res->capture_reg->vdm.VDM_R_RUN);
> +		status_w = readl(&res->capture_reg->vdm.VDM_W_RUN);
> +		status_t = readl(&res->capture_reg->vdm.VDM_T_RUN);
> +
> +		l2_status = readl(&res->capture_reg->l2isp.L2_BUS_L2_STATUS);
> +
> +		if (status_r == 0U && status_w == 0U && status_t == 0U && l2_status == 0U)
> +			run_flag = false;
> +
> +		cur_ns = ktime_get_ns();
> +
> +		if (cur_ns > timeout_ns) {
> +			ret = -ETIMEDOUT;
> +			run_flag = false;
> +		}
> +	} while (run_flag);
> +
> +	if (ret == 0) {
> +		/* Clear run flag of MAIN unit */
> +		res->run_flag_main = false;
> +	}
> +
> +	return ret;
> +}

[snip]

> diff --git a/drivers/media/platform/visconti/hwd_viif_internal.h b/drivers/media/platform/visconti/hwd_viif_internal.h
> new file mode 100644
> index 00000000000..c954e804946
> --- /dev/null
> +++ b/drivers/media/platform/visconti/hwd_viif_internal.h
> @@ -0,0 +1,340 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/* Toshiba Visconti Video Capture Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#ifndef HWD_VIIF_INTERNAL_H
> +#define HWD_VIIF_INTERNAL_H
> +
> +#include "hwd_viif_reg.h"
> +
> +#define HWD_VIIF_CSI2_MAX_VC		    (3U)
> +#define HWD_VIIF_CSI2_MIN_DT		    (0x10U)
> +#define HWD_VIIF_CSI2_MAX_DT		    (0x3fU)
> +#define HWD_VIIF_CSI2_MAX_WORD_COUNT	    (16384U)
> +#define HWD_VIIF_CSI2_MAX_PACKET_NUM	    (8192U)
> +#define HWD_VIIF_DPHY_MIN_DATA_RATE	    (80U)
> +#define HWD_VIIF_DPHY_MAX_DATA_RATE	    (1500U)
> +#define HWD_VIIF_DPHY_CFG_CLK_25M	    (32U)
> +#define HWD_VIIF_DPHY_TRANSFER_HS_TABLE_NUM (43U)
> +
> +/* maximum horizontal/vertical position/dimension of CROP with ISP */
> +#define HWD_VIIF_CROP_MAX_X_ISP (8062U)
> +#define HWD_VIIF_CROP_MAX_Y_ISP (3966U)
> +#define HWD_VIIF_CROP_MAX_W_ISP (8190U)
> +#define HWD_VIIF_CROP_MAX_H_ISP (4094U)
> +
> +/* maximum horizontal/vertical position/dimension of CROP without ISP */
> +#define HWD_VIIF_CROP_MAX_X (1920U)
> +#define HWD_VIIF_CROP_MAX_Y (1408U)
> +#define HWD_VIIF_CROP_MIN_W (128U)
> +#define HWD_VIIF_CROP_MAX_W (2048U)
> +#define HWD_VIIF_CROP_MIN_H (128U)
> +#define HWD_VIIF_CROP_MAX_H (1536U)
> +
> +/* pixel clock: [kHz] */
> +#define HWD_VIIF_MIN_PIXEL_CLOCK (3375U)
> +#define HWD_VIIF_MAX_PIXEL_CLOCK (600000U)
> +
> +/* picture size: [pixel], [ns] */
> +#define HWD_VIIF_MIN_HTOTAL_PIXEL (143U)
> +#define HWD_VIIF_MIN_HTOTAL_NSEC  (239U)
> +#define HWD_VIIF_MAX_HTOTAL_PIXEL (65535U)
> +#define HWD_VIIF_MAX_HTOTAL_NSEC  (109225U)
> +
> +/* horizontal back porch size: [system clock] */
> +#define HWD_VIIF_HBP_SYSCLK (10U)
> +
> +/* active picture size: [pixel] */
> +#define HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP (128U)
> +#define HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP (4096U)
> +#define HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP  (640U)
> +#define HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP  (3840U)
> +
> +/* picture vertical size: [line], [packet] */
> +#define HWD_VIIF_MIN_VTOTAL_LINE	   (144U)
> +#define HWD_VIIF_MAX_VTOTAL_LINE	   (16383U)
> +#define HWD_VIIF_MIN_VBP_LINE		   (5U)
> +#define HWD_VIIF_MAX_VBP_LINE		   (4095U)
> +#define HWD_VIIF_MIN_VBP_PACKET		   (5U)
> +#define HWD_VIIF_MAX_VBP_PACKET		   (4095U)
> +#define HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP (128U)
> +#define HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP (2160U)
> +#define HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP  (480U)
> +#define HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP  (2160U)
> +
> +/* image source select */
> +#define HWD_VIIF_INPUT_CSI2 (0U)

This macro is related to a hardware register, and should thus be moved
to the hwd_viif_reg.h file. Same for other macros in this file as
applicable.

> +
> +#define HWD_VIIF_CSC_MAX_OFFSET	       (0x0001FFFFU)
> +#define HWD_VIIF_CSC_MAX_COEF_VALUE    (0x0000FFFFU)
> +#define HWD_VIIF_CSC_MAX_COEF_NUM      (9U)
> +#define HWD_VIIF_GAMMA_MAX_VSPLIT      (4094U)
> +#define HWD_VIIF_MTB_CB_YG_COEF_OFFSET (16U)
> +#define HWD_VIIF_MTB_CR_YG_COEF_OFFSET (0U)
> +#define HWD_VIIF_MTB_CB_CB_COEF_OFFSET (16U)
> +#define HWD_VIIF_MTB_CR_CB_COEF_OFFSET (0U)
> +#define HWD_VIIF_MTB_CB_CR_COEF_OFFSET (16U)
> +#define HWD_VIIF_MTB_CR_CR_COEF_OFFSET (0U)
> +#define HWD_VIIF_MAX_PITCH_ISP	       (32704U)
> +#define HWD_VIIF_MAX_PITCH	       (65536U)
> +
> +/* size of minimum/maximum input image */
> +#define HWD_VIIF_MIN_INPUT_IMG_WIDTH	  (128U)
> +#define HWD_VIIF_MAX_INPUT_IMG_WIDTH_ISP  (4096U)
> +#define HWD_VIIF_MAX_INPUT_IMG_WIDTH	  (2048U)
> +#define HWD_VIIF_MIN_INPUT_IMG_HEIGHT	  (128U)
> +#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT_ISP (2160U)
> +#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT	  (1536U)
> +#define HWD_VIIF_MAX_INPUT_LINE_SIZE	  (16384U)
> +
> +/* size of minimum/maximum output image */
> +#define HWD_VIIF_MIN_OUTPUT_IMG_WIDTH	  (128U)
> +#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP (5760U)
> +#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB (4096U)
> +
> +#define HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT	   (128U)
> +#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP (3240U)
> +#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB (2160U)
> +
> +#define HWD_VIIF_NO_EVENT (0x0U)

Just use 0 in the code, as for HWD_VIIF_DISABLE.

> +
> +/* System clock: [kHz] */
> +#define HWD_VIIF_SYS_CLK (500000UL)

Shouldn't the system clock rate be retrieved dynamically at runtime
(possibly at probe time and cached) with clk_get_rate() instead of being
hardcoded ?

> +
> +/*
> + * wait time for force abort to complete(max 1line time = 1228.8[us]
> + * when width = 4096, RAW24, 80Mbps
> + */
> +#define HWD_VIIF_WAIT_ABORT_COMPLETE_TIME (1229U)
> +
> +/*
> + * complete time of register buffer transfer.
> + * actual time is about 30us in case of L1ISP
> + */
> +#define HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME (39U)
> +
> +/* internal operation latencies: [system clock]*/
> +#define HWD_VIIF_TABLE_LOAD_TIME    (24000UL)
> +#define HWD_VIIF_REGBUF_ACCESS_TIME (15360UL)
> +
> +/* offset of Vsync delay: [line] */
> +#define HWD_VIIF_L1_DELAY_W_HDRC  (31U)
> +#define HWD_VIIF_L1_DELAY_WO_HDRC (11U)
> +
> +/* data width is 32bit */
> +#define HWD_VIIF_VDM_CFG_PARAM (0x00000210U)
> +
> +/* vsync mode is pulse */
> +#define HWD_VIIF_DPGM_VSYNC_PULSE (1U)
> +
> +/* Vlatch mask bit for L1ISP and L2ISP */
> +#define HWD_VIIF_ISP_VLATCH_MASK (2U)
> +
> +/* Register buffer */
> +#define HWD_VIIF_ISP_MAX_CONTEXT_NUM	(4U)
> +#define HWD_VIIF_ISP_REGBUF_MODE_BYPASS (0U)
> +#define HWD_VIIF_ISP_REGBUF_MODE_BUFFER (1U)
> +#define HWD_VIIF_ISP_REGBUF_READ	(1U)

[snip]

> +/**
> + * struct hwd_viif_l2_roi_path_info - L2ISP ROI path control information
> + *
> + * @roi_num: the number of ROIs which are used.
> + * @post_enable_flag: flag to show which of POST is enabled.
> + * @post_crop_x: CROP x of each L2ISP POST
> + * @post_crop_y: CROP y of each L2ISP POST
> + * @post_crop_w: CROP w of each L2ISP POST
> + * @post_crop_h: CROP h of each L2ISP POST
> + */
> +struct hwd_viif_l2_roi_path_info {
> +	u32 roi_num;
> +	bool post_enable_flag[HWD_VIIF_MAX_POST_NUM];
> +	u32 post_crop_x[HWD_VIIF_MAX_POST_NUM];
> +	u32 post_crop_y[HWD_VIIF_MAX_POST_NUM];
> +	u32 post_crop_w[HWD_VIIF_MAX_POST_NUM];
> +	u32 post_crop_h[HWD_VIIF_MAX_POST_NUM];
> +};
> +
> +/**
> + * struct hwd_viif_res - driver internal resource structure
> + *
> + * @clock_id: clock ID of each unit
> + * @csi2_clock_id: clock ID of CSI-2 RX
> + * @csi2_reset_id: reset ID of CSI-2 RX
> + * @pixel_clock: pixel clock
> + * @htotal_size: horizontal total size
> + * @dt_image_main_w_isp: Data type of image data for ISP path
> + * @csi2host_reg: pointer to register access structure of CSI-2 RX host controller
> + * @capture_reg: pointer to register access structure of capture unit
> + * @l2_roi_path_info: ROI path information of L2ISP
> + * @run_flag_main: run flag of MAIN unit(true: run, false: not run)
> + */
> +struct hwd_viif_res {
> +	//u32 clock_id;
> +	//u32 csi2_clock_id;
> +	//u32 csi2_reset_id;

Please drop commented-out code.

> +	u32 pixel_clock;
> +	u32 htotal_size;
> +	u32 dt_image_main_w_isp;
> +	struct hwd_viif_csi2host_reg *csi2host_reg;
> +	struct hwd_viif_capture_reg *capture_reg;
> +	struct hwd_viif_l2_roi_path_info l2_roi_path_info;
> +	bool run_flag_main;
> +};
> +
> +/**
> + * struct hwd_viif_dphy_hs_info - dphy hs information
> + *
> + * @rate: Data rate [Mbps]
> + * @hsfreqrange: IP operating frequency(hsfreqrange)
> + * @osc_freq_target: DDL target oscillation frequency(osc_freq_target)
> + */
> +struct hwd_viif_dphy_hs_info {
> +	u32 rate;
> +	u32 hsfreqrange;
> +	u32 osc_freq_target;
> +};
> +
> +#endif /* HWD_VIIF_INTERNAL_H */
> diff --git a/drivers/media/platform/visconti/hwd_viif_reg.h b/drivers/media/platform/visconti/hwd_viif_reg.h
> new file mode 100644
> index 00000000000..b7f43c5fe95
> --- /dev/null
> +++ b/drivers/media/platform/visconti/hwd_viif_reg.h
> @@ -0,0 +1,2802 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/* Toshiba Visconti Video Capture Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#ifndef HWD_VIIF_REG_H
> +#define HWD_VIIF_REG_H
> +
> +/**
> + * struct hwd_viif_csi2host_reg - Registers for VIIF CSI2HOST control
> + */
> +struct hwd_viif_csi2host_reg {

As noted by Sakari in his review, kernel drivers usually use macros for
register addresses. I'm not entirely opposed to using structures, but I
share his concerns. Furthermore, macros would allow writing convenience
wrappers around writel():

struct viif_csi2rx
{
	...
	void __iomem *regs;
	...
};

static inline void viif_csi2rx_write(struct viif_csi2rx *csi2rx, u32 reg, u32 val)
{
	writel(val, csi2rx->regs + reg);
}

Similar functions can be written for other register spaces. This
improves (I think) code readability (I may be biased though).


In any case, grouping all register definitions in a file, separate from
the rest of the headers, is nice, but register bits should also be
defined in the same file, as macros. For instance, in
viif_csi2rx_initialize() you have

	/* Define errors to be masked */
	csi2rx_mask.mask[0] = 0x0000000F; /*check all for PHY_FATAL*/
	csi2rx_mask.mask[1] = 0x0001000F; /*check all for PKT_FATAL*/
	csi2rx_mask.mask[2] = 0x000F0F0F; /*check all for FRAME_FATAL*/
	csi2rx_mask.mask[3] = 0x000F000F; /*check all for PHY*/
	csi2rx_mask.mask[4] = 0x000F000F; /*check all for PKT*/
	csi2rx_mask.mask[5] = 0x00FF00FF; /*check all for LINE*/

	return hwd_viif_csi2rx_initialize(viif_dev->hwd_res, num_lane, HWD_VIIF_CSI2_DPHY_L0L1L2L3,
					  dphy_rate, HWD_VIIF_ENABLE, &err_target, &csi2rx_mask);

where csi2rx_mask is then written to the CSI2RX_INT_MSK_* registers.
Those numerical values should use macros that name the bits. The macros
should be named according to the register they're related to (something
like VIIF_CSI2RX_INT_MSK_PHY_FATAL_* for the CSI2RX_INT_MSK_PHY_FATAL
register for instance). I would also place them right after the
CSI2RX_INT_MSK_PHY_FATAL field below, in order to group registers and
their bits together:

	u32 CSI2RX_INT_MSK_PHY_FATAL;
#define VIIF_CSI2RX_INT_MSK_PHY_FATAL_FOO	BIT(0)
#define VIIF_CSI2RX_INT_MSK_PHY_FATAL_BAR	BIT(1)
...
	u32 CSI2RX_INT_FORCE_PHY_FATAL;
...

> +	u32 RESERVED_A_1;
> +	u32 CSI2RX_NLANES;
> +	u32 CSI2RX_RESETN;
> +	u32 CSI2RX_INT_ST_MAIN;
> +	u32 CSI2RX_DATA_IDS_1;
> +	u32 CSI2RX_DATA_IDS_2;
> +	u32 RESERVED_B_1[10];
> +	u32 CSI2RX_PHY_SHUTDOWNZ;
> +	u32 CSI2RX_PHY_RSTZ;
> +	u32 CSI2RX_PHY_RX;
> +	u32 CSI2RX_PHY_STOPSTATE;
> +	u32 CSI2RX_PHY_TESTCTRL0;
> +	u32 CSI2RX_PHY_TESTCTRL1;
> +	u32 RESERVED_B_2[34];
> +	u32 CSI2RX_INT_ST_PHY_FATAL;
> +	u32 CSI2RX_INT_MSK_PHY_FATAL;
> +	u32 CSI2RX_INT_FORCE_PHY_FATAL;
> +	u32 RESERVED_B_3[1];
> +	u32 CSI2RX_INT_ST_PKT_FATAL;
> +	u32 CSI2RX_INT_MSK_PKT_FATAL;
> +	u32 CSI2RX_INT_FORCE_PKT_FATAL;
> +	u32 RESERVED_B_4[1];
> +	u32 CSI2RX_INT_ST_FRAME_FATAL;
> +	u32 CSI2RX_INT_MSK_FRAME_FATAL;
> +	u32 CSI2RX_INT_FORCE_FRAME_FATAL;
> +	u32 RESERVED_B_5[1];
> +	u32 CSI2RX_INT_ST_PHY;
> +	u32 CSI2RX_INT_MSK_PHY;
> +	u32 CSI2RX_INT_FORCE_PHY;
> +	u32 RESERVED_B_6[1];
> +	u32 CSI2RX_INT_ST_PKT;
> +	u32 CSI2RX_INT_MSK_PKT;
> +	u32 CSI2RX_INT_FORCE_PKT;
> +	u32 RESERVED_B_7[1];
> +	u32 CSI2RX_INT_ST_LINE;
> +	u32 CSI2RX_INT_MSK_LINE;
> +	u32 CSI2RX_INT_FORCE_LINE;
> +	u32 RESERVED_B_8[113];
> +	u32 RESERVED_A_2;
> +	u32 RESERVED_A_3;
> +	u32 RESERVED_A_4;
> +	u32 RESERVED_A_5;
> +	u32 RESERVED_A_6;

Can this be written

	u32 RESERVED_A_2_6[5];

? There are large blocks of reserved registers below, it would help
shortening the file.

> +	u32 RESERVED_B_9[58];
> +	u32 RESERVED_A_7;
> +};

[snip]

> +/**
> + * struct hwd_viif_l1isp_reg - Registers for VIIF L1ISP control
> + */
> +struct hwd_viif_l1isp_reg {
> +	u32 L1_SYSM_WIDTH;
> +	u32 L1_SYSM_HEIGHT;
> +	u32 L1_SYSM_START_COLOR;
> +	u32 L1_SYSM_INPUT_MODE;
> +	u32 RESERVED_A_1;
> +	u32 L1_SYSM_YCOEF_R;
> +	u32 L1_SYSM_YCOEF_G;
> +	u32 L1_SYSM_YCOEF_B;
> +	u32 L1_SYSM_INT_STAT;
> +	u32 L1_SYSM_INT_MASKED_STAT;
> +	u32 L1_SYSM_INT_MASK;
> +	u32 RESERVED_A_2;
> +	u32 RESERVED_A_3;
> +	u32 RESERVED_A_4;
> +	u32 RESERVED_B_1[2];
> +	u32 L1_SYSM_AG_H;
> +	u32 L1_SYSM_AG_M;
> +	u32 L1_SYSM_AG_L;
> +	u32 L1_SYSM_AG_PARAM_A;
> +	u32 L1_SYSM_AG_PARAM_B;
> +	u32 L1_SYSM_AG_PARAM_C;
> +	u32 L1_SYSM_AG_PARAM_D;
> +	u32 L1_SYSM_AG_SEL_HOBC;
> +	u32 L1_SYSM_AG_SEL_ABPC;
> +	u32 L1_SYSM_AG_SEL_RCNR;
> +	u32 L1_SYSM_AG_SEL_LSSC;
> +	u32 L1_SYSM_AG_SEL_MPRO;
> +	u32 L1_SYSM_AG_SEL_VPRO;
> +	u32 L1_SYSM_AG_CONT_HOBC01_EN;
> +	u32 L1_SYSM_AG_CONT_HOBC2_EN;
> +	u32 L1_SYSM_AG_CONT_ABPC01_EN;
> +	u32 L1_SYSM_AG_CONT_ABPC2_EN;
> +	u32 L1_SYSM_AG_CONT_RCNR01_EN;
> +	u32 L1_SYSM_AG_CONT_RCNR2_EN;
> +	u32 L1_SYSM_AG_CONT_LSSC_EN;
> +	u32 L1_SYSM_AG_CONT_MPRO_EN;
> +	u32 L1_SYSM_AG_CONT_VPRO_EN;
> +	u32 L1_SYSM_CTXT;
> +	u32 L1_SYSM_MAN_CTXT;
> +	u32 RESERVED_A_5;
> +	u32 RESERVED_B_2[7];
> +	u32 RESERVED_A_6;
> +	u32 L1_HDRE_SRCPOINT00;
> +	u32 L1_HDRE_SRCPOINT01;
> +	u32 L1_HDRE_SRCPOINT02;
> +	u32 L1_HDRE_SRCPOINT03;
> +	u32 L1_HDRE_SRCPOINT04;
> +	u32 L1_HDRE_SRCPOINT05;
> +	u32 L1_HDRE_SRCPOINT06;
> +	u32 L1_HDRE_SRCPOINT07;
> +	u32 L1_HDRE_SRCPOINT08;
> +	u32 L1_HDRE_SRCPOINT09;
> +	u32 L1_HDRE_SRCPOINT10;
> +	u32 L1_HDRE_SRCPOINT11;
> +	u32 L1_HDRE_SRCPOINT12;
> +	u32 L1_HDRE_SRCPOINT13;
> +	u32 L1_HDRE_SRCPOINT14;
> +	u32 L1_HDRE_SRCPOINT15;

This also seems to be a candidate for an array:

	u32 L1_HDRE_SRCPOINT[16];

Not only will it shorten this file, it will also make the code simpler
as you'll be able to replace

	writel(param->hdre_src_point[0], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT00);
	writel(param->hdre_src_point[1], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT01);
	writel(param->hdre_src_point[2], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT02);
	writel(param->hdre_src_point[3], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT03);
	writel(param->hdre_src_point[4], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT04);
	writel(param->hdre_src_point[5], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT05);
	writel(param->hdre_src_point[6], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT06);
	writel(param->hdre_src_point[7], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT07);
	writel(param->hdre_src_point[8], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT08);
	writel(param->hdre_src_point[9], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT09);
	writel(param->hdre_src_point[10], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT10);
	writel(param->hdre_src_point[11], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT11);
	writel(param->hdre_src_point[12], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT12);
	writel(param->hdre_src_point[13], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT13);
	writel(param->hdre_src_point[14], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT14);
	writel(param->hdre_src_point[15], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT15);

with

	for (i = 0; i < ARRAY_SIZE(param->hdre_src_point); ++i)
		writel(param->hdre_src_point[i], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT[i]);

Same in quite a few other locations.

[snip]

> +};

[snip]

> diff --git a/include/uapi/linux/visconti_viif.h b/include/uapi/linux/visconti_viif.h
> new file mode 100644
> index 00000000000..f92278425b7
> --- /dev/null
> +++ b/include/uapi/linux/visconti_viif.h
> @@ -0,0 +1,1724 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Toshiba Visconti Video Capture Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#ifndef __UAPI_VISCONTI_VIIF_H_
> +#define __UAPI_VISCONTI_VIIF_H_
> +
> +#include <linux/types.h>
> +#include <linux/videodev2.h>
> +
> +/* Visconti specific compound controls */
> +#define V4L2_CID_VISCONTI_VIIF_BASE			       (V4L2_CID_USER_BASE + 0x1000)
> +#define V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 1)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 2)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF	       (V4L2_CID_VISCONTI_VIIF_BASE + 3)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 4)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG		       (V4L2_CID_VISCONTI_VIIF_BASE + 5)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE		       (V4L2_CID_VISCONTI_VIIF_BASE + 6)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION       (V4L2_CID_VISCONTI_VIIF_BASE + 7)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC		       (V4L2_CID_VISCONTI_VIIF_BASE + 8)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE (V4L2_CID_VISCONTI_VIIF_BASE + 9)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION                                \
> +	(V4L2_CID_VISCONTI_VIIF_BASE + 10)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS			 (V4L2_CID_VISCONTI_VIIF_BASE + 11)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION (V4L2_CID_VISCONTI_VIIF_BASE + 12)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC			 (V4L2_CID_VISCONTI_VIIF_BASE + 13)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS		 (V4L2_CID_VISCONTI_VIIF_BASE + 14)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB			 (V4L2_CID_VISCONTI_VIIF_BASE + 15)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN		 (V4L2_CID_VISCONTI_VIIF_BASE + 16)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC			 (V4L2_CID_VISCONTI_VIIF_BASE + 17)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM		 (V4L2_CID_VISCONTI_VIIF_BASE + 18)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA			 (V4L2_CID_VISCONTI_VIIF_BASE + 19)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT (V4L2_CID_VISCONTI_VIIF_BASE + 20)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION	 (V4L2_CID_VISCONTI_VIIF_BASE + 21)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST		 (V4L2_CID_VISCONTI_VIIF_BASE + 22)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI			 (V4L2_CID_VISCONTI_VIIF_BASE + 23)
> +#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA			 (V4L2_CID_VISCONTI_VIIF_BASE + 24)
> +#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS	 (V4L2_CID_VISCONTI_VIIF_BASE + 25)
> +#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS		 (V4L2_CID_VISCONTI_VIIF_BASE + 26)
> +#define V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS		 (V4L2_CID_VISCONTI_VIIF_BASE + 27)
> +#define V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS		 (V4L2_CID_VISCONTI_VIIF_BASE + 28)

First of all, thank you for taking the time to write all these, as well
as the control documentation.

This is a *lot* of controls, and each of them store a potentially large
quantity of data. Unless I'm mistaken, the driver doesn't use the
request API, which means that there's no synchronization between control
values and frames. Isn't that a problem ? I'm wondering if a mechanism
based on parameters buffers (like the rkisp1 driver for instance)
wouldn't be a better fit.

> +/* Enable/Disable flag */
> +#define VIIF_DISABLE (0U)
> +#define VIIF_ENABLE  (1U)

No need for parentheses.

[snip]

> +#endif /* __UAPI_VISCONTI_VIIF_H_ */

-- 
Regards,

Laurent Pinchart
