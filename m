Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0049D730C97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjFOB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFOB2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:28:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759C2125;
        Wed, 14 Jun 2023 18:28:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QhPnr2GQ2z4f4DhP;
        Thu, 15 Jun 2023 09:28:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3mp5PaYpkU3_rLg--.4972S3;
        Thu, 15 Jun 2023 09:28:49 +0800 (CST)
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor
 idle/frozen_sync_thread() to fix deadlock
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        yangerkun@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com>
 <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com>
 <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
 <CALTww292gwOe-WEjuBwJn0AXvJC4AbfMZXC43EvVt3GCeBoHfw@mail.gmail.com>
 <5bf97ec5-0cb4-1163-6917-2bc98d912c2b@huaweicloud.com>
 <CALTww28UapJnK+Xfx7O9uEd5ZH2E7ufPT_7pKY6YYuzTZ0Fbdw@mail.gmail.com>
 <b96ec15b-6102-17bb-2c18-a487f224865b@huaweicloud.com>
 <CALTww2-knHOoX35NB73X-sMn1u8EJHLA=0aOnoVqVm83+fdG5Q@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <04700f85-62a2-1dbd-f330-80f9a13b7d2e@huaweicloud.com>
Date:   Thu, 15 Jun 2023 09:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2-knHOoX35NB73X-sMn1u8EJHLA=0aOnoVqVm83+fdG5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3mp5PaYpkU3_rLg--.4972S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF45JFy8Xr4xAr18trWUArb_yoWruw47pr
        y8AF1UGr4UAr47Z34Ut3WjvFW0y34UXF15Xr9xJry3Jwn5Kw4ftFW7CFW5uFykZFn5Jw1U
        ZrWrJFWfZFWqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/06/14 17:08, Xiao Ni 写道:
> On Wed, Jun 14, 2023 at 4:29 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/06/14 15:57, Xiao Ni 写道:
>>> On Wed, Jun 14, 2023 at 3:38 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2023/06/14 15:12, Xiao Ni 写道:
>>>>> On Wed, Jun 14, 2023 at 10:04 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> 在 2023/06/14 9:48, Yu Kuai 写道:
>>>>>>
>>>>>>
>>>>>>>>
>>>>>>>> In the patch, sync_seq is added in md_reap_sync_thread. In
>>>>>>>> idle_sync_thread, if sync_seq isn't equal
>>>>>>>>
>>>>>>>> mddev->sync_seq, it should mean there is someone that stops the sync
>>>>>>>> thread already, right? Why do
>>>>>>>>
>>>>>>>> you say 'new started sync thread' here?
>>>>>>
>>>>>> If someone stops the sync thread, and new sync thread is not started,
>>>>>> then this sync_seq won't make a difference, above wait_event() will not
>>>>>> wait because !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) will pass.
>>>>>> So 'sync_seq' is only used when the old sync thread stops and new sync
>>>>>> thread starts, add 'sync_seq' will bypass this case.
>>>>>
>>>>> Hi
>>>>>
>>>>> If a new sync thread starts, why can sync_seq be different? sync_seq
>>>>> is only added in md_reap_sync_thread. And when a new sync request
>>>>> starts, it can't stop the sync request again?
>>>>>
>>>>> Af first, the sync_seq is 0
>>>>>
>>>>> admin1
>>>>> echo idle > sync_action
>>>>> idle_sync_thread(sync_seq is 1)
>>>>
>>>> Wait, I'm confused here, how can sync_seq to be 1 here? I suppose you
>>>> mean that there is a sync_thread just finished?
>>>
>>> Hi Kuai
>>>
>>> Yes. Because idle_sync_thread needs to wait until md_reap_sync_thread
>>> finishes. And md_reap_sync_thread adds sync_seq. Do I understand your
>>> patch right?
>>
>> Yes, noted that idle_sync_thread() will only wait if MD_RECOVERY_RUNNING
>> is set.
>>
>>>
>>>>
>>>> Then the problem is that idle_sync_thread() read sync_seq after the old
>>>> sync_thread is done, and new sync_thread start before wait_event() is
>>>> called, should we wait for this new sync_thread?
>>>>
>>>> My answer here is that we should, but I'm also ok to not wait this new
>>>> sync_thread, I don't think this behaviour matters. The key point here
>>>> is that once wait_event() is called from idle_sync_thread(), this
>>>> wait_event() should not wait for new sync_thread...
>>>
>>> I think we should wait. If we don't wait for it, there is a problem.
>>> One person echos idle to sync_action and it doesn't work sometimes.
>>> It's a strange thing.
>>>
>>
>> Ok. I'll add new comment to emphasize that idle_sync_thread() won't wait
>> for new sync_thread that is started after wait_event().
> 
> I suggest removing this function. Without this change, it's more
> simple and it can work well without problem. The people that echo idle
> to sync_action needs to wait until the sync action finishes. The code
> semantic is clear and simple.
>>
>>>>
>>>>> echo resync > sync_action (new sync)
>>>>
>>>> If this is behind "echo idle > sync_action", idle_sync_thread should not
>>>> see that MD_RECOVERY_RUNNING is set and wait_event() won't wait at all.
>>>
>>> `echo resync > sync_action` can't change the sync_seq. So 'echo idle >
>>> sync_action' still waits until MD_RECOVERY_RUNNING is cleared?
>>
>> This is not accurate, if `echo resync > sync_action` triggers a new
>> sync_thread, then sync_seq is updated when this sync_thread is done,
>> during this period, MD_RECOVERY_RUNNING is still set, so `echo idle
>>   >sync_action` will wait for sync_thread to be done.
> 
> I can understand your comment, but sorry, I still can't get how
> sync_seq works. Could you give a specific case that explains how it
> works?

Ok, the problem is that echo ilde is supposed to interrupt sync_thread
and stop sync_thread quickly. Now that we don't hold mutex here, we
can't prevent new sync_thread to start. For exapmle:

1) a sync_thread A is runing, MD_RECOVERY_RUNNING is set;

2) echo idle, A will be interrupted, mutex is not hold and
idle_sync_thread() is waiting for MD_RECOVERY_RUNNING to be cleared.

3) A is interrupted, it'll clear MD_RECOVERY_RUNNING and try to wakeup
idle_sync_thread(), however, before idle_sync_thread() is woken, A can
be done and a new sync_thread B can be started, and MD_RECOVERY_RUNNING
will be set again.

4) idle_sync_thread() finially wake up, however, MD_RECOVERY_RUNNING is
set and it will still waiting. And this time B won't be interrupted.

Thanks,
Kuai

