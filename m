Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6468B444
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBFCzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBFCzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:55:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5051A1A955;
        Sun,  5 Feb 2023 18:55:50 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P99nr73qWzJsFp;
        Mon,  6 Feb 2023 10:54:08 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 10:55:48 +0800
Subject: Re: [PATCH-next v2] loop: loop_set_status_from_info() check before
 assignment
To:     Zhong Jinghua <zhongjinghua@huawei.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20230206020716.2036-1-zhongjinghua@huawei.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <d9486c88-33b1-3dc1-d58c-89de73679e50@huawei.com>
Date:   Mon, 6 Feb 2023 10:55:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230206020716.2036-1-zhongjinghua@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 10:07 AM, Zhong Jinghua wrote:
> In loop_set_status_from_info(), lo->lo_offset and lo->lo_sizelimit should
> be checked before reassignment, because if an overflow error occurs, the
> original correct value will be changed to the wrong value, and it will not
> be changed back.
>
> Modifying to the wrong value logic is always not quiet right, we hope to
> optimize this.
>
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
LGTM
> ---
>  v1->v2: Modify note: overflowing -> overflow 
>  drivers/block/loop.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1518a6423279..1b35cbd029c7 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -977,13 +977,13 @@ loop_set_status_from_info(struct loop_device *lo,
>  		return -EINVAL;
>  	}
>  
> +	/* Avoid assigning overflow values */
> +	if (info->lo_offset > LLONG_MAX || info->lo_sizelimit > LLONG_MAX)
> +		return -EOVERFLOW;
> +
>  	lo->lo_offset = info->lo_offset;
>  	lo->lo_sizelimit = info->lo_sizelimit;
>  
> -	/* loff_t vars have been assigned __u64 */
> -	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
> -		return -EOVERFLOW;
> -
>  	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
>  	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
>  	lo->lo_flags = info->lo_flags;

