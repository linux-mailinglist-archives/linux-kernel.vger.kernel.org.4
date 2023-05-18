Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A715F707767
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjERBY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjERBY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:24:57 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43DE92;
        Wed, 17 May 2023 18:24:50 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D8C0F806C;
        Thu, 18 May 2023 09:24:42 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 09:24:42 +0800
Received: from [192.168.125.131] (113.72.146.100) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 09:24:42 +0800
Message-ID: <901dd93d-bd79-a62f-1ada-0328a5f04737@starfivetech.com>
Date:   Thu, 18 May 2023 09:22:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 08/10] reset: starfive: jh7110: Add StarFive
 STG/ISP/VOUT resets support
Content-Language: en-US
To:     Andreas Schwab <schwab@suse.de>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230424135409.6648-1-xingyu.wu@starfivetech.com>
 <20230424135409.6648-9-xingyu.wu@starfivetech.com> <mvmsfbvgkom.fsf@suse.de>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <mvmsfbvgkom.fsf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/17 21:19, Andreas Schwab wrote:
> On Apr 24 2023, Xingyu Wu wrote:
> 
>> @@ -58,6 +76,18 @@ static const struct auxiliary_device_id jh7110_reset_ids[] = {
>>  		.name = "clk_starfive_jh7110_sys.rst-aon",
>>  		.driver_data = (kernel_ulong_t)&jh7110_aon_info,
>>  	},
>> +	{
>> +		.name = "clk_starfive_jh7110_sys.rst-stg",
>> +		.driver_data = (kernel_ulong_t)&jh7110_stg_info,
>> +	},
>> +	{
>> +		.name = "clk_starfive_jh7110_sys.rst-isp",
>> +		.driver_data = (kernel_ulong_t)&jh7110_isp_info,
>> +	},
>> +	{
>> +		.name = "clk_starfive_jh7110_sys.rst-vout",
> 
> "clk_starfive_jh7110_sys.rst-vout" is exactly AUXILIARY_NAME_SIZE long,
> thus lacks a null termination.
> 

Yeah, it should be modified to "clk_starfive_jh7110_sys.rst-vo" in this and
use "rst-vo" instead of "rst-vout" in the probe of vout clock driver.
Then it will work.

Best regards,
Xingyu Wu
