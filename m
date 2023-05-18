Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEED7081A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjERMox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjERMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:44:50 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA2170E;
        Thu, 18 May 2023 05:44:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QMV6f3Qv6z4f41S5;
        Thu, 18 May 2023 20:44:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7O6HWZkrarPJg--.29868S3;
        Thu, 18 May 2023 20:44:43 +0800 (CST)
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Pradeep P V K <quic_pragalla@quicinc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
 <a29dcfa5-bb6a-d3b9-9fb7-cce87a8f8620@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4648819c-2115-a981-1b74-0495b94d4233@huaweicloud.com>
Date:   Thu, 18 May 2023 20:44:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a29dcfa5-bb6a-d3b9-9fb7-cce87a8f8620@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7O6HWZkrarPJg--.29868S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43tFWkWrykZrWxXF1DZFb_yoW5Xr4Upr
        nYqrs8Ary8Jr18Wr4DJw1DuryxZ3WUKw4jyr1rJFs5Jr9rXrnIq3WUZrnY9F1rXF4xJrZ8
        Jr4UJ395Zr4UArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/18 20:16, Yu Kuai 写道:

> @@ -173,18 +171,17 @@ void ioc_clear_queue(struct request_queue *q)
>   {
>          LIST_HEAD(icq_list);
> 
> +       rcu_read_lock();

Sorry that I realized this is still not enough, following list_empty()
and list_entry() can still concurrent with list_del(). Please try the
following patch:
>          spin_lock_irq(&q->queue_lock);
>          list_splice_init(&q->icq_list, &icq_list);
>          spin_unlock_irq(&q->queue_lock);
> 
> -       rcu_read_lock();
>          while (!list_empty(&icq_list)) {
>                  struct io_cq *icq =
>                          list_entry(icq_list.next, struct io_cq, q_node);
> 
>                  spin_lock_irq(&icq->ioc->lock);
> -               if (!(icq->flags & ICQ_DESTROYED))
> -                       ioc_destroy_icq(icq);
> +               ioc_destroy_icq(icq);
>                  spin_unlock_irq(&icq->ioc->lock);
>          }
>          rcu_read_unlock();
> 
> .
> 

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 63fc02042408..47684d1e9006 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -78,6 +78,9 @@ static void ioc_destroy_icq(struct io_cq *icq)

         lockdep_assert_held(&ioc->lock);

+       if (icq->flags & ICQ_DESTROYED)
+               return;
+
         radix_tree_delete(&ioc->icq_tree, icq->q->id);
         hlist_del_init(&icq->ioc_node);
         list_del_init(&icq->q_node);
@@ -128,12 +131,7 @@ static void ioc_release_fn(struct work_struct *work)
                         spin_lock(&q->queue_lock);
                         spin_lock(&ioc->lock);

-                       /*
-                        * The icq may have been destroyed when the ioc lock
-                        * was released.
-                        */
-                       if (!(icq->flags & ICQ_DESTROYED))
-                               ioc_destroy_icq(icq);
+                       ioc_destroy_icq(icq);

                         spin_unlock(&q->queue_lock);
                         rcu_read_unlock();
@@ -175,19 +173,16 @@ void ioc_clear_queue(struct request_queue *q)

         spin_lock_irq(&q->queue_lock);
         list_splice_init(&q->icq_list, &icq_list);
-       spin_unlock_irq(&q->queue_lock);

-       rcu_read_lock();
         while (!list_empty(&icq_list)) {
                 struct io_cq *icq =
                         list_entry(icq_list.next, struct io_cq, q_node);

                 spin_lock_irq(&icq->ioc->lock);
-               if (!(icq->flags & ICQ_DESTROYED))
-                       ioc_destroy_icq(icq);
+               ioc_destroy_icq(icq);
                 spin_unlock_irq(&icq->ioc->lock);
         }
-       rcu_read_unlock();
+       spin_unlock_irq(&q->queue_lock);
  }
  #else /* CONFIG_BLK_ICQ */
  static inline void ioc_exit_icqs(struct io_context *ioc)

