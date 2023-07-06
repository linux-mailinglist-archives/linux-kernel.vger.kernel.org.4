Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F774A7DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGFXjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DD11BE1;
        Thu,  6 Jul 2023 16:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 932DB614B6;
        Thu,  6 Jul 2023 23:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9048FC433C8;
        Thu,  6 Jul 2023 23:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688686783;
        bh=6fqr7wPLjBY8t1IgVsprpFsOLLCGzV/ls+G57rzir5A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tz4XQhfNsIUmBAsCL1mmqkVauhFRPTdgKHM18RFN3YOmBOvUHdn9O0cvdFzFe9XJT
         tLpRtD9j5gk4rZTdTbi2m7m4VFbmwA5fP+5NHwVoXQfEzgKbm2PDbo7a0BTx7nmGQb
         XE8kozVVoBETZPJP818ZRYLuH6c5daCJJuHYetypvocAtwI81vOKL9wcAh4lCI+7na
         46waolNCzPQWccNB/p+GTCXz78fv1t4jirSsjk6MpjbcgmxuwQOo+waJySurbIUHR+
         3VW77ac1yagVEPPvB0JsE6t8n7BKXPa1OxXVgsa0TMBOKeArRUXP9kSr7amVvHwnWS
         7QE0odqQkiQIw==
Message-ID: <9549562b-e6ce-15df-571a-bdb6a84bdb03@kernel.org>
Date:   Fri, 7 Jul 2023 08:39:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/8] pata: ixp4xx: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230706124239.23366-1-frank.li@vivo.com>
 <20230706124239.23366-6-frank.li@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706124239.23366-6-frank.li@vivo.com>
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
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

Patch title:

ata: pata_ixp4xx: ...

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/ata/pata_ixp4xx_cf.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
> index b1daa4d3fcd9..246bb4f8f1f7 100644
> --- a/drivers/ata/pata_ixp4xx_cf.c
> +++ b/drivers/ata/pata_ixp4xx_cf.c
> @@ -242,12 +242,6 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
>  	int ret;
>  	int irq;
>  
> -	cmd = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ctl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -
> -	if (!cmd || !ctl)
> -		return -EINVAL;
> -
>  	ixpp = devm_kzalloc(dev, sizeof(*ixpp), GFP_KERNEL);
>  	if (!ixpp)
>  		return -ENOMEM;
> @@ -271,18 +265,18 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ixpp->cmd = devm_ioremap_resource(dev, cmd);
> -	ixpp->ctl = devm_ioremap_resource(dev, ctl);
> -	if (IS_ERR(ixpp->cmd) || IS_ERR(ixpp->ctl))
> -		return -ENOMEM;
> +	ixpp->cmd = devm_platform_get_and_ioremap_resource(pdev, 0, &cmd);
> +	if (IS_ERR(ixpp->cmd))
> +		return PTR_ERR(ixpp->cmd);
> +
> +	ixpp->ctl = devm_platform_get_and_ioremap_resource(pdev, 1, &ctl);
> +	if (IS_ERR(ixpp->ctl))
> +		return PTR_ERR(ixpp->ctl);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq > 0)
> -		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
> -	else if (irq < 0)
> +	if (irq < 0)
>  		return irq;
> -	else
> -		return -EINVAL;
> +	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);

This change is OK but this should be a different patch.

>  
>  	/* Just one port to set up */
>  	ixp4xx_setup_port(ixpp->host->ports[0], ixpp, cmd->start, ctl->start);

-- 
Damien Le Moal
Western Digital Research

