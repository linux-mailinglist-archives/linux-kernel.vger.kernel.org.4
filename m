Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284F76DEFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDLI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjDLI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:58:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8EA5D2;
        Wed, 12 Apr 2023 01:57:49 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2A92624E287;
        Wed, 12 Apr 2023 16:51:19 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 16:51:19 +0800
Received: from [192.168.125.82] (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 16:51:18 +0800
Message-ID: <ee406b3d-0719-9332-cab5-62fe7537bcf1@starfivetech.com>
Date:   Wed, 12 Apr 2023 16:51:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/7] dt-bindings: power: Constrain properties for
 JH7110 PMU
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-2-changhuang.liang@starfivetech.com>
 <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 16:35, Krzysztof Kozlowski wrote:
> On 11/04/2023 08:47, Changhuang Liang wrote:
>> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg and
>> interrupts properties.
[...]
>>  
>>  description: |
>>    StarFive JH7110 SoC includes support for multiple power domains which can be
>> @@ -17,6 +18,7 @@ properties:
>>    compatible:
>>      enum:
>>        - starfive,jh7110-pmu
>> +      - starfive,jh7110-pmu-dphy
> 
> You do here much more than commit msg says.
> 
> Isn'y DPHY a phy? Why is it in power?
> 

OK, I will add more description. This is a power framework used to turn on/off 
DPHY. So it in power, not a phy.

>>  
>>    reg:
>>      maxItems: 1
>> @@ -29,10 +31,18 @@ properties:
>>  
>>  required:
>>    - compatible
>> -  - reg
>> -  - interrupts
>>    - "#power-domain-cells"
>>  
>> +if:
> 
> Put it under allOf (in this place). Will save you one re-indentation later.
> 

OK, will fix it.

>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: starfive,jh7110-pmu
>> +then:
>> +  required:
>> +    - reg
>> +    - interrupts
>> +
>>  additionalProperties: false
>>  
>>  examples:
>> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt-bindings/power/starfive,jh7110-pmu.h
>> index 132bfe401fc8..0bfd6700c144 100644
>> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
>> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
>> @@ -14,4 +14,7 @@
>>  #define JH7110_PD_ISP		5
>>  #define JH7110_PD_VENC		6
>>  
>> +#define JH7110_PD_DPHY_TX	0
>> +#define JH7110_PD_DPHY_RX	1
>> +
>>  #endif
> 
> Best regards,
> Krzysztof
> 
