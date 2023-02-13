Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0437F693C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBMCln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:41:41 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4DBB86;
        Sun, 12 Feb 2023 18:41:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PFTB41m1Jz4f3jQb;
        Mon, 13 Feb 2023 10:41:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyFco+ljYBHZDA--.37464S3;
        Mon, 13 Feb 2023 10:41:34 +0800 (CST)
Subject: Re: [PATCH -next RFC 2/3] block: factor out the setting of
 GD_NEED_PART_SCAN
To:     Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai1@huaweicloud.com>,
        hch@infradead.org, jack@suse.cz, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
 <20230212092641.2394146-3-yukuai1@huaweicloud.com>
 <9b0b9059-c0f6-df5b-863a-987970f3567d@suse.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8eeacd36-6f35-230c-1c93-074c63eee08f@huaweicloud.com>
Date:   Mon, 13 Feb 2023 10:41:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9b0b9059-c0f6-df5b-863a-987970f3567d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyFco+ljYBHZDA--.37464S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWfXF1DZw4UXFWDXFy7Wrg_yoW5XFW7pr
        n5JFW5tryjgrn3WFyjqF1DXry5G3WDtwn7JryUJF10vr43JrnFqF4jgryqgr1UJrZ7Jr4U
        Xr1UXryxZF1xAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/02/12 19:36, Hannes Reinecke 写道:
> On 2/12/23 10:26, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> In order to prevent scan partition for a device that is opened
>> exclusively by someone else, new conditions will be added to
>> disk_scan_partitions() in the next patch. Hence if device is opened
>> exclusively between bdev_add() and disk_scan_partitions(), the first
>> partition scan will fail unexpected. This patch factor out the setting
>> of GD_NEED_PART_SCAN to prevent the problem.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/genhd.c | 2 +-
>>   block/ioctl.c | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 075d8da284f5..c0d1220bd798 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -367,7 +367,6 @@ int disk_scan_partitions(struct gendisk *disk, 
>> fmode_t mode)
>>       if (disk->open_partitions)
>>           return -EBUSY;
>> -    set_bit(GD_NEED_PART_SCAN, &disk->state);
>>       bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
>>       if (IS_ERR(bdev))
>>           return PTR_ERR(bdev);
>> @@ -493,6 +492,7 @@ int __must_check device_add_disk(struct device 
>> *parent, struct gendisk *disk,
>>           if (ret)
>>               goto out_unregister_bdi;
>> +        set_bit(GD_NEED_PART_SCAN, &disk->state);
>>           bdev_add(disk->part0, ddev->devt);
>>           if (get_capacity(disk))
>>               disk_scan_partitions(disk, FMODE_READ);
> Usual caveat:
> What happens if the flag is already set here?
> Wouldn't that imply that another scan is underway?

I think this is not true, currently set the state just means we're going
to scan, and if some checking failed, the state will be left. I don't
have a good idea how to fix this yet...

Thanks,
Kuai

> And wouldn't it be better to use 'test_and_set()'?
> 
> 
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 6dd49d877584..0eefcdb936a0 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -528,6 +528,7 @@ static int blkdev_common_ioctl(struct block_device 
>> *bdev, fmode_t mode,
>>               return -EACCES;
>>           if (bdev_is_partition(bdev))
>>               return -EINVAL;
>> +        set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>>           return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
>>       case BLKTRACESTART:
>>       case BLKTRACESTOP:
> Similar here.
> 
> Cheers,
> 
> Hannes

