Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17438715369
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjE3CHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjE3CG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:06:59 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321ED1B4;
        Mon, 29 May 2023 19:06:26 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B3D2424E271;
        Tue, 30 May 2023 10:05:39 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 30 May
 2023 10:05:39 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 30 May
 2023 10:05:39 +0800
Message-ID: <86555925-b8dd-29a8-60cd-5c2ff2c1432a@starfivetech.com>
Date:   Tue, 30 May 2023 10:05:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
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
 <042c560d-1f36-8e97-3796-7423245592f4@starfivetech.com>
In-Reply-To: <042c560d-1f36-8e97-3796-7423245592f4@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/29 14:44, William Qiu wrote:
> 
> 
> On 2023/5/26 23:36, Mark Brown wrote:
>> On Fri, May 26, 2023 at 02:25:28PM +0800, William Qiu wrote:
>> 
>>>  	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
>>> +		qspi_ahb = devm_clk_get(dev, "qspi-ahb");
>>> +		if (IS_ERR(qspi_ahb)) {
>>> +			dev_err(dev, "Cannot claim QSPI_AHB clock.\n");
>>> +			ret = PTR_ERR(qspi_ahb);
>>> +			return ret;
>>> +		}
>>> +
>>> +		ret = clk_prepare_enable(qspi_ahb);
>>> +		if (ret) {
>>> +			dev_err(dev, "Cannot enable QSPI AHB clock.\n");
>>> +			goto probe_clk_failed;
>>> +		}
>> 
>> Nothing ever disables or unprepares this clock as far as I can tell?
>> Perhaps also consider using the clk_bulk_ APIs.
> 
> I will add in next version.
> 
> Thanks for taking time to review this patch series and give useful
> suggestions.
> 
> Best regards,
> William

Hi Mark,

	Now I want to replace the original devm_clk_get API in the
driver with devm_clk_bulk_get_all API, which can achieve compatibility,
but it seems that it is not good for other ip with only one clock, so I
want to ask about that can I replace it? Or define that inside jh7110?

Best regards,
William
