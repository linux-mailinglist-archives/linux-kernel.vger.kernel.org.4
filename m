Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7413747DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGEHFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGEHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:05:15 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDC5170E;
        Wed,  5 Jul 2023 00:05:04 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0E8CA7FFD;
        Wed,  5 Jul 2023 15:04:57 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Jul
 2023 15:04:57 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Jul
 2023 15:04:56 +0800
Message-ID: <90b55926-1d0c-b9c0-3020-5837e2028809@starfivetech.com>
Date:   Wed, 5 Jul 2023 15:04:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-3-william.qiu@starfivetech.com>
 <808dac44-a72c-4675-1e4a-0ed96190efb4@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <808dac44-a72c-4675-1e4a-0ed96190efb4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/5 14:21, Krzysztof Kozlowski wrote:
> On 04/07/2023 11:04, William Qiu wrote:
>> Add QSPI clock operation in device probe.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@intel.com/
>> Reported-by: Julia Lawall <julia.lawall@inria.fr>
>> Closes: https://lore.kernel.org/r/202306040644.6ZHs55x4-lkp@intel.com/
> 
> 
>>  
>> @@ -1840,6 +1858,8 @@ static int cqspi_resume(struct device *dev)
>>  	struct spi_master *master = dev_get_drvdata(dev);
>>  
>>  	clk_prepare_enable(cqspi->clk);
>> +	if (of_device_is_compatible(dev->of_node, "starfive,jh7110-qspi"))
> 
> Don't add compatible checks inside the code. It does not scale. We
> expect compatibles to be listed only in one place - of_device_id - and
> customize driver with match data / quirks / flags.
> 
> Comment applies to all your diff hunks.
> 
I'll use "of_device_get_match_data" to replace it. But the way I added
reset before is also by compatible checks. Should I change this place to 
"of_device_get_match_data" as well?
>> +		clk_bulk_prepare_enable(cqspi->num_clks, cqspi->clks);
>>  	cqspi_wait_idle(cqspi);
>>  	cqspi_controller_init(cqspi);
>>  
> 
> Best regards,
> Krzysztof
> 
