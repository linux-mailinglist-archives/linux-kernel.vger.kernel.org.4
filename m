Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9436717A05
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjEaIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjEaIZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:25:29 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C811C;
        Wed, 31 May 2023 01:25:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWMlN4jkyz4f3mWc;
        Wed, 31 May 2023 16:25:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JvBHdk_H1uKg--.24777S3;
        Wed, 31 May 2023 16:25:21 +0800 (CST)
Subject: Re: [PATCH -next v3 4/7] md/raid1-10: submit write io directly if
 bitmap is not enabled
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
 <20230529131106.2123367-5-yukuai1@huaweicloud.com>
 <CALTww2-mOkQR+Qu0s=TE-TFoR7D0tDaA=gOOJ75r-Z_43X1yEg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0f01b4dc-8eea-f3e9-43a4-c33084fa72a1@huaweicloud.com>
Date:   Wed, 31 May 2023 16:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2-mOkQR+Qu0s=TE-TFoR7D0tDaA=gOOJ75r-Z_43X1yEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77JvBHdk_H1uKg--.24777S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxZr1fJFy7XF1xWF1ftFb_yoW5Kryfp3
        yDGa4Ykry5JFy2qwnIva4DAFyrt3WktrZrKryfG345uFy3ZFsxGFWrGay5Kw1kCrnxCF4a
        vr15KFyDCr1YqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/31 15:26, Xiao Ni 写道:
> On Mon, May 29, 2023 at 9:14 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid10")
>> add bitmap support, and it changed that write io is submitted through
>> daemon thread because bitmap need to be updated before write io. And
>> later, plug is used to fix performance regression because all the write io
>> will go to demon thread, which means io can't be issued concurrently.
>>
>> However, if bitmap is not enabled, the write io should not go to daemon
>> thread in the first place, and plug is not needed as well.
>>
>> Fixes: 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid10")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md-bitmap.c |  4 +---
>>   drivers/md/md-bitmap.h |  7 +++++++
>>   drivers/md/raid1-10.c  | 13 +++++++++++--
>>   3 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
>> index ad5a3456cd8a..3ee590cf12a7 100644
>> --- a/drivers/md/md-bitmap.c
>> +++ b/drivers/md/md-bitmap.c
>> @@ -1016,7 +1016,6 @@ static int md_bitmap_file_test_bit(struct bitmap *bitmap, sector_t block)
>>          return set;
>>   }
>>
>> -
>>   /* this gets called when the md device is ready to unplug its underlying
>>    * (slave) device queues -- before we let any writes go down, we need to
>>    * sync the dirty pages of the bitmap file to disk */
>> @@ -1026,8 +1025,7 @@ void md_bitmap_unplug(struct bitmap *bitmap)
>>          int dirty, need_write;
>>          int writing = 0;
>>
>> -       if (!bitmap || !bitmap->storage.filemap ||
>> -           test_bit(BITMAP_STALE, &bitmap->flags))
>> +       if (!md_bitmap_enabled(bitmap))
>>                  return;
>>
>>          /* look at each page to see if there are any set bits that need to be
>> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
>> index cfd7395de8fd..3a4750952b3a 100644
>> --- a/drivers/md/md-bitmap.h
>> +++ b/drivers/md/md-bitmap.h
>> @@ -273,6 +273,13 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
>>                               sector_t *lo, sector_t *hi, bool clear_bits);
>>   void md_bitmap_free(struct bitmap *bitmap);
>>   void md_bitmap_wait_behind_writes(struct mddev *mddev);
>> +
>> +static inline bool md_bitmap_enabled(struct bitmap *bitmap)
>> +{
>> +       return bitmap && bitmap->storage.filemap &&
>> +              !test_bit(BITMAP_STALE, &bitmap->flags);
>> +}
>> +
>>   #endif
>>
>>   #endif
>> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
>> index 506299bd55cb..73cc3cb9154d 100644
>> --- a/drivers/md/raid1-10.c
>> +++ b/drivers/md/raid1-10.c
>> @@ -131,9 +131,18 @@ static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
>>                                        blk_plug_cb_fn unplug)
>>   {
>>          struct raid1_plug_cb *plug = NULL;
>> -       struct blk_plug_cb *cb = blk_check_plugged(unplug, mddev,
>> -                                                  sizeof(*plug));
>> +       struct blk_plug_cb *cb;
>> +
>> +       /*
>> +        * If bitmap is not enabled, it's safe to submit the io directly, and
>> +        * this can get optimal performance.
>> +        */
>> +       if (!md_bitmap_enabled(mddev->bitmap)) {
>> +               raid1_submit_write(bio);
>> +               return true;
>> +       }
> 
> Can we check this out of raid1_add_bio_to_plug and call
> raid1_submit_write directly in make_request function?

Of course we can, I'm trying to avoid redundant code here...

Thanks,
Kuai
> 
> Regards
> Xiao
>>
>> +       cb = blk_check_plugged(unplug, mddev, sizeof(*plug));
>>          if (!cb)
>>                  return false;
>>
>> --
>> 2.39.2
>>
> 
> .
> 

