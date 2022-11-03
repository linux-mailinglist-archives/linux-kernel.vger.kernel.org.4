Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577FA61754C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKCDxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiKCDxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:53:04 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0D19C39;
        Wed,  2 Nov 2022 20:51:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N2qVh3gYgz6PDHf;
        Thu,  3 Nov 2022 11:48:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgAnDtO0OmNjIRYaBQ--.12160S3;
        Thu, 03 Nov 2022 11:51:17 +0800 (CST)
Subject: Re: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
To:     Khazhy Kumykov <khazhy@chromium.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>,
        Jan Kara <jack@suse.cz>
References: <20221103013937.603626-1-khazhy@google.com>
 <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
 <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f83404b4-84a4-de4e-fa4d-9ce38900d91c@huaweicloud.com>
Date:   Thu, 3 Nov 2022 11:51:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnDtO0OmNjIRYaBQ--.12160S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17CFyrtFWrKry7uryDWrg_yoW8Zr15p3
        y0gFWjgr4xJrySgrZFyw4UAFyFvr4rWrZ8KryYg3s7ArZ8Ga4xtFsFkw4ruayfGFZ3K3ZI
        vr1Fqa45Gr1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/03 11:05, Khazhy Kumykov 写道:
> On Wed, Nov 2, 2022 at 7:56 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2022/11/03 9:39, Khazhismel Kumykov 写道:
>>> This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
>>> but woken_list_node still being hashed. This would happen when
>>> bfq_init_rq() expects a brand new allocated queue to be returned from
>>
>>   From what I see, bfqq->waker_bfqq is updated in bfq_init_rq() only if
>> 'new_queue' is false, but if 'new_queue' is false, the returned 'bfqq'
>> from bfq_get_bfqq_handle_split() will never be oom_bfqq, so I'm confused
>> here...
> There's two calls for bfq_get_bfqq_handle_split in this function - the
> second one is after the check you mentioned, and is the problematic
> one.
Yes, thanks for the explanation. Now I understand how the problem
triggers.

>>
>>> bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
>>> without resetting woken_list_node. Since we can always return oom_bfqq
>>> when attempting to allocate, we cannot assume waker_bfqq starts as NULL.
>>> We must either reset woken_list_node, or avoid setting woken_list at all
>>> for oom_bfqq - opt to do the former.
>>
>> Once oom_bfqq is used, I think the io is treated as issued from root
>> group. Hence I don't think it's necessary to set woken_list or
>> waker_bfqq for oom_bfqq.
> Ack, I was wondering what's right here since, evidently, *someone* had
> already set oom_bfqq->waker_bfqq to *something* (although... maybe it
> was an earlier init_rq). But maybe it's better to do nothing if we
> *know* it's oom_bfqq.

I need to have a check how oom_bfqq get involved with waker_bfqq, and
then see if it's reasonable.

Probably Jan and Paolo will have better view on this.

Thanks,
Kuai
> 
> Is it a correct interpretation here that setting waker_bfqq won't
> accomplish anything anyways on oom_bfqq, so better off not?

