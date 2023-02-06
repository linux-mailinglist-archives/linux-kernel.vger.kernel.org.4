Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E870D68B46F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBFDTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFDTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:19:31 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCD1ABF5;
        Sun,  5 Feb 2023 19:19:28 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P9BLy4ZwBz4f3k67;
        Mon,  6 Feb 2023 11:19:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+7ceBjzshECw--.31350S3;
        Mon, 06 Feb 2023 11:19:24 +0800 (CST)
Subject: Re: [PATCH-next v2] loop: loop_set_status_from_info() check before
 assignment
To:     Zhong Jinghua <zhongjinghua@huawei.com>, axboe@kernel.dk,
        code@siddh.me, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230206020716.2036-1-zhongjinghua@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <32179e8a-a3ca-9412-1977-fdaa7f065691@huaweicloud.com>
Date:   Mon, 6 Feb 2023 11:19:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230206020716.2036-1-zhongjinghua@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+7ceBjzshECw--.31350S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWDGFWUWr43Xr1xGw13CFg_yoW8Xw48pF
        srWFyUAa1rKF4fKF4Dt348XFW5G3W7Gry3uFy7tay8AryIvFn2gr9rG3y5urZ7JrykurWF
        gF15JFykZF1UGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/02/06 10:07, Zhong Jinghua Ð´µÀ:
> In loop_set_status_from_info(), lo->lo_offset and lo->lo_sizelimit should
> be checked before reassignment, because if an overflow error occurs, the
> original correct value will be changed to the wrong value, and it will not
> be changed back.
> 
> Modifying to the wrong value logic is always not quiet right, we hope to
> optimize this.
> 

Please add a fix tag and cc stable:

Fixes: c490a0b5a4f3 ("loop: Check for overflow while configuring loop")

This commit doesn't fix the problem it described in commit message.

Thanks,
Kuai

> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   v1->v2: Modify note: overflowing -> overflow
>   drivers/block/loop.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1518a6423279..1b35cbd029c7 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -977,13 +977,13 @@ loop_set_status_from_info(struct loop_device *lo,
>   		return -EINVAL;
>   	}
>   
> +	/* Avoid assigning overflow values */
> +	if (info->lo_offset > LLONG_MAX || info->lo_sizelimit > LLONG_MAX)
> +		return -EOVERFLOW;
> +
>   	lo->lo_offset = info->lo_offset;
>   	lo->lo_sizelimit = info->lo_sizelimit;
>   
> -	/* loff_t vars have been assigned __u64 */
> -	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
> -		return -EOVERFLOW;
> -
>   	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
>   	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
>   	lo->lo_flags = info->lo_flags;
> 

