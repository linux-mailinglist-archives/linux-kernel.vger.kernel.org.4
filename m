Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8029B746E95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGDK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGDK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:26:39 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BA18D;
        Tue,  4 Jul 2023 03:26:29 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 97D8C100061;
        Tue,  4 Jul 2023 13:26:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 97D8C100061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688466387;
        bh=tCA/VjPpfkK2yojMVa3HrJf75D4zZdCMfmdCF4LawF4=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=Qci3fecCVE7EdZqWTrNIb/U4XV93APT3cNz9rT7NLJeryBUsMLgLGYBFWs6jeIrXI
         Qj4Whu+1hNU/bn54YmHUQTdy5+yZqMg1qrmdPBgWmdx9M9Y8Ly94P4ahpiZ2He+V7i
         khRho2v/XWVpIbYjUCxb74kf6slFRjLoQ9rJo/j5Yj1L2hVhbyADF5bF/oZQOWaJNl
         9lNbHTMegbYVuh/MNQtvpVlujTM1KkJHhL5hCTMunBAXBCpjrqBmVk/Q4D4LwskAmo
         TD7g8s5i9h5vMIPVacq+mSQd6tq72j9mOx8j2mXD+7s9RcZGBqQ1qeyhWpt8bWm3QT
         Q/BiSN2qaOabw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 13:26:27 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 13:26:17 +0300
Message-ID: <ee2eb73a-fb25-58ae-cf7e-83d971b7b8b2@sberdevices.ru>
Date:   Tue, 4 Jul 2023 13:21:17 +0300
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
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230704115628.55320428@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178415 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
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



