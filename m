Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F765B84EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiINJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiINJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:26:02 -0400
Received: from out29-197.mail.aliyun.com (out29-197.mail.aliyun.com [115.124.29.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E5F84ED0;
        Wed, 14 Sep 2022 02:15:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07530093|-1;BR=01201311R111S72rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0124995-0.0136961-0.973804;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=kant@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.PFIoChB_1663146904;
Received: from 192.168.220.136(mailfrom:kant@allwinnertech.com fp:SMTPD_---.PFIoChB_1663146904)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 17:15:22 +0800
Message-ID: <a040e16c-e8e9-f550-7251-99ec1d18f508@allwinnertech.com>
Date:   Wed, 14 Sep 2022 17:15:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Kant Fan <kant@allwinnertech.com>
Subject: Re: [RESEND] devfreq: governor: Save void *data in the governor
 userspace
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
References: <20220329091449.105308-1-kant@allwinnertech.com>
Content-Language: en-US
In-Reply-To: <20220329091449.105308-1-kant@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2022 5:14 PM, Kant Fan wrote:
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
> devfreq_add_device(). So if a governor want to use void *data
> to do some other things, it must save void *data in the init()
> function and restore void *data in the exit() function.
> 
> Signed-off-by: Kant Fan <kant@allwinnertech.com>
> ---
>   drivers/devfreq/governor_userspace.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index ab9db7adb3ad..dbbb448dcbcf 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -17,6 +17,7 @@
>   struct userspace_data {
>   	unsigned long user_frequency;
>   	bool valid;
> +	void *saved_data;
>   };
>   
>   static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
> @@ -91,6 +92,7 @@ static int userspace_init(struct devfreq *devfreq)
>   		goto out;
>   	}
>   	data->valid = false;
> +	data->saved_data = devfreq->data;
>   	devfreq->data = data;
>   
>   	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
> @@ -100,6 +102,8 @@ static int userspace_init(struct devfreq *devfreq)
>   
>   static void userspace_exit(struct devfreq *devfreq)
>   {
> +	struct userspace_data *data = devfreq->data;
> +	void *saved_data = data->saved_data;
>   	/*
>   	 * Remove the sysfs entry, unless this is being called after
>   	 * device_del(), which should have done this already via kobject_del().
> @@ -108,7 +112,7 @@ static void userspace_exit(struct devfreq *devfreq)
>   		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>   
>   	kfree(devfreq->data);
> -	devfreq->data = NULL;
> +	devfreq->data = saved_data;
>   }
>   
>   static int devfreq_userspace_handler(struct devfreq *devfreq,

Dear MyungJoo, Kyungmin & Chanwoo,
Gently ping this issue... Does this patch has a chance to be accepted?
This seems to be a bug in devfreq userspace governor, which affects the 
switching between governors -- When switching from userspace to 
ondemand, the ondemand governor would be invalid.
If there's any question, please let me know.
Thank you.

-- 
Best Regards,
Kant Fan
