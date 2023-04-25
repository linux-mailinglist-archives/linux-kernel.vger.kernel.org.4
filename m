Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8F6EDBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjDYGrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjDYGrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:47:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06373BB9E;
        Mon, 24 Apr 2023 23:47:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5CHC4ZN6z4f42Yl;
        Tue, 25 Apr 2023 14:47:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbF6d0dkDT5vIA--.826S3;
        Tue, 25 Apr 2023 14:47:24 +0800 (CST)
Subject: Re: [PATCH -next 1/8] md/raid10: prevent soft lockup while flush
 writes
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@osdl.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
 <20230420112946.2869956-2-yukuai1@huaweicloud.com>
 <CAPhsuW5ifaGc47-vJWwbRyjgJHr3CJy+_zZ1wAL=FNxPOk-0WQ@mail.gmail.com>
 <b3393e4d-2fdb-41a6-54ba-fb564c484e56@huaweicloud.com>
 <CAPhsuW47GBgnofLrN8DVMkrBC=tVjhvoQroVZPRrMUHwGcOBLA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <994e902f-b912-3bab-ac8d-e8c1dd2e17d3@huaweicloud.com>
Date:   Tue, 25 Apr 2023 14:47:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW47GBgnofLrN8DVMkrBC=tVjhvoQroVZPRrMUHwGcOBLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbF6d0dkDT5vIA--.826S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8AFWUtF4DAryUGr4kJFb_yoW8urW3p3
        45KFWayr4DAr43trsYyr1ktFy8tayrXr47WrykJr17J39I9F1jy3WUJr1jgryY9ry7uryU
        AFWkKrW3uw18t3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/04/25 14:39, Song Liu 写道:
> On Mon, Apr 24, 2023 at 11:16 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/04/25 8:23, Song Liu 写道:
>>> On Thu, Apr 20, 2023 at 4:31 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Currently, there is no limit for raid1/raid10 plugged bio. While flushing
>>>> writes, raid1 has cond_resched() while raid10 doesn't, and too many
>>>> writes can cause soft lockup.
>>>>
>>>> Follow up soft lockup can be triggered easily with writeback test for
>>>> raid10 with ramdisks:
>>>>
>>>> watchdog: BUG: soft lockup - CPU#10 stuck for 27s! [md0_raid10:1293]
>>>> Call Trace:
>>>>    <TASK>
>>>>    call_rcu+0x16/0x20
>>>>    put_object+0x41/0x80
>>>>    __delete_object+0x50/0x90
>>>>    delete_object_full+0x2b/0x40
>>>>    kmemleak_free+0x46/0xa0
>>>>    slab_free_freelist_hook.constprop.0+0xed/0x1a0
>>>>    kmem_cache_free+0xfd/0x300
>>>>    mempool_free_slab+0x1f/0x30
>>>>    mempool_free+0x3a/0x100
>>>>    bio_free+0x59/0x80
>>>>    bio_put+0xcf/0x2c0
>>>>    free_r10bio+0xbf/0xf0
>>>>    raid_end_bio_io+0x78/0xb0
>>>>    one_write_done+0x8a/0xa0
>>>>    raid10_end_write_request+0x1b4/0x430
>>>>    bio_endio+0x175/0x320
>>>>    brd_submit_bio+0x3b9/0x9b7 [brd]
>>>>    __submit_bio+0x69/0xe0
>>>>    submit_bio_noacct_nocheck+0x1e6/0x5a0
>>>>    submit_bio_noacct+0x38c/0x7e0
>>>>    flush_pending_writes+0xf0/0x240
>>>>    raid10d+0xac/0x1ed0
>>>
>>> Is it possible to trigger this with a mdadm test?
>>>
>>
>> The test I mentioned in patch 8 can trigger this problem reliablity, so
>> I this add a new test can achieve this.
> 
> To be clear, by "mdadm test" I mean the tests included in mdadm:
> 
> https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/tree/tests
> 
> Could you please try to add a test? If it works, we should add it to
> mdadm.

Yes, of course. However, I'm not familiar how mdadm tests works yet, it
might take some time. By the way, I'll be good if I can add the test to
blktests if possible.

Thanks,
Kuai
> 
> Thanks,
> Song
> .
> 

