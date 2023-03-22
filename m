Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C36C4DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCVOdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCVOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:33:42 -0400
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C6023119
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:33:11 -0700 (PDT)
Message-ID: <b91ae03a-14d5-11eb-8ec7-3ed91ff2c59e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679495554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SRYokyGovx2tLntDs2fsGNYRANFbvMkAvUBXmuNL4A=;
        b=W8CqgiqQPCpiyxyvZxJDpVhypoyPX3amvFt5ZzsM/oq9xSjr9edj/mZxbN3fCAXYaIBiE/
        hZ48ssq6B5F423lWovfj29ASf97WHA/opbbE8nwpLyKtegET6fR9wCTQxBfkW99NTjTKeo
        fFylyaoOgJgm2427nq1HJFXlGdwtzZI=
Date:   Wed, 22 Mar 2023 22:32:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Marc Smith <msmith626@gmail.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
 <20230322064122.2384589-2-yukuai1@huaweicloud.com>
 <2c2599ec-ac35-6494-aedf-93ecca1969ee@linux.dev>
 <d1d27b2a-96ec-319e-4690-64e781c9a473@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <d1d27b2a-96ec-319e-4690-64e781c9a473@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/23 17:00, Yu Kuai wrote:
> Hi,
>
> 在 2023/03/22 15:19, Guoqing Jiang 写道:
>>
>>
>> On 3/22/23 14:41, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> This reverts commit 9dfbdafda3b34e262e43e786077bab8e476a89d1.
>>>
>>> Because it will introduce a defect that sync_thread can be running 
>>> while
>>> MD_RECOVERY_RUNNING is cleared, which will cause some unexpected 
>>> problems,
>>> for example:
>>>
>>> list_add corruption. prev->next should be next (ffff0001ac1daba0), 
>>> but was ffff0000ce1a02a0. (prev=ffff0000ce1a02a0).
>>> Call trace:
>>>   __list_add_valid+0xfc/0x140
>>>   insert_work+0x78/0x1a0
>>>   __queue_work+0x500/0xcf4
>>>   queue_work_on+0xe8/0x12c
>>>   md_check_recovery+0xa34/0xf30
>>>   raid10d+0xb8/0x900 [raid10]
>>>   md_thread+0x16c/0x2cc
>>>   kthread+0x1a4/0x1ec
>>>   ret_from_fork+0x10/0x18
>>>
>>> This is because work is requeued while it's still inside workqueue:
>>
>> If the workqueue subsystem can have such problem because of md flag,
>> then I have to think workqueue is fragile.
>>
>>> t1:            t2:
>>> action_store
>>>   mddev_lock
>>>    if (mddev->sync_thread)
>>>     mddev_unlock
>>>     md_unregister_thread
>>>     // first sync_thread is done
>>>             md_check_recovery
>>>              mddev_try_lock
>>>              /*
>>>               * once MD_RECOVERY_DONE is set, new sync_thread
>>>               * can start.
>>>               */
>>>              set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
>>>              INIT_WORK(&mddev->del_work, md_start_sync)
>>>              queue_work(md_misc_wq, &mddev->del_work)
>>>               test_and_set_bit(WORK_STRUCT_PENDING_BIT, ...)
>>
>> Assume you mean below,
>>
>> 1551 if(!test_and_set_bit(WORK_STRUCT_PENDING_BIT, 
>> work_data_bits(work))) {
>> 1552                 __queue_work(cpu, wq, work);
>> 1553                 ret = true;
>> 1554         }
>>
>> Could you explain how the same work can be re-queued? Isn't the 
>> PENDING_BIT
>> is already set in t3? I believe queue_work shouldn't do that per the 
>> comment
>> but I am not expert ...
>
> This is not related to workqueue, it is just because raid10
> reinitialize the work that is already queued, 

I am trying to understand the possibility.

