Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B806DEC01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDLGmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDLGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:42:50 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB4359FC;
        Tue, 11 Apr 2023 23:42:46 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CE4CB7F98;
        Wed, 12 Apr 2023 14:42:43 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:42:43 +0800
Received: from [192.168.125.82] (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:42:42 +0800
Message-ID: <1e3e917a-17ff-2a06-e127-e0d43b731301@starfivetech.com>
Date:   Wed, 12 Apr 2023 14:42:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 4/7] soc: starfive: Add pmu type operation
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
 <20230411064743.273388-5-changhuang.liang@starfivetech.com>
 <20230411-flavoring-sternness-a3b6cdee9fcb@spud>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230411-flavoring-sternness-a3b6cdee9fcb@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 4:52, Conor Dooley wrote:
> Hey Changhuang Liang,
> 
> On Mon, Apr 10, 2023 at 11:47:40PM -0700, Changhuang Liang wrote:
>> Add pmu type, make a distinction between different PMU.
> 
> Please write more detailed commit messages, thanks.
> 

OK, will write more detail for it.

>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>  drivers/soc/starfive/jh71xx_pmu.c | 55 ++++++++++++++++++++++---------
>>  1 file changed, 39 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
>> index 306218c83691..98f6849d61de 100644
>> --- a/drivers/soc/starfive/jh71xx_pmu.c
>> +++ b/drivers/soc/starfive/jh71xx_pmu.c
>> @@ -45,6 +45,12 @@
>>   */
>>  #define JH71XX_PMU_TIMEOUT_US		100
>>  
>> +/* pmu type */
> 
> Delete this comment, it's obvious.
> 

OK, will delete this line.

>> +enum pmu_type {
>> +	JH71XX_PMU_GENERAL,
> 
> I'm really not sold on GENERAL as a name.
> Why not name these after the compatibles?
>

OK, will change to "JH71XX_PMU".
 
>> +	JH71XX_PMU_DPHY,
>> +};
>> +
>>  struct jh71xx_domain_info {
>>  	const char * const name;
>>  	unsigned int flags;
>> @@ -54,6 +60,7 @@ struct jh71xx_domain_info {
>>  struct jh71xx_pmu_match_data {
>>  	const struct jh71xx_domain_info *domain_info;
>>  	int num_domains;
>> +	u8 pmu_type;
> 
> This is an enum, not a u8?
> 

OK, will fix it.

> Thanks,
> Conor.
> 
