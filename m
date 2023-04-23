Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4756EBF31
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjDWMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDWMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:03:46 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFF8170F;
        Sun, 23 Apr 2023 05:03:43 -0700 (PDT)
Received: from [192.168.1.10] ([183.94.69.5])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33NC1cSH013449-33NC1cSI013449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 23 Apr 2023 20:01:38 +0800
Message-ID: <54c3b7f7-20da-f42e-6bef-f462246fd3ee@hust.edu.cn>
Date:   Sun, 23 Apr 2023 20:01:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] iio: adc: mxs-lradc: fix the order of two cleanup
 operations
To:     Jonathan Cameron <jic23@kernel.org>, Jiakai Luo <jkluo@hust.edu.cn>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>,
        hust-os-kernel-patches@googlegroups.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230417024745.59614-1-jkluo@hust.edu.cn>
 <20230423115049.1c73600f@jic23-huawei>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20230423115049.1c73600f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/23 18:50, Jonathan Cameron wrote:
> On Sun, 16 Apr 2023 19:47:45 -0700
> Jiakai Luo <jkluo@hust.edu.cn> wrote:
>
>> Smatch reports:
>> drivers/iio/adc/mxs-lradc-adc.c:766 mxs_lradc_adc_probe() warn:
>> missing unwind goto?
>>
>> the order of three init operation:
>> 1.mxs_lradc_adc_trigger_init
>> 2.iio_triggered_buffer_setup
>> 3.mxs_lradc_adc_hw_init
>>
>> thus, the order of three cleanup operation should be:
>> 1.mxs_lradc_adc_hw_stop
>> 2.iio_triggered_buffer_cleanup
>> 3.mxs_lradc_adc_trigger_remove
>>
>> we exchange the order of two cleanup operations,
>> introducing the following differences:
>> 1.if mxs_lradc_adc_trigger_init fails, returns directly;
>> 2.if trigger_init succeeds but iio_triggered_buffer_setup fails,
>> goto err_trig and remove the trigger.
>>
>> In addition, we also reorder the unwind that goes on in the
>> remove() callback to match the new ordering.
>>
>> Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
>> Signed-off-by: Jiakai Luo <jkluo@hust.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> If resending please state why.  I'm guessing on this occasion it was because
> you realised a fresh thread is expected for a new patch.
>
> Also, even if you are just amending the patch description, please increase
> the version number so that we can be sure we are looking at latest version.
>
> I already picked it from the earlier posting and this appears unchanged
> so all's well that ends well!
>
> Jonathan

Hi JC,

Jiakai originally would like to send a reminder about his patch, but 
mistakenly sent a v2 version.

Please ignore this v2 version since this version is the same with v1 
version.

Sorry for the mistake.

>
>> ---
>> The issue is found by static analysis and remains untested.
>> ---
>>   drivers/iio/adc/mxs-lradc-adc.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
>> index bca79a93cbe4..85882509b7d9 100644
>> --- a/drivers/iio/adc/mxs-lradc-adc.c
>> +++ b/drivers/iio/adc/mxs-lradc-adc.c
>> @@ -757,13 +757,13 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>>   
>>   	ret = mxs_lradc_adc_trigger_init(iio);
>>   	if (ret)
>> -		goto err_trig;
>> +		return ret;
>>   
>>   	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
>>   					 &mxs_lradc_adc_trigger_handler,
>>   					 &mxs_lradc_adc_buffer_ops);
>>   	if (ret)
>> -		return ret;
>> +		goto err_trig;
>>   
>>   	adc->vref_mv = mxs_lradc_adc_vref_mv[lradc->soc];
>>   
>> @@ -801,9 +801,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>>   
>>   err_dev:
>>   	mxs_lradc_adc_hw_stop(adc);
>> -	mxs_lradc_adc_trigger_remove(iio);
>> -err_trig:
>>   	iio_triggered_buffer_cleanup(iio);
>> +err_trig:
>> +	mxs_lradc_adc_trigger_remove(iio);
>>   	return ret;
>>   }
>>   
>> @@ -814,8 +814,8 @@ static int mxs_lradc_adc_remove(struct platform_device *pdev)
>>   
>>   	iio_device_unregister(iio);
>>   	mxs_lradc_adc_hw_stop(adc);
>> -	mxs_lradc_adc_trigger_remove(iio);
>>   	iio_triggered_buffer_cleanup(iio);
>> +	mxs_lradc_adc_trigger_remove(iio);
>>
>>   	return 0;
>>   }
