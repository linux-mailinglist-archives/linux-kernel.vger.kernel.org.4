Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BA747BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGEDSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 23:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEDR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 23:17:59 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D61B6;
        Tue,  4 Jul 2023 20:17:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QwlGN40wVz4f3mK4;
        Wed,  5 Jul 2023 11:17:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbDd4KRkFajwNA--.34759S3;
        Wed, 05 Jul 2023 11:17:50 +0800 (CST)
Subject: Re: [PATCH RFC 0/7] blk-mq: improve tag fair sharing
To:     Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <4c9fea33-9c30-4ab9-c210-95e09d323837@acm.org>
 <82d44ba1-4389-079c-935a-cbb49203ca27@huaweicloud.com>
 <c4de836a-a2a1-847f-1525-1accb814e45e@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <84f9bfb4-293b-ad55-97e4-e8c611c5e9ca@huaweicloud.com>
Date:   Wed, 5 Jul 2023 11:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c4de836a-a2a1-847f-1525-1accb814e45e@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbDd4KRkFajwNA--.34759S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1kKF1ktFy5AF4kKr13CFg_yoW8Gw17pF
        WrKas0yw4ktry2kr92gw1DWF4ftrZ3Jr4UZr1rXwn7Awn8KFW2vFWrtas0kasrur4qgF4j
        9F4vkrZYyF4kJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/04 2:08, Bart Van Assche 写道:
> On 7/3/23 06:29, Yu Kuai wrote:
>> 在 2023/06/20 23:20, Bart Van Assche 写道:
>>> On 6/18/23 09:07, Yu Kuai wrote:
>>>> This is not a formal version and not fully tested, I send this RFC
>>>> because I want to make sure if people think doing this is meaningful,
>>>> before I spend too much time on this.
>>> The approach looks good to me but I'd like to hear from Jens and 
>>> Christoph what their opinion is about the approach of this patch 
>>> series before doing an in-depth review.
>>>
>> Any suggestions on this topic? It'll be great to hear that if anyone
>> thinks it's meaningful to refactor tag fair sharing.
> 
> The cover letter of this patch series says "This is not a formal version 
> and not fully tested". If a fully tested version will be posted, I will 
> help with an in-depth review.

Thanks for taking time on this patchset, do you think I need to do
following for the formal version, or these improvements can be done
later?

- current algorithm to borrow tags in patch 7 is very easy and
straightforward, it should work fine on simple caces like the case you
reported for ufs, but this algorithm should be improved for more
complicated cases.
- currently borrowed tags will never be returned untill queue is idle,
I should figure out a way to return borrowed tags if this queue is not
busy, so that other queues can borrow tag from this queue.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 

