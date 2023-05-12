Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01870013A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbjELHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbjELHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:16:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD23599;
        Fri, 12 May 2023 00:14:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QHg4H6YWPz4f3jJB;
        Fri, 12 May 2023 15:14:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbBP511kfk0dJQ--.30340S3;
        Fri, 12 May 2023 15:14:25 +0800 (CST)
Subject: Re: [PATCH -next] block: fix blktrace debugfs entries leak
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230511065633.710045-1-yukuai1@huaweicloud.com>
 <20230511152808.GA8641@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <18db3894-d128-7857-4c11-25b59d82ff54@huaweicloud.com>
Date:   Fri, 12 May 2023 15:14:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230511152808.GA8641@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbBP511kfk0dJQ--.30340S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWxZr17ZrW7XryUCw1fCrg_yoW8tF17pa
        ySqan0kr1qyrsYva47Zw4UXaySg3s5ArWrJF9ag34S9F15Jr1agFW7AwsYva13XrsI9r90
        q3WYvrW7Jry8XF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6w
        ZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/11 23:28, Christoph Hellwig Ð´µÀ:
> On Thu, May 11, 2023 at 02:56:33PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit 99d055b4fd4b ("block: remove per-disk debugfs files in
>> blk_unregister_queue") moves blk_trace_shutdown() from
>> blk_release_queue() to blk_unregister_queue(), this is safe if blktrace
>> is created through sysfs, however, there are some regression in corner
>> cases:
>>
>> 1) for scsi, passthrough io can still be issued after del_gendisk, and
>>     blktrace debugfs entries will be removed immediately after
>>     del_gendisk(), therefor passthrough io can't be tracked and blktrace
>>     will complain:
>>
>>     failed read of /sys/kernel/debug/block/sdb/trace0: 5/Input/output error
> 
> But that is the right thing.  The only thing that has a name is the
> gendisk and it is gone at this point.  Leaking the debugfs entries
> that are named after, and ultimatively associated with the gendisk
> (even if the code is still a bit confused about this) will create a lot
> of trouble for us.
> 
>> 2) blktrace can still be enabled after del_gendisk() through ioctl if the
>>     disk is opened before del_gendisk(), and if blktrace is not shutdown
>>     through ioctl before closing the disk, debugfs entries will be
>>     leaked.
> 
> Yes.
> 
>> It seems 1) is not important, while 2) needs to be fixed apparently.
>>
>> Fix this problem by shutdown blktrace in blk_free_queue(),
>> disk_release() is not used because scsi sg support blktrace without
>> gendisk, and this is safe because queue is not freed yet, and
>> blk_trace_shutdown() is reentrant.
> 
> I think disk_release is the right place for "normal" blktrace.  The
> odd cdev based blktrace for /dev/sg will need separate handling.
> To be honest I'm not even sure how /dev/sg based passthrough is
> even supposed to work in practice, but I'll need to spend some more
> time to familarize myself with it.

I'm not sure how to specail hanlde /dev/sg* for now, however,
If we don't care about blktrace for passthrough io after del_gendisk(),
and /dev/sg* has separate handling, I think it's better just to check
QUEUE_FLAG_REGISTERED in blk_trace_setup(), and don't enable blktrace
in the first place.

Thanks,
Kuai

