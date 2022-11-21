Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37CC6330DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiKUXni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiKUXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:42:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0600AE0DC9;
        Mon, 21 Nov 2022 15:41:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2322788F;
        Tue, 22 Nov 2022 00:41:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669074096;
        bh=OsNzWOxt+1Uz9pblEiTC7lBWE1dWJGL9cCym66ao+hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSYxu68Bxi+i6zA2IBtJTdyNSgC0QbSR4M/jE4FDeatfguQNWpW/e5l8ysyKLwagi
         qm4CIZU/Dt1P7hV3Wzymz4NWWtinO9DHg33OD5e+dVVePLMzJH/58FnjkXkH7t9jRS
         zb8qd3rPQ3qx2kNM42eps2A/QcP3kQeRt66HXCdg=
Date:   Tue, 22 Nov 2022 01:41:21 +0200
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
Subject: Re: [PATCH 13/14] docs: admin-guide: media: bcm2835-isp: Add
 documentation for bcm2835-isp
Message-ID: <Y3wMof/ERK7ZBINW@pendragon.ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <20221121214722.22563-14-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121214722.22563-14-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang and Naush,

Thank you for the patch.

On Tue, Nov 22, 2022 at 03:17:21AM +0530, Umang Jain wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> Document device nodes, frame buffer formats and initial set of
> configuraiton that can be set from userspace to configure the pipeline.

s/configuraiton/configuration/

> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../admin-guide/media/bcm2835-isp.rst         | 127 ++++++++++++++++++
>  .../userspace-api/media/drivers/index.rst     |   1 +
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/admin-guide/media/bcm2835-isp.rst
> 
> diff --git a/Documentation/admin-guide/media/bcm2835-isp.rst b/Documentation/admin-guide/media/bcm2835-isp.rst
> new file mode 100644
> index 000000000000..e1c19f78435e
> --- /dev/null
> +++ b/Documentation/admin-guide/media/bcm2835-isp.rst
> @@ -0,0 +1,127 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +BCM2835 ISP Driver
> +==================
> +
> +Introduction
> +------------
> +
> +The BCM2835 Image Sensor Pipeline (ISP) is a fixed function hardware pipeline
> +for performing image processing operations.  Images are fed to the input
> +of the ISP through memory frame buffers.  These images may be in various YUV,
> +RGB, or Bayer formats.

Does the ISP really support RGB or YUV input images ? Is this supported
by the driver ?

> A typical use case would have Bayer images obtained from
> +an image sensor by the BCM2835 Unicam peripheral, written to a memory
> +frame buffer, and finally fed into the input of the ISP.  Two concurrent output
> +images may be generated in YUV or RGB format at different resolutions.
> +Statistics output is also generated for Bayer input images.
> +
> +The bcm2835-isp driver exposes the following media pads as V4L2 device nodes:

This sounds weird. Pads are not video nodes, are they ? Or are those
MMAL pads ?

