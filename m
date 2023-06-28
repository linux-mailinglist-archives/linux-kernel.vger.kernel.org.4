Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57CD740A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjF1H6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:58:11 -0400
Received: from dggsgout12.his.huawei.com ([45.249.212.56]:11131 "EHLO
        dggsgout12.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjF1Hzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:55:50 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QrX0T6ff5z4f3whf;
        Wed, 28 Jun 2023 14:36:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbDb1Jtkz4XYMg--.38460S3;
        Wed, 28 Jun 2023 14:36:11 +0800 (CST)
Subject: Re: [PATCH 1/3] md/raid10: check replacement and rdev to prevent
 submit the same io twice
To:     linan666@huaweicloud.com, song@kernel.org,
        guoqing.jiang@cloud.ionos.com, colyli@suse.de, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230628015752.102267-1-linan666@huaweicloud.com>
 <20230628015752.102267-2-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cf66fbb5-8174-3baf-4a00-63f46a8e41a9@huaweicloud.com>
Date:   Wed, 28 Jun 2023 14:36:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230628015752.102267-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbDb1Jtkz4XYMg--.38460S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKry7Gr1ktF1xCF4UGFWktFb_yoW8JrW8pa
        1kK3Wj9w1UCw42kFsFq34UCa40qw4kJrW3ArZ8X3yrXasxXFW5Cw4rG345Wr4DXr4Yga4U
        XF1Uta1xJa1UXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/28 9:57, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> After commit 4ca40c2ce099 ("md/raid10: Allow replacement device to be
> replace old drive."), 'rdev' and 'replacement' could appear to be
> identical. There are already checks for that in wait_blocked_dev() and
> raid10_write_request(). Add check for raid10_handle_discard() now.
> 

I'm working on synchronize io with array configuration, so that these
checks is not necessary and can be removed, however, this might take
some time, before that, this patch LGTM:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index fabc340aae4f..3e6a09aaaba6 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1811,6 +1811,8 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
>   		r10_bio->devs[disk].bio = NULL;
>   		r10_bio->devs[disk].repl_bio = NULL;
>   
> +		if (rdev == rrdev)
> +			rrdev = NULL;
>   		if (rdev && (test_bit(Faulty, &rdev->flags)))
>   			rdev = NULL;
>   		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
> 

