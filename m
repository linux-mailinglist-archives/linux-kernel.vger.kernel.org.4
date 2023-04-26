Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365B6EFD1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbjDZWUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjDZWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:20:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E330F2;
        Wed, 26 Apr 2023 15:19:58 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F09E2660309E;
        Wed, 26 Apr 2023 23:19:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682547596;
        bh=+OscA6mJnbIYnZfMg7bAO4iT6/B0MVE8PNNsUBI7ZJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VEDcQrFdE1I+omJfqHC8m/BHpXEM7wrEriDN2hxAn4O3x5NnuVgnf72/71aMwJ/Jo
         gDhkCAd5C9lFGLlUhTdsgI8HmvAP6PVhLvXTyR3DcImczEzLtX8zBP9lgcDx3xhFon
         0vdJYo8OihQDlCT50sm1WWvpqgpo0/BzLR1DEY8/JKZnekpQC5Je9Z23lpnFqNYxus
         rB02gfObh36TMPh2yLtBTnT6N41C4BJxbiv4tn6Z5kOJeR5i+e7hv+XYeGN5Pn+Bqa
         HaEH6nSRFsV5pv/L76U2U86ufVKMWzzRS3DuC9o946821M3ZSF9g6sfislLIvmyrK7
         yp3NsqEZo2M0A==
Message-ID: <26addb7d-bb9d-34e8-d4fe-e323ff488101@collabora.com>
Date:   Thu, 27 Apr 2023 03:49:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, robert.mader@collabora.com,
        nicolas.dufresne@collabora.co.uk, ezequiel@vanguardiasur.com.ar,
        festevam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        hverkuil-cisco@xs4all.nl, linux-imx@nxp.com,
        regressions@lists.linux.dev
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
 <20230220104849.398203-2-benjamin.gaignard@collabora.com>
Content-Language: en-US
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20230220104849.398203-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 20/02/23 16:18, Benjamin Gaignard wrote:
> Setting context source and destination formats should only be done
> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
> the targeted queue is not busy.
> Remove these calls from hantro_reset_encoded_fmt() and
> hantro_reset_raw_fmt() to clean the driver.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

KernelCI found this patch causes a regression in the
baseline.dmesg.alert test [1] on rk3399-rock-pi-4b [2],
see the bisection report for more details [3].

Let us know if you have any questions.


[1] https://github.com/kernelci/kernelci-core/blob/main/config/rootfs/debos/overlays/baseline/opt/kernelci/dmesg.sh
[2] https://linux.kernelci.org/test/case/id/6442e825f19134d74c2e865d/
[3] https://groups.io/g/kernelci-results/message/40740


Thanks,
Shreeya Patel

#regzbot introduced: db6f68b51e5c

> ---
>   drivers/media/platform/verisilicon/hantro_v4l2.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index c0d427956210..d8aa42bd4cd4 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -382,13 +382,10 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>   
>   	vpu_fmt = hantro_get_default_fmt(ctx, true);
>   
> -	if (ctx->is_encoder) {
> -		ctx->vpu_dst_fmt = vpu_fmt;
> +	if (ctx->is_encoder)
>   		fmt = &ctx->dst_fmt;
> -	} else {
> -		ctx->vpu_src_fmt = vpu_fmt;
> +	else
>   		fmt = &ctx->src_fmt;
> -	}
>   
>   	hantro_reset_fmt(fmt, vpu_fmt);
>   	fmt->width = vpu_fmt->frmsize.min_width;
> @@ -408,11 +405,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>   	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
>   
>   	if (ctx->is_encoder) {
> -		ctx->vpu_src_fmt = raw_vpu_fmt;
>   		raw_fmt = &ctx->src_fmt;
>   		encoded_fmt = &ctx->dst_fmt;
>   	} else {
> -		ctx->vpu_dst_fmt = raw_vpu_fmt;
>   		raw_fmt = &ctx->dst_fmt;
>   		encoded_fmt = &ctx->src_fmt;
>   	}
