Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89376EBC8E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjDWDIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjDWDIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:08:46 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692532132;
        Sat, 22 Apr 2023 20:08:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q3tWV6vqJz4f4FTB;
        Sun, 23 Apr 2023 11:08:38 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLA2oURkW4DZHw--.28693S3;
        Sun, 23 Apr 2023 11:08:40 +0800 (CST)
Subject: Re: [PATCH v2] md/md-multipath: guard against a possible NULL
 dereference
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230421062110.368253-1-d-tatianin@yandex-team.ru>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eba0985d-27fc-ce0f-537a-b8b713d75262@huaweicloud.com>
Date:   Sun, 23 Apr 2023 11:08:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230421062110.368253-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLA2oURkW4DZHw--.28693S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1rZFWkJr4ruFWkZF4xZwb_yoWkZFcE9a
        1FvrWxtrW5AFnrAFnrAr4fZry0yFWUWr18Wrs2qr4rA3W5tw4kArWDZrn8XanxCw4rCF4D
        Jw1vkw10vF1jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/04/21 14:21, Daniil Tatianin Ð´µÀ:
> mempool_alloc might fail to allocate a slot, in which case we will end
> up dereferencing a NULL mp_bh pointer.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
> Changes since v1: fixed a typo
> ---
>   drivers/md/md-multipath.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> index 66edf5e72bd6..8dfa353440e5 100644
> --- a/drivers/md/md-multipath.c
> +++ b/drivers/md/md-multipath.c
> @@ -108,6 +108,8 @@ static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
>   		return true;
>   
>   	mp_bh = mempool_alloc(&conf->pool, GFP_NOIO);

The comment in mempool_alloc says:

Note that due to preallocation, this function *never* fails when called
from process contexts.

And there are many places to use this way, so I think this patch is not
needed.

Thanks,
Kuai
> +	if (!mp_bh)
> +		return false;
>   
>   	mp_bh->master_bio = bio;
>   	mp_bh->mddev = mddev;
> 

