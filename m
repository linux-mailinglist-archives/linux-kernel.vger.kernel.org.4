Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD36C5C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCWBgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCWBge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:36:34 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A1618A9F;
        Wed, 22 Mar 2023 18:36:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PhnxR2kYSz4f405s;
        Thu, 23 Mar 2023 09:36:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiAbrRtk9ZaYFQ--.45131S3;
        Thu, 23 Mar 2023 09:36:29 +0800 (CST)
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, logang@deltatee.com,
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
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <31e7f59e-579a-7812-632d-059ed0a6d441@huaweicloud.com>
Date:   Thu, 23 Mar 2023 09:36:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b91ae03a-14d5-11eb-8ec7-3ed91ff2c59e@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiAbrRtk9ZaYFQ--.45131S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15ZFyruryrAF48KrWfXwb_yoWrAFWUp3
        yfA3W3J3ykKrW8AFyjyw10qFyrXw1Ut39xJrn3GFy3Aw1YyryIqay3XFWq9FZ8ArZ5Cw1j
        vF1rGa95ZryYyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/22 22:32, Guoqing Jiang 写道:
>>> Could you explain how the same work can be re-queued? Isn't the 
>>> PENDING_BIT
>>> is already set in t3? I believe queue_work shouldn't do that per the 
>>> comment
>>> but I am not expert ...
>>
>> This is not related to workqueue, it is just because raid10
>> reinitialize the work that is already queued, 
> 
> I am trying to understand the possibility.
> 
>> like I discribed later in t3:
>>
>> t2:
>> md_check_recovery:
>>  INIT_WORK -> clear pending
>>  queue_work -> set pending
>>   list_add_tail
>> ...
>>
>> t3: -> work is still pending
>> md_check_recovery:
>>  INIT_WORK -> clear pending
>>  queue_work -> set pending
>>   list_add_tail -> list is corrupted
> 
> First, t2 and t3 can't be run in parallel since reconfig_mutex must be 
> held. And if sync_thread existed,
> the second process would unregister and reap sync_thread which means the 
> second process will
> call INIT_WORK and queue_work again.
> 
> Maybe your description is valid, I would prefer call work_pending and 
> flush_workqueue instead of
> INIT_WORK and queue_work.

This is not enough, it's right this can avoid list corruption, but the
worker function md_start_sync just register a sync_thread, and
md_do_sync() can still in progress, hence this can't prevent a new
sync_thread to start while the old one is not done, some other problems
like deadlock can still be triggered.

>> Of course, our 5.10 and mainline are the same,
>>
>> there are some tests:
>>
>> First the deadlock can be reporduced reliably, test script is simple:
>>
>> mdadm -Cv /dev/md0 -n 4 -l10 /dev/sd[abcd]
> 
> So this is raid10 while the previous problem was appeared in raid456, I 
> am not sure it is the same
> issue, but let's see.

Ok, I'm not quite familiar with raid456 yet, however, the problem is
still related to that action_store hold mutex to unregister sync_thread,
right?

>> Then, the problem MD_RECOVERY_RUNNING can be cleared can't be reporduced
>> reliably, usually it takes 2+ days to triggered a problem, and each time
>> problem phenomenon can be different, I'm hacking the kernel and add
>> some BUG_ON to test MD_RECOVERY_RUNNING in attached patch, following
>> test can trigger the BUG_ON:
> 
> Also your debug patch obviously added large delay which make the 
> calltrace happen, I doubt
> if user can hit it in real life. Anyway, will try below test from my side.
> 
>> mdadm -Cv /dev/md0 -e1.0 -n 4 -l 10 /dev/sd{a..d} --run
>> sleep 5
>> echo 1 > /sys/module/md_mod/parameters/set_delay
>> echo idle > /sys/block/md0/md/sync_action &
>> sleep 5
>> echo "want_replacement" > /sys/block/md0/md/dev-sdd/state
>>
>> test result:
>>
>> [  228.390237] md_check_recovery: running is set
>> [  228.391376] md_check_recovery: queue new sync thread
>> [  233.671041] action_store unregister success! delay 10s
>> [  233.689276] md_check_recovery: running is set
>> [  238.722448] md_check_recovery: running is set
>> [  238.723328] md_check_recovery: queue new sync thread
>> [  238.724851] md_do_sync: before new wor, sleep 10s
>> [  239.725818] md_do_sync: delay done
>> [  243.674828] action_store delay done
>> [  243.700102] md_reap_sync_thread: running is cleared!
>> [  243.748703] ------------[ cut here ]------------
>> [  243.749656] kernel BUG at drivers/md/md.c:9084!
> 
> After your debug patch applied, is L9084 points to below?
> 
> 9084                                 mddev->curr_resync = MaxSector;

In my environment, it's a BUG_ON() that I added in md_do_sync:

9080  skip:
9081         /* set CHANGE_PENDING here since maybe another update is 
needed,
9082         ┊* so other nodes are informed. It should be harmless for 
normal
9083         ┊* raid */
9084         BUG_ON(!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
9085         set_mask_bits(&mddev->sb_flags, 0,
9086                 ┊     BIT(MD_SB_CHANGE_PENDING) | 
BIT(MD_SB_CHANGE_DEVS));

> 
> I don't understand how it triggers below calltrace, and it has nothing 
> to do with
> list corruption, right?

Yes, this is just a early BUG_ON() to detect that if MD_RECOVERY_RUNNING
is cleared while sync_thread is still in progress.

Thanks,
Kuai

