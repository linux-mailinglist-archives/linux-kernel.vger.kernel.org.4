Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850CD74A7D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGFXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGFXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:37:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91281BE1;
        Thu,  6 Jul 2023 16:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75CA261476;
        Thu,  6 Jul 2023 23:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D12C433C8;
        Thu,  6 Jul 2023 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688686664;
        bh=G+V2hz9n6fp+8qO6nu/vx8tNdEv7FhsV5V05r1dTJGA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JwBfPSuH7WthDPZdzCC2uh9oT0Xpp8fXWYJeJI1eEC2kngrkOrVULIUK6ghbY9loN
         9VwF0ogybOEMOPVMXPCYXMlJdZeJ3zqDQZDXYSX3H6CoDNMpU3S/xCnN+6tMC9d68k
         1dNqKt5oakvAtLP+OBxfdz5IAvIix3yBpQ9/XReQrKQ490rMZt6wiDWb5Obo2MPGSO
         v29liHzCVQZaT9Ns4BacSQfFCaK2llugoRugDKS/B0+YKO5uiYW0q5KuJxUo4JiLbi
         1mpVSrR4qvZVJVhsh06/Or5Vt2KcT1uR25qV+OxQqcrg6cnFNRxjQsL9f9yX+xFnJQ
         pXcobZZHydVQQ==
Message-ID: <31792407-2990-6f31-e2ec-aad81c8870ee@kernel.org>
Date:   Fri, 7 Jul 2023 08:37:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/8] ata: sata_rcar: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230706124239.23366-1-frank.li@vivo.com>
 <20230706124239.23366-5-frank.li@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706124239.23366-5-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 21:42, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/ata/sata_rcar.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 34790f15c1b8..63f8337c2a98 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -861,15 +861,11 @@ static int sata_rcar_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct ata_host *host;
>  	struct sata_rcar_priv *priv;
> -	struct resource *mem;
> -	int irq;
> -	int ret = 0;
> +	int irq, ret;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> -	if (!irq)
> -		return -EINVAL;

Same comment as Geert: this is OK to remove, but make that a different
patch.

>  
>  	priv = devm_kzalloc(dev, sizeof(struct sata_rcar_priv), GFP_KERNEL);
>  	if (!priv)
> @@ -890,8 +886,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
>  
>  	host->private_data = priv;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(dev, mem);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base)) {
>  		ret = PTR_ERR(priv->base);
>  		goto err_pm_put;

-- 
Damien Le Moal
Western Digital Research

