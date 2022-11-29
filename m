Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB063B8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiK2Dit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiK2Dir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:38:47 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEF831FBE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:38:45 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLp2P4FqVz15MsR;
        Tue, 29 Nov 2022 11:38:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 11:38:43 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 11:38:42 +0800
Subject: Re: [PATCH v2] genirq/irqdesc: fix WARNING in irq_sysfs_del()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <tglx@linutronix.de>, <kraig@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20221128151612.1786122-1-yangyingliang@huawei.com>
 <Y4Tt2NIcPFeoss4s@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <7fe216b0-0e5e-adef-075b-067c90e93020@huawei.com>
Date:   Tue, 29 Nov 2022 11:38:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y4Tt2NIcPFeoss4s@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/29 1:20, Greg KH wrote:
> On Mon, Nov 28, 2022 at 11:16:12PM +0800, Yang Yingliang wrote:
>> I got the lots of WARNING report when doing fault injection test:
>>
>> kernfs: can not remove 'chip_name', no directory
>> WARNING: CPU: 0 PID: 253 at fs/kernfs/dir.c:1616 kernfs_remove_by_name_ns+0xce/0xe0
>> RIP: 0010:kernfs_remove_by_name_ns+0xce/0xe0
>> Call Trace:
>>   <TASK>
>>   remove_files.isra.1+0x3f/0xb0
>>   sysfs_remove_group+0x68/0xe0
>>   sysfs_remove_groups+0x41/0x70
>>   __kobject_del+0x45/0xc0
>>   kobject_del+0x29/0x40
>>   free_desc+0x42/0x70
>>   irq_free_descs+0x5e/0x90
>>
>> kernfs: can not remove 'hwirq', no directory
>> WARNING: CPU: 0 PID: 253 at fs/kernfs/dir.c:1616 kernfs_remove_by_name_ns+0xce/0xe0
>> RIP: 0010:kernfs_remove_by_name_ns+0xce/0xe0
>> Call Trace:
>>   <TASK>
>>   remove_files.isra.1+0x3f/0xb0
>>   sysfs_remove_group+0x68/0xe0
>>   sysfs_remove_groups+0x41/0x70
>>   __kobject_del+0x45/0xc0
>>   kobject_del+0x29/0x40
>>   free_desc+0x42/0x70
>>   irq_free_descs+0x5e/0x90
>>
>> If irq_sysfs_add() fails in alloc_descs(), the directory of interrupt
>> informations is not added to sysfs, it causes the WARNINGs when removing
>> the information files. Add 'sysfs_added' field in struct irq_desc to
>> indicate if it is added, and check it before calling kobject_del() to
>> avoid these WARNINGs.
>>
>> Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v1 -> v2:
>>    Don't use state_in_sysfs, introduce 'sysfs_added' to indicate if it is added.
>> ---
>>   include/linux/irqdesc.h | 1 +
>>   kernel/irq/irqdesc.c    | 7 +++++--
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index 844a8e30e6de..fec0f3946a34 100644
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -97,6 +97,7 @@ struct irq_desc {
>>   #ifdef CONFIG_SPARSE_IRQ
>>   	struct rcu_head		rcu;
>>   	struct kobject		kobj;
>> +	bool			sysfs_added;
>>   #endif
>>   	struct mutex		request_mutex;
>>   	int			parent_irq;
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index a91f9001103c..9bf74d11bad5 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -292,6 +292,8 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
>>   		 */
>>   		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
>>   			pr_warn("Failed to add kobject for irq %d\n", irq);
>> +		else
>> +			desc->sysfs_added = true;
> Wait, no.  Why are you just not properly failing and unwinding here?
We can not call kobject_put() here, it will free the 'desc' in 
irq_kobj_release(),
the irq is still in use and the 'desc' should be freed in free_desc(), 
so the failure
handled in irq_sysfs_del().

If irq_sysfs_add() fails, it does nothing except print message,
we don't know if it's added successfully while calling irq_sysfs_del(),
so I introduced a filed to store the return status that can be used in
irq_sysfs_add().

alloc_descs()
   irq_sysfs_add(desc) <-- it's failed and does nothing except print message

irq_free_descs()
   free_desc()
     irq_sysfs_del(desc) <-- it doesn't know irq_sysfs_add() is failed.
     delayed_free_desc()
       kfree(desc)

I this case, If dont' use a flag, I can not figure out a better way to
let irq_sysfs_del() know it's added failed.

Thanks,
Yang
> Why do you need a special flag just to say "sysfs worked" or not unlike
> all other users of kobjects.
>
> Fix this up properly please.
>
> thanks,
>
> greg k-h
> .
