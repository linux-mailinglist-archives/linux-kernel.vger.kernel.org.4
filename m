Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392776C5D94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCWDwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjCWDve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:51:34 -0400
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F8E305FA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:50:53 -0700 (PDT)
Message-ID: <3fc2a539-e4cc-e057-6cf0-da7b3953be6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679543451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybg5x3mPlbI3ZHUIehsnRSB/BbMrlTIw6UpPqu0sdhM=;
        b=e07qC8bsMjxyFPwXnCmmYgpZoQ5i92lD6PPLkh7VCKCwNebCmfr0QTrmlBwtzUMhMEGavF
        p9DwfMNYP//dTUcGyDdMD2ubsuSChGOvLUVktr3HdkDJs/cN6PdvLqR4eG2UTEHZud74Ce
        9GMGo5q1g8IJU4SyHqTCN3xgqqRgx/A=
Date:   Thu, 23 Mar 2023 11:50:48 +0800
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
 <b91ae03a-14d5-11eb-8ec7-3ed91ff2c59e@linux.dev>
 <31e7f59e-579a-7812-632d-059ed0a6d441@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <31e7f59e-579a-7812-632d-059ed0a6d441@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/23 09:36, Yu Kuai wrote:
> Hi,
>
> 在 2023/03/22 22:32, Guoqing Jiang 写道:
>>>> Could you explain how the same work can be re-queued? Isn't the 
>>>> PENDING_BIT
>>>> is already set in t3? I believe queue_work shouldn't do that per 
>>>> the comment
>>>> but I am not expert ...
>>>
>>> This is not related to workqueue, it is just because raid10
>>> reinitialize the work that is already queued, 
>>
>> I am trying to understand the possibility.
>>
>>> like I discribed later in t3:
>>>
>>> t2:
>>> md_check_recovery:
>>>  INIT_WORK -> clear pending
>>>  queue_work -> set pending
>>>   list_add_tail
>>> ...
>>>
>>> t3: -> work is still pending
>>> md_check_recovery:
>>>  INIT_WORK -> clear pending
>>>  queue_work -> set pending
>>>   list_add_tail -> list is corrupted
>>
>> First, t2 and t3 can't be run in parallel since reconfig_mutex must 
>> be held. And if sync_thread existed,
>> the second process would unregister and reap sync_thread which means 
>> the second process will
>> call INIT_WORK and queue_work again.
>>
>> Maybe your description is valid, I would prefer call work_pending and 
>> flush_workqueue instead of
>> INIT_WORK and queue_work.
>
> This is not enough, it's right this can avoid list corruption, but the
> worker function md_start_sync just register a sync_thread, and
> md_do_sync() can still in progress, hence this can't prevent a new
> sync_thread to start while the old one is not done, some other problems
> like deadlock can still be triggered.
>
>>> Of course, our 5.10 and mainline are the same,
>>>
>>> there are some tests:
>>>
>>> First the deadlock can be reporduced reliably, test script is simple:
>>>
>>> mdadm -Cv /dev/md0 -n 4 -l10 /dev/sd[abcd]
>>
>> So this is raid10 while the previous problem was appeared in raid456, 
>> I am not sure it is the same
>> issue, but let's see.
>
> Ok, I'm not quite familiar with raid456 yet, however, the problem is
> still related to that action_store hold mutex to unregister sync_thread,
> right?

Yes and no, the previous raid456 bug also existed because it can't get 
stripe while
barrier is involved as you mentioned in patch 4, which is different.

>
>>> Then, the problem MD_RECOVERY_RUNNING can be cleared can't be 
>>> reporduced
>>> reliably, usually it takes 2+ days to triggered a problem, and each 
>>> time
>>> problem phenomenon can be different, I'm hacking the kernel and add
>>> some BUG_ON to test MD_RECOVERY_RUNNING in attached patch, following
>>> test can trigger the BUG_ON:
>>
>> Also your debug patch obviously added large delay which make the 
>> calltrace happen, I doubt
>> if user can hit it in real life. Anyway, will try below test from my 
>> side.
>>
>>> mdadm -Cv /dev/md0 -e1.0 -n 4 -l 10 /dev/sd{a..d} --run
>>> sleep 5
>>> echo 1 > /sys/module/md_mod/parameters/set_delay
>>> echo idle > /sys/block/md0/md/sync_action &
>>> sleep 5
>>> echo "want_replacement" > /sys/block/md0/md/dev-sdd/state

