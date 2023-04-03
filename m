Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE836D3D5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjDCGbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDCGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:31:39 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A963172B;
        Sun,  2 Apr 2023 23:31:36 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7C1C224E290;
        Mon,  3 Apr 2023 14:31:29 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 14:31:29 +0800
Received: from [192.168.125.82] (183.27.97.179) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 14:31:28 +0800
Message-ID: <b07842e4-54cc-873e-3140-4a933e054802@starfivetech.com>
Date:   Mon, 3 Apr 2023 14:31:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] phy: starfive: Add mipi dphy rx support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <20230223015952.201841-3-changhuang.liang@starfivetech.com>
 <ZBhTmTEcrV59oaw3@matsya>
 <2aa1bdbd-e37e-941a-9422-0908545c14f7@starfivetech.com>
 <ZCbloBdeffocT3Os@matsya>
 <d48ab612-213a-8d20-4b36-3f64f3d24721@starfivetech.com>
 <0dd5e35b-512e-41ed-af33-f94b7e2868c1@spud>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <0dd5e35b-512e-41ed-af33-f94b7e2868c1@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/3 14:24, Conor Dooley wrote:
> On Mon, Apr 03, 2023 at 09:39:00AM +0800, Changhuang Liang wrote:
>> On 2023/3/31 21:52, Vinod Koul wrote:
>>> On 21-03-23, 14:08, Changhuang Liang wrote:
>>>> On 2023/3/20 20:37, Vinod Koul wrote:
>>>>> On 22-02-23, 17:59, Changhuang Liang wrote:
>>>>>> [...]
>>>>>> +static const struct regval_t stf_dphy_init_list[] = {
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(4), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(8), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(12), 0x0000fff0 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(16), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(20), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(24), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(28), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(32), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(36), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(40), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(40), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(48), 0x24000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(52), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(56), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(60), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(64), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(68), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(72), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(76), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(80), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(84), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(88), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(92), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(96), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(100), 0x02000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(104), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(108), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(112), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(116), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(120), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(124), 0x0000000c },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(128), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(132), 0xcc500000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(136), 0x000000cc },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(140), 0x00000000 },
>>>>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(144), 0x00000000 },
>>>>>> +};
>>>>>> +
>>>>>> +static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
>>>>>> +{
>>>>>> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
>>>>>> +	int map[6] = {4, 0, 1, 2, 3, 5};
>>>>>
>>>>> what does this mean?
>>>>
>>>> This is the physical lane and logical lane mapping table, should I add a note for it?
>>>
>>> Yes please. Also will the mapping be always static or ever change?
>>>  
>>
>> The mapping is always static on the visionfive2 single board computer.
>> Thanks for your comments.
> 
> What about other boards featuring a JH7110?

maybe add this mapping in the device tree, we just need to parse the device tree is better.
