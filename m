Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1876BACBB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjCOJz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjCOJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:55:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC758234B;
        Wed, 15 Mar 2023 02:53:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pc5Ll5s3sz4f42wH;
        Wed, 15 Mar 2023 17:53:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCKflRFkQ9HVEw--.36384S3;
        Wed, 15 Mar 2023 17:53:37 +0800 (CST)
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Marc Smith <msmith626@gmail.com>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de, "yukuai (C)" <yukuai3@huawei.com>
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
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
 <9dc19483-de0f-e8c6-bf18-10c33d0a35fd@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2cc75a4b-2df5-e8f0-cc01-f07210ba580f@huaweicloud.com>
Date:   Wed, 15 Mar 2023 17:53:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9dc19483-de0f-e8c6-bf18-10c33d0a35fd@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCKflRFkQ9HVEw--.36384S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUuw48Zw18uFW8KF45ZFb_yoWrJw4kpr
        Z5KFZxJrWUArZ7Zry8X3WUXFW8Awn7XasrJry3WFy3Cw15G3yaqay5ZFW29F9rZFZ3Ja13
        Xw15JFWFvrWDCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/15 17:30, Guoqing Jiang 写道:
> 
>> Just borrow this thread to discuss, I think this commit might have
>> problem in some corner cases:
>>
>> t1:                t2:
>> action_store
>>  mddev_lock
>>   if (mddev->sync_thread)
>>    mddev_unlock
>>    md_unregister_thread
>>                 md_check_recovery
>>                  set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
>>                  queue_work(md_misc_wq, &mddev->del_work)
>>    mddev_lock_nointr
>>    md_reap_sync_thread
>>    // clear running
>>  mddev_lock
>>
>> t3:
>> md_start_sync
>> // running is not set
> 
> What does 'running' mean? MD_RECOVERY_RUNNING?
> 
>> Our test report a problem that can be cause by this in theory, by we
>> can't be sure for now...
> 
> I guess you tried to describe racy between
> 
> action_store -> md_register_thread
> 
> and
> 
> md_start_sync -> md_register_thread
> 
> Didn't you already fix them in the series?
> 
> [PATCH -next 0/5] md: fix uaf for sync_thread
> 
> Sorry, I didn't follow the problem and also your series, I might try your
> test with latest mainline kernel if the test is available somewhere.
> 
>> We thought about how to fix this, instead of calling
>> md_register_thread() here to wait for sync_thread to be done
>> synchronisely,
> 
> IMO, md_register_thread just create and wake a thread, not sure why it
> waits for sync_thread.
> 
>> we do this asynchronously like what md_set_readonly() and do_md_stop() 
>> does.
> 
> Still, I don't have clear picture about the problem, so I can't judge it.
> 

Sorry that I didn't explain the problem clear. Let me explain the
problem we meet first:

1) raid10d is waiting for sync_thread to stop:
   raid10d
    md_unregister_thread
     kthread_stop

2) sync_thread is waiting for io to finish:
   md_do_sync
    wait_event(... atomic_read(&mddev->recovery_active) == 0)

3) io is waiting for raid10d to finish(online crash found 2 io in 
conf->retry_list)

Additional information from online crash:
mddev->recovery = 29, // DONE, RUNING, INTR is set

PID: 138293  TASK: ffff0000de89a900  CPU: 7   COMMAND: "md0_resync"
  #0 [ffffa00107c178a0] __switch_to at ffffa0010001d75c
  #1 [ffffa00107c178d0] __schedule at ffffa001017c7f14
  #2 [ffffa00107c179f0] schedule at ffffa001017c880c
  #3 [ffffa00107c17a20] md_do_sync at ffffa0010129cdb4
  #4 [ffffa00107c17d50] md_thread at ffffa00101290d9c
  #5 [ffffa00107c17e50] kthread at ffffa00100187a74

PID: 138294  TASK: ffff0000eba13d80  CPU: 5   COMMAND: "md0_resync"
  #0 [ffffa00107e47a60] __switch_to at ffffa0010001d75c
  #1 [ffffa00107e47a90] __schedule at ffffa001017c7f14
  #2 [ffffa00107e47bb0] schedule at ffffa001017c880c
  #3 [ffffa00107e47be0] schedule_timeout at ffffa001017d1298
  #4 [ffffa00107e47d50] md_thread at ffffa00101290ee8
  #5 [ffffa00107e47e50] kthread at ffffa00100187a74
// there are two sync_thread for md0

I believe the root cause is that two sync_thread exist for the same
mddev, and this is how I think this is possible:

t1:			t2:
action_store
  mddev_lock
   if (mddev->sync_thread)
    mddev_unlock
    md_unregister_thread
    // first sync_thread is done
			md_check_recovery
                  	 set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
                  	 queue_work(md_misc_wq, &mddev->del_work)
    mddev_lock_nointr
    md_reap_sync_thread
    // MD_RECOVERY_RUNNING is cleared
  mddev_unlock

t3:
md_start_sync
// second sync_thread is registed

t3:
md_check_recovery
  queue_work(md_misc_wq, &mddev->del_work)
  // MD_RECOVERY_RUNNING  is not set, a new sync_thread can be started

This is just guess, I can't reporduce the problem yet. Please let me
know if you have any questions

Thanks,
Kuai

