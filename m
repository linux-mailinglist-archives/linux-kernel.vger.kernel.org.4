Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7187C627410
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiKNBKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiKNBKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:10:06 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB8B510067
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:10:04 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 14 Nov 2022 10:09:48 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B1D2A2059027;
        Mon, 14 Nov 2022 10:09:48 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 14 Nov 2022 10:09:48 +0900
Received: from [10.212.157.40] (unknown [10.212.157.40])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 071D8B62AE;
        Mon, 14 Nov 2022 10:09:48 +0900 (JST)
Message-ID: <32291d3a-25f8-ff5f-d149-180fbb82278d@socionext.com>
Date:   Mon, 14 Nov 2022 10:09:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] reset: uniphier-glue: Fix possible null-ptr-deref
To:     Hui Tang <tanghui20@huawei.com>, p.zabel@pengutronix.de,
        mhiramat@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        weiyongjun1@huawei.com
References: <20221114004958.258513-1-tanghui20@huawei.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20221114004958.258513-1-tanghui20@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/14 9:49, Hui Tang wrote:
> It will cause null-ptr-deref when resource_size(res) invoked,
> if platform_get_resource() returns NULL.
> 
> Fixes: 499fef09a323 ("reset: uniphier: add USB3 core reset control")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>   drivers/reset/reset-uniphier-glue.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/reset-uniphier-glue.c
> b/drivers/reset/reset-uniphier-glue.c
> index 146fd5d45e99..15abac9fc72c 100644
> --- a/drivers/reset/reset-uniphier-glue.c
> +++ b/drivers/reset/reset-uniphier-glue.c
> @@ -47,7 +47,6 @@ static int uniphier_glue_reset_probe(struct
> platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct uniphier_glue_reset_priv *priv;
>   	struct resource *res;
> -	resource_size_t size;
>   	int i, ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -60,7 +59,6 @@ static int uniphier_glue_reset_probe(struct
> platform_device *pdev)
>   		return -EINVAL;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	size = resource_size(res);
>   	priv->rdata.membase = devm_ioremap_resource(dev, res);
>   	if (IS_ERR(priv->rdata.membase))
>   		return PTR_ERR(priv->rdata.membase);
> @@ -96,7 +94,7 @@ static int uniphier_glue_reset_probe(struct
> platform_device *pdev)
>   
>   	spin_lock_init(&priv->rdata.lock);
>   	priv->rdata.rcdev.owner = THIS_MODULE;
> -	priv->rdata.rcdev.nr_resets = size * BITS_PER_BYTE;
> +	priv->rdata.rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
>   	priv->rdata.rcdev.ops = &reset_simple_ops;
>   	priv->rdata.rcdev.of_node = dev->of_node;
>   	priv->rdata.active_low = true;

Good catch! resource_size() should refer to res after the check.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi
