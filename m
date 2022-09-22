Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33C55E64AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIVOGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:06:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C426ED5DD;
        Thu, 22 Sep 2022 07:06:33 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYH8N4jJnzHpt6;
        Thu, 22 Sep 2022 22:04:20 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 22:06:30 +0800
Subject: Re: [PATCH] scsi: libsas: fix use-after-free bug in
 smp_execute_task_sg
To:     Duoming Zhou <duoming@zju.edu.cn>, <linux-kernel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <kuba@kernel.org>,
        <john.garry@huawei.com>, <gregkh@linuxfoundation.org>,
        <davem@davemloft.net>
References: <20220920144213.10536-1-duoming@zju.edu.cn>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <9cd0b0ae-c6c7-a5bc-a834-a84010702bbc@huawei.com>
Date:   Thu, 22 Sep 2022 22:06:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220920144213.10536-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/20 22:42, Duoming Zhou wrote:
> When executing SMP task failed, the smp_execute_task_sg()
> calls del_timer() to delete the "slow_task->timer". However,
> if the timer handler sas_task_internal_timedout() is running,
> the del_timer() in smp_execute_task_sg() will not stop it
> and the UAF bug will happen. The process is shown below:
> 
>        (thread 1)               |        (thread 2)
> smp_execute_task_sg()          | sas_task_internal_timedout()
>   ...                           |
>   del_timer()                   |
>   ...                           |  ...
>   sas_free_task(task)           |
>    kfree(task->slow_task) //FREE|
>                                 |  task->slow_task->... //USE
> 
> Fix by calling del_timer_sync() in smp_execute_task_sg(),
> which makes sure the timer handler have finished before
> the "task->slow_task" is deallocated.
> 
> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/scsi/libsas/sas_expander.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index fa2209080cc..5ce25183010 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -67,7 +67,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
>   		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
>   
>   		if (res) {
> -			del_timer(&task->slow_task->timer);
> +			del_timer_sync(&task->slow_task->timer);
>   			pr_notice("executing SMP task failed:%d\n", res);
>   			break;
>   		}
> 

The timer should be triggered 10 seconds later. I am curious why we stay
this long before del_timer().

However this change looks good to me.
Reviewed-by: Jason Yan <yanaijie@huawei.com>
