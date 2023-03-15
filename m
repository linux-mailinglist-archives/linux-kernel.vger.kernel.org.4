Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91536BAA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjCOHwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjCOHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:52:27 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564756FFF5;
        Wed, 15 Mar 2023 00:52:05 -0700 (PDT)
Received: from [192.168.1.190] (ip5b426bea.dynamic.kabel-deutschland.de [91.66.107.234])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C79C61CC457B;
        Wed, 15 Mar 2023 08:52:02 +0100 (CET)
Message-ID: <37a0cd0f-2613-e2de-286f-b762312f6c3e@molgen.mpg.de>
Date:   Wed, 15 Mar 2023 08:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
Content-Language: en-US
To:     Marc Smith <msmith626@gmail.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
 <55e30408-ac63-965f-769f-18be5fd5885c@molgen.mpg.de>
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
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <CAH6h+hf7Y-kurBJG+pnH6WCQiaEK+Jq3KG5JOGnHJ4Uw6AbUjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can just comment, that the simple patch I proposed at https://lore.kernel.org/linux-raid/bc342de0-98d2-1733-39cd-cc1999777ff3@molgen.mpg.de/ works for us with several different kernel versions and currently 195 raid6 jbods on 105 systems going through several "idle->sync->idle" transitions each month for over two years now.

So if you suffer from the problem and are able to add patches to the kernel you use, you might give it a try.

Best
   Donald

On 3/14/23 14:25, Marc Smith wrote:
> On Mon, Feb 8, 2021 at 7:49 PM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:t
>>
>> Hi Donald,
>>
>> On 2/8/21 19:41, Donald Buczek wrote:
>>> Dear Guoqing,
>>>
>>> On 08.02.21 15:53, Guoqing Jiang wrote:
>>>>
>>>>
>>>> On 2/8/21 12:38, Donald Buczek wrote:
>>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
>>>>>> sync_thread, like this.
>>>>>>
>>>>>>           /* resync has finished, collect result */
>>>>>>           mddev_unlock(mddev);
>>>>>>           md_unregister_thread(&mddev->sync_thread);
>>>>>>           mddev_lock(mddev);
>>>>>
>>>>> As above: While we wait for the sync thread to terminate, wouldn't it
>>>>> be a problem, if another user space operation takes the mutex?
>>>>
>>>> I don't think other places can be blocked while hold mutex, otherwise
>>>> these places can cause potential deadlock. Please try above two lines
>>>> change. And perhaps others have better idea.
>>>
>>> Yes, this works. No deadlock after >11000 seconds,
>>>
>>> (Time till deadlock from previous runs/seconds: 1723, 37, 434, 1265,
>>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
>>
>> Great. I will send a formal patch with your reported-by and tested-by.
>>
>> Thanks,
>> Guoqing
> 
> I'm still hitting this issue with Linux 5.4.229 -- it looks like 1/2
> of the patches that supposedly resolve this were applied to the stable
> kernels, however, one was omitted due to a regression:
> md: don't unregister sync_thread with reconfig_mutex held (upstream
> commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
> 
> I don't see any follow-up on the thread from June 8th 2022 asking for
> this patch to be dropped from all stable kernels since it caused a
> regression.
> 
> The patch doesn't appear to be present in the current mainline kernel
> (6.3-rc2) either. So I assume this issue is still present there, or it
> was resolved differently and I just can't find the commit/patch.
> 
> I can induce the issue by using Donald's script above which will
> eventually result in hangs:
> ...
> 147948.504621] INFO: task md_test_2.sh:68033 blocked for more than 122 seconds.
> [147948.504624]       Tainted: P           OE     5.4.229-esos.prod #1
> [147948.504624] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [147948.504625] md_test_2.sh    D    0 68033      1 0x00000004
> [147948.504627] Call Trace:
> [147948.504634]  __schedule+0x4ab/0x4f3
> [147948.504637]  ? usleep_range+0x7a/0x7a
> [147948.504638]  schedule+0x67/0x81
> [147948.504639]  schedule_timeout+0x2c/0xe5
> [147948.504643]  ? do_raw_spin_lock+0x2b/0x52
> [147948.504644]  __wait_for_common+0xc4/0x13a
> [147948.504647]  ? wake_up_q+0x40/0x40
> [147948.504649]  kthread_stop+0x9a/0x117
> [147948.504653]  md_unregister_thread+0x43/0x4d
> [147948.504655]  md_reap_sync_thread+0x1c/0x1d5
> [147948.504657]  action_store+0xc9/0x284
> [147948.504658]  md_attr_store+0x9f/0xb8
> [147948.504661]  kernfs_fop_write+0x10a/0x14c
> [147948.504664]  vfs_write+0xa0/0xdd
> [147948.504666]  ksys_write+0x71/0xba
> [147948.504668]  do_syscall_64+0x52/0x60
> [147948.504671]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> ...
> [147948.504748] INFO: task md120_resync:135315 blocked for more than
> 122 seconds.
> [147948.504749]       Tainted: P           OE     5.4.229-esos.prod #1
> [147948.504749] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [147948.504749] md120_resync    D    0 135315      2 0x80004000
> [147948.504750] Call Trace:
> [147948.504752]  __schedule+0x4ab/0x4f3
> [147948.504754]  ? printk+0x53/0x6a
> [147948.504755]  schedule+0x67/0x81
> [147948.504756]  md_do_sync+0xae7/0xdd9
> [147948.504758]  ? remove_wait_queue+0x41/0x41
> [147948.504759]  md_thread+0x128/0x151
> [147948.504761]  ? _raw_spin_lock_irqsave+0x31/0x5d
> [147948.504762]  ? md_start_sync+0xdc/0xdc
> [147948.504763]  kthread+0xe4/0xe9
> [147948.504764]  ? kthread_flush_worker+0x70/0x70
> [147948.504765]  ret_from_fork+0x35/0x40
> ...
> 
> This happens on 'raid6' MD RAID arrays that initially have sync_action==resync.
> 
> Any guidance would be greatly appreciated.
> 
> --Marc

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
