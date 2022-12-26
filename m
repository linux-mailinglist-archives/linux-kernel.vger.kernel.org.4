Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88147656547
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLZWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:15:55 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EFAE3B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:15:48 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so1973920ooi.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUckakhK2YDfWvKB+vPGRiFS4B95mA3CWPNKe4m32vE=;
        b=mfqi0fGyCtEcfB2h/+lOc7iZKAzfGRM38qDX4ixBx6F+WRrpMGqbVFFDKlrbhU/n43
         NLCfgWYoW6Qgfzk2FEQ5k685jM2noRs/BsYV7FvZ+wBZQUlgO+3dI6lfc1QlPVYbTqsF
         CS2Vt3u0VNjHymZwJUKr3B3h5khXO90bTSLjjSiG+Kk+CMdH/FWEk/0zL3Gn1rDTrEsS
         7cOTgNtjJumF1jQ7Fjnno9E15UP3FXmhjqoYqOagnTv1f6wB1eGmMUR1Ikak+ohiCnpe
         HlxnRQPbIGXd82AdCL7A1dSg3l603RFIpwz/h2qseFzJbZ+FDy0O3TCnlRQzOJlVDHA8
         vcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUckakhK2YDfWvKB+vPGRiFS4B95mA3CWPNKe4m32vE=;
        b=Txbv2UIvF4Fu/dqYJy4FpPxbVTzc154yu7KnW1vz378rXwZxf9f5L86chP2VwVGZmX
         Q59gku2p1aVJEwd6ltu7SvlQWXXKUK1Z6guF2fEv6PA9wJ2N2XnoV3F++8aXyjpPo6/m
         kO33fnDhMN6U4EnUKuyg+mbEVAczuOrnZTTPGluHy4A2cVr+HPp0/LkRGpvlhqEEp+pQ
         1VxSR2FE9TGeB7voowaf7Blr92tr2l6DHs0weYxUA9Q8KrYruV0ci3HtGxfqAomJqMIh
         vPsCTsH2OEo/va+p3OJHZS3m9DXQTix375zLX0R6+eqNzYJ06+P+DIhNePpkjKFqNzbp
         OpoA==
X-Gm-Message-State: AFqh2kobYdy6fuGkdkPGy6pxkPqJPbAfHFQJayfkOa5Erl4/bNzvm8p9
        244FTfuzXT+csRVIIjMKhyWz6z6VOHC8NAwk
X-Google-Smtp-Source: AMrXdXvn3BXZiNw7vAUdU4u5D7tsVvCvwRwrfcrB5MW9EP+EYLbjcbtJMMSMuvpr0Oy+Z35K7WzUOQ==
X-Received: by 2002:a4a:98f1:0:b0:4a5:e527:77f8 with SMTP id b46-20020a4a98f1000000b004a5e52777f8mr8283003ooj.3.1672092948116;
        Mon, 26 Dec 2022 14:15:48 -0800 (PST)
Received: from eze-laptop ([190.11.62.130])
        by smtp.gmail.com with ESMTPSA id y12-20020a4a9c0c000000b004a09df5a1dbsm4776600ooj.8.2022.12.26.14.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:15:47 -0800 (PST)
Date:   Mon, 26 Dec 2022 19:15:41 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] media: rkvdec: Add an ops to check for decode
 errors
Message-ID: <Y6odDbRNY7g+eKag@eze-laptop>
References: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
 <20221223193807.914935-2-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223193807.914935-2-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for the patch.

On Fri, Dec 23, 2022 at 02:38:03PM -0500, Nicolas Dufresne wrote:
> This optional internal ops allow each codec to do their own
> error status checking. The presence of an error is reported
> using the ERROR buffer state. This patch have no functional
> changes.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++----
>  drivers/staging/media/rkvdec/rkvdec.h |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 7bab7586918c1..7e76f8b728854 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -950,6 +950,7 @@ static void rkvdec_v4l2_cleanup(struct rkvdec_dev *rkvdec)
>  static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
>  {
>  	struct rkvdec_dev *rkvdec = priv;
> +	struct rkvdec_ctx *ctx;
>  	enum vb2_buffer_state state;
>  	u32 status;
>  
> @@ -958,12 +959,13 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
>  		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
>  
>  	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
> -	if (cancel_delayed_work(&rkvdec->watchdog_work)) {
> -		struct rkvdec_ctx *ctx;
> +	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
>  
> -		ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
> +	if (ctx->coded_fmt_desc->ops->check_error_info)
> +		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
> +
> +	if (cancel_delayed_work(&rkvdec->watchdog_work))
>  		rkvdec_job_finish(ctx, state);
> -	}
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
> index 633335ebb9c49..4ae8e6c6b03c9 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
>  		     struct vb2_v4l2_buffer *dst_buf,
>  		     enum vb2_buffer_state result);
>  	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
> +	/* called from IRQ handler */
> +	int (*check_error_info)(struct rkvdec_ctx *ctx);

I don't think it's a good idea to mix the return of this internal API
with enum vb2_buffer_state.

Please make the return type of this function a boolean or an integer
type that is decoupled from the VB2 buffer state.

Thanks!
Ezequiel

>  };
>  
>  struct rkvdec_coded_fmt_desc {
> -- 
> 2.38.1
> 
