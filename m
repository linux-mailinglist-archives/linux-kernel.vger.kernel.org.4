Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B187235C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjFFDe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFFDeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:34:25 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A0311B;
        Mon,  5 Jun 2023 20:34:23 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 665C68155;
        Tue,  6 Jun 2023 11:34:16 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 11:34:16 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 11:34:15 +0800
Message-ID: <39ff6f3f-4713-3864-4325-3dbde811a220@starfivetech.com>
Date:   Tue, 6 Jun 2023 11:34:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230602084925.215411-1-william.qiu@starfivetech.com>
 <20230602084925.215411-2-william.qiu@starfivetech.com>
 <20230602-impurity-broker-28cc27869b64@spud>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20230602-impurity-broker-28cc27869b64@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
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



On 2023/6/3 2:02, Conor Dooley wrote:
> On Fri, Jun 02, 2023 at 04:49:23PM +0800, William Qiu wrote:
>> The QSPI controller needs three clock items to work properly on StarFive
>> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
>> platforms do not have this constraint.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml    | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> index b310069762dd..b6a27171d965 100644
>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -26,6 +26,15 @@ allOf:
>>              const: starfive,jh7110-qspi
>>      then:
>>        properties:
>> +        clocks:
>> +          maxItems: 3
>> +
>> +        clock-names:
>> +          items:
>> +            - const: ref_clk
> 
> Aww, I liked Mark's suggestions better.
> If you are respinning to fix the LKP reported issue w/ ignoring the result
> of enabling the clocks, could you chop the _clk off of this one?
> 
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.

Hi Conor,

Thanks for taking time to review this patch series.
About the clock name, I would take Mark's suggestions, and will update it in
next version.

Best regards,
William
