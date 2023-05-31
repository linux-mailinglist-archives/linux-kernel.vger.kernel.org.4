Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605457176BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjEaGTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEaGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:19:24 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4A9F;
        Tue, 30 May 2023 23:19:20 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DEEC224DDBE;
        Wed, 31 May 2023 14:19:17 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 31 May
 2023 14:19:17 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 31 May
 2023 14:19:16 +0800
Message-ID: <93ba0b97-45aa-e59d-1454-80c4f245acc0@starfivetech.com>
Date:   Wed, 31 May 2023 14:19:16 +0800
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
 <042c560d-1f36-8e97-3796-7423245592f4@starfivetech.com>
 <86555925-b8dd-29a8-60cd-5c2ff2c1432a@starfivetech.com>
 <eb68722b-bcab-4aa1-aa4e-54bfe95ef414@sirena.org.uk>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <eb68722b-bcab-4aa1-aa4e-54bfe95ef414@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
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



On 2023/5/30 18:33, Mark Brown wrote:
> On Tue, May 30, 2023 at 10:05:38AM +0800, William Qiu wrote:
>> On 2023/5/29 14:44, William Qiu wrote:
>> > On 2023/5/26 23:36, Mark Brown wrote:
> 
>> >> Nothing ever disables or unprepares this clock as far as I can tell?
>> >> Perhaps also consider using the clk_bulk_ APIs.
> 
>> > I will add in next version.
> 
>> 	Now I want to replace the original devm_clk_get API in the
>> driver with devm_clk_bulk_get_all API, which can achieve compatibility,
>> but it seems that it is not good for other ip with only one clock, so I
>> want to ask about that can I replace it? Or define that inside jh7110?
> 
> You could always specify a different array of clocks depending on which
> compatible the driver sees, just like you'd conditionally request clocks
> individually.
Hi Mark,

	If specify a different array of clocks depending on which compatible
the driver sees, since there will also be clock operations in the suspend
and resume interfaces, this can make the code look complicated.
	My thoughts are as follows:
	Modify the following code

1658	/* Obtain QSPI clock. */
1659	cqspi->clk = devm_clk_get(dev, NULL);
1660	if (IS_ERR(cqspi->clk)) {
1661		dev_err(dev, "Cannot claim QSPI clock.\n");
1662		ret = PTR_ERR(cqspi->clk);
1663		return ret;
1664	}

	as following:

	/* Obtain QSPI clock. */
	cqspi->num_clks = devm_clk_bulk_get_all(dev, &cqspi->clks);
	if (cqspi->num_clks < 0) {
		dev_err(dev, "Cannot claim QSPI clock: %u\n", cqspi->num_clks);
		return -EINVAL;
	}

	This way, the code will look simpler and clearer. How do you think
about it.

Best Regards,
William
