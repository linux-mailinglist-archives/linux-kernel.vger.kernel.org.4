Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE93A69EC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBVBtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:48:58 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCBDEB50;
        Tue, 21 Feb 2023 17:48:55 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PLzXJ14Rhz16Nhf;
        Wed, 22 Feb 2023 09:46:24 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Feb 2023 09:48:52 +0800
Subject: Re: [PATCH] md: fix null-ptr-deference in md_free_disk()
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
CC:     <song@kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
References: <20230221135506.296074-1-yukuai1@huaweicloud.com>
 <CALTww2-eUz7__wmu6Cbxs0yV3OGD23WggRUbn6ry_z+W9MApKA@mail.gmail.com>
 <CALTww29pPRCx_U10yZsUvytoj6vhvE3_v2Mum_7hxHsa21+qCA@mail.gmail.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <ac760b7a-f19e-a02b-f7b2-a9e7974c3e93@huawei.com>
Date:   Wed, 22 Feb 2023 09:48:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww29pPRCx_U10yZsUvytoj6vhvE3_v2Mum_7hxHsa21+qCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/02/22 8:41, Xiao Ni 写道:
> Sorry, the patch was missed in the last email.
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 927a43db5dfb..f5480778e2f7 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6256,6 +6256,11 @@ static void __md_stop(struct mddev *mddev)
>                  mddev->to_remove = &md_redundancy_group;
>          module_put(pers->owner);
>          clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +
> +       percpu_ref_exit(&mddev->writes_pending);
> +       percpu_ref_exit(&mddev->active_io);
> +       bioset_exit(&mddev->bio_set);
> +       bioset_exit(&mddev->sync_set);
>   }
> 

This change pass my test, feel free to add:
Tested-by: Yu Kuai <yukuai3@huawei.com>

>   void md_stop(struct mddev *mddev)
> @@ -6265,10 +6270,6 @@ void md_stop(struct mddev *mddev)
>           */
>          __md_stop_writes(mddev);
>          __md_stop(mddev);
> -       percpu_ref_exit(&mddev->writes_pending);
> -       percpu_ref_exit(&mddev->active_io);
> -       bioset_exit(&mddev->bio_set);
> -       bioset_exit(&mddev->sync_set);
>   }
> 
>   EXPORT_SYMBOL_GPL(md_stop);
> @@ -7839,11 +7840,6 @@ static void md_free_disk(struct gendisk *disk)
>   {
>          struct mddev *mddev = disk->private_data;
> 
> -       percpu_ref_exit(&mddev->writes_pending);
> -       percpu_ref_exit(&mddev->active_io);
> -       bioset_exit(&mddev->bio_set);
> -       bioset_exit(&mddev->sync_set);
> -
>          mddev_free(mddev);
>   }
> 
> If we release those memories in md_free_disk, it's hard to find the
> corresponding relationship between alloc memory and free memory.
> If we free memory in __md_stop, it's easy to find the right place where
> those memories are free.
> 
> Best Regards
> Xiao
> 
> 
> On Wed, Feb 22, 2023 at 8:39 AM Xiao Ni <xni@redhat.com> wrote:
>>
>> Hi Yu Kuai
>>
>> Thanks for reporting this problem.
>>
>> For creating raid device, md raid calls do_md_run->md_run, dm raid
>> calls md_run. We alloc those memory in md_run.
>> For stopping raid device, md raid calls do_md_stop->__md_stop, dm raid
>> calls md_stop->__md_stop.
>>
>> So how about this patch:
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 927a43db5dfb..f5480778e2f7 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>>
>> On Tue, Feb 21, 2023 at 9:33 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> If md_run() failed after 'acitive_io' is initialized, then
>>> percpu_ref_exit() is called in error path, however, later md_free_disk()
>>> will call percpu_ref_exit() again, which lead to following
>>> null-ptr-deference:
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000038
>>> Oops: 0000 [#1] PREEMPT SMP
>>> CPU: 41 PID: 585 Comm: kworker/41:1 Not tainted 6.2.0-rc8-next-20230220 #1452
>>> Workqueue: md_misc mddev_delayed_delete
>>> RIP: 0010:free_percpu+0x110/0x630
>>> Call Trace:
>>>   <TASK>
>>>   __percpu_ref_exit+0x44/0x70
>>>   percpu_ref_exit+0x16/0x90
>>>   md_free_disk+0x2f/0x80
>>>   disk_release+0x101/0x180
>>>   device_release+0x84/0x110
>>>   kobject_put+0x12a/0x380
>>>   kobject_put+0x160/0x380
>>>   mddev_delayed_delete+0x19/0x30
>>>   process_one_work+0x269/0x680
>>>   worker_thread+0x266/0x640
>>>   kthread+0x151/0x1b0
>>>   ret_from_fork+0x1f/0x30
>>>
>>> Since freeing mddev will exit 'active_io' unconditionally, fix the
>>> problem by removing exiting 'active_io' from error path, this way
>>> it will be delayed to free mddev.
>>>
>>> Fixes: 72adae23a72c ("md: Change active_io to percpu")
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/md.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 927a43db5dfb..77124679b3fd 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -5851,7 +5851,7 @@ int md_run(struct mddev *mddev)
>>>          if (!bioset_initialized(&mddev->bio_set)) {
>>>                  err = bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
>>>                  if (err)
>>> -                       goto exit_active_io;
>>> +                       return err;
>>>          }
>>>          if (!bioset_initialized(&mddev->sync_set)) {
>>>                  err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
>>> @@ -6039,8 +6039,6 @@ int md_run(struct mddev *mddev)
>>>          bioset_exit(&mddev->sync_set);
>>>   exit_bio_set:
>>>          bioset_exit(&mddev->bio_set);
>>> -exit_active_io:
>>> -       percpu_ref_exit(&mddev->active_io);
>>>          return err;
>>>   }
>>>   EXPORT_SYMBOL_GPL(md_run);
>>> --
>>> 2.31.1
>>>
> 
> .
> 
