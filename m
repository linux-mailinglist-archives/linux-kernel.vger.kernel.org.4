Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE0701D0C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjENLSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjENLSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:18:12 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587A1BF0;
        Sun, 14 May 2023 04:18:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QK0NX68Gzz4f4046;
        Sun, 14 May 2023 19:18:04 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LNsw2Bk_lO0JQ--.4903S3;
        Sun, 14 May 2023 19:18:06 +0800 (CST)
Message-ID: <ccd37c99-e47e-b662-2e62-cf13180639fd@huaweicloud.com>
Date:   Sun, 14 May 2023 19:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/4] md/raid10: fix overflow in safe_delay_store
To:     Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
        song@kernel.org, neilb@suse.de, Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-3-linan666@huaweicloud.com>
 <9e7cbf09-aedd-5d16-f847-af519b309de5@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <9e7cbf09-aedd-5d16-f847-af519b309de5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LNsw2Bk_lO0JQ--.4903S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWkCry8uryrAr1fXr13Arb_yoW7Jry3pF
        n5JrWUWryUJrn3Jr1xtr1UXFy5Jr18X3WDJr1xXFyUJr47AF1Ygr1UXrnYgr1UJrW8XF1U
        Jr1UXrnrZr1DJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUlQ6LUUUUU=
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



在 2023/5/6 10:00, Yu Kuai 写道:
> Hi,
> 
> 在 2023/05/06 9:23, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> There is no input check when echo md/safe_mode_delay, and overflow will
>> occur. There is risk of overflow in strict_strtoul_scaled(), too. Fix it
>> by using kstrtoul instead of parsing word one by one.
> 
> Other than some nits below, this patch looks good to me,
> feel free to add:
> 
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>>
>> Fixes: 72e02075a33f ("md: factor out parsing of fixed-point numbers")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.c | 70 ++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 46 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 8e344b4b3444..fd5c3babcd6d 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -3767,52 +3767,74 @@ static int analyze_sbs(struct mddev *mddev)
>>    */
>>   int strict_strtoul_scaled(const char *cp, unsigned long *res, int 
>> scale)
>>   {
>> -    unsigned long result = 0;
>> -    long decimals = -1;
>> -    while (isdigit(*cp) || (*cp == '.' && decimals < 0)) {
>> -        if (*cp == '.')
>> -            decimals = 0;
>> -        else if (decimals < scale) {
>> -            unsigned int value;
>> -            value = *cp - '0';
>> -            result = result * 10 + value;
>> -            if (decimals >= 0)
>> -                decimals++;
>> -        }
>> -        cp++;
>> -    }
>> -    if (*cp == '\n')
>> -        cp++;
>> -    if (*cp)
>> +    unsigned long result = 0, decimals = 0;
>> +    char *pos, *str;
>> +    int rv;
>> +
>> +    str = kmemdup_nul(cp, strlen(cp), GFP_KERNEL);
>> +    if (!str)
>> +        return -ENOMEM;
>> +    pos = strchr(str, '.');
>> +    if (pos) {
>> +        int cnt = scale;
>> +
>> +        *pos = '\0';
>> +        while (isdigit(*(++pos))) {
>> +            if (cnt) {
>> +                decimals = decimals * 10 + *pos - '0';
>> +                cnt--;
>> +            }
>> +        }
>> +        if (*pos == '\n')
>> +            pos++;
>> +        if (*pos) {
>> +            kfree(str);
>> +            return -EINVAL;
>> +        }
>> +        decimals *= int_pow(10, cnt);
>> +    }
>> +
>> +    rv = kstrtoul(str, 10, &result);
>> +    kfree(str);
>> +    if (rv)
>> +        return rv;
>> +
>> +    if (result > (ULONG_MAX - decimals) / (unsigned int)int_pow(10, 
>> scale))
> 
> This is correct, I guess the reason to use unsigned int is that u64/u64
> will compile error in some 32-bit architecture. It's better to use
> div64_u64() here.
> 
>>           return -EINVAL;
>> -    if (decimals < 0)
>> -        decimals = 0;
>> -    *res = result * int_pow(10, scale - decimals);
>> -    return 0;
>> +    *res = result * int_pow(10, scale) + decimals;
>> +
>> +    return rv;
>>   }
>>   static ssize_t
>>   safe_delay_show(struct mddev *mddev, char *page)
>>   {
>> -    int msec = (mddev->safemode_delay*1000)/HZ;
>> -    return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
>> +    unsigned int msec = ((unsigned long)mddev->safemode_delay*1000)/HZ;
>> +
>> +    return sprintf(page, "%u.%03u\n", msec/1000, msec%1000);
>>   }
>>   static ssize_t
>>   safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
>>   {
>>       unsigned long msec;
>> +    int ret;
>>       if (mddev_is_clustered(mddev)) {
>>           pr_warn("md: Safemode is disabled for clustered mode\n");
>>           return -EINVAL;
>>       }
>> -    if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
>> +    ret = strict_strtoul_scaled(cbuf, &msec, 3);
>> +    if (ret < 0)
>> +        return ret;
>> +    if (msec > UINT_MAX)
>>           return -EINVAL;
>> +
>>       if (msec == 0)
>>           mddev->safemode_delay = 0;
>>       else {
>>           unsigned long old_delay = mddev->safemode_delay;
>> +        /* HZ <= 1000, so new_delay < UINT_MAX, too */
> 
> new_delay <= UNIT_MAX
> 
>>           unsigned long new_delay = (msec*HZ)/1000;
> 
> There is no need do declare them as 'unsigned long', you can use
> 'unsigned int' directly now.
> 
> And you can also use DIV64_U64_ROUND_UP() directly here.
> 

I will fix it in v3.

> Thanks,
> Kuai
>>           if (new_delay == 0)
>>
> 
> .

-- 
Thanks,
Nan

