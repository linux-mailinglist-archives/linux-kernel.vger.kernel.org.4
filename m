Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91D65652A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 22:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiLZVdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 16:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiLZVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 16:33:13 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E112606
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 13:33:13 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id l8-20020a056830054800b006705fd35eceso7218117otb.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPYczn0YGxyfNylm4RLYqULvGhb7tE5TBnYQ9n6+TQ4=;
        b=AksfF9rvGEGSGLbDaaP6t5xxNTpfhEGpVd3JMBSIRegbAz/dfcVugjaH2mjpHCpZ2i
         9w7FouGC76y4iCb26O4IHP0MfsorGXNYHVbAcPz7spQ3tdOZjpUWMWfNbjHaR6cNDTr2
         SCJtmr1RMUwrTcxHwq7/h1dpd7IV+K5ej3d5lxF1EYatDtcPrPcauzxLHX/FkYXNNo2R
         1UACmCr90iFk2SV6A2cQivaLkcYldkvBD34FOsweQzB013L5S5ytJsytmreV0mra4CJD
         aKklfo53h/HNjFNBGGrjhvvlqunfRk+BLrXAHW7j/UtB7TVy3xdWevKtIxdJLvBHQPdC
         nYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPYczn0YGxyfNylm4RLYqULvGhb7tE5TBnYQ9n6+TQ4=;
        b=eAvGXBLHOhIuVcZr9mMSQsC6vE3D0os74UrfanOc+UZ22kzLWJgN28tKe8hWVFQvg0
         5I1a/kYLgW+yQHhmcDYvEWaI3fZjbHR4Kr27Wga8GAQfla/44VvGOjuoS48M/Dxz9iGK
         XX3bwNgZhBBGOxDmFpg+eO/Z2jrgXmmXJQj9s4cs5z6hOd/ZKfA0AQyDanNBel/OcjTB
         qe/1i1tNl3jzE8mOQoqmy9AVoGDzGWM8ESvS1LQ0cNf9g4Hvl0Hmp9mi2j2loLCqnqKc
         MfN/16moAsEjQ9W91FnZc9b4BPl0mn9egxEeaZYzT+lUkZeSeKQzkSt/BS22O0Sn9HuR
         6dyg==
X-Gm-Message-State: AFqh2ko7p6HNwbxAoYrCNRCJkQ/bz+rnT8peMupeFq3f/0n9prb+6MI+
        Sphc62xGbW8Ooi8Q8x5g+XLpyA==
X-Google-Smtp-Source: AMrXdXtbaYC6Pk3YNeTADhvjliJr+F/irr0Zz4Tu6hOtJpg+1rzAw3f3gGvqqvdT8BmFU1k7BUXTJA==
X-Received: by 2002:a05:6830:1b66:b0:670:51ea:f267 with SMTP id d6-20020a0568301b6600b0067051eaf267mr12068785ote.37.1672090392387;
        Mon, 26 Dec 2022 13:33:12 -0800 (PST)
Received: from eze-laptop ([190.11.62.130])
        by smtp.gmail.com with ESMTPSA id bi15-20020a056830378f00b00683e80b5ca7sm1627159otb.38.2022.12.26.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 13:33:11 -0800 (PST)
Date:   Mon, 26 Dec 2022 18:33:06 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] media: rkvdec: Re-enable H.264 error detection
Message-ID: <Y6oTEkEwuGISwr+z@eze-laptop>
References: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
 <20221223193807.914935-4-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223193807.914935-4-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

I'm still unsure about this patchset.
It sounds like a good approach and a nice
improvement, but I want to make sure I think through it.

Meanwhile, a small comment...

On Fri, Dec 23, 2022 at 02:38:05PM -0500, Nicolas Dufresne wrote:
> This re-enable H.264 error detection, but using the other error mode.
> In that mode, the decoder will skip over the error macro-block or
> slices and complete the decoding. As a side effect, the error status
> is not set in the interrupt status register, and instead errors are
> detected per format. Using this mode workaround the issue that the
> HW get stuck in error state, and allow reporting that some corruption
> may be present in the buffer to userland.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 4fc167b42cf0c..dfe3e235f099a 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1162,14 +1162,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>  
>  	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
>  
> -	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> -	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
>  	writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
>  	writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
>  
>  	/* Start decoding! */
>  	writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
> -	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
> +	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
> +	       RKVDEC_H264ORVP9_ERR_MODE,
>  	       rkvdec->regs + RKVDEC_REG_INTERRUPT);
>  
>  	return 0;
> @@ -1183,10 +1184,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
>  
> +static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
> +{
> +	struct rkvdec_dev *rkvdec = ctx->dev;
> +	int err;
> +
> +	err = readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
> +	if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
> +		pr_debug("Decoded picture have %i/%i slices with errors.\n",

... still uses pr_debug. I would change it so it uses v4l2_dbg,
and can be controlled using the same debug parameter
as you use in patch 4/4.

> +			 RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(err));
> +		return VB2_BUF_STATE_ERROR;
> +	}
> +
> +	return VB2_BUF_STATE_DONE;
> +}
> +
>  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
>  	.adjust_fmt = rkvdec_h264_adjust_fmt,
>  	.start = rkvdec_h264_start,
>  	.stop = rkvdec_h264_stop,
>  	.run = rkvdec_h264_run,
>  	.try_ctrl = rkvdec_h264_try_ctrl,
> +	.check_error_info = rkvdec_h264_check_error_info,
>  };
> -- 
> 2.38.1
> 
