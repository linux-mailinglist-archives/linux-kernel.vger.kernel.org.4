Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4E6B0FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCHREC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCHRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:03:39 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8B38B46;
        Wed,  8 Mar 2023 09:02:38 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 328H1vjx018910;
        Wed, 8 Mar 2023 11:01:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678294917;
        bh=Rzhdyx4/bWaLNlhaP+DWfD17bwuJ+afLN2sYULYLQKI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EKUUO1WFLbEyQYR3mburZt281MOy7feMi7MHdl66XW6FMv03Ymhh2JX0A8SumNzti
         s+SANVBt5DyPm7IkJBqwAK1zbAgrNyF54Vl9l2VmO8x82efYBI9vn62C56b4DH5D51
         db4aNHSpnpjTPDlwJegpEF6uFBIMlx7X695wGHhI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 328H1vXJ026069
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 11:01:57 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 11:01:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 11:01:57 -0600
Received: from [10.247.19.40] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 328H1vQm002979;
        Wed, 8 Mar 2023 11:01:57 -0600
Message-ID: <b3820dd3-83dd-278e-e9ad-814be0bc8cfa@ti.com>
Date:   Wed, 8 Mar 2023 11:01:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] kbuild: Disallow DTB overlays to built from .dts named
 source files
Content-Language: en-US
To:     Nicolas Schier <nicolas@fjasle.eu>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230306224752.8417-1-afd@ti.com> <ZAi+Qo1z2OkrqncP@fjasle.eu>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZAi+Qo1z2OkrqncP@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 10:56 AM, Nicolas Schier wrote:
> On Mon, Mar 06, 2023 at 04:47:52PM -0600 Andrew Davis wrote:
>> As a follow up to the series allowing DTB overlays to built from .dtso
>> files. Now that all overlays have been renamed, remove the ability to
>> build from overlays from .dts files to prevent any files with the old
>          ^^^^
> 
> The first "from" sounds superfluous to me.
> 

It is a typo, feel free to drop it locally whoever takes this patch.

Thanks,
Andrew

> Kind regards,
> Nicolas
>> name from accidental being added.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   scripts/Makefile.lib | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 100a386fcd71..68d0134bdbf9 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -418,9 +418,6 @@ endif
>>   $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>>   	$(call if_changed_dep,dtb)
>>   
>> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>> -	$(call if_changed_dep,dtc)
>> -
>>   $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
>>   	$(call if_changed_dep,dtc)
>>   
>> -- 
>> 2.39.2
> 
