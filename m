Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2463ED65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLAKOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLAKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:14:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B89208E;
        Thu,  1 Dec 2022 02:14:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NNBkv0lQtz4f3l7D;
        Thu,  1 Dec 2022 18:14:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgCHL66Ifohjq42HBQ--.58049S3;
        Thu, 01 Dec 2022 18:14:34 +0800 (CST)
Subject: Re: [PATCH -next v2 9/9] blk-iocost: fix walk_list corruption
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-10-linan122@huawei.com>
 <Y4fEKZy4rTE5rG/5@slm.duckdns.org>
 <c028dd77-cabf-edd6-c893-8ee24762ac8c@huaweicloud.com>
 <Y4h7RxdT83g+zFN0@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <de04965e-1341-3053-0f4b-395b8390d00c@huaweicloud.com>
Date:   Thu, 1 Dec 2022 18:14:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4h7RxdT83g+zFN0@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHL66Ifohjq42HBQ--.58049S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1UAF1UKw4rJw4UZrykGrg_yoW8Zr4kpF
        WDWF9xC3yjgr42gayDXws8trnakwn5Kr48Jw18Ga1Fyryagw1xt3WkZr98GF48ZFsrJrW3
        Zr4Fg3y3CFWjk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

�� 2022/12/01 18:00, Tejun Heo д��:
> On Thu, Dec 01, 2022 at 09:19:54AM +0800, Yu Kuai wrote:
>>>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>>>> index 710cf63a1643..d2b873908f88 100644
>>>> --- a/block/blk-iocost.c
>>>> +++ b/block/blk-iocost.c
>>>> @@ -2813,13 +2813,14 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
>>>>    {
>>>>    	struct ioc *ioc = rqos_to_ioc(rqos);
>>>> +	del_timer_sync(&ioc->timer);
>>>> +
>>>>    	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
>>>>    	spin_lock_irq(&ioc->lock);
>>>>    	ioc->running = IOC_STOP;
>>>>    	spin_unlock_irq(&ioc->lock);
>>>> -	del_timer_sync(&ioc->timer);
>>>
>>> I don't about this workaround. Let's fix properly?
>>
>> Ok, and by the way, is there any reason to delete timer after
>> deactivate policy? This seems a litter wreid to me.
> 
> ioc->running is what controls whether the timer gets rescheduled or not. If
> we don't shut that down, the timer may as well get rescheduled after being
> deleted. Here, the only extra activation point is IO issue which shouldn't
> trigger during rq_qos_exit, so the ordering shouldn't matter but this is the
> right order for anything which can get restarted.

Thanks for the explanation.

I'm trying to figure out how to make sure child blkg pins it's parent,
btw, do you think following cleanup make sense?

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a645184aba4a..6ad8791af9d7 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2810,13 +2810,13 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
  {
         struct ioc *ioc = rqos_to_ioc(rqos);

-       blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
-
         spin_lock_irq(&ioc->lock);
         ioc->running = IOC_STOP;
         spin_unlock_irq(&ioc->lock);

         del_timer_sync(&ioc->timer);
+       blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
+
         free_percpu(ioc->pcpu_stat);
         kfree(ioc);
  }

Thanks,
Kuai