> +
> +.. tabularcolumns:: |l|l|l|l|
> +
> +.. cssclass: longtable
> +
> +.. flat-table::
> +
> +    * - *Pad*
> +      - *Direction*
> +      - *Purpose*
> +      - *Formats*
> +
> +    * - "bcm2835-isp0-output0"
> +      - sink
> +      - Accepts Bayer, RGB or YUV format frame buffers as input to the ISP HW
> +        pipeline.
> +      - :ref:`RAW8 <V4L2-PIX-FMT-SRGGB8>`,
> +        :ref:`RAW10P <V4L2-PIX-FMT-SRGGB10P>`,
> +        :ref:`RAW12P <V4L2-PIX-FMT-SRGGB12P>`,
> +        :ref:`RAW14P <V4L2-PIX-FMT-SRGGB14P>`,
> +        :ref:`RAW16 <V4L2-PIX-FMT-SRGGB16>`,
> +        :ref:`RGB24/BGR24 <V4L2-PIX-FMT-RGB24>`,
> +        :ref:`YUYV <V4L2-PIX-FMT-YUYV>`,
> +        :ref:`YVYU <V4L2-PIX-FMT-YVYU>`,
> +        :ref:`UYVY <V4L2-PIX-FMT-UYVY>`,
> +        :ref:`VYUY <V4L2-PIX-FMT-VYUY>`,
> +        :ref:`YUV420/YVU420 <V4L2-PIX-FMT-YUV420>`
> +
> +    * - "bcm2835-isp0-capture1"
> +      - source
> +      - High resolution YUV or RGB processed output from the ISP.
> +      - :ref:`RGB565 <V4L2-PIX-FMT-RGB565>`,
> +        :ref:`RGB24/BGR24 <V4L2-PIX-FMT-RGB24>`,
> +        :ref:`ABGR32 <V4L2-PIX-FMT-ABGR32>`,
> +        :ref:`YUYV <V4L2-PIX-FMT-YUYV>`,
> +        :ref:`YVYU <V4L2-PIX-FMT-YVYU>`,
> +        :ref:`UYVY <V4L2-PIX-FMT-UYVY>`,
> +        :ref:`VYUY <V4L2-PIX-FMT-VYUY>`.
> +        :ref:`YUV420/YVU420 <V4L2-PIX-FMT-YUV420>`,
> +        :ref:`NV12/NV21 <V4L2-PIX-FMT-NV12>`,
> +
> +    * - "bcm2835-isp0-capture2"
> +      - source
> +      - Low resolution YUV processed output from the ISP. The output of
> +        this pad cannot have a resolution larger than the "bcm2835-isp0-capture1" pad in any dimension.
> +      - :ref:`YUYV <V4L2-PIX-FMT-YUYV>`,
> +        :ref:`YVYU <V4L2-PIX-FMT-YVYU>`,
> +        :ref:`UYVY <V4L2-PIX-FMT-UYVY>`,
> +        :ref:`VYUY <V4L2-PIX-FMT-VYUY>`.
> +        :ref:`YUV420/YVU420 <V4L2-PIX-FMT-YUV420>`,
> +        :ref:`NV12/NV21 <V4L2-PIX-FMT-NV12>`,
> +
> +    * - "bcm2835-isp0-capture1"

Is that capture3 ?

Maybe the video nodes should be renamed to make their purpose clearer ?

> +      - source
> +      - Image statistics calculated from the input image provided on the
> +        "bcm2835-isp0-output0" pad.  Statistics are only available for Bayer
> +        format input images.
> +      - :ref:`v4l2-meta-fmt-bcm2835-isp-stats`.
> +
> +Pipeline Configuration
> +----------------------
> +
> +The ISP pipeline can be configure through user-space by calling
> +:ref:`VIDIOC_S_EXT_CTRLS <VIDIOC_G_EXT_CTRLS>` on the “bcm2835-isp0-output0”
> +node with the appropriate parameters as shown in the table below.
> +
> +.. tabularcolumns:: |p{2cm}|p{5.0cm}|
> +
> +.. cssclass: longtable
> +
> +.. flat-table::
> +
> +    * - *id*
> +      - *Parameter*
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_CC_MATRIX``
> +      - struct :c:type:`bcm2835_isp_custom_ccm`
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_LENS_SHADING``
> +      - struct :c:type:`bcm2835_isp_lens_shading`
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_BLACK_LEVEL``
> +      - struct :c:type:`bcm2835_isp_black_level`
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_GEQ``
> +      - struct :c:type:`bcm2835_isp_geq`
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_GAMMA``
> +      - struct :c:type:`bcm2835_isp_gamma`
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_DENOISE``
> +      - struct :c:type:`bcm2835_isp_denoise`
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_SHARPEN``
> +      - struct :c:type:`bcm2835_isp_sharpen`
> +
> +    * - ``V4L2_CID_USER_BCM2835_ISP_DPC``
> +      - struct :c:type:`bcm2835_isp_dpc`
> +
> +++++++++++++++++++++++++
> +Configuration Parameters
> +++++++++++++++++++++++++
> +
> +.. kernel-doc:: include/uapi/linux/bcm2835-isp.h
> +   :functions: bcm2835_isp_rational bcm2835_isp_ccm bcm2835_isp_custom_ccm
> +                bcm2835_isp_gain_format bcm2835_isp_lens_shading
> +                bcm2835_isp_black_level bcm2835_isp_geq bcm2835_isp_gamma
> +                bcm2835_isp_denoise bcm2835_isp_sharpen
> +                bcm2835_isp_dpc_mode bcm2835_isp_dpc
> diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
> index 32f82aed47d9..34e0d7102ef0 100644
> --- a/Documentation/userspace-api/media/drivers/index.rst
> +++ b/Documentation/userspace-api/media/drivers/index.rst
> @@ -31,6 +31,7 @@ For more details see the file COPYING in the source distribution of Linux.
>  	:maxdepth: 5
>  	:numbered:
>  
> +	bcm2835-isp
>  	ccs
>  	cx2341x-uapi
>  	dw100

-- 
Regards,

Laurent Pinchart
