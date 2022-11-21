Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E76330B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiKUX2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:28:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED37D5A3C;
        Mon, 21 Nov 2022 15:28:41 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2029E88F;
        Tue, 22 Nov 2022 00:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669073319;
        bh=cC/yGsnh62r1C2zY2rHk7jtuYsCdE0HihBu80S+TNYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQOVC55C0LaaBonmfDi9LL1cWsAJib2JACPijg/hs8EPF+/IhBUdQfXUhsK2H+PXr
         MjynuEHJAbbwVAlMv3JY9EzKMU9n6g/EskLRrTCvHiWF7seuO84B/SaKK7eGhIsllC
         nHZoJXsel30pBxVhCw3eBikMha/j23/N86zy0Pi0=
Date:   Tue, 22 Nov 2022 01:28:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH 08/14] uapi: bcm2835-isp: Add bcm2835-isp uapi header file
Message-ID: <Y3wJl8QjPk979A+k@pendragon.ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <20221121214722.22563-9-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121214722.22563-9-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang and Dave,

Thank you for the patch.

On Tue, Nov 22, 2022 at 03:17:16AM +0530, Umang Jain wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> This file defines the userland interface to the bcm2835-isp driver
> that will follow in a separate commit.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  include/uapi/linux/bcm2835-isp.h   | 320 +++++++++++++++++++++++++++++
>  include/uapi/linux/v4l2-controls.h |   6 +
>  2 files changed, 326 insertions(+)
>  create mode 100644 include/uapi/linux/bcm2835-isp.h
> 
> diff --git a/include/uapi/linux/bcm2835-isp.h b/include/uapi/linux/bcm2835-isp.h
> new file mode 100644
> index 000000000000..cf8c0437f159
> --- /dev/null
> +++ b/include/uapi/linux/bcm2835-isp.h
> @@ -0,0 +1,320 @@
> +/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * bcm2835-isp.h
> + *
> + * BCM2835 ISP driver - user space header file.
> + *
> + * Copyright © 2019-2020 Raspberry Pi (Trading) Ltd.
> + *
> + * Author: Naushir Patuck (naush@raspberrypi.com)
> + *
> + */
> +
> +#ifndef __BCM2835_ISP_H_
> +#define __BCM2835_ISP_H_
> +
> +#include <linux/v4l2-controls.h>
> +
> +#define V4L2_CID_USER_BCM2835_ISP_CC_MATRIX	\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0001)
> +#define V4L2_CID_USER_BCM2835_ISP_LENS_SHADING	\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0002)
> +#define V4L2_CID_USER_BCM2835_ISP_BLACK_LEVEL	\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0003)
> +#define V4L2_CID_USER_BCM2835_ISP_GEQ		\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0004)
> +#define V4L2_CID_USER_BCM2835_ISP_GAMMA		\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0005)
> +#define V4L2_CID_USER_BCM2835_ISP_DENOISE	\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0006)
> +#define V4L2_CID_USER_BCM2835_ISP_SHARPEN	\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0007)
> +#define V4L2_CID_USER_BCM2835_ISP_DPC		\
> +				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0008)
> +
> +/*
> + * All structs below are directly mapped onto the equivalent structs in
> + * drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
> + * for convenience.
> + */
> +
> +/**
> + * struct bcm2835_isp_rational - Rational value type.
> + *
> + * @num:	Numerator.
> + * @den:	Denominator.
> + */
> +struct bcm2835_isp_rational {
> +	__s32 num;
> +	__u32 den;
> +};
> +
> +/**
> + * struct bcm2835_isp_ccm - Colour correction matrix.
> + *
> + * @ccm:	3x3 correction matrix coefficients.
> + * @offsets:	1x3 correction offsets.
> + */
> +struct bcm2835_isp_ccm {
> +	struct bcm2835_isp_rational ccm[3][3];
> +	__s32 offsets[3];
> +};
> +
> +/**
> + * struct bcm2835_isp_custom_ccm - Custom CCM applied with the
> + *				   V4L2_CID_USER_BCM2835_ISP_CC_MATRIX ctrl.
> + *
> + * @enabled:	Enable custom CCM.
> + * @ccm:	Custom CCM coefficients and offsets.
> + */
> +struct bcm2835_isp_custom_ccm {
> +	__u32 enabled;
> +	struct bcm2835_isp_ccm ccm;
> +};
> +
> +/**
> + * enum bcm2835_isp_gain_format - format of the gains in the lens shading
> + *				  tables used with the
> + *				  V4L2_CID_USER_BCM2835_ISP_LENS_SHADING ctrl.
> + *
> + * @GAIN_FORMAT_U0P8_1:		Gains are u0.8 format, starting at 1.0
> + * @GAIN_FORMAT_U1P7_0:		Gains are u1.7 format, starting at 0.0
> + * @GAIN_FORMAT_U1P7_1:		Gains are u1.7 format, starting at 1.0
> + * @GAIN_FORMAT_U2P6_0:		Gains are u2.6 format, starting at 0.0
> + * @GAIN_FORMAT_U2P6_1:		Gains are u2.6 format, starting at 1.0
> + * @GAIN_FORMAT_U3P5_0:		Gains are u3.5 format, starting at 0.0
> + * @GAIN_FORMAT_U3P5_1:		Gains are u3.5 format, starting at 1.0
> + * @GAIN_FORMAT_U4P10:		Gains are u4.10 format, starting at 0.0
> + */
> +enum bcm2835_isp_gain_format {
> +	GAIN_FORMAT_U0P8_1 = 0,
> +	GAIN_FORMAT_U1P7_0 = 1,
> +	GAIN_FORMAT_U1P7_1 = 2,
> +	GAIN_FORMAT_U2P6_0 = 3,
> +	GAIN_FORMAT_U2P6_1 = 4,
> +	GAIN_FORMAT_U3P5_0 = 5,
> +	GAIN_FORMAT_U3P5_1 = 6,
> +	GAIN_FORMAT_U4P10  = 7,
> +};
> +
> +/**
> + * struct bcm2835_isp_lens_shading - Lens shading tables supplied with the
> + *				     V4L2_CID_USER_BCM2835_ISP_LENS_SHADING
> + *				     ctrl.
> + *
> + * @enabled:		Enable lens shading.
> + * @grid_cell_size:	Size of grid cells in samples (16, 32, 64, 128 or 256).
> + * @grid_width:		Width of lens shading tables in grid cells.
> + * @grid_stride:	Row to row distance (in grid cells) between grid cells
> + *			in the same horizontal location.
> + * @grid_height:	Height of lens shading tables in grid cells.
> + * @dmabuf:		dmabuf file handle containing the table.
> + * @ref_transform:	Reference transform - unsupported, please pass zero.
> + * @corner_sampled:	Whether the gains are sampled at the corner points
> + *			of the grid cells or in the cell centres.
> + * @gain_format:	Format of the gains (see enum &bcm2835_isp_gain_format).
> + */
> +struct bcm2835_isp_lens_shading {
> +	__u32 enabled;
> +	__u32 grid_cell_size;
> +	__u32 grid_width;
> +	__u32 grid_stride;
> +	__u32 grid_height;
> +	__s32 dmabuf;
> +	__u32 ref_transform;
> +	__u32 corner_sampled;
> +	__u32 gain_format;
> +};
> +
> +/**
> + * struct bcm2835_isp_black_level - Sensor black level set with the
> + *				    V4L2_CID_USER_BCM2835_ISP_BLACK_LEVEL ctrl.
> + *
> + * @enabled:		Enable black level.
> + * @black_level_r:	Black level for red channel.
> + * @black_level_g:	Black level for green channels.
> + * @black_level_b:	Black level for blue channel.
> + */
> +struct bcm2835_isp_black_level {
> +	__u32 enabled;
> +	__u16 black_level_r;
> +	__u16 black_level_g;
> +	__u16 black_level_b;
> +	__u8 padding[2]; /* Unused */
> +};
> +
> +/**
> + * struct bcm2835_isp_geq - Green equalisation parameters set with the
> + *			    V4L2_CID_USER_BCM2835_ISP_GEQ ctrl.
> + *
> + * @enabled:	Enable green equalisation.
> + * @offset:	Fixed offset of the green equalisation threshold.
> + * @slope:	Slope of the green equalisation threshold.
> + */
> +struct bcm2835_isp_geq {
> +	__u32 enabled;
> +	__u32 offset;
> +	struct bcm2835_isp_rational slope;
> +};
> +
> +#define BCM2835_NUM_GAMMA_PTS 33
> +
> +/**
> + * struct bcm2835_isp_gamma - Gamma parameters set with the
> + *			      V4L2_CID_USER_BCM2835_ISP_GAMMA ctrl.
> + *
> + * @enabled:	Enable gamma adjustment.
> + * @X:		X values of the points defining the gamma curve.
> + *		Values should be scaled to 16 bits.
> + * @Y:		Y values of the points defining the gamma curve.
> + *		Values should be scaled to 16 bits.
> + */
> +struct bcm2835_isp_gamma {
> +	__u32 enabled;
> +	__u16 x[BCM2835_NUM_GAMMA_PTS];
> +	__u16 y[BCM2835_NUM_GAMMA_PTS];
> +};
> +
> +/**
> + * struct bcm2835_isp_denoise - Denoise parameters set with the
> + *				V4L2_CID_USER_BCM2835_ISP_DENOISE ctrl.
> + *
> + * @enabled:	Enable denoise.
> + * @constant:	Fixed offset of the noise threshold.
> + * @slope:	Slope of the noise threshold.
> + * @strength:	Denoise strength between 0.0 (off) and 1.0 (maximum).
> + */
> +struct bcm2835_isp_denoise {
> +	__u32 enabled;
> +	__u32 constant;
> +	struct bcm2835_isp_rational slope;
> +	struct bcm2835_isp_rational strength;
> +};
> +
> +/**
> + * struct bcm2835_isp_sharpen - Sharpen parameters set with the
> + *				V4L2_CID_USER_BCM2835_ISP_SHARPEN ctrl.
> + *
> + * @enabled:	Enable sharpening.
> + * @threshold:	Threshold at which to start sharpening pixels.
> + * @strength:	Strength with which pixel sharpening increases.
> + * @limit:	Limit to the amount of sharpening applied.
> + */
> +struct bcm2835_isp_sharpen {
> +	__u32 enabled;
> +	struct bcm2835_isp_rational threshold;
> +	struct bcm2835_isp_rational strength;
> +	struct bcm2835_isp_rational limit;
> +};
> +
> +/**
> + * enum bcm2835_isp_dpc_mode - defective pixel correction (DPC) strength.
> + *
> + * @DPC_MODE_OFF:		No DPC.
> + * @DPC_MODE_NORMAL:		Normal DPC.
> + * @DPC_MODE_STRONG:		Strong DPC.
> + */
> +enum bcm2835_isp_dpc_mode {
> +	DPC_MODE_OFF = 0,
> +	DPC_MODE_NORMAL = 1,
> +	DPC_MODE_STRONG = 2,
> +};
> +
> +/**
> + * struct bcm2835_isp_dpc - Defective pixel correction (DPC) parameters set
> + *			    with the V4L2_CID_USER_BCM2835_ISP_DPC ctrl.
> + *
> + * @enabled:	Enable DPC.
> + * @strength:	DPC strength (see enum &bcm2835_isp_dpc_mode).
> + */
> +struct bcm2835_isp_dpc {
> +	__u32 enabled;
> +	__u32 strength;
> +};
> +
> +/*
> + * ISP statistics structures.
> + *
> + * The bcm2835_isp_stats structure is generated at the output of the
> + * statistics node.  Note that this does not directly map onto the statistics
> + * output of the ISP HW.  Instead, the MMAL firmware code maps the HW statistics
> + * to the bcm2835_isp_stats structure.
> + */
> +#define DEFAULT_AWB_REGIONS_X 16
> +#define DEFAULT_AWB_REGIONS_Y 12
> +
> +#define NUM_HISTOGRAMS 2
> +#define NUM_HISTOGRAM_BINS 128
> +#define AWB_REGIONS (DEFAULT_AWB_REGIONS_X * DEFAULT_AWB_REGIONS_Y)
> +#define FLOATING_REGIONS 16
> +#define AGC_REGIONS 16
> +#define FOCUS_REGIONS 12
> +
> +/**
> + * struct bcm2835_isp_stats_hist - Histogram statistics
> + *
> + * @r_hist:	Red channel histogram.
> + * @g_hist:	Combined green channel histogram.
> + * @b_hist:	Blue channel histogram.
> + */
> +struct bcm2835_isp_stats_hist {
> +	__u32 r_hist[NUM_HISTOGRAM_BINS];
> +	__u32 g_hist[NUM_HISTOGRAM_BINS];
> +	__u32 b_hist[NUM_HISTOGRAM_BINS];
> +};
> +
> +/**
> + * struct bcm2835_isp_stats_region - Region sums.
> + *
> + * @counted:	The number of 2x2 bayer tiles accumulated.
> + * @notcounted:	The number of 2x2 bayer tiles not accumulated.
> + * @r_sum:	Total sum of counted pixels in the red channel for a region.
> + * @g_sum:	Total sum of counted pixels in the green channel for a region.
> + * @b_sum:	Total sum of counted pixels in the blue channel for a region.
> + */
> +struct bcm2835_isp_stats_region {
> +	__u32 counted;
> +	__u32 notcounted;
> +	__u64 r_sum;
> +	__u64 g_sum;
> +	__u64 b_sum;
> +};
> +
> +/**
> + * struct bcm2835_isp_stats_focus - Focus statistics.
> + *
> + * @contrast_val:	Focus measure - accumulated output of the focus filter.
> + *			In the first dimension, index [0] counts pixels below a
> + *			preset threshold, and index [1] counts pixels above the
> + *			threshold.  In the second dimension, index [0] uses the
> + *			first predefined filter, and index [1] uses the second
> + *			predefined filter.
> + * @contrast_val_num:	The number of counted pixels in the above accumulation.
> + */
> +struct bcm2835_isp_stats_focus {
> +	__u64 contrast_val[2][2];
> +	__u32 contrast_val_num[2][2];
> +};
> +
> +/**
> + * struct bcm2835_isp_stats - ISP statistics.
> + *
> + * @version:		Version of the bcm2835_isp_stats structure.
> + * @size:		Size of the bcm2835_isp_stats structure.
> + * @hist:		Histogram statistics for the entire image.
> + * @awb_stats:		Statistics for the regions defined for AWB calculations.
> + * @floating_stats:	Statistics for arbitrarily placed (floating) regions.
> + * @agc_stats:		Statistics for the regions defined for AGC calculations.
> + * @focus_stats:	Focus filter statistics for the focus regions.
> + */
> +struct bcm2835_isp_stats {
> +	__u32 version;
> +	__u32 size;
> +	struct bcm2835_isp_stats_hist hist[NUM_HISTOGRAMS];
> +	struct bcm2835_isp_stats_region awb_stats[AWB_REGIONS];
> +	struct bcm2835_isp_stats_region floating_stats[FLOATING_REGIONS];
> +	struct bcm2835_isp_stats_region agc_stats[AGC_REGIONS];
> +	struct bcm2835_isp_stats_focus focus_stats[FOCUS_REGIONS];
> +};
> +
> +#endif /* __BCM2835_ISP_H_ */
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index b5e7d082b8ad..31606d42ec58 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -217,6 +217,7 @@ enum v4l2_colorfx {
>   * The base for Allegro driver controls.
>   * We reserve 16 controls for this driver.
>   */
> +

Unrelated change.

>  #define V4L2_CID_USER_ALLEGRO_BASE		(V4L2_CID_USER_BASE + 0x1170)
>  
>  /*
> @@ -231,6 +232,11 @@ enum v4l2_colorfx {
>   */
>  #define V4L2_CID_USER_DW100_BASE		(V4L2_CID_USER_BASE + 0x1190)
>  
> +/* The base for the bcm2835-isp driver controls.

/*
 * The base for the bcm2835-isp driver controls.

> + * We reserve 16 controls for this driver.
> + */
> +#define V4L2_CID_USER_BCM2835_ISP_BASE		(V4L2_CID_USER_BASE + 0x11a0)

This will be interesting to handle in libcamera, as it breaks the ABI
with the downstream driver.

> +
>  /* MPEG-class control IDs */
>  /* The MPEG controls are applicable to all codec controls
>   * and the 'MPEG' part of the define is historical */

-- 
Regards,

Laurent Pinchart
