Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C66C469C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCVJhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCVJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:37:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0F25C110;
        Wed, 22 Mar 2023 02:36:51 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:cd0d:1462:ffab:ab3a] (unknown [IPv6:2a01:e0a:120:3210:cd0d:1462:ffab:ab3a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FB7566003AE;
        Wed, 22 Mar 2023 09:36:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679477810;
        bh=PG6CX5ajqtdLi2tzLr2luOtl3CwHO03O+WLnE2aRKAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lCP+okL1HpozS00eimFUyuYxd4HkDX0N6Bt75CbT7z5LnCZHxqXlEfTWHK56NJOF8
         ptnN6IFaQFwWGCZysac0wJ2wfoHX5mMmGvw3ZCfCYxFvdfvdt1e2DItZ/2IxcishQn
         65d/SIqvad1YHJWySE2W8pIuDOS1HvuUwVVcNoZ2HvUQe3k+8awhw6ZLw3li29Qn0a
         kze1mDH6SI4qHQ9ounD46I5RAbU4ZEYYgxnI30HPf/r0dSzIHvqGkejiVCuVCBLmHi
         gveFPCKOTMlT+GA9pz3jbprSIYyni/ocKC9WzoiVxpCjQ+imuUQTvxEvI3ZrO9iv2M
         j1YwLxCp7CTOQ==
Message-ID: <5d5c8c7b-b926-8397-7994-623ac9b37e83@collabora.com>
Date:   Wed, 22 Mar 2023 10:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: hantro: HEVC: Fix exception handling in
 tile_buffer_reallocate()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e3aaeecf-8e74-2e74-c58a-d80e153e98f9@web.de>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <e3aaeecf-8e74-2e74-c58a-d80e153e98f9@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Thanks for your patch,

Le 20/03/2023 à 19:43, Markus Elfring a écrit :
> Date: Mon, 20 Mar 2023 19:13:20 +0100
>
> The label “err_free_tile_buffers” was used to jump to another pointer
> check despite of the detail in the implementation of the function
> “tile_buffer_reallocate” that it was determined already that
> a corresponding variable contained a null pointer because of a failed
> function call “dma_alloc_coherent”.
>
> * Thus use an additional label instead.
>
> * Delete a redundant check.
>
>
> This issue was detected by using the Coccinelle software.

If you want to optimize the error path I think the best
option is to return -ENOMEM when hevc_dec->tile_filter.cpu is NULL,
remove
	if (hevc_dec->tile_bsd.cpu)
		dma_free_coherent(vpu->dev, hevc_dec->tile_bsd.size,
				  hevc_dec->tile_bsd.cpu,
				  hevc_dec->tile_bsd.dma);
and reorder the two other dma_free to get something clean.

Regards,
Benjamin

>
> Fixes: cb5dd5a0fa518dff14ff2b90837c3c8f98f4dd5c ("media: hantro: Introduce G2/HEVC decoder")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/media/platform/verisilicon/hantro_hevc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_hevc.c b/drivers/media/platform/verisilicon/hantro_hevc.c
> index 9383fb7081f6..ac60df18efb7 100644
> --- a/drivers/media/platform/verisilicon/hantro_hevc.c
> +++ b/drivers/media/platform/verisilicon/hantro_hevc.c
> @@ -109,7 +109,7 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
>                                  &hevc_dec->tile_filter.dma,
>                                  GFP_KERNEL);
>       if (!hevc_dec->tile_filter.cpu)
> -        goto err_free_tile_buffers;
> +        goto recheck_tile_sao_cpu;
>       hevc_dec->tile_filter.size = size;
>   
>       size = (VERT_SAO_RAM_SIZE * height64 * (num_tile_cols - 1) * ctx->bit_depth) / 8;
> @@ -133,12 +133,12 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
>       return 0;
>   
>   err_free_tile_buffers:
> -    if (hevc_dec->tile_filter.cpu)
> -        dma_free_coherent(vpu->dev, hevc_dec->tile_filter.size,
> -                  hevc_dec->tile_filter.cpu,
> -                  hevc_dec->tile_filter.dma);
> +    dma_free_coherent(vpu->dev, hevc_dec->tile_filter.size,
> +              hevc_dec->tile_filter.cpu,
> +              hevc_dec->tile_filter.dma);
>       hevc_dec->tile_filter.cpu = NULL;
>   
> +recheck_tile_sao_cpu:
>       if (hevc_dec->tile_sao.cpu)
>           dma_free_coherent(vpu->dev, hevc_dec->tile_sao.size,
>                     hevc_dec->tile_sao.cpu,
> --
> 2.40.0
>
>
