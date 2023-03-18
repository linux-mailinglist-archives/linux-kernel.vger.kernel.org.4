Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0193D6BFBE2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCRRgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCRRgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:36:14 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9D31E3E;
        Sat, 18 Mar 2023 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=r7A7mdmBsBY9f3U2r41zJO5Uw7IfyxYxQsJX4tWnBic=; b=ANiUAJRwfDdBEzPXgKut6x0e7H
        JifM0Ql1RokHy27pqRMCgLTo+kgBNrfw+amBnQUeMac085ALnseR2o87hsa+0Fp3UVzZV97g3lVvg
        hSH8eLGSD5HFX40bVyxj2+O6vXgIhPSicCJYD2s+URiSoDrFhe5XvmH7YpkzEbRsqRrQzXLyFjRIJ
        8LFGn83oHsgorJkYIGoAMTF/dpHl56qcJ+QwX62uVDH4j2Mo9yw2KcfOqqJ5iWKGTy/ZCOIr3Pwzi
        RNYC+QkK0AViteORpAy4p9ukYreIeJ8aVtieJBPn50InwMjrxZ6phI6WCDiKY7yVhn1XjKrLU3mnM
        k68LbttQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pdaTP-0001Cp-Hi; Sat, 18 Mar 2023 18:36:07 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pdaTP-000Nhv-3p; Sat, 18 Mar 2023 18:36:07 +0100
Message-ID: <d62ece80-4d88-36a6-9561-fa0f5afc40c1@metafoo.de>
Date:   Sat, 18 Mar 2023 10:36:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, Zheng Wang <zyytlz.wz@163.com>
Cc:     eugen.hristev@collabora.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
 <20230318173913.19e8a1b1@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230318173913.19e8a1b1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26847/Sat Mar 18 08:21:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/23 10:39, Jonathan Cameron wrote:
> On Fri, 10 Mar 2023 17:12:39 +0800
> Zheng Wang <zyytlz.wz@163.com> wrote:
>
>> In at91_adc_probe, &st->touch_st.workq is bound with
>> at91_adc_workq_handler. Then it will be started by irq
>> handler at91_adc_touch_data_handler
>>
>> If we remove the driver which will call at91_adc_remove
>>    to make cleanup, there may be a unfinished work.
>>
>> The possible sequence is as follows:
>>
>> Fix it by finishing the work before cleanup in the at91_adc_remove
>>
>> CPU0                  CPU1
>>
>>                      |at91_adc_workq_handler
>> at91_adc_remove     |
>> iio_device_unregister|
>> iio_dev_release     |
>> kfree(iio_dev_opaque);|
>>                      |
>>                      |iio_push_to_buffers
>>                      |&iio_dev_opaque->buffer_list
>>                      |//use
>> Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>> ---
>>   drivers/iio/adc/at91-sama5d2_adc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index 50d02e5fc6fc..1b95d18d9e0b 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -2495,6 +2495,8 @@ static int at91_adc_remove(struct platform_device *pdev)
>>   	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>   	struct at91_adc_state *st = iio_priv(indio_dev);
>>   
>> +	disable_irq_nosync(st->irq);
>> +	cancel_work_sync(&st->touch_st.workq);
> I'd like some input form someone more familiar with this driver than I am.
>
> In particular, whilst it fixes the bug seen I'm not sure what the most
> logical ordering for the disable is or the best way to do it.
>
> I'd prefer to see the irq cut off at source by disabling it at the device
> feature that is generating the irq followed by cancelling or waiting for
> completion of any in flight work.
The usually way you'd do this by calling free_irq() before the 
cancel_work_sync().


