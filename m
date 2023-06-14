Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08654715370
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjE3CIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjE3CIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:08:15 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC3AE3;
        Mon, 29 May 2023 19:07:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVbQL2WSYz4f3lVw;
        Tue, 30 May 2023 10:07:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J6WnVk4dYPKg--.45958S3;
        Tue, 30 May 2023 10:07:55 +0800 (CST)
Subject: Re: [PATCH -next] block: fix blktrace debugfs entries leak
To:     Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230511065633.710045-1-yukuai1@huaweicloud.com>
 <20230511152808.GA8641@lst.de>
 <18db3894-d128-7857-4c11-25b59d82ff54@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e26d37bc-0f09-426a-ef25-57bdbd716ae9@huaweicloud.com>
Date:   Tue, 30 May 2023 10:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <18db3894-d128-7857-4c11-25b59d82ff54@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J6WnVk4dYPKg--.45958S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15AFW7CF17KF1kZw1rXrb_yoW5Gr1xpF
        Z2qan0kryUArsYva4jvw48Za4fK34rJFWkWF93GryS9FsxJr1agrW7XrsY9rW5Xr4v9r90
        qw15ZrW7Ar18XFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
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

Hi, Christoph

在 2023/05/12 15:14, Yu Kuai 写道:
> Hi,
> 
> 在 2023/05/11 23:28, Christoph Hellwig 写道:
>> On Thu, May 11, 2023 at 02:56:33PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Commit 99d055b4fd4b ("block: remove per-disk debugfs files in
>>> blk_unregister_queue") moves blk_trace_shutdown() from
>>> blk_release_queue() to blk_unregister_queue(), this is safe if blktrace
>>> is created through sysfs, however, there are some regression in corner
>>> cases:
>>>
>>> 1) for scsi, passthrough io can still be issued after del_gendisk, and
>>>     blktrace debugfs entries will be removed immediately after
>>>     del_gendisk(), therefor passthrough io can't be tracked and blktrace
>>>     will complain:
>>>
>>>     failed read of /sys/kernel/debug/block/sdb/trace0: 5/Input/output 
>>> error
>>
>> But that is the right thing.  The only thing that has a name is the
>> gendisk and it is gone at this point.  Leaking the debugfs entries
>> that are named after, and ultimatively associated with the gendisk
>> (even if the code is still a bit confused about this) will create a lot
>> of trouble for us.
>>
>>> 2) blktrace can still be enabled after del_gendisk() through ioctl if 
>>> the
>>>     disk is opened before del_gendisk(), and if blktrace is not shutdown
>>>     through ioctl before closing the disk, debugfs entries will be
>>>     leaked.
>>
>> Yes.
>>
>>> It seems 1) is not important, while 2) needs to be fixed apparently.
>>>
>>> Fix this problem by shutdown blktrace in blk_free_queue(),
>>> disk_release() is not used because scsi sg support blktrace without
>>> gendisk, and this is safe because queue is not freed yet, and
>>> blk_trace_shutdown() is reentrant.
>>
>> I think disk_release is the right place for "normal" blktrace.  The
>> odd cdev based blktrace for /dev/sg will need separate handling.
>> To be honest I'm not even sure how /dev/sg based passthrough is
>> even supposed to work in practice, but I'll need to spend some more
>> time to familarize myself with it.
> 
> I'm not sure how to specail hanlde /dev/sg* for now, however,
> If we don't care about blktrace for passthrough io after del_gendisk(),
> and /dev/sg* has separate handling, I think it's better just to check
> QUEUE_FLAG_REGISTERED in blk_trace_setup(), and don't enable blktrace
> in the first place.

Any suggestions about this problem? Should we use separate handling for
/dev/sd? Or just free blktrace in blk_free_queue().
> 
> Thanks,
> Kuai
> 
> .
> 

