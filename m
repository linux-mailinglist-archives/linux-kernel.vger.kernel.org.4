Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7F6DE9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDLDDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLDD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:03:27 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F7A2134;
        Tue, 11 Apr 2023 20:03:25 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E1E1724E207;
        Wed, 12 Apr 2023 11:03:23 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 11:03:24 +0800
Received: from [192.168.125.82] (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 11:03:22 +0800
Message-ID: <5f9ee37a-cd22-16cf-4083-a102902ba5ea@starfivetech.com>
Date:   Wed, 12 Apr 2023 11:03:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 3/7] soc: starfive: Modify ioremap to regmap
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-4-changhuang.liang@starfivetech.com>
 <20230411-sanctuary-impotent-92964df67a26@spud>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230411-sanctuary-impotent-92964df67a26@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 4:26, Conor Dooley wrote:
> On Mon, Apr 10, 2023 at 11:47:39PM -0700, Changhuang Liang wrote:
>> Modify ioremap to regmap, easy to simplify code.
> 
> This doesn't simplify anything, adding regmap to the mix actually makes
> it less obvious what is going on here & it's not even fewer LoC:
> 1 file changed, 23 insertions(+), 20 deletions(-)
> 
> Please write a commit message that explains the real motivation for
> this change.
> 
> Thanks,
> Conor.
> 

When a new pmu is introduced later, they can use the same member 
"struct regmap *base" in "struct jh71xx_pmu". I will add more
commit message later.

>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>  drivers/soc/starfive/jh71xx_pmu.c | 43 +++++++++++++++++--------------
>>  1 file changed, 23 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
>> index 7d5f50d71c0d..306218c83691 100644
>> --- a/drivers/soc/starfive/jh71xx_pmu.c
>> +++ b/drivers/soc/starfive/jh71xx_pmu.c
>> @@ -6,13 +6,13 @@
>>   */
>>  
>>  #include <linux/interrupt.h>
>> -#include <linux/io.h>
>> -#include <linux/iopoll.h>
>> +#include <linux/mfd/syscon.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_domain.h>
>> +#include <linux/regmap.h>
>>  #include <dt-bindings/power/starfive,jh7110-pmu.h>
>>  
>>  /* register offset */
>> @@ -59,7 +59,7 @@ struct jh71xx_pmu_match_data {
>>  struct jh71xx_pmu {
>>  	struct device *dev;
>>  	const struct jh71xx_pmu_match_data *match_data;
>> -	void __iomem *base;
>> +	struct regmap *base;
>>  	struct generic_pm_domain **genpd;
>>  	struct genpd_onecell_data genpd_data;
>>  	int irq;
>> @@ -75,11 +75,14 @@ struct jh71xx_pmu_dev {
>>  static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_on)
>>  {
>>  	struct jh71xx_pmu *pmu = pmd->pmu;
>> +	unsigned int val;
>>  
>>  	if (!mask)
>>  		return -EINVAL;
>>  
>> -	*is_on = readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
>> +	regmap_read(pmu->base, JH71XX_PMU_CURR_POWER_MODE, &val);
>> +
>> +	*is_on = val & mask;
>>  
>>  	return 0;
>>  }
>> @@ -130,7 +133,7 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
>>  		encourage_hi = JH71XX_PMU_SW_ENCOURAGE_DIS_HI;
>>  	}
>>  
>> -	writel(mask, pmu->base + mode);
>> +	regmap_write(pmu->base, mode, mask);
>>  
>>  	/*
>>  	 * 2.Write SW encourage command sequence to the Software Encourage Reg (offset 0x44)
>> @@ -140,21 +143,21 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
>>  	 *   Then write the lower bits of the command sequence, followed by the upper
>>  	 *   bits. The sequence differs between powering on & off a domain.
>>  	 */
>> -	writel(JH71XX_PMU_SW_ENCOURAGE_ON, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
>> -	writel(encourage_lo, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
>> -	writel(encourage_hi, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
>> +	regmap_write(pmu->base, JH71XX_PMU_SW_ENCOURAGE, JH71XX_PMU_SW_ENCOURAGE_ON);
>> +	regmap_write(pmu->base, JH71XX_PMU_SW_ENCOURAGE, encourage_lo);
>> +	regmap_write(pmu->base, JH71XX_PMU_SW_ENCOURAGE, encourage_hi);
>>  
>>  	spin_unlock_irqrestore(&pmu->lock, flags);
>>  
>>  	/* Wait for the power domain bit to be enabled / disabled */
>>  	if (on) {
>> -		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
>> -						val, val & mask,
>> -						1, JH71XX_PMU_TIMEOUT_US);
>> +		ret = regmap_read_poll_timeout_atomic(pmu->base, JH71XX_PMU_CURR_POWER_MODE,
>> +						      val, val & mask,
>> +						      1, JH71XX_PMU_TIMEOUT_US);
>>  	} else {
>> -		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
>> -						val, !(val & mask),
>> -						1, JH71XX_PMU_TIMEOUT_US);
>> +		ret = regmap_read_poll_timeout_atomic(pmu->base, JH71XX_PMU_CURR_POWER_MODE,
>> +						      val, !(val & mask),
>> +						      1, JH71XX_PMU_TIMEOUT_US);
>>  	}
>>  
>>  	if (ret) {
>> @@ -190,14 +193,14 @@ static void jh71xx_pmu_int_enable(struct jh71xx_pmu *pmu, u32 mask, bool enable)
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&pmu->lock, flags);
>> -	val = readl(pmu->base + JH71XX_PMU_TIMER_INT_MASK);
>> +	regmap_read(pmu->base, JH71XX_PMU_TIMER_INT_MASK, &val);
>>  
>>  	if (enable)
>>  		val &= ~mask;
>>  	else
>>  		val |= mask;
>>  
>> -	writel(val, pmu->base + JH71XX_PMU_TIMER_INT_MASK);
>> +	regmap_write(pmu->base, JH71XX_PMU_TIMER_INT_MASK, val);
>>  	spin_unlock_irqrestore(&pmu->lock, flags);
>>  }
>>  
>> @@ -206,7 +209,7 @@ static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
>>  	struct jh71xx_pmu *pmu = data;
>>  	u32 val;
>>  
>> -	val = readl(pmu->base + JH71XX_PMU_INT_STATUS);
>> +	regmap_read(pmu->base, JH71XX_PMU_INT_STATUS, &val);
>>  
>>  	if (val & JH71XX_PMU_INT_SEQ_DONE)
>>  		dev_dbg(pmu->dev, "sequence done.\n");
>> @@ -220,8 +223,8 @@ static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
>>  		dev_err(pmu->dev, "p-channel fail event.\n");
>>  
>>  	/* clear interrupts */
>> -	writel(val, pmu->base + JH71XX_PMU_INT_STATUS);
>> -	writel(val, pmu->base + JH71XX_PMU_EVENT_STATUS);
>> +	regmap_write(pmu->base, JH71XX_PMU_INT_STATUS, val);
>> +	regmap_write(pmu->base, JH71XX_PMU_EVENT_STATUS, val);
>>  
>>  	return IRQ_HANDLED;
>>  }
>> @@ -271,7 +274,7 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
>>  	if (!pmu)
>>  		return -ENOMEM;
>>  
>> -	pmu->base = devm_platform_ioremap_resource(pdev, 0);
>> +	pmu->base = device_node_to_regmap(np);
>>  	if (IS_ERR(pmu->base))
>>  		return PTR_ERR(pmu->base);
>>  
>> -- 
>> 2.25.1
>>
