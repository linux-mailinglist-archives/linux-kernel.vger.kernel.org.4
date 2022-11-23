Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC30636287
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiKWO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiKWO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:57:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C0F70A37;
        Wed, 23 Nov 2022 06:57:06 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 315576602939;
        Wed, 23 Nov 2022 14:57:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669215424;
        bh=g4PZ1pFavunt2Qa2dTh59ojyrA0227tsgXRwJ1+S5mY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nuS1G94KsbG8q60/U2Ciim/So0bBfMPt4cb+jgeUkgxwkI+hsKaMhX71KemIi2EO5
         tyyBCXos2d1dYnRREbO92uE/NiOjPs7FxW5pnU5WpWmHyMoqdF3UDxw7v34bwiQiX3
         7FC2yAKhPQm0gldiu1rYhME7staCFi9hUWmVrJBUtqlo16sxGtvD5rfTXKl4rdUCap
         wdCT6zTSoK4RmA729jiY2cNYfnpRztbWpMSWXyhljuGEN9B/H7/6YbDk/FSu/Nk3XW
         UVWN9a/KZcvLpaUhwljPQpzHXEZCG+44KdgKP7NsiUWAgUPE9xw95LKaf84IGqHSo7
         1zZk8c/rGAqOg==
Message-ID: <c8174977-2995-811a-83e2-9f941057acd8@collabora.com>
Date:   Wed, 23 Nov 2022 15:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/4] irqchip: irq-mtk-cirq: Move register offsets to
 const array
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
 <20221123112249.98281-4-angelogioacchino.delregno@collabora.com>
 <86fse9ok3y.wl-maz@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <86fse9ok3y.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/11/22 14:50, Marc Zyngier ha scritto:
> On Wed, 23 Nov 2022 11:22:48 +0000,
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
>>
>> In preparation to add support for new SoCs having a different
>> register layout, add an enumeration that documents register
>> offsets and move the definitions for the same to a u32 array;
>>
>> Selecting the right register offsets array is done by adding an
>> of_device_id array containing all of the currently supported
>> compatible strings pointing to the "v1" offsets array (as data):
>> since no devicetree declares the `mediatek,mtk-cirq` compatible
>> without a SoC-specific one, it wasn't necessary to provide any
>> legacy fallback.
>>
>> Every usage of the aforemementioned definitions was changed to
>> get a register address through a newly introduced `mtk_cirq_reg()`
>> accessor.
>>
>> This change brings no functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/irqchip/irq-mtk-cirq.c | 78 ++++++++++++++++++++++++++--------
>>   1 file changed, 61 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
>> index 9bca0918078e..4d873d2ba0fd 100644
>> --- a/drivers/irqchip/irq-mtk-cirq.c
>> +++ b/drivers/irqchip/irq-mtk-cirq.c
>> @@ -15,14 +15,29 @@
>>   #include <linux/slab.h>
>>   #include <linux/syscore_ops.h>
>>   
>> -#define CIRQ_ACK	0x40
>> -#define CIRQ_MASK_SET	0xc0
>> -#define CIRQ_MASK_CLR	0x100
>> -#define CIRQ_SENS_SET	0x180
>> -#define CIRQ_SENS_CLR	0x1c0
>> -#define CIRQ_POL_SET	0x240
>> -#define CIRQ_POL_CLR	0x280
>> -#define CIRQ_CONTROL	0x300
>> +enum mtk_cirq_reg_index {
>> +	CIRQ_STA,
>> +	CIRQ_ACK,
>> +	CIRQ_MASK_SET,
>> +	CIRQ_MASK_CLR,
>> +	CIRQ_SENS_SET,
>> +	CIRQ_SENS_CLR,
>> +	CIRQ_POL_SET,
>> +	CIRQ_POL_CLR,
>> +	CIRQ_CONTROL
>> +};
>> +
>> +static const u32 mtk_cirq_regs_v1[] = {
> 
> Again: this contains offsets, not registers. Consistency matters.
> 

Ack.

>> +	[CIRQ_STA]	= 0x0,
>> +	[CIRQ_ACK]	= 0x40,
>> +	[CIRQ_MASK_SET]	= 0xc0,
>> +	[CIRQ_MASK_CLR]	= 0x100,
>> +	[CIRQ_SENS_SET]	= 0x180,
>> +	[CIRQ_SENS_CLR]	= 0x1c0,
>> +	[CIRQ_POL_SET]	= 0x240,
>> +	[CIRQ_POL_CLR]	= 0x280,
>> +	[CIRQ_CONTROL]	= 0x300,
>> +};
>>   
>>   #define CIRQ_EN	0x1
>>   #define CIRQ_EDGE	0x2
>> @@ -32,18 +47,28 @@ struct mtk_cirq_chip_data {
>>   	void __iomem *base;
>>   	unsigned int ext_irq_start;
>>   	unsigned int ext_irq_end;
>> +	const u32 *offsets;
>>   	struct irq_domain *domain;
>>   };
>>   
>>   static struct mtk_cirq_chip_data *cirq_data;
>>   
>> -static void mtk_cirq_write_mask(struct irq_data *data, unsigned int offset)
>> +static inline void __iomem *mtk_cirq_reg(struct mtk_cirq_chip_data *chip_data,
> 
> Drop the inline. That's for the compiler to figure it out.
> 

Will do.

>> +					 enum mtk_cirq_reg_index idx,
>> +					 unsigned int cirq_num)
> 
> What does cirq_num mean for registers that are not relative to an
> interrupt? Create a separate helper for those.
> 
Means literally nothing, so yes I agree, but...

