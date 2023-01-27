Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6F67E84D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjA0Obr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjA0Obo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:31:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E403DFF0E;
        Fri, 27 Jan 2023 06:31:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 878D561CBB;
        Fri, 27 Jan 2023 14:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5282C433EF;
        Fri, 27 Jan 2023 14:31:32 +0000 (UTC)
Message-ID: <05bfc909-1ebb-b74f-dcdd-adc70dd97f3e@xs4all.nl>
Date:   Fri, 27 Jan 2023 15:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 01/10] media: Add P012 and P012M video format
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1671071730.git.ming.qian@nxp.com>
 <dfaef3c8eb29108b1837a1959d598c8b0db63422.1671071730.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <dfaef3c8eb29108b1837a1959d598c8b0db63422.1671071730.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 04:11, Ming Qian wrote:
> P012 is a YUV format with 12-bits per component with interleaved UV,
> like NV12, expanded to 16 bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.
> And P012M has two non contiguous planes.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../media/v4l/pixfmt-yuv-planar.rst           | 94 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  2 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
>  include/uapi/linux/videodev2.h                |  2 +
>  4 files changed, 100 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index f1d5bb7b806d..aa37c3de8808 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -123,6 +123,20 @@ All components are stored with the same number of bits per component.
>        - Cb, Cr
>        - Yes
>        - 4x4 tiles
> +    * - V4L2_PIX_FMT_P012
> +      - 'P012'
> +      - 12
> +      - 4:2:0
> +      - Cb, Cr
> +      - Yes
> +      - Linear
> +    * - V4L2_PIX_FMT_P012M
> +      - 'PM12'
> +      - 12
> +      - 4:2:0
> +      - Cb, Cr
> +      - Yes
> +      - Linear
>      * - V4L2_PIX_FMT_NV16
>        - 'NV16'
>        - 8
> @@ -586,6 +600,86 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
>        - Cb\ :sub:`11`
>        - Cr\ :sub:`11`
>  
> +.. _V4L2-PIX-FMT-P012:
> +.. _V4L2-PIX-FMT-P012M:
> +
> +P012 and P012M
> +--------------
> +
> +P012 is like NV12 with 12 bits per component, expanded to 16 bits.
> +Data in the 12 high bits, zeros in the 4 low bits, arranged in little endian order.
> +
> +.. flat-table:: Sample 4x4 P012 Image
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - start + 0:
> +      - Y'\ :sub:`00`
> +      - Y'\ :sub:`01`
> +      - Y'\ :sub:`02`
> +      - Y'\ :sub:`03`
> +    * - start + 8:
> +      - Y'\ :sub:`10`
> +      - Y'\ :sub:`11`
> +      - Y'\ :sub:`12`
> +      - Y'\ :sub:`13`
> +    * - start + 16:
> +      - Y'\ :sub:`20`
> +      - Y'\ :sub:`21`
> +      - Y'\ :sub:`22`
> +      - Y'\ :sub:`23`
> +    * - start + 24:
> +      - Y'\ :sub:`30`
> +      - Y'\ :sub:`31`
> +      - Y'\ :sub:`32`
> +      - Y'\ :sub:`33`
> +    * - start + 32:
> +      - Cb\ :sub:`00`
> +      - Cr\ :sub:`00`
> +      - Cb\ :sub:`01`
> +      - Cr\ :sub:`01`
> +    * - start + 40:
> +      - Cb\ :sub:`10`
> +      - Cr\ :sub:`10`
> +      - Cb\ :sub:`11`
> +      - Cr\ :sub:`11`
> +
> +.. flat-table:: Sample 4x4 P012M Image
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - start0 + 0:
> +      - Y'\ :sub:`00`
> +      - Y'\ :sub:`01`
> +      - Y'\ :sub:`02`
> +      - Y'\ :sub:`03`
> +    * - start0 + 8:
> +      - Y'\ :sub:`10`
> +      - Y'\ :sub:`11`
> +      - Y'\ :sub:`12`
> +      - Y'\ :sub:`13`
> +    * - start0 + 16:
> +      - Y'\ :sub:`20`
> +      - Y'\ :sub:`21`
> +      - Y'\ :sub:`22`
> +      - Y'\ :sub:`23`
> +    * - start0 + 24:
> +      - Y'\ :sub:`30`
> +      - Y'\ :sub:`31`
> +      - Y'\ :sub:`32`
> +      - Y'\ :sub:`33`
> +    * -
> +    * - start1 + 0:
> +      - Cb\ :sub:`00`
> +      - Cr\ :sub:`00`
> +      - Cb\ :sub:`01`
> +      - Cr\ :sub:`01`
> +    * - start1 + 8:
> +      - Cb\ :sub:`10`
> +      - Cr\ :sub:`10`
> +      - Cb\ :sub:`11`
> +      - Cr\ :sub:`11`
> +
>  
>  Fully Planar YUV Formats
>  ========================
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index 40f56e044640..a5e8ba370d33 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -267,6 +267,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_P012,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>  
>  		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
>  		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
> @@ -292,6 +293,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		{ .format = V4L2_PIX_FMT_NV21M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>  		{ .format = V4L2_PIX_FMT_NV16M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV61M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_P012M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>  
>  		/* Bayer RGB formats */
>  		{ .format = V4L2_PIX_FMT_SBGGR8,	.pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 8e0a0ff62a70..067dbdd0a9ef 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1348,6 +1348,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV24:		descr = "Y/UV 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV42:		descr = "Y/VU 4:4:4"; break;
>  	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/UV 4:2:0"; break;
> +	case V4L2_PIX_FMT_P012:		descr = "12-bit Y/UV 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
> @@ -1358,6 +1359,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV61M:	descr = "Y/VU 4:2:2 (N-C)"; break;
>  	case V4L2_PIX_FMT_NV12MT:	descr = "Y/UV 4:2:0 (64x32 MB, N-C)"; break;
>  	case V4L2_PIX_FMT_NV12MT_16X16:	descr = "Y/UV 4:2:0 (16x16 MB, N-C)"; break;
> +	case V4L2_PIX_FMT_P012M:	descr = "12-bit Y/UV 4:2:0 (N-C)"; break;
>  	case V4L2_PIX_FMT_YUV420M:	descr = "Planar YUV 4:2:0 (N-C)"; break;
>  	case V4L2_PIX_FMT_YVU420M:	descr = "Planar YVU 4:2:0 (N-C)"; break;
>  	case V4L2_PIX_FMT_YUV422M:	descr = "Planar YUV 4:2:2 (N-C)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 1befd181a4cc..5448aa3b7858 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -626,12 +626,14 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
>  #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
>  #define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 4:2:0 10-bit per component */
> +#define V4L2_PIX_FMT_P012    v4l2_fourcc('P', '0', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */
>  
>  /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */
>  #define V4L2_PIX_FMT_NV21M   v4l2_fourcc('N', 'M', '2', '1') /* 21  Y/CrCb 4:2:0  */
>  #define V4L2_PIX_FMT_NV16M   v4l2_fourcc('N', 'M', '1', '6') /* 16  Y/CbCr 4:2:2  */
>  #define V4L2_PIX_FMT_NV61M   v4l2_fourcc('N', 'M', '6', '1') /* 16  Y/CrCb 4:2:2  */
> +#define V4L2_PIX_FMT_P012M   v4l2_fourcc('P', 'M', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */

The name of the V4L2_PIX_FMT_ defines in this series are hard to decode.

In this case is it derived from V4L2_PIX_FMT_P010, which really should have been
named differently, but it's too late now :-(

So I guess we'll stick with this naming, but it's not obvious what 'P012' means
without referring to documentation.

Oh well.

Regards,

	Hans

>  
>  /* three planes - Y Cb, Cr */
>  #define V4L2_PIX_FMT_YUV410  v4l2_fourcc('Y', 'U', 'V', '9') /*  9  YUV 4:1:0     */

