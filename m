Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5FA61A091
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiKDTKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKDTKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:10:16 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CA5985D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:10:14 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id r24uozMxztFxAr24uoSTR9; Fri, 04 Nov 2022 20:10:09 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Nov 2022 20:10:09 +0100
X-ME-IP: 86.243.100.34
Message-ID: <d3edf1c5-5317-b9d1-6c23-4ad97a574af6@wanadoo.fr>
Date:   Fri, 4 Nov 2022 20:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iio: adc: hx711: remove errors during deferred probe
Content-Language: fr, en-US
To:     nate.d@variscite.com
Cc:     ak@it-klinger.de, eran.m@variscite.com, jic23@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104172243.1004384-1-nate.d@variscite.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221104172243.1004384-1-nate.d@variscite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/11/2022 à 18:22, Nate Drude a écrit :
> This patch removes noisy kernel messages like "failed to sck-gpiod" or
> "failed to get dout-gpiod" when the probe is deferred.
> 
> Signed-off-by: Nate Drude <nate.d-/HTLZasLZWtl57MIdRCFDg@public.gmane.org>
> ---
>   drivers/iio/adc/hx711.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index f7ee856a6b8b..8ba4a5b113aa 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -482,8 +482,9 @@ static int hx711_probe(struct platform_device *pdev)
>   	 */
>   	hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
>   	if (IS_ERR(hx711_data->gpiod_pd_sck)) {
> -		dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
> -					PTR_ERR(hx711_data->gpiod_pd_sck));
> +		if (PTR_ERR(hx711_data->gpiod_pd_sck) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
> +						PTR_ERR(hx711_data->gpiod_pd_sck));
>   		return PTR_ERR(hx711_data->gpiod_pd_sck);
>   	}
>   
> @@ -493,8 +494,9 @@ static int hx711_probe(struct platform_device *pdev)
>   	 */
>   	hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_IN);
>   	if (IS_ERR(hx711_data->gpiod_dout)) {
> -		dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
> -					PTR_ERR(hx711_data->gpiod_dout));
> +		if (PTR_ERR(hx711_data->gpiod_dout) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
> +						PTR_ERR(hx711_data->gpiod_dout));
>   		return PTR_ERR(hx711_data->gpiod_dout);
>   	}
>   

Hi,
using dev_err_probe() looks like a better candidate for that.

It can be can folded with the return (saving some LoC and the {} around 
the error handling path), and display the error code in a human readable 
manner.

CJ
