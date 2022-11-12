Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D662686A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiKLJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLJTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:19:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBDB7CC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:19:53 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8VQH0cjLz15M79;
        Sat, 12 Nov 2022 17:19:35 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:19:51 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:19:50 +0800
Subject: Re: [PATCH] genirq/irqdesc: hide illegible sysfs warning of
 kobject_del()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221112093939.616270-1-liushixin2@huawei.com>
 <Y29gXLqK2wiu7/WK@kroah.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <137bd5cc-0be9-6228-82e2-a75b53e5a2ae@huawei.com>
Date:   Sat, 12 Nov 2022 17:19:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y29gXLqK2wiu7/WK@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/12 16:59, Greg Kroah-Hartman wrote:
> On Sat, Nov 12, 2022 at 05:39:39PM +0800, Liu Shixin wrote:
>> If irq_sysfs_add() failed, system will report a warning but don't call
>> kobject_put() to release the descriptor.
> I can not parse this sentance :(
irq_sysfs_add() call kobject_add(). If kobject_add() failed, will print "Failed to add kobject for irq".
But not call kobject_put().
>
>> Then in irq_sysfs_del(), we continue to call kobject_del(). In such
>> situation, kobject_del() will complains about a object with no parent
>> like this:
> Then we should not be calling irq_sysfs_del() if the call failed.  That
> is the real fix here.
If so, should I add a variable to record whether kobject has alreadly added or not?
>>  kernfs: can not remove 'actions', no directory
>>  WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
>> [...]
>>  Call Trace:
>>   <TASK>
>>   remove_files.isra.0+0x3f/0xb0
>>   sysfs_remove_group+0x68/0xe0
>>   sysfs_remove_groups+0x41/0x70
>>   __kobject_del+0x45/0xc0
>>   kobject_del+0x2a/0x40
>>   free_desc+0x44/0x70
>>   irq_free_descs+0x5d/0x90
>> [...]
>>
>> Use kobj->state_in_sysfs to check whether kobject is added succeed. And
>> if not, we should not call kobject_del().
> That does not describe what you are doing here at all.
Sorry, I forget to update...
>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  kernel/irq/irqdesc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index a91f9001103c..a820d96210d4 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -300,10 +300,11 @@ static void irq_sysfs_del(struct irq_desc *desc)
>>  	/*
>>  	 * If irq_sysfs_init() has not yet been invoked (early boot), then
>>  	 * irq_kobj_base is NULL and the descriptor was never added.
>> +	 * And the descriptor may be added failed.
>>  	 * kobject_del() complains about a object with no parent, so make
>>  	 * it conditional.
>>  	 */
>> -	if (irq_kobj_base)
>> +	if (irq_kobj_base && desc->kobj.parent)
> How would the parent be NULL?  Parent devices always stick around until
> the child is removed, otherwise something is really wrong here.  You
> should never have to look at the parent.
irq_sysfs_add() call kobject_add(). If kobject_add() failed, the parent will be NULL.
You can find the same check of kobj->parent in cpuid_cpu_offline().

thanks,

Liu Shixin
.
>
> thanks,
>
> greg k-h
> .
>

