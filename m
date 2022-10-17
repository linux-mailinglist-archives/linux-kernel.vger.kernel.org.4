Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A78600A83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiJQJYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiJQJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:24:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4FE959B;
        Mon, 17 Oct 2022 02:24:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MrWj54Yv8zKFNQ;
        Mon, 17 Oct 2022 17:22:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCXmMpEH01jcy+kAQ--.60665S3;
        Mon, 17 Oct 2022 17:24:22 +0800 (CST)
Subject: Re: [PATCH RFC] block: fix use after free for bd_holder_dir/slave_dir
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, gregkh@linuxfoundation.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221012125838.1608619-1-yukuai1@huaweicloud.com>
 <Y00LTH0yk3obS22m@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dadef634-9ec3-aa7b-f1c0-65a98a0fafb1@huaweicloud.com>
Date:   Mon, 17 Oct 2022 17:24:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y00LTH0yk3obS22m@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXmMpEH01jcy+kAQ--.60665S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4kWw1fCFWfXryDZF43ZFb_yoW5ZFW5pF
        yrCayrJr4IqF4DuF4Utw4UJFWjga48tF1xuFyfKryIgrnrJrZ29FZ5CF1UuFn8Ars7Kr4q
        vr45JrWY9ayvkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, christoph!

ÔÚ 2022/10/17 15:59, Christoph Hellwig Ð´µÀ:
> AFAICS the problem is the that pre-registered holders don't get
> unregistered for a late add_disk failure.
> 
> Something like this should fix your error:
> 

I agree that this patch do make sense, however, it seems to me this
patch should fix the problem that kobject is leaked, not uaf... And I
verified that the problem can still be reporduced with this patch.

Some details about our error£º

while creating dm using sda, sda is removed. Thus device_add_disk() will
fail at bd_register_pending_holders() and and slave_dir is removed.
Then, later in dm error path, slave_dir is accessed again.

Perhaps refactor dm error path can fix this error, however, I still
think the root cause is lifecycle of slave_dir/bd_holder_dir, and there
are still probably other potential problems...

Thanks,
Kuai
> diff --git a/block/genhd.c b/block/genhd.c
> index 17b33c62423df..6123005154b2a 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -484,7 +484,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   
>   	ret = blk_register_queue(disk);
>   	if (ret)
> -		goto out_put_slave_dir;
> +		goto out_unregister_holders;
>   
>   	if (!(disk->flags & GENHD_FL_HIDDEN)) {
>   		ret = bdi_register(disk->bdi, "%u:%u",
> @@ -526,6 +526,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   		bdi_unregister(disk->bdi);
>   out_unregister_queue:
>   	blk_unregister_queue(disk);
> +out_unregister_holders:
> +	bd_unregister_all_holders(disk);
>   out_put_slave_dir:
>   	kobject_put(disk->slave_dir);
>   out_put_holder_dir:
> diff --git a/block/holder.c b/block/holder.c
> index 5283bc804cc14..12c09d5c21280 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -169,3 +169,13 @@ int bd_register_pending_holders(struct gendisk *disk)
>   	mutex_unlock(&disk->open_mutex);
>   	return ret;
>   }
> +
> +void bd_unregister_all_holders(struct gendisk *disk)
> +{
> +	struct bd_holder_disk *holder;
> +
> +	mutex_lock(&disk->open_mutex);
> +	list_for_each_entry(holder, &disk->slave_bdevs, list)
> +		__unlink_disk_holder(holder->bdev, disk);
> +	mutex_unlock(&disk->open_mutex);
> +}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50e358a19d986..ccab9a2dae4bd 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -840,6 +840,7 @@ void set_capacity(struct gendisk *disk, sector_t size);
>   int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
>   void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
>   int bd_register_pending_holders(struct gendisk *disk);
> +void bd_unregister_all_holders(struct gendisk *disk);
>   #else
>   static inline int bd_link_disk_holder(struct block_device *bdev,
>   				      struct gendisk *disk)
> @@ -854,6 +855,9 @@ static inline int bd_register_pending_holders(struct gendisk *disk)
>   {
>   	return 0;
>   }
> +static inline void bd_unregister_all_holders(struct gendisk *disk)
> +{
> +}
>   #endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
>   
>   dev_t part_devt(struct gendisk *disk, u8 partno);
> .
> 

