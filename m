Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B27673364
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjASINU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:13:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665145BDD;
        Thu, 19 Jan 2023 00:13:15 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NyFh74YGwzRrHR;
        Thu, 19 Jan 2023 16:11:19 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 16:13:12 +0800
Subject: Re: [PATCH V4 1/3] thermal: core: call put_device() only after
 device_register() fails
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1674030722.git.viresh.kumar@linaro.org>
 <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <d7c05b81-3299-9ebe-b27d-06549290e3a1@huawei.com>
Date:   Thu, 19 Jan 2023 16:13:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> put_device() shouldn't be called before a prior call to
> device_register(). __thermal_cooling_device_register() doesn't follow
> that properly and needs fixing. Also
> thermal_cooling_device_destroy_sysfs() is getting called unnecessarily
> on few error paths.
>
> Fix all this by placing the calls at the right place.
>
> Based on initial work done by Caleb Connolly.
>
> Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
> For v6.2-rc.
>
> V3->V4:
> - The first three versions were sent by Caleb.
> - The new version fixes the current bugs, without looking to optimize the
>    code any further, which is done separately in the next two patches.
>
>   drivers/thermal/thermal_core.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..77bd47d976a2 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -909,15 +909,20 @@ __thermal_cooling_device_register(struct device_node *np,
>   	cdev->devdata = devdata;
>   
>   	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
> -	if (ret)
> -		goto out_kfree_type;
> +	if (ret) {
> +		kfree(cdev->type);
> +		goto out_ida_remove;
> +	}
>   
>   	thermal_cooling_device_setup_sysfs(cdev);
> +
>   	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>   	if (ret) {
> +		kfree(cdev->type);
>   		thermal_cooling_device_destroy_sysfs(cdev);
> -		goto out_kfree_type;
> +		goto out_ida_remove;
>   	}
> +
>   	ret = device_register(&cdev->device);
>   	if (ret)
>   		goto out_kfree_type;
> @@ -943,6 +948,8 @@ __thermal_cooling_device_register(struct device_node *np,
>   	thermal_cooling_device_destroy_sysfs(cdev);
>   	kfree(cdev->type);
>   	put_device(&cdev->device);
> +
> +	/* thermal_release() takes care of the rest */
>   	cdev = NULL;
>   out_ida_remove:
>   	ida_free(&thermal_cdev_ida, id);
