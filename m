Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241171538A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjE3CT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE3CTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:19:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553DDB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:19:53 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QVb7F0CGsz18Lkn;
        Tue, 30 May 2023 09:54:49 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 09:59:25 +0800
Message-ID: <56c6dc9a-a5a6-368a-abd4-cace43ceaec0@huawei.com>
Date:   Tue, 30 May 2023 09:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/3] genirq: Use hlist for managing resend handlers
To:     Thomas Gleixner <tglx@linutronix.de>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
 <20230519134902.1495562-2-sdonthineni@nvidia.com>
 <6dc6642a-1e7c-f111-1fa2-be54826ecef6@huawei.com> <871qiylsc9.ffs@tglx>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <871qiylsc9.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas

在 2023/5/30 5:51, Thomas Gleixner 写道:
> On Mon, May 29 2023 at 15:57, Chang Liao wrote:
>> 在 2023/5/19 21:49, Shanker Donthineni 写道:
>>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>>> index 844a8e30e6de..d9451d456a73 100644
>>> --- a/include/linux/irqdesc.h
>>> +++ b/include/linux/irqdesc.h
>>> @@ -102,6 +102,9 @@ struct irq_desc {
>>>  	int			parent_irq;
>>>  	struct module		*owner;
>>>  	const char		*name;
>>> +#ifdef CONFIG_HARDIRQS_SW_RESEND
>>> +	struct hlist_node	resend_node;
>>> +#endif
>>>  } ____cacheline_internodealigned_in_smp;
>>
>> Although there is no documented rule that limits the change of the KABI
>> struct irq_desc, it is still better to keep the irq_desc definition
>> stable.
> 
> Please read and understand:
> 
>        Documentation/process/stable-api-nonsense.rst
> 
> If you want KABI, then that's  _YOUR_ problem, period.

Thanks for the guide.

> 
>>> -/* Bitmap to handle software resend of interrupts: */
>>> -static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>>> +/* hlist_head to handle software resend of interrupts: */
>>> +static HLIST_HEAD(irq_resend_list);
>>> +static DEFINE_RAW_SPINLOCK(irq_resend_lock);
>>
>> What is the benefit of using hlist here? If you want to enjoy the
>> low latency of querying elements by key, you must define a hlist table
>> with a reasonable number of buckets. Otherwise, I don't think the time
>> complexity of hlist is better than a regular double-linked list,
>> right?
> 
> What's complex about hlist in this case? Please explain.

Honestly, it is not about the complexity. Perhaps I do not understand the
usage of hlist very deeply. I have searched some codes in the kernel and
found that hlist is always used to speed up arbitrary querying, such as
searching a registered kprobe by address. Back to this patch, these resend
IRQs are organized in a sequence list actually, and traveled one by one to
handle. Further, by comparing the difference between hlist_empty, hlist_add_head,
hlist_del_init, and their counterparts in list, it looks like a regular linked
list is also good enough.

Thanks.

> 
> Thanks,
> 
>         tglx

-- 
BR
Liao, Chang
