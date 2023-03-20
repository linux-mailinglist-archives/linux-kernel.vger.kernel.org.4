Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202C66C0D73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCTJgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCTJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:35:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28F42057A;
        Mon, 20 Mar 2023 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679304936; x=1710840936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dyi9itZ2EsM0QbXbELyjxRO6wIIBtI+33DE19QI5xqM=;
  b=vBumbBz7E0Or0y0XMk0CvHUGoZOXRq1rQHdc/uzHsyRd2MxiyZAy9Tno
   SwlJlBUrlIFq2wJ3/aTVgxe/ZReWysZbZCovCJgFeUaYCscjBo/i23zob
   6a21B801a/PRjIx+TPCeKKEMhhoFAu1/w6I8rmBgYNj7PpH6/HYFSFcfz
   GgLltgcc/DJoOHHSBtJ38DrMR/PuSFpCqZOgPtQo8tzC8zx3VJsSnc708
   NU9m4V9khDPQYiGGjNSIUq7Euto8MOJk647UF9n0QWyuJq7OdYbbp2de4
   m+wKbAAxFFds7WX+kJ7VaESIHczH5oDBCC0ldFEPuKGqPdERL5AFG2hDi
   g==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673938800"; 
   d="scan'208";a="142894619"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Mar 2023 02:35:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 02:35:32 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 20 Mar 2023 02:35:30 -0700
Message-ID: <954acc8c-0df3-23a4-7237-ecbc31811a56@microchip.com>
Date:   Mon, 20 Mar 2023 10:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, <eugen.hristev@collabora.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230310091239.1440279-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 at 10:12, Zheng Wang wrote:
> In at91_adc_probe, &st->touch_st.workq is bound with
> at91_adc_workq_handler. Then it will be started by irq
> handler at91_adc_touch_data_handler
> 
> If we remove the driver which will call at91_adc_remove
>    to make cleanup, there may be a unfinished work.
> 
> The possible sequence is as follows:
> 
> Fix it by finishing the work before cleanup in the at91_adc_remove
> 
> CPU0                  CPU1
> 
>                      |at91_adc_workq_handler
> at91_adc_remove     |
> iio_device_unregister|
> iio_dev_release     |
> kfree(iio_dev_opaque);|
>                      |
>                      |iio_push_to_buffers
>                      |&iio_dev_opaque->buffer_list
>                      |//use

There is no such thing as a SMP platform using this driver (yet?), so we 
agree that this fix is purely theoretical, cannot be reproduced nor its 
fix validated.

That being said, I'm happy that enhancements are provided to this 
driver, no doubt about that.


> Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>   drivers/iio/adc/at91-sama5d2_adc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 50d02e5fc6fc..1b95d18d9e0b 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2495,6 +2495,8 @@ static int at91_adc_remove(struct platform_device *pdev)
>          struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>          struct at91_adc_state *st = iio_priv(indio_dev);
> 
> +       disable_irq_nosync(st->irq);
> +       cancel_work_sync(&st->touch_st.workq);

About stopping the source of interrupt, I would recommend using a 
sequence already exposed in at91_adc_hw_init (and possibly make it 
common), like:

    if (st->soc_info.platform->layout->EOC_IDR)
            at91_adc_writel(st, EOC_IDR, 0xffffffff);
    at91_adc_writel(st, IDR, 0xffffffff);

Regards,
   Nicolas

>          iio_device_unregister(indio_dev);
> 
>          at91_adc_dma_disable(st);
> --
> 2.25.1
> 

-- 
Nicolas Ferre

