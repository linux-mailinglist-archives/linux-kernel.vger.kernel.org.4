Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F395B9520
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIOHV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:21:25 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EA1F2E6;
        Thu, 15 Sep 2022 00:21:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MSpVQ565TzKG5w;
        Thu, 15 Sep 2022 15:19:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgC3VW9u0iJj+9h_Aw--.25937S3;
        Thu, 15 Sep 2022 15:21:20 +0800 (CST)
Subject: Re: [PATCH v2 1/4] md/raid10: cleanup wait_barrier()
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        guoqing.jiang@linux.dev, pmenzel@molgen.mpg.de,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
 <20220914014914.398712-2-yukuai1@huaweicloud.com>
 <f0dd9208-05ec-b2fa-4b29-5fa140486fa3@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1932cd56-87fc-51ac-4cb0-ec35d912525c@huaweicloud.com>
Date:   Thu, 15 Sep 2022 15:21:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f0dd9208-05ec-b2fa-4b29-5fa140486fa3@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3VW9u0iJj+9h_Aw--.25937S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4xKrW3WF4rKw13Aw4DCFg_yoW5GF1Upw
        sxGFW3AF4kJ342ywsxXa18ZFyS9397JrWUJF9Fk34kZFn0vr98Kr43t34FkryDurs3ua4F
        qFs5Kr9xG3WjkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/09/15 0:16, Logan Gunthorpe 写道:
> 
> 
> On 2022-09-13 19:49, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently the nasty condition is wait_barrier() is hard to read. This
>> patch factor out the condition into a function.
>>
>> There are no functional changes.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid10.c | 56 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 32 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 64d6e4cd8a3a..56458a53043d 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -957,44 +957,52 @@ static void lower_barrier(struct r10conf *conf)
>>   	wake_up(&conf->wait_barrier);
>>   }
>>   
>> +static bool stop_waiting_barrier(struct r10conf *conf)
>> +{
>> +	/* barrier is dropped */
>> +	if (!conf->barrier)
>> +		return true;
>> +
>> +	/*
>> +	 * If there are already pending requests (preventing the barrier from
>> +	 * rising completely), and the pre-process bio queue isn't empty, then
>> +	 * don't wait, as we need to empty that queue to get the nr_pending
>> +	 * count down.
>> +	 */
>> +	if (atomic_read(&conf->nr_pending)) {
>> +		struct bio_list *bio_list = current->bio_list;
> 
> I'd probably just put the bio_list declaration at the top of this
> function, then the nested if statements are not necessary. The compiler
> should be able to optimize the access just fine.
> 
>>   	if (conf->barrier) {
>> -		struct bio_list *bio_list = current->bio_list;
>> -		conf->nr_waiting++;
>> -		/* Wait for the barrier to drop.
>> -		 * However if there are already pending
>> -		 * requests (preventing the barrier from
>> -		 * rising completely), and the
>> -		 * pre-process bio queue isn't empty,
>> -		 * then don't wait, as we need to empty
>> -		 * that queue to get the nr_pending
>> -		 * count down.
>> -		 */
>>   		/* Return false when nowait flag is set */
>>   		if (nowait) {
>>   			ret = false;
>>   		} else {
>> +			conf->nr_waiting++;
> 
> Technically speaking, I think moving nr_waiting counts as a functional
> change. As best as I can see it is correct, but it should probably be at
> least mentioned in the commit message, or maybe done as a separate
> commit with it's own justification. That way if it causes problems down
> the road, a bisect will make the issue clearer.

Thanks for your advice, I just think increase and decrease nr_waiting in
the case 'nowait' is pointless, and I move it incidentally.

I'll post a separate clean up patch to do that.

Paul, can I still add your Acked-by for this patch?

Thanks,
Kuai
> 
> Thanks,
> 
> Logan
> .
> 

