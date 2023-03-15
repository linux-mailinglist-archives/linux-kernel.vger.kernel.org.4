Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0656BAC30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjCOJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjCOJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:30:30 -0400
Received: from out-14.mta1.migadu.com (out-14.mta1.migadu.com [IPv6:2001:41d0:203:375::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6637E7C977
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:30:26 -0700 (PDT)
Message-ID: <9dc19483-de0f-e8c6-bf18-10c33d0a35fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678872624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4HfRN4eTowTpZTYHTA6C8zGizb12G32fGkhr7WYMEg=;
        b=b+Vp3PoMkFTPrgLxDu9McW1jyWoI2PGuhcbOO9zzK9qOXXXvcex8Kq0jipj1Y0ej9PXWLt
        s8IzgFNuwX14JbBxb4XVeUYR7IVKDPlgW6SWkaoCziXmvylOwo2vaFqZaShA54ctq+GW+D
        KIuqs3XaXo6O3GPt+PqHVgq2efpNHAg=
Date:   Wed, 15 Mar 2023 17:30:21 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Yu Kuai <yukuai3@huawei.com>, Marc Smith <msmith626@gmail.com>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
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
 <60829bc7-2eb9-f4ca-1a36-d2dbda5b0f3e@huawei.com>
Content-Language: en-US
In-Reply-To: <60829bc7-2eb9-f4ca-1a36-d2dbda5b0f3e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/23 11:02, Yu Kuai wrote:
>
>
> 在 2023/03/14 21:55, Guoqing Jiang 写道:
>>
>>
>> On 3/14/23 21:25, Marc Smith wrote:
>>> On Mon, Feb 8, 2021 at 7:49 PM Guoqing Jiang
>>> <guoqing.jiang@cloud.ionos.com> wrote:
>>>> Hi Donald,
>>>>
>>>> On 2/8/21 19:41, Donald Buczek wrote:
>>>>> Dear Guoqing,
>>>>>
>>>>> On 08.02.21 15:53, Guoqing Jiang wrote:
>>>>>>
>>>>>> On 2/8/21 12:38, Donald Buczek wrote:
>>>>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
>>>>>>>> sync_thread, like this.
>>>>>>>>
>>>>>>>>           /* resync has finished, collect result */
>>>>>>>>           mddev_unlock(mddev);
>>>>>>>> md_unregister_thread(&mddev->sync_thread);
>>>>>>>>           mddev_lock(mddev);
>>>>>>> As above: While we wait for the sync thread to terminate, 
>>>>>>> wouldn't it
>>>>>>> be a problem, if another user space operation takes the mutex?
>>>>>> I don't think other places can be blocked while hold mutex, 
>>>>>> otherwise
>>>>>> these places can cause potential deadlock. Please try above two 
>>>>>> lines
>>>>>> change. And perhaps others have better idea.
>>>>> Yes, this works. No deadlock after >11000 seconds,
>>>>>
>>>>> (Time till deadlock from previous runs/seconds: 1723, 37, 434, 1265,
>>>>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
>>>> Great. I will send a formal patch with your reported-by and tested-by.
>>>>
>>>> Thanks,
>>>> Guoqing
>>> I'm still hitting this issue with Linux 5.4.229 -- it looks like 1/2
>>> of the patches that supposedly resolve this were applied to the stable
>>> kernels, however, one was omitted due to a regression:
>>> md: don't unregister sync_thread with reconfig_mutex held (upstream
>>> commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
> Hi, Guoqing,
>
> Just borrow this thread to discuss, I think this commit might have
> problem in some corner cases:
>
> t1:                t2:
> action_store
>  mddev_lock
>   if (mddev->sync_thread)
>    mddev_unlock
>    md_unregister_thread
>                 md_check_recovery
>                  set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
>                  queue_work(md_misc_wq, &mddev->del_work)
>    mddev_lock_nointr
>    md_reap_sync_thread
>    // clear running
>  mddev_lock
>
> t3:
> md_start_sync
> // running is not set

What does 'running' mean? MD_RECOVERY_RUNNING?

> Our test report a problem that can be cause by this in theory, by we
> can't be sure for now...

I guess you tried to describe racy between

action_store -> md_register_thread

and

md_start_sync -> md_register_thread

Didn't you already fix them in the series?

[PATCH -next 0/5] md: fix uaf for sync_thread

Sorry, I didn't follow the problem and also your series, I might try your
test with latest mainline kernel if the test is available somewhere.

> We thought about how to fix this, instead of calling
> md_register_thread() here to wait for sync_thread to be done
> synchronisely,

IMO, md_register_thread just create and wake a thread, not sure why it
waits for sync_thread.

> we do this asynchronously like what md_set_readonly() and  
> do_md_stop() does.

Still, I don't have clear picture about the problem, so I can't judge it.

Thanks,
Guoqing
