Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE98602129
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJRC2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJRC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:28:30 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED427DF56;
        Mon, 17 Oct 2022 19:28:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MryQj4zF8z6S2SR;
        Tue, 18 Oct 2022 10:26:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXCzJID05jv4whAA--.23642S3;
        Tue, 18 Oct 2022 10:28:25 +0800 (CST)
Subject: Re: [PATCH v4 0/6] blk-wbt: simple improvment to enable wbt correctly
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@infradead.org,
        ebiggers@kernel.org, paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
 <8a5333ea-361b-a9eb-2149-01f218260c0c@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b03fc249-e2a7-15dc-6d48-aa19948e8001@huaweicloud.com>
Date:   Tue, 18 Oct 2022 10:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8a5333ea-361b-a9eb-2149-01f218260c0c@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXCzJID05jv4whAA--.23642S3
X-Coremail-Antispam: 1UD129KBjvJXoW7XFy7tryxtFyDKFW5Zr4UCFg_yoW8JrWxp3
        95JasI9rWq9r9agw43Jr17G343Jay0qF1UXryay34rZ3WjvrnIq3W8Wr1FgF90qrs7Wa1q
        v3Z8tFWq9FyUu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
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

friendly ping ...

在 2022/10/11 16:06, Yu Kuai 写道:
> friendly ping ...
> 
> 在 2022/09/30 11:19, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> changes in v4:
>>   - remove patch 3 from v3
>>   - add patch 2,3 in v4
>>
>> changes in v3:
>>   - instead of check elevator name, add a flag in elevator_queue, as
>>   suggested by Christoph.
>>   - add patch 3 and patch 5 to this patchset.
>>
>> changes in v2:
>>   - define new api if wbt config is not enabled in patch 1.
>>
>> Yu Kuai (6):
>>    elevator: remove redundant code in elv_unregister_queue()
>>    blk-wbt: remove unnecessary check in wbt_enable_default()
>>    blk-wbt: make enable_state more accurate
>>    blk-wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
>>    elevator: add new field flags in struct elevator_queue
>>    blk-wbt: don't enable throttling if default elevator is bfq
>>
>>   block/bfq-iosched.c |  2 ++
>>   block/blk-sysfs.c   |  6 +++++-
>>   block/blk-wbt.c     | 26 ++++++++++++++++++++++----
>>   block/blk-wbt.h     | 17 ++++++++++++-----
>>   block/elevator.c    |  8 ++------
>>   block/elevator.h    |  5 ++++-
>>   6 files changed, 47 insertions(+), 17 deletions(-)
>>
> 
> .
> 

