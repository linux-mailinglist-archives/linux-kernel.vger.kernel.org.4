Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA4717935
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEaH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjEaH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:56:37 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30FB1B6;
        Wed, 31 May 2023 00:55:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWM4f4J0qz4f44nR;
        Wed, 31 May 2023 15:55:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbFh_XZkoPtsKg--.6305S3;
        Wed, 31 May 2023 15:55:15 +0800 (CST)
Subject: Re: [PATCH -next v3 6/7] md/raid1-10: don't handle pluged bio by
 daemon thread
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
 <20230529131106.2123367-7-yukuai1@huaweicloud.com>
 <CALTww29ixKpcVknNe36D+x=2c1Aw-=z32SP-dJ_Hj8WxL2n4bg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <830352e1-ecfa-f5dc-ce7c-349553bd3003@huaweicloud.com>
Date:   Wed, 31 May 2023 15:55:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww29ixKpcVknNe36D+x=2c1Aw-=z32SP-dJ_Hj8WxL2n4bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbFh_XZkoPtsKg--.6305S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw15CF4UCw43XFWxtr1kXwb_yoW7Aw47p3
        yjqa15tFWUJrW2vwsFvF48uFyFqa1qgFW7CrZ5Cws5WF9xXF97Ga1rGFW8WrykZr13GFyx
        Zr15Kr98GF4YvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/31 15:50, Xiao Ni 写道:
> On Mon, May 29, 2023 at 9:14 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> current->bio_list will be set under submit_bio() context, in this case
>> bitmap io will be added to the list and wait for current io submission to
>> finish, while current io submission must wait for bitmap io to be done.
>> commit 874807a83139 ("md/raid1{,0}: fix deadlock in bitmap_unplug.") fix
>> the deadlock by handling plugged bio by daemon thread.
> 
> Thanks for the historic introduction. I did a test and printed the
> logs in raid10_unplug. The tools I used are dd and mkfs. from_schedule
> is always true during I/O and it's 0 when io finishes. So I have a
> question here, how can I trigger the condition that from_schedule is 0
> and current->list is not NULL? In other words, is there really a
> deadlock here? Before your patch it looks like all bios are merged
> into conf->pending_bio_list and are handled by raid10d. It can't
> submit bio directly in the originating process which mentioned in
> 57c67df48866
> 
As I mentioned below, after commit a214b949d8e3, this deadlock doesn't
exist anymore, and without this patch, patch 7 will introduce this
scenario again.

Thanks,
Kuai
>>
>> On the one hand, the deadlock won't exist after commit a214b949d8e3
>> ("blk-mq: only flush requests from the plug in blk_mq_submit_bio"). On
>> the other hand, current solution makes it impossible to flush plugged bio
>> in raid1/10_make_request(), because this will cause that all the writes
>> will goto daemon thread.
>>
>> In order to limit the number of plugged bio, commit 874807a83139
>> ("md/raid1{,0}: fix deadlock in bitmap_unplug.") is reverted, and the
>> deadlock is fixed by handling bitmap io asynchronously.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid1-10.c | 14 ++++++++++++++
>>   drivers/md/raid1.c    |  4 ++--
>>   drivers/md/raid10.c   |  8 +++-----
>>   3 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
>> index 73cc3cb9154d..17e55c1fd5a1 100644
>> --- a/drivers/md/raid1-10.c
>> +++ b/drivers/md/raid1-10.c
>> @@ -151,3 +151,17 @@ static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>>
>>          return true;
>>   }
>> +
>> +/*
>> + * current->bio_list will be set under submit_bio() context, in this case bitmap
>> + * io will be added to the list and wait for current io submission to finish,
>> + * while current io submission must wait for bitmap io to be done. In order to
>> + * avoid such deadlock, submit bitmap io asynchronously.
>> + */
>> +static inline void raid1_prepare_flush_writes(struct bitmap *bitmap)
>> +{
>> +       if (current->bio_list)
>> +               md_bitmap_unplug_async(bitmap);
>> +       else
>> +               md_bitmap_unplug(bitmap);
>> +}
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 0778e398584c..006620fed595 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -794,7 +794,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>   static void flush_bio_list(struct r1conf *conf, struct bio *bio)
>>   {
>>          /* flush any pending bitmap writes to disk before proceeding w/ I/O */
>> -       md_bitmap_unplug(conf->mddev->bitmap);
>> +       raid1_prepare_flush_writes(conf->mddev->bitmap);
> 
> If we unplug bitmap asynchronously, can we make sure the bitmap are
> flushed before the corresponding data?
> 
> Regards
> Xiao
> 
>>          wake_up(&conf->wait_barrier);
>>
>>          while (bio) { /* submit pending writes */
>> @@ -1166,7 +1166,7 @@ static void raid1_unplug(struct blk_plug_cb *cb, bool from_schedule)
>>          struct r1conf *conf = mddev->private;
>>          struct bio *bio;
>>
>> -       if (from_schedule || current->bio_list) {
>> +       if (from_schedule) {
>>                  spin_lock_irq(&conf->device_lock);
>>                  bio_list_merge(&conf->pending_bio_list, &plug->pending);
>>                  spin_unlock_irq(&conf->device_lock);
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 6640507ecb0d..fb22cfe94d32 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -902,9 +902,7 @@ static void flush_pending_writes(struct r10conf *conf)
>>                  __set_current_state(TASK_RUNNING);
>>
>>                  blk_start_plug(&plug);
>> -               /* flush any pending bitmap writes to disk
>> -                * before proceeding w/ I/O */
>> -               md_bitmap_unplug(conf->mddev->bitmap);
>> +               raid1_prepare_flush_writes(conf->mddev->bitmap);
>>                  wake_up(&conf->wait_barrier);
>>
>>                  while (bio) { /* submit pending writes */
>> @@ -1108,7 +1106,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
>>          struct r10conf *conf = mddev->private;
>>          struct bio *bio;
>>
>> -       if (from_schedule || current->bio_list) {
>> +       if (from_schedule) {
>>                  spin_lock_irq(&conf->device_lock);
>>                  bio_list_merge(&conf->pending_bio_list, &plug->pending);
>>                  spin_unlock_irq(&conf->device_lock);
>> @@ -1120,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
>>
>>          /* we aren't scheduling, so we can do the write-out directly. */
>>          bio = bio_list_get(&plug->pending);
>> -       md_bitmap_unplug(mddev->bitmap);
>> +       raid1_prepare_flush_writes(mddev->bitmap);
>>          wake_up(&conf->wait_barrier);
>>
>>          while (bio) { /* submit pending writes */
>> --
>> 2.39.2
>>
> 
> .
> 

