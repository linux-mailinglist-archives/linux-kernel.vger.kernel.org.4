Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0988A6733A2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjASI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjASIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:25:34 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F805CE40;
        Thu, 19 Jan 2023 00:25:32 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NyFvY2syqzJqpM;
        Thu, 19 Jan 2023 16:21:13 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 16:25:28 +0800
Subject: Re: [PATCH 2/3] thermal: core: Move cdev cleanup to thermal_release()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1674030722.git.viresh.kumar@linaro.org>
 <d043f685320f4c5956293aff139b07034f24f0a5.1674030722.git.viresh.kumar@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <dee79e32-9824-e55c-37d6-69b2a329004e@huawei.com>
Date:   Thu, 19 Jan 2023 16:25:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d043f685320f4c5956293aff139b07034f24f0a5.1674030722.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/18 16:38, Viresh Kumar wrote:
> thermal_release() already frees cdev, let it do rest of the cleanup as
> well in order to simplify the error paths in
> __thermal_cooling_device_register().
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
>   drivers/thermal/thermal_core.c | 33 ++++++++++++++-------------------
>   1 file changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 77bd47d976a2..1fb109a97ff6 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -774,6 +774,9 @@ static void thermal_release(struct device *dev)
>   	} else if (!strncmp(dev_name(dev), "cooling_device",
>   			    sizeof("cooling_device") - 1)) {
>   		cdev = to_cooling_device(dev);
> +		thermal_cooling_device_destroy_sysfs(cdev);
> +		kfree(cdev->type);
> +		ida_free(&thermal_cdev_ida, cdev->id);
>   		kfree(cdev);
>   	}
>   }
> @@ -909,23 +912,21 @@ __thermal_cooling_device_register(struct device_node *np,
>   	cdev->devdata = devdata;
>   
>   	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
> -	if (ret) {
> -		kfree(cdev->type);
> -		goto out_ida_remove;
> -	}
> +	if (ret)
> +		goto out_cdev_type;
>   
>   	thermal_cooling_device_setup_sysfs(cdev);
>   
>   	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -	if (ret) {
> -		kfree(cdev->type);
> -		thermal_cooling_device_destroy_sysfs(cdev);
> -		goto out_ida_remove;
> -	}
> +	if (ret)
> +		goto out_cooling_dev;
>   
>   	ret = device_register(&cdev->device);
> -	if (ret)
> -		goto out_kfree_type;
> +	if (ret) {
> +		/* thermal_release() handles rest of the cleanup */
> +		put_device(&cdev->device);
> +		return ERR_PTR(ret);
> +	}
>   
>   	/* Add 'this' new cdev to the global cdev list */
>   	mutex_lock(&thermal_list_lock);
> @@ -944,13 +945,10 @@ __thermal_cooling_device_register(struct device_node *np,
>   
>   	return cdev;
>   
> -out_kfree_type:
> +out_cooling_dev:
>   	thermal_cooling_device_destroy_sysfs(cdev);
> +out_cdev_type:
>   	kfree(cdev->type);
> -	put_device(&cdev->device);
> -
> -	/* thermal_release() takes care of the rest */
> -	cdev = NULL;
>   out_ida_remove:
>   	ida_free(&thermal_cdev_ida, id);
>   out_kfree_cdev:
> @@ -1111,10 +1109,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>   
>   	mutex_unlock(&thermal_list_lock);
>   
> -	ida_free(&thermal_cdev_ida, cdev->id);
>   	device_del(&cdev->device);
> -	thermal_cooling_device_destroy_sysfs(cdev);
> -	kfree(cdev->type);
>   	put_device(&cdev->device);
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
