Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134D270D240
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjEWDQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEWDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:16:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF990
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:15:57 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QQK8w2pfNz18Lc1;
        Tue, 23 May 2023 11:11:28 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 11:15:55 +0800
Message-ID: <a2f82321-8bca-d773-b83e-a71c1f455e40@huawei.com>
Date:   Tue, 23 May 2023 11:15:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     James Gowans <jgowans@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        "zhangjianhua (E)" <chris.zjh@huawei.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20230317095300.4076497-1-jgowans@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James

在 2023/3/17 17:53, James Gowans 写道:
> Update the generic handle_fasteoi_irq to cater for the case when the
> next interrupt comes in while the previous handler is still running.
> Currently when that happens the irq_may_run() early out causes the next
> IRQ to be lost. Change the behaviour to mark the interrupt as pending
> and re-run the handler when handle_fasteoi_irq sees that the pending
> flag has been set again. This is largely inspired by handle_edge_irq.
> 
> Generally it should not be possible for the next interrupt to arrive
> while the previous handler is still running: the next interrupt should
> only arrive after the EOI message has been sent and the previous handler
> has returned. However, there is a race where if the interrupt affinity
> is changed while the previous handler is running, then the next
> interrupt can arrive at a different CPU while the previous handler is
> still running. In that case there will be a concurrent invoke and the
> early out will be taken.
> 
> For example:
> 
>            CPU 0             |          CPU 1
> -----------------------------|-----------------------------
> interrupt start              |
>   handle_fasteoi_irq         | set_affinity(CPU 1)
>     handler                  |
>     ...                      | interrupt start
>     ...                      |   handle_fasteoi_irq -> early out
>   handle_fasteoi_irq return  | interrupt end
> interrupt end                |
> 
> This issue was observed specifically on an arm64 system with a GIC-v3
> handling MSIs; GIC-v3 uses the handle_fasteoi_irq handler. The issue is
> that the global ITS is responsible for affinity but does not know
> whether interrupts are pending/running, only the CPU-local redistributor
> handles the EOI. Hence when the affinity is changed in the ITS, the new
> CPU's redistributor does not know that the original CPU is still running
> the handler.
> 
> There are a few uncertainties about this implementation compared to the
> prior art in handle_edge_irq:
> 
> 1. Do we need to mask the IRQ and then unmask it later? I don't think so
> but it's not entirely clear why handle_edge_irq does this anyway; it's
> an edge IRQ so not sure why it needs to be masked.

In the GIC architecture, a CPU that is handling an IRQ cannot be signaled
with a new interrupt until it satisfies the interrupt preemption requirements
defined in the GIC architecture. One of these requirements is that the
priority of the new pending interrupt is higher than the priority of the
current running interrupt. Obviously, the same interrupt source cannot
preempt itself. Additionally, interrupt priority is rarely enabled in
the Linux kernel,except for the PESUDO_NMI.

If the interrupt is an LPI, and interrupt handling is still in progress on
the original CPU, the lack of the ACITVE state means that the LPI can be
distributed to another CPU once its affinity has been changed. On the other
hand, since the desc->istate is marked IRQS_PENDING and this interrupt has
been consumed on the new CPU, there is no need to mask it and then unmask it later.

> 
> 2. Should the EOI delivery be inside the do loop after every handler
> run? I think outside the loops is best; only inform the chip to deliver
> more IRQs once all pending runs have been finished.

The GIC architecture requires that writes to the EOI register be in the exact
reverse order of reads from the IAR register. Therefore, IAR and EOI must be paired.
Writing EOI inside the do loop after every handler may cause subtle problems.

> 
> 3. Do we need to check that desc->action is still set? I don't know if
> it can be un-set while the IRQ is still enabled.

This check is necessary here. When the code enters this critical section, the kernel
running on another CPU might have already unregistered the IRQ action via the free_irq API.
Although free_irq is typically used in code paths called on module unload or exception
handling, we have also observed that virtualization using VFIO as a PCI backend
frequently intends to use free_irq in some regular code paths.

Thanks.

> 
> 4. There is now more overlap with the handle_edge_eoi_irq handler;
> should we try to unify these?
> 
> Signed-off-by: James Gowans <jgowans@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: KarimAllah Raslan <karahmed@amazon.com>
> ---
>  Documentation/core-api/genericirq.rst | 9 ++++++++-
>  kernel/irq/chip.c                     | 9 +++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
> index f959c9b53f61..b54485eca8b5 100644
> --- a/Documentation/core-api/genericirq.rst
> +++ b/Documentation/core-api/genericirq.rst
> @@ -240,7 +240,14 @@ which only need an EOI at the end of the handler.
>  
>  The following control flow is implemented (simplified excerpt)::
>  
> -    handle_irq_event(desc->action);
> +    if (desc->status & running) {
> +        desc->status |= pending;
> +        return;
> +    }
> +    do {
> +        desc->status &= ~pending;
> +        handle_irq_event(desc->action);
> +    } while (status & pending);
>      desc->irq_data.chip->irq_eoi();
>  
>  
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 49e7bc871fec..4e5fc2b7e8a9 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -692,8 +692,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>  
>  	raw_spin_lock(&desc->lock);
>  
> -	if (!irq_may_run(desc))
> +	if (!irq_may_run(desc)) {
> +		desc->istate |= IRQS_PENDING;
>  		goto out;
> +	}
>  
>  	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>  
> @@ -711,7 +713,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>  	if (desc->istate & IRQS_ONESHOT)
>  		mask_irq(desc);
>  
> -	handle_irq_event(desc);
> +	do {
> +		handle_irq_event(desc);
> +	} while (unlikely((desc->istate & IRQS_PENDING) &&
> +			!irqd_irq_disabled(&desc->irq_data)));
>  
>  	cond_unmask_eoi_irq(desc, chip);
>  
