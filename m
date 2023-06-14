Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5AB72F256
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbjFNB6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjFNB6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:58:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17ED1FC9;
        Tue, 13 Jun 2023 18:58:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgpVR0MJpz4f3tNm;
        Wed, 14 Jun 2023 09:58:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7O+HolkasWdLg--.26820S3;
        Wed, 14 Jun 2023 09:58:23 +0800 (CST)
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
 <a26e28a6-91e0-e803-749e-2ce957711c64@huaweicloud.com>
 <097caed2-10b3-7cd1-7c06-90f983e5c720@acm.org>
 <f9ccab59-91a1-69d5-6d20-2c6ea0e24b5a@huaweicloud.com>
 <66906bd5-d73f-af96-bf38-c6aee576fa73@acm.org>
 <bef8340e-f051-db63-5c2f-a2bc94c678ac@huaweicloud.com>
 <04a4d0db-2f2d-e2fc-5458-4ddf852ffc8a@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3e9e42aa-9a0d-2b73-194b-5c229e9ed533@huaweicloud.com>
Date:   Wed, 14 Jun 2023 09:58:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <04a4d0db-2f2d-e2fc-5458-4ddf852ffc8a@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7O+HolkasWdLg--.26820S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF43JrWUJr4fWrykXrW3Awb_yoW8Jw4Upa
        y8tFZIkFs7J398AwsrX3W8uayftwn3Jr97Jr1fG347Zwn09w4fZw4Ut3909rZ3Zr97Cr12
        gay8Xr95X3s5Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
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

在 2023/06/13 22:07, Bart Van Assche 写道:
> On 5/18/23 00:55, Yu Kuai wrote:
>> 在 2023/05/18 10:23, Bart Van Assche 写道:
>>> On 5/17/23 18:49, Yu Kuai wrote:
>>>> Currently, fair share from hctx_may_queue() requires two
>>>> atomic_read(active_queues and active_requests), I think this smoothing
>>>> method can be placed into get_tag fail path, for example, the more 
>>>> times
>>>> a disk failed to get tag in a period of time, the more tag this disk 
>>>> can
>>>> get, and all the information can be updated here(perhaps directly
>>>> record how many tags a disk can get, then hctx_may_queue() still only
>>>> require 2 atomic_read()).
>>>
>>> That sounds interesting to me. Do you perhaps plan to implement this 
>>> approach and to post it as a patch?
>>
>> Of course, I'll try to send a RFC patch.
> 
> Hi Kuai,
> 
> Has this RFC patch already been posted or did I perhaps miss it?

Sorry for the delay, I finished switch from not share to fair share
directly verion, however, I found that it's not that simple to add a
smoothing method, and I'm stuck here for now.

I'll try to send a RFC verion soon, the smoothing method may not be
flexible, but I'll make sure it can work for your simple case that
2 device share tags, and one only issue few io while the other issue
lots of io.

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

