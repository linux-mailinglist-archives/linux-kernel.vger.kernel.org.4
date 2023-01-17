Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9892066DA79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjAQKBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjAQKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:01:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43021EC7D;
        Tue, 17 Jan 2023 02:01:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B62F1CE13DA;
        Tue, 17 Jan 2023 10:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC57C433EF;
        Tue, 17 Jan 2023 10:01:08 +0000 (UTC)
Message-ID: <c07e3491-ccac-d487-de09-3576b534228d@xs4all.nl>
Date:   Tue, 17 Jan 2023 11:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-3-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
In-Reply-To: <20230111022433.25950-3-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

Some review comments below:

On 11/01/2023 03:24, Yuji Ishikawa wrote:
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
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index a9334263fa9..0908158036d 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -83,6 +83,7 @@ source "drivers/media/platform/sunxi/Kconfig"
>  source "drivers/media/platform/ti/Kconfig"
>  source "drivers/media/platform/verisilicon/Kconfig"
>  source "drivers/media/platform/via/Kconfig"
> +source "drivers/media/platform/visconti/Kconfig"

We're moving towards a "drivers/media/platform/<vendor>/<model>/" directory
structure, so it is better to move this driver to .../platform/toshiba/visconti/.

>  source "drivers/media/platform/xilinx/Kconfig"
>  
>  endif # MEDIA_PLATFORM_DRIVERS
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index a91f4202427..1c67cb56244 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -26,6 +26,7 @@ obj-y += sunxi/
>  obj-y += ti/
>  obj-y += verisilicon/
>  obj-y += via/
> +obj-y += visconti/
>  obj-y += xilinx/
>  
>  # Please place here only ancillary drivers that aren't SoC-specific
> diff --git a/drivers/media/platform/visconti/Kconfig b/drivers/media/platform/visconti/Kconfig
> new file mode 100644
> index 00000000000..031e4610809
> --- /dev/null
> +++ b/drivers/media/platform/visconti/Kconfig
> @@ -0,0 +1,9 @@
> +config VIDEO_VISCONTI_VIIF
> +	tristate "Visconti Camera Interface driver"
> +	depends on V4L_PLATFORM_DRIVERS && MEDIA_CONTROLLER && VIDEO_DEV
> +	depends on ARCH_VISCONTI

This should be: depends on ARCH_VISCONTI || COMPILE_TEST

We want to be able to compile this driver for other platforms as well.

> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE
> +	help
> +	  This is V4L2 driver for Toshiba Visconti Camera Interface driver
> +
> diff --git a/drivers/media/platform/visconti/Makefile b/drivers/media/platform/visconti/Makefile
> new file mode 100644
> index 00000000000..e14b904df75
> --- /dev/null
> +++ b/drivers/media/platform/visconti/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the Visconti video input device driver
> +#
> +
> +visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o
> +
> +obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
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

It's odd to see two copyrights from what looks like the same company.
Just checking: is this correct?

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
> +
> +struct hwd_viif_res *allocate_viif_res(struct device *dev, void *csi2host_vaddr,
> +				       void *capture_vaddr)
> +{
> +	struct hwd_viif_res *res = devm_kzalloc(dev, sizeof(struct hwd_viif_res), GFP_KERNEL);
> +
> +	res->csi2host_reg = csi2host_vaddr;
> +	res->capture_reg = capture_vaddr;
> +	res->run_flag_main = (bool)false;
> +	return res;
> +}
> +
> +/* Convert the unit of time-period (from sysclk, to num lines in the image) */
> +static u32 sysclk_to_numlines(u64 time_in_sysclk, const struct hwd_viif_input_img *img)
> +{
> +	u64 v1 = time_in_sysclk * (u64)img->pixel_clock;
> +	u64 v2 = (u64)img->htotal_size * HWD_VIIF_SYS_CLK;
> +
> +	return (u32)(v1 / v2);

Use div64_u64 instead so it will compile on platforms without native 64 bit division support.

> +}
> +
> +static u32 lineperiod_in_sysclk(u64 hsize, u64 pixel_clock)
> +{
> +	return (u32)(hsize * HWD_VIIF_SYS_CLK / pixel_clock);

Ditto.

> +}

<snip>

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
> +
> +/* System clock: [kHz] */
> +#define HWD_VIIF_SYS_CLK (500000UL)
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
> +
> +/* constants for L1 ISP*/
> +#define HWD_VIIF_L1_INPUT_MODE_NUM			 (5U)
> +#define HWD_VIIF_L1_INPUT_DEPTH_MIN			 (8U)
> +#define HWD_VIIF_L1_INPUT_DEPTH_MAX			 (24U)
> +#define HWD_VIIF_L1_INPUT_DEPTH_SDR_MAX			 (12U)
> +#define HWD_VIIF_L1_INPUT_DEPTH_PWL_MAX			 (14U)
> +#define HWD_VIIF_L1_RAW_MODE_NUM			 (4U)
> +#define HWD_VIIF_L1_INPUT_NUM_MIN			 (1U)
> +#define HWD_VIIF_L1_INPUT_NUM_MAX			 (3U)
> +#define HWD_VIIF_L1_AG_ID_NUM				 (4U)
> +#define HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM		 (3U)
> +#define HWD_VIIF_L1_HDRE_MAX_KNEEPOINT_VAL		 (0x3fffU)
> +#define HWD_VIIF_L1_HDRE_MAX_HDRE_SIG_VAL		 (0xffffffU)
> +#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_RATIO		 (0x400000U)
> +#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_VAL		 (0xffffffU)
> +#define HWD_VIIF_L1_OBCC_MAX_AG_VAL			 (511U)
> +#define HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL	 (0xffffffU)
> +#define HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL		 (1023U)
> +#define HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL		 (1U)
> +#define HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL		 (31U)
> +#define HWD_VIIF_L1_VDM_ALIGN				 (0x8U) /* port interface width is 64bit */
> +#define HWD_VIIF_L1_VDM_CFG_PARAM			 (0x00000310U) /* data width is 64bit */
> +#define HWD_VIIF_L1_VDM_SRAM_BASE			 (0x00000600U)
> +#define HWD_VIIF_L1_VDM_SRAM_SIZE			 (0x00000020U)
> +#define HWD_VIIF_L1_VDM_DPC_TABLE_SIZE			 (0x2000U)
> +#define HWD_VIIF_L1_VDM_LSC_TABLE_SIZE			 (0x600U)
> +#define HWD_VIIF_L1_PWHB_MAX_OUT_PIXEL_VAL		 (4095U)
> +#define HWD_VIIF_L1_PWHB_MAX_GAIN_VAL			 (0x80000U)
> +#define HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL	 (63U)
> +#define HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL (31U)
> +#define HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL	 (3U)
> +#define HWD_VIIF_L1_RCNR_MAX_ZERO_CLIP_VAL		 (256U)
> +#define HWD_VIIF_L1_RCNR_MAX_BLEND_VAL			 (16U)
> +#define HWD_VIIF_L1_RCNR_MAX_BLACK_LEVEL_VAL		 (64U)
> +#define HWD_VIIF_L1_RCNR_MIN_0DIV_GUARD_VAL		 (4U)
> +#define HWD_VIIF_L1_RCNR_MAX_0DIV_GUARD_VAL		 (16U)
> +#define HWD_VIIF_L1_RCNR_MAX_CALC_MSF_NOISE_MULTI_VAL	 (32U)
> +#define HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL	 (2U)
> +#define HWD_VIIF_L1_RCNR_MAX_UP_LIMIT_GRGB_SENS_RATIO	 (15U)
> +#define HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO		 (0x400U)
> +#define HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO		 (0x400000U)
> +#define HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL		 (0x400000U)
> +#define HWD_VIIF_L1_HDRS_MAX_DST_MAX_VAL		 (0xffffffU)
> +#define HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL		 (4095U)
> +#define HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL			 (0xffffffU)
> +#define HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL		 (0x100000U)
> +#define HWD_VIIF_L1_BLACK_LEVEL_MAX_DST_VAL		 (0xffffffU)
> +#define HWD_VIIF_LSC_MIN_GAIN				 (-4096)
> +#define HWD_VIIF_LSC_MAX_GAIN				 (4096)
> +#define HWD_VIIF_LSC_GRID_MIN_COORDINATE		 (1U)
> +#define HWD_VIIF_LSC_PWB_MAX_COEF_VAL			 (0x800U)
> +#define HWD_VIIF_DAMP_MAX_LSBSEL			 (15U)
> +#define HWD_VIIF_MAIN_PROCESS_MAX_OUT_PIXEL_VAL		 (0xffffffU)
> +#define HWD_VIIF_AWB_MIN_GAIN				 (64U)
> +#define HWD_VIIF_AWB_MAX_GAIN				 (1024U)
> +#define HWD_VIIF_AWB_GATE_LOWER				 (-127)
> +#define HWD_VIIF_AWB_GATE_UPPER				 (127)
> +#define HWD_VIIF_AWB_UNSIGNED_GATE_UPPER		 (127U)
> +#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_SPEED		 (15U)
> +#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL		 (31U)
> +#define HWD_VIIF_AWB_INTEGRATION_STOP_TH		 (1023U)
> +#define HWD_VIIF_L1_HDRC_MAX_THROUGH_SHIFT_VAL		 (8U)
> +#define HWD_VIIF_L1_HDRC_MIN_INPUT_DATA_WIDTH		 (10U)
> +#define HWD_VIIF_L1_HDRC_MAX_INPUT_DATA_WIDTH		 (24U)
> +#define HWD_VIIF_L1_HDRC_MAX_PT_SLOPE			 (13U)
> +#define HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO		 (256U)
> +#define HWD_VIIF_L1_HDRC_MAX_FLARE_VAL			 (0xffffffU)
> +#define HWD_VIIF_L1_HDRC_MAX_BLEND_LUMA			 (16U)
> +#define HWD_VIIF_L1_HDRC_MAX_LTM_TONE_BLEND_RATIO	 (0x400000U)
> +#define HWD_VIIF_L1_HDRC_MAX_LTM_MAGNIFICATION		 (0x4000U)
> +#define HWD_VIIF_L1_HDRC_RATIO_OFFSET			 (10U)
> +#define HWD_VIIF_L1_GAMMA_MAX_VAL			 (8191U)
> +#define HWD_VIIF_L1_SUPPRESSION_MAX_VAL			 (0x4000U)
> +#define HWD_VIIF_L1_EDGE_SUPPRESSION_MAX_LIMIT		 (15U)
> +#define HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN		 (0x1000U)
> +#define HWD_VIIF_L1_AEXP_MAX_WEIGHT			 (3U)
> +#define HWD_VIIF_L1_AEXP_MAX_BLOCK_TH			 (256U)
> +#define HWD_VIIF_L1_AEXP_MAX_SATURATION_PIXEL_TH	 (0xffffffU)
> +#define HWD_VIIF_L1_AEXP_MIN_BLOCK_WIDTH		 (64U)
> +#define HWD_VIIF_L1_AEXP_MIN_BLOCK_HEIGHT		 (64U)
> +#define HWD_VIIF_L1_HIST_COLOR_RGBY			 (2U)
> +#define HWD_VIIF_L1_HIST_MAX_BLOCK_NUM			 (8U)
> +#define HWD_VIIF_L1_HIST_MAX_STEP			 (15U)
> +#define HWD_VIIF_L1_HIST_MAX_BIN_SHIFT			 (31U)
> +#define HWD_VIIF_L1_HIST_MAX_COEF			 (65536U)
> +#define HWD_VIIF_L1_HIST_MIN_ADD_B_COEF			 (-65536)
> +#define HWD_VIIF_L1_HIST_MIN_ADD_A_COEF			 (-16777216)
> +#define HWD_VIIF_L1_HIST_MAX_ADD_A_COEF			 (16777216)
> +#define HWD_VIIF_L1_HIST_VDM_SIZE			 (4096U)
> +#define HWD_VIIF_L1_HIST_VDM_SRAM_BASE			 (0x00000400U)
> +#define HWD_VIIF_L1_HIST_VDM_SRAM_SIZE			 (0x00000040U)
> +#define HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT		 (0x0200U)
> +#define HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT		 (0x10BFU)
> +#define HWD_VIIF_L1_COEF_MIN				 (256U)
> +#define HWD_VIIF_L1_COEF_MAX				 (65024U)
> +
> +/* constants for L2 ISP */
> +#define HWD_VIIF_L2_VDM_ALIGN			     (0x4U)
> +#define HWD_VIIF_L2_VDM_GRID_SRAM_BASE		     (0x00000620U)
> +#define HWD_VIIF_L2_VDM_GRID_SRAM_SIZE		     (0x00000020U)
> +#define HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE		     (0x00000640U)
> +#define HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE		     (0x00000020U)
> +#define HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE	     (0x00000200U)
> +#define HWD_VIIF_L2_UNDIST_POLY_NUM		     (11U)
> +#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H     (-4296)
> +#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H     (4296)
> +#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V     (-2360)
> +#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V     (2360)
> +#define HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE	     (1677721U)
> +#define HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2	     (0x4000000U)
> +#define HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA  (0x800U)
> +#define HWD_VIIF_L2_UNDIST_MIN_POLY_COEF	     (-2147352576)
> +#define HWD_VIIF_L2_UNDIST_MAX_POLY_COEF	     (2147352576)
> +#define HWD_VIIF_L2_UNDIST_MIN_GRID_NUM		     (16U)
> +#define HWD_VIIF_L2_UNDIST_MAX_GRID_NUM		     (64U)
> +#define HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM	     (2048U)
> +#define HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV   (0x800000U)
> +#define HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE	     (0x400U)
> +#define HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE	     (0x2000U)
> +#define HWD_VIIF_L2_ROI_MIN_NUM			     (1U)
> +#define HWD_VIIF_L2_ROI_MAX_NUM			     (2U)
> +#define HWD_VIIF_L2_ROI_MIN_SCALE		     (32768U)
> +#define HWD_VIIF_L2_ROI_MAX_SCALE		     (131072U)
> +#define HWD_VIIF_L2_ROI_MIN_SCALE_INV		     (32768U)
> +#define HWD_VIIF_L2_ROI_MAX_SCALE_INV		     (131072U)
> +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE (128U)
> +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE (8190U)
> +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE (128U)
> +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE (4094U)
> +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE	     (128U)
> +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE	     (8190U)
> +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE	     (128U)
> +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE	     (4094U)
> +#define HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT	     (0x1CU)
> +#define HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT	     (0x1FU)
> +#define HWD_VIIF_L2_ROI_NONE			     (3U)
> +#define HWD_VIIF_MAX_POST_NUM			     (2U)
> +#define HWD_VIIF_L2_INPUT_OTHER_CH		     (0x50U)
> +
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

