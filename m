Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9045BFEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIUNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIUNQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:16:13 -0400
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E65B89929;
        Wed, 21 Sep 2022 06:16:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436431|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00638819-0.00303347-0.990578;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=kant@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.PL-Vbxz_1663766154;
Received: from 192.168.220.136(mailfrom:kant@allwinnertech.com fp:SMTPD_---.PL-Vbxz_1663766154)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 21:15:57 +0800
Message-ID: <ff876f76-85c8-15d6-4f55-831722608edd@allwinnertech.com>
Date:   Wed, 21 Sep 2022 21:15:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND] devfreq: governor: Save void *data in the governor
 userspace
Content-Language: en-US
From:   Kant Fan <kant@allwinnertech.com>
To:     myungjoo.ham@samsung.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allwinner-opensource-support@allwinnertech.com" 
        <allwinner-opensource-support@allwinnertech.com>
References: <a040e16c-e8e9-f550-7251-99ec1d18f508@allwinnertech.com>
 <20220329091449.105308-1-kant@allwinnertech.com>
 <CGME20220914091525epcas1p31c8a9b11ba7a36da4678e3254b0ea962@epcms1p8>
 <20220914094355epcms1p8d6eeb0834e2d7c782d49558fac0ce6c4@epcms1p8>
 <8599d9df-3f56-1762-959d-01ee8c753a5b@allwinnertech.com>
In-Reply-To: <8599d9df-3f56-1762-959d-01ee8c753a5b@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2022 3:41 PM, Kant Fan wrote:
>>>>     static int devfreq_userspace_handler(struct devfreq *devfreq,
>>>
>>> Dear MyungJoo, Kyungmin & Chanwoo,
>>> Gently ping this issue... Does this patch has a chance to be accepted?
>>> This seems to be a bug in devfreq userspace governor, which affects the
>>> switching between governors -- When switching from userspace to
>>> ondemand, the ondemand governor would be invalid.
>>> If there's any question, please let me know.
>>> Thank you.
>>
>> Yes, indeed. This is a bug.
>>
>> Actually, it appears that allocating a new memory buffer for
>> devfreq->data itself is a bug for a governor, this is supposed
>> to be allocated by a device driver. Thus, the comment of
>> "void *data" of "struct devfreq" should be updated:
>> "/* private data for governors given by device drivers */"
>>
>> It'd be better to have something like, "void *internal_data"
>> for governors to freely handle within its context of init-exit,
>> which is not touched by its users (device drivers).
>>
>> @Chanwoo: what's your opinion on this?
>>
>> Cheers,
>> MyungJoo.
>>
> 
> Hi MyungJoo,
> Thanks for your suggestion. Here's the patch-v2, please have a look:
> 
> -- 
> Subject: [PATCH] devfreq: governor: Add a private governor_data for 
> governors in devfreq
> 
> The member void *data in the structure devfreq can be overwrite
> by governor_userspace. For example:
> 1. The device driver assigned the devfreq governor to simple_ondemand
> by the function devfreq_add_device() and init the devfreq member
> void *data to a pointer of a static structure devfreq_simple_ondemand_data
> by the function devfreq_add_device().
> 2. The user changed the devfreq governor to userspace by the command
> "echo userspace > /sys/class/devfreq/.../governor".
> 3. The governor userspace alloced a dynamic memory for the struct
> userspace_data and assigend the member void *data of devfreq to
> this memory by the function userspace_init().
> 4. The user changed the devfreq governor back to simple_ondemand
> by the command "echo simple_ondemand > /sys/class/devfreq/.../governor".
> 5. The governor userspace exited and assigned the member void *data
> in the structure devfreq to NULL by the function userspace_exit().
> 6. The governor simple_ondemand fetched the static information of
> devfreq_simple_ondemand_data in the function
> devfreq_simple_ondemand_func() but the member void *data of devfreq was
> assigned to NULL by the function userspace_exit().
> 7. The information of upthreshold and downdifferential is lost
> and the governor simple_ondemand can't work correctly.
> 
> The member void *data in the structure devfreq is designed for
> a static pointer used in a governor and inited by the function
> devfreq_add_device(). This patch add an element named governor_data
> in the devfreq structure which can be used by a governor(E.g userspace)
> who want to assign a private data to do some private things.
> 
> Signed-off-by: Kant Fan <kant@allwinnertech.com>
> ---
> 
> diff --git a/drivers/devfreq/governor_userspace.c 
> b/drivers/devfreq/governor_userspace.c
> index ab9db7a..d69672c 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -21,7 +21,7 @@
> 
>   static int devfreq_userspace_func(struct devfreq *df, unsigned long 
> *freq)
>   {
> -    struct userspace_data *data = df->data;
> +    struct userspace_data *data = df->governor_data;
> 
>       if (data->valid)
>           *freq = data->user_frequency;
> @@ -40,7 +40,7 @@
>       int err = 0;
> 
>       mutex_lock(&devfreq->lock);
> -    data = devfreq->data;
> +    data = devfreq->governor_data;
> 
>       sscanf(buf, "%lu", &wanted);
>       data->user_frequency = wanted;
> @@ -60,7 +60,7 @@
>       int err = 0;
> 
>       mutex_lock(&devfreq->lock);
> -    data = devfreq->data;
> +    data = devfreq->governor_data;
> 
>       if (data->valid)
>           err = sprintf(buf, "%lu\n", data->user_frequency);
> @@ -91,7 +91,7 @@
>           goto out;
>       }
>       data->valid = false;
> -    devfreq->data = data;
> +    devfreq->governor_data = data;
> 
>       err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
>   out:
> @@ -107,8 +107,8 @@
>       if (devfreq->dev.kobj.sd)
>           sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
> 
> -    kfree(devfreq->data);
> -    devfreq->data = NULL;
> +    kfree(devfreq->governor_data);
> +    devfreq->governor_data = NULL;
>   }
> 
>   static int devfreq_userspace_handler(struct devfreq *devfreq,
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 34aab4d..d265af3 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -152,8 +152,8 @@
>    * @max_state:        count of entry present in the frequency table.
>    * @previous_freq:    previously configured frequency value.
>    * @last_status:    devfreq user device info, performance statistics
> - * @data:    Private data of the governor. The devfreq framework does not
> - *        touch this.
> + * @data:    devfreq core pass to governors, governor should not change 
> it.
> + * @governor_data:    private data for governors, devfreq core doesn't 
> touch it.
>    * @user_min_freq_req:    PM QoS minimum frequency request from user 
> (via sysfs)
>    * @user_max_freq_req:    PM QoS maximum frequency request from user 
> (via sysfs)
>    * @scaling_min_freq:    Limit minimum frequency requested by OPP 
> interface
> @@ -193,7 +193,8 @@
>       unsigned long previous_freq;
>       struct devfreq_dev_status last_status;
> 
> -    void *data; /* private data for governors */
> +    void *data;
> +    void *governor_data;
> 
>       struct dev_pm_qos_request user_min_freq_req;
>       struct dev_pm_qos_request user_max_freq_req;
> 

Hi MyungJoo,
Sorry to disturb. Just want to say that I'm looking forward to your 
advice on this patch. Thank you :>

-- 
Best Regards,
Kant Fan
