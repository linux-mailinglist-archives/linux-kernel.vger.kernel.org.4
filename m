Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0765870A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 22:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiL1V10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 16:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL1V1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 16:27:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B543C140B4;
        Wed, 28 Dec 2022 13:27:18 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00D65109;
        Wed, 28 Dec 2022 22:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672262836;
        bh=sp2ZBB6P279b00k8+UwmXpA6Hm9xy8NUgh+Jr/+0/uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQ2+f64EH8lFWaBxwtHVGK154e2FTIKrvuMvgSb5Z2okoo5DPwieKwZFzSs70IXiO
         /sShwWs/jk2Md1WsZCkIa5X9bHoZMMpa/kRMazfVX5MQEgA1klbMK/U6TvatttHkdl
         dgHp2q+KRh/Bpd86b0GUdNwMTks+jxqaeageqkyY=
Date:   Wed, 28 Dec 2022 23:27:11 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tanmay Bhushan <007047221b@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: media: omap4iss: Fix null dereference
 for iss
Message-ID: <Y6y0r9fPnfWvwlua@pendragon.ideasonboard.com>
References: <7f4fe87ef8a9995bc2c64bf2e5a03ef6948b8692.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f4fe87ef8a9995bc2c64bf2e5a03ef6948b8692.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

Thank you for the patch.

On Wed, Dec 28, 2022 at 09:58:31PM +0100, Tanmay Bhushan wrote:
> From 7aa39c0d02bddf9cfa14762f115303b79bfa0ae3 Mon Sep 17 00:00:00 2001
> From: Tanmay Bhushan <007047221b@gmail.com>
> Date: Wed, 28 Dec 2022 21:01:16 +0100
> Subject: [PATCH] media: staging: media: omap4iss: Fix null dereference
> for iss
> 
> media_pad_remote_pad_first returns NULL in some cases but while using
> the return value was used without NULL check which will lead to panic
> in case of NULL return. iss_pipeline_is_last returns value check so
> have returned 0 in case of NULL and csi2_configure is not documented
> for such cases so returned EINVAL for it. Code is not tested
> as it is only for NULL dereference verification.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
> ---
>  drivers/staging/media/omap4iss/iss.c      | 6 +++++-
>  drivers/staging/media/omap4iss/iss_csi2.c | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/omap4iss/iss.c
> b/drivers/staging/media/omap4iss/iss.c
> index fa2a36d829d3..3f01eeff40e7 100644
> --- a/drivers/staging/media/omap4iss/iss.c
> +++ b/drivers/staging/media/omap4iss/iss.c
> @@ -552,7 +552,11 @@ static int iss_pipeline_is_last(struct
> media_entity *me)

Your mail client wrapped lines, which prevents the patch from being
applied with git-am. I recommend using git-send-email to send patches.
https://git-send-email.io/ provides clear and detailed instructions on
how to set it up (especially when using gmail).

>  	if (!pipe || pipe->stream_state ==
> ISS_PIPELINE_STREAM_STOPPED)
>  		return 0;
>  	pad = media_pad_remote_pad_first(&pipe->output->pad);
> -	return pad->entity == me;

Have you seen this actually crashing, or are you only speculating ? The
video node at the output of the pipeline should always be connected, so
I don't think media_pad_remote_pad_first() can ever return NULL here.

> +
> +	if (pad)
> +		return pad->entity == me;
> +
> +	return 0;
>  }
>  
>  static int iss_reset(struct iss_device *iss)
> diff --git a/drivers/staging/media/omap4iss/iss_csi2.c
> b/drivers/staging/media/omap4iss/iss_csi2.c
> index 04ce0e7eb557..ab2c2ad64464 100644
> --- a/drivers/staging/media/omap4iss/iss_csi2.c
> +++ b/drivers/staging/media/omap4iss/iss_csi2.c
> @@ -539,6 +539,10 @@ static int csi2_configure(struct iss_csi2_device
> *csi2)
>  		return -EBUSY;
>  
>  	pad = media_pad_remote_pad_first(&csi2->pads[CSI2_PAD_SINK]);
> +
> +	if (!pad)
> +		return -EINVAL;

Same here, what makes you think this is possible ?

> +
>  	sensor = media_entity_to_v4l2_subdev(pad->entity);
>  	pdata = sensor->host_priv;
>  
> 

-- 
Regards,

Laurent Pinchart
