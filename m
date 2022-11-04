Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38576619B99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiKDP2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiKDP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:27:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D73E2E6A9;
        Fri,  4 Nov 2022 08:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12535B82EC3;
        Fri,  4 Nov 2022 15:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D9BC433D7;
        Fri,  4 Nov 2022 15:27:31 +0000 (UTC)
Message-ID: <76c3fc1b-e90f-748c-39ee-74be93fd6811@xs4all.nl>
Date:   Fri, 4 Nov 2022 16:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 10/11] media: cedrus: Adjust buffer size based on
 control values
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221102180810.267252-1-jernej.skrabec@gmail.com>
 <20221102180810.267252-11-jernej.skrabec@gmail.com>
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221102180810.267252-11-jernej.skrabec@gmail.com>
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

Hi Jernej,

On 02/11/2022 19:08, Jernej Skrabec wrote:
> In some cases decoding engine needs extra space in capture buffers. This
> is the case for decoding 10-bit HEVC frames into 8-bit capture format.
> This commit only adds infrastructure for such cases.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c       | 14 ++++++++++++++
>  drivers/staging/media/sunxi/cedrus/cedrus.h       |  2 ++
>  drivers/staging/media/sunxi/cedrus/cedrus_video.c |  4 ++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index 6a2c08928613..c36999e47591 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -68,8 +68,22 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
>  
> +static int cedrus_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct cedrus_ctx *ctx = container_of(ctrl->handler,
> +					      struct cedrus_ctx, hdl);
> +	struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> +					       V4L2_BUF_TYPE_VIDEO_CAPTURE);
> +
> +	if (!vb2_is_busy(vq) && !vb2_is_streaming(vq))

You can drop the !vb2_is_streaming part. If you are streaming, then
it will also be 'busy'.

> +		cedrus_reset_cap_format(ctx);

This is weird. I would expect that this is only called for specific controls,
since presumably not all will change the sizeimage value. It looks like
it applies only to V4L2_CID_STATELESS_HEVC_SPS, so I see no reason why
you would call cedrus_reset_cap_format() for other controls as well.

And what happens if someone makes such a change *while streaming*?
Shouldn't cedrus_try_ctrl detect that and fail with -EBUSY in that case?

Regardless, this is unexpected behavior, so some explanatory comments
would be useful.

I'm also not sure whether it isn't better to add cedrus_s_ctrl in the next
patch, I think it would be more understandable when seen with an actual
control.

Regards,

	Hans

> +
> +	return 0;
> +}
> +
>  static const struct v4l2_ctrl_ops cedrus_ctrl_ops = {
>  	.try_ctrl = cedrus_try_ctrl,
> +	.s_ctrl = cedrus_s_ctrl,
>  };
>  
>  static const struct cedrus_control cedrus_controls[] = {
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
> index 5904294f3108..774fe8048ce3 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -162,6 +162,8 @@ struct cedrus_dec_ops {
>  	int (*start)(struct cedrus_ctx *ctx);
>  	void (*stop)(struct cedrus_ctx *ctx);
>  	void (*trigger)(struct cedrus_ctx *ctx);
> +	unsigned int (*extra_cap_size)(struct cedrus_ctx *ctx,
> +				       struct v4l2_pix_format *pix_fmt);
>  };
>  
>  struct cedrus_variant {
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> index dec5d3ae4871..dc67940f1ade 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -250,6 +250,10 @@ static int cedrus_try_fmt_vid_cap_p(struct cedrus_ctx *ctx,
>  	pix_fmt->height = ctx->src_fmt.height;
>  	cedrus_prepare_format(pix_fmt);
>  
> +	if (ctx->current_codec->extra_cap_size)
> +		pix_fmt->sizeimage +=
> +			ctx->current_codec->extra_cap_size(ctx, pix_fmt);
> +
>  	return 0;
>  }
>  

