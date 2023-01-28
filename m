Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3867F3DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjA1Bzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1Bzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:55:39 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D627B400;
        Fri, 27 Jan 2023 17:55:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P3cwN3NFSz4f3lKX;
        Sat, 28 Jan 2023 09:55:32 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDHd6uVgNRjN0AnCg--.29152S2;
        Sat, 28 Jan 2023 09:55:34 +0800 (CST)
Subject: Re: [PATCH v4 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
 <20230118093726.3939160-7-shikemeng@huaweicloud.com>
 <20230118173745.GC12399@lst.de>
 <f4dea0fc-5fcf-ceec-84d5-468b25c947ff@huaweicloud.com>
Message-ID: <2a149492-a2c1-68ef-1644-fb577151a9e1@huaweicloud.com>
Date:   Sat, 28 Jan 2023 09:55:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <f4dea0fc-5fcf-ceec-84d5-468b25c947ff@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHd6uVgNRjN0AnCg--.29152S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfXw48tr4furyfGF45ZFb_yoW8Gry8pw
        4fZayjqr4ktrWvkw4vka1xWryxKwsxKryaqr1xtr1fWr45Kr1Sgr13KrW29F9ayr4kC3W7
        uF13ZasxZFZYyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 1/19/2023 9:40 AM, Kemeng Shi wrote:
> 
> 
> on 1/19/2023 1:37 AM, Christoph Hellwig wrote:
>> On Wed, Jan 18, 2023 at 05:37:19PM +0800, Kemeng Shi wrote:
>>> +/*
>>> + * blk_mq_commit_rqs will notify driver using bd->last that there is no
>>> + * more requests. (See comment in struct blk_mq_ops for commit_rqs for
>>> + * details)
>>> + * Attention, we should explicitly call this in unusual cases:
>>> + *  1) did not queue everything initially scheduled to queue
>>> + *  2) the last attempt to queue a request failed
>>> + */
>>> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued,
>>> +			      bool from_schedule)
>>
>> Isn't from_schedule always false here as well now?
> Hi Christoph ,
> Yes, it's always false now. As blk_mq_commit_rqs is a general function
> for all commits now, I keep the from_schedule for commits where
> from_schedule maybe true in future. We can remove from_schedule now
> and add it back when from_schedule is indeed needed. Both way is
> acceptable for me. Please let me know which way do you prefer and I
> will send a new version if needed.
> Thanks.
>> Otherwise looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
> 
Hi Christoph,
Sorry for bother. I'm not sure if you got this message. I plan to collect
reviewed-by from you for this patch if no futher work is informed.
Thanks.

-- 
Best wishes
Kemeng Shi

