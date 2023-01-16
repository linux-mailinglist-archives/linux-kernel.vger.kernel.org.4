Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2766B52E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjAPBHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjAPBHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:07:10 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA318E3AC;
        Sun, 15 Jan 2023 17:07:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NwDPv1psmz4f3jMq;
        Mon, 16 Jan 2023 09:06:59 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgBHsy00o8RjcP3ABg--.29754S2;
        Mon, 16 Jan 2023 09:07:01 +0800 (CST)
Subject: Re: [PATCH v3 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
 <20230111130159.3741753-8-shikemeng@huaweicloud.com>
 <20230111054520.GA17158@lst.de>
 <c51cbadb-bfd8-5f26-6bc3-5ad975b5db39@huaweicloud.com>
Message-ID: <e2ba1495-e9a8-8dfc-4eee-d9a2984bc0d2@huaweicloud.com>
Date:   Mon, 16 Jan 2023 09:07:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <c51cbadb-bfd8-5f26-6bc3-5ad975b5db39@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgBHsy00o8RjcP3ABg--.29754S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4kJw1DtF1kZryftw48Xrb_yoW8XF18pF
        4UJa98ta1rJrsFywn5Ja1xZFyxJ39aqry3Xr9rt34rWrWYgFyfur43KrnrWFZrCr4kJ3y3
        u3y3Cr90qa4rurJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 1/11/2023 2:30 PM, Kemeng Shi wrote:
> 
> Hi Christoph, thank you for taking time to review, alos sorry for the bother
> of code style problem. I will fix them in next version.
> on 1/11/2023 1:45 PM, Christoph Hellwig wrote:
>> On Wed, Jan 11, 2023 at 09:01:52PM +0800, Kemeng Shi wrote:
>>> 1. rename orignal blk_mq_commit_rqs to blk_mq_plug_commit_rqs as
>>> trace_block_unplug is only needed when we dispatch request from plug list.
>>
>> Why?  I think always having the trace even for the commit case seems
>> very useful for making the traces useful.
> I think unplug event more likely means that request going to be sent to driver
> was plugged and in plug list. And the current code do only trace unplug event
> when dispatching requests from plug list. If so, would it be better to add
> a new event to trace commit?
Hi Christoph, which way do you prefer now? Keep unplug event consistent to
trace commit of requests from plug list only or trace all commits with
unplug event. Please let me know and I will consider it in next version.
Thanks.
>>> +/* blk_mq_commit_rqs and blk_mq_plug_commit_rqs notify driver using
>>> + * bd->last that there is no more requests. (See comment in struct
>>
>> This is not the normal kernel comment style.
>>
>>> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued)
>>> +{
>>> +	if (hctx->queue->mq_ops->commit_rqs && queued) {
>>> +		hctx->queue->mq_ops->commit_rqs(hctx);
>>> +	}
>>
>> No need for the braces.
>>
> 

-- 
Best wishes
Kemeng Shi

