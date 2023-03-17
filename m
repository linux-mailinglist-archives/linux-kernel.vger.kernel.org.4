Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275566BE64D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCQKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCQKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:12:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299A40F8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:12:40 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PdKcL6SCZz17KV1;
        Fri, 17 Mar 2023 18:09:38 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 18:12:38 +0800
Message-ID: <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
Date:   Fri, 17 Mar 2023 18:12:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     James Gowans <jgowans@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>,
        KarimAllah Raslan <karahmed@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
Content-Language: en-US
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20230317095300.4076497-1-jgowans@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
>             CPU 0             |          CPU 1
> -----------------------------|-----------------------------
> interrupt start              |
>    handle_fasteoi_irq         | set_affinity(CPU 1)
>      handler                  |
>      ...                      | interrupt start
>      ...                      |   handle_fasteoi_irq -> early out
>    handle_fasteoi_irq return  | interrupt end
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
>
> 2. Should the EOI delivery be inside the do loop after every handler
> run? I think outside the loops is best; only inform the chip to deliver
> more IRQs once all pending runs have been finished.
>
> 3. Do we need to check that desc->action is still set? I don't know if
> it can be un-set while the IRQ is still enabled.
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
>   Documentation/core-api/genericirq.rst | 9 ++++++++-
>   kernel/irq/chip.c                     | 9 +++++++--
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
> index f959c9b53f61..b54485eca8b5 100644
> --- a/Documentation/core-api/genericirq.rst
> +++ b/Documentation/core-api/genericirq.rst
> @@ -240,7 +240,14 @@ which only need an EOI at the end of the handler.
>   
>   The following control flow is implemented (simplified excerpt)::
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
>       desc->irq_data.chip->irq_eoi();
>   
>   
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 49e7bc871fec..4e5fc2b7e8a9 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -692,8 +692,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>   
>   	raw_spin_lock(&desc->lock);
>   
> -	if (!irq_may_run(desc))
> +	if (!irq_may_run(desc)) {
> +		desc->istate |= IRQS_PENDING;
>   		goto out;
> +	}
>   
>   	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>   
> @@ -711,7 +713,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>   	if (desc->istate & IRQS_ONESHOT)
>   		mask_irq(desc);
>   
> -	handle_irq_event(desc);
> +	do {
> +		handle_irq_event(desc);
> +	} while (unlikely((desc->istate & IRQS_PENDING) &&
> +			!irqd_irq_disabled(&desc->irq_data)));
>   
>   	cond_unmask_eoi_irq(desc, chip);
>   

Hi:

Finally, someone also hit this problem.

I just send patch a  few weeks ago.

It seems that we have the same solution.(I introduced a new flow handler).

Hopefully this issue will be fixed as soon as possible.

[1] 
https://lore.kernel.org/all/20230310101417.1081434-1-zouyipeng@huawei.com/

-- 
Regards,
Yipeng Zou

