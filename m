Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB716C342A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCUO0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCUOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:25:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BA5072B;
        Tue, 21 Mar 2023 07:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C881B8172F;
        Tue, 21 Mar 2023 14:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA81C433D2;
        Tue, 21 Mar 2023 14:25:11 +0000 (UTC)
Message-ID: <558a8afc-f62d-aec7-aca5-5d26471ba332@xs4all.nl>
Date:   Tue, 21 Mar 2023 15:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] media: meson: vdec: add HEVC decode codec
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Benjamin Roszak <benjamin545@gmail.com>
References: <20230314114318.4057353-1-christianshewitt@gmail.com>
 <20230314114318.4057353-3-christianshewitt@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230314114318.4057353-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 12:43, Christian Hewitt wrote:
> From: Maxime Jourdan <mjourdan@baylibre.com>
> 
> Add initial HEVC codec for the Amlogic GXBB/GXL/GXM SoCs using
> the common "HEVC" decoder driver.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> [codec alignment to upstream changes and frame handling improvements]
> Signed-off-by: Benjamin Roszak <benjamin545@gmail.com>
> ---
>  drivers/staging/media/meson/vdec/Makefile     |    2 +-
>  drivers/staging/media/meson/vdec/codec_hevc.c | 1463 +++++++++++++++++
>  drivers/staging/media/meson/vdec/codec_hevc.h |   13 +
>  drivers/staging/media/meson/vdec/esparser.c   |    3 +-
>  drivers/staging/media/meson/vdec/hevc_regs.h  |    1 +
>  .../staging/media/meson/vdec/vdec_platform.c  |   37 +
>  6 files changed, 1517 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.c
>  create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.h
> 

<snip>

> diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/staging/media/meson/vdec/vdec_platform.c
> index 88c9d72e1c83..ea2aa0e8cf0b 100644
> --- a/drivers/staging/media/meson/vdec/vdec_platform.c
> +++ b/drivers/staging/media/meson/vdec/vdec_platform.c
> @@ -11,10 +11,23 @@
>  #include "vdec_hevc.h"
>  #include "codec_mpeg12.h"
>  #include "codec_h264.h"
> +#include "codec_hevc.h"
>  #include "codec_vp9.h"
>  
>  static const struct amvdec_format vdec_formats_gxbb[] = {
>  	{
> +		.pixfmt = V4L2_PIX_FMT_HEVC,
> +		.min_buffers = 4,
> +		.max_buffers = 24,
> +		.max_width = 3840,
> +		.max_height = 2160,
> +		.vdec_ops = &vdec_hevc_ops,
> +		.codec_ops = &codec_hevc_ops,
> +		.firmware_path = "meson/vdec/gxl_hevc.bin",
> +		.pixfmts_cap = { V4L2_PIX_FMT_NV12M, 0 },
> +		.flags = V4L2_FMT_FLAG_COMPRESSED |
> +			 V4L2_FMT_FLAG_DYN_RESOLUTION,
> +	}, {
>  		.pixfmt = V4L2_PIX_FMT_H264,
>  		.min_buffers = 2,
>  		.max_buffers = 24,
> @@ -64,6 +77,18 @@ static const struct amvdec_format vdec_formats_gxl[] = {
>  		.pixfmts_cap = { V4L2_PIX_FMT_NV12M, 0 },
>  		.flags = V4L2_FMT_FLAG_COMPRESSED |
>  			 V4L2_FMT_FLAG_DYN_RESOLUTION,
> +	}, {
> +		.pixfmt = V4L2_PIX_FMT_HEVC,
> +		.min_buffers = 4,
> +		.max_buffers = 24,
> +		.max_width = 3840,
> +		.max_height = 2160,
> +		.vdec_ops = &vdec_hevc_ops,
> +		.codec_ops = &codec_hevc_ops,
> +		.firmware_path = "meson/vdec/gxl_hevc.bin",
> +		.pixfmts_cap = { V4L2_PIX_FMT_NV12M, 0 },
> +		.flags = V4L2_FMT_FLAG_COMPRESSED |
> +			 V4L2_FMT_FLAG_DYN_RESOLUTION,
>  	}, {
>  		.pixfmt = V4L2_PIX_FMT_H264,
>  		.min_buffers = 2,
> @@ -114,6 +139,18 @@ static const struct amvdec_format vdec_formats_gxm[] = {
>  		.pixfmts_cap = { V4L2_PIX_FMT_NV12M, 0 },
>  		.flags = V4L2_FMT_FLAG_COMPRESSED |
>  			 V4L2_FMT_FLAG_DYN_RESOLUTION,
> +	}, {
> +		.pixfmt = V4L2_PIX_FMT_HEVC,
> +		.min_buffers = 4,
> +		.max_buffers = 24,
> +		.max_width = 3840,
> +		.max_height = 2160,
> +		.vdec_ops = &vdec_hevc_ops,
> +		.codec_ops = &codec_hevc_ops,
> +		.firmware_path = "meson/vdec/gxl_hevc.bin",

Hmm, I don't see this firmware in any debian package. Is it made available to
linux-firmware? This actually applies to *all* meson/vdec/ firmwares.

Regards,

	Hans

> +		.pixfmts_cap = { V4L2_PIX_FMT_NV12M, 0 },
> +		.flags = V4L2_FMT_FLAG_COMPRESSED |
> +			 V4L2_FMT_FLAG_DYN_RESOLUTION,
>  	}, {
>  		.pixfmt = V4L2_PIX_FMT_H264,
>  		.min_buffers = 2,

