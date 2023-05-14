Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB95701CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjENLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjENLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:08:13 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA11A8;
        Sun, 14 May 2023 04:08:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QK0903g4Pz4f3tqB;
        Sun, 14 May 2023 19:08:04 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LMTwWBkgtezJQ--.4196S3;
        Sun, 14 May 2023 19:08:05 +0800 (CST)
Message-ID: <6ed5b778-24f6-25c2-7689-113bb0297847@huaweicloud.com>
Date:   Sun, 14 May 2023 19:08:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/4] md/raid10: fix wrong setting of
 max_corr_read_errors
To:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>
Cc:     linan666@huaweicloud.com, neilb@suse.de, Rob.Becker@riverbed.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-4-linan666@huaweicloud.com>
 <ddec947c-d2b9-e4fe-30e6-02c76f162ab3@huaweicloud.com>
 <CAPhsuW6zSN86vGO9rd-oTq4TuCYLc+ftrAO6mo6UE7qCNJaCUw@mail.gmail.com>
 <5db8b619-7eac-79be-10e4-1292a44b943b@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <5db8b619-7eac-79be-10e4-1292a44b943b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LMTwWBkgtezJQ--.4196S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4UKw4kWF4xXF18Kw43trb_yoWkKrbEgF
        4Iywn3Gr48Arn2ya1DZ39IvrWDGFWUW3yrJF1DKF4YqwnrZFyftF4ktF9Yqr48JFnY9ryr
        uasYqF42krsIyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
        M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/13 10:21, Yu Kuai 写道:
> Hi,
> 
> 在 2023/05/13 9:08, Song Liu 写道:
>> On Fri, May 5, 2023 at 7:02 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> Hi,
>>>
>>> 在 2023/05/06 9:23, linan666@huaweicloud.com 写道:
>>>> From: Li Nan <linan122@huawei.com>
>>>>
>>>> max_corr_read_errors should not be negative number. Change it to
>>>> unsigned int where use it.
>>>>
>>>
>>> Looks good, feel free to add:
>>>
>>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>>>
>>>> Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of 
>>>> correctable read errors.")
>>>> Signed-off-by: Li Nan <linan122@huawei.com>
>>
>> Hmm.. Does the current code break in any cases?
> 
> The problem is that somewhere use unsigned value, and somewhere use
> signed value, and I thinsk the only functional change is in
> fix_read_error(), if max_read_errors is negative, the judgement will
> always pass before this patch:
> 
> if (atomic_read(&rdev->read_errors) > max_read_errors)
> 

In addition, it is confusing for users after setting a huge number to it.
   # echo 4294967295 > /sys/block/$disk/md/max_read_errors
   # cat /sys/block/$disk/md/max_read_errors
     -1

-- 
Thanks,
Nan

