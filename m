Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533266F0426
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbjD0KYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243568AbjD0KYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:24:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A3049F1;
        Thu, 27 Apr 2023 03:23:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q6Wzv1vDwz4f3tPH;
        Thu, 27 Apr 2023 18:23:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+k6TUpkG_+gIA--.28455S3;
        Thu, 27 Apr 2023 18:23:56 +0800 (CST)
Subject: Re: [PATCH 1/3] md/raid10: fix slab-out-of-bounds in
 md_bitmap_get_counter
To:     linan666@huaweicloud.com, song@kernel.org, neilb@suse.de,
        Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230427085612.1346752-1-linan666@huaweicloud.com>
 <20230427085612.1346752-2-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <39b4db2d-ae72-1006-fddf-244be5c83afb@huaweicloud.com>
Date:   Thu, 27 Apr 2023 18:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230427085612.1346752-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+k6TUpkG_+gIA--.28455S3
X-Coremail-Antispam: 1UD129KBjvJXoW7GFyDCw1rWFykZr1rtF4UXFb_yoW8JF48pF
        sru345Cr1rAF47uF1jvry8uFyrX3Z8KFZrGryIk345ua9rGF98ur4rG3WYva4kCr1rGa98
        XF15Ja93W3yvqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
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

ÔÚ 2023/04/27 16:56, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> If we write a large number to md/bitmap_set_bits, md_bitmap_checkpage()
> will return -EINVAL because "page >= bitmap->pages", but the return value
> was not checked immediately in md_bitmap_get_counter() in order to set
> *blocks value and slab-out-of-bounds occurs.
> 
> Return directly if err is -EINVAL.
> 
> Fixes: ef4256733506 ("md/bitmap: optimise scanning of empty bitmaps.")
> Signed-off-by: Li Nan <linan122@huawei.com>

This patch looks good to me, feel free to add£º

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

By the way, I think it's better for bitmap_store() to return error
number if bitmap doesn't exist or setting dirty bits failed.

Thnaks,
Kuai
> ---
>   drivers/md/md-bitmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 920bb68156d2..0b41ef422da7 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1388,6 +1388,8 @@ __acquires(bitmap->lock)
>   	int err;
>   
>   	err = md_bitmap_checkpage(bitmap, page, create, 0);
> +	if (err == -EINVAL)
> +		return NULL;
>   
>   	if (bitmap->bp[page].hijacked ||
>   	    bitmap->bp[page].map == NULL)
> 

