Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA8703490
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbjEOQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbjEOQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:49:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB759F7;
        Mon, 15 May 2023 09:49:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FGmqCT058261;
        Mon, 15 May 2023 11:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684169332;
        bh=WYd+HVrvnZqOOIEZzprHDBIRRRbxOwfly0aIcgGcCPA=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=iiIiWjd7bc5jfMNHn2gZH4rUNBemTTyTqFNwW5TrplB4d93zNHJmg9L5XmOXrCSyB
         NJM9CxisGQmSs98u5njB+dhQbgsMmfXUli6ppu4ekI/ToTedMgefrQg454VOhnzXJB
         NlzUp9YAG6j2UzNXCS1p4gObu0QRHepNt121fSLk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FGmq5t085842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:48:52 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:48:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:48:52 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FGmpJV101621;
        Mon, 15 May 2023 11:48:51 -0500
Message-ID: <1118291b-1137-6368-6202-e54151f01eb0@ti.com>
Date:   Mon, 15 May 2023 11:48:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] kbuild: Disallow DTB overlays to built from .dts named
 source files
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
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
 <b3820dd3-83dd-278e-e9ad-814be0bc8cfa@ti.com>
In-Reply-To: <b3820dd3-83dd-278e-e9ad-814be0bc8cfa@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 9:01 AM, Andrew Davis wrote:
> On 3/8/23 10:56 AM, Nicolas Schier wrote:
>> On Mon, Mar 06, 2023 at 04:47:52PM -0600 Andrew Davis wrote:
>>> As a follow up to the series allowing DTB overlays to built from .dtso
>>> files. Now that all overlays have been renamed, remove the ability to
>>> build from overlays from .dts files to prevent any files with the old
>>          ^^^^
>>
>> The first "from" sounds superfluous to me.
>>
> 
> It is a typo, feel free to drop it locally whoever takes this patch.
> 

Seems no one took this last cycle.. Still valid and applies for this one.

Andrew

> Thanks,
> Andrew
> 
>> Kind regards,
>> Nicolas
>>> name from accidental being added.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   scripts/Makefile.lib | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>> index 100a386fcd71..68d0134bdbf9 100644
>>> --- a/scripts/Makefile.lib
>>> +++ b/scripts/Makefile.lib
>>> @@ -418,9 +418,6 @@ endif
>>>   $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>>>       $(call if_changed_dep,dtb)
>>> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>>> -    $(call if_changed_dep,dtc)
>>> -
>>>   $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
>>>       $(call if_changed_dep,dtc)
>>> -- 
>>> 2.39.2
>>
