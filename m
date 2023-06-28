Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA14A740DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjF1JwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:52:23 -0400
Received: from dggsgout11.his.huawei.com ([45.249.212.51]:12484 "EHLO
        dggsgout11.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjF1J0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:26:43 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrbnD1dNJz4f3l1j;
        Wed, 28 Jun 2023 17:26:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA30JPP_JtkFqjhMg--.49301S3;
        Wed, 28 Jun 2023 17:26:40 +0800 (CST)
Subject: Re: [PATCH 2/3] md/raid10: factor out get_rdev_repl_from_mirror()
To:     linan666@huaweicloud.com, song@kernel.org,
        guoqing.jiang@cloud.ionos.com, colyli@suse.de, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230628015752.102267-1-linan666@huaweicloud.com>
 <20230628015752.102267-3-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <36a6be92-f9c5-fd7c-20d9-741e2a6f133f@huaweicloud.com>
Date:   Wed, 28 Jun 2023 17:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230628015752.102267-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JPP_JtkFqjhMg--.49301S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xuFyDAr1DKF17XF1DWrg_yoW8uw4UpF
        4DK3WSyr4UJw42kFsrXFWDAa4avrn2qF40yry3u34ruw13trWUAF1kG3yfArn8ZFZ5u34j
        qa15Kr4kC3WjqFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/28 9:57, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> Factor out a helper to get 'rdev' and 'replacement' from config->mirrors.
> Just to make code cleaner and prepare to fix the bug of io loss while
> 'replacement' replace 'rdev'.
> 
> There is no functional change.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 3e6a09aaaba6..eaaf6307ddda 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1346,6 +1346,26 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
>   	}
>   }
>   
> +static void get_rdev_repl_from_mirror(struct raid10_info *mirror,
> +				 struct md_rdev **prdev,
> +				 struct md_rdev **prrdev)

I don't like this name, but I can live with this for now, related code
will be removed eventually.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> +{
> +	struct md_rdev *rdev, *rrdev;
> +
> +	rrdev = rcu_dereference(mirror->replacement);
> +	/*
> +	 * Read replacement first to prevent reading both rdev and
> +	 * replacement as NULL during replacement replace rdev.
> +	 */
> +	smp_mb();
> +	rdev = rcu_dereference(mirror->rdev);
> +	if (rdev == rrdev)
> +		rrdev = NULL;
> +
> +	*prrdev = rrdev;
> +	*prdev = rdev;
> +}
> +
>   static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
>   {
>   	int i;
> @@ -1489,15 +1509,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
>   		int d = r10_bio->devs[i].devnum;
>   		struct md_rdev *rdev, *rrdev;
>   
> -		rrdev = rcu_dereference(conf->mirrors[d].replacement);
> -		/*
> -		 * Read replacement first to prevent reading both rdev and
> -		 * replacement as NULL during replacement replace rdev.
> -		 */
> -		smp_mb();
> -		rdev = rcu_dereference(conf->mirrors[d].rdev);
> -		if (rdev == rrdev)
> -			rrdev = NULL;
> +		get_rdev_repl_from_mirror(&conf->mirrors[d], &rdev, &rrdev);
>   		if (rdev && (test_bit(Faulty, &rdev->flags)))
>   			rdev = NULL;
>   		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
> 

