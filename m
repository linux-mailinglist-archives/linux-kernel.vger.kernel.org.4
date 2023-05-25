Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C7710C28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjEYMbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjEYMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:31:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA55E43
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:31:12 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QRnQN2Gl5zLpvk;
        Thu, 25 May 2023 20:28:12 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 20:31:08 +0800
Message-ID: <bf94a380-fadd-8c38-cc51-4b54711d84b3@huawei.com>
Date:   Thu, 25 May 2023 20:31:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     "Gowans, James" <jgowans@amazon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <a2f82321-8bca-d773-b83e-a71c1f455e40@huawei.com>
 <efe052679277adf38f0b843420fec7657ed3dc37.camel@amazon.com>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <efe052679277adf38f0b843420fec7657ed3dc37.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/23 19:59, Gowans, James 写道:
> On Tue, 2023-05-23 at 11:15 +0800, liaochang (A) wrote:
>>> 1. Do we need to mask the IRQ and then unmask it later? I don't think so
>>> but it's not entirely clear why handle_edge_irq does this anyway; it's
>>> an edge IRQ so not sure why it needs to be masked.
>>
>>
>> In the GIC architecture, a CPU that is handling an IRQ cannot be signaled
>> with a new interrupt until it satisfies the interrupt preemption requirements
>> defined in the GIC architecture. One of these requirements is that the
>> priority of the new pending interrupt is higher than the priority of the
>> current running interrupt. Obviously, the same interrupt source cannot
>> preempt itself. Additionally, interrupt priority is rarely enabled in
>> the Linux kernel,except for the PESUDO_NMI.
>>
>> If the interrupt is an LPI, and interrupt handling is still in progress on
>> the original CPU, the lack of the ACITVE state means that the LPI can be
>> distributed to another CPU once its affinity has been changed. On the other
>> hand, since the desc->istate is marked IRQS_PENDING and this interrupt has
>> been consumed on the new CPU, there is no need to mask it and then unmask it later.
> 
> Thanks, this makes sense to me and matches my understanding. What I was
> actually unsure about was why handle_edge_irq() *does* do the masking. I
> guess it's because handle_edge_irq() runs desc->irq_data.chip->irq_ack(),
> and perhaps if that isn't run (in the concurrent invoke case) then the IRQ
> will keep getting re-triggered? Wild speculation. :-)

James,

I am not very familiar with the history of these flow handlers. However, according
to the comments, I believe that handle_edge_irq() masks interrupts to ensure a window
in which the first interrupt can be handled. This may be because, when handle_edge_irq()
was introduced into the kernel, the controller hardware may have been too simple to gate
interrupts from the same source. As a result, the kernel had to explicitly mask interrupts.

Modern Arm and GIC(v3) handle this differently. Once the CPU acknowledges an edge-triggered
LPI, it inherits the priority of the interrupt into the RRP register. This means that pending
interrupts with insufficient priority cannot preempt the handling interrupt on the CPU until
the CPU drops the priority by writing EOI. In other words, the interrupt from the same source
will be gated by the GIC hardware, so there is no need to do masking in handle_edge_irq().

> 
>>> 2. Should the EOI delivery be inside the do loop after every handler
>>> run? I think outside the loops is best; only inform the chip to deliver
>>> more IRQs once all pending runs have been finished.
>>
>> The GIC architecture requires that writes to the EOI register be in the exact
>> reverse order of reads from the IAR register. Therefore, IAR and EOI must be paired.
>> Writing EOI inside the do loop after every handler may cause subtle problems.
>>
> Ah ha! (where is this documented, btw?) And because the IAR read happens
> really early in (for example) __gic_handle_irq_from_irqson() it only makes
> sense to call EOI once when returning from the interrupt context. That
> also means that in the concurrent invoke case we would need to run EOI
> even if the handler was not invoked.

Download offical GIC specification from [1], and check out Chapter4.

> 
>>> 3. Do we need to check that desc->action is still set? I don't know if
>>> it can be un-set while the IRQ is still enabled.
>>
>> This check is necessary here. When the code enters this critical section, the kernel
>> running on another CPU might have already unregistered the IRQ action via the free_irq API.
>> Although free_irq is typically used in code paths called on module unload or exception
>> handling, we have also observed that virtualization using VFIO as a PCI backend
>> frequently intends to use free_irq in some regular code paths.
>>
> 
> Okay, I'm a bit hazy on whether it is or should be possible to unregister
> the IRQ action while the handler is still running - it sounds like you're
> saying this is possible and safe. More code spelunking would be necessary
> to verify this but I won't bother seeing as it looks like the solution
> we're tending towards uses check_irq_resend(), instead of invoking the
> handler directly.

> 
> JG

[1] https://developer.arm.com/documentation/ihi0069/latest/

-- 
BR
Liao, Chang
