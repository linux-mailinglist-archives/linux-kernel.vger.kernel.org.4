Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715D365590F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiLXIEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXIEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:04:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30CF2606;
        Sat, 24 Dec 2022 00:04:03 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:9071:5495:b8e6:e417] (unknown [IPv6:2a01:e0a:120:3210:9071:5495:b8e6:e417])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 116216602CE4;
        Sat, 24 Dec 2022 08:04:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671869041;
        bh=gwiI8vPLAipPEAg6suP/Gdgsidzj+89aU3MlnmFb6CI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fudwGN1x/TMpFiYZC3wdz3auwHOAy9z/AbFYWiGILCgmSIFO6lQOvhTqFGHu54D2B
         h84fruUR8owRI43OQx6xmLr4ss9+Me0O0gZvTrdMzrCffz4E9BSk7O/oqC4NcrfqUl
         9g6EtkBgY8cDBaBhQFtXdElBNrb7GgV7jjEdK3UsJb5ttPf/WMmOwNlZ29swZIgSVC
         wQyz25uUHNahL5Ov0ONvcQ+4ESsyaR5R9HyHvme7OC5PLS9XT/Lu5MsN9iw+Ec6quZ
         z3gBAL+AZtV8DAuaXhH7HLL8yjag6NxFPdVST6ntOkMUEEN8NWDsFCAjDMcdq846hM
         5qEtr/gIrZjtA==
Message-ID: <8d13ffb9-74cb-00f9-072a-0614e341e1ef@collabora.com>
Date:   Sat, 24 Dec 2022 09:03:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] hantro: Fix JPEG encoder ENUM_FRMSIZE on RK3399
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Robert Mader <robert.mader@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221223181647.720918-1-nicolas.dufresne@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20221223181647.720918-1-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 23/12/2022 à 19:16, Nicolas Dufresne a écrit :
> Since 79c987de8b354, enumerating framesize on format set with "MODE_NONE"
> (any raw formats) is reporting an invalid frmsize.
>
>    Size: Stepwise 0x0 - 0x0 with step 0/0
>
> Before this change, the driver would return EINVAL, which is also invalid but
> worked in GStreamer. The original intent was not to implement it, hence the
> -ENOTTY return in this change. While drivers should implement ENUM_FRMSIZE for
> all formats and queues, this change is limited in scope to fix the regression.
>
> This fixes taking picture in Gnome Cheese software, or any software using
> GSteamer to encode JPEG with hardware acceleration.
>
> Fixes: 79c987de8b354 ("media: hantro: Use post processor scaling capacities")
> Reported-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/media/platform/verisilicon/hantro_v4l2.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7b..30e650edaea8a 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -161,8 +161,11 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
>   	}
>   
>   	/* For non-coded formats check if postprocessing scaling is possible */
> -	if (fmt->codec_mode == HANTRO_MODE_NONE && hantro_needs_postproc(ctx, fmt)) {
> -		return hanto_postproc_enum_framesizes(ctx, fsize);
> +	if (fmt->codec_mode == HANTRO_MODE_NONE) {
> +		if (hantro_needs_postproc(ctx, fmt))
> +			return hanto_postproc_enum_framesizes(ctx, fsize);
> +		else
> +			return -ENOTTY;
>   	} else if (fsize->index != 0) {
>   		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
>   			  fsize->index);
