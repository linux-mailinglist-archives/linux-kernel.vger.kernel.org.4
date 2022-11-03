Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE06617A32
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKCJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKCJpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:45:33 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD6FD18;
        Thu,  3 Nov 2022 02:45:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N2zMK3pMlz6PF7Y;
        Thu,  3 Nov 2022 17:42:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA30NS1jWNjMlgnBQ--.2248S3;
        Thu, 03 Nov 2022 17:45:26 +0800 (CST)
Subject: Re: [PATCH 2/2] block: fix use after free for bd_holder_dir
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221103025541.1875809-1-yukuai1@huaweicloud.com>
 <20221103025541.1875809-3-yukuai1@huaweicloud.com>
 <20221103081211.GB3346@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d4b7c2c7-7da5-9814-e934-174cb8cd5740@huaweicloud.com>
Date:   Thu, 3 Nov 2022 17:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221103081211.GB3346@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA30NS1jWNjMlgnBQ--.2248S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7urWrAw1UuryDtF15XFb_yoW8tFW7pa
        90qF4kK3y8JFW7Zwsrt347XFW0qw15Xa48CFWS9F4IgrZ8Xr1vyr43GFW7WF17Ar1vvr4j
        qF1jq3ya9F1vkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/03 16:12, Christoph Hellwig 写道:
> On Thu, Nov 03, 2022 at 10:55:41AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, the caller of bd_link_disk_holer() get 'bdev' by
>> blkdev_get_by_dev(), which will look up 'bdev' by inode number 'dev'.
>> Howerver, it's possible that del_gendisk() can be called currently, and
>> 'bd_holder_dir' can be freed before bd_link_disk_holer() access it, thus
>> use after free is triggered.
>>
>> t1:				t2:
>> bdev = blkdev_get_by_dev
>> 				del_gendisk
>> 				 kobject_put(bd_holder_dir)
>> 				  kobject_free()
>> bd_link_disk_holder
>>
>> Fix the problem by checking disk is still live and grabbing a reference
>> to 'bd_holder_dir' first in bd_link_disk_holder().
> 
> Looks good with some minor stilistic nipicks:
> 
>> +	if (!disk_live(bdev->bd_disk)) {
>> +		mutex_unlock(&bdev->bd_disk->open_mutex);
>> +		return -ENODEV;
>> +	}
> 
> This can use a goto out_unlock;

This lock is different from current 'out_unlock', add a new lable will
make the code more complex, I think.
> 
>>   		holder->refcnt++;
>> +		kobject_put(bdev->bd_holder_dir);
>>   		goto out_unlock;
>>   	}
>>   
>>   	holder = kzalloc(sizeof(*holder), GFP_KERNEL);
>>   	if (!holder) {
>>   		ret = -ENOMEM;
>> +		kobject_put(bdev->bd_holder_dir);
>>   		goto out_unlock;
>>   	}
>>   
>> @@ -101,16 +114,12 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>>   		ret = __link_disk_holder(bdev, disk);
>>   		if (ret) {
>>   			kfree(holder);
>> +			kobject_put(bdev->bd_holder_dir);
> 
> And I think a goto out_put_holder and out_free_holder would clean this up
> nicely.

Yes, you're right.
> 
>>   	list_add(&holder->list, &disk->slave_bdevs);
>> -	/*
>> -	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
>> -	 * to keep our own here to allow for cleanup past that point.
>> -	 */
>> -	kobject_get(bdev->bd_holder_dir);
> 
> .. with this then jumping straight to out_unlock.

Ok, I'll do that in next version.
> 
> 
> We should repost a series with my first 7 patches and your two.  I can do
> that, but it might take some time as I just got through (minor) knee
> surgery and am still at the hospital, so if you have spare cycles feel
> free to do it.

I'm glad to do that, and have a good rest 😄

Thanks,
Kuai
> 
> .
> 

