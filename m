Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA974D617
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGJNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJNAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:00:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E450AA8;
        Mon, 10 Jul 2023 06:00:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R03yS1xDCz4f4XSD;
        Mon, 10 Jul 2023 21:00:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK_vAKxkCTebNg--.58698S3;
        Mon, 10 Jul 2023 21:00:33 +0800 (CST)
Subject: Re: [PATCH 2/2] md/raid10: handle replacement devices in
 fix_recovery_read_error
To:     Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230627034127.4000994-1-linan666@huaweicloud.com>
 <20230627034127.4000994-3-linan666@huaweicloud.com>
 <CAPhsuW7+bWe9YDMnjRgb657Fz7Vs_4wnBcU9jVSXuofKhaO38Q@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <62e6e2bc-4fd2-0ee9-6215-609778e0289a@huaweicloud.com>
Date:   Mon, 10 Jul 2023 21:00:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7+bWe9YDMnjRgb657Fz7Vs_4wnBcU9jVSXuofKhaO38Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK_vAKxkCTebNg--.58698S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr17tw4rAFW3GFW3AF1xAFb_yoW5Jryfpw
        1DG3Z0kryDJa4UZF1DZayDAasYkws3trW5Krn8J3W2k3saqrZxKFW7WrW5Cry8uF1a9F4Y
        qan8WrW3ua4DKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/07 16:33, Song Liu 写道:
> On Tue, Jun 27, 2023 at 11:42 AM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> In fix_recovery_read_error(), the handling of replacement devices is
>> missing. Add it. If io error is from replacement, error this device
>> directly. If io error is from other device, just set badblocks for
>> replacement.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/raid10.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 5105273f60e9..6d9025089455 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -2551,7 +2551,7 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
>>
>>          while (sectors) {
>>                  int s = sectors;
>> -               struct md_rdev *rdev;
>> +               struct md_rdev *rdev, *repl;
>>                  sector_t addr;
>>                  int ok;
>>
>> @@ -2559,6 +2559,7 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
>>                          s = PAGE_SIZE >> 9;
>>
>>                  rdev = conf->mirrors[dr].rdev;
>> +               repl = conf->mirrors[dw].replacement;
>>                  addr = r10_bio->devs[0].addr + sect,
>>                  ok = sync_page_io(rdev,
>>                                    addr,
>> @@ -2580,6 +2581,9 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
>>                                          set_bit(MD_RECOVERY_NEEDED,
>>                                                  &rdev->mddev->recovery);
>>                          }
>> +                       if (repl && !sync_page_io(repl, addr, s << 9,
>> +                           pages[idx], REQ_OP_WRITE, false))
>> +                               md_error(mddev, repl);
>>                  }
>>                  if (!ok) {
>>                          /* We don't worry if we cannot set a bad block -
>> @@ -2592,7 +2596,9 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
>>                                  /* need bad block on destination too */
>>                                  rdev = conf->mirrors[dw].rdev;
>>                                  addr = r10_bio->devs[1].addr + sect;
>> -                               if (!rdev_set_badblocks(rdev, addr, s, 0)) {
>> +                               if (!rdev_set_badblocks(rdev, addr, s, 0) ||
>> +                                   (repl &&
>> +                                   !rdev_set_badblocks(repl, addr, s, 0))) {
> 
> Do we really want this in the if () statement? Shall we always set
> badblock on both rdev and repl?

I think this is wrong to set repl badblocks inside this, because if
setting badblocks for rdev failed, repl is still not handled.

By the way, I think it's better to at least try to read from all
possible copies before setting badblocks for repl.

Thanks,
Kuai
> 
> Thanks,
> Song
> 
>>                                          /* just abort the recovery */
>>                                          pr_notice("md/raid10:%s: recovery aborted due to read error\n",
>>                                                    mdname(mddev));
>> --
>> 2.39.2
>>
> .
> 

