Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC56706369
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjEQI6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjEQI6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:58:22 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B78421E;
        Wed, 17 May 2023 01:58:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QLn7m04wQz4f3p19;
        Wed, 17 May 2023 16:58:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LMjl2RkdWB+Jg--.10715S3;
        Wed, 17 May 2023 16:58:13 +0800 (CST)
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
To:     Pradeep P V K <quic_pragalla@quicinc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
Date:   Wed, 17 May 2023 16:58:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230517084434.18932-1-quic_pragalla@quicinc.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LMjl2RkdWB+Jg--.10715S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar48Cr4rWrW7uw43KF1Utrb_yoW5JFykpr
        4DXFZ0kr48JryIvanrtayv9F18X3WqgF17C393G3yfGr9xZr9xtF4DCr1aqF90qrs7CrWj
        gayrG390kr1DC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/17 16:44, Pradeep P V K Ð´µÀ:
> There is a potential race between ioc_clear_fn() and
> exit_io_context() as shown below, due to which below
> crash is observed. It can also result into use-after-free
> issue.
> 
> context#1:                           context#2:
> ioc_release_fn()                     do_exit();
> ->spin_lock(&ioc->lock);             ->exit_io_context();
> ->ioc_destroy_icq(icq);              ->ioc_exit_icqs();
>   ->list_del_init(&icq->q_node);       ->spin_lock_irq(&ioc->lock);
>   ->call_rcu(&icq->__rcu_head,
>       icq_free_icq_rcu);
> ->spin_unlock(&ioc->lock);
>                                        ->ioc_exit_icq(); gets the same icq
I don't understand how is this possible, the list is protected by
'ioc->lock', both hlist_del_init and hlist_for_each_entry are called
inside the lock.

Thanks,
Kuai
> 				       ->bfq_exit_icq();
>                                    This results into below crash as bic
> 				  is NULL as it is derived from icq.
> 				  There is a chance that icq could be
> 				  free'd as well.
> 
> [33.245722][ T8666] Unable to handle kernel NULL pointer dereference
> at virtual address 0000000000000018.
> ...
> Call trace:
> [33.325782][ T8666]  bfq_exit_icq+0x28/0xa8
> [33.325785][ T8666]  exit_io_context+0xcc/0x100
> [33.325786][ T8666]  do_exit+0x764/0xa58
> [33.325791][ T8666]  do_group_exit+0x0/0xa0
> [33.325793][ T8666]  invoke_syscall+0x48/0x114
> [33.325802][ T8666]  el0_svc_common+0xcc/0x118
> [33.325805][ T8666]  do_el0_svc+0x34/0xd0
> [33.325807][ T8666]  el0_svc+0x38/0xd0
> [33.325812][ T8666]  el0t_64_sync_handler+0x8c/0xfc
> [33.325813][ T8666]  el0t_64_sync+0x1a0/0x1a4
> 
> Fix this by checking with ICQ_DESTROYED flags in ioc_exit_icqs().
> Also, ensure ioc_exit_icq() is accessing icq within rcu_read_lock/unlock
> so that icq doesn't get free'd up while it is still using it.
> 
> Signed-off-by: Pradeep P V K <quic_pragalla@quicinc.com>
> ---
>   block/blk-ioc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 63fc02042408..1aa34fd46ac8 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -60,10 +60,14 @@ static void ioc_exit_icqs(struct io_context *ioc)
>   {
>   	struct io_cq *icq;
>   
> +	rcu_read_lock();
>   	spin_lock_irq(&ioc->lock);
> -	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node)
> -		ioc_exit_icq(icq);
> +	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
> +		if (!(icq->flags & ICQ_DESTROYED))
> +			ioc_exit_icq(icq);
> +	}
>   	spin_unlock_irq(&ioc->lock);
> +	rcu_read_unlock();
>   }
>   
>   /*
> 

