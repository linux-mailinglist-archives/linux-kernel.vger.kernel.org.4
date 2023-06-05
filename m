Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7672271E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjFENOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjFENO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:14:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125F113;
        Mon,  5 Jun 2023 06:14:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZYYs4Xkyz4f3kkC;
        Mon,  5 Jun 2023 20:58:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLPd231kQXP9Kw--.46378S3;
        Mon, 05 Jun 2023 20:58:07 +0800 (CST)
Subject: Re: [PATCH] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, dlemoal@kernel.org,
        quic_pragalla@quicinc.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <03ffbdc4-66e2-5508-f632-e3a1999f40df@huaweicloud.com>
Date:   Mon, 5 Jun 2023 20:58:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLPd231kQXP9Kw--.46378S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xAw48uFWfWrWkZr17Awb_yoW5uF43pr
        yrWa9xC3y8Xr4xWr4DWa1293s3ua1Fgr4qyr1fGrZ5Ar9FvrnIg3W8AryFqFn5XFs7ArZ8
        Zr4UK395Cr4UCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens

ÔÚ 2023/05/31 15:34, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, icq is tracked by both request_queue(icq->q_node) and
> task(icq->ioc_node), and ioc_clear_queue() from elevator exit is not
> safe because it can access the list without protection:
> 
> ioc_clear_queue			ioc_release_fn
>   lock queue_lock
>   list_splice
>   /* move queue list to a local list */
>   unlock queue_lock
>   /*
>    * lock is released, the local list
>    * can be accessed through task exit.
>    */
> 
> 				lock ioc->lock
> 				while (!hlist_empty)
> 				 icq = hlist_entry
> 				 lock queue_lock
> 				  ioc_destroy_icq
> 				   delete icq->ioc_node
>   while (!list_empty)
>    icq = list_entry()		   list_del icq->q_node
>    /*
>     * This is not protected by any lock,
>     * list_entry concurrent with list_del
>     * is not safe.
>     */
> 
> 				 unlock queue_lock
> 				unlock ioc->lock
> 
> Fix this problem by protecting list 'icq->q_node' by queue_lock from
> ioc_clear_queue().
> 
> Reported-and-tested-by: Pradeep Pragallapati <quic_pragalla@quicinc.com>
> Link: https://lore.kernel.org/lkml/20230517084434.18932-1-quic_pragalla@quicinc.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-ioc.c | 30 +++++++++++++-----------------
>   1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 63fc02042408..d5db92e62c43 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -77,6 +77,10 @@ static void ioc_destroy_icq(struct io_cq *icq)
>   	struct elevator_type *et = q->elevator->type;
>   
>   	lockdep_assert_held(&ioc->lock);
> +	lockdep_assert_held(&q->queue_lock);
> +
> +	if (icq->flags & ICQ_DESTROYED)
> +		return;
>   
>   	radix_tree_delete(&ioc->icq_tree, icq->q->id);
>   	hlist_del_init(&icq->ioc_node);
> @@ -128,12 +132,7 @@ static void ioc_release_fn(struct work_struct *work)
>   			spin_lock(&q->queue_lock);
>   			spin_lock(&ioc->lock);
>   
> -			/*
> -			 * The icq may have been destroyed when the ioc lock
> -			 * was released.
> -			 */
> -			if (!(icq->flags & ICQ_DESTROYED))
> -				ioc_destroy_icq(icq);
> +			ioc_destroy_icq(icq);
>   
>   			spin_unlock(&q->queue_lock);
>   			rcu_read_unlock();
> @@ -171,23 +170,20 @@ static bool ioc_delay_free(struct io_context *ioc)
>    */
>   void ioc_clear_queue(struct request_queue *q)
>   {
> -	LIST_HEAD(icq_list);
> -
>   	spin_lock_irq(&q->queue_lock);
> -	list_splice_init(&q->icq_list, &icq_list);
> -	spin_unlock_irq(&q->queue_lock);
> -
> -	rcu_read_lock();
> -	while (!list_empty(&icq_list)) {
> +	while (!list_empty(&q->icq_list)) {
>   		struct io_cq *icq =
> -			list_entry(icq_list.next, struct io_cq, q_node);
> +			list_first_entry(&q->icq_list, struct io_cq, q_node);
>   
> +		/*
> +		 * Other context won't hold ioc lock to wait for queue_lock, see
> +		 * details in ioc_release_fn().
> +		 */
>   		spin_lock_irq(&icq->ioc->lock);

Sorry that I made a mistake here to use spin_lock_irq() for recursive
locking.

Should I resend this patch or send a new fix patch?

Sincerely apologize for this trouble.

Thanks,
Kuai
> -		if (!(icq->flags & ICQ_DESTROYED))
> -			ioc_destroy_icq(icq);
> +		ioc_destroy_icq(icq);
>   		spin_unlock_irq(&icq->ioc->lock);
>   	}
> -	rcu_read_unlock();
> +	spin_unlock_irq(&q->queue_lock);
>   }
>   #else /* CONFIG_BLK_ICQ */
>   static inline void ioc_exit_icqs(struct io_context *ioc)
> 

