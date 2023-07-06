Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575D974A7CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjGFXf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGFXfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2F1BC3;
        Thu,  6 Jul 2023 16:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB41761208;
        Thu,  6 Jul 2023 23:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5825C433C7;
        Thu,  6 Jul 2023 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688686553;
        bh=DP7fJGvKQ0uhwcbMQ4HpQrGiWbGBPP9soTviBQgpsZQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q7IiS06KZPS2/0Au4NLJYv85CJJlKitaXhs2QzDXKtYT0bqaAlGzcfewrLv2vBIqJ
         jBjiNxB2iFpxrHwBHOdJ5GFe5zdTj5Sw303fT8DTwzS1MNPYjUwsGoAjg5RXATGwUM
         gY+xpiOK2qtEAxslDK9GPsOgm/cJfyGzjuu1GUhA61MPwRGTXgI0Pu0XjZnK8LZ9Jy
         Y+dtZuLX1jfaUVBoJ6jlJSw1GrzMyOIOWSTa3Ot3iYxlYFwQP7HxZ9XN5JjcrtiLfz
         e19fxmy0Shr/YaYyeIYNKPAlswcH9skyf/4So4HKy5tD45O8ZNqGUcLFjB7SsG8qiv
         zpRZSTaVTDt2Q==
Message-ID: <e6966fdb-e022-8fbe-4bc0-2c2b71138ed2@kernel.org>
Date:   Fri, 7 Jul 2023 08:35:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/8] ahci: tegra: Convert to
 devm_platform_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230706124239.23366-1-frank.li@vivo.com>
 <20230706124239.23366-4-frank.li@vivo.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706124239.23366-4-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 21:42, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.

Please be consistent with the patch titles. This should be:

ata: ahci_tegra: Convert to devm_platform_ioremap_resource()

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/ata/ahci_tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 21c20793e517..d1a35da7e824 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -530,8 +530,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  	tegra->pdev = pdev;
>  	tegra->soc = of_device_get_match_data(&pdev->dev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
> +	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(tegra->sata_regs))
>  		return PTR_ERR(tegra->sata_regs);
>  

-- 
Damien Le Moal
Western Digital Research