> like I discribed later in t3:
>
> t2:
> md_check_recovery:
>  INIT_WORK -> clear pending
>  queue_work -> set pending
>   list_add_tail
> ...
>
> t3: -> work is still pending
> md_check_recovery:
>  INIT_WORK -> clear pending
>  queue_work -> set pending
>   list_add_tail -> list is corrupted

First, t2 and t3 can't be run in parallel since reconfig_mutex must be 
held. And if sync_thread existed,
the second process would unregister and reap sync_thread which means the 
second process will
call INIT_WORK and queue_work again.

Maybe your description is valid, I would prefer call work_pending and 
flush_workqueue instead of
INIT_WORK and queue_work.

>
>>
>> Returns %false if @work was already on a queue, %true otherwise.
>>
>>>               // set pending bit
>>>               insert_work
>>>                list_add_tail
>>>              mddev_unlock
>>>     mddev_lock_nointr
>>>     md_reap_sync_thread
>>>     // MD_RECOVERY_RUNNING is cleared
>>>   mddev_unlock
>>>
>>> t3:
>>>
>>> // before queued work started from t2
>>> md_check_recovery
>>>   // MD_RECOVERY_RUNNING is not set, a new sync_thread can be started
>>>   INIT_WORK(&mddev->del_work, md_start_sync)
>>>    work->data = 0
>>>    // work pending bit is cleared
>>>   queue_work(md_misc_wq, &mddev->del_work)
>>>    insert_work
>>>     list_add_tail
>>>     // list is corrupted
>>>
>>> This patch revert the commit to fix the problem, the deadlock this
>>> commit tries to fix will be fixed in following patches.
>>
>> Pls cc the previous users who had encounter the problem to test the
>> second patch.
>
> Ok, cc Marc. Can you try if this patchset fix the problem you reproted
> in the following thread?
>
> md_raid: mdX_raid6 looping after sync_action "check" to "idle"
> transition
>>
>> And can you share your test which can trigger the re-queued issue?
>> I'd like to try with latest mainline such as 6.3-rc3, and your test is
>> not only run against 5.10 kernel as you described before, right?
>>
>
> Of course, our 5.10 and mainline are the same,
>
> there are some tests:
>
> First the deadlock can be reporduced reliably, test script is simple:
>
> mdadm -Cv /dev/md0 -n 4 -l10 /dev/sd[abcd]

So this is raid10 while the previous problem was appeared in raid456, I 
am not sure it is the same
issue, but let's see.

>
> fio -filename=/dev/md0 -rw=randwrite -direct=1 -name=a -bs=4k 
> -numjobs=16 -iodepth=16 &
>
> echo -1 > /sys/kernel/debug/fail_make_request/times
> echo 1 > /sys/kernel/debug/fail_make_request/probability
> echo 1 > /sys/block/sda/make-it-fail
>
> {
>         while true; do
>                 mdadm -f /dev/md0 /dev/sda
>                 mdadm -r /dev/md0 /dev/sda
>                 mdadm --zero-superblock /dev/sda
>                 mdadm -a /dev/md0 /dev/sda
>                 sleep 2
>         done
> } &
>
> {
>         while true; do
>                 mdadm -f /dev/md0 /dev/sdd
>                 mdadm -r /dev/md0 /dev/sdd
>                 mdadm --zero-superblock /dev/sdd
>                 mdadm -a /dev/md0 /dev/sdd
>                 sleep 10
>         done
> } &
>
> {
>         while true; do
>                 echo frozen > /sys/block/md0/md/sync_action
>                 echo idle > /sys/block/md0/md/sync_action
>                 sleep 0.1
>         done
> } &
>
> Then, the problem MD_RECOVERY_RUNNING can be cleared can't be reporduced
> reliably, usually it takes 2+ days to triggered a problem, and each time
> problem phenomenon can be different, I'm hacking the kernel and add
> some BUG_ON to test MD_RECOVERY_RUNNING in attached patch, following
> test can trigger the BUG_ON:

