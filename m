Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665936B1C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCIH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCIH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:27:14 -0500
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [IPv6:2001:41d0:203:375::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE3DAB8B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:27:11 -0800 (PST)
Message-ID: <fbbb46dc-ac07-9a99-dece-f0077a9fd491@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678346829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKoe8WZTyxS/qTBdQdxa83BgdUQGwHsnhiFLsgV2ULA=;
        b=bhMlYA6e3hJe55cgdQnRpHm0QC/3HgsDjuq+URhNfaojnqpRFtsh9JLPLN9HHDAujHrjaq
        lAwoVJo+cWqPX1e5lRNzlQ9/Chu77ahE3gzIMHWK8ALuP1XrYj13Jz3LbavlAZ1egK8xfx
        ydFGkS2ReOlocTommlLaoAKxQoc9YE4=
Date:   Thu, 9 Mar 2023 15:27:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH -next] raid10: fix leak of io accounting
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230304070133.1134975-1-yukuai1@huaweicloud.com>
 <a2551c50-feea-bcbe-00ed-802456b5a19f@linux.dev>
 <76d32496-641e-c93a-df77-9ce9d9c1a1e1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <76d32496-641e-c93a-df77-9ce9d9c1a1e1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/23 14:56, Yu Kuai wrote:
> Hi,
>
> 在 2023/03/09 14:36, Guoqing Jiang 写道:
>> Hi,
>>
>> What do you mean 'leak' here?
>
> I try to mean that inflight counting is leaked, because it's increased
> twice for one io.

How about change the subject to something like?

'md/raid10: Don't call bio_start_io_acct twice for bio which experienced 
read error'

>
>>
>> On 3/4/23 15:01, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> handle_read_error() will resumit r10_bio by raid10_read_request(), 
>>> which
>>> will call bio_start_io_acct() again, while bio_end_io_acct() will only
>>> be called once.
>>>
>>> Fix the problem by don't account io again from handle_read_error().
>>
>> My understanding is it caused inaccurate io stats for bio which had a 
>> read
>> error.
>>
>>> Fixes: 528bc2cf2fcc ("md/raid10: enable io accounting")
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/raid10.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>> index 6c66357f92f5..4f8edb6ea3e2 100644
>>> --- a/drivers/md/raid10.c
>>> +++ b/drivers/md/raid10.c
>>> @@ -1173,7 +1173,7 @@ static bool regular_request_wait(struct mddev 
>>> *mddev, struct r10conf *conf,
>>>   }
>>>   static void raid10_read_request(struct mddev *mddev, struct bio *bio,
>>> -                struct r10bio *r10_bio)
>>> +                struct r10bio *r10_bio, bool handle_error)
>>>   {
>>>       struct r10conf *conf = mddev->private;
>>>       struct bio *read_bio;
>>> @@ -1244,7 +1244,7 @@ static void raid10_read_request(struct mddev 
>>> *mddev, struct bio *bio,
>>>       }
>>>       slot = r10_bio->read_slot;
>>> -    if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>>> +    if (!handle_error && 
>>> blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>>>           r10_bio->start_time = bio_start_io_acct(bio);
>>
>> I think a simpler way is just check R10BIO_ReadError here.
>
> No, I'm afraid this is incorrect because handle_read_error clears the
> state before resubmiting the r10bio.

Right,

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
