Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A846DED68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDLITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:19:33 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA7C2;
        Wed, 12 Apr 2023 01:19:30 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3BBD824E1BE;
        Wed, 12 Apr 2023 16:19:29 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 16:19:29 +0800
Received: from [192.168.125.82] (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 16:19:28 +0800
Message-ID: <68839732-2d3f-aafc-8744-550f4bfa27f0@starfivetech.com>
Date:   Wed, 12 Apr 2023 16:19:27 +0800
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
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
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
>> Add dphy pmu to turn on/off the dphy power switch.
[...]
>> +
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

OK, I will use call back make here neater.

> Very much open to dissenting opinions there though. Emil? Walker?
> 
> Cheers,
> Conor.
> 
>>  
>>  	return ret;
>>  }
[...]
>> -- 
>> 2.25.1
>>
