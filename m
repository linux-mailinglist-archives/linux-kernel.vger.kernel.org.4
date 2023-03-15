Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893756BA570
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCODCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCODCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:02:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFAB521FA;
        Tue, 14 Mar 2023 20:02:42 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PbwCZ0THFzrSpq;
        Wed, 15 Mar 2023 11:01:46 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:02:38 +0800
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Marc Smith <msmith626@gmail.com>
CC:     Donald Buczek <buczek@molgen.mpg.de>, Song Liu <song@kernel.org>,
        <linux-raid@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <it+raid@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
 <d95aa962-9750-c27c-639a-2362bdb32f41@cloud.ionos.com>
 <30576384-682c-c021-ff16-bebed8251365@molgen.mpg.de>
 <cdc0b03c-db53-35bc-2f75-93bbca0363b5@molgen.mpg.de>
 <bc342de0-98d2-1733-39cd-cc1999777ff3@molgen.mpg.de>
 <c3390ab0-d038-f1c3-5544-67ae9c8408b1@cloud.ionos.com>
 <a27c5a64-62bf-592c-e547-1e8e904e3c97@molgen.mpg.de>
 <6c7008df-942e-13b1-2e70-a058e96ab0e9@cloud.ionos.com>
 <12f09162-c92f-8fbb-8382-cba6188bfb29@molgen.mpg.de>
 <6757d55d-ada8-9b7e-b7fd-2071fe905466@cloud.ionos.com>
 <93d8d623-8aec-ad91-490c-a414c4926fb2@molgen.mpg.de>
 <0bb7c8d8-6b96-ce70-c5ee-ba414de10561@cloud.ionos.com>
 <e271e183-20e9-8ca2-83eb-225d4d7ab5db@molgen.mpg.de>
 <1cdfceb6-f39b-70e1-3018-ea14dbe257d9@cloud.ionos.com>
 <7733de01-d1b0-e56f-db6a-137a752f7236@molgen.mpg.de>
 <d92922af-f411-fc53-219f-154de855cd13@cloud.ionos.com>
 <CAH6h+hf7Y-kurBJG+pnH6WCQiaEK+Jq3KG5JOGnHJ4Uw6AbUjg@mail.gmail.com>
 <2af18cf7-05eb-f1d1-616a-2c5894d1ac43@linux.dev>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <60829bc7-2eb9-f4ca-1a36-d2dbda5b0f3e@huawei.com>
Date:   Wed, 15 Mar 2023 11:02:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2af18cf7-05eb-f1d1-616a-2c5894d1ac43@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/03/14 21:55, Guoqing Jiang 写道:
> 
> 
> On 3/14/23 21:25, Marc Smith wrote:
>> On Mon, Feb 8, 2021 at 7:49 PM Guoqing Jiang
>> <guoqing.jiang@cloud.ionos.com> wrote:
>>> Hi Donald,
>>>
>>> On 2/8/21 19:41, Donald Buczek wrote:
>>>> Dear Guoqing,
>>>>
>>>> On 08.02.21 15:53, Guoqing Jiang wrote:
>>>>>
>>>>> On 2/8/21 12:38, Donald Buczek wrote:
>>>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
>>>>>>> sync_thread, like this.
>>>>>>>
>>>>>>>           /* resync has finished, collect result */
>>>>>>>           mddev_unlock(mddev);
>>>>>>>           md_unregister_thread(&mddev->sync_thread);
>>>>>>>           mddev_lock(mddev);
>>>>>> As above: While we wait for the sync thread to terminate, wouldn't it
>>>>>> be a problem, if another user space operation takes the mutex?
>>>>> I don't think other places can be blocked while hold mutex, otherwise
>>>>> these places can cause potential deadlock. Please try above two lines
>>>>> change. And perhaps others have better idea.
>>>> Yes, this works. No deadlock after >11000 seconds,
>>>>
>>>> (Time till deadlock from previous runs/seconds: 1723, 37, 434, 1265,
>>>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
>>> Great. I will send a formal patch with your reported-by and tested-by.
>>>
>>> Thanks,
>>> Guoqing
>> I'm still hitting this issue with Linux 5.4.229 -- it looks like 1/2
>> of the patches that supposedly resolve this were applied to the stable
>> kernels, however, one was omitted due to a regression:
>> md: don't unregister sync_thread with reconfig_mutex held (upstream
>> commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
Hi, Guoqing,

Just borrow this thread to discuss, I think this commit might have
problem in some corner cases:

t1:				t2:
action_store
  mddev_lock
   if (mddev->sync_thread)
    mddev_unlock
    md_unregister_thread
				md_check_recovery
				 set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
				 queue_work(md_misc_wq, &mddev->del_work)
    mddev_lock_nointr
    md_reap_sync_thread
    // clear running
  mddev_lock

t3:
md_start_sync
// running is not set

Our test report a problem that can be cause by this in theory, by we
can't be sure for now...

We thought about how to fix this, instead of calling
md_register_thread() here to wait for sync_thread to be done
synchronisely, we do this asynchronously like what md_set_readonly() and
do_md_stop() does.

What do you think?

Thanks,
Kuai
>>
>> I don't see any follow-up on the thread from June 8th 2022 asking for
>> this patch to be dropped from all stable kernels since it caused a
>> regression.
>>
>> The patch doesn't appear to be present in the current mainline kernel
>> (6.3-rc2) either. So I assume this issue is still present there, or it
>> was resolved differently and I just can't find the commit/patch.
> 
> It should be fixed by commit 9dfbdafda3b3"md: unlock mddev before reap
> sync_thread in action_store".
> 
> Thanks,
> Guoqing
> .
> 
