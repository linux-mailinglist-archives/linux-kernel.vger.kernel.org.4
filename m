Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C764B058
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiLMHVr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Dec 2022 02:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiLMHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:21:45 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60517E20;
        Mon, 12 Dec 2022 23:21:39 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3101E24E0D8;
        Tue, 13 Dec 2022 15:21:38 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Dec
 2022 15:21:38 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Dec
 2022 15:21:37 +0800
Message-ID: <26e9c3eb-aaeb-8cbd-dda0-20f28331dbeb@starfivetech.com>
Date:   Tue, 13 Dec 2022 15:21:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 2/3] mmc: starfive: Add sdio/emmc driver support
To:     Shawn Lin <shawn.lin@rock-chips.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-3-william.qiu@starfivetech.com>
 <faea4932-add6-fc51-836d-b113e8c9a194@rock-chips.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <faea4932-add6-fc51-836d-b113e8c9a194@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/13 10:24, Shawn Lin wrote:
> Hi
> 
> On 2022/12/7 21:17, William Qiu wrote:
>> Add sdio/emmc driver support for StarFive JH7110 soc.
>>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>   MAINTAINERS                        |   6 +
>>   drivers/mmc/host/Kconfig           |  10 ++
>>   drivers/mmc/host/Makefile          |   1 +
>>   drivers/mmc/host/dw_mmc-starfive.c | 197 +++++++++++++++++++++++++++++
>>   4 files changed, 214 insertions(+)
>>   create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>>
> 
> ...
> 
>> +
>> +static unsigned long dw_mci_starfive_caps[] = {
>> +    MMC_CAP_CMD23,
>> +    MMC_CAP_CMD23,
>> +    MMC_CAP_CMD23
>> +};
>> +
> 
> ....
> 
>> +    host->priv = priv;
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dw_mci_drv_data starfive_data = {
>> +    .caps = dw_mci_starfive_caps,
>> +    .num_caps = ARRAY_SIZE(dw_mci_starfive_caps),
> 
> use ".common_caps = MMC_CAP_CMD23" instead.
> 

Hi Shawn,

Thank you for taking time to review.
The .common_caps is not defined in dw_mci_drv_data.
And .num_caps is also used in dw_mci-rockchip.c.

Best regards,
William Qiu
>> +    .set_ios = dw_mci_starfive_set_ios,
>> +    .parse_dt = dw_mci_starfive_parse_dt,
>> +    .execute_tuning = dw_mci_starfive_execute_tuning,
>> +};
>> +
>> +static const struct of_device_id dw_mci_starfive_match[] = {
> 