On 04.07.2023 12:56, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Tue, 4 Jul 2023 12:46:51 +0300:
> 
>> On 04.07.2023 12:41, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@sberdevices.ru wrote on Tue, 4 Jul 2023 12:23:03 +0300:
>>>   
>>>> On 04.07.2023 11:36, Miquel Raynal wrote:  
>>>>> Hi Arseniy,
>>>>>
>>>>> AVKrasnov@sberdevices.ru wrote on Wed, 28 Jun 2023 12:29:36 +0300:
>>>>>     
>>>>>> Meson NAND supports both 512B and 1024B ECC step size.
>>>>>>
>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>> ---
>>>>>>  drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++--------
>>>>>>  1 file changed, 35 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> index 345212e8c691..6cc4f63b86c8 100644
>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> @@ -135,6 +135,7 @@ struct meson_nfc_nand_chip {
>>>>>>  struct meson_nand_ecc {
>>>>>>  	u32 bch;
>>>>>>  	u32 strength;
>>>>>> +	u32 size;
>>>>>>  };
>>>>>>  
>>>>>>  struct meson_nfc_data {
>>>>>> @@ -190,7 +191,8 @@ struct meson_nfc {
>>>>>>  };
>>>>>>  
>>>>>>  enum {
>>>>>> -	NFC_ECC_BCH8_1K		= 2,
>>>>>> +	NFC_ECC_BCH8_512	= 1,
>>>>>> +	NFC_ECC_BCH8_1K,
>>>>>>  	NFC_ECC_BCH24_1K,
>>>>>>  	NFC_ECC_BCH30_1K,
>>>>>>  	NFC_ECC_BCH40_1K,
>>>>>> @@ -198,15 +200,16 @@ enum {
>>>>>>  	NFC_ECC_BCH60_1K,
>>>>>>  };
>>>>>>  
>>>>>> -#define MESON_ECC_DATA(b, s)	{ .bch = (b),	.strength = (s)}
>>>>>> +#define MESON_ECC_DATA(b, s, sz)	{ .bch = (b), .strength = (s), .size = (sz) }
>>>>>>  
>>>>>>  static struct meson_nand_ecc meson_ecc[] = {
>>>>>> -	MESON_ECC_DATA(NFC_ECC_BCH8_1K, 8),
>>>>>> -	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24),
>>>>>> -	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30),
>>>>>> -	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40),
>>>>>> -	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50),
>>>>>> -	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60),
>>>>>> +	MESON_ECC_DATA(NFC_ECC_BCH8_512, 8,  512),
>>>>>> +	MESON_ECC_DATA(NFC_ECC_BCH8_1K,  8,  1024),
>>>>>> +	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24, 1024),
>>>>>> +	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30, 1024),
>>>>>> +	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40, 1024),
>>>>>> +	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50, 1024),
>>>>>> +	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60, 1024),
>>>>>>  };
>>>>>>  
>>>>>>  static int meson_nand_calc_ecc_bytes(int step_size, int strength)
>>>>>> @@ -224,8 +227,27 @@ static int meson_nand_calc_ecc_bytes(int step_size, int strength)
>>>>>>  
>>>>>>  NAND_ECC_CAPS_SINGLE(meson_gxl_ecc_caps,
>>>>>>  		     meson_nand_calc_ecc_bytes, 1024, 8, 24, 30, 40, 50, 60);
>>>>>> -NAND_ECC_CAPS_SINGLE(meson_axg_ecc_caps,
>>>>>> -		     meson_nand_calc_ecc_bytes, 1024, 8);
>>>>>> +
>>>>>> +static const int axg_stepinfo_strengths[] = { 8 };
>>>>>> +static const struct nand_ecc_step_info axg_stepinfo_1024 = {
>>>>>> +	.stepsize = 1024,
>>>>>> +	.strengths = axg_stepinfo_strengths,
>>>>>> +	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
>>>>>> +};
>>>>>> +
>>>>>> +static const struct nand_ecc_step_info axg_stepinfo_512 = {
>>>>>> +	.stepsize = 512,
>>>>>> +	.strengths = axg_stepinfo_strengths,
>>>>>> +	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
>>>>>> +};
>>>>>> +
>>>>>> +static const struct nand_ecc_step_info axg_stepinfo[] = { axg_stepinfo_1024, axg_stepinfo_512 };
>>>>>> +
>>>>>> +static const struct nand_ecc_caps meson_axg_ecc_caps = {
>>>>>> +	.stepinfos = axg_stepinfo,
>>>>>> +	.nstepinfos = ARRAY_SIZE(axg_stepinfo),
>>>>>> +	.calc_ecc_bytes = meson_nand_calc_ecc_bytes,
>>>>>> +};
>>>>>>  
>>>>>>  static struct meson_nfc_nand_chip *to_meson_nand(struct nand_chip *nand)
>>>>>>  {
>>>>>> @@ -1259,7 +1281,8 @@ static int meson_nand_bch_mode(struct nand_chip *nand)
>>>>>>  		return -EINVAL;
>>>>>>  
>>>>>>  	for (i = 0; i < ARRAY_SIZE(meson_ecc); i++) {
>>>>>> -		if (meson_ecc[i].strength == nand->ecc.strength) {
>>>>>> +		if (meson_ecc[i].strength == nand->ecc.strength &&
>>>>>> +		    meson_ecc[i].size == nand->ecc.size) {
>>>>>>  			meson_chip->bch_mode = meson_ecc[i].bch;
>>>>>>  			return 0;
>>>>>>  		}
>>>>>> @@ -1278,7 +1301,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>>>  	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>  	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>>>  	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>> -	int nsectors = mtd->writesize / 1024;
>>>>>> +	int nsectors = mtd->writesize / 512;    
>>>>>
>>>>> This cannot be unconditional, right?    
>>>>
>>>> Hello Miquel!
>>>>
>>>> Yes, this code looks strange. 'nsectors' is used to calculate space in OOB
>>>> that could be used by ECC engine (this value will be passed as 'oobavail'
>>>> to 'nand_ecc_choose_conf()'). Idea of 512 is to consider "worst" case
>>>> for ECC, e.g. minimal number of bytes for ECC engine (and at the same time
>>>> maximum number of free bytes). For Meson, if ECC step size is 512, then we
>>>> have 4 x 2 free bytes in OOB (if step size if 1024 then we have 2 x 2 free
>>>> bytes in OOB).
>>>>
>>>> I think this code could be reworked in the following way:
>>>>
>>>> if ECC step size is already known here (from DTS), calculate 'nsectors' using
>>>> given value (div by 512 for example). Otherwise calculate 'nsectors' in the
>>>> current manner:  
>>>
>>> It will always be known when these function are run. There is no
>>> guessing here.  
>>
>> Hm I checked, that but if step size is not set in DTS, here it will be 0, 
>> then it will be selected in 'nand_ecc_choose_conf()' according provided 'ecc_caps'
>> and 'oobavail'...
>>
>> Anyway, I'll do the following thing:
>>
>> int nsectors;
>>
>> if (nand->ecc.size)
>>     nsectors = mtd->writesize / nand->ecc.size; <--- this is for 512 ECC
> 
> You should set nand->ecc.size in ->attach_chip() instead.

Sorry, didn't get it... if ECC step size is set in DTS, then here, in chip attach
callback it will be already known (DT part was processed in 'rawnand_dt_init()').
If ECC step size is unknown (e.g. 0 here), 'nand_ecc_choose_conf()' will set it
according provided ecc caps. What do You mean for "You should set ..." ?

Thanks, Arseniy


> 
>> else
>>     nsectors = mtd->writesize / 1024; <--- this is for default 1024 ECC
>>
>> Thanks, Arseniy
>>
>>>   
>>>>
>>>> int nsectors = mtd->writesize / 1024;
>>>>
>>>> Moreover 1024 is default ECC step size for this driver, so default behaviour
>>>> will be preserved.  
>>>
>>> Yes, otherwise you would break existing users.
>>>   
>>>>
>>>> Thanks, Arseniy
>>>>  
>>>>>     
>>>>>>  	int raw_writesize;
>>>>>>  	int ret;
>>>>>>      
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Miquèl    
>>>
>>>
>>> Thanks,
>>> Miquèl  
> 
> 
> Thanks,
> Miquèl
