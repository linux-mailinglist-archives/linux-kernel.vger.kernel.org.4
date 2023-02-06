Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F368B397
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBFBFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFBFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:05:48 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E51A954;
        Sun,  5 Feb 2023 17:05:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P97Nd3xdcz4f3tps;
        Mon,  6 Feb 2023 09:05:37 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgCHfhxWUuBjlEg_Cw--.10457S2;
        Mon, 06 Feb 2023 09:05:39 +0800 (CST)
Subject: Re: [PATCH v4 12/14] blk-mq: remove set of bd->last when get driver
 tag for next request fails
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, jack@suse.cz
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
 <20230118093726.3939160-12-shikemeng@huaweicloud.com>
 <20230118174208.GH12399@lst.de>
 <1f116b9b-8194-54c8-eedb-7f2c9cd493c6@huaweicloud.com>
 <0526b518-0894-10f6-e428-c03644d39c02@huaweicloud.com>
Message-ID: <119aeade-151b-e375-f89b-20956bd9f3fb@huaweicloud.com>
Date:   Mon, 6 Feb 2023 09:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <0526b518-0894-10f6-e428-c03644d39c02@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgCHfhxWUuBjlEg_Cw--.10457S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr47Ww4xurWUGw4fZw43Jrb_yoW8XFWxpF
        WfJayjkF45tFsFyrn2ywsFgFy8t3y3XrW3Xrn8ZryrXws8ur13Kr95KrW29asFyr4xGa12
        9w4jgasYvw18Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 1/28/2023 10:03 AM, Kemeng Shi wrote:
> 
> 
> on 1/19/2023 9:45 AM, Kemeng Shi wrote:
>>
>>
>> on 1/19/2023 1:42 AM, Christoph Hellwig wrote:
>>> On Wed, Jan 18, 2023 at 05:37:24PM +0800, Kemeng Shi wrote:
>>>> Commit 113285b473824 ("blk-mq: ensure that bd->last is always set
>>>> correctly") will set last if we failed to get driver tag for next
>>>> request to avoid flush miss as we break the list walk and will not
>>>> send the last request in the list which will be sent with last set
>>>> normally.
>>>> This code seems stale now becase the flush introduced is always
>>>> redundant as:
>>>> For case tag is really out, we will send a extra flush if we find
>>>> list is not empty after list walk.
>>>> For case some tag is freed before retry in blk_mq_prep_dispatch_rq for
>>>> next, then we can get a tag for next request in retry and flush notified
>>>> already is not necessary.
>>>
>>> I think Ming will know this code better than me, but aren't we
>>> losing the blk_mq_get_driver_tag call entirely here now.  Where
>>> is getting the driver tag covered now?
>>>
>> We will get driver tag in blk_mq_prep_dispatch_rq at beginning of dispatch
>> loop, so it's fine to remove blk_mq_get_driver_tag here. Thanks.
>>
> 
> Hi Ming and everyone familiar with code invovled, could you help with
> reviewing this patch and patch "[PATCH v4 04/14] blk-mq: Fix potential
> io hung for shared sbitmap per tagset" in the same patchset.
> Thanks.
> 
Could anyone please help review the last two patches without reviewed-by.
Thanks.

-- 
Best wishes
Kemeng Shi

