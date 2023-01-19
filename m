Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB16733A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjASI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjASI0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:26:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1CF677B6;
        Thu, 19 Jan 2023 00:25:53 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NyFvD1XStzqV4k;
        Thu, 19 Jan 2023 16:20:56 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 16:25:50 +0800
Subject: Re: [PATCH 3/3] thermal: core: Use device_unregister() instead of
 device_del/put()
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
 <b31022f186287075f60f42facde01b3b42b06d7d.1674030722.git.viresh.kumar@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <63e19339-78fb-8107-1f41-418ec83a7bfe@huawei.com>
Date:   Thu, 19 Jan 2023 16:25:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b31022f186287075f60f42facde01b3b42b06d7d.1674030722.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
> Lets not open code device_unregister() unnecessarily.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
>   drivers/thermal/thermal_core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 1fb109a97ff6..9fb37c5d9c4f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1109,8 +1109,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>   
>   	mutex_unlock(&thermal_list_lock);
>   
> -	device_del(&cdev->device);
> -	put_device(&cdev->device);
> +	device_unregister(&cdev->device);
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>   
