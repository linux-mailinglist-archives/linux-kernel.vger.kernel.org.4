Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0360A36F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiJXLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiJXLyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:54:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8319753B0;
        Mon, 24 Oct 2022 04:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38147B8113A;
        Mon, 24 Oct 2022 11:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C1C43143;
        Mon, 24 Oct 2022 11:38:38 +0000 (UTC)
Message-ID: <d75c0597-2323-27f2-a7e2-b319667bdcf6@xs4all.nl>
Date:   Mon, 24 Oct 2022 13:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1] media: cedrus: Propagate error code from
 cedrus_h265_skip_bits()
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220914150105.209484-1-dmitry.osipenko@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220914150105.209484-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

This patch has a conflict with this patch from Jernej:

https://patchwork.linuxtv.org/project/linux-media/patch/20221017194413.1198301-1-jernej.skrabec@gmail.com/

I decided to take Jernej's patch first. Can you make a v2 that sits on top of
that patch?

Thanks!

	Hans

On 9/14/22 17:01, Dmitry Osipenko wrote:
> The cedrus_h265_skip_bits() may get into infinite loop if decoding
> parameters are incorrect. In this case we detect the loop and print
> a error message, continuing the decoding that is fated to fail.
> 
> Will be cleaner to abort the decoding early. Propagate the error code
> to cedrus_device_run() and reset hardware on the cedrus_h265_skip_bits()
> failure.
> 
> Suggested-by: Jernej Škrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_dec.c  |  2 ++
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 15 ++++++++++++---
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c   |  7 ++++++-
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.h   |  2 ++
>  4 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> index e7f7602a5ab4..ae5df3dc01c0 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -112,6 +112,8 @@ void cedrus_device_run(void *priv)
>  
>  		dev->dec_ops[ctx->current_codec]->trigger(ctx);
>  	} else {
> +		cedrus_hw_reset(dev);
> +
>  		v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev,
>  						 ctx->fh.m2m_ctx,
>  						 VB2_BUF_STATE_ERROR);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> index 4952fc17f3e6..f409f59452d8 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -224,9 +224,10 @@ static void cedrus_h265_pred_weight_write(struct cedrus_dev *dev,
>  	}
>  }
>  
> -static void cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
> +static int cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
>  {
>  	int count = 0;
> +	int err;
>  
>  	while (count < num) {
>  		int tmp = min(num - count, 32);
> @@ -235,11 +236,16 @@ static void cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
>  			     VE_DEC_H265_TRIGGER_FLUSH_BITS |
>  			     VE_DEC_H265_TRIGGER_TYPE_N_BITS(tmp));
>  
> -		if (cedrus_wait_for(dev, VE_DEC_H265_STATUS, VE_DEC_H265_STATUS_VLD_BUSY))
> +		err = cedrus_wait_for(dev, VE_DEC_H265_STATUS, VE_DEC_H265_STATUS_VLD_BUSY);
> +		if (err) {
>  			dev_err_ratelimited(dev->dev, "timed out waiting to skip bits\n");
> +			return err;
> +		}
>  
>  		count += tmp;
>  	}
> +
> +	return 0;
>  }
>  
>  static void cedrus_h265_write_scaling_list(struct cedrus_ctx *ctx,
> @@ -408,6 +414,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	u32 pic_order_cnt[2];
>  	u8 *padding;
>  	int count;
> +	int err;
>  	u32 reg;
>  
>  	sps = run->h265.sps;
> @@ -534,7 +541,9 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	/* Include the one bit. */
>  	count++;
>  
> -	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8 - count);
> +	err = cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8 - count);
> +	if (err)
> +		return err;
>  
>  	/* Bitstream parameters. */
>  
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> index a6470a89851e..e9ceca332062 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -168,11 +168,16 @@ void cedrus_watchdog(struct work_struct *work)
>  					 VB2_BUF_STATE_ERROR);
>  }
>  
> +void cedrus_hw_reset(struct cedrus_dev *dev)
> +{
> +	reset_control_reset(dev->rstc);
> +}
> +
>  int cedrus_hw_suspend(struct device *device)
>  {
>  	struct cedrus_dev *dev = dev_get_drvdata(device);
>  
> -	reset_control_assert(dev->rstc);
> +	cedrus_hw_reset(dev);
>  
>  	clk_disable_unprepare(dev->ram_clk);
>  	clk_disable_unprepare(dev->mod_clk);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> index 7c92f00e36da..919c4475f0d7 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> @@ -30,4 +30,6 @@ void cedrus_hw_remove(struct cedrus_dev *dev);
>  
>  void cedrus_watchdog(struct work_struct *work);
>  
> +void cedrus_hw_reset(struct cedrus_dev *dev);
> +
>  #endif
