Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DCB6E8AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjDTHKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjDTHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:10:53 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B099E76;
        Thu, 20 Apr 2023 00:10:49 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 09E7A24E270;
        Thu, 20 Apr 2023 15:10:47 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Apr
 2023 15:10:46 +0800
Received: from [192.168.125.89] (113.72.144.253) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Apr
 2023 15:10:45 +0800
Message-ID: <6ce407ab-0d2a-323f-61df-44b2ed8eb0ca@starfivetech.com>
Date:   Thu, 20 Apr 2023 15:10:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add cpu scaling for JH7110
 SoC
To:     Conor Dooley <conor@kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230417063942.3141-1-mason.huo@starfivetech.com>
 <20230417063942.3141-4-mason.huo@starfivetech.com>
 <20230418-talcum-unthread-618a5bd2758a@spud>
Content-Language: en-US
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230418-talcum-unthread-618a5bd2758a@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/19 1:28, Conor Dooley wrote:
> Hey Mason,
> 
> Just one minor comment in passing..
> 
> On Mon, Apr 17, 2023 at 02:39:42PM +0800, Mason Huo wrote:
>> Add the operating-points-v2 to support cpu scaling on StarFive JH7110 SoC.
>> It supports up to 4 cpu frequency loads.
>> 
>> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-2.dtsi         | 17 ++++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 33 +++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index cca1c8040801..b25e6d68ce53 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -227,3 +227,20 @@ &uart0 {
>>  	pinctrl-0 = <&uart0_pins>;
>>  	status = "okay";
>>  };
>> +
>> +&U74_1 {
>> +	cpu-supply = <&vdd_cpu>;
>> +};
>> +
>> +&U74_2 {
>> +	cpu-supply = <&vdd_cpu>;
>> +};
>> +
>> +&U74_3 {
>> +	cpu-supply = <&vdd_cpu>;
>> +};
>> +
>> +&U74_4 {
>> +	cpu-supply = <&vdd_cpu>;
>> +};
>> +
> 
> Applying: riscv: dts: starfive: Add cpu scaling for JH7110 SoC
> /stuff/linux/.git/rebase-apply/patch:30: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> 
> Cheers,
> Conor.
> 
Hi Conor,

Will fix it soon.

Thanks
Mason
