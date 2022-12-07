Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297464582E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLGKvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLGKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:51:02 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23D92450A9;
        Wed,  7 Dec 2022 02:50:59 -0800 (PST)
Received: from loongson.cn (unknown [117.133.84.183])
        by gateway (Coremail) with SMTP id _____8AxCekTcJBjDs4DAA--.5513S3;
        Wed, 07 Dec 2022 18:50:59 +0800 (CST)
Received: from [192.168.1.2] (unknown [117.133.84.183])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxn+ARcJBjGDEnAA--.31698S3;
        Wed, 07 Dec 2022 18:50:58 +0800 (CST)
Message-ID: <cfbfe5c1-2dbb-a057-b56c-13900ba8c953@loongson.cn>
Date:   Wed, 7 Dec 2022 18:50:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] irqchip: loongson-liointc: add hierarchy irq support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn
References: <20221207014555.22465-1-zhuyinbo@loongson.cn>
 <874ju7tz4r.wl-maz@kernel.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
In-Reply-To: <874ju7tz4r.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxn+ARcJBjGDEnAA--.31698S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCr4rur1Utw4UJw4kAw48tFb_yoW5ZF1fpF
        W8Ca1avr45Jr12grW3Wr1UX34ay395JrZFyayfKF9ruFyDA34vkF109FnF9r4Syry8G3W2
        vF1xWrW5uF15GaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
        8v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/7 16:08, Marc Zyngier 写道:
> On Wed, 07 Dec 2022 01:45:55 +0000,
> Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>> When the irq of hierarchical interrupt chip was routed to liointc
>> that asked liointc driver to support hierarchy irq and this patch
>> was to add such support.
>>
>> In addition, this patch only consider dts, and acpi hierarchy irq
>> support will be added later as required.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-liointc.c | 31 ++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
>> index 0da8716f8f24..58e43a2cd02e 100644
>> --- a/drivers/irqchip/irq-loongson-liointc.c
>> +++ b/drivers/irqchip/irq-loongson-liointc.c
>> @@ -177,6 +177,32 @@ static const struct irq_domain_ops acpi_irq_gc_ops = {
>>   	.xlate	= liointc_domain_xlate,
>>   };
>>   
>> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>> +static int liointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +				unsigned int nr_irqs, void *arg)
>> +{
>> +	int i, ret;
>> +	irq_hw_number_t hwirq;
>> +	unsigned int type = IRQ_TYPE_NONE;
>> +	struct irq_fwspec *fwspec = arg;
>> +
>> +	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_map_generic_chip(domain, virq + i, hwirq + i);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops of_irq_gc_ops = {
>> +	.translate	= irq_domain_translate_twocell,
>> +	.alloc		= liointc_domain_alloc,
>> +	.free		= irq_domain_free_irqs_top,
>> +};
>> +#endif
>> +
>>   static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>>   		struct fwnode_handle *domain_handle, struct device_node *node)
>>   {
>> @@ -218,8 +244,13 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>>   		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>>   					&acpi_irq_gc_ops, priv);
>>   	else
>> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>> +		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>> +					&of_irq_gc_ops, priv);
>> +#else
>>   		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>>   					&irq_generic_chip_ops, priv);
>> +#endif
> Two things:
>
> - Why do we need three calls to create the same domains depending on
>    what firmware is used and kernel configuration?
yes, It depend on firmeware and kernel configuration.
>
> - who is going to decide whether to select the
>    CONFIG_IRQ_DOMAIN_HIERARCHY option?
The latest gpio driver will select  CONFIG_IRQ_DOMAIN_HIERARCHY
>
> I'd really like to see a statement from the Loongson folks about what
> this whole DT stuff is all about. AFAICT, the core ACPICA stuff isn't
> even fully merged (i.e. we still rely on arch-specific hacks).

The support of dts is mainly for Loongson embedded chips, such as 
LoongArch Loongson-2

series SoC.  and it use dts to descripte device and don't support acpi.

>
> Can you *please* finish what you've started before adding another
> layer of quality stuff on top?
>
> 	M.
>

