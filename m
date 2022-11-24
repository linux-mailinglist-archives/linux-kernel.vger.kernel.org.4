Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DDE6376A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKXKmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKXKmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:42:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D293E0A0;
        Thu, 24 Nov 2022 02:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82775B8274B;
        Thu, 24 Nov 2022 10:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4626C433D6;
        Thu, 24 Nov 2022 10:42:29 +0000 (UTC)
Message-ID: <15ba9b9e-f3f6-7f30-c200-d7c9593a4735@xs4all.nl>
Date:   Thu, 24 Nov 2022 11:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_HEADERS_ONLY flag
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>
References: <20220712093754.23370-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220712093754.23370-1-ming.qian@nxp.com>
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

+CC Nicolas and Tomasz.

I would like some feedback for this patch.

On 12/07/2022 11:37, Ming Qian wrote:
> By setting the V4L2_BUF_FLAG_HEADERS_ONLY flag,
> hint the vb2 only contains stream header,
> but does not contain any frame data.
> 
> This flag needs to be used when header mode is set to
> V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  Documentation/userspace-api/media/v4l/buffer.rst      | 11 +++++++++++
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 10 +++++++---
>  include/uapi/linux/videodev2.h                        |  2 ++
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
> index 4638ec64db00..18a6f5fcc822 100644
> --- a/Documentation/userspace-api/media/v4l/buffer.rst
> +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> @@ -607,6 +607,17 @@ Buffer Flags
>  	the format. Any subsequent call to the
>  	:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
>  	but return an ``EPIPE`` error code.
> +    * .. _`V4L2-BUF-FLAG-HEADERS-ONLY`:
> +
> +      - ``V4L2_BUF_FLAG_HEADERS_ONLY``
> +      - 0x00200000
> +      - This flag may be set when the buffer only contains codec

Set by the driver or userspace? Or either, depending on whether it is
an encoder or decoder?

codec -> the codec

> +	header, but does not contain any frame data. Usually the codec
> +	header is merged to the next idr frame, with the flag

to -> with
idr -> IDR

> +	``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes that will

is -> are

scenes: do you mean 'scenarios'?

> +	split the header and queue it separately. This flag can set only when

"split the header and queue it separately" -> queue the header in a separate buffer

can -> can be

> +	codec support V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,

codec -> the codec
support -> supports

> +	and the header mode is set to V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE
>      * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
>  
>        - ``V4L2_BUF_FLAG_REQUEST_FD``
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 6183f43f4d73..478b6af4205d 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -1386,8 +1386,12 @@ enum v4l2_mpeg_video_intra_refresh_period_type -
>      (enum)
>  
>  enum v4l2_mpeg_video_header_mode -
> -    Determines whether the header is returned as the first buffer or is
> -    it returned together with the first frame. Applicable to encoders.
> +    Determines whether the header is returned as the first buffer
> +    with flag V4L2_BUF_FLAG_HEADERS_ONLY or is

or is it -> or if it is

> +    it returned together with the first frame.
> +    Applicable to encoders and decoders.
> +    If it's not implemented in a driver,
> +    V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME is to be assumed,
>      Possible values are:
>  
>  .. raw:: latex
> @@ -1401,7 +1405,7 @@ enum v4l2_mpeg_video_header_mode -
>      :stub-columns: 0
>  
>      * - ``V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE``
> -      - The stream header is returned separately in the first buffer.
> +      - The stream header is returned separately in the first buffer with the flag V4L2_BUF_FLAG_HEADERS_ONLY.
>      * - ``V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME``
>        - The stream header is returned together with the first encoded
>  	frame.
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 5311ac4fde35..6fd96acd6080 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -1131,6 +1131,8 @@ static inline __u64 v4l2_timeval_to_ns(const struct timeval *tv)
>  #define V4L2_BUF_FLAG_TSTAMP_SRC_SOE		0x00010000
>  /* mem2mem encoder/decoder */
>  #define V4L2_BUF_FLAG_LAST			0x00100000
> +/* Buffer only contains codec header */

codec -> the codec

> +#define V4L2_BUF_FLAG_HEADERS_ONLY		0x00200000
>  /* request_fd is valid */
>  #define V4L2_BUF_FLAG_REQUEST_FD		0x00800000
>  

Of course, there needs to be a driver that uses this as well. And drivers that support
V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE would need to add support for this flag as well,
I guess.

And what I haven't seen here is *why* you need this flag. There are already drivers that
support V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE, and they managed fine without it.

Regards,

	Hans
