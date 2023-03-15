Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3328C6BACF1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCOKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjCOKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:33 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D7CA12;
        Wed, 15 Mar 2023 03:02:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pc5XW3LVSz4f3s6R;
        Wed, 15 Mar 2023 18:02:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R+clxFkayjWEw--.46752S3;
        Wed, 15 Mar 2023 18:02:05 +0800 (CST)
Subject: Re: [PATCH v2 5/5] md: protect md_thread with a new disk level spin
 lock
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com,
        snitzer@kernel.org, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230315061810.653263-1-yukuai1@huaweicloud.com>
 <20230315061810.653263-6-yukuai1@huaweicloud.com>
 <16613534-5482-23c5-fa97-cfaedecab3d7@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7cc22b63-a2f7-67ed-1a50-9fb415fadb81@huaweicloud.com>
Date:   Wed, 15 Mar 2023 18:02:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <16613534-5482-23c5-fa97-cfaedecab3d7@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R+clxFkayjWEw--.46752S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fWw4DArWxJw13JF43KFg_yoW8Gr4rpr
        yxXFy5JrWUCr1kAr18J3WUJa4Yyr1Iq3WUAry5WF17Jw15GryaqryjvFyjgF1DXF48Jr4D
        Jr15tF4fZryDJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/15 17:39, Guoqing Jiang 写道:
> 
> 
> On 3/15/23 14:18, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our test reports a uaf for 'mddev->sync_thread':
>>
>> T1                      T2
>> md_start_sync
>>   md_register_thread
>>             raid1d
>>              md_check_recovery
>>               md_reap_sync_thread
>>                md_unregister_thread
>>                 kfree
>>
>>   md_wakeup_thread
>>    wake_up
>>    ->sync_thread was freed
> 
> Better to provide the relevant uaf (user after free perhaps you mean)
> log from the test.
Ok, I'll add uaf report(the report is from v5.10) in the next version.
> 
>> Currently, a global spinlock 'pers_lock' is borrowed to protect
>> 'mddev->thread', this problem can be fixed likewise, however, there might
>> be similar problem for other md_thread, and I really don't like the 
>> idea to
>> borrow a global lock.
>>
>> This patch use a disk level spinlock to protect md_thread in relevant 
>> apis.
> 
> It is array level I think, and you probably want to remove the comment.
> 
> * pers_lockdoes extra service to protect accesses to
> * mddev->thread when the mutex cannot be held.

Yes, I missed this.

Thanks,
Kuai
> 
> Thanks,
> Guoqing
> .
> 

