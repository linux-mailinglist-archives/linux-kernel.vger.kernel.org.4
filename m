Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BFB6F8DD2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjEFCAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEFCAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:00:42 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A994C05;
        Fri,  5 May 2023 19:00:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QCrNz6F8gz4f3nqt;
        Sat,  6 May 2023 10:00:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCLDtFVkVJWQIA--.1449S3;
        Sat, 06 May 2023 10:00:37 +0800 (CST)
Subject: Re: [PATCH v2 2/4] md/raid10: fix overflow in safe_delay_store
To:     linan666@huaweicloud.com, song@kernel.org, neilb@suse.de,
        Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-3-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9e7cbf09-aedd-5d16-f847-af519b309de5@huaweicloud.com>
Date:   Sat, 6 May 2023 10:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230506012315.3370489-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCLDtFVkVJWQIA--.1449S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWkKw18tFW7Gw4UZw47Arb_yoW5tF47pa
        93G34avrWUtrWIkF1SvF4DWFy3W3Z7XrW7t342yrWfXFZrXFn8Kr1fGw4Fvr1UCrW5ZF43
        ArW5JFyDCr1Dt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/06 9:23, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> There is no input check when echo md/safe_mode_delay, and overflow will
> occur. There is risk of overflow in strict_strtoul_scaled(), too. Fix it
> by using kstrtoul instead of parsing word one by one.

Other than some nits below, this patch looks good to me,
feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Fixes: 72e02075a33f ("md: factor out parsing of fixed-point numbers")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 70 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8e344b4b3444..fd5c3babcd6d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3767,52 +3767,74 @@ static int analyze_sbs(struct mddev *mddev)
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

This is correct, I guess the reason to use unsigned int is that u64/u64
will compile error in some 32-bit architecture. It's better to use
div64_u64() here.

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
>   {
>   	unsigned long msec;
> +	int ret;
>   
>   	if (mddev_is_clustered(mddev)) {
>   		pr_warn("md: Safemode is disabled for clustered mode\n");
>   		return -EINVAL;
>   	}
>   
> -	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
> +	ret = strict_strtoul_scaled(cbuf, &msec, 3);
> +	if (ret < 0)
> +		return ret;
> +	if (msec > UINT_MAX)
>   		return -EINVAL;
> +
>   	if (msec == 0)
>   		mddev->safemode_delay = 0;
>   	else {
>   		unsigned long old_delay = mddev->safemode_delay;
> +		/* HZ <= 1000, so new_delay < UINT_MAX, too */

new_delay <= UNIT_MAX

>   		unsigned long new_delay = (msec*HZ)/1000;

There is no need do declare them as 'unsigned long', you can use
'unsigned int' directly now.

And you can also use DIV64_U64_ROUND_UP() directly here.

Thanks,
Kuai
>   
>   		if (new_delay == 0)
> 

