Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D768CD9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBGDus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGDuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:50:46 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A7F421E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:50:44 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1E13024E15C;
        Tue,  7 Feb 2023 11:50:37 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 11:50:37 +0800
Received: from [192.168.125.89] (183.27.96.33) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 11:50:36 +0800
Message-ID: <21d774af-76bb-538e-b0f6-f52295116fa7@starfivetech.com>
Date:   Tue, 7 Feb 2023 11:50:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] irqchip/irq-sifive-plic: Add syscore callbacks for
 hibernation
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20230113094216.116036-1-mason.huo@starfivetech.com>
 <864js01j26.wl-maz@kernel.org>
 <c851138c-148a-bc5f-219b-1573d7e7e318@starfivetech.com>
 <86v8kfyn62.wl-maz@kernel.org>
Content-Language: en-US
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <86v8kfyn62.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.33]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/6 20:48, Marc Zyngier wrote:
> On Mon, 06 Feb 2023 06:13:11 +0000,
> Mason Huo <mason.huo@starfivetech.com> wrote:
>> 
>> 
>> 
>> On 2023/2/5 18:51, Marc Zyngier wrote:
>> > On Fri, 13 Jan 2023 09:42:16 +0000,
>> > Mason Huo <mason.huo@starfivetech.com> wrote:
>> >> 
>> >> The priority and enable registers of plic will be reset
>> >> during hibernation power cycle in poweroff mode,
>> >> add the syscore callbacks to save/restore those registers.
>> >> 
>> >> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
>> >> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>> >> Reviewed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>> >> ---
>> >>  drivers/irqchip/irq-sifive-plic.c | 93 ++++++++++++++++++++++++++++++-
>> >>  1 file changed, 91 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> >> index ff47bd0dec45..80306de45d2b 100644
>> >> --- a/drivers/irqchip/irq-sifive-plic.c
>> >> +++ b/drivers/irqchip/irq-sifive-plic.c
>> >> @@ -17,6 +17,7 @@
>> >>  #include <linux/of_irq.h>
>> >>  #include <linux/platform_device.h>
>> >>  #include <linux/spinlock.h>
>> >> +#include <linux/syscore_ops.h>
>> >>  #include <asm/smp.h>
>> >>  
>> >>  /*
>> >> @@ -67,6 +68,8 @@ struct plic_priv {
>> >>  	struct irq_domain *irqdomain;
>> >>  	void __iomem *regs;
>> >>  	unsigned long plic_quirks;
>> >> +	unsigned int nr_irqs;
>> >> +	u32 *priority_reg;
>> >>  };
>> >>  
>> >>  struct plic_handler {
>> >> @@ -79,10 +82,13 @@ struct plic_handler {
>> >>  	raw_spinlock_t		enable_lock;
>> >>  	void __iomem		*enable_base;
>> >>  	struct plic_priv	*priv;
>> >> +	/* To record interrupts that are enabled before suspend. */
>> >> +	u32 enable_reg[MAX_DEVICES / 32];
>> > 
>> > What does MAX_DEVICES represent here? How is it related to the number
>> > of interrupts you're trying to save? It seems to be related to the
>> > number of CPUs, so it hardly makes any sense so far.
>> > 
>> The comment of this macro describes that "The largest number supported
>> by devices marked as 'sifive,plic-1.0.0', is 1024, of which
>> device 0 is defined as non-existent by the RISC-V Privileged Spec."
>> As far as I understand, the *device* here means HW IRQ source,
>> and the HW IRQ 0 is non-existent.
> 
> So why is it sized to that maximum value? The binding gives you the
> *real* value that the HW implements.
> 
OK, will change to use binding value.

>> 
>> >>  };
>> >>  static int plic_parent_irq __ro_after_init;
>> >>  static bool plic_cpuhp_setup_done __ro_after_init;
>> >>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>> >> +static struct plic_priv *priv_data;
>> >>  
>> >>  static int plic_irq_set_type(struct irq_data *d, unsigned int type);
>> >>  
>> >> @@ -229,6 +235,78 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
>> >>  	return IRQ_SET_MASK_OK;
>> >>  }
>> >>  
>> >> +static void plic_irq_resume(void)
>> >> +{
>> >> +	unsigned int i, cpu;
>> >> +	u32 __iomem *reg;
>> >> +
>> >> +	for (i = 0; i < priv_data->nr_irqs; i++)
>> >> +		writel(priv_data->priority_reg[i],
>> >> +				priv_data->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
>> > 
>> > From what I can tell, this driver uses exactly 2 priorities: 0 and 1.
>> > And yet you use a full 32bit to encode those. Does it seem like a good
>> > idea?
>> > 
>> Yes, currently this driver uses oly 2 priorities.
>> But, according to the sifive spec, the priority register is a 32bit register,
>> and it supports 7 levels of priority.
> 
> And? This is a Linux driver, not an implementation validation
> tool. What is the point of saving/restoring stuff that is *never*
> used? :-(
> 
> 	M.
> OK, will save/restore the priority in 1 bit. 

Thanks
Mason
