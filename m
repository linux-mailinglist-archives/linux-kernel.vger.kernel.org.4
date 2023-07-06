Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA49074A7DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGFXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4A1BE1;
        Thu,  6 Jul 2023 16:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3E761208;
        Thu,  6 Jul 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6654C433C8;
        Thu,  6 Jul 2023 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688686824;
        bh=Tujvzn4Wxs028ODcLbjT4SKTlIH3KZy7BkIxU9xPyp8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZmnHvkE1y8KWQonwoLUVtPX/jP7vLElmepVmMo1LqXmPyXJsykYgIWcZ4ckeGmhz6
         uNm1pYWbpaiId70z2dbr9es/ll7Bsc0BTkQjngUyYZbrJmfBtjJIPBrBlJ/kProc5W
         UTSH0EI5Ovxa1RZPwbO6jmWjWoUV99aQg2HI/fRRpDg6lmADspB8+r1NZBIT4GaODj
         SonPJKxpT0HKAeSW0uvKlX/OM53pQhLXXiwXbmriD+JYlVYjN/77+h9m073XxwBH0+
         bpXeVNTw+VD3k1ui7DXoFNUMencOhOUCfFY31yMtdX+Ttc9Mi7IXAWYGTTbgk5UZkf
         HQRIe9fjeP8Aw==
Message-ID: <3f279fcf-5fbc-d0bb-ec94-39d35acd2d81@kernel.org>
Date:   Fri, 7 Jul 2023 08:40:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 8/8] pata: imx: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230706124239.23366-1-frank.li@vivo.com>
 <20230706124239.23366-8-frank.li@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706124239.23366-8-frank.li@vivo.com>
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
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

Patch title:

ata: pata_imx: ...

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/ata/pata_imx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
> index 4013f28679a9..65d09ec94c12 100644
> --- a/drivers/ata/pata_imx.c
> +++ b/drivers/ata/pata_imx.c
> @@ -164,8 +164,7 @@ static int pata_imx_probe(struct platform_device *pdev)
>  	ap->pio_mask = ATA_PIO4;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS;
>  
> -	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->host_regs = devm_ioremap_resource(&pdev->dev, io_res);
> +	priv->host_regs = devm_platform_get_and_ioremap_resource(pdev, 0, &io_res);
>  	if (IS_ERR(priv->host_regs)) {
>  		ret = PTR_ERR(priv->host_regs);
>  		goto err;

-- 
Damien Le Moal
Western Digital Research

