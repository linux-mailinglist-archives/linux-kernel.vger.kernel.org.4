Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0E6E5790
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDRCkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRCkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:40:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7F340C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:40:04 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [7.185.36.25])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q0p5T2dV5zKs8h;
        Tue, 18 Apr 2023 10:38:53 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 10:39:42 +0800
Message-ID: <84d80347-5d48-3a75-3f61-8096cd819d61@huawei.com>
Date:   Tue, 18 Apr 2023 10:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     Marc Zyngier <maz@kernel.org>, "Gowans, James" <jgowans@amazon.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <87h6tp5lkt.wl-maz@kernel.org>
 <0869847124f982c50d0f8d0ede996004f90a5576.camel@amazon.com>
 <86pm89kyyt.wl-maz@kernel.org>
Content-Language: en-US
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <86pm89kyyt.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/12 21:32, Marc Zyngier 写道:
> I think we have most of what we need already, see the hack below. It
> is totally untested, but you'll hopefully get the idea.
>
> Thanks,
>
> 	M.
>
> >From c96d2ab37fe273724f1264fba5f4913259875d56 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 10 Apr 2023 10:56:32 +0100
> Subject: [PATCH] irqchip/gicv3-its: Force resend of LPIs taken while already
>   in-progress
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3-its.c |  3 +++
>   include/linux/irq.h              | 13 +++++++++++++
>   kernel/irq/chip.c                |  5 ++++-
>   kernel/irq/debugfs.c             |  2 ++
>   4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 586271b8aa39..d04c73a2bc6b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3574,6 +3574,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>   		irqd = irq_get_irq_data(virq + i);
>   		irqd_set_single_target(irqd);
>   		irqd_set_affinity_on_activate(irqd);
> +		irqd_set_resend_when_in_progress(irqd);
>   		pr_debug("ID:%d pID:%d vID:%d\n",
>   			 (int)(hwirq + i - its_dev->event_map.lpi_base),
>   			 (int)(hwirq + i), virq + i);
> @@ -4512,6 +4513,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>   		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
>   					      irqchip, vm->vpes[i]);
>   		set_bit(i, bitmap);
> +
> +		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
>   	}
>   
>   	if (err) {
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b1b28affb32a..4b2a7cc96eb2 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -223,6 +223,8 @@ struct irq_data {
>    *				  irq_chip::irq_set_affinity() when deactivated.
>    * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
>    *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
> + * IRQD_RESEND_WHEN_IN_PROGRESS - Interrupt may fire when already in progress,
> + *				  needs resending.
>    */
>   enum {
>   	IRQD_TRIGGER_MASK		= 0xf,
> @@ -249,6 +251,7 @@ enum {
>   	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
>   	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
>   	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
> +	IRQD_RESEND_WHEN_IN_PROGRESS	= (1 << 31),
>   };
>   
>   #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
> @@ -448,6 +451,16 @@ static inline bool irqd_affinity_on_activate(struct irq_data *d)
>   	return __irqd_to_state(d) & IRQD_AFFINITY_ON_ACTIVATE;
>   }
>   
> +static inline bool irqd_needs_resend_when_in_progress(struct irq_data *d)
> +{
> +	return __irqd_to_state(d) & IRQD_RESEND_WHEN_IN_PROGRESS;
> +}
> +
> +static inline void irqd_set_resend_when_in_progress(struct irq_data *d)
> +{
> +	__irqd_to_state(d) |= IRQD_RESEND_WHEN_IN_PROGRESS;
> +}
> +
>   #undef __irqd_to_state
>   
>   static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 49e7bc871fec..73546ba8bc43 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -692,8 +692,11 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>   
>   	raw_spin_lock(&desc->lock);
>   
> -	if (!irq_may_run(desc))
> +	if (!irq_may_run(desc)) {
> +		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
> +			check_irq_resend(desc, true);
>   		goto out;
> +	}
>   
>   	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>   
> diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
> index bbcaac64038e..5971a66be034 100644
> --- a/kernel/irq/debugfs.c
> +++ b/kernel/irq/debugfs.c
> @@ -133,6 +133,8 @@ static const struct irq_bit_descr irqdata_states[] = {
>   	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
>   
>   	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
> +
> +	BIT_MASK_DESCR(IRQD_RESEND_WHEN_IN_PROGRESS),
>   };
>   
>   static const struct irq_bit_descr irqdesc_states[] = {

Hi Marc:

     Thanks for you patch, and i was tested it on my board, it works for me.

     We force resend a irq when irq_may_run return false, besides 
IRQD_IRQ_INPROGRESS,

     are there other situations (such as IRQD_WAKEUP_ARMED) that will 
also resend an irq?

-- 
Regards,
Yipeng Zou

