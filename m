Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6CA6A8E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCCBFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCCBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:05:01 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16171457EF;
        Thu,  2 Mar 2023 17:04:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSVBG6pgSz4f3jJK;
        Fri,  3 Mar 2023 09:04:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiC3RwFkxlz2EA--.36686S3;
        Fri, 03 Mar 2023 09:04:56 +0800 (CST)
Subject: Re: [PATCH] blk-mq: quiesce queue while reallocating hctxs
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, ming.lei@redhat.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230221092436.3570192-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b63413ef-f65c-4e74-f7f8-98298842688c@huaweicloud.com>
Date:   Fri, 3 Mar 2023 09:04:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230221092436.3570192-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiC3RwFkxlz2EA--.36686S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rWr1xGF48tryrJrW7twb_yoW8AF1xpF
        W5GanrKw1IvF18Xa4jva1fWFyfJFs5Wr15ur4ag345Ar1UCrs2qr1xGr47WrW0yrZ5Arsr
        Kr4DJFWkZF4DArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

friendly ping ...

Thanks,
Kuai

ÔÚ 2023/02/21 17:24, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 8237c01f1696 ("blk-mq: use quiesced elevator switch when
> reinitializing queues") add quiesce queue while switching elevator,
> however, if old elevator is none, queue is still not quiesced. Hence
> reallocating hctxs can concurrent with run queue. Fix it by also
> quiesce queue in the beginning of __blk_mq_update_nr_hw_queues().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-mq.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d3494a796ba8..fb44ef0dff8a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4691,8 +4691,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>   		return;
>   
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_freeze_queue(q);
> +		blk_mq_quiesce_queue(q);
> +	}
>   	/*
>   	 * Switch IO scheduler to 'none', cleaning up the data associated
>   	 * with the previous scheduler. We will switch back once we are done
> @@ -4741,8 +4743,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
>   		blk_mq_elv_switch_back(&head, q);
>   
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		blk_mq_unquiesce_queue(q);
>   		blk_mq_unfreeze_queue(q);
> +	}
>   }
>   
>   void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> 

