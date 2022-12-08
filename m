Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B1646DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLHLBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiLHLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:00:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215B178A4;
        Thu,  8 Dec 2022 02:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670497011; x=1702033011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jZm84mXS2zwnbUgC6cdFKWsTsw/xZ4TYuKZBkJwd2Z0=;
  b=mlvzL3y59l46+fAkQ5canADCvNLUJ8GypjTY9IP5JAWzN5ScMCFn8Qe9
   JUObTLkU8dY/0nJ1WdG+3LwoOTPXDzWT5bZ6A/B0zU7LNx5W52L7FbkbD
   xxLctQCI7Lm63bLXZVK+RdM7ddqAAUeTVVx/dkeVXk/tMniq+0hnFymKU
   0CCTZ+X9S8NF4UJQG4OwQLI56QXipz3mTxd2/LnVNpC1zRzr2SU2O3jVh
   d39LsnvAePMeEby7QJfBpY39LgIwmhlM+tLi32NwH0d2WlQiy8sqgOP9p
   UJzRghiZwckfDrrMsv02hsk/AO/8FICUA5tfUmAS8s274jo52TAjhAnN9
   w==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="192209365"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2022 03:56:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Dec 2022 03:56:50 -0700
Received: from [10.12.72.78] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Dec 2022 03:56:48 -0700
Message-ID: <64c9bdaf-a138-a9bb-17dd-63ad96d2292b@microchip.com>
Date:   Thu, 8 Dec 2022 11:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] crypto: atmel: Add capability case for the 0x600 SHA and
 AES IP versions
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221207135953.136557-1-sergiu.moga@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221207135953.136557-1-sergiu.moga@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 at 14:59, Sergiu Moga wrote:
> In order for the driver to be made aware of the capabilities of the SHA
> and AES IP versions 0x600 , such as those present on the SAM9X60 SoC's,
> add a corresponding switch case to the capability method of the respective
> drivers. Without this, besides the capabilities not being correctly set,
> the self tests may hang since the driver is endlessly waiting for a
> completion to be set by a never occurring DMA interrupt handler.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Sergiu, best regards,
   Nicolas

> ---
>   drivers/crypto/atmel-aes.c | 1 +
>   drivers/crypto/atmel-sha.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index 886bf258544c..063394cfa874 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -2510,6 +2510,7 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
>   	/* keep only major version number */
>   	switch (dd->hw_version & 0xff0) {
>   	case 0x700:
> +	case 0x600:
>   	case 0x500:
>   		dd->caps.has_dualbuff = 1;
>   		dd->caps.has_cfb64 = 1;
> diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
> index ca4b01926d1b..00be792e605c 100644
> --- a/drivers/crypto/atmel-sha.c
> +++ b/drivers/crypto/atmel-sha.c
> @@ -2509,6 +2509,7 @@ static void atmel_sha_get_cap(struct atmel_sha_dev *dd)
>   	/* keep only major version number */
>   	switch (dd->hw_version & 0xff0) {
>   	case 0x700:
> +	case 0x600:
>   	case 0x510:
>   		dd->caps.has_dma = 1;
>   		dd->caps.has_dualbuff = 1;

-- 
Nicolas Ferre

