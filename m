Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228276ADC27
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCGKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCGKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:42:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300A3C16;
        Tue,  7 Mar 2023 02:42:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PWBqG1kPBz4f3jJB;
        Tue,  7 Mar 2023 18:42:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR8rFQdk3az6EQ--.40871S3;
        Tue, 07 Mar 2023 18:42:52 +0800 (CST)
Subject: Re: [PATCH -next] radi10: fix leak of 'r10bio->remaining' for
 recovery
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230307022739.2656920-1-yukuai1@huaweicloud.com>
 <7684548b-5e6b-975b-67c2-98c686a4925f@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d4ef4c18-c377-2568-17e6-dea344b7f479@huaweicloud.com>
Date:   Tue, 7 Mar 2023 18:42:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7684548b-5e6b-975b-67c2-98c686a4925f@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR8rFQdk3az6EQ--.40871S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UJr1DXw45GFyDXF1xuFg_yoW5Zw43pF
        4kKFWFyry5W3Z3Cr1UJ3yUAFyrK3yDXayDJF10ga47Xw43ArWjgF4UXrZ0gr1Dur4xWryU
        Xr1DXrsrZFZrtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6wZUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/07 17:53, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Thank you for your patch.
> 
> Am 07.03.23 um 03:27 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
> 
> There is a small typo in the prefix of the commit message summary: raid10.
> 
> It also seems common to use md/raid10 as prefix.
> 
>> raid10_sync_request() will add 'r10bio->remaining' for both rdev and
>> replacement rdev. However, if the read io failed,
> 
> fails (present tense for problem description/summary)
> 
>> recovery_request_write() will return without issuring the write io, in
> 
> 1.  return*s*
> 2.  assuring?
> 
>> this case, end_sync_request() is only called once and 'remaining' is
>> leaked, which will cause io hang.
> 
> leaked, causing an io hang.
> 
>> Fix the probleming by decreasing 'remaining' according to if 'bio' and
> 
> problem
> 

Thanks for those advices, I'll send a new version after code changes is
reviewed.

Thanks,
Kuai

>> 'repl_bio' is valid.
>>
>> Fixes: 24afd80d99f8 ("md/raid10: handle recovery of replacement 
>> devices.")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid10.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index a8b5fecef136..f7002a1aa9cf 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -2611,11 +2611,22 @@ static void recovery_request_write(struct 
>> mddev *mddev, struct r10bio *r10_bio)
>>   {
>>       struct r10conf *conf = mddev->private;
>>       int d;
>> -    struct bio *wbio, *wbio2;
>> +    struct bio *wbio = r10_bio->devs[1].bio;
>> +    struct bio *wbio2 = r10_bio->devs[1].repl_bio;
>> +
>> +    /* Need to test wbio2->bi_end_io before we call
>> +     * submit_bio_noacct as if the former is NULL,
>> +     * the latter is free to free wbio2.
>> +     */
>> +    if (wbio2 && !wbio2->bi_end_io)
>> +        wbio2 = NULL;
>>       if (!test_bit(R10BIO_Uptodate, &r10_bio->state)) {
>>           fix_recovery_read_error(r10_bio);
>> -        end_sync_request(r10_bio);
>> +        if (wbio->bi_end_io)
>> +            end_sync_request(r10_bio);
>> +        if (wbio2)
>> +            end_sync_request(r10_bio);
>>           return;
>>       }
>> @@ -2624,14 +2635,6 @@ static void recovery_request_write(struct mddev 
>> *mddev, struct r10bio *r10_bio)
>>        * and submit the write request
>>        */
>>       d = r10_bio->devs[1].devnum;
>> -    wbio = r10_bio->devs[1].bio;
>> -    wbio2 = r10_bio->devs[1].repl_bio;
>> -    /* Need to test wbio2->bi_end_io before we call
>> -     * submit_bio_noacct as if the former is NULL,
>> -     * the latter is free to free wbio2.
>> -     */
>> -    if (wbio2 && !wbio2->bi_end_io)
>> -        wbio2 = NULL;
>>       if (wbio->bi_end_io) {
>>           atomic_inc(&conf->mirrors[d].rdev->nr_pending);
>>           md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
> 
> 
> Kind regards,
> 
> Paul
> 
> .
> 

