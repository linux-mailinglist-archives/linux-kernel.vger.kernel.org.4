Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC576F11A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbjD1GMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjD1GMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:12:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE51710;
        Thu, 27 Apr 2023 23:12:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q72Ly5m5Kz4f3mVv;
        Fri, 28 Apr 2023 14:12:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiC2Y0tk65qRHg--.3612S3;
        Fri, 28 Apr 2023 14:12:08 +0800 (CST)
Subject: Re: [PATCH v2] block: Skip destroyed blkg when restart in
 blkg_destroy_all()
To:     Tao Su <tao1.su@linux.intel.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai1@huaweicloud.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230428045149.1310073-1-tao1.su@linux.intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c007f189-8573-8390-4338-ae4c281ffbee@huaweicloud.com>
Date:   Fri, 28 Apr 2023 14:12:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230428045149.1310073-1-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiC2Y0tk65qRHg--.3612S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw48JrWUKFy3CF4kCrW3ZFb_yoW8AFWfp3
        9rGw1Ykr9YkFn29a17W3W7uryFga1rXr1rW3y3W34Ykr17XrZ2v3W09w1DJFyxAF1fGrWr
        Ar1UtryFkws5u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
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

ÔÚ 2023/04/28 12:51, Tao Su Ð´µÀ:
> Kernel hang in blkg_destroy_all() when total blkg greater than
> BLKG_DESTROY_BATCH_SIZE, because of not removing destroyed blkg in
> blkg_list. So the size of blkg_list is same after destroying a
> batch of blkg, and the infinite 'restart' occurs.
> 
> Since blkg should stay on the queue list until blkg_free_workfn(),
> skip destroyed blkg when restart a new round, which will solve this
> kernel hang issue and satisfy the previous will to restart.

Please add a fix tag:

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from 
blkg_free_workfn() and blkcg_deactivate_policy()")
> 
> Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>

You can remove this tag, and feel free to add:

Suggested-and-reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks,
Kuai
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
> v2:
> - change 'directly remove destroyed blkg' to 'skip destroyed blkg'
> 
> v1:
> - https://lore.kernel.org/all/20230425075911.839539-1-tao1.su@linux.intel.com/
> 
>   block/blk-cgroup.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bd50b55bdb61..75bad5d60c9f 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -528,6 +528,9 @@ static void blkg_destroy_all(struct gendisk *disk)
>   	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>   		struct blkcg *blkcg = blkg->blkcg;
>   
> +		if (hlist_unhashed(&blkg->blkcg_node))
> +			continue;
> +
>   		spin_lock(&blkcg->lock);
>   		blkg_destroy(blkg);
>   		spin_unlock(&blkcg->lock);
> 