... mtk_cirq_irq_reg(), mtk_cirq_reg() feels too similar and may lead to
confusion while reading the code.

Any advice about a possibly clear-er name?

>> +{
>> +	void __iomem *reg = chip_data->base + chip_data->offsets[idx];
>> +
>> +	return reg + (cirq_num / 32) * 4;
>> +}
>> +
>> +static void mtk_cirq_write_mask(struct irq_data *data, enum mtk_cirq_reg_index idx)
>>   {
>>   	struct mtk_cirq_chip_data *chip_data = data->chip_data;
>>   	unsigned int cirq_num = data->hwirq;
>>   	u32 mask = 1 << (cirq_num % 32);
>>   
>> -	writel_relaxed(mask, chip_data->base + offset + (cirq_num / 32) * 4);
>> +	writel_relaxed(mask, mtk_cirq_reg(chip_data, idx, cirq_num));
>>   }
>>   
>>   static void mtk_cirq_mask(struct irq_data *data)
>> @@ -160,6 +185,7 @@ static const struct irq_domain_ops cirq_domain_ops = {
>>   #ifdef CONFIG_PM_SLEEP
>>   static int mtk_cirq_suspend(void)
>>   {
>> +	void __iomem *reg;
>>   	u32 value, mask;
>>   	unsigned int irq, hwirq_num;
>>   	bool pending, masked;
>> @@ -200,31 +226,34 @@ static int mtk_cirq_suspend(void)
>>   				continue;
>>   		}
>>   
>> +		reg = mtk_cirq_reg(cirq_data, CIRQ_ACK, i);
>>   		mask = 1 << (i % 32);
>> -		writel_relaxed(mask, cirq_data->base + CIRQ_ACK + (i / 32) * 4);
>> +		writel_relaxed(mask, reg);
>>   	}
>>   
>>   	/* set edge_only mode, record edge-triggerd interrupts */
>>   	/* enable cirq */
>> -	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
>> +	reg = mtk_cirq_reg(cirq_data, CIRQ_CONTROL, 0);
>> +	value = readl_relaxed(reg);
>>   	value |= (CIRQ_EDGE | CIRQ_EN);
>> -	writel_relaxed(value, cirq_data->base + CIRQ_CONTROL);
>> +	writel_relaxed(value, reg);
>>   
>>   	return 0;
>>   }
>>   
>>   static void mtk_cirq_resume(void)
>>   {
>> +	void __iomem *reg = mtk_cirq_reg(cirq_data, CIRQ_CONTROL, 0);
>>   	u32 value;
>>   
>>   	/* flush recorded interrupts, will send signals to parent controller */
>> -	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
>> -	writel_relaxed(value | CIRQ_FLUSH, cirq_data->base + CIRQ_CONTROL);
>> +	value = readl_relaxed(reg);
>> +	writel_relaxed(value | CIRQ_FLUSH, reg);
>>   
>>   	/* disable cirq */
>> -	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
>> +	value = readl_relaxed(reg);
>>   	value &= ~(CIRQ_EDGE | CIRQ_EN);
>> -	writel_relaxed(value, cirq_data->base + CIRQ_CONTROL);
>> +	writel_relaxed(value, reg);
>>   }
>>   
>>   static struct syscore_ops mtk_cirq_syscore_ops = {
>> @@ -240,10 +269,18 @@ static void mtk_cirq_syscore_init(void)
>>   static inline void mtk_cirq_syscore_init(void) {}
>>   #endif
>>   
>> +static const struct of_device_id mtk_cirq_of_match[] = {
> 
> Can't this be made __initconst?
> 

Ack.

>> +	{ .compatible = "mediatek,mt2701-cirq", .data = &mtk_cirq_regs_v1 },
>> +	{ .compatible = "mediatek,mt8135-cirq", .data = &mtk_cirq_regs_v1 },
>> +	{ .compatible = "mediatek,mt8173-cirq", .data = &mtk_cirq_regs_v1 },
>> +	{ /* sentinel */ }
>> +};
>> +
>>   static int __init mtk_cirq_of_init(struct device_node *node,
>>   				   struct device_node *parent)
>>   {
>>   	struct irq_domain *domain, *domain_parent;
>> +	const struct of_device_id *match;
>>   	unsigned int irq_num;
>>   	int ret;
>>   
>> @@ -274,6 +311,13 @@ static int __init mtk_cirq_of_init(struct device_node *node,
>>   	if (ret)
>>   		goto out_unmap;
>>   
>> +	match = of_match_node(mtk_cirq_of_match, node);
>> +	if (!match) {
>> +		ret = -ENODEV;
>> +		goto out_unmap;
>> +	}
> 
> Can't you perform this before mapping the MMIO region and allocating
> memory? If you must fail, fail early.
> 

I was thinking the same, but ultimately chose to aggregate handling that entirely
in one place...

I'll move that as suggested.

Many thanks,
Angelo

