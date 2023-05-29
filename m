Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09D714243
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjE2DSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjE2DSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:18:48 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A7B1;
        Sun, 28 May 2023 20:18:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QV12V5Qn2z4f3mJM;
        Mon, 29 May 2023 11:18:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7ORGXRkW4rJKQ--.54725S3;
        Mon, 29 May 2023 11:18:43 +0800 (CST)
Subject: Re: [PATCH -next v2 7/7] md/raid1-10: limit the number of plugged bio
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, akpm@osdl.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
 <20230426082031.1299149-8-yukuai1@huaweicloud.com>
 <CALTww2-yTsHXNFgkAVu0v++HHahZCnvXEUv2qJqbvcGUhKanDw@mail.gmail.com>
 <5e9852fe-0d47-92fc-f6a9-16d028d09ad4@huaweicloud.com>
 <CALTww28ur_S0UpGQqq0TubSgkxGG7dicc1ZKrJ3Pno4CpSOWUw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <25279079-2600-b0d3-5279-caaf6f664d71@huaweicloud.com>
Date:   Mon, 29 May 2023 11:18:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww28ur_S0UpGQqq0TubSgkxGG7dicc1ZKrJ3Pno4CpSOWUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7ORGXRkW4rJKQ--.54725S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4UXF4DuF48Xry5Ar4UXFb_yoW7Aw45pw
        4Uta4YkFWUJrW7Xw1jq3WjvF1ftw4DWrWUZr95G343XF9FqFy7Wa15JFWrur1kZrnxGFy7
        ZFn8KrZxWF15tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/29 11:10, Xiao Ni 写道:
> On Mon, May 29, 2023 at 10:20 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/05/29 10:08, Xiao Ni 写道:
>>> Hi Kuai
>>>
>>> There is a limitation of the memory in your test. But for most
>>> situations, customers should not set this. Can this change introduce a
>>> performance regression against other situations?
>>
>> Noted that this limitation is just to triggered writeback as soon as
>> possible in the test, and it's 100% sure real situations can trigger
>> dirty pages write back asynchronously and continue to produce new dirty
>> pages.
> 
> Hi
> 
> I'm confused here. If we want to trigger write back quickly, it needs
> to set these two values with a smaller number, rather than 0 and 60.
> Right?

60 is not required, I'll remove this setting.

0 just means write back if there are any dirty pages.
>>
>> If a lot of bio is not plugged, then it's the same as before; if a lot
>> of bio is plugged, noted that before this patchset, these bio will spent
>> quite a long time in plug, and hence I think performance should be
>> better.
> 
> Hmm, it depends on if it's sequential or not? If it's a big io
> request, can it miss the merge opportunity?

The bio will still be merged to underlying disks' rq(if it's rq based),
underlying disk won't flush plug untill the number of request exceed
threshold.

Thanks,
Kuai
> 
> Regards
> Xiao
> 
>>
>> Thanks,
>> Kuai
>>>
>>> Best Regards
>>> Xiao
>>>
>>> On Wed, Apr 26, 2023 at 4:24 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> bio can be added to plug infinitely, and following writeback test can
>>>> trigger huge amount of plugged bio:
>>>>
>>>> Test script:
>>>> modprobe brd rd_nr=4 rd_size=10485760
>>>> mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
>>>> echo 0 > /proc/sys/vm/dirty_background_ratio
>>>> echo 60 > /proc/sys/vm/dirty_ratio
>>>> fio -filename=/dev/md0 -ioengine=libaio -rw=write -bs=4k -numjobs=1 -iodepth=128 -name=test
>>>>
>>>> Test result:
>>>> Monitor /sys/block/md0/inflight will found that inflight keep increasing
>>>> until fio finish writing, after running for about 2 minutes:
>>>>
>>>> [root@fedora ~]# cat /sys/block/md0/inflight
>>>>          0  4474191
>>>>
>>>> Fix the problem by limiting the number of plugged bio based on the number
>>>> of copies for original bio.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    drivers/md/raid1-10.c | 9 ++++++++-
>>>>    drivers/md/raid1.c    | 2 +-
>>>>    drivers/md/raid10.c   | 2 +-
>>>>    3 files changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
>>>> index 98d678b7df3f..35fb80aa37aa 100644
>>>> --- a/drivers/md/raid1-10.c
>>>> +++ b/drivers/md/raid1-10.c
>>>> @@ -21,6 +21,7 @@
>>>>    #define IO_MADE_GOOD ((struct bio *)2)
>>>>
>>>>    #define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
>>>> +#define MAX_PLUG_BIO 32
>>>>
>>>>    /* for managing resync I/O pages */
>>>>    struct resync_pages {
>>>> @@ -31,6 +32,7 @@ struct resync_pages {
>>>>    struct raid1_plug_cb {
>>>>           struct blk_plug_cb      cb;
>>>>           struct bio_list         pending;
>>>> +       unsigned int            count;
>>>>    };
>>>>
>>>>    static void rbio_pool_free(void *rbio, void *data)
>>>> @@ -127,7 +129,7 @@ static inline void md_submit_write(struct bio *bio)
>>>>    }
>>>>
>>>>    static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>>>> -                                     blk_plug_cb_fn unplug)
>>>> +                                     blk_plug_cb_fn unplug, int copies)
>>>>    {
>>>>           struct raid1_plug_cb *plug = NULL;
>>>>           struct blk_plug_cb *cb;
>>>> @@ -147,6 +149,11 @@ static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>>>>
>>>>           plug = container_of(cb, struct raid1_plug_cb, cb);
>>>>           bio_list_add(&plug->pending, bio);
>>>> +       if (++plug->count / MAX_PLUG_BIO >= copies) {
>>>> +               list_del(&cb->list);
>>>> +               cb->callback(cb, false);
>>>> +       }
>>>> +
>>>>
>>>>           return true;
>>>>    }
>>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>>> index 639e09cecf01..c6066408a913 100644
>>>> --- a/drivers/md/raid1.c
>>>> +++ b/drivers/md/raid1.c
>>>> @@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>>>>                                                 r1_bio->sector);
>>>>                   /* flush_pending_writes() needs access to the rdev so...*/
>>>>                   mbio->bi_bdev = (void *)rdev;
>>>> -               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
>>>> +               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug, disks)) {
>>>>                           spin_lock_irqsave(&conf->device_lock, flags);
>>>>                           bio_list_add(&conf->pending_bio_list, mbio);
>>>>                           spin_unlock_irqrestore(&conf->device_lock, flags);
>>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>>> index bd9e655ca408..7135cfaf75db 100644
>>>> --- a/drivers/md/raid10.c
>>>> +++ b/drivers/md/raid10.c
>>>> @@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
>>>>
>>>>           atomic_inc(&r10_bio->remaining);
>>>>
>>>> -       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
>>>> +       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->copies)) {
>>>>                   spin_lock_irqsave(&conf->device_lock, flags);
>>>>                   bio_list_add(&conf->pending_bio_list, mbio);
>>>>                   spin_unlock_irqrestore(&conf->device_lock, flags);
>>>> --
>>>> 2.39.2
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 

