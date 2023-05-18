Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19EE708105
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjERMQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjERMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:16:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1661BD;
        Thu, 18 May 2023 05:16:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QMTVR4wjvz4f3kpD;
        Thu, 18 May 2023 20:16:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3mAYvF2Zk__y3Iw--.49396S3;
        Thu, 18 May 2023 20:16:48 +0800 (CST)
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Pradeep P V K <quic_pragalla@quicinc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a29dcfa5-bb6a-d3b9-9fb7-cce87a8f8620@huaweicloud.com>
Date:   Thu, 18 May 2023 20:16:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3mAYvF2Zk__y3Iw--.49396S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1rJF43WFW8GF48ArWkWFg_yoW7AryDpr
        1kXr98CryUJryIkr4UJw1qvry8GF1UKw1UJryrGay8Ar17ArnFqF1UZr1Ygry5Xr4xAr4j
        qr18G390vr1UC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
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

在 2023/05/17 16:58, Yu Kuai 写道:
> Hi,
> 
> 在 2023/05/17 16:44, Pradeep P V K 写道:
>> There is a potential race between ioc_clear_fn() and
>> exit_io_context() as shown below, due to which below
>> crash is observed. It can also result into use-after-free
>> issue.
>>
>> context#1:                           context#2:
>> ioc_release_fn()                     do_exit();
>> ->spin_lock(&ioc->lock);             ->exit_io_context();
>> ->ioc_destroy_icq(icq);              ->ioc_exit_icqs();
>>   ->list_del_init(&icq->q_node);       ->spin_lock_irq(&ioc->lock);
>>   ->call_rcu(&icq->__rcu_head,
>>       icq_free_icq_rcu);
>> ->spin_unlock(&ioc->lock);

I think above concurrent scenario is not possible as well.

exit_io_context() doesn't release ioc refcount before ioc_exit_icqs() is
done, so that ioc_release_fn() can never concurrent with
ioc_exit_icqs().

do_exit
  exit_io_context
   ioc_exit_icqs
   put_io_context -> ioc_release_fn won't be called before this

>>                                        ->ioc_exit_icq(); gets the same 
>> icq
> I don't understand how is this possible, the list is protected by
> 'ioc->lock', both hlist_del_init and hlist_for_each_entry are called
> inside the lock.
> 
> Thanks,
> Kuai
>>                        ->bfq_exit_icq();
>>                                    This results into below crash as bic
>>                   is NULL as it is derived from icq.
>>                   There is a chance that icq could be
>>                   free'd as well.
>>
>> [33.245722][ T8666] Unable to handle kernel NULL pointer dereference
>> at virtual address 0000000000000018.
>> ...
>> Call trace:
>> [33.325782][ T8666]  bfq_exit_icq+0x28/0xa8
>> [33.325785][ T8666]  exit_io_context+0xcc/0x100
>> [33.325786][ T8666]  do_exit+0x764/0xa58
>> [33.325791][ T8666]  do_group_exit+0x0/0xa0
>> [33.325793][ T8666]  invoke_syscall+0x48/0x114
>> [33.325802][ T8666]  el0_svc_common+0xcc/0x118
>> [33.325805][ T8666]  do_el0_svc+0x34/0xd0
>> [33.325807][ T8666]  el0_svc+0x38/0xd0
>> [33.325812][ T8666]  el0t_64_sync_handler+0x8c/0xfc
>> [33.325813][ T8666]  el0t_64_sync+0x1a0/0x1a4
>>
>> Fix this by checking with ICQ_DESTROYED flags in ioc_exit_icqs().
>> Also, ensure ioc_exit_icq() is accessing icq within rcu_read_lock/unlock
>> so that icq doesn't get free'd up while it is still using it.
>>
>> Signed-off-by: Pradeep P V K <quic_pragalla@quicinc.com>
>> ---
>>   block/blk-ioc.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>> index 63fc02042408..1aa34fd46ac8 100644
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -60,10 +60,14 @@ static void ioc_exit_icqs(struct io_context *ioc)
>>   {
>>       struct io_cq *icq;
>> +    rcu_read_lock();
>>       spin_lock_irq(&ioc->lock);
>> -    hlist_for_each_entry(icq, &ioc->icq_list, ioc_node)
>> -        ioc_exit_icq(icq);
>> +    hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
>> +        if (!(icq->flags & ICQ_DESTROYED))
By the way, above change doesn't make sense to me as well.
ioc_exit_icq() is called before setting ICQ_DESTROYED, hence if
ICQ_DESTROYED is set, then ICQ_EXITED is set as well, in this case
ioc_exit_icq() won't do anything.

>> +            ioc_exit_icq(icq);
>> +    }
>>       spin_unlock_irq(&ioc->lock);
>> +    rcu_read_unlock();
>>   }
>>   /*

I think I do found a problem, but I'm not sure it's the same in your
case, can you try the following patch?

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 63fc02042408..37a56f2bb040 100644
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
@@ -173,18 +171,17 @@ void ioc_clear_queue(struct request_queue *q)
  {
         LIST_HEAD(icq_list);

+       rcu_read_lock();
         spin_lock_irq(&q->queue_lock);
         list_splice_init(&q->icq_list, &icq_list);
         spin_unlock_irq(&q->queue_lock);

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
         rcu_read_unlock();

