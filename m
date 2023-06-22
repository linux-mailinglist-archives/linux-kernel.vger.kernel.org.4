Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42C73A4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjFVP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjFVP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:28:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE042118;
        Thu, 22 Jun 2023 08:27:32 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:7d72:676c:e745:a6ef] (unknown [IPv6:2a01:e0a:120:3210:7d72:676c:e745:a6ef])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F2486606EDE;
        Thu, 22 Jun 2023 16:27:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687447646;
        bh=Yz+NRZOehOEU34hZagSNPjsgeqyatJPhUhG6wIg2Iio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V8Imr1qeQyMMtuQ6blSrhADA3yYPLUM83j3zTux9jWDQffVzlaZrPfjWcPSu8Hk3e
         CjET/duybztDC6v97V7rZ+VUhyRSgRjOi9iIjQj5YQMFoiKN6MnVxQNlvAJy1MHQLH
         n50qvwtAv2LD4c0FuoMOImVHMOMPZPnfWcGTU0rtmzhFQVdwdTEUjE93x7NkYKmBAV
         9qZMTQKrDqEXE1dUmcVQqVHOVnpXADp4k8NwGkLsRg8ZpcITM/OPJAPhCjJWu9K/d6
         XHkwcQZNRn0FF3f1bPBSQBshUdzZvevH7svbFJEKCEGB/xdZfPpm3K20Udcz5bQw4r
         wXEDVkApYNnqw==
Message-ID: <6798cc82-d5dc-5603-7e7e-57ce09c09d24@collabora.com>
Date:   Thu, 22 Jun 2023 17:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/11] media: verisilicon: postproc: Fix down scale
 test
Content-Language: en-US
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-9-benjamin.gaignard@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20230622131349.144160-9-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 22/06/2023 à 15:13, Benjamin Gaignard a écrit :
> Do not allow down scaling if the source buffer resolution is
> smaller than destination one.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   drivers/media/platform/verisilicon/hantro_postproc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
> index a6b67d0cc66c..a4f2c5e8932c 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -103,7 +103,10 @@ static void hantro_postproc_g1_enable(struct hantro_ctx *ctx)
>   
>   static int down_scale_factor(struct hantro_ctx *ctx)
>   {
> -	if (ctx->src_fmt.width == ctx->dst_fmt.width)
> +	if (ctx->src_fmt.width <= ctx->dst_fmt.width)
> +		return 0;
> +
> +	if (ctx->src_fmt.height <= ctx->dst_fmt.height)

One test will be enough.
I will fix that in v4.

Benjamin

>   		return 0;
>   
>   	return DIV_ROUND_CLOSEST(ctx->src_fmt.width, ctx->dst_fmt.width);
