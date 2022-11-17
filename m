Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61F462D3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiKQHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiKQHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:04:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9D62386;
        Wed, 16 Nov 2022 23:04:09 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NCW616XcxzJnpN;
        Thu, 17 Nov 2022 15:00:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:04:07 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:04:07 +0800
Subject: Re: [PATCH] rcu: Make vmalloc_dump_obj() call in a preemptible
 context
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221116141511.3695680-1-qiang1.zhang@intel.com>
 <bbcb265f-0731-47c7-3a04-976504b95915@huawei.com>
 <PH0PR11MB5880515EC312E9BA1FCF6A28DA069@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e9404e66-19ca-37c1-1f75-2d729b8af831@huawei.com>
Date:   Thu, 17 Nov 2022 15:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB5880515EC312E9BA1FCF6A28DA069@PH0PR11MB5880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/17 13:20, Zhang, Qiang1 wrote:
> 
> 
> On 2022/11/16 22:15, Zqiang wrote:
>> Currently, the mem_dump_obj() is invoked in call_rcu(), the
>>
>> Plan to call mem_dump_obj() in rcu_do_batch().
>>
>> call_rcu() is maybe invoked in non-preemptive code segment,
>> for object allocated from vmalloc(), the following scenarios
>> may occur:
>>
>> 	CPU 0
>> tasks context
>>    spin_lock(&vmap_area_lock)
>>           Interrupt context
>> 	      call_rcu()
>> 		mem_dump_obj
>>                   vmalloc_dump_obj
>>                     spin_lock(&vmap_area_lock) <--deadlock
>>
>> and for PREEMPT-RT kernel, the spinlock will convert to sleepable
>> lock, it also make vmap_area_lock spinlock can not acquire in
>> non-preemptive code segment. therefore, this commit make the
>> vmalloc_dump_obj() call in a preemptible context.
>>
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>> ---
>>  mm/util.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 12984e76767e..465f8b8824ca 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -1124,8 +1124,12 @@ void mem_dump_obj(void *object)
>>  		return;
>>  	}
>>  
>> -	if (vmalloc_dump_obj(object))
>> -		return;
>> +	if (is_vmalloc_addr(object)) {
>> +		if (preemptible() && vmalloc_dump_obj(object))
>>
>> preemptible() --> !in_interrupt()?
> 
> Hi Leizhen 
> 
> !in_interrupt()  not include following scenario:
> 
> task context:
> 
> local_irq_save() or preempt_disable();
> call_rcu()
>       mem_dump_obj()
> 	vmalloc_dump_obj()
> 		spin_lock(&vmap_area_lock)
> local_irq_restore() or preempt_denable();
> 
> for PREEMPT-RT kernel, spinlock will convert to sleepable lock.

OK.

> 
>>
>> +			return;
>> +		type = "vmalloc memory";
>> +		goto end;
>> +	}
>>
>> Move into vmalloc_dump_obj()?
> 
> you mean move preemptible() into vmalloc_dump_obj()?

Move all? Currently, vmalloc_dump_obj() is invoked only by
mem_dump_obj(). The encapsulation is a little better in my opinion.

> 
> Thanks
> Zqiang
> 
>>
>>  
>>  	if (virt_addr_valid(object))
>>  		type = "non-slab/vmalloc memory";
>> @@ -1135,7 +1139,7 @@ void mem_dump_obj(void *object)
>>  		type = "zero-size pointer";
>>  	else
>>  		type = "non-paged memory";
>> -
>> +end:
>>  	pr_cont(" %s\n", type);
>>  }
>>  EXPORT_SYMBOL_GPL(mem_dump_obj);
>>
> 

-- 
Regards,
  Zhen Lei
