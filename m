Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AFC70B3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 05:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjEVDqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjEVDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 23:46:18 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D6C4;
        Sun, 21 May 2023 20:46:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPjzT0Cf7z4f3v4h;
        Mon, 22 May 2023 11:46:13 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77KA5Wpky7bMJw--.54379S3;
        Mon, 22 May 2023 11:46:10 +0800 (CST)
Subject: Re: [PATCH -next 1/5] md/raid5: don't allow replacement while reshape
 is not done
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, reddunur@online.de, jovetoo@gmail.com,
        dgilmour76@gmail.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230512015610.821290-1-yukuai1@huaweicloud.com>
 <20230512015610.821290-2-yukuai1@huaweicloud.com>
 <CAPhsuW5YFnqkOFz2tU+GQT=TnVXc-RySECaj=FOHw2rEh5tz0g@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aad4acb6-ccc7-560e-e251-3b4b28a862ef@huaweicloud.com>
Date:   Mon, 22 May 2023 11:46:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5YFnqkOFz2tU+GQT=TnVXc-RySECaj=FOHw2rEh5tz0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77KA5Wpky7bMJw--.54379S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3AFW5JFW8XrWkuw4xXrb_yoW8Cw1rpa
        ySkFs8ZF4UZw45Ca1DJ3WrWFyS939agrZ0krnxu34Yv34Yqr18G3yxKry5Cr48Zr4Yk3yF
        qr1UGa9xJw10y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/20 7:33, Song Liu 写道:
> On Thu, May 11, 2023 at 6:59 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Set rdev replacement has but not only two conditions:
>>
>> 1) MD_RECOVERY_RUNNING is not set;
>> 2) rdev nr_pending is 0;
> 
> The above is confusing. I updated it and applied the set to md-next.

By the way, I'm willing to add regression test for these problems, and I
already send two other tests and there are no response yet. Should the
test wait for fixed patch to be applied to make progress?

Thanks,
Kuai
> Please let me know if it looks good.
> 
> Thanks,
> Song
> 
>>
>> If reshape is interrupted(for example, echo frozen to sync_action), then
>> rdev replacement can be set. It's safe because reshape is always prior to
>> resync in md_check_recovery(). However, if system reboots, then kernel will
>> complain cannot handle concurrent replacement and reshape and this array
>> is not able to assemble anymore.
>>
>> Fix this problem by don't allow replacement until reshape is done.
>>
>> Reported-by: Peter Neuwirth <reddunur@online.de>
>> Link: https://lore.kernel.org/linux-raid/e2f96772-bfbc-f43b-6da1-f520e5164536@online.de/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid5.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index a58507a4345d..bd3b535c0739 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -8378,6 +8378,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                  p = conf->disks + disk;
>>                  tmp = rdev_mdlock_deref(mddev, p->rdev);
>>                  if (test_bit(WantReplacement, &tmp->flags) &&
>> +                   mddev->reshape_position == MaxSector &&
>>                      p->replacement == NULL) {
>>                          clear_bit(In_sync, &rdev->flags);
>>                          set_bit(Replacement, &rdev->flags);
>> --
>> 2.39.2
>>
> .
> 

