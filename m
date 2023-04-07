Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B16DA926
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjDGG6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDGG6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:58:52 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087817DBF;
        Thu,  6 Apr 2023 23:58:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B52D424E2EE;
        Fri,  7 Apr 2023 14:58:49 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 14:58:50 +0800
Received: from [192.168.125.82] (183.27.97.179) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 14:58:48 +0800
Message-ID: <5dc4ddc2-9d15-ebb2-38bc-8a544ca67e0d@starfivetech.com>
Date:   Fri, 7 Apr 2023 14:58:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
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
References: <20230315100421.133428-1-changhuang.liang@starfivetech.com>
 <20230315100421.133428-2-changhuang.liang@starfivetech.com>
 <20230320151437.GA1709620-robh@kernel.org>
 <fa13e903-809d-064f-baff-c7e7474b52da@starfivetech.com>
 <06a17138-cccc-1283-d235-fa54275c1651@kernel.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <06a17138-cccc-1283-d235-fa54275c1651@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/7 14:54, Krzysztof Kozlowski wrote:
> On 07/04/2023 08:51, Changhuang Liang wrote:
>>>> +
>>>> +  resets:
>>>> +    items:
>>>> +      - description: DPHY_HW reset
>>>> +      - description: DPHY_B09_ALWAYS_ON reset
>>>> +
>>>> +  starfive,aon-syscon:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    items:
>>>> +      - items:
>>>> +          - description: phandle of AON SYSCON
>>>> +          - description: register offset
>>>> +    description: The power of dphy rx is configured by AON SYSCON
>>>> +      in this property.
>>>
>>> Sounds like AON SYSCON should be a power-domains provider. Custom 
>>> phandle links are for things which don't fit standard bindings.
>>>
>>
>> Hi, Rob,
>>
>> On visionfive2 jh7110 SoC, this AON SYSCON is the Secondary power switch to the DPHY Rx.
>> When we open the pmic switch, we also need to configure the AON SYSCON register to turn 
>> on the switch, it is used to link the pmic and the DPHY Rx, So I think it just use syscon
>> framework is enought. What about your comments.
> 
> Which sounds exactly like power domain provider...
> 

OK, thanks for your comment, I will try to use power domain framework in next patch.

> Best regards,
> Krzysztof
> 
