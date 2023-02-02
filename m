Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7425B687599
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBBFvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjBBFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:51:13 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EEE1F5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 21:50:26 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Feb 2023 14:50:26 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id E7A222058B4F;
        Thu,  2 Feb 2023 14:50:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 2 Feb 2023 14:50:21 +0900
Received: from [10.212.156.77] (unknown [10.212.156.77])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 62B453D59;
        Thu,  2 Feb 2023 14:50:25 +0900 (JST)
Message-ID: <bb307806-fa02-d147-2c25-6b3b3bbd411b@socionext.com>
Date:   Thu, 2 Feb 2023 14:50:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] bus: unifier-system-bus: Remove open coded "ranges"
 parsing
To:     Rob Herring <robh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230201220011.247100-1-robh@kernel.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20230201220011.247100-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2023/02/02 7:00, Rob Herring wrote:
> "ranges" is a standard property and we have common helper functions for
> parsing it, so let's use them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Compile tested only!

Please fix the driver's name.

s/unifier-system-bus/uniphier-system-bus/

> ---
>   drivers/bus/uniphier-system-bus.c | 54 +++++++------------------------
>   1 file changed, 11 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/bus/uniphier-system-bus.c
> b/drivers/bus/uniphier-system-bus.c
> index f70dedace20b..cb5c89ce7b86 100644
> --- a/drivers/bus/uniphier-system-bus.c
> +++ b/drivers/bus/uniphier-system-bus.c
> @@ -176,10 +176,9 @@ static int uniphier_system_bus_probe(struct
> platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct uniphier_system_bus_priv *priv;
> -	const __be32 *ranges;
> -	u32 cells, addr, size;
> -	u64 paddr;
> -	int pna, bank, rlen, rone, ret;
> +	struct of_range_parser parser;
> +	struct of_range range;
> +	int ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -191,48 +190,17 @@ static int uniphier_system_bus_probe(struct
> platform_device *pdev)
>   
>   	priv->dev = dev;
>   
> -	pna = of_n_addr_cells(dev->of_node);
> -
> -	ret = of_property_read_u32(dev->of_node, "#address-cells",
> &cells);
> -	if (ret) {
> -		dev_err(dev, "failed to get #address-cells\n");
> -		return ret;
> -	}
> -	if (cells != 2) {
> -		dev_err(dev, "#address-cells must be 2\n");
> -		return -EINVAL;
> -	}

Don't you need to check the value of "#address-cells"?

> -
> -	ret = of_property_read_u32(dev->of_node, "#size-cells", &cells);
> -	if (ret) {
> -		dev_err(dev, "failed to get #size-cells\n");
> +	ret = of_range_parser_init(&parser, dev->of_node);
> +	if (ret)
>   		return ret;
> -	}
> -	if (cells != 1) {
> -		dev_err(dev, "#size-cells must be 1\n");
> -		return -EINVAL;
> -	}

Same as "#size-cells"

> -	ranges = of_get_property(dev->of_node, "ranges", &rlen);
> -	if (!ranges) {
> -		dev_err(dev, "failed to get ranges property\n");
> -		return -ENOENT;
> -	}
> -
> -	rlen /= sizeof(*ranges);
> -	rone = pna + 2;
> -
> -	for (; rlen >= rone; rlen -= rone) {
> -		bank = be32_to_cpup(ranges++);
> -		addr = be32_to_cpup(ranges++);
> -		paddr = of_translate_address(dev->of_node, ranges);
> -		if (paddr == OF_BAD_ADDR)
> +	for_each_of_range(&parser, &range) {
> +		if (range.cpu_addr == OF_BAD_ADDR)
>   			return -EINVAL;
> -		ranges += pna;
> -		size = be32_to_cpup(ranges++);
> -
> -		ret = uniphier_system_bus_add_bank(priv, bank, addr,
> -						   paddr, size);
> +		ret = uniphier_system_bus_add_bank(priv,
> +						
> upper_32_bits(range.bus_addr),
> +						
> lower_32_bits(range.bus_addr),
> +						   range.cpu_addr,
> range.size);
>   		if (ret)
>   			return ret;
>   	}

I confirmed the value of all the arguments of uniphier_system_bus_add_bank()
match the previous ones.

Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi
