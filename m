Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC89646994
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLHHQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLHHQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:16:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E637231;
        Wed,  7 Dec 2022 23:16:51 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NSQRf23JQzmW8B;
        Thu,  8 Dec 2022 15:15:58 +0800 (CST)
Received: from [10.174.176.219] (10.174.176.219) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 15:16:47 +0800
Subject: Re: [RFC 1/2] ACPI: APEI: Make memory_failure() triggered by
 synchronization errors execute in the current context
To:     Shuai Xue <xueshuai@linux.alibaba.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>,
        <akpm@linux-foundation.org>, <ashish.kalra@amd.com>,
        <xiexiuqi@huawei.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        <yingwen.cyw@alibaba-inc.com>
References: <20221205115111.131568-1-lvying6@huawei.com>
 <20221205115111.131568-2-lvying6@huawei.com>
 <c779d666-4937-e2dc-2d52-da0e49d5d1ac@linux.alibaba.com>
 <e7d66b23-ce62-4a50-91c3-29aaa41d2e90@huawei.com>
 <5afef5fd-7e44-32ae-fa94-5fcf47d4b4df@linux.alibaba.com>
From:   Lv Ying <lvying6@huawei.com>
Message-ID: <a4ea2510-7602-f259-f8b9-07cd44c07808@huawei.com>
Date:   Thu, 8 Dec 2022 15:16:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5afef5fd-7e44-32ae-fa94-5fcf47d4b4df@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.219]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/8 11:25, Shuai Xue wrote:
> + Xie XiuQi
> 
> On 2022/12/8 AM10:20, Lv Ying wrote:
>>
>>>
>>> We also encountered this problem in production environment, and tried to
>>> solve it by dividing synchronous and asynchronous error handling into different
>>> paths: task work for synchronous error and workqueue for asynchronous error.
>>>
>>> The main challenge is how to distinguish synchronous errors in kernel first
>>> mode through APEI, a related discussion is here.[1]
>>>
>> Hi Shuai:
>>
>> I'm very happy to have received your response, we encountered this problem in our production environment too. I spent a lot of time researching the rationale for synchronous errors and asynchronous errors to share the same process. I mention in my patch commit message: memory_failure() triggered by synchronous error is
>> executed in the kworker context, the early_kill mode of memory_failure()
>> will send wrong si_code by SIGBUS signal because of wrong current process.
>>
>> The challenge for my patch is to prove the rationality of distinguishing synchronous errors. I do not have a good idea of distinguishing synchronous error by looking through ACPI/UEFI spec, so I sent this patchset for more input. And I resent RFC PATCH v1 [1]add this as TODO.
>>
>>>> @@ -978,14 +979,14 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>>>            estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>>>>            len = cper_estatus_len(estatus);
>>>>            node_len = GHES_ESTATUS_NODE_LEN(len);
>>>> -        task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
>>>> +        corruption_page_pending = ghes_do_proc(estatus_node->ghes, estatus, true);
>>>>            if (!ghes_estatus_cached(estatus)) {
>>>>                generic = estatus_node->generic;
>>>>                if (ghes_print_estatus(NULL, generic, estatus))
>>>>                    ghes_estatus_cache_add(generic, estatus);
>>>>            }
>>>
>>> In the case of your patch, it is inappropriate to assume that ghes_proc_in_irq() is only
>>> called to handle synchronous error. Firmware could notify all synchronous and asynchronous
>>> error signals to kernel through NMI notification, e.g. SDEI. In this case, asynchronous
>>> error will be treated as synchronous error.
>>>
>>
>> Yes, as I mentioned above, I do not have a good idea of distinguishing synchronous error. I agree with you that ghes_proc_in_irq() is called in SDEI, SEA, NMI notify type, they are NMI-like notify, this function run some job which may not be NMI safe in IRQ context. And NMI may be asynchronous error.
>>
>> However, cureent kernel use ghes_kick_task_work in ghes_proc_in_irq(), there is an assumption here that ghes_proc_in_irq() are currently in the context of a synchronous exception, although this is not appropriate.
>>
>>> Our colleague Yingwen has submitted a proposal to extend acpi_hest_generic_data::flag (bit 8)
>>> to indicate that the error is a synchronous[2]. Personally speaking, it is a more general
>>> solution and completely solves the problem.
>>>
>>>
>>>> Background:
>>>>
>>>> In ARM world, two type events (Sync/Async) from hardware IP need OS/VMM take different actions.
>>>> Current CPER memory error record is not able to distinguish sync/async type event right now.
>>>> Current OS/VMM need to take extra actions beyond CPER which is heavy burden to identify the
>>>> two type events
>>>>
>>>> Sync event (e.g. CPU consume poisoned data) --> Firmware  -> CPER error log  --> OS/VMM take recovery action.
>>>> Async event (e.g. Memory controller detect UE event)  --> Firmware  --> CPER error log  --> OS take page action.
>>>>
>>>>
>>>> Proposal:
>>>>
>>>> - In section description Flags field(UEFI spec section N.2, add sync flag as below. OS/VMM
>>>>    could depend on this flag to distinguish sync/async events.
>>>> - Bit8 – sync flag; if set this flag indicates that this event record is synchronous(e.g.
>>>>    cpu core consumes poison data, then cause instruction/data abort); if not set, this event record is asynchronous.
>>>>
>>>> Best regards,
>>>> Yingwen Chen
>>>
>>> A RFC patch set based on above proposal is here[3].
>>>
>>
>> I'm glad your team is working on advancing this thing in the UEFI community. This will make kernel identify synchronous as an easy job. Based on your proposal, I think your work is suitable.
>>
>> However, there are real problems here in the running production environment of the LTS kernel:
>> 1. this new proposal has not yet been accepted by the UEFI spec
>> 2. it will require firmware update in production environment which may be more difficult than kernel livepatch upgrade.
>>
>> If there are more ways to distinguish synchronous error in kernel APEI,
>> I can try it. For example, in APEI mode, is it suitable to use notify type to distinguish synchronous error?
>> synchronous error:
>> SDEI SEA
>> asynchronous error:
>> NMI
> 
> Sorry, I'm afraid it's not suitable. It is no doubt that SEA notification is synchronous,
> but we should not assume that platform use NMI notification for asynchronous errors,
> and SDEI notification for synchronous errors.
> 
> If we want to address the problem now, I prefer to just consider SEA notification is synchronous
> and add MF_ACTION_REQUIRED when SEA is adopt. Please refer to XiuQi's work.[1]
> 
> [1]https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/
> 
> Best Regards,
> Shuai
> 
Thanks for your advice, it may be currently more practical to solve the 
problem that synchronous and asynchronous errors
share the same processing flow only in the SEA scenario. I will refer to 
XiuQi's work and update RFC PATCH v2.


-- 
Thanks!
Lv Ying
