Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3D6C4169
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCVECU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCVEBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:01:49 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99864DE0E;
        Tue, 21 Mar 2023 21:00:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PhFBN2cr1z4f3mKt;
        Wed, 22 Mar 2023 12:00:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyFqfRpki+pjFQ--.44895S3;
        Wed, 22 Mar 2023 12:00:43 +0800 (CST)
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively open
 device again
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Changhui Zhong <czhong@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
 <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <dc7d28bf-35ca-7cde-ffdf-9490177dfdb9@huaweicloud.com>
 <ZBpbGKxPQcs9NYst@ovpn-8-18.pek2.redhat.com>
 <5facd7c1-fa90-99ff-bd08-cdf67fe6c1ab@huaweicloud.com>
 <a8505ded-dadd-9096-4b13-31512a2c703e@huaweicloud.com>
 <ZBp4Ql08g5YvTDAA@ovpn-8-17.pek2.redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <28ee8ba9-fa42-d3bb-d3c4-44d7e77c64be@huaweicloud.com>
Date:   Wed, 22 Mar 2023 12:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZBp4Ql08g5YvTDAA@ovpn-8-17.pek2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyFqfRpki+pjFQ--.44895S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47WryfZF15tFykZw4Utwb_yoW8Cr1fpF
        WxGa13JF4DJryYkw1Iqw17GFW5Kw4xZry5WFyUGr10k3s0vr98trZ7t3yq9r9Fqr1UGw1Y
        9F15JFn3Xa4jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyU
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/22 11:38, Ming Lei 写道:
>>>>>> Hi Yu kuai,
>>>>>>
>>>>>> Looks the original issue starts to re-appear now with the two patches:
>>>>>>
>>>>>> https://lore.kernel.org/linux-block/20221130135344.2ul4cyfstfs3znxg@quack3/
>>>>>>
>>>>>>
>>>>>> And underlying disk partition and raid partition can be observed at the
>>>>>> same time.
>>>>>>
>>>>>> Can you take a look?
>>>>> Yes, thanks for the report. I realize that sda1 adn sdb1 is created
>>>>> while raid open sda and sdb excl, and I think this problem should exist
>>>>> before this patchset.
>>>>
>>>> Looks not reproduced before applying your two patches, that is
>>>> exactly what Jan
>>>> tried to fix with 36369f46e917 ("block: Do not reread partition
>>>> table on exclusively open device").
>>>
>>> Hi, Ming
>>>
>>> I just tried your test with this patchset reverted, and I can still
>>> reporduce the problem myself.
>>
>> Oops, I forgot to revert the first patch. It's right the problem can't
>> be reporduced.
>>>
>>> raid only open this device excl, and disk_scan_partitions is not called:
>>>
>>> md_import_device
>>>    blkdev_get_by_devo
>>>
>>> I need to add some debuginfo to figure out how GD_NEED_PART_SCAN is set
>>> for sda after raid is stopped. And this should explain why sda1 is
>>> created.
>>
>> I found how GD_NEED_PART_SCAN is set now, in patch 2, this is set before
>> bd_prepare_to_claim, so preciously faild part scan will still set this
>> bit, and following patch shold fix this problem:
> 
> Just run quick test, the issue won't be reproduced with your patch, and
> the change looks rational too,
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 

Thanks for the test and review, I just do some additional change to
clear GD_NEED_PART_SCAN, I will send a patch, can you take a look?

Kuai
> 
> Thanks,
> Ming
> 
> .
> 

