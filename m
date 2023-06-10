Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB572AA5E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjFJImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFJImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 04:42:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0D3A8C;
        Sat, 10 Jun 2023 01:42:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdWf31fXqz4f3nJh;
        Sat, 10 Jun 2023 16:42:03 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLNaN4Rk84t4LQ--.19484S3;
        Sat, 10 Jun 2023 16:42:04 +0800 (CST)
Message-ID: <288f846f-01f7-6c60-b440-aaabb1538de3@huaweicloud.com>
Date:   Sat, 10 Jun 2023 16:42:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] md/raid10: Only check QUEUE_FLAG_IO_STAT when issuing io
To:     Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
        song@kernel.org, jgq516@gmail.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230609094320.2397604-1-linan666@huaweicloud.com>
 <8d2134a6-90dc-822b-52ef-cd7cc8060b36@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <8d2134a6-90dc-822b-52ef-cd7cc8060b36@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLNaN4Rk84t4LQ--.19484S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry7Kw1xWF1rGr4Dur47twb_yoW8Kw4Dpr
        ykKFy5J345Gr4kJryqqr1UAry5tw4DJ34DJr18JFyUXF1UJryjgF4UXr90gr1kJr4fAr17
        XF15JrnrurW5JF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
        M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/10 10:32, Yu Kuai 写道:
> Hi,
> 
> 在 2023/06/09 17:43, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> /sys/block/[device]/queue/iostats is used to control whether to count io
>> stat. Write 0 to it will clear queue_flags QUEUE_FLAG_IO_STAT which means
>> iostats is disabled. If we disable iostats and later endable it, the io
>> issued during this period will be counted incorrectly, inflight will be
>> decreased to -1.
>>
>>    //T1 set iostats
>>    echo 0 > /sys/block/md0/queue/iostats
>>     clear QUEUE_FLAG_IO_STAT
>>
>>             //T2 issue io
>>             if (QUEUE_FLAG_IO_STAT) -> false
>>              bio_start_io_acct
>>               inflight++
>>
>>    echo 1 > /sys/block/md0/queue/iostats
>>     set QUEUE_FLAG_IO_STAT
>>
>>                     //T3 io end
>>                     if (QUEUE_FLAG_IO_STAT) -> true
>>                      bio_end_io_acct
>>                       inflight--    -> -1
>>
>> Also, if iostats is enabled while issuing io but disabled while io end,
>> inflight will never be decreased.
>>
>> Fix it by checking start_time when io end. Only check QUEUE_FLAG_IO_STAT
>> while issuing io, just like request based devices.
>>
>> Fixes: 528bc2cf2fcc ("md/raid10: enable io accounting")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/raid10.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 381c21f7fb06..bf9dca5c25c3 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -325,7 +325,7 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
>>       if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
>>           bio->bi_status = BLK_STS_IOERR;
>> -    if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>> +    if (r10_bio->start_time)
>>           bio_end_io_acct(bio, r10_bio->start_time);
> 
> This patch LGTM, can you change this for raid1 as well? raid0 and
> raid456 is using md_account_bio(), and they don't have such problem.
> 

OK, I will fix raid1 later. Thanks for suggestion.

> Thanks,
> Kuai
-- 
Thanks,
Nan