These are commented out, but they are still present in the kerneldoc above.

Any reason why these three fields aren't just removed?

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

<snip>

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

You need to reserve a range for Visconti controls in the v4l2-controls.h header.
See e.g. V4L2_CID_USER_DW100_BASE. That ensures that these controls have unique
IDs, not used by other drivers.

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

These controls need to be documented: what do they do, what arguments do they have.

Take a look at v4l2-controls.h, for example the V4L2_CID_STATELESS_VP9_COMPRESSED_HDR
define. The data structure it takes is just above the CID define, so it is already
much easier to see what the control takes as value.

But in this case it needs a bit more since these controls are not documented in the
V4L2 spec, so you will have to do that here as well. I.e., describe what the control does.

Does the driver configure these controls to sensible default values when it is
first loaded?

Also, if there is public documentation available, then add a URL to it at the top of
this header.

> +
> +/* Enable/Disable flag */
> +#define VIIF_DISABLE (0U)
> +#define VIIF_ENABLE  (1U)
> +
> +/**
> + * enum viif_rawpack_mode - RAW pack mode for ioctl(VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE)
> + *
> + * @VIIF_RAWPACK_DISABLE: RAW pack disable
> + * @VIIF_RAWPACK_MSBFIRST: RAW pack enable (MSB First)
> + * @VIIF_RAWPACK_LSBFIRST: RAW pack enable (LSB First)
> + */
> +enum viif_rawpack_mode {
> +	VIIF_RAWPACK_DISABLE = 0,
> +	VIIF_RAWPACK_MSBFIRST = 2,
> +	VIIF_RAWPACK_LSBFIRST = 3,
> +};
> +
> +/**
> + * enum viif_l1_input - L1ISP preprocessing mode
> + *
> + * @VIIF_L1_INPUT_HDR: bypass(HDR input)
> + * @VIIF_L1_INPUT_PWL: HDRE(PWL input)
> + * @VIIF_L1_INPUT_HDR_IMG_CORRECT: SLIC-ABPC-PWHB-RCNR-HDRS
> + * @VIIF_L1_INPUT_PWL_IMG_CORRECT: HDRE-SLIC-ABPC-PWHB-RCNR-HDRS
> + */
> +enum viif_l1_input {
> +	VIIF_L1_INPUT_HDR = 0,
> +	VIIF_L1_INPUT_PWL = 1,
> +	VIIF_L1_INPUT_HDR_IMG_CORRECT = 3,
> +	VIIF_L1_INPUT_PWL_IMG_CORRECT = 4,
> +};
> +
> +/**
> + * enum viif_l1_raw - L1ISP RAW color filter mode
> + *
> + * @VIIF_L1_RAW_GR_R_B_GB: Gr-R-B-Gb
> + * @VIIF_L1_RAW_R_GR_GB_B: R-Gr-Gb-B
> + * @VIIF_L1_RAW_B_GB_GR_R: B-Gb-Gr-R
> + * @VIIF_L1_RAW_GB_B_R_GR: Gb-B-R-Gr
> + */
> +enum viif_l1_raw {
> +	VIIF_L1_RAW_GR_R_B_GB = 0,
> +	VIIF_L1_RAW_R_GR_GB_B = 1,
> +	VIIF_L1_RAW_B_GB_GR_R = 2,
> +	VIIF_L1_RAW_GB_B_R_GR = 3,
> +};
> +
> +/**
> + * struct viif_l1_input_mode_config - L1ISP INPUT MODE parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE`
> + * @mode: &enum viif_l1_input value.
> + * @depth: Color depth (even only). Range for each L1ISP pre-processing mode is:
> + *
> + *  * VIIF_L1_INPUT_HDR/HDR_IMG_CORRECT: Range: [8..24].
> + *  * VIIF_L1_INPUT_PWL/PWL_IMG_CORRECT: Range: [8..14].
> + * @raw_color_filter: &enum viif_l1_raw value.
> + */
> +struct viif_l1_input_mode_config {
> +	__u32 mode;
> +	__u32 depth;
> +	__u32 raw_color_filter;
> +};
> +
> +/**
> + * struct viif_l1_rgb_to_y_coef_config - L1ISP coefficient for calculating
> + * Y from RGB parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF`
> + * @coef_r: R co-efficient [256..65024] accuracy: 1/65536
> + * @coef_g: R co-efficient [256..65024] accuracy: 1/65536
> + * @coef_b: R co-efficient [256..65024] accuracy: 1/65536
> + */
> +struct viif_l1_rgb_to_y_coef_config {
> +	__u16 coef_r;
> +	__u16 coef_g;
> +	__u16 coef_b;
> +};
> +
> +/**
> + * enum viif_l1_img_sensitivity_mode - L1ISP image sensitivity
> + *
> + * @VIIF_L1_IMG_SENSITIVITY_HIGH: high sensitivity
> + * @VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED: middle sensitivity or led
> + * @VIIF_L1_IMG_SENSITIVITY_LOW: low sensitivity
> + */
> +enum viif_l1_img_sensitivity_mode {
> +	VIIF_L1_IMG_SENSITIVITY_HIGH = 0,
> +	VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED = 1,
> +	VIIF_L1_IMG_SENSITIVITY_LOW = 2,
> +};
> +
> +/**
> + * struct viif_l1_ag_mode_config - L1ISP AG mode parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE`
> + * @sysm_ag_grad: Analog gain slope [0..255] (element is id)
> + * @sysm_ag_ofst: Analog gain offset [0..65535] (element is id)
> + * @sysm_ag_cont_hobc_en_high: 1:enable/0:disable to control analog gain
> + *                             for high sensitivity image of OBCC
> + * @sysm_ag_psel_hobc_high: Analog gain id for high sensitivity image of OBCC [0..3]
> + * @sysm_ag_cont_hobc_en_middle_led: 1:enable/0:disable to control analog gain
> + *                                   for middle sensitivity or LED image of OBCC
> + * @sysm_ag_psel_hobc_middle_led: Analog gain id for middle sensitivity
> + *                                or LED image of OBCC [0..3]
> + * @sysm_ag_cont_hobc_en_low: 1:enable/0:disable to control analog gain
> + *                            for low sensitivity image of OBCC
> + * @sysm_ag_psel_hobc_low: Analog gain id for low sensitivity image of OBCC [0..3]
> + * @sysm_ag_cont_abpc_en_high: 1:enable/0:disable to control analog gain
> + *                             for high sensitivity image of ABPC
> + * @sysm_ag_psel_abpc_high: Analog gain id for high sensitivity image of ABPC [0..3]
> + * @sysm_ag_cont_abpc_en_middle_led: 1:enable/0:disable to control analog gain
> + *                                   for middle sensitivity or LED image of ABPC
> + * @sysm_ag_psel_abpc_middle_led: Analog gain id for middle sensitivity
> + *                                or LED image of ABPC [0..3]
> + * @sysm_ag_cont_abpc_en_low: 1:enable/0:disable to control analog gain
> + *                            for low sensitivity image of ABPC
> + * @sysm_ag_psel_abpc_low: Analog gain id for low sensitivity image of ABPC [0..3]
> + * @sysm_ag_cont_rcnr_en_high: 1:enable/0:disable to control analog gain
> + *                             for high sensitivity image of RCNR
> + * @sysm_ag_psel_rcnr_high: Analog gain id for high sensitivity image of RCNR [0..3]
> + * @sysm_ag_cont_rcnr_en_middle_led: 1:enable/0:disable to control analog gain
> + *                                   for middle sensitivity or LED image of RCNR
> + * @sysm_ag_psel_rcnr_middle_led: Analog gain id for middle sensitivity
> + *                                or LED image of RCNR [0..3]
> + * @sysm_ag_cont_rcnr_en_low: 1:enable/0:disable to control analog gain
> + *                            for low sensitivity image of RCNR
> + * @sysm_ag_psel_rcnr_low: Analog gain id for low sensitivity image of RCNR [0..3]
> + * @sysm_ag_cont_lssc_en: 1:enable/0:disable to control analog gain for LSC
> + * @sysm_ag_ssel_lssc: &enum viif_l1_img_sensitivity_mode value. Sensitive image used for LSC.
> + * @sysm_ag_psel_lssc: Analog gain id for LSC [0..3]
> + * @sysm_ag_cont_mpro_en: 1:enable/0:disable to control analog gain for color matrix
> + * @sysm_ag_ssel_mpro: &enum viif_l1_img_sensitivity_mode value.
> + *                     Sensitive image used for color matrix.
> + * @sysm_ag_psel_mpro:Aanalog gain id for color matrix [0..3]
> + * @sysm_ag_cont_vpro_en: 1:enable/0:disable to control analog gain for image adjustment
> + * @sysm_ag_ssel_vpro: &enum viif_l1_img_sensitivity_mode value.
> + *                     Sensitive image used for image adjustment.
> + * @sysm_ag_psel_vpro: Analog gain id for image adjustment [0..3]
> + * @sysm_ag_cont_hobc_test_high: Manual analog gain for high sensitivity image
> + *                               of OBCC [0..255]
> + * @sysm_ag_cont_hobc_test_middle_led: Manual analog gain for middle sensitivity
> + *                                     or led image of OBCC [0..255]
> + * @sysm_ag_cont_hobc_test_low: Manual analog gain for low sensitivity image
> + *                              of OBCC [0..255]
> + * @sysm_ag_cont_abpc_test_high: Manual analog gain for high sensitivity image
> + *                               of ABPC [0..255]
> + * @sysm_ag_cont_abpc_test_middle_led: Manual analog gain for middle sensitivity
> + *                                     or led image of ABPC [0..255]
> + * @sysm_ag_cont_abpc_test_low: Manual analog gain for low sensitivity image
> + *                              of ABPC [0..255]
> + * @sysm_ag_cont_rcnr_test_high: Manual analog gain for high sensitivity image
> + *                               of RCNR [0..255]
> + * @sysm_ag_cont_rcnr_test_middle_led: Manual analog gain for middle sensitivity
> + *                                     or led image of RCNR [0..255]
> + * @sysm_ag_cont_rcnr_test_low: Manual analog gain for low sensitivity image
> + *                              of RCNR [0..255]
> + * @sysm_ag_cont_lssc_test: Manual analog gain for LSSC [0..255]
> + * @sysm_ag_cont_mpro_test: Manual analog gain for color matrix [0..255]
> + * @sysm_ag_cont_vpro_test: Manual analog gain for image adjustment [0..255]
> + *
> + * Operation setting of L1ISP analog gain function.
> + * Analog gain control is disabled if following settings are done.
> + * "sysm_ag_cont_*_en = DRV_VIIF_DISABLE" and "sysm_ag_cont_*_test = 0"
> + * In case "VIIF_L1_INPUT_HDR" or "VIIF_L1_INPUT_PWL" is set to "mode" which is
> + * an &struct viif_l1_input_mode_config, analog gain control needs to be disabled.
> + * Even if this condition is not satisfied, this driver doesn't return error.
> + *
> + * The value set in sysm_ag_psel_xxx indicates analog gain system to be used and
> + * corresponds to the element number of sysm_ag_grad and sysm_ag_ofst.
> + * For example, if sysm_ag_psel_hobc_high is set to 2, then values set in
> + * sysm_ag_grad[2] and sysm_ag_ofst[2] are used for high sensitivity images
> + * in OBCC processing.
> + */
> +struct viif_l1_ag_mode_config {
> +	__u8 sysm_ag_grad[4];
> +	__u16 sysm_ag_ofst[4];
> +	__u32 sysm_ag_cont_hobc_en_high;
> +	__u32 sysm_ag_psel_hobc_high;
> +	__u32 sysm_ag_cont_hobc_en_middle_led;
> +	__u32 sysm_ag_psel_hobc_middle_led;
> +	__u32 sysm_ag_cont_hobc_en_low;
> +	__u32 sysm_ag_psel_hobc_low;
> +	__u32 sysm_ag_cont_abpc_en_high;
> +	__u32 sysm_ag_psel_abpc_high;
> +	__u32 sysm_ag_cont_abpc_en_middle_led;
> +	__u32 sysm_ag_psel_abpc_middle_led;
> +	__u32 sysm_ag_cont_abpc_en_low;
> +	__u32 sysm_ag_psel_abpc_low;
> +	__u32 sysm_ag_cont_rcnr_en_high;
> +	__u32 sysm_ag_psel_rcnr_high;
> +	__u32 sysm_ag_cont_rcnr_en_middle_led;
> +	__u32 sysm_ag_psel_rcnr_middle_led;
> +	__u32 sysm_ag_cont_rcnr_en_low;
> +	__u32 sysm_ag_psel_rcnr_low;
> +	__u32 sysm_ag_cont_lssc_en;
> +	__u32 sysm_ag_ssel_lssc;
> +	__u32 sysm_ag_psel_lssc;
> +	__u32 sysm_ag_cont_mpro_en;
> +	__u32 sysm_ag_ssel_mpro;
> +	__u32 sysm_ag_psel_mpro;
> +	__u32 sysm_ag_cont_vpro_en;
> +	__u32 sysm_ag_ssel_vpro;
> +	__u32 sysm_ag_psel_vpro;
> +	__u8 sysm_ag_cont_hobc_test_high;
> +	__u8 sysm_ag_cont_hobc_test_middle_led;
> +	__u8 sysm_ag_cont_hobc_test_low;
> +	__u8 sysm_ag_cont_abpc_test_high;
> +	__u8 sysm_ag_cont_abpc_test_middle_led;
> +	__u8 sysm_ag_cont_abpc_test_low;
> +	__u8 sysm_ag_cont_rcnr_test_high;
> +	__u8 sysm_ag_cont_rcnr_test_middle_led;
> +	__u8 sysm_ag_cont_rcnr_test_low;
> +	__u8 sysm_ag_cont_lssc_test;
> +	__u8 sysm_ag_cont_mpro_test;
> +	__u8 sysm_ag_cont_vpro_test;
> +};
> +
> +/**
> + * struct viif_l1_ag_config - L1ISP AG parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG`
> + * @gain_h: Analog gain for high sensitive image [0..65535]
> + * @gain_m: Analog gain for middle sensitive image or LED image [0..65535]
> + * @gain_l: Analog gain for low sensitive image [0..65535]
> + */
> +struct viif_l1_ag_config {
> +	__u16 gain_h;
> +	__u16 gain_m;
> +	__u16 gain_l;
> +};
> +
> +/**
> + * struct viif_l1_hdre_config - L1ISP HDRE parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE`
> + * @hdre_src_point: Knee point N value of PWL compressed signal [0..0x3FFF]
> + * @hdre_dst_base: Offset value of HDR signal in Knee area M [0..0xFFFFFF]
> + * @hdre_ratio: Slope of output pixel value in Knee area M
> + *              [0..0x3FFFFF], accuracy: 1/64
> + * @hdre_dst_max_val: Maximum value of output pixel [0..0xFFFFFF]
> + */
> +struct viif_l1_hdre_config {
> +	__u32 hdre_src_point[16];
> +	__u32 hdre_dst_base[17];
> +	__u32 hdre_ratio[17];
> +	__u32 hdre_dst_max_val;
> +};
> +
> +/**
> + * struct viif_l1_img_extraction_config -  L1ISP image extraction parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION`
> + * @input_black_gr: Black level of input pixel (Gr) [0..0xFFFFFF]
> + * @input_black_r: Black level of input pixel (R) [0..0xFFFFFF]
> + * @input_black_b: Black level of input pixel (B) [0..0xFFFFFF]
> + * @input_black_gb: Black level of input pixel (Gb) [0..0xFFFFFF]
> + */
> +struct viif_l1_img_extraction_config {
> +	__u32 input_black_gr;
> +	__u32 input_black_r;
> +	__u32 input_black_b;
> +	__u32 input_black_gb;
> +};
> +
> +/**
> + * enum viif_l1_dpc_mode - L1ISP defect pixel correction mode
> + * @VIIF_L1_DPC_1PIXEL: 1 pixel correction mode
> + * @VIIF_L1_DPC_2PIXEL: 2 pixel correction mode
> + */
> +enum viif_l1_dpc_mode {
> +	VIIF_L1_DPC_1PIXEL = 0,
> +	VIIF_L1_DPC_2PIXEL = 1,
> +};
> +
> +/**
> + * struct viif_l1_dpc - L1ISP defect pixel correction parameters
> + * for &struct viif_l1_dpc_config
> + * @abpc_sta_en: 1:enable/0:disable setting of Static DPC
> + * @abpc_dyn_en: 1:enable/0:disable setting of Dynamic DPC
> + * @abpc_dyn_mode: &enume viif_l1_dpc_mode value. Sets dynamic DPC mode.
> + * @abpc_ratio_limit: Variation adjustment of dynamic DPC [0..1023]
> + * @abpc_dark_limit: White defect judgment limit of dark area [0..1023]
> + * @abpc_sn_coef_w_ag_min: Luminance difference adjustment of white DPC
> + *                         (undere lower threshold) [1..31]
> + * @abpc_sn_coef_w_ag_mid: Luminance difference adjustment of white DPC
> + *                         (between lower and upper threshold) [1..31]
> + * @abpc_sn_coef_w_ag_max: Luminance difference adjustment of white DPC
> + *                         (over upper threshold) [1..31]
> + * @abpc_sn_coef_b_ag_min: Luminance difference adjustment of black DPC
> + *                         (undere lower threshold) [1..31]
> + * @abpc_sn_coef_b_ag_mid: Luminance difference adjustment of black DPC
> + *                         (between lower and upper threshold) [1..31]
> + * @abpc_sn_coef_b_ag_max: Luminance difference adjustment of black DPC
> + *                         (over upper threshold) [1..31]
> + * @abpc_sn_coef_w_th_min: Luminance difference adjustment of white DPC
> + *                         analog gain lower threshold [0..255]
> + * @abpc_sn_coef_w_th_max: Luminance difference adjustment of white DPC
> + *                         analog gain upper threshold [0..255]
> + * @abpc_sn_coef_b_th_min: Luminance difference adjustment of black DPC
> + *                         analog gain lower threshold [0..255]
> + * @abpc_sn_coef_b_th_max: Luminance difference adjustment of black DPC
> + *                         analog gain upper threshold [0..255]
> + *
> + * Parameters should meet the following conditions.
> + * "abpc_sn_coef_w_th_min < abpc_sn_coef_w_th_max" and
> + * "abpc_sn_coef_b_th_min < abpc_sn_coef_b_th_max"
> + */
> +struct viif_l1_dpc {
> +	__u32 abpc_sta_en;
> +	__u32 abpc_dyn_en;
> +	__u32 abpc_dyn_mode;
> +	__u32 abpc_ratio_limit;
> +	__u32 abpc_dark_limit;
> +	__u32 abpc_sn_coef_w_ag_min;
> +	__u32 abpc_sn_coef_w_ag_mid;
> +	__u32 abpc_sn_coef_w_ag_max;
> +	__u32 abpc_sn_coef_b_ag_min;
> +	__u32 abpc_sn_coef_b_ag_mid;
> +	__u32 abpc_sn_coef_b_ag_max;
> +	__u8 abpc_sn_coef_w_th_min;
> +	__u8 abpc_sn_coef_w_th_max;
> +	__u8 abpc_sn_coef_b_th_min;
> +	__u8 abpc_sn_coef_b_th_max;
> +};
> +
> +/**
> + * struct viif_l1_dpc_config - L1ISP defect pixel correction parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC`
> + * @param_h: DPC parameter for high sensitive image. Refer to &struct viif_l1_dpc
> + * @param_m: DPC parameter for middle sensitive image. Refer to &struct viif_l1_dpc
> + * @param_l: DPC parameter for low sensitive image. Refer to &struct viif_l1_dpc
> + * @table_h_addr: DPC table address for high sensitive image.
> + *                The table size is sizeof(u32) * 2048.
> + *                Set zero to disable this table.

Addresses in a control struct? Sounds iffy, but I'll comment more on it when I review
the control code.

> + * @table_m_addr: DPC table address for middle sensitive image or LED image.
> + *                The table size is sizeof(u32) * 2048.
> + *                Set zero to disable this table.
> + * @table_l_addr: DPC table address for low sensitive image.
> + *                The table size is sizeof(u32) * 2048.
> + *                Set zero to disable this table.
> + *
> + * The size of each table is fixed at 8192 Byte.
> + * Application should make sure that the table data is based on HW specification
> + * since this driver does not check the DPC table.
> + */
> +struct viif_l1_dpc_config {
> +	struct viif_l1_dpc param_h;
> +	struct viif_l1_dpc param_m;
> +	struct viif_l1_dpc param_l;
> +	__u64 table_h_addr;
> +	__u64 table_m_addr;
> +	__u64 table_l_addr;
> +};
> +
> +/**
> + * struct viif_l1_preset_wb - L1ISP  preset white balance parameters
> + * for &struct viif_l1_preset_white_balance_config
> + * @gain_gr: Gr gain [0..524287], accuracy 1/16384
> + * @gain_r: R gain [0..524287], accuracy 1/16384
> + * @gain_b: B gain [0..524287], accuracy 1/16384
> + * @gain_gb: Gb gain [0..524287], accuracy 1/16384
> + */
> +struct viif_l1_preset_wb {
> +	__u32 gain_gr;
> +	__u32 gain_r;
> +	__u32 gain_b;
> +	__u32 gain_gb;
> +};
> +
> +/**
> + * struct viif_l1_preset_white_balance_config - L1ISP  preset white balance
> + * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE`
> + * @dstmaxval: Maximum value of output pixel [pixel] [0..4095]
> + * @param_h: Preset white balance parameter for high sensitive image.
> + *           Refer to &struct viif_l1_preset_wb
> + * @param_m: Preset white balance parameters for middle sensitive image or LED image.
> + *           Refer to &struct viif_l1_preset_wb
> + * @param_l: Preset white balance parameters for low sensitive image.
> + *           Refer to &struct viif_l1_preset_wb
> + */
> +struct viif_l1_preset_white_balance_config {
> +	__u32 dstmaxval;
> +	struct viif_l1_preset_wb param_h;
> +	struct viif_l1_preset_wb param_m;
> +	struct viif_l1_preset_wb param_l;
> +};
> +
> +/**
> + * enum viif_l1_rcnr_type - L1ISP high resolution luminance filter type
> + *
> + * @VIIF_L1_RCNR_LOW_RESOLUTION: low resolution
> + * @VIIF_L1_RCNR_MIDDLE_RESOLUTION: middle resolution
> + * @VIIF_L1_RCNR_HIGH_RESOLUTION: high resolution
> + * @VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION: ultra high resolution
> + */
> +enum viif_l1_rcnr_type {
> +	VIIF_L1_RCNR_LOW_RESOLUTION = 0,
> +	VIIF_L1_RCNR_MIDDLE_RESOLUTION = 1,
> +	VIIF_L1_RCNR_HIGH_RESOLUTION = 2,
> +	VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION = 3,
> +};
> +
> +/**
> + * enum viif_l1_msf_blend_ratio - L1ISP MSF blend ratio
> + *
> + * @VIIF_L1_MSF_BLEND_RATIO_0_DIV_64: 0/64
> + * @VIIF_L1_MSF_BLEND_RATIO_1_DIV_64: 1/64
> + * @VIIF_L1_MSF_BLEND_RATIO_2_DIV_64: 2/64
> + */
> +enum viif_l1_msf_blend_ratio {
> +	VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 = 0,
> +	VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 = 1,
> +	VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 = 2,
> +};
> +
> +/**
> + * struct viif_l1_raw_color_noise_reduction - L1ISP RCNR parameters
> + * for &struct viif_l1_raw_color_noise_reduction_config
> + * @rcnr_sw: 1:Enable/0:Disable setting of RAW color noise reduction
> + * @rcnr_cnf_dark_ag0: Maximum value of LSF dark noise adjustment[0..63]
> + * @rcnr_cnf_dark_ag1: Middle value of LSF dark noise adjustment [0..63]
> + * @rcnr_cnf_dark_ag2: Minimum value of LSF dark noise adjustment [0..63]
> + * @rcnr_cnf_ratio_ag0: Maximum value of LSF luminance interlocking noise adjustment [0..31]
> + * @rcnr_cnf_ratio_ag1: Middle value of LSF luminance interlocking noise adjustment [0..31]
> + * @rcnr_cnf_ratio_ag2: Minimum value of LSF luminance interlocking noise adjustment [0..31]
> + * @rcnr_cnf_clip_gain_r: LSF color correction limit adjustment gain R [0..3]
> + * @rcnr_cnf_clip_gain_g: LSF color correction limit adjustment gain G [0..3]
> + * @rcnr_cnf_clip_gain_b: LSF color correction limit adjustment gain B [0..3]
> + * @rcnr_a1l_dark_ag0: Maximum value of MSF dark noise adjustment [0..63]
> + * @rcnr_a1l_dark_ag1: Middle value of MSF dark noise adjustment [0..63]
> + * @rcnr_a1l_dark_ag2: Minimum value of MSF dark noise adjustment [0..63]
> + * @rcnr_a1l_ratio_ag0: Maximum value of MSF luminance interlocking noise adjustment [0..31]
> + * @rcnr_a1l_ratio_ag1: Middle value of MSF luminance interlocking noise adjustment [0..31]
> + * @rcnr_a1l_ratio_ag2: Minimum value of MSF luminance interlocking noise adjustment [0..31]
> + * @rcnr_inf_zero_clip: Input stage zero clip setting [0..256]
> + * @rcnr_merge_d2blend_ag0: Maximum value of filter results and input blend ratio [0..16]
> + * @rcnr_merge_d2blend_ag1: Middle value of filter results and input blend ratio [0..16]
> + * @rcnr_merge_d2blend_ag2: Minimum value of filter results and input blend ratio [0..16]
> + * @rcnr_merge_black: Black level minimum value [0..64]
> + * @rcnr_merge_mindiv: 0 div guard value of inverse arithmetic unit [4..16]
> + * @rcnr_hry_type: &enum viif_l1_rcnr_type value. Filter type for HSF filter process.
> + * @rcnr_anf_blend_ag0: &enum viif_l1_msf_blend_ratio value.
> + *                      Maximum value of MSF result blend ratio in write back data to line memory.
> + * @rcnr_anf_blend_ag1: &enum viif_l1_msf_blend_ratio value.
> + *                      Middle value of MSF result blend ratio in write back data to line memory.
> + * @rcnr_anf_blend_ag2: &enum viif_l1_msf_blend_ratio value.
> + *                      Minimum value of MSF result blend ratio in write back data to line memory.
> + * @rcnr_lpf_threshold: Multiplier value for calculating dark noise / luminance
> + *                      interlock noise of MSF [0..31], accuracy: 1/8
> + * @rcnr_merge_hlblend_ag0: Maximum value of luminance signal generation blend [0..2]
> + * @rcnr_merge_hlblend_ag1: Middle value of luminance signal generation blend [0..2]
> + * @rcnr_merge_hlblend_ag2: Minimum value of luminance signal generation blend [0..2]
> + * @rcnr_gnr_sw: 1:Enable/0:Disable setting of Gr/Gb sensitivity ratio
> + *               correction function switching
> + * @rcnr_gnr_ratio: Upper limit of Gr/Gb sensitivity ratio correction factor [0..15]
> + * @rcnr_gnr_wide_en: 1:Enable/0:Disable setting of the function to double
> + *                    correction upper limit ratio of rcnr_gnr_ratio
> + */
> +struct viif_l1_raw_color_noise_reduction {
> +	__u32 rcnr_sw;
> +	__u32 rcnr_cnf_dark_ag0;
> +	__u32 rcnr_cnf_dark_ag1;
> +	__u32 rcnr_cnf_dark_ag2;
> +	__u32 rcnr_cnf_ratio_ag0;
> +	__u32 rcnr_cnf_ratio_ag1;
> +	__u32 rcnr_cnf_ratio_ag2;
> +	__u32 rcnr_cnf_clip_gain_r;
> +	__u32 rcnr_cnf_clip_gain_g;
> +	__u32 rcnr_cnf_clip_gain_b;
> +	__u32 rcnr_a1l_dark_ag0;
> +	__u32 rcnr_a1l_dark_ag1;
> +	__u32 rcnr_a1l_dark_ag2;
> +	__u32 rcnr_a1l_ratio_ag0;
> +	__u32 rcnr_a1l_ratio_ag1;
> +	__u32 rcnr_a1l_ratio_ag2;
> +	__u32 rcnr_inf_zero_clip;
> +	__u32 rcnr_merge_d2blend_ag0;
> +	__u32 rcnr_merge_d2blend_ag1;
> +	__u32 rcnr_merge_d2blend_ag2;
> +	__u32 rcnr_merge_black;
> +	__u32 rcnr_merge_mindiv;
> +	__u32 rcnr_hry_type;
> +	__u32 rcnr_anf_blend_ag0;
> +	__u32 rcnr_anf_blend_ag1;
> +	__u32 rcnr_anf_blend_ag2;
> +	__u32 rcnr_lpf_threshold;
> +	__u32 rcnr_merge_hlblend_ag0;
> +	__u32 rcnr_merge_hlblend_ag1;
> +	__u32 rcnr_merge_hlblend_ag2;
> +	__u32 rcnr_gnr_sw;
> +	__u32 rcnr_gnr_ratio;
> +	__u32 rcnr_gnr_wide_en;
> +};
> +
> +/**
> + * struct viif_l1_raw_color_noise_reduction_config - L1ISP RCNR parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION`
> + * @param_h: RAW color noise reduction parameter for high sensitive image.
> + *           Refer to &struct viif_l1_raw_color_noise_reduction
> + * @param_m: RAW color noise reduction parameter for middle sensitive image or LED image.
> + *           Refer to &struct viif_l1_raw_color_noise_reduction
> + * @param_l: RAW color noise reduction parameter for low sensitive image.
> + *           Refer to &struct viif_l1_raw_color_noise_reduction
> + */
> +struct viif_l1_raw_color_noise_reduction_config {
> +	struct viif_l1_raw_color_noise_reduction param_h;
> +	struct viif_l1_raw_color_noise_reduction param_m;
> +	struct viif_l1_raw_color_noise_reduction param_l;
> +};
> +
> +/**
> + * enum viif_l1_hdrs_middle_img_mode - L1ISP HDR setting
> + *
> + * @VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE: not use middle image
> + * @VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE: use middle image
> + */
> +enum viif_l1_hdrs_middle_img_mode {
> +	VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE = 0,
> +	VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE = 1,
> +};
> +
> +/**
> + * struct viif_l1_hdrs_config - L1ISP HDRS parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS`
> + * @hdrs_hdr_mode: &enum viif_l1_hdrs_middle_img_mode value.
> + *                 Use/No use settings of middle sensitivity image in HDRS.
> + * @hdrs_hdr_ratio_m: Magnification ratio of middle sensitivity image for high
> + *                    sensitivity image [0x400..0x400000] accuracy: 1/1024
> + * @hdrs_hdr_ratio_l: Magnification ratio of low sensitivity image for high
> + *                    sensitivity image [0x400..0x400000], accuracy: 1/1024
> + * @hdrs_hdr_ratio_e: Magnification ratio of LED image for high sensitivity image
> + *                    [0x400..0x400000], accuracy: 1/1024
> + * @hdrs_dg_h: High sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
> + * @hdrs_dg_m: Middle sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
> + * @hdrs_dg_l: Low sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
> + * @hdrs_dg_e: LED image digital gain [0..0x3FFFFF], accuracy: 1/1024
> + * @hdrs_blendend_h: Maximum luminance used for blend high sensitivity image [0..4095]
> + * @hdrs_blendend_m: Maximum luminance used for blend middle sensitivity image [0..4095]
> + * @hdrs_blendend_e: Maximum luminance used for blend LED image [0..4095]
> + * @hdrs_blendbeg_h: Minimum luminance used for blend high sensitivity image [0..4095]
> + * @hdrs_blendbeg_m: Minimum luminance used for blend middle sensitivity image [0..4095]
> + * @hdrs_blendbeg_e: Minimum luminance used for blend LED image [0..4095]
> + * @hdrs_led_mode_on: 1:Enable/0:Disable settings of LED mode
> + * @hdrs_dst_max_val: Maximum value of output pixel [0..0xFFFFFF]
> + *
> + * parameter error needs to be returned in the below condition.
> + * (hdrs_hdr_mode == VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE) && (hdrs_led_mode_on == 1)
> + */
> +struct viif_l1_hdrs_config {
> +	__u32 hdrs_hdr_mode;
> +	__u32 hdrs_hdr_ratio_m;
> +	__u32 hdrs_hdr_ratio_l;
> +	__u32 hdrs_hdr_ratio_e;
> +	__u32 hdrs_dg_h;
> +	__u32 hdrs_dg_m;
> +	__u32 hdrs_dg_l;
> +	__u32 hdrs_dg_e;
> +	__u32 hdrs_blendend_h;
> +	__u32 hdrs_blendend_m;
> +	__u32 hdrs_blendend_e;
> +	__u32 hdrs_blendbeg_h;
> +	__u32 hdrs_blendbeg_m;
> +	__u32 hdrs_blendbeg_e;
> +	__u32 hdrs_led_mode_on;
> +	__u32 hdrs_dst_max_val;
> +};
> +
> +/**
> + * struct viif_l1_black_level_correction_config -  L1ISP image level conversion
> + * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION`
> + * @srcblacklevel_gr: Black level of Gr input pixel [pixel] [0..0xFFFFFF]
> + * @srcblacklevel_r: Black level of R input pixel [pixel] [0..0xFFFFFF]
> + * @srcblacklevel_b: Black level of B input pixel [pixel] [0..0xFFFFFF]
> + * @srcblacklevel_gb: Black level of Gb input pixel [pixel] [0..0xFFFFFF]
> + * @mulval_gr: Gr gain [0..0xFFFFF], accuracy: 1/256
> + * @mulval_r: R gain [0..0xFFFFF], accuracy: 1/256
> + * @mulval_b: B gain [0..0xFFFFF], accuracy: 1/256
> + * @mulval_gb: Gb gain [0..0xFFFFF], accuracy: 1/256
> + * @dstmaxval: Maximum value of output pixel [pixel] [0..0xFFFFFF]
> + */
> +struct viif_l1_black_level_correction_config {
> +	__u32 srcblacklevel_gr;
> +	__u32 srcblacklevel_r;
> +	__u32 srcblacklevel_b;
> +	__u32 srcblacklevel_gb;
> +	__u32 mulval_gr;
> +	__u32 mulval_r;
> +	__u32 mulval_b;
> +	__u32 mulval_gb;
> +	__u32 dstmaxval;
> +};
> +
> +/**
> + * enum viif_l1_para_coef_gain - L1ISP parabola shading correction coefficient ratio
> + *
> + * @VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH: 1/8
> + * @VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH: 1/4
> + * @VIIF_L1_PARA_COEF_GAIN_ONE_SECOND: 1/2
> + * @VIIF_L1_PARA_COEF_GAIN_ONE_FIRST: 1/1
> + */
> +enum viif_l1_para_coef_gain {
> +	VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH = 0, /* 1/8 */
> +	VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH = 1, /* 1/4 */
> +	VIIF_L1_PARA_COEF_GAIN_ONE_SECOND = 2, /* 1/2 */
> +	VIIF_L1_PARA_COEF_GAIN_ONE_FIRST = 3, /* 1/1 */
> +};
> +
> +/**
> + * enum viif_l1_grid_coef_gain - L1ISP grid shading correction coefficient ratio
> + *
> + * @VIIF_L1_GRID_COEF_GAIN_X1: x1
> + * @VIIF_L1_GRID_COEF_GAIN_X2: x2
> + */
> +enum viif_l1_grid_coef_gain {
> +	VIIF_L1_GRID_COEF_GAIN_X1 = 0,
> +	VIIF_L1_GRID_COEF_GAIN_X2 = 1,
> +};
> +
> +/**
> + * struct viif_l1_lsc_parabola_ag_param - L2ISP parabola shading parameters
> + * for &struct viif_l1_lsc_parabola_param
> + * @lssc_paracoef_h_l_max: Parabola coefficient left maximum gain value
> + * @lssc_paracoef_h_l_min: Parabola coefficient left minimum gain value
> + * @lssc_paracoef_h_r_max: Parabola coefficient right maximum gain value
> + * @lssc_paracoef_h_r_min: Parabola coefficient right minimum gain value
> + * @lssc_paracoef_v_u_max: Parabola coefficient upper maximum gain value
> + * @lssc_paracoef_v_u_min: Parabola coefficient upper minimum gain value
> + * @lssc_paracoef_v_d_max: Parabola coefficient lower maximum gain value
> + * @lssc_paracoef_v_d_min: Parabola coefficient lower minimum gain value
> + * @lssc_paracoef_hv_lu_max: Parabola coefficient upper left gain maximum value
> + * @lssc_paracoef_hv_lu_min: Parabola coefficient upper left gain minimum value
> + * @lssc_paracoef_hv_ru_max: Parabola coefficient upper right gain maximum value
> + * @lssc_paracoef_hv_ru_min: Parabola coefficient upper right minimum gain value
> + * @lssc_paracoef_hv_ld_max: Parabola coefficient lower left gain maximum value
> + * @lssc_paracoef_hv_ld_min: Parabola coefficient lower left gain minimum value
> + * @lssc_paracoef_hv_rd_max: Parabola coefficient lower right gain maximum value
> + * @lssc_paracoef_hv_rd_min: Parabola coefficient lower right minimum gain value
> + *
> + * The range and accuracy of each coefficient are as
> + * "range: [-4096..4095], accuracy: 1/256 "
> + *
> + * Each coefficient should meet the following conditions.
> + * "lssc_paracoef_xx_xx_min <= lssc_paracoef_xx_xx_max"
> + */
> +struct viif_l1_lsc_parabola_ag_param {
> +	__s16 lssc_paracoef_h_l_max;
> +	__s16 lssc_paracoef_h_l_min;
> +	__s16 lssc_paracoef_h_r_max;
> +	__s16 lssc_paracoef_h_r_min;
> +	__s16 lssc_paracoef_v_u_max;
> +	__s16 lssc_paracoef_v_u_min;
> +	__s16 lssc_paracoef_v_d_max;
> +	__s16 lssc_paracoef_v_d_min;
> +	__s16 lssc_paracoef_hv_lu_max;
> +	__s16 lssc_paracoef_hv_lu_min;
> +	__s16 lssc_paracoef_hv_ru_max;
> +	__s16 lssc_paracoef_hv_ru_min;
> +	__s16 lssc_paracoef_hv_ld_max;
> +	__s16 lssc_paracoef_hv_ld_min;
> +	__s16 lssc_paracoef_hv_rd_max;
> +	__s16 lssc_paracoef_hv_rd_min;
> +};
> +
> +/**
> + * struct viif_l1_lsc_parabola_param - L2ISP parabola shading parameters
> + * for &struct viif_l1_lsc
> + * @lssc_para_h_center: Horizontal coordinate of central optical axis [pixel]
> + *                      [0..(Input image width - 1)]
> + * @lssc_para_v_center: Vertical coordinate of central optical axis [line]
> + *                      [0..(Input image height - 1)]
> + * @lssc_para_h_gain: Horizontal distance gain with the optical axis
> + *                    [0..4095], accuracy: 1/256
> + * @lssc_para_v_gain: Vertical distance gain with the optical axis
> + *                    [0..4095], accuracy: 1/256
> + * @lssc_para_mgsel2: &enum viif_l1_para_coef_gain value.
> + *                    Parabola 2D correction coefficient gain magnification ratio.
> + * @lssc_para_mgsel4: &enum viif_l1_para_coef_gain value.
> + *                    Parabola 4D correction coefficient gain magnification ratio.
> + * @r_2d: 2D parabola coefficient for R.
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + * @r_4d: 4D parabola coefficient for R.
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + * @gr_2d: 2D parabola coefficient for Gr
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + * @gr_4d: 4D parabola coefficient for Gr
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + * @gb_2d: 2D parabola coefficient for Gb
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + * @gb_4d: 4D parabola coefficient for Gb
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + * @b_2d: 2D parabola coefficient for B
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + * @b_4d: 4D parabola coefficient for B
> + *        Refer to &struct viif_l1_lsc_parabola_ag_param
> + */
> +struct viif_l1_lsc_parabola_param {
> +	__u32 lssc_para_h_center;
> +	__u32 lssc_para_v_center;
> +	__u32 lssc_para_h_gain;
> +	__u32 lssc_para_v_gain;
> +	__u32 lssc_para_mgsel2;
> +	__u32 lssc_para_mgsel4;
> +	struct viif_l1_lsc_parabola_ag_param r_2d;
> +	struct viif_l1_lsc_parabola_ag_param r_4d;
> +	struct viif_l1_lsc_parabola_ag_param gr_2d;
> +	struct viif_l1_lsc_parabola_ag_param gr_4d;
> +	struct viif_l1_lsc_parabola_ag_param gb_2d;
> +	struct viif_l1_lsc_parabola_ag_param gb_4d;
> +	struct viif_l1_lsc_parabola_ag_param b_2d;
> +	struct viif_l1_lsc_parabola_ag_param b_4d;
> +};
> +
> +/**
> + * struct viif_l1_lsc_grid_param - L2ISP grid shading parameters
> + * for &struct viif_l1_lsc
> + * @lssc_grid_h_size: Grid horizontal direction pixel count [32, 64, 128, 256, 512]
> + * @lssc_grid_v_size: Grid vertical direction pixel count [32, 64, 128, 256, 512]
> + * @lssc_grid_h_center: Horizontal coordinates of grid (1, 1) [pixel] [1..lssc_grid_h_size]
> + *                      Should meet the following condition.
> + *                      "Input image width <= lssc_grid_h_center + lssc_grid_h_size * 31"
> + * @lssc_grid_v_center: Vertical coordinates of grid (1, 1) [line] [1..lssc_grid_v_size]
> + *                      Should meet the following condition.
> + *                      "Input image height <= lssc_grid_v_center + lssc_grid_v_size * 23"
> + * @lssc_grid_mgsel: &enum viif_l1_grid_coef_gain value.
> + *                   Grid correction coefficient gain value magnification ratio.
> + */
> +struct viif_l1_lsc_grid_param {
> +	__u32 lssc_grid_h_size;
> +	__u32 lssc_grid_v_size;
> +	__u32 lssc_grid_h_center;
> +	__u32 lssc_grid_v_center;
> +	__u32 lssc_grid_mgsel;
> +};
> +
> +/**
> + * struct viif_l1_lsc - L2ISP LSC parameters for &struct viif_l1_lsc_config
> + * @lssc_parabola_param_addr: Address of a &struct viif_l1_lsc_parabola_param instance.
> + *                            Set 0 to disable parabola shading correction.
> + * @lssc_grid_param_addr: Address of a &struct viif_l1_lsc_grid_param instance,
> + *                        Set 0 to disable grid shading correction.
> + * @lssc_pwhb_r_gain_max: PWB R correction processing coefficient maximum value
> + * @lssc_pwhb_r_gain_min: PWB R correction processing coefficient minimum value
> + * @lssc_pwhb_gr_gain_max: PWB Gr correction processing coefficient maximum value
> + * @lssc_pwhb_gr_gain_min: PWB Gr correction processing coefficient minimum value
> + * @lssc_pwhb_gb_gain_max: PWB Gb correction processing coefficient maximum value
> + * @lssc_pwhb_gb_gain_min: PWB Gb correction processing coefficient minimum value
> + * @lssc_pwhb_b_gain_max: PWB B correction processing coefficient maximum value
> + * @lssc_pwhb_b_gain_min: PWB B correction processing coefficient minimum value
> + *
> + * The range and accuracy of preset white balance (PWB) correction process
> + * coefficient (lssc_pwhb_{r/gr/gb/b}_gain_{max/min}) are as below.
> + * "range: [0..2047], accuracy: 1/256"
> + *
> + * PWB correction process coefficient
> + * (lssc_pwhb_{r/gr/gb/b}_gain_{max/min}) should meet the following conditions.
> + * "lssc_pwhb_{r/gr/gb/b}_gain_min <= lssc_pwhb_{r/gr/gb/b}_gain_max"
> + */
> +struct viif_l1_lsc {
> +	__u64 lssc_parabola_param_addr;
> +	__u64 lssc_grid_param_addr;
> +	__u32 lssc_pwhb_r_gain_max;
> +	__u32 lssc_pwhb_r_gain_min;
> +	__u32 lssc_pwhb_gr_gain_max;
> +	__u32 lssc_pwhb_gr_gain_min;
> +	__u32 lssc_pwhb_gb_gain_max;
> +	__u32 lssc_pwhb_gb_gain_min;
> +	__u32 lssc_pwhb_b_gain_max;
> +	__u32 lssc_pwhb_b_gain_min;
> +};
> +
> +/**
> + * struct viif_l1_lsc_config - L2ISP LSC parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC`
> + * @param_addr: Address of a &struct viif_l1_lsc instance.
> + *              Set 0 to disable LSC operation.
> + * @table_gr_addr: Address of the grid table for LSC of Gr component.
> + *                 The table size is sizeof(u16) * 768.
> + *                 Set 0 to disable this table.
> + * @table_r_addr:  Address of the grid table for LSC of R component.
> + *                 The table size is sizeof(u16) * 768.
> + *                 Set 0 to disable this table.
> + * @table_b_addr:  Address of the grid table for LSC of B component.
> + *                 The table size is sizeof(u16) * 768.
> + *                 Set 0 to disable this table.
> + * @table_gb_addr: Address of the grid table for LSC of Gb component.
> + *                 The table size is sizeof(u16) * 768.
> + *                 Set 0 to disable this table.
> + *
> + * The size of each table is fixed to 1,536 Bytes.
> + * Application should make sure that the table data is based on HW specification
> + * since this driver does not check the grid table.
> + */
> +struct viif_l1_lsc_config {
> +	__u64 param_addr;
> +	__u64 table_gr_addr;
> +	__u64 table_r_addr;
> +	__u64 table_b_addr;
> +	__u64 table_gb_addr;
> +};
> +
> +/**
> + * enum viif_l1_demosaic_mode - L1ISP demosaic modeenum viif_l1_demosaic_mode
> + *
> + * @VIIF_L1_DEMOSAIC_ACPI: Toshiba ACPI algorithm
> + * @VIIF_L1_DEMOSAIC_DMG: DMG algorithm
> + */
> +enum viif_l1_demosaic_mode {
> +	VIIF_L1_DEMOSAIC_ACPI = 0,
> +	VIIF_L1_DEMOSAIC_DMG = 1,
> +};
> +
> +/**
> + * struct viif_l1_color_matrix_correction - L1ISP color matrix correction
> + * parameters for &struct viif_l1_main_process_config
> + * @coef_rmg_min: (R-G) Minimum coefficient
> + * @coef_rmg_max: (R-G) Maximum coefficient
> + * @coef_rmb_min: (R-B) Minimum coefficient
> + * @coef_rmb_max: (R-B) Maximum coefficient
> + * @coef_gmr_min: (G-R) Minimum coefficient
> + * @coef_gmr_max: (G-R) Maximum coefficient
> + * @coef_gmb_min: (G-B) Minimum coefficient
> + * @coef_gmb_max: (G-B) Maximum coefficient
> + * @coef_bmr_min: (B-R) Minimum coefficient
> + * @coef_bmr_max: (B-R) Maximum coefficient
> + * @coef_bmg_min: (B-G) Minimum coefficient
> + * @coef_bmg_max: (B-G) Maximum coefficient
> + * @dst_minval: Minimum value of output pixel [0..0xFFFF] [pixel]
> + *
> + * The range and accuracy of each coefficient are as
> + * "range: [-32768..32767], accuracy: 1/ 4096"
> + *
> + * Also, each coefficient should meet "coef_xxx_min <= coef_xxx_max" condition
> + */
> +struct viif_l1_color_matrix_correction {
> +	__s16 coef_rmg_min;
> +	__s16 coef_rmg_max;
> +	__s16 coef_rmb_min;
> +	__s16 coef_rmb_max;
> +	__s16 coef_gmr_min;
> +	__s16 coef_gmr_max;
> +	__s16 coef_gmb_min;
> +	__s16 coef_gmb_max;
> +	__s16 coef_bmr_min;
> +	__s16 coef_bmr_max;
> +	__s16 coef_bmg_min;
> +	__s16 coef_bmg_max;
> +	__u16 dst_minval;
> +};
> +
> +/**
> + * struct viif_l1_main_process_config - L1ISP Main process operating parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS`
> + * @demosaic_mode: &enum viif_l1_demosaic_mode value. Sets demosaic mode.
> + * @damp_lsbsel: Clipping range of output pixel value to AWB adjustment function [0..15]
> + * @param_addr: Address to a &struct viif_l1_color_matrix_correction instance.
> + *              Set 0 to disable color matrix correction.
> + * @dst_maxval: Maximum value of output pixel [0..0xFFFFFF].
> + *              Applicable to output of each process (digital amplifier,
> + *              demosaicing and color matrix correction) in L1ISP Main process.
> + */
> +struct viif_l1_main_process_config {
> +	__u32 demosaic_mode;
> +	__u32 damp_lsbsel;
> +	__u64 param_addr;
> +	__u32 dst_maxval;
> +};
> +
> +/**
> + * enum viif_l1_awb_mag - L1ISP signal magnification before AWB adjustment
> + *
> + * @VIIF_L1_AWB_ONE_SECOND: x 1/2
> + * @VIIF_L1_AWB_X1: 1 times
> + * @VIIF_L1_AWB_X2: 2 times
> + * @VIIF_L1_AWB_X4: 4 times
> + */
> +enum viif_l1_awb_mag {
> +	VIIF_L1_AWB_ONE_SECOND = 0,
> +	VIIF_L1_AWB_X1 = 1,
> +	VIIF_L1_AWB_X2 = 2,
> +	VIIF_L1_AWB_X4 = 3,
> +};
> +
> +/**
> + * enum viif_l1_awb_area_mode - L1ISP AWB detection target area
> + *
> + * @VIIF_L1_AWB_AREA_MODE0: only center area
> + * @VIIF_L1_AWB_AREA_MODE1: center area when uv is in square gate
> + * @VIIF_L1_AWB_AREA_MODE2: all area except center area
> + * @VIIF_L1_AWB_AREA_MODE3: all area
> + */
> +enum viif_l1_awb_area_mode {
> +	VIIF_L1_AWB_AREA_MODE0 = 0,
> +	VIIF_L1_AWB_AREA_MODE1 = 1,
> +	VIIF_L1_AWB_AREA_MODE2 = 2,
> +	VIIF_L1_AWB_AREA_MODE3 = 3,
> +};
> +
> +/**
> + * enum viif_l1_awb_restart_cond - L1ISP AWB adjustment restart conditions
> + *
> + * @VIIF_L1_AWB_RESTART_NO: no restart
> + * @VIIF_L1_AWB_RESTART_128FRAME: restart after 128 frame
> + * @VIIF_L1_AWB_RESTART_64FRAME: restart after 64 frame
> + * @VIIF_L1_AWB_RESTART_32FRAME: restart after 32 frame
> + * @VIIF_L1_AWB_RESTART_16FRAME: restart after 16 frame
> + * @VIIF_L1_AWB_RESTART_8FRAME: restart after 8 frame
> + * @VIIF_L1_AWB_RESTART_4FRAME: restart after 4 frame
> + * @VIIF_L1_AWB_RESTART_2FRAME: restart after 2 frame
> + */
> +enum viif_l1_awb_restart_cond {
> +	VIIF_L1_AWB_RESTART_NO = 0,
> +	VIIF_L1_AWB_RESTART_128FRAME = 1,
> +	VIIF_L1_AWB_RESTART_64FRAME = 2,
> +	VIIF_L1_AWB_RESTART_32FRAME = 3,
> +	VIIF_L1_AWB_RESTART_16FRAME = 4,
> +	VIIF_L1_AWB_RESTART_8FRAME = 5,
> +	VIIF_L1_AWB_RESTART_4FRAME = 6,
> +	VIIF_L1_AWB_RESTART_2FRAME = 7,
> +};
> +
> +/**
> + * struct viif_l1_awb - L1ISP AWB adjustment parameters
> + * for &struct viif_l1_awb_config
> + * @awhb_ygate_sel: 1:Enable/0:Disable to fix Y value at YUV conversion
> + * @awhb_ygate_data: Y value in case Y value is fixed [64, 128, 256, 512]
> + * @awhb_cgrange: &enum viif_l1_awb_mag value.
> + *                Signal output magnification ratio before AWB adjustment.
> + * @awhb_ygatesw: 1:Enable/0:Disable settings of luminance gate
> + * @awhb_hexsw: 1:Enable/0:Disable settings of hexa-gate
> + * @awhb_areamode: &enum viif_l1_awb_area_mode value.
> + *                 Final selection of accumulation area for detection target area.
> + * @awhb_area_hsize: Horizontal size per block in central area [pixel]
> + *                   [1..(Input image width -8)/8]
> + * @awhb_area_vsize: Vertical size per block in central area [line]
> + *                   [1..(Input image height -4)/8]
> + * @awhb_area_hofs: Horizontal offset of block [0] in central area [pixel]
> + *                  [0..(Input image width -9)]
> + * @awhb_area_vofs: Vertical offset of block [0] in central area [line]
> + *                  [0..(Input image height -5)]
> + * @awhb_area_maskh: Setting 1:Enable/0:Disable( of accumulated selection.
> + *                   Each bit implies the following.
> + *                   [31:0] = {
> + *                   (7, 3),(6, 3),(5, 3),(4, 3),(3, 3),(2, 3),(1, 3),(0, 3),
> + *                   (7, 2),(6, 2),(5, 2),(4, 2),(3, 2),(2, 2),(1, 2),(0, 2),
> + *                   (7, 1),(6, 1),(5, 1),(4, 1),(3, 1),(2, 1),(1, 1),(0, 1),
> + *                   (7, 0),(6, 0),(5, 0),(4, 0),(3, 0),(2, 0),(1, 0),(0, 0)}
> + * @awhb_area_maskl: Setting 1:Enable/0:Disable of accumulated selection.
> + *                   Each bit implies the following.
> + *                   [31:0] = {
> + *                   (7, 7),(6, 7),(5, 7),(4, 7),(3, 7),(2, 7),(1, 7),(0, 7),
> + *                   (7, 6),(6, 6),(5, 6),(4, 6),(3, 6),(2, 6),(1, 6),(0, 6),
> + *                   (7, 5),(6, 5),(5, 5),(4, 5),(3, 5),(2, 5),(1, 5),(0, 5),
> + *                   (7, 4),(6, 4),(5, 4),(4, 4),(3, 4),(2, 4),(1, 4),(0, 4)}
> + * @awhb_sq_sw: 1:Enable/0:Disable each square gate
> + * @awhb_sq_pol: 1:Enable/0:Disable to add accumulated gate for each square gate
> + * @awhb_bycut0p: U upper end value [pixel] [0..127]
> + * @awhb_bycut0n: U lower end value [pixel] [0..127]
> + * @awhb_rycut0p: V upper end value [pixel] [0..127]
> + * @awhb_rycut0n: V lower end value [pixel] [0..127]
> + * @awhb_rbcut0h: V-axis intercept upper end [pixel] [-127..127]
> + * @awhb_rbcut0l: V-axis intercept lower end [pixel] [-127..127]
> + * @awhb_bycut_h: U direction center value of each square gate [-127..127]
> + * @awhb_bycut_l: U direction width of each square gate [0..127]
> + * @awhb_rycut_h: V direction center value of each square gate [-127..127]
> + * @awhb_rycut_l: V direction width of each square gate [0..127]
> + * @awhb_awbsftu: U gain offset [-127..127]
> + * @awhb_awbsftv: V gain offset [-127..127]
> + * @awhb_awbhuecor: 1:Enable/0:Disable setting of color correlation retention function
> + * @awhb_awbspd: UV convergence speed [0..15] [times] (0 means "stop")
> + * @awhb_awbulv: U convergence point level [0..31]
> + * @awhb_awbvlv: V convergence point level [0..31]
> + * @awhb_awbondot: Accumulation operation stop pixel count threshold [pixel] [0..1023]
> + * @awhb_awbfztim: &enum viif_l1_awb_restart_cond value. Condition to restart AWB process.
> + * @awhb_wbgrmax: B gain adjustment range (Width from center to upper limit)
> + *                [0..255], accuracy: 1/64
> + * @awhb_wbgbmax: R gain adjustment range (Width from center to upper limit)
> + *                [0..255], accuracy: 1/64
> + * @awhb_wbgrmin: B gain adjustment range (Width from center to lower limit)
> + *                [0..255], accuracy: 1/64
> + * @awhb_wbgbmin: R gain adjustment range (Width from center to lower limit)
> + *                [0..255], accuracy: 1/64
> + * @awhb_ygateh: Luminance gate maximum value [pixel] [0..255]
> + * @awhb_ygatel: Luminance gate minimum value [pixel] [0..255]
> + * @awhb_awbwait: Number of restart frames after UV convergence freeze [0..255]
> + */
> +struct viif_l1_awb {
> +	__u32 awhb_ygate_sel;
> +	__u32 awhb_ygate_data;
> +	__u32 awhb_cgrange;
> +	__u32 awhb_ygatesw;
> +	__u32 awhb_hexsw;
> +	__u32 awhb_areamode;
> +	__u32 awhb_area_hsize;
> +	__u32 awhb_area_vsize;
> +	__u32 awhb_area_hofs;
> +	__u32 awhb_area_vofs;
> +	__u32 awhb_area_maskh;
> +	__u32 awhb_area_maskl;
> +	__u32 awhb_sq_sw[3];
> +	__u32 awhb_sq_pol[3];
> +	__u32 awhb_bycut0p;
> +	__u32 awhb_bycut0n;
> +	__u32 awhb_rycut0p;
> +	__u32 awhb_rycut0n;
> +	__s32 awhb_rbcut0h;
> +	__s32 awhb_rbcut0l;
> +	__s32 awhb_bycut_h[3];
> +	__u32 awhb_bycut_l[3];
> +	__s32 awhb_rycut_h[3];
> +	__u32 awhb_rycut_l[3];
> +	__s32 awhb_awbsftu;
> +	__s32 awhb_awbsftv;
> +	__u32 awhb_awbhuecor;
> +	__u32 awhb_awbspd;
> +	__u32 awhb_awbulv;
> +	__u32 awhb_awbvlv;
> +	__u32 awhb_awbondot;
> +	__u32 awhb_awbfztim;
> +	__u8 awhb_wbgrmax;
> +	__u8 awhb_wbgbmax;
> +	__u8 awhb_wbgrmin;
> +	__u8 awhb_wbgbmin;
> +	__u8 awhb_ygateh;
> +	__u8 awhb_ygatel;
> +	__u8 awhb_awbwait;
> +};
> +
> +/**
> + * struct viif_l1_awb_config - L1ISP AWB parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB`
> + * @param_addr: Address to a &struct viif_l1_awb instance.
> + *              Set 0 to disable AWB adjustment.
> + * @awhb_wbmrg: White balance adjustment R gain [64..1023], accuracy: 1/256
> + * @awhb_wbmgg: White balance adjustment G gain [64..1023], accuracy: 1/256
> + * @awhb_wbmbg: White balance adjustment B gain [64..1023], accuracy: 1/256
> + */
> +struct viif_l1_awb_config {
> +	__u64 param_addr;
> +	__u32 awhb_wbmrg;
> +	__u32 awhb_wbmgg;
> +	__u32 awhb_wbmbg;
> +};
> +
> +/**
> + * enum viif_l1_hdrc_tone_type - L1ISP HDRC tone type
> + *
> + * @VIIF_L1_HDRC_TONE_USER: User Tone
> + * @VIIF_L1_HDRC_TONE_PRESET: Preset Tone
> + */
> +enum viif_l1_hdrc_tone_type {
> +	VIIF_L1_HDRC_TONE_USER = 0,
> +	VIIF_L1_HDRC_TONE_PRESET = 1,
> +};
> +
> +/**
> + * struct viif_l1_hdrc - L1ISP HDRC parameters for &struct viif_l1_hdrc_config
> + * @hdrc_ratio: Data width of input image [bit] [10..24]
> + * @hdrc_pt_ratio: Preset Tone curve slope [0..13]
> + * @hdrc_pt_blend: Preset Tone0 curve blend ratio [0..256], accuracy: 1/256
> + * @hdrc_pt_blend2: Preset Tone2 curve blend ratio [0..256], accuracy: 1/256
> + * @hdrc_tn_type: &enum viif_l1_hdrc_tone_type value. L1ISP HDRC tone type.
> + * @hdrc_utn_tbl: HDRC value of User Tone curve [0..0xFFFF]
> + * @hdrc_flr_val: Constant flare value [0..0xFFFFFF]
> + * @hdrc_flr_adp: 1:Enable/0:Disable setting of dynamic flare measurement
> + * @hdrc_ybr_off: 1:Enable(function OFF) / 0:Disable(function ON) settings
> + *                of bilateral luminance filter function OFF
> + * @hdrc_orgy_blend: Blend settings of luminance correction data after HDRC
> + *                   and data before luminance correction [0..16].
> + *                   (0:Luminance correction 100%, 8:Luminance correction 50%,
> + *                   16:Luminance correction 0%)
> + * @hdrc_pt_sat: Preset Tone saturation value [0..0xFFFF]
> + *
> + * Parameter error needs to be returned in
> + * "hdrc_pt_blend + hdrc_pt_blend2 > 256" condition.
> + *
> + * In case application enables dynamic flare control, input image height should
> + * satisfy the following condition. Even if this condition is not satisfied,
> + * this driver doesn't return error in case other conditions for each parameter
> + * are satisfied. "Input image height % 64 != 18, 20, 22, 24, 26"
> + *
> + * hdrc_utn_tbl should satisfy the following condition. Even if this condition
> + * is not satisfied, this driver doesn't return error in case other conditions
> + * for each parameter are satisfied. "hdrc_utn_tbl[N] <= hdrc_utn_tbl[N+1]"
> + */
> +struct viif_l1_hdrc {
> +	__u32 hdrc_ratio;
> +	__u32 hdrc_pt_ratio;
> +	__u32 hdrc_pt_blend;
> +	__u32 hdrc_pt_blend2;
> +	__u32 hdrc_tn_type;
> +	__u16 hdrc_utn_tbl[20];
> +	__u32 hdrc_flr_val;
> +	__u32 hdrc_flr_adp;
> +	__u32 hdrc_ybr_off;
> +	__u32 hdrc_orgy_blend;
> +	__u16 hdrc_pt_sat;
> +};
> +
> +/**
> + * struct viif_l1_hdrc_config - L1ISP HDRC parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC`
> + * @param_addr: Address to a &struct viif_l1_hdrc instance.
> + *              Set 0 to disable HDR compression.
> + * @hdrc_thr_sft_amt: Amount of right shift in through mode (HDRC disabled) [0..8].
> + *                    Should set 0 if HDRC is enabled
> + */
> +struct viif_l1_hdrc_config {
> +	__u64 param_addr;
> +	__u32 hdrc_thr_sft_amt;
> +};
> +
> +/**
> + * struct viif_l1_hdrc_ltm_config - L1ISP HDRC LTM parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM`
> + * @tnp_max: Tone blend rate maximum value of LTM function
> + *           [0..4194303], accuracy: 1/64. In case of 0, LTM function is OFF
> + * @tnp_mag: Intensity adjustment of LTM function [0..16383], accuracy: 1/64
> + * @tnp_fil: Smoothing filter coefficient [0..255].
> + *           [0]: coef0, [1]: coef1, [2]: coef2, [3]: coef3, [4]: coef4
> + *           EINVAL needs to be returned in the below condition.
> + *           "(coef1 + coef2 + coef3 + coef4) * 2 + coef0 != 1024"
> + */
> +struct viif_l1_hdrc_ltm_config {
> +	__u32 tnp_max;
> +	__u32 tnp_mag;
> +	__u8 tnp_fil[5];
> +};
> +
> +/**
> + * struct viif_l1_gamma - L1ISP gamma correction parameters
> + * for &struct viif_l1_gamma_config
> + * @gam_p: Luminance value after gamma correction [0..8191]
> + * @blkadj: Black level adjustment value after gamma correction [0..65535]
> + */
> +struct viif_l1_gamma {
> +	__u16 gam_p[44];
> +	__u16 blkadj;
> +};
> +
> +/**
> + * struct viif_l1_gamma_config - L1ISP gamma correction parameters
> + * @param_addr: Address to a &struct viif_l1_gamma instance.
> + *              Set 0 to disable gamma correction at l1 ISP.
> + */
> +struct viif_l1_gamma_config {
> +	__u64 param_addr;
> +};
> +
> +/**
> + * struct viif_l1_nonlinear_contrast -  L1ISP non-linear contrast parameters
> + * for &struct viif_l1_img_quality_adjustment_config
> + * @blk_knee: Black side peak luminance value [0..0xFFFF]
> + * @wht_knee: White side peak luminance value[0..0xFFFF]
> + * @blk_cont: Black side slope [0..255], accuracy: 1/256
> + *            [0]:the value at AG minimum, [1]:the value at AG less than 128,
> + *            [2]:the value at AG equal to or more than 128
> + * @wht_cont: White side slope [0..255], accuracy: 1/256
> + *            [0]:the value at AG minimum, [1]:the value at AG less than 128,
> + *            [2]:the value at AG equal to or more than 128
> + */
> +struct viif_l1_nonlinear_contrast {
> +	__u16 blk_knee;
> +	__u16 wht_knee;
> +	__u8 blk_cont[3];
> +	__u8 wht_cont[3];
> +};
> +
> +/**
> + * struct viif_l1_lum_noise_reduction -  L1ISP luminance noise reduction
> + * parameters for &struct viif_l1_img_quality_adjustment_config
> + * @gain_min: Minimum value of extracted noise gain [0..0xFFFF], accuracy: 1/256
> + * @gain_max: Maximum value of extracted noise gain [0..0xFFFF], accuracy: 1/256
> + * @lim_min: Minimum value of extracted noise limit [0..0xFFFF]
> + * @lim_max: Maximum value of extracted noise limit [0..0xFFFF]
> + *
> + * Parameter error needs to be returned in the below conditions.
> + * "gain_min > gain_max" or "lim_min > lim_max"
> + */
> +struct viif_l1_lum_noise_reduction {
> +	__u16 gain_min;
> +	__u16 gain_max;
> +	__u16 lim_min;
> +	__u16 lim_max;
> +};
> +
> +/**
> + * struct viif_l1_edge_enhancement -  L1ISP edge enhancement parameters
> + * for &struct viif_l1_img_quality_adjustment_config
> + * @gain_min: Extracted edge gain minimum value [0..0xFFFF], accuracy: 1/256
> + * @gain_max: Extracted edge gain maximum value [0..0xFFFF], accuracy: 1/256
> + * @lim_min: Extracted edge limit minimum value [0..0xFFFF]
> + * @lim_max: Extracted edge limit maximum value [0..0xFFFF]
> + * @coring_min: Extracted edge coring threshold minimum value [0..0xFFFF]
> + * @coring_max: Extracted edge coring threshold maximum value [0..0xFFFF]
> + *
> + * Parameter error needs to be returned in the below conditions.
> + * "gain_min > gain_max" or "lim_min > lim_max" or "coring_min > coring_max"
> + */
> +struct viif_l1_edge_enhancement {
> +	__u16 gain_min;
> +	__u16 gain_max;
> +	__u16 lim_min;
> +	__u16 lim_max;
> +	__u16 coring_min;
> +	__u16 coring_max;
> +};
> +
> +/**
> + * struct viif_l1_uv_suppression -  L1ISP UV suppression parameters
> + * for &struct viif_l1_img_quality_adjustment_config
> + * @bk_mp: Black side slope [0..0x3FFF], accuracy: 1/16384
> + * @black: Minimum black side gain [0..0x3FFF], accuracy: 1/16384
> + * @wh_mp: White side slope [0..0x3FFF], accuracy: 1/16384
> + * @white: Minimum white side gain [0..0x3FFF], accuracy: 1/16384
> + * @bk_slv: Black side intercept [0..0xFFFF]
> + * @wh_slv: White side intercept [0..0xFFFF]
> + *
> + * parameter error needs to be returned in "bk_slv >= wh_slv" condition.
> + */
> +struct viif_l1_uv_suppression {
> +	__u32 bk_mp;
> +	__u32 black;
> +	__u32 wh_mp;
> +	__u32 white;
> +	__u16 bk_slv;
> +	__u16 wh_slv;
> +};
> +
> +/**
> + * struct viif_l1_coring_suppression -  L1ISP coring suppression parameters
> + * for &struct viif_l1_img_quality_adjustment_config
> + * @lv_min: Minimum coring threshold [0..0xFFFF]
> + * @lv_max: Maximum coring threshold [0..0xFFFF]
> + * @gain_min: Minimum gain [0..0xFFFF], accuracy: 1/65536
> + * @gain_max: Maximum gain [0..0xFFFF], accuracy: 1/65536
> + *
> + * Parameter error needs to be returned in the below condition.
> + * "lv_min > lv_max" or "gain_min > gain_max"
> + */
> +struct viif_l1_coring_suppression {
> +	__u16 lv_min;
> +	__u16 lv_max;
> +	__u16 gain_min;
> +	__u16 gain_max;
> +};
> +
> +/**
> + * struct viif_l1_edge_suppression -  L1ISP edge suppression parameters
> + * for &struct viif_l1_img_quality_adjustment_config
> + * @gain: Gain of edge color suppression [0..0xFFFF], accuracy: 1/256
> + * @lim: Limiter threshold of edge color suppression [0..15]
> + */
> +struct viif_l1_edge_suppression {
> +	__u16 gain;
> +	__u32 lim;
> +};
> +
> +/**
> + * struct viif_l1_color_level -  L1ISP color level parameters
> + * for &struct viif_l1_img_quality_adjustment_config
> + * @cb_gain: U component gain [0..0xFFF], accuracy: 1/2048
> + * @cr_gain: V component gain [0..0xFFF], accuracy: 1/2048
> + * @cbr_mgain_min: UV component gain [0..0xFFF], accuracy: 1/2048
> + * @cbp_gain_max: Positive U component gain [0..0xFFF], accuracy: 1/2048
> + * @cbm_gain_max: Negative V component gain [0..0xFFF], accuracy: 1/2048
> + * @crp_gain_max: Positive U component gain [0..0xFFF], accuracy: 1/2048
> + * @crm_gain_max: Negative V component gain [0..0xFFF], accuracy: 1/2048
> + */
> +struct viif_l1_color_level {
> +	__u32 cb_gain;
> +	__u32 cr_gain;
> +	__u32 cbr_mgain_min;
> +	__u32 cbp_gain_max;
> +	__u32 cbm_gain_max;
> +	__u32 crp_gain_max;
> +	__u32 crm_gain_max;
> +};
> +
> +/**
> + * struct viif_l1_img_quality_adjustment_config -  L1ISP image quality
> + * adjustment parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT`
> + * @coef_cb: Cb coefficient used in RGB to YUV conversion
> + *           [0..0xFFFF], accuracy: 1/65536
> + * @coef_cr: Cr coefficient used in RGB to YUV conversion
> + *           [0..0xFFFF], accuracy: 1/65536
> + * @brightness: Brightness value [-32768..32767] (0 means off)
> + * @linear_contrast: Linear contrast adjustment value
> + *                   [0..0xFF], accuracy: 1/128 (128 means off)
> + * @nonlinear_contrast_addr: Address to a &struct viif_l1_nonlinear_contrast instance.
> + *                           Set 0 to disable nonlinear contrast adjustment.
> + * @lum_noise_reduction_addr: Address to a &struct viif_l1_lum_noise_reduction instance.
> + *                            Set 0 to disable luminance noise reduction.
> + * @edge_enhancement_addr: Address to a &struct viif_l1_edge_enhancement instance.
> + *                         Set 0 to disable edge enhancement,
> + * @uv_suppression_addr: Address to a &struct viif_l1_uv_suppression instance.
> + *                       Set 0 to disable chroma suppression.
> + * @coring_suppression_addr: Address to a &struct viif_l1_coring_suppression instance.
> + *                           Set 0 to disable coring suppression.
> + * @edge_suppression_addr: Address to a &struct viif_l1_edge_suppression instance.
> + *                         Set 0 to disable chroma edge suppression.
> + * @color_level_addr: Address to a &struct viif_l1_color_level instance.
> + *                    Set 0 to disable color level adjustment.
> + * @color_noise_reduction_enable: 1:Enable/0:disable setting of
> + *                                color component noise reduction processing
> + */
> +struct viif_l1_img_quality_adjustment_config {
> +	__u16 coef_cb;
> +	__u16 coef_cr;
> +	__s16 brightness;
> +	__u8 linear_contrast;
> +	__u64 nonlinear_contrast_addr;
> +	__u64 lum_noise_reduction_addr;
> +	__u64 edge_enhancement_addr;
> +	__u64 uv_suppression_addr;
> +	__u64 coring_suppression_addr;
> +	__u64 edge_suppression_addr;
> +	__u64 color_level_addr;
> +	__u32 color_noise_reduction_enable;
> +};
> +
> +/**
> + * struct viif_l1_avg_lum_generation_config - L1ISP average luminance generation configuration
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION`
> + * @aexp_start_x: horizontal position of block[0] [0.."width of input image - 1"] [pixel]
> + * @aexp_start_y: vertical position of block[0] [0.."height of input image - 1"] [line]
> + * @aexp_block_width: width of one block(needs to be multiple of 64)
> + *                    [64.."width of input image"] [pixel]
> + * @aexp_block_height: height of one block(needs to be multiple of 64)
> + *                     [64.."height of input image"] [line]
> + * @aexp_weight: weight of each block [0..3]  [y][x]:
> + *               y means vertical position and x means horizontal position
> + * @aexp_satur_ratio: threshold to judge whether saturated block or not [0..256]
> + * @aexp_black_ratio: threshold to judge whether black block or not [0..256]
> + * @aexp_satur_level: threshold to judge whether saturated pixel or not [0x0..0xffffff]
> + * @aexp_ave4linesy: vertical position of the initial line
> + *                   for 4-lines average luminance [0.."height of input image - 4"] [line]
> + */
> +struct viif_l1_avg_lum_generation_config {
> +	__u32 aexp_start_x;
> +	__u32 aexp_start_y;
> +	__u32 aexp_block_width;
> +	__u32 aexp_block_height;
> +	__u32 aexp_weight[8][8];
> +	__u32 aexp_satur_ratio;
> +	__u32 aexp_black_ratio;
> +	__u32 aexp_satur_level;
> +	__u32 aexp_ave4linesy[4];
> +};
> +
> +/**
> + * enum viif_l2_undist_mode - L2ISP undistortion mode
> + * @VIIF_L2_UNDIST_POLY: polynomial mode
> + * @VIIF_L2_UNDIST_GRID: grid table mode
> + * @VIIF_L2_UNDIST_POLY_TO_GRID: polynomial, then grid table mode
> + * @VIIF_L2_UNDIST_GRID_TO_POLY: grid table, then polynomial mode
> + */
> +enum viif_l2_undist_mode {
> +	VIIF_L2_UNDIST_POLY = 0,
> +	VIIF_L2_UNDIST_GRID = 1,
> +	VIIF_L2_UNDIST_POLY_TO_GRID = 2,
> +	VIIF_L2_UNDIST_GRID_TO_POLY = 3,
> +};
> +
> +/**
> + * struct viif_l2_undist - L2ISP UNDIST parameters
> + * for &struct viif_l2_undist_config
> + * @through_mode: 1:enable or 0:disable through mode of undistortion
> + * @roi_mode: &enum viif_l2_undist_mode value. Sets L2ISP undistortion mode.
> + * @sensor_crop_ofs_h: Horizontal start position of sensor crop area[pixel]
> + *                     [-4296..4296], accuracy: 1/2
> + * @sensor_crop_ofs_v: Vertical start position of sensor crop area[line]
> + *                     [-2360..2360], accuracy: 1/2
> + * @norm_scale: Normalization coefficient for distance from center
> + *              [0..1677721], accuracy: 1/33554432
> + * @valid_r_norm2_poly: Setting target area for polynomial correction
> + *                      [0..0x3FFFFFF], accuracy: 1/33554432
> + * @valid_r_norm2_grid: Setting target area for grid table correction
> + *                      [0..0x3FFFFFF], accuracy: 1/33554432
> + * @roi_write_area_delta: Error adjustment value of forward function and
> + *                        inverse function for pixel position calculation
> + *                        [0..0x7FF], accuracy: 1/1024
> + * @poly_write_g_coef: 10th-order polynomial coefficient for G write pixel position calculation
> + *                     [-2147352576..2147352576], accuracy: 1/131072
> + * @poly_read_b_coef: 10th-order polynomial coefficient for B read pixel position calculation
> + *                    [-2147352576..2147352576], accuracy: 1/131072
> + * @poly_read_g_coef: 10th-order polynomial coefficient for G read pixel position calculation
> + *                    [-2147352576..2147352576], accuracy: 1/131072
> + * @poly_read_r_coef: 10th-order polynomial coefficient for R read pixel position calculation
> + *                    [-2147352576..2147352576], accuracy: 1/131072
> + * @grid_node_num_h: Number of horizontal grids [16..64]
> + * @grid_node_num_v: Number of vertical grids [16..64]
> + * @grid_patch_hsize_inv: Inverse pixel size between horizontal grids
> + *                        [0..0x7FFFFF], accuracy: 1/8388608
> + * @grid_patch_vsize_inv: Inverse pixel size between vertical grids
> + *                        [0..0x7FFFFF], accuracy: 1/8388608
> + */
> +struct viif_l2_undist {
> +	__u32 through_mode;
> +	__u32 roi_mode[2];
> +	__s32 sensor_crop_ofs_h;
> +	__s32 sensor_crop_ofs_v;
> +	__u32 norm_scale;
> +	__u32 valid_r_norm2_poly;
> +	__u32 valid_r_norm2_grid;
> +	__u32 roi_write_area_delta[2];
> +	__s32 poly_write_g_coef[11];
> +	__s32 poly_read_b_coef[11];
> +	__s32 poly_read_g_coef[11];
> +	__s32 poly_read_r_coef[11];
> +	__u32 grid_node_num_h;
> +	__u32 grid_node_num_v;
> +	__u32 grid_patch_hsize_inv;
> +	__u32 grid_patch_vsize_inv;
> +};
> +
> +/**
> + * struct viif_l2_undist_config - L2ISP UNDIST parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST`
> + * @param: &struct viif_l2_undist
> + * @write_g_addr: Address to write-G grid table.
> + *                Table size is specified by member size.
> + *                Set 0 to disable this table.
> + * @read_b_addr: Address to read-B grid table.
> + *               Table size is specified by member size.
> + *               Set 0 to disable this table.
> + * @read_g_addr: Address to read-G grid table.
> + *               Table size is specified by member size.
> + *               Set 0 to disable this table.
> + * @read_r_addr: Address to read-R grid table.
> + *               Table size is specified by member size.
> + *               Set 0 to disable this table.
> + * @size: Table size [byte]. Range: [1024..8192] or 0.
> + *        The value should be "grid_node_num_h * grid_node_num_v * 4".
> + *        See also &struct viif_l2_undist.
> + *        Set 0 if NULL is set for all tables.
> + *        Set valid size value if at least one table is valid.
> + *
> + * Application should make sure that the table data is based on HW specification
> + * since this driver does not check the contents of specified grid table.
> + */
> +struct viif_l2_undist_config {
> +	struct viif_l2_undist param;
> +	__u64 write_g_addr;
> +	__u64 read_b_addr;
> +	__u64 read_g_addr;
> +	__u64 read_r_addr;
> +	__u32 size;
> +};
> +
> +/**
> + * struct viif_l2_roi_config - L2ISP ROI parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI`
> + * @roi_num:
> + *     1 when only capture path0 is activated,
> + *     2 when both capture path 0 and path 1 are activated.
> + * @roi_scale: Scale value for each ROI [32768..131072], accuracy: 1/65536
> + * @roi_scale_inv: Inverse scale value for each ROI [32768..131072], accuracy: 1/65536
> + * @corrected_wo_scale_hsize: Corrected image width for each ROI [pixel] [128..8190]
> + * @corrected_wo_scale_vsize: Corrected image height for each ROI [line] [128..4094]
> + * @corrected_hsize: Corrected and scaled image width for each ROI [pixel] [128..8190]
> + * @corrected_vsize: Corrected and scaled image height for each ROI [line] [128..4094]
> + */
> +struct viif_l2_roi_config {
> +	__u32 roi_num;
> +	__u32 roi_scale[2];
> +	__u32 roi_scale_inv[2];
> +	__u32 corrected_wo_scale_hsize[2];
> +	__u32 corrected_wo_scale_vsize[2];
> +	__u32 corrected_hsize[2];
> +	__u32 corrected_vsize[2];
> +};
> +
> +/** enum viif_gamma_mode - Gamma correction mode
> + *
> + * @VIIF_GAMMA_COMPRESSED: compressed table mode
> + * @VIIF_GAMMA_LINEAR: linear table mode
> + */
> +enum viif_gamma_mode {
> +	VIIF_GAMMA_COMPRESSED = 0,
> +	VIIF_GAMMA_LINEAR = 1,
> +};
> +
> +/**
> + * struct viif_l2_gamma_config - L2ISP gamma correction parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA`
> + * @pathid: 0 for Capture Path 0, 1 for Capture Path 1.
> + * @enable: 1:Enable, 0:Disable settings of L2ISP gamma correction control
> + * @vsplit: Line switching position of first table and second table [line] [0..4094].
> + *          Should set 0 in case 0 is set to @enable
> + * @mode: &enum viif_gamma_mode value.
> + *        Should set VIIF_GAMMA_COMPRESSED when 0 is set to @enable
> + * @table_addr: Address to gamma table for L2ISP gamma.
> + *              The table has 6 channels;
> + *              [0]: G/Y(1st table), [1]: G/Y(2nd table), [2]: B/U(1st table)
> + *              [3]: B/U(2nd table), [4]: R/V(1st table), [5]: R/V(2nd table)
> + *              Each channel of the table is __u16 typed and 512 bytes.
> + */
> +struct viif_l2_gamma_config {
> +	__u32 pathid;
> +	__u32 enable;
> +	__u32 vsplit;
> +	__u32 mode;
> +	__u64 table_addr[6];
> +};
> +
> +/**
> + * enum viif_csi2_cal_status - CSI2RX calibration status
> + *
> + * @VIIF_CSI2_CAL_NOT_DONE: Calibration not complete
> + * @VIIF_CSI2_CAL_SUCCESS: Calibration success
> + * @VIIF_CSI2_CAL_FAIL: Calibration failed
> + */
> +enum viif_csi2_cal_status {
> +	VIIF_CSI2_CAL_NOT_DONE = 0,
> +	VIIF_CSI2_CAL_SUCCESS = 1,
> +	VIIF_CSI2_CAL_FAIL = 2,
> +};
> +
> +/**
> + * struct viif_csi2rx_dphy_calibration_status - CSI2-RX D-PHY Calibration
> + * information for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS`
> + * @term_cal_with_rext: Result of termination calibration with rext
> + * @clock_lane_offset_cal: Result of offset calibration of clock lane
> + * @data_lane0_offset_cal: Result of offset calibration of data lane0
> + * @data_lane1_offset_cal: Result of offset calibration of data lane1
> + * @data_lane2_offset_cal: Result of offset calibration of data lane2
> + * @data_lane3_offset_cal: Result of offset calibration of data lane3
> + * @data_lane0_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane0
> + * @data_lane1_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane1
> + * @data_lane2_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane2
> + * @data_lane3_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane3
> + *
> + * Values for each member is typed &enum viif_csi2_cal_status.
> + */
> +struct viif_csi2rx_dphy_calibration_status {
> +	__u32 term_cal_with_rext;
> +	__u32 clock_lane_offset_cal;
> +	__u32 data_lane0_offset_cal;
> +	__u32 data_lane1_offset_cal;
> +	__u32 data_lane2_offset_cal;
> +	__u32 data_lane3_offset_cal;
> +	__u32 data_lane0_ddl_tuning_cal;
> +	__u32 data_lane1_ddl_tuning_cal;
> +	__u32 data_lane2_ddl_tuning_cal;
> +	__u32 data_lane3_ddl_tuning_cal;
> +};
> +
> +/**
> + * struct viif_csi2rx_err_status - CSI2RX Error status parameters
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS`
> + * @err_phy_fatal: D-PHY FATAL error.
> + *
> + *  * bit[3]: Start of transmission error on DATA Lane3.
> + *  * bit[2]: Start of transmission error on DATA Lane2.
> + *  * bit[1]: Start of transmission error on DATA Lane1.
> + *  * bit[0]: Start of transmission error on DATA Lane0.
> + * @err_pkt_fatal: Packet FATAL error.
> + *
> + *  * bit[16]: Header ECC contains 2 errors, unrecoverable.
> + *  * bit[3]: Checksum error detected on virtual channel 3.
> + *  * bit[2]: Checksum error detected on virtual channel 2.
> + *  * bit[1]: Checksum error detected on virtual channel 1.
> + *  * bit[0]: Checksum error detected on virtual channel 0.
> + * @err_frame_fatal: Frame FATAL error.
> + *
> + *  * bit[19]: Last received Frame, in virtual channel 3, has at least one CRC error.
> + *  * bit[18]: Last received Frame, in virtual channel 2, has at least one CRC error.
> + *  * bit[17]: Last received Frame, in virtual channel 1, has at least one CRC error.
> + *  * bit[16]: Last received Frame, in virtual channel 0, has at least one CRC error.
> + *  * bit[11]: Incorrect Frame Sequence detected in virtual channel 3.
> + *  * bit[10]: Incorrect Frame Sequence detected in virtual channel 2.
> + *  * bit[9]: Incorrect Frame Sequence detected in virtual channel 1.
> + *  * bit[8]: Incorrect Frame Sequence detected in virtual channel 0.
> + *  * bit[3]: Error matching Frame Start with Frame End for virtual channel 3.
> + *  * bit[2]: Error matching Frame Start with Frame End for virtual channel 2.
> + *  * bit[1]: Error matching Frame Start with Frame End for virtual channel 1.
> + *  * bit[0]: Error matching Frame Start with Frame End for virtual channel 0.
> + * @err_phy: D-PHY error.
> + *
> + *  * bit[19]: Escape Entry Error on Data Lane 3.
> + *  * bit[18]: Escape Entry Error on Data Lane 2.
> + *  * bit[17]: Escape Entry Error on Data Lane 1.
> + *  * bit[16]: Escape Entry Error on Data Lane 0.
> + *  * bit[3]: Start of Transmission Error on Data Lane 3 (synchronization can still be achieved).
> + *  * bit[2]: Start of Transmission Error on Data Lane 2 (synchronization can still be achieved).
> + *  * bit[1]: Start of Transmission Error on Data Lane 1 (synchronization can still be achieved).
> + *  * bit[0]: Start of Transmission Error on Data Lane 0 (synchronization can still be achieved).
> + * @err_pkt: Packet error.
> + *
> + *  * bit[19]: Header Error detected and corrected on virtual channel 3.
> + *  * bit[18]: Header Error detected and corrected on virtual channel 2.
> + *  * bit[17]: Header Error detected and corrected on virtual channel 1.
> + *  * bit[16]: Header Error detected and corrected on virtual channel 0.
> + *  * bit[3]: Unrecognized or unimplemented data type detected in virtual channel 3.
> + *  * bit[2]: Unrecognized or unimplemented data type detected in virtual channel 2.
> + *  * bit[1]: Unrecognized or unimplemented data type detected in virtual channel 1.
> + *  * bit[0]: Unrecognized or unimplemented data type detected in virtual channel 0.
> + * @err_line: Line error.
> + *
> + *  * bit[23]: Error in the sequence of lines for vc7 and dt7.
> + *  * bit[22]: Error in the sequence of lines for vc6 and dt6.
> + *  * bit[21]: Error in the sequence of lines for vc5 and dt5.
> + *  * bit[20]: Error in the sequence of lines for vc4 and dt4.
> + *  * bit[19]: Error in the sequence of lines for vc3 and dt3.
> + *  * bit[18]: Error in the sequence of lines for vc2 and dt2.
> + *  * bit[17]: Error in the sequence of lines for vc1 and dt1.
> + *  * bit[16]: Error in the sequence of lines for vc0 and dt0.
> + *  * bit[7]: Error matching Line Start with Line End for vc7 and dt7.
> + *  * bit[6]: Error matching Line Start with Line End for vc6 and dt6.
> + *  * bit[5]: Error matching Line Start with Line End for vc5 and dt5.
> + *  * bit[4]: Error matching Line Start with Line End for vc4 and dt4.
> + *  * bit[3]: Error matching Line Start with Line End for vc3 and dt3.
> + *  * bit[2]: Error matching Line Start with Line End for vc2 and dt2.
> + *  * bit[1]: Error matching Line Start with Line End for vc1 and dt1.
> + *  * bit[0]: Error matching Line Start with Line End for vc0 and dt0.
> + */
> +struct viif_csi2rx_err_status {
> +	__u32 err_phy_fatal;
> +	__u32 err_pkt_fatal;
> +	__u32 err_frame_fatal;
> +	__u32 err_phy;
> +	__u32 err_pkt;
> +	__u32 err_line;
> +};
> +
> +/**
> + * struct viif_l1_info - L1ISP AWB information
> + * for &struct viif_isp_capture_status
> + * @avg_lum_weight: weighted average luminance value at average luminance generation
> + * @avg_lum_block: average luminance of each block [y][x]:
> + *                 y means vertical position and x means horizontal position
> + * @avg_lum_four_line_lum: 4-lines average luminance.
> + *                         avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
> + * @avg_satur_pixnum: the number of saturated pixel at average luminance generation
> + * @avg_black_pixnum: the number of black pixel at average luminance generation
> + * @awb_ave_u: U average value of AWB adjustment [pixel]
> + * @awb_ave_v: V average value of AWB adjustment [pixel]
> + * @awb_accumulated_pixel: Accumulated pixel count of AWB adjustment
> + * @awb_gain_r: R gain used in the next frame of AWB adjustment
> + * @awb_gain_g: G gain used in the next frame of AWB adjustment
> + * @awb_gain_b: B gain used in the next frame of AWB adjustment
> + * @awb_status_u: boolean value of U convergence state of AWB adjustment
> + *                (0: not-converged, 1: converged)
> + * @awb_status_v: boolean value of V convergence state of AWB adjustment
> + *                (0: not-converged, 1: converged)
> + */
> +struct viif_l1_info {
> +	__u32 avg_lum_weight;
> +	__u32 avg_lum_block[8][8];
> +	__u32 avg_lum_four_line_lum[4];
> +	__u32 avg_satur_pixnum;
> +	__u32 avg_black_pixnum;
> +	__u32 awb_ave_u;
> +	__u32 awb_ave_v;
> +	__u32 awb_accumulated_pixel;
> +	__u32 awb_gain_r;
> +	__u32 awb_gain_g;
> +	__u32 awb_gain_b;
> +	__u8 awb_status_u;
> +	__u8 awb_status_v;
> +};
> +
> +/**
> + * struct viif_isp_capture_status - L1ISP capture information
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS`
> + * @l1_info: L1ISP AWB information. Refer to &struct viif_l1_info
> + */
> +struct viif_isp_capture_status {
> +	struct viif_l1_info l1_info;
> +};
> +
> +/**
> + * struct viif_reported_errors - Errors since last call
> + * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS`
> + * @main: error flag value for capture device 0 and 1
> + * @sub: error flag value for capture device 2
> + * @csi2rx: error flag value for CSI2 receiver
> + */
> +struct viif_reported_errors {
> +	__u32 main;
> +	__u32 sub;
> +	__u32 csi2rx;
> +};
> +
> +#endif /* __UAPI_VISCONTI_VIIF_H_ */

Regards,

	Hans
