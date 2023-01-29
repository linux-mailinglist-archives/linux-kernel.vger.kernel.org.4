Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DF367FE90
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjA2L3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2L3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:29:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A551E2B7;
        Sun, 29 Jan 2023 03:29:32 -0800 (PST)
Received: from ideasonboard.com (host-212-171-97-20.pool212171.interbusiness.it [212.171.97.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C528E327;
        Sun, 29 Jan 2023 12:29:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674991771;
        bh=fI5Fo1OzTqItExBmXaJCOk7Wu73AfLqMybxnBI02GOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaS/+I9kw4VX/OhrpS7Wgxm2xZRNxs0muLeFpeWYn/idb6ZWBqjt9QcUvjeeErmYW
         A11swFtHd+flY/j6zESMMeTtBN5w+99qdnjMtn51jV5InJcoeWh22t8CvVL0ckxwJV
         vNzmTsU4Ezg5QPHrwGrJ89613mKKdP8BcBMhzdK0=
Date:   Sun, 29 Jan 2023 12:29:27 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] media: i2c: ov2685: Add .get_selection() support
Message-ID: <20230129112927.jyx3c2hxkhwvqmyq@uno.localdomain>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
 <20230129-ov2685-improvements-v1-4-f281bd49399c@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230129-ov2685-improvements-v1-4-f281bd49399c@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca

On Sun, Jan 29, 2023 at 10:42:38AM +0100, Luca Weiss wrote:
> Add support for the .get_selection() pad operation to the ov2685 sensor
> driver.
>
> Report the native sensor size (pixel array), the crop bounds (readable
> pixel array area) and the current and default analog crop rectangles.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

As the driver supports a single mode you could have hard-coded
the rectangle sizes in get_selection(), but this way is much better as
it prepares for adding more modes to the driver eventually.

Thanks
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

> ---
>  drivers/media/i2c/ov2685.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
> index bfced11b178b..7ebf36d1a8cc 100644
> --- a/drivers/media/i2c/ov2685.c
> +++ b/drivers/media/i2c/ov2685.c
> @@ -56,6 +56,9 @@
>  #define OV2685_REG_VALUE_16BIT		2
>  #define OV2685_REG_VALUE_24BIT		3
>
> +#define OV2685_NATIVE_WIDTH		1616
> +#define OV2685_NATIVE_HEIGHT		1216
> +
>  #define OV2685_LANES			1
>  #define OV2685_BITS_PER_SAMPLE		10
>
> @@ -78,6 +81,7 @@ struct ov2685_mode {
>  	u32 exp_def;
>  	u32 hts_def;
>  	u32 vts_def;
> +	const struct v4l2_rect *analog_crop;
>  	const struct regval *reg_list;
>  };
>
> @@ -231,6 +235,13 @@ static const int ov2685_test_pattern_val[] = {
>  	OV2685_TEST_PATTERN_COLOR_SQUARE,
>  };
>
> +static const struct v4l2_rect ov2685_analog_crop = {
> +	.left	= 8,
> +	.top	= 8,
> +	.width	= 1600,
> +	.height	= 1200,
> +};
> +
>  static const struct ov2685_mode supported_modes[] = {
>  	{
>  		.width = 1600,
> @@ -238,6 +249,7 @@ static const struct ov2685_mode supported_modes[] = {
>  		.exp_def = 0x04ee,
>  		.hts_def = 0x06a4,
>  		.vts_def = 0x050e,
> +		.analog_crop = &ov2685_analog_crop,
>  		.reg_list = ov2685_1600x1200_regs,
>  	},
>  };
> @@ -384,6 +396,53 @@ static int ov2685_enum_frame_sizes(struct v4l2_subdev *sd,
>  	return 0;
>  }
>
> +static const struct v4l2_rect *
> +__ov2685_get_pad_crop(struct ov2685 *ov2685,
> +		      struct v4l2_subdev_state *state, unsigned int pad,
> +		      enum v4l2_subdev_format_whence which)
> +{
> +	const struct ov2685_mode *mode = ov2685->cur_mode;
> +
> +	switch (which) {
> +	case V4L2_SUBDEV_FORMAT_TRY:
> +		return v4l2_subdev_get_try_crop(&ov2685->subdev, state, pad);
> +	case V4L2_SUBDEV_FORMAT_ACTIVE:
> +		return mode->analog_crop;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int ov2685_get_selection(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *sd_state,
> +				struct v4l2_subdev_selection *sel)
> +{
> +	struct ov2685 *ov2685 = to_ov2685(sd);
> +
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_CROP:
> +		mutex_lock(&ov2685->mutex);
> +		sel->r = *__ov2685_get_pad_crop(ov2685, sd_state, sel->pad,
> +				sel->which);
> +		mutex_unlock(&ov2685->mutex);
> +		break;
> +	case V4L2_SEL_TGT_NATIVE_SIZE:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = OV2685_NATIVE_WIDTH;
> +		sel->r.height = OV2685_NATIVE_HEIGHT;
> +		break;
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +		sel->r = ov2685_analog_crop;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /* Calculate the delay in us by clock rate and clock cycles */
>  static inline u32 ov2685_cal_delay(u32 cycles)
>  {
> @@ -592,6 +651,8 @@ static const struct v4l2_subdev_pad_ops ov2685_pad_ops = {
>  	.enum_frame_size = ov2685_enum_frame_sizes,
>  	.get_fmt = ov2685_get_fmt,
>  	.set_fmt = ov2685_set_fmt,
> +	.get_selection = ov2685_get_selection,
> +	.set_selection = ov2685_get_selection,
>  };
>
>  static const struct v4l2_subdev_ops ov2685_subdev_ops = {
>
> --
> 2.39.1
>
