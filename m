Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3F645A77
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLGNKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLGNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:10:41 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6D56543
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:10:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NRyMF2KLYz4f3wRD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:10:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgD37azJkJBjG4rYBg--.48614S3;
        Wed, 07 Dec 2022 21:10:34 +0800 (CST)
Subject: Re: [PATCH-next] block: fix null-deref in percpu_ref_put
To:     Dennis Zhou <dennis@kernel.org>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221206090939.871239-1-zhongjinghua@huawei.com>
 <Y4/mzMd4evRg9yDi@fedora>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4b826950-52a5-b50b-1086-c14422ca3039@huaweicloud.com>
Date:   Wed, 7 Dec 2022 21:10:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4/mzMd4evRg9yDi@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgD37azJkJBjG4rYBg--.48614S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF17KF4rAry8GrW8XF4ruFg_yoW8ur48pF
        WxtF4akr4ktF4DKwn7Aw4xu3yxZr45KFyfGas3Gr1ayr13WFyFv3W3CFyY9F4jyr4kA3y0
        vr4qg3ZIkFyq937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/12/07 9:05, Dennis Zhou Ð´µÀ:
> Hello,
> 
> On Tue, Dec 06, 2022 at 05:09:39PM +0800, Zhong Jinghua wrote:
>> A problem was find in stable 5.10 and the root cause of it like below.
>>
>> In the use of q_usage_counter of request_queue, blk_cleanup_queue using
>> "wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter))"
>> to wait q_usage_counter becoming zero. however, if the q_usage_counter
>> becoming zero quickly, and percpu_ref_exit will execute and ref->data
>> will be freed, maybe another process will cause a null-defef problem
>> like below:
>>
>> 	CPU0                             CPU1
>> blk_mq_destroy_queue
>>   blk_freeze_queue
>>    blk_mq_freeze_queue_wait
>> 				scsi_end_request
>> 				 percpu_ref_get
>> 				 ...
>> 				 percpu_ref_put
>> 				  atomic_long_sub_and_test
>>   blk_put_queue
>>    kobject_put
>>     kref_put
>>      blk_release_queue
>>       percpu_ref_exit
>>        ref->data -> NULL
>>     				   ref->data->release(ref) -> null-deref
>>
> 
> I remember thinking about this a while ago. I don't think this fix works
> as nicely as it may seem. Please correct me if I'm wrong.
> 
> q->q_usage_counter has the oddity that the lifetime of the percpu_ref
> object isn't managed by the release function. The freeing is handled by
> a separate path where it depends on the percpu_ref hitting 0. So here we
> have 2 concurrent paths racing to run with 1 destroying the object. We
> probably need blk_release_queue() to wait on percpu_ref's release
> finishing, not starting.
> 
> I think the above works in this specific case because there is a
> call_rcu() in blk_release_queue(). If there wasn't a call_rcu(),
> then by the same logic we could delay ref->data->release(ref) further
> and that could potentially lead to a use after free.
> 
> Ideally, I think fixing the race in q->q_usage_counter's pattern is
> better than masking it here as I think we're being saved by the
> call_rcu() call further down the object release path.

Agree.

BTW, Wensheng used to send a patch to fix this in block layer:

https://www.spinics.net/lists/kernel/msg4615696.html.

Thanks,
Kuai

