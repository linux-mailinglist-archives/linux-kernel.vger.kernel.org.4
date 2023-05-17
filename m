Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA617063FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjEQJU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjEQJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA2C4C07;
        Wed, 17 May 2023 02:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0555D63B0B;
        Wed, 17 May 2023 09:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67D1C433D2;
        Wed, 17 May 2023 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684315221;
        bh=lpHBQAQ+iCtxDN9YHpVPU+9RWLux9n18G0+RciPK0L0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AS1staIfbe5/RTIbC0XlaRLquWylxZF7WXGPq0hjNJrlYDhpR89VBMersU87hxm/C
         ebH/DYQCIG2eexzhuO8Q3RZhkZvxQXqd3j7rRDjWZ1GGzGgw5uo7fo0G92Kc1xRG9H
         RB3LaPtMmIkinA5lnTHswBHBXYpFuwCTKedIIjnz6TbGEVA5LhrIz228o4uPYtQwrR
         dTYVFBdhPi4jt6iUYwZc/+ZXEjh4pheKgBHO/M/mrbYWwCOehjTiCq2dlEvry6/m8n
         6yJjCcQDytis3mo7zj5ZhC5HeXziDQ6SfkDQqR8sgI638za6SqI5vwTtTq4YBZEnUc
         nQKIT2JSbTGWw==
Message-ID: <a2f86cd7-776c-d7ed-8815-62683a14ba36@kernel.org>
Date:   Wed, 17 May 2023 18:20:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Pradeep P V K <quic_pragalla@quicinc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 17:58, Yu Kuai wrote:
> Hi,
> 
> 在 2023/05/17 16:44, Pradeep P V K 写道:
>> There is a potential race between ioc_clear_fn() and
>> exit_io_context() as shown below, due to which below
>> crash is observed. It can also result into use-after-free
>> issue.
>>
>> context#1:                           context#2:
>> ioc_release_fn()                     do_exit();
>> ->spin_lock(&ioc->lock);             ->exit_io_context();
>> ->ioc_destroy_icq(icq);              ->ioc_exit_icqs();
>>   ->list_del_init(&icq->q_node);       ->spin_lock_irq(&ioc->lock);
>>   ->call_rcu(&icq->__rcu_head,
>>       icq_free_icq_rcu);
>> ->spin_unlock(&ioc->lock);
>>                                        ->ioc_exit_icq(); gets the same icq
> I don't understand how is this possible, the list is protected by
> 'ioc->lock', both hlist_del_init and hlist_for_each_entry are called
> inside the lock.

Given that ioc_destroy_icq() calls ioc_exit_icq(), ioc_exit_icqs() should ignore
all icqs that have been destroyed already, otherwise, ioc_exit_icq() gets called
twice for the same icq. The missing rcu lock in ioc_exit_icqs() already was in
itself a bug, and the missing flag check is another.

> 
> Thanks,
> Kuai
>> 				       ->bfq_exit_icq();
>>                                    This results into below crash as bic
>> 				  is NULL as it is derived from icq.
>> 				  There is a chance that icq could be
>> 				  free'd as well.
>>
>> [33.245722][ T8666] Unable to handle kernel NULL pointer dereference
>> at virtual address 0000000000000018.
>> ...
>> Call trace:
>> [33.325782][ T8666]  bfq_exit_icq+0x28/0xa8
>> [33.325785][ T8666]  exit_io_context+0xcc/0x100
>> [33.325786][ T8666]  do_exit+0x764/0xa58
>> [33.325791][ T8666]  do_group_exit+0x0/0xa0
>> [33.325793][ T8666]  invoke_syscall+0x48/0x114
>> [33.325802][ T8666]  el0_svc_common+0xcc/0x118
>> [33.325805][ T8666]  do_el0_svc+0x34/0xd0
>> [33.325807][ T8666]  el0_svc+0x38/0xd0
>> [33.325812][ T8666]  el0t_64_sync_handler+0x8c/0xfc
>> [33.325813][ T8666]  el0t_64_sync+0x1a0/0x1a4
>>
>> Fix this by checking with ICQ_DESTROYED flags in ioc_exit_icqs().
>> Also, ensure ioc_exit_icq() is accessing icq within rcu_read_lock/unlock
>> so that icq doesn't get free'd up while it is still using it.
>>
>> Signed-off-by: Pradeep P V K <quic_pragalla@quicinc.com>

Pradeep, this needs a Fixes tag and cc-stable I think.

>> ---
>>   block/blk-ioc.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>> index 63fc02042408..1aa34fd46ac8 100644
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -60,10 +60,14 @@ static void ioc_exit_icqs(struct io_context *ioc)
>>   {
>>   	struct io_cq *icq;
>>   
>> +	rcu_read_lock();
>>   	spin_lock_irq(&ioc->lock);
>> -	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node)
>> -		ioc_exit_icq(icq);
>> +	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
>> +		if (!(icq->flags & ICQ_DESTROYED))
>> +			ioc_exit_icq(icq);
>> +	}
>>   	spin_unlock_irq(&ioc->lock);
>> +	rcu_read_unlock();
>>   }
>>   
>>   /*
>>
> 

-- 
Damien Le Moal
Western Digital Research

