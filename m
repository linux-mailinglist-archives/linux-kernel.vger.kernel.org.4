Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103CB714516
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjE2Gp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjE2GpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:45:04 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1164F90;
        Sun, 28 May 2023 23:45:03 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A62D380C4;
        Mon, 29 May 2023 14:45:01 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 14:45:01 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 14:45:01 +0800
Message-ID: <042c560d-1f36-8e97-3796-7423245592f4@starfivetech.com>
Date:   Mon, 29 May 2023 14:44:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
 <20230526062529.46747-3-william.qiu@starfivetech.com>
 <fecc9d6a-022e-49d9-a452-8a63c409ebf3@sirena.org.uk>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <fecc9d6a-022e-49d9-a452-8a63c409ebf3@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 23:36, Mark Brown wrote:
> On Fri, May 26, 2023 at 02:25:28PM +0800, William Qiu wrote:
> 
>>  	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
>> +		qspi_ahb = devm_clk_get(dev, "qspi-ahb");
>> +		if (IS_ERR(qspi_ahb)) {
>> +			dev_err(dev, "Cannot claim QSPI_AHB clock.\n");
>> +			ret = PTR_ERR(qspi_ahb);
>> +			return ret;
>> +		}
>> +
>> +		ret = clk_prepare_enable(qspi_ahb);
>> +		if (ret) {
>> +			dev_err(dev, "Cannot enable QSPI AHB clock.\n");
>> +			goto probe_clk_failed;
>> +		}
> 
> Nothing ever disables or unprepares this clock as far as I can tell?
> Perhaps also consider using the clk_bulk_ APIs.

I will add in next version.

Thanks for taking time to review this patch series and give useful
suggestions.

Best regards,
William
