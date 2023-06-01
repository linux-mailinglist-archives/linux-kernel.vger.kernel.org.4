Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD389719023
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFABmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFABmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:42:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C4121;
        Wed, 31 May 2023 18:41:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWplQ4Kygz4f3mVt;
        Thu,  1 Jun 2023 09:41:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLNi93dkxrmlKg--.39177S3;
        Thu, 01 Jun 2023 09:41:55 +0800 (CST)
Subject: Re: [PATCH -next v3 7/7] md/raid1-10: limit the number of plugged bio
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
 <20230529131106.2123367-8-yukuai1@huaweicloud.com>
 <CALTww29JCfgQivaEqi3dAvTrfxT9bhN6Rj04fyXRRJF2DfNHyg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f618a509-5c96-b512-7bec-d0edd3db7b02@huaweicloud.com>
Date:   Thu, 1 Jun 2023 09:41:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww29JCfgQivaEqi3dAvTrfxT9bhN6Rj04fyXRRJF2DfNHyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLNi93dkxrmlKg--.39177S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWfGFWkZry5KF4UuFyrCrg_yoWrAFW7pw
        4Uta4Y9FWUXrWUu3yDXa1UuFyFqw4qqFWUCr95C3y3JFy7WFW7Wa15JFWrGF1DZFZxWry7
        A3Z8K39xuFs8tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/31 23:42, Xiao Ni 写道:
> On Mon, May 29, 2023 at 9:14 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> bio can be added to plug infinitely, and following writeback test can
>> trigger huge amount of plugged bio:
>>
>> Test script:
>> modprobe brd rd_nr=4 rd_size=10485760
>> mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean --bitmap=internal
>> echo 0 > /proc/sys/vm/dirty_background_ratio
>> fio -filename=/dev/md0 -ioengine=libaio -rw=write -bs=4k -numjobs=1 -iodepth=128 -name=test
>>
>> Test result:
>> Monitor /sys/block/md0/inflight will found that inflight keep increasing
>> until fio finish writing, after running for about 2 minutes:
>>
>> [root@fedora ~]# cat /sys/block/md0/inflight
>>         0  4474191
>>
>> Fix the problem by limiting the number of plugged bio based on the number
>> of copies for original bio.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid1-10.c | 9 ++++++++-
>>   drivers/md/raid1.c    | 2 +-
>>   drivers/md/raid10.c   | 2 +-
>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
>> index 17e55c1fd5a1..bb1e23b66c45 100644
>> --- a/drivers/md/raid1-10.c
>> +++ b/drivers/md/raid1-10.c
>> @@ -21,6 +21,7 @@
>>   #define IO_MADE_GOOD ((struct bio *)2)
>>
>>   #define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
>> +#define MAX_PLUG_BIO 32
>>
>>   /* for managing resync I/O pages */
>>   struct resync_pages {
>> @@ -31,6 +32,7 @@ struct resync_pages {
>>   struct raid1_plug_cb {
>>          struct blk_plug_cb      cb;
>>          struct bio_list         pending;
>> +       unsigned int            count;
>>   };
>>
>>   static void rbio_pool_free(void *rbio, void *data)
>> @@ -128,7 +130,7 @@ static inline void raid1_submit_write(struct bio *bio)
>>   }
>>
>>   static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>> -                                     blk_plug_cb_fn unplug)
>> +                                     blk_plug_cb_fn unplug, int copies)
>>   {
>>          struct raid1_plug_cb *plug = NULL;
>>          struct blk_plug_cb *cb;
>> @@ -148,6 +150,11 @@ static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>>
>>          plug = container_of(cb, struct raid1_plug_cb, cb);
>>          bio_list_add(&plug->pending, bio);
>> +       if (++plug->count / MAX_PLUG_BIO >= copies) {
>> +               list_del(&cb->list);
>> +               cb->callback(cb, false);
>> +       }
>> +
> It doesn't need this line here.
> 
> Have you done some performance tests with this patch set?

Just a simple fio script to test 4 ramdisk/loop 16thread 4k write in my
VM, and I didn't notice regression, however, I didn't run benchmarks
yet, I don't have such physical environment to test performance for
now...

I'll definitely run some performance tests in physical evironment later.

Thanks,
Kuai
> 
> Regards
> Xiao
>>
>>          return true;
>>   }
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 006620fed595..dc89a1c4b1f1 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>>                                                r1_bio->sector);
>>                  /* flush_pending_writes() needs access to the rdev so...*/
>>                  mbio->bi_bdev = (void *)rdev;
>> -               if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
>> +               if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug, disks)) {
>>                          spin_lock_irqsave(&conf->device_lock, flags);
>>                          bio_list_add(&conf->pending_bio_list, mbio);
>>                          spin_unlock_irqrestore(&conf->device_lock, flags);
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index fb22cfe94d32..9237dbeb07ba 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
>>
>>          atomic_inc(&r10_bio->remaining);
>>
>> -       if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
>> +       if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->copies)) {
>>                  spin_lock_irqsave(&conf->device_lock, flags);
>>                  bio_list_add(&conf->pending_bio_list, mbio);
>>                  spin_unlock_irqrestore(&conf->device_lock, flags);
>> --
>> 2.39.2
>>
> 
> .
> 