Also your debug patch obviously added large delay which make the 
calltrace happen, I doubt
if user can hit it in real life. Anyway, will try below test from my side.

> mdadm -Cv /dev/md0 -e1.0 -n 4 -l 10 /dev/sd{a..d} --run
> sleep 5
> echo 1 > /sys/module/md_mod/parameters/set_delay
> echo idle > /sys/block/md0/md/sync_action &
> sleep 5
> echo "want_replacement" > /sys/block/md0/md/dev-sdd/state
>
> test result:
>
> [  228.390237] md_check_recovery: running is set
> [  228.391376] md_check_recovery: queue new sync thread
> [  233.671041] action_store unregister success! delay 10s
> [  233.689276] md_check_recovery: running is set
> [  238.722448] md_check_recovery: running is set
> [  238.723328] md_check_recovery: queue new sync thread
> [  238.724851] md_do_sync: before new wor, sleep 10s
> [  239.725818] md_do_sync: delay done
> [  243.674828] action_store delay done
> [  243.700102] md_reap_sync_thread: running is cleared!
> [  243.748703] ------------[ cut here ]------------
> [  243.749656] kernel BUG at drivers/md/md.c:9084!

After your debug patch applied, is L9084 points to below?

9084                                 mddev->curr_resync = MaxSector;

I don't understand how it triggers below calltrace, and it has nothing 
to do with
list corruption, right?

>
> [  243.750548] invalid opcode: 0000 [#1] PREEMPT SMP
> [  243.752028] CPU: 6 PID: 1495 Comm: md0_resync Not tainted 
> 6.3.0-rc1-next-20230310-00001-g4b3965bcb967-dirty #47
> [  243.755030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
> 04/01/2014
> [  243.758516] RIP: 0010:md_do_sync+0x16a9/0x1b00
> [  243.759583] Code: ff 48 83 05 60 ce a7 0c 01 e9 8d f9 ff ff 48 83 
> 05 13 ce a7 0c 01 48 c7 c6 e9 e0 29 83 e9 3b f9 ff ff 48 83 05 5f d0 
> a7 0c 01 <0f> 0b 48 83 05 5d d0 a7 0c 01 e8 f8 d5 0b0
> [  243.763661] RSP: 0018:ffffc90003847d50 EFLAGS: 00010202
> [  243.764212] RAX: 0000000000000028 RBX: ffff88817b529000 RCX: 
> 0000000000000000
> [  243.764936] RDX: 0000000000000000 RSI: 0000000000000206 RDI: 
> ffff888100040740
> [  243.765648] RBP: 00000000002d6780 R08: 0101010101010101 R09: 
> ffff888165671d80
> [  243.766352] R10: ffffffff8ad6096c R11: ffff88816fcfa9f0 R12: 
> 0000000000000001
> [  243.767066] R13: ffff888173920040 R14: ffff88817b529000 R15: 
> 0000000000187100
> [  243.767781] FS:  0000000000000000(0000) GS:ffff888ffef80000(0000) 
> knlGS:0000000000000000
> [  243.768588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  243.769172] CR2: 00005599effa8451 CR3: 00000001663e6000 CR4: 
> 00000000000006e0
> [  243.769888] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  243.770598] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  243.771300] Call Trace:
> [  243.771555]  <TASK>
> [  243.771779]  ? kvm_clock_read+0x14/0x30
> [  243.772169]  ? kvm_sched_clock_read+0x9/0x20
> [  243.772611]  ? sched_clock_cpu+0x21/0x330
> [  243.773023]  md_thread+0x2ec/0x300
> [  243.773373]  ? md_write_start+0x420/0x420
> [  243.773845]  kthread+0x13e/0x1a0
> [  243.774210]  ? kthread_exit+0x50/0x50
> [  243.774591]  ret_from_fork+0x1f/0x30
>

Thanks,
Guoqing
