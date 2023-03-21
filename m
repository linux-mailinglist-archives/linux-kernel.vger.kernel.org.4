Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FA6C2F78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCUKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCUKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEAA61B6;
        Tue, 21 Mar 2023 03:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B39E61AB6;
        Tue, 21 Mar 2023 10:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E709C433D2;
        Tue, 21 Mar 2023 10:49:05 +0000 (UTC)
Message-ID: <c4e73432-4758-6ad3-415b-80ca898c19a9@xs4all.nl>
Date:   Tue, 21 Mar 2023 11:49:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 04/10] media: Add YUV48_12 video format
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1678788305.git.ming.qian@nxp.com>
 <44bfcc0f57f0eae6d2a94914e40a902556f6eb02.1678788305.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <44bfcc0f57f0eae6d2a94914e40a902556f6eb02.1678788305.git.ming.qian@nxp.com>
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

On 14/03/2023 11:08, Ming Qian wrote:
> YUV48_12 is a YUV format with 12-bits per component like YUV24,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../media/v4l/pixfmt-packed-yuv.rst           | 28 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  1 +
>  4 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> index 24a771542059..ed998d8341ff 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> @@ -257,6 +257,34 @@ the second byte and Y'\ :sub:`7-0` in the third byte.
>      - The padding bits contain undefined values that must be ignored by all
>        applications and drivers.
>  
> +The next lists the packed YUV 4:4:4 formats with 12 bits per component.

next -> next table

> +expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,

expand -> Expand

> +arranged in little endian order. storing 1 pixels in 6 bytes.

pixels -> pixel

> +
> +.. flat-table:: Packed YUV 4:4:4 Image Formats (12bpc)
> +    :header-rows: 1
> +    :stub-columns: 0
> +
> +    * - Identifier
> +      - Code
> +      - Byte 1-0
> +      - Byte 3-2
> +      - Byte 5-4
> +      - Byte 7-6
> +      - Byte 9-8
> +      - Byte 11-10
> +
> +    * .. _V4L2-PIX-FMT-YUV48-12:
> +
> +      - ``V4L2_PIX_FMT_YUV48_12``
> +      - 'Y312'
> +
> +      - Y'\ :sub:`0`
> +      - Cb\ :sub:`0`
> +      - Cr\ :sub:`0`
> +      - Y'\ :sub:`1`
> +      - Cb\ :sub:`1`
> +      - Cr\ :sub:`1`
>  
>  4:2:2 Subsampling
>  =================
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index 21ace56fac04..da313a0637de 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -259,6 +259,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_YUV48_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>  
>  		/* YUV planar formats */
>  		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 2cb485643562..6543cda5815f 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1346,6 +1346,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
>  	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
>  	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
> +	case V4L2_PIX_FMT_YUV48_12:	descr = "12-bit Depth YUV 4:4:4"; break;

How about: "12-bit YUYV 4:4:4 Packed"

By the way, I think these existing formats:

        case V4L2_PIX_FMT_Y210:         descr = "10-bit YUYV Packed"; break;
        case V4L2_PIX_FMT_Y212:         descr = "12-bit YUYV Packed"; break;
        case V4L2_PIX_FMT_Y216:         descr = "16-bit YUYV Packed"; break;

should be renamed to "10-bit YUYV 4:2:2 Packed"

>  	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index db06d4c4f008..8a6430bc4a00 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -621,6 +621,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-8-8-8  */
>  #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
>  #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
> +#define V4L2_PIX_FMT_YUV48_12    v4l2_fourcc('Y', '3', '1', '2') /* 48  YUV 4:4:4 12-bit per component */
>  
>  /*
>   * YCbCr packed format. For each Y2xx format, xx bits of valid data occupy the MSBs

Regards,

	Hans
