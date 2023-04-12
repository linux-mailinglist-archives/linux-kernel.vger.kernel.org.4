Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF06DEC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDLHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDLHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:31:56 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1E103;
        Wed, 12 Apr 2023 00:31:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0157A24E1BE;
        Wed, 12 Apr 2023 15:31:43 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 15:31:43 +0800
Received: from [192.168.125.82] (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 15:31:42 +0800
Message-ID: <1d085fe3-39f8-232a-e628-1eb138b899b7@starfivetech.com>
Date:   Wed, 12 Apr 2023 15:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 6/7] soc: starfive: Add dphy pmu support
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
 <20230411064743.273388-7-changhuang.liang@starfivetech.com>
 <20230411-iron-everybody-70b78e94aee5@spud>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230411-iron-everybody-70b78e94aee5@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 5:15, Conor Dooley wrote:
> On Mon, Apr 10, 2023 at 11:47:42PM -0700, Changhuang Liang wrote:
[...]
>> +++ b/MAINTAINERS
>> @@ -19944,6 +19944,7 @@ F:	include/dt-bindings/reset/starfive?jh71*.h
>>  
>>  STARFIVE JH71XX PMU CONTROLLER DRIVER
>>  M:	Walker Chen <walker.chen@starfivetech.com>
>> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
> 
> Unmentioned in the commit message, plus I would like an R-b or an Ack
> from Walker.
> 

OK, I will make a discuss with Walker.

>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/power/starfive*
>>  F:	drivers/soc/starfive/jh71xx_pmu.c
>> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
>> index 990db6735c48..d4092ca4dccf 100644
[...]
>> @@ -94,6 +97,8 @@ static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_o
>>  
>>  	if (pmu->match_data->pmu_type == JH71XX_PMU_GENERAL)
>>  		offset = JH71XX_PMU_CURR_POWER_MODE;
>> +	else if (pmu->match_data->pmu_type == JH71XX_PMU_DPHY)
> 
> There are only two options for this "enum", so why `else if`?
> 

OK, will change to else.

>> +		offset = JH71XX_PMU_DPHY_SWITCH;
>>  
>>  	regmap_read(pmu->base, offset, &val);
>>  
>> @@ -170,6 +175,23 @@ static int jh71xx_pmu_general_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bo
>>  	return 0;
>>  }
>>  
[...]
>>  static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
>>  {
>>  	struct jh71xx_pmu *pmu = pmd->pmu;
>> @@ -191,6 +213,8 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
>>  
>>  	if (pmu->match_data->pmu_type == JH71XX_PMU_GENERAL)
>>  		ret = jh71xx_pmu_general_set_state(pmd, mask, on);
>> +	else if (pmu->match_data->pmu_type == JH71XX_PMU_DPHY)
>> +		ret = jh71xx_pmu_dphy_set_state(pmd, mask, on);
> 
> Perhaps I am verging on over-complication, but I dislike this carry on.
> Is this the only time we'll see a power domain provider coming out of
> a syscon, or are there likely to be more?
> Either way, I think having an ops struct w/ both parse_dt() and the
> set_state() implementations would be neater than what you have here.
> 
> Very much open to dissenting opinions there though. Emil? Walker?
> 
> Cheers,
> Conor.
> 

"else if" will change to "else"
As far as I know, there are only two types power domain on the JH7110 SoC.
One is the original, another one is coming out of a syscon.

>>  
>>  	return ret;
>>  }
[...]
>> 2.25.1
>>
