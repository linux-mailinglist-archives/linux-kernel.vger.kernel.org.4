Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213377141EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjE2CT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2CT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:19:56 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A732AC;
        Sun, 28 May 2023 19:19:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QTzkX3Wfcz4f3khv;
        Mon, 29 May 2023 10:19:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7PEC3RkD4rGKQ--.59819S3;
        Mon, 29 May 2023 10:19:50 +0800 (CST)
Subject: Re: [PATCH -next v2 7/7] md/raid1-10: limit the number of plugged bio
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, akpm@osdl.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
 <20230426082031.1299149-8-yukuai1@huaweicloud.com>
 <CALTww2-yTsHXNFgkAVu0v++HHahZCnvXEUv2qJqbvcGUhKanDw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5e9852fe-0d47-92fc-f6a9-16d028d09ad4@huaweicloud.com>
Date:   Mon, 29 May 2023 10:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2-yTsHXNFgkAVu0v++HHahZCnvXEUv2qJqbvcGUhKanDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7PEC3RkD4rGKQ--.59819S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7GFyfXF1xZr1fJFyUAwb_yoWrZFW3pa
        1Dta4Y9FWUXrWUZw4qq3WUuFyFqw4vgFWUCrZYk3yfAF9rXFyUWa15JFWrWr1DZF9xWFy7
        Z3Z8KrZxWFn8tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
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

在 2023/05/29 10:08, Xiao Ni 写道:
> Hi Kuai
> 
> There is a limitation of the memory in your test. But for most
> situations, customers should not set this. Can this change introduce a
> performance regression against other situations?

Noted that this limitation is just to triggered writeback as soon as
possible in the test, and it's 100% sure real situations can trigger
dirty pages write back asynchronously and continue to produce new dirty
pages.

If a lot of bio is not plugged, then it's the same as before; if a lot
of bio is plugged, noted that before this patchset, these bio will spent
quite a long time in plug, and hence I think performance should be
better.

Thanks,
Kuai
> 
> Best Regards
> Xiao
> 
> On Wed, Apr 26, 2023 at 4:24 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> bio can be added to plug infinitely, and following writeback test can
>> trigger huge amount of plugged bio:
>>
>> Test script:
>> modprobe brd rd_nr=4 rd_size=10485760
>> mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
>> echo 0 > /proc/sys/vm/dirty_background_ratio
>> echo 60 > /proc/sys/vm/dirty_ratio
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
>> index 98d678b7df3f..35fb80aa37aa 100644
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
>> @@ -127,7 +129,7 @@ static inline void md_submit_write(struct bio *bio)
>>   }
>>
>>   static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>> -                                     blk_plug_cb_fn unplug)
>> +                                     blk_plug_cb_fn unplug, int copies)
>>   {
>>          struct raid1_plug_cb *plug = NULL;
>>          struct blk_plug_cb *cb;
>> @@ -147,6 +149,11 @@ static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>>
>>          plug = container_of(cb, struct raid1_plug_cb, cb);
>>          bio_list_add(&plug->pending, bio);
>> +       if (++plug->count / MAX_PLUG_BIO >= copies) {
>> +               list_del(&cb->list);
>> +               cb->callback(cb, false);
>> +       }
>> +
>>
>>          return true;
>>   }
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 639e09cecf01..c6066408a913 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>>                                                r1_bio->sector);
>>                  /* flush_pending_writes() needs access to the rdev so...*/
>>                  mbio->bi_bdev = (void *)rdev;
>> -               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
>> +               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug, disks)) {
>>                          spin_lock_irqsave(&conf->device_lock, flags);
>>                          bio_list_add(&conf->pending_bio_list, mbio);
>>                          spin_unlock_irqrestore(&conf->device_lock, flags);
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index bd9e655ca408..7135cfaf75db 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
>>
>>          atomic_inc(&r10_bio->remaining);
>>
>> -       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
>> +       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->copies)) {
>>                  spin_lock_irqsave(&conf->device_lock, flags);
>>                  bio_list_add(&conf->pending_bio_list, mbio);
>>                  spin_unlock_irqrestore(&conf->device_lock, flags);
>> --
>> 2.39.2
>>
> 
> .
> 