Combined your debug patch with above steps. Seems you are

1. add delay to action_store, so it can't get lock in time.
2. echo "want_replacement"**triggers md_check_recovery which can grab lock
     to start sync thread.
3. action_store finally hold lock to clear RECOVERY_RUNNING in reap sync 
thread.
4. Then the new added BUG_ON is invoked since RECOVERY_RUNNING is cleared
     in step 3.

>>>
>>> test result:
>>>
>>> [  228.390237] md_check_recovery: running is set
>>> [  228.391376] md_check_recovery: queue new sync thread
>>> [  233.671041] action_store unregister success! delay 10s
>>> [  233.689276] md_check_recovery: running is set
>>> [  238.722448] md_check_recovery: running is set
>>> [  238.723328] md_check_recovery: queue new sync thread
>>> [  238.724851] md_do_sync: before new wor, sleep 10s
>>> [  239.725818] md_do_sync: delay done
>>> [  243.674828] action_store delay done
>>> [  243.700102] md_reap_sync_thread: running is cleared!
>>> [  243.748703] ------------[ cut here ]------------
>>> [  243.749656] kernel BUG at drivers/md/md.c:9084!
>>
>> After your debug patch applied, is L9084 points to below?
>>
>> 9084                                 mddev->curr_resync = MaxSector;
>
> In my environment, it's a BUG_ON() that I added in md_do_sync:

Ok, so we are on different code base ...

> 9080  skip:
> 9081         /* set CHANGE_PENDING here since maybe another update is 
> needed,
> 9082         ┊* so other nodes are informed. It should be harmless for 
> normal
> 9083         ┊* raid */
> 9084         BUG_ON(!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> 9085         set_mask_bits(&mddev->sb_flags, 0,
> 9086                 ┊     BIT(MD_SB_CHANGE_PENDING) | 
> BIT(MD_SB_CHANGE_DEVS));
>
>>
>> I don't understand how it triggers below calltrace, and it has 
>> nothing to do with
>> list corruption, right?
>
> Yes, this is just a early BUG_ON() to detect that if MD_RECOVERY_RUNNING
> is cleared while sync_thread is still in progress.

sync_thread can be interrupted once MD_RECOVERY_INTR is set which means 
the RUNNING
can be cleared, so I am not sure the added BUG_ON is reasonable. And 
change BUG_ON
like this makes more sense to me.

+BUG_ON(!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
+!test_bit(MD_RECOVERY_INTR, &mddev->recovery));

I think there might be racy window like you described but it should be 
really small, I prefer
to just add a few lines like this instead of revert and introduce new 
lock to resolve the same
issue (if it is).

@@ -4792,9 +4793,15 @@action_store(struct mddev *mddev, const char 
*page, size_t len)
                        if (mddev->sync_thread) {
                                sector_t save_rp = mddev->reshape_position;

+set_bit(MD_RECOVERY_DONOT, &mddev->recovery);
@@ -4805,6 +4812,7 @@action_store(struct mddev *mddev, const char *page, 
size_t len)
                                mddev->reshape_position = save_rp;
                                set_bit(MD_RECOVERY_INTR, 
&mddev->recovery);
                                md_reap_sync_thread(mddev);
+clear_bit(MD_RECOVERY_DONOT, &mddev->recovery);
                        }
                        mddev_unlock(mddev);
@@ -9296,6 +9313,9 @@void md_check_recovery(struct mddev *mddev)
        if (!md_is_rdwr(mddev) &&
            !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
                return;
+/* action_store is in the middle of reap sync thread, let's wait */
+if (test_bit(MD_RECOVERY_DONOT, &mddev->recovery))
+return;
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -553,6 +553,7 @@enum recovery_flags {
        MD_RECOVERY_ERROR,      /* sync-action interrupted because 
io-error */
        MD_RECOVERY_WAIT,       /* waiting for pers->start() to finish */
        MD_RESYNCING_REMOTE,    /* remote node is running resync thread */
+MD_RECOVERY_DONOT,     /* for a nasty racy issue */
};

TBH, I am reluctant to see the changes in the series, it can only be 
considered
acceptable with conditions:

1. the previous raid456 bug can be fixed in this way too, hopefully Marc 
or others
     can verify it.
2. pass all the tests in mdadm.

Thanks,
Guoqing
