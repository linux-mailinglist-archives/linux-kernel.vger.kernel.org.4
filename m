Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA8E61000A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiJ0SQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiJ0SQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:16:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7043678D;
        Thu, 27 Oct 2022 11:16:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29RIGLH0037720;
        Thu, 27 Oct 2022 13:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666894581;
        bh=/zj3g63JhQDHegIxQO0BLz+KSVsmlonxodsKrtWMvcg=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=lfPMG+cvYIxoBAkM0+DXQherZgSGwsW8587eLYBmme9zo/1pZdp0ikE3G8S7zzXVC
         64Sn9Bd0aIN0QcrQVf8elePQQ2/TFFmGX9J8ybdc9sa4RcyRQWFEpwulUQPQ0iOq6J
         w+MTVAMjfeCBb+iLvJdakUtmjHtath07zeMikDXM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29RIGLfJ067267
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 13:16:21 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 13:16:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 13:16:21 -0500
Received: from [10.250.35.234] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29RIGKXe112488;
        Thu, 27 Oct 2022 13:16:20 -0500
Message-ID: <e25a5f89-42bb-f97b-4b84-e7609ee00139@ti.com>
Date:   Thu, 27 Oct 2022 13:16:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] ARM: nspire: Use syscon-reboot to handle restart
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026161302.5319-1-afd@ti.com>
 <20221026161302.5319-2-afd@ti.com>
 <9314a458-0fd9-c645-bb55-5f28b961ea5f@linaro.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <9314a458-0fd9-c645-bb55-5f28b961ea5f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 3:17 PM, Krzysztof Kozlowski wrote:
> On 26/10/2022 12:13, Andrew Davis wrote:
>> Writing this bit can be handled by the syscon-reboot driver. Add the
>> info to DT and remove the machine_desc version.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>   arch/arm/boot/dts/nspire.dtsi |  7 +++++++
> 
> DTS cannot go with code.
> 
> Additionally, this breaks people's filtering as there is no "dts" prefix
> in the subject.
> 
>>   arch/arm/mach-nspire/Kconfig  |  2 ++
>>   arch/arm/mach-nspire/mmio.h   |  3 ---
>>   arch/arm/mach-nspire/nspire.c | 10 ----------
>>   4 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
>> index bb240e6a3a6f..6357b803521e 100644
>> --- a/arch/arm/boot/dts/nspire.dtsi
>> +++ b/arch/arm/boot/dts/nspire.dtsi
>> @@ -172,7 +172,14 @@ rtc: rtc@90090000 {
>>   			};
>>   
>>   			misc: misc@900a0000 {
>> +				compatible = "syscon", "simple-mfd";
> 
> These are not allowed on their own (need specific compatible) and you
> should have warnings when running dtbs_check.
> 

Ah, my bad, must have gotten lost in the other existing warnings.
Sent v3 with the above fixes, and tried to remove some existing warnings.

Thanks,
Andrew

> Best regards,
> Krzysztof
> 
