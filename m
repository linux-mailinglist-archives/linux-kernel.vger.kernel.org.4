Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77896F04D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbjD0LQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbjD0LQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:16:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1291BD9;
        Thu, 27 Apr 2023 04:16:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q6Y8G1zDdz4f3w0G;
        Thu, 27 Apr 2023 19:16:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLN9WUpk0uUHIQ--.33659S3;
        Thu, 27 Apr 2023 19:16:15 +0800 (CST)
Subject: Re: [PATCH 2/3] md/raid10: fix overflow in safe_delay_store
To:     linan666@huaweicloud.com, song@kernel.org, neilb@suse.de,
        Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230427085612.1346752-1-linan666@huaweicloud.com>
 <20230427085612.1346752-3-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cc4cfcf6-54cf-a271-4082-687e8ba5c1c5@huaweicloud.com>
Date:   Thu, 27 Apr 2023 19:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230427085612.1346752-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLN9WUpk0uUHIQ--.33659S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy3tF4UWFy8KF4xAF4rAFb_yoW5AFW8pa
        93G34avr4UtryIkF1SvF4DWFy5WFn7XrWDt34IyrZ3XF4DXFn8K34rGw4Fvr1UC3yUZF47
        Jry5JF1DCr9FkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Other than some nits below, this patch looks good to me.

ÔÚ 2023/04/27 16:56, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> There is no input check when echo md/safe_mode_delay, and overflow will
> occur. There is risk of overflow in strict_strtoul_scaled(), too. Fixed
typo: Fix

> it by using kstrtoul instead of parsing word one by one.
> 
> Fixes: 72e02075a33f ("md: factor out parsing of fixed-point numbers")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 66 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 43 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8e344b4b3444..faffbd042925 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3767,35 +3767,51 @@ static int analyze_sbs(struct mddev *mddev)
>    */
>   int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
>   {
> -	unsigned long result = 0;
> -	long decimals = -1;
> -	while (isdigit(*cp) || (*cp == '.' && decimals < 0)) {
> -		if (*cp == '.')
> -			decimals = 0;
> -		else if (decimals < scale) {
> -			unsigned int value;
> -			value = *cp - '0';
> -			result = result * 10 + value;
> -			if (decimals >= 0)
> -				decimals++;
> -		}
> -		cp++;
> -	}
> -	if (*cp == '\n')
> -		cp++;
> -	if (*cp)
> +	unsigned long result = 0, decimals = 0;
> +	char *pos, *str;
> +	int rv;
> +
> +	str = kmemdup_nul(cp, strlen(cp), GFP_KERNEL);
> +	if (!str)
> +		return -ENOMEM;
> +	pos = strchr(str, '.');
> +	if (pos) {
> +		int cnt = scale;
> +
> +		*pos = '\0';
> +		while (isdigit(*(++pos))) {
> +			if (cnt) {
> +				decimals = decimals * 10 + *pos - '0';
> +				cnt--;
> +			}
> +		}
> +		if (*pos == '\n')
> +			pos++;
> +		if (*pos) {
> +			kfree(str);
> +			return -EINVAL;
> +		}
> +		decimals *= int_pow(10, cnt);
> +	}
> +
> +	rv = kstrtoul(str, 10, &result);
> +	kfree(str);
> +	if (rv)
> +		return rv;
> +
> +	if (result > (ULONG_MAX - decimals) / (unsigned int)int_pow(10, scale))
>   		return -EINVAL;
> -	if (decimals < 0)
> -		decimals = 0;
> -	*res = result * int_pow(10, scale - decimals);
> -	return 0;
> +	*res = result * int_pow(10, scale) + decimals;
> +
> +	return rv;
>   }
>   
>   static ssize_t
>   safe_delay_show(struct mddev *mddev, char *page)
>   {
> -	int msec = (mddev->safemode_delay*1000)/HZ;
> -	return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
> +	unsigned int msec = ((unsigned long)mddev->safemode_delay*1000)/HZ;
> +
> +	return sprintf(page, "%u.%03u\n", msec/1000, msec%1000);
>   }
>   static ssize_t
>   safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
> @@ -3809,10 +3825,14 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
>   
>   	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
>   		return -EINVAL;

strict_strtoul_scaled() can return -ENOMEM now.

> +	if (msec > UINT_MAX)
> +		return -EINVAL;
> +
>   	if (msec == 0)
>   		mddev->safemode_delay = 0;
>   	else {
>   		unsigned long old_delay = mddev->safemode_delay;
> +		/* HZ <= 1000, so new_delay < UINT_MAX, too */
>   		unsigned long new_delay = (msec*HZ)/1000;
>   
>   		if (new_delay == 0)
> 

