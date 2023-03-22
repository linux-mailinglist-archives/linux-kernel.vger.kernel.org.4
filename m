Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6706C45E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCVJM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCVJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:12:57 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED72705;
        Wed, 22 Mar 2023 02:12:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PhN6T0nNhz4f3l6w;
        Wed, 22 Mar 2023 17:12:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiCRxhpkabVwFQ--.48080S3;
        Wed, 22 Mar 2023 17:12:50 +0800 (CST)
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <283fcc3b-bf24-e473-94c5-ffe7e73bfd47@huaweicloud.com>
Date:   Wed, 22 Mar 2023 17:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiCRxhpkabVwFQ--.48080S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1UZF1rArW5Wry8tw13urg_yoWrGr4UpF
        ZxJF45tr1DWr13ua4jvFn7Gr4rGa9rAryfJry7K34Ivwn8X3ZIkFyvk3yDG3W0vr97KrWU
        XF1UXa4ruF1fAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Zr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
        IYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
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

Hi, Ming

ÔÚ 2023/03/22 15:58, Ming Lei Ð´µÀ:
> On Wed, Mar 22, 2023 at 11:59:26AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
>> set, and partition scan will be proceed again when blkdev_get_by_dev()
>> is called. However, this will cause a problem that re-assemble partitioned
>> raid device will creat partition for underlying disk.
>>
>> Test procedure:
>>
>> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
>> sgdisk -n 0:0:+100MiB /dev/md0
>> blockdev --rereadpt /dev/sda
>> blockdev --rereadpt /dev/sdb
>> mdadm -S /dev/md0
>> mdadm -A /dev/md0 /dev/sda /dev/sdb
>>
>> Test result: underlying disk partition and raid partition can be
>> observed at the same time
>>
>> Note that this can still happen in come corner cases that
>> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
>> device.
>>
>> Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> The issue still can't be avoided completely, such as, after rebooting,
> /dev/sda1 & /dev/md0p1 can be observed at the same time. And this one
> should be underlying partitions scanned before re-assembling raid, I
> guess it may not be easy to avoid.

Yes, this is possible and I don't know how to fix this yet...
> 
> Also seems the following change added in e5cfefa97bcc isn't necessary:
> 
>                  /* Make sure the first partition scan will be proceed */
>                  if (get_capacity(disk) && !(disk->flags & GENHD_FL_NO_PART) &&
>                      !test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
>                          set_bit(GD_NEED_PART_SCAN, &disk->state);
> 
> since the following disk_scan_partitions() in device_add_disk() should cover
> partitions scan.

This can't be guaranteed if someone else open the device excl after
bdev_add and before disk_scan_partitions:

t1: 			t2:
device_add_disk
  bdev_add
   insert_inode_hash
			// open device excl
  disk_scan_partitions
  // will fail

However, this is just in theory, and it's unlikely to happen in
practice.

Thanks,
Kuai
> 
>> ---
>>   block/genhd.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 08bb1a9ec22c..a72e27d6779d 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -368,7 +368,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>>   	if (disk->open_partitions)
>>   		return -EBUSY;
>>   
>> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
>>   	/*
>>   	 * If the device is opened exclusively by current thread already, it's
>>   	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
>> @@ -381,12 +380,19 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>>   			return ret;
>>   	}
>>   
>> +	set_bit(GD_NEED_PART_SCAN, &disk->state);
>>   	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
>>   	if (IS_ERR(bdev))
>>   		ret =  PTR_ERR(bdev);
>>   	else
>>   		blkdev_put(bdev, mode & ~FMODE_EXCL);
>>   
>> +	/*
>> +	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
>> +	 * and this will cause that re-assemble partitioned raid device will
>> +	 * creat partition for underlying disk.
>> +	 */
>> +	clear_bit(GD_NEED_PART_SCAN, &disk->state);
> 
> I feel GD_NEED_PART_SCAN becomes a bit hard to follow.
> 
> So far, it is only consumed by blkdev_get_whole(), and cleared in
> bdev_disk_changed(). That means partition scan can be retried
> if bdev_disk_changed() fails.
> 
> Another mess is that more drivers start to touch this flag, such as
> nbd/sd, probably it is better to change them into one API of
> blk_disk_need_partition_scan(), and hide implementation detail
> to drivers.
> 
> 
> thanks,
> Ming
> 
> .
> 

