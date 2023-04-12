Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF206DEB89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLGIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLGIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:08:01 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653E6B8;
        Tue, 11 Apr 2023 23:07:57 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 703CC24E196;
        Wed, 12 Apr 2023 14:07:54 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:07:54 +0800
Received: from [192.168.125.109] (113.72.145.176) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:07:53 +0800
Message-ID: <eeb7dadb-1cfd-d270-158b-5dd2e5f2bd1a@starfivetech.com>
Date:   Wed, 12 Apr 2023 14:07:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 5/7] soc: starfive: Use call back to parse device tree
 resources
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-6-changhuang.liang@starfivetech.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230411064743.273388-6-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 14:47, Changhuang Liang wrote:
> Different compatible parse device tree resources work in different ways.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

I don't think it's necessary to submit multiple patches separately for the same .c file
unless it is very necessary. Because the disadvantage of separating multiple patches 
is that some information lacks completeness and coherence.

> ---
>  drivers/soc/starfive/jh71xx_pmu.c | 54 ++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
> index 98f6849d61de..990db6735c48 100644
> --- a/drivers/soc/starfive/jh71xx_pmu.c
> +++ b/drivers/soc/starfive/jh71xx_pmu.c
> @@ -57,10 +57,14 @@ struct jh71xx_domain_info {
>  	u8 bit;
>  };
>  
> +struct jh71xx_pmu;
> +
>  struct jh71xx_pmu_match_data {
>  	const struct jh71xx_domain_info *domain_info;
>  	int num_domains;
>  	u8 pmu_type;
> +	int (*pmu_parse_dt)(struct platform_device *pdev,
> +			    struct jh71xx_pmu *pmu);
>  };
>  
>  struct jh71xx_pmu {
> @@ -251,6 +255,31 @@ static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int jh7110_pmu_general_parse_dt(struct platform_device *pdev,
> +				       struct jh71xx_pmu *pmu)
> +{


