Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60107747506
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjGDPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGDPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:12:18 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E1D10D7;
        Tue,  4 Jul 2023 08:12:15 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6C5A8120056;
        Tue,  4 Jul 2023 18:12:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6C5A8120056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688483534;
        bh=MA18R4ahtdeUwMRF3ebCu6zn0dDacp0s1VVqqmBwV7Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=ox8qOlaWTO8rk6r8RAc4KQBGMVACKzKeKwGKI6jM7Kv5RRfT17BTQ+1c9yBuy9W14
         IeLclQ8lh53wRx/JOx/BwldRfCUosLgN6qQEn7b5xXoYE7kshmUk6krtUbrVFgZGQO
         bi4KRSYGk/t1LU6nQuSTxdQVgfSdBK+evbkPGkfCjWOMz0URwIBa33UoVApW08J1ud
         kTkM/Vp0rleXvbS/Z2w4vdzKbtrLhNkzzIoJBn1ax+2vS02kAJZgcIsMeDkItiSofo
         qzCr3j+AiHAXV49Kui+LjuoqIYqRPGMQ4rYWudYnLkyZXlF0qcxXkqOYRLAoINe6Ty
         s3DkJQInq4KXQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 18:12:14 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 18:12:03 +0300
Message-ID: <e45afb19-d77b-6ef3-08bf-68e8626371be@sberdevices.ru>
Date:   Tue, 4 Jul 2023 18:07:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v1 2/2] mtd: rawnand: meson: support for 512B ECC step
 size
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
 <20230628092937.538683-3-AVKrasnov@sberdevices.ru>
 <20230704103617.4affae8a@xps-13>
 <9e6eaa87-887c-f955-113a-43860c8ea00c@sberdevices.ru>
 <20230704114110.25ca9de4@xps-13>
 <aede4639-0e99-565a-c997-c414342c66af@sberdevices.ru>
 <20230704115628.55320428@xps-13>
 <ee2eb73a-fb25-58ae-cf7e-83d971b7b8b2@sberdevices.ru>
 <20230704154106.5c5aafd8@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230704154106.5c5aafd8@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178426 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 05:54:00 #21559896
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.07.2023 16:41, Miquel Raynal wrote:
> Hi Arseniy,
> 
>>>>>> Yes, this code looks strange. 'nsectors' is used to calculate space in OOB
>>>>>> that could be used by ECC engine (this value will be passed as 'oobavail'
>>>>>> to 'nand_ecc_choose_conf()'). Idea of 512 is to consider "worst" case
>>>>>> for ECC, e.g. minimal number of bytes for ECC engine (and at the same time
>>>>>> maximum number of free bytes). For Meson, if ECC step size is 512, then we
>>>>>> have 4 x 2 free bytes in OOB (if step size if 1024 then we have 2 x 2 free
>>>>>> bytes in OOB).
>>>>>>
>>>>>> I think this code could be reworked in the following way:
>>>>>>
>>>>>> if ECC step size is already known here (from DTS), calculate 'nsectors' using
>>>>>> given value (div by 512 for example). Otherwise calculate 'nsectors' in the
>>>>>> current manner:    
>>>>>
>>>>> It will always be known when these function are run. There is no
>>>>> guessing here.    
>>>>
>>>> Hm I checked, that but if step size is not set in DTS, here it will be 0, 
>>>> then it will be selected in 'nand_ecc_choose_conf()' according provided 'ecc_caps'
>>>> and 'oobavail'...
>>>>
>>>> Anyway, I'll do the following thing:
>>>>
>>>> int nsectors;
>>>>
>>>> if (nand->ecc.size)
>>>>     nsectors = mtd->writesize / nand->ecc.size; <--- this is for 512 ECC  
>>>
>>> You should set nand->ecc.size in ->attach_chip() instead.  
>>
>> Sorry, didn't get it... if ECC step size is set in DTS, then here, in chip attach
>> callback it will be already known (DT part was processed in 'rawnand_dt_init()').
>> If ECC step size is unknown (e.g. 0 here), 'nand_ecc_choose_conf()' will set it
>> according provided ecc caps. What do You mean for "You should set ..." ?
> 
> The current approach is wrong, it decides the number of ECC chunks
> (called nsectors in the driver) and then asks the core to decide the
> number of ECC chunks to use.

Yes! I was also confused about that.

> 
> Just provide mtd->oobsize - 2 as last parameter and then rely on the
> core's logic to find the right ECC step-size/strength?
> 
> There is no point in requesting a particular step size without a
> specific strength, or? So I believe you should provide both in the DTS
> if you want particular parameters to be applied, otherwise you can let
> the core decide what is best.

So I think this could be a separated patch as it doesn't rely on 512 step size ECC
support for Meson and may be it should be "Fix" tagged.

Thanks, Arseniy

> 
> Thanks,
> Miquèl
