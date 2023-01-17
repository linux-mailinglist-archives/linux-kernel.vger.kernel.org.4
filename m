Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B95E66D3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjAQBBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 20:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjAQBBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:01:24 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB22222D5;
        Mon, 16 Jan 2023 17:01:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NwrDq24RPz4f3vsg;
        Tue, 17 Jan 2023 09:01:15 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBXDLBc88VjDmVyBw--.15852S2;
        Tue, 17 Jan 2023 09:01:17 +0800 (CST)
Subject: Re: [PATCH v3 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     dwagner@suse.de, hare@suse.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, jack@suse.cz
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
 <20230111130159.3741753-8-shikemeng@huaweicloud.com>
 <20230111054520.GA17158@lst.de>
 <c51cbadb-bfd8-5f26-6bc3-5ad975b5db39@huaweicloud.com>
 <e2ba1495-e9a8-8dfc-4eee-d9a2984bc0d2@huaweicloud.com>
 <20230116160958.GB23434@lst.de>
 <d1244b25-9ae6-33b0-e6b7-3e3c463b1224@kernel.dk>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5511fa8a-b59b-a127-15ae-50425740ba52@huaweicloud.com>
Date:   Tue, 17 Jan 2023 09:01:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d1244b25-9ae6-33b0-e6b7-3e3c463b1224@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXDLBc88VjDmVyBw--.15852S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4UtryrAw1kAw1kWFWktFb_yoWDCFX_uF
        15u3srGrW3G3srtrZ8tF45Zrs0gay5W3W5Jw4ktrW0qa4FyFs7WFnFgFy8K3WfG3yj9F9I
        9F9Iqwn09rWfWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 1/17/2023 12:13 AM, Jens Axboe wrote:
> On 1/16/23 9:09 AM, Christoph Hellwig wrote:
>> On Mon, Jan 16, 2023 at 09:07:00AM +0800, Kemeng Shi wrote:
>>>>> Why?  I think always having the trace even for the commit case seems
>>>>> very useful for making the traces useful.
>>>> I think unplug event more likely means that request going to be sent to driver
>>>> was plugged and in plug list. And the current code do only trace unplug event
>>>> when dispatching requests from plug list. If so, would it be better to add
>>>> a new event to trace commit?
>>> Hi Christoph, which way do you prefer now? Keep unplug event consistent to
>>> trace commit of requests from plug list only or trace all commits with
>>> unplug event. Please let me know and I will consider it in next version.
>>> Thanks.
>>
>> To me always having the trace feels more useful, but let's see if Jens
>> has an opinion on it.
> 
> Agree, that is probably the saner option.
> 
Thanks for replies, I will trace all commits with unplug event in next version.

-- 
Best wishes
Kemeng Shi

