Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7EC6BC34A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCPB06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:26:56 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBDCB4825;
        Wed, 15 Mar 2023 18:26:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PcV3B6SXJz4f3nV3;
        Thu, 16 Mar 2023 09:26:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CFGcBJkR1f8Ew--.10447S3;
        Thu, 16 Mar 2023 09:26:32 +0800 (CST)
Subject: Re: [PATCH v2 0/5] md: fix uaf for sync_thread
To:     Logan Gunthorpe <logang@deltatee.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com,
        snitzer@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230315061810.653263-1-yukuai1@huaweicloud.com>
 <e1a5fe1c-ea3d-adef-62ec-3b30bedbe4f8@molgen.mpg.de>
 <606b1388-10e7-a0ae-f314-52274b0942dd@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d0dfd5ad-12d4-c6d1-68b2-a112d3f3c163@huaweicloud.com>
Date:   Thu, 16 Mar 2023 09:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <606b1388-10e7-a0ae-f314-52274b0942dd@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CFGcBJkR1f8Ew--.10447S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8AF4UWw1DCFW8Xr15CFg_yoW5WrWDpa
        y5K3WFyr4kGa1Ikr1xtr4xA3W2kw1ftFWUCryrG34UA345Xw4xtFWftrW5ZF45uan3WwnI
        v3WrX3s5W3s0yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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

在 2023/03/16 6:55, Logan Gunthorpe 写道:
> 
> 
> On 2023-03-15 02:30, Paul Menzel wrote:
>> Am 15.03.23 um 07:18 schrieb Yu Kuai:
>>> I tested this pathset with mdadm tests, and there are no new regression,
>>> by the way, following test will failed with or without this patchset:
>>>
>>> 01raid6integ
>>> 04r1update
>>> 05r6tor0
>>> 10ddf-create
>>> 10ddf-fail-spare
>>> 10ddf-fail-stop-readd
>>> 10ddf-geometry
>>
>> As you improved the tests in the past, can you confirm, these failed on
>> your test systems too and are fixed now?
> 
> Hmm, well Yu did not claim that those tests were fixed. If you re-read
> what was said, the tests listed failed with or without the new changes.
> As I read it, Yu asserts no new regressions were created with the patch
> set, not that failing tests were fixed.
> 
> Unfortunately, the tests listed are largely not ones I saw failing the
> last time I ran the tests (though it's been a few months since I last
> tried). I know 01raid6integ used to fail some of the time, but the other
> 6 tests mentioned worked the last time I ran them; and there are many
> other tests that failed when I ran them. (My notes on which tests are
> broken are included in the most recent mdadm tree in tests/*.broken)
> 
> I was going to try and confirm that no new regressions were introduced
> by Yu's patches, but seems the tests are getting worse. I tried running
> the tests on the current md-next branch and found that one of the early
> tests, 00raid5-zero, hangs indefinitely. I quickly ran the same test on
> v6.3-rc2 and found that it runs just fine there. So it looks like
> there's already a regression in md-next that is not part of this series
> and I don't have the time to dig into the root cause right now.
> 
> Yu's patches don't apply cleanly to v6.3-rc2 and I can't run the tests
> against md-next; so I didn't bother running them, but I did do a quick
> review. The locking changes make sense to me so it might be worth
> merging for correctness. However, I'm not entirely sure it's the best
> solution -- the md thread stuff seems like a bit of a mess and passing
> an mddev to thread functions that were not related to the mddev to get a
> lock seems to just make the mess a bit worse.
> 
> For example, it seems a bit ugly to me for the lock mddev->thread_lock
> to protect the access of a pointer in struct r5l_log. Just spit-balling,
> but perhaps RCU would be more appropriate here. Then md_wakeup_thread()
> would just need to hold the RCU read lock when dereferencing, and
> md_unregister_thread() would just need to synchronize_rcu() before
> stopping and freeing the thread. This has the benefit of not requiring
> the mddev object for every md_thread and would probably require a lot
> less churn than the current patches.

Thanks for your suggestion, this make sense to me. I'll try to use rcu.

Thanks,
Kuai
> 
> Logan
> 
> 
> 
> 
> .
> 

