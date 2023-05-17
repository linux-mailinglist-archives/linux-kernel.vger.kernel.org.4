Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB57061AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjEQHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjEQHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:49:34 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5302D5591;
        Wed, 17 May 2023 00:49:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QLlcD4YTxz4f3jpp;
        Wed, 17 May 2023 15:49:16 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgD31QP7hmRkFY5qIw--.45129S3;
        Wed, 17 May 2023 15:49:17 +0800 (CST)
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
To:     Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <ZF0K7A6G2cYBjSgn@infradead.org>
 <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
 <ZF5G5ztMng8Xbd1W@infradead.org>
 <2740ee82-e35f-1cbf-f5d0-373f94eb14a5@acm.org>
 <de3f41a0-b13d-d4f6-765a-19b857bce53e@huaweicloud.com>
 <86065501-ab2e-09b4-71cd-c0b18ede00ed@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a26e28a6-91e0-e803-749e-2ce957711c64@huaweicloud.com>
Date:   Wed, 17 May 2023 15:49:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <86065501-ab2e-09b4-71cd-c0b18ede00ed@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD31QP7hmRkFY5qIw--.45129S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyrWw17AF4rZw48Zr4ktFb_yoW5JFW7pF
        Z3tF45Cw4kJ34jka1kZr4IgF1rt393JFWUJrnxAry0k398Ars7Zr17G3yY9FyrAw4kCF1j
        yrWFqrykXFy8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/16 23:12, Bart Van Assche 写道:
> On 5/12/23 20:09, Yu Kuai wrote:
>> 在 2023/05/13 2:12, Bart Van Assche 写道:
>>> The fair tag sharing algorithm has a negative impact on all SCSI 
>>> devices with multiple logical units. This is because logical units 
>>> are considered active until (request timeout) seconds have elapsed 
>>> after the logical unit stopped being used (see also the 
>>> blk_mq_tag_idle() call in blk_mq_timeout_work()). UFS users are hit 
>>> by this because UFS 3.0 devices have a limited queue depth (32) and 
>>> because power management commands are submitted to a logical unit 
>>> (WLUN). Hence, it happens often that the block layer "active queue" 
>>> counter is equal to 2 while only one logical unit is being used 
>>> actively (a logical unit backed by NAND flash). The performance 
>>> difference between queue depths 16 and 32 for UFS devices is 
>>> significant.
>>
>> We meet similiar problem before, but I think remove tag fair sharing
>> might cause some problems, because get tag is not fair currently, for
>> example 2 devices share 32 tag, while device a issue large amount of
>> io concurrently, and device b only issue one io, in this case, if fair
>> tag sharing is removed, device b can get bad io latency.
>>
>> By the way, I tried to propose a way to workaround this by following:
>>
>> 1) disable fair tag sharing untill get tag found no tag is avaiable;
>> 2) enable fair tag sharing again if the disk donesn't faild to get tag
>> for a period of time;
>>
>> Can this approch be considered?
> 
> I'm afraid that this approach won't help for the UFS driver since it is 
> likely that all tags are in use by a single logical unit during an IOPS 
> test. Hence, fair sharing would be enabled even when we don't want it to 
> be enabled.

It's right my original method is not flexible.

> 
> I propose that we switch to one of these two approaches:

How about a smoothing method that the device with more io will share
more tag, and each device will get at least one tag?

Thanks,
Kuai

> * Either remove the fair tag sharing code entirely and rely on the 
> fairness mechanism provided by the sbitmap code. I'm referring to how 
> __sbitmap_queue_wake_up() uses the wake_index member variable.
> * Or make the behavior of the fairness algorithm configurable from user 
> space. One possible approach is to make the proportion of tags for a 
> logical unit / NVMe namespace configurable via sysfs. This will allow to 
> reduce the number of tags for the WLUN of UFS devices.
> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 

