Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1C701D08
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjENLPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjENLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:15:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBE187;
        Sun, 14 May 2023 04:15:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QK0Kp64lVz4f3wtQ;
        Sun, 14 May 2023 19:15:42 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LPfwmBkDDe0JQ--.4748S3;
        Sun, 14 May 2023 19:15:43 +0800 (CST)
Message-ID: <863a4b6e-ff85-2d82-cf8b-bec87e0f5468@huaweicloud.com>
Date:   Sun, 14 May 2023 19:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/4] md/raid10: fix slab-out-of-bounds in
 md_bitmap_get_counter
To:     Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc:     neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-2-linan666@huaweicloud.com>
 <CAPhsuW7p=xw41EZ-f+UHMO+o5bLFGirORPE-gfnkYqfpjv-rzw@mail.gmail.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW7p=xw41EZ-f+UHMO+o5bLFGirORPE-gfnkYqfpjv-rzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LPfwmBkDDe0JQ--.4748S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4UJFyxGFW8CFyDJF1DZFb_yoW8Ww13pF
        srW3W5Crn5JF1UuF1jvFykAFyrtws5KrZrJrWrG345ua47GF9xArWrKF1Y9wn29r13GFZx
        XF45G3WfurnYqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/13 9:05, Song Liu 写道:
> On Fri, May 5, 2023 at 6:24 PM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> If we write a large number to md/bitmap_set_bits, md_bitmap_checkpage()
>> will return -EINVAL because "page >= bitmap->pages", but the return value
>> was not checked immediately in md_bitmap_get_counter() in order to set
>> *blocks value and slab-out-of-bounds occurs.
>>
>> Return directly if err is -EINVAL.
>>
>> Fixes: ef4256733506 ("md/bitmap: optimise scanning of empty bitmaps.")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md-bitmap.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
>> index 920bb68156d2..0b41ef422da7 100644
>> --- a/drivers/md/md-bitmap.c
>> +++ b/drivers/md/md-bitmap.c
>> @@ -1388,6 +1388,8 @@ __acquires(bitmap->lock)
>>          int err;
>>
>>          err = md_bitmap_checkpage(bitmap, page, create, 0);
>> +       if (err == -EINVAL)
>> +               return NULL;
> 
> This logic is error prone. Since we are on it, let's fix it better.
> Specifically, we can move "page >= bitmap->pages" check out

I will check out it in v3.

> of md_bitmap_checkpage(). (and fix the call site in md_bitmap_resize
> for clustered md).
> 

In md_bitmap_resize(), incoming parameters "page < bitmap->counts.page" 
and do not have this problem.


> Also, could you please add a mdadm test for this issue?
> 

It's my pleasure.

> Thanks,
> Song
> 
>>
>>          if (bitmap->bp[page].hijacked ||
>>              bitmap->bp[page].map == NULL)
>> --
>> 2.31.1
>>
> .

Thanks for your suggesion.

-- 
Thanks,
Nan

