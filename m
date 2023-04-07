Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552BE6DA9A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjDGHyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:54:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A06E82;
        Fri,  7 Apr 2023 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680854076; x=1712390076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CZ/jCUb4kYCui3C/8u1ZqszGrltmw8qxX+93UuaVuMU=;
  b=aJ6Dk3zNtcdKOQnR2wEyMH0dmJpqduCM3Fie0NX6MGZsh5qscUNlQ1Ah
   XyQtS/kh09UdRoQ31OYkIs/LNDYv4pIhX1VGhFcYiJ2L8Rs1lSFyRA/1e
   pyu/qLRxy1dP2r7hCkg4YzcLgrFV6MF1btBo+NxS5flMQ/B6s2usbjS3E
   mgaQamO3HsOveNoelUd8wYqPJYkn1RIHxboh/94BCmozV8VkKvT4cEWva
   nC2fBRL1dkWZaVyAYMkkGrHYoBW3V0jkwqOfZyKVZyMGnjDUr4rTjN9K5
   2nJEvrDi96IwOFx01AA+vwFWd3MeuekCfwLy6E9rPlMeiuxDPKFLh7T5n
   A==;
X-IronPort-AV: E=Sophos;i="5.98,326,1673938800"; 
   d="scan'208";a="208137635"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2023 00:54:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 00:54:35 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 7 Apr 2023 00:54:33 -0700
Message-ID: <e3e704f5-3719-637a-8bc5-3a24e2e7cb92@microchip.com>
Date:   Fri, 7 Apr 2023 09:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] spi: atmel: Improve exception handling in
 atmel_spi_configure_dma()
To:     Markus Elfring <Markus.Elfring@web.de>,
        <kernel-janitors@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>
CC:     <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <82aebf6c-47ac-9d17-2d11-6245f582338e@web.de>
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <82aebf6c-47ac-9d17-2d11-6245f582338e@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 at 08:22, Markus Elfring wrote:
> Date: Fri, 7 Apr 2023 08:08:59 +0200
> 
> The label “error” was used to jump to another pointer check despite of
> the detail in the implementation of the function “atmel_spi_configure_dma”
> that it was determined already that the corresponding variable
> contained an error pointer because of a failed call of
> the function “dma_request_chan”.
> 
> * Thus use more appropriate labels instead.
> 
> * Delete two redundant checks.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 398b6b310ec85eef9d98df5963d5ded18aa92ad8 ("spi: atmel: switch to use modern name")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

It's becoming a pattern, but still:
NACK.

Regards,
   Nicolas

> ---
>   drivers/spi/spi-atmel.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 7f06305e16cb..ed8dc93c73e5 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -511,12 +511,12 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
>                   * requested tx channel.
>                   */
>                  dev_dbg(dev, "No RX DMA channel, DMA is disabled\n");
> -               goto error;
> +               goto release_channel_tx;
>          }
> 
>          err = atmel_spi_dma_slave_config(as, 8);
>          if (err)
> -               goto error;
> +               goto release_channel_rx;
> 
>          dev_info(&as->pdev->dev,
>                          "Using %s (tx) and %s (rx) for DMA transfers\n",
> @@ -524,11 +524,11 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
>                          dma_chan_name(host->dma_rx));
> 
>          return 0;
> -error:
> -       if (!IS_ERR(host->dma_rx))
> -               dma_release_channel(host->dma_rx);
> -       if (!IS_ERR(host->dma_tx))
> -               dma_release_channel(host->dma_tx);
> +
> +release_channel_rx:
> +       dma_release_channel(host->dma_rx);
> +release_channel_tx:
> +       dma_release_channel(host->dma_tx);
>   error_clear:
>          host->dma_tx = host->dma_rx = NULL;
>          return err;
> --
> 2.40.0
> 

-- 
Nicolas Ferre

