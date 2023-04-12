Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCAF6DF539
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjDLM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjDLM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:29:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF1E6185
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuiVDgHLhtp/7WjYTFaKDlQTAdauXRgPr/pidZdxST3+5PVRI4ThoNz272KNlBrygACc99fdRTj8rWAkr2NbRyHz4ywqAHYrXHi+ZhnALPpRPctsEwBgRPNOp+XUTyiBTSBWabCt4PsCG+w3Nyb96jg+gkvdmLSZwDHovFA6FkU2arkX2E+KgA9njehI6wFwusBcZDDMEIGEgTHfdm8GLFrOXnpI7gn0zrhev/Z1kyew3HqluKyV60G0HgrdAYQtiUP76RCmNFEXJyyB2s4i6L1m7GC4o3ecCkEJ3hKutiuDbttylGV2BRkX6Z/PkYw4rfJA76M9jlIVBmpx/fyMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAeJ4Q/Kc0oql1LwJpJ/ig4ic9w4FJvG5obxIbt0Gxk=;
 b=F/43p9vsLdJPnGQZpBY5Zil9yj674me6aQWki/cltBRk/XomUQpR3cM8Wdv+ntwnJKEbDWdJvRGA/Fx4Ti+Xah1gWG4quyHJ0sdaS9OPM9gcfkYtDlKPFdMBGEBDEPyQzc9nPIkECpy9U6Msm4AaNNKlYHGpeW0tmwG5FN1sD/DxJq0+JiSGClShwZf9YdbIG2nFLcQ4dXuSgqpYcM0MhNc5sPRpo3aYKPWhqZDGDqwwRZ6mfxr1NLgdrwnkZAIgAWk/2qJlFEr+q3UjHx4/Mk4UTIn+JHsh7HRvTGHU2CGN85k2SbMTB0CThPWU+dSeblobkqe1vf4jkf1HC1RBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SG2PR03MB6801.apcprd03.prod.outlook.com (2603:1096:4:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 12:28:15 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 12:28:15 +0000
Message-ID: <7ae0a89d-2cbc-1e0c-527a-4d6b6218dc2d@amlogic.com>
Date:   Wed, 12 Apr 2023 20:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
 <20230412094400.3c82f631@xps-13>
 <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
 <20230412113654.183350d0@xps-13>
 <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
 <4baac18b-c223-d346-503c-f5f9ae49320d@amlogic.com>
 <fe03919a-3468-b79e-5971-1f7671684ee9@amlogic.com>
 <20230412114326.fn3nm5r3rzlnqgg7@CAB-WSD-L081021>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230412114326.fn3nm5r3rzlnqgg7@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::32) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SG2PR03MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: f5163f3b-04f5-48db-13d9-08db3b516307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EysL9Dtv1B/6vALMqQZCc8A5iuikE4eraOZ2KTivIdzwp90VAs5K93uESIno0ODZySwRsFUATdMDj0lvRJYrJWMb2JPC+NwZ6JAhueBlTN6+Exs7QtXSSeqeLPBuFJ4lr90kLjQpI1VOIu/Gno3CWwaOm8YpqPcMS9OI+CBmSVJtkNo/IzghvURTLSpxisHxh1+bOl0k0/CQ3iya3DG9b6Hgg2wAjLPIRifsTqajW4kD2mZoxm0RAeYbc+Zh38R4SMqS+vNnJweVVBj7UPrXhpSQL4UkeVO8hN4vXtly1aCj5WnjbYDX7pdGSppiHXjRHvuBT78yD/yXvHAjBbAy0IGtxVTJ2tCa0pEySUJMvqvZIp+ggCUBeg5tCyeyQEZaLydOAKC0GFSdyraq0y5fGsA6ymWh9vFy8xzcn4iV0z892CBcON8EeC3XEi7eDVHRP3g7JnVrty09zAIRGBHzaV1J4khVFgAkEBxTKbLPeMaCBBo7e4E7aCsFM3IY8RWnGWaD6ahO51GTzD8ALR4UGtVuBK3VUhsRGgHs0voba7O9BfJVEY//Jf3lFPyihMDZwciQELSBfR0S/PXLJwB7FSPzdjrfBBtRM4byj0J6PCpvUS5GwE8uglAwxIHAf8iTqvGQoE1QnMm9zaBEswyOjoAG3/cyChzAVagRSaav+IR78jmo7z20kKOT5fT6gD0W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39850400004)(451199021)(41300700001)(5660300002)(478600001)(2616005)(8936002)(38350700002)(8676002)(38100700002)(31686004)(2906002)(44832011)(31696002)(7416002)(83380400001)(186003)(4326008)(86362001)(66946007)(26005)(6916009)(66476007)(6512007)(316002)(66556008)(6506007)(52116002)(54906003)(36756003)(53546011)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJTS09tdURDRUI3TXZrTXhDMmtZcytIUEZxSEgxUm1mWmIxaU11MkdZUnpu?=
 =?utf-8?B?OFRzS1h5dWpHNW04TDk0bEw0VkhTMDZIdUtGeU4zQ0djRUNCWS9CWkREbkoz?=
 =?utf-8?B?L29SakFVOXNXMFNsTTM1dndwcEFtaENvRVUvL0FkTzZZVlVQYkJQV0hYd1hh?=
 =?utf-8?B?YW0rUldoMjZGcjlOb2hqdmNDTnQ4UnNuY3JvNDl4MWFRZzhsTHNGL29TQnZa?=
 =?utf-8?B?alRWaS9VKzNsS0NnWnE5WTBURlBHL1NCSWo5RGNKVE5KbHlhNEtEdWM1NUpr?=
 =?utf-8?B?WGNHRlZUWFczNFAwMFJjemdZN1lIVk8rbmZnRXFjM24yUlpoaGRCSzJFdGF4?=
 =?utf-8?B?UXp6RWNzT21KVnVUd0pWd0pHUVowVk56a1h3eE5VYmRxQ2R2WGxzalVlRGI5?=
 =?utf-8?B?cUw3ZGJnbzBGR0tVbU45ck9sdmVkSHBEbFZtV25Bdll6ZlJsUjhNSjdueGlU?=
 =?utf-8?B?eEk3NUJJaGora2EzOC9pN1N4VGhZZ3VDd21xUXpNWlVLb1o4VEtYaHJNZFRX?=
 =?utf-8?B?MWlreXEzL1ozbEpiZm1LZnovZk8xZkM2ZFZKQTVxbFBHZjUzUUZEeVRoMDBG?=
 =?utf-8?B?cG9xcGtqWFVkU01zWVBZa3hwc0NuUnpObzN2eDVodnVxVFV6SW44WEZIWTdY?=
 =?utf-8?B?N21QUTZoVTdiWFl5a01RMlNuMFIrMzdla3RVSGluNW5UblNmSDBEbVhGUWU1?=
 =?utf-8?B?dnFNdWpmVFBzekxldXpUbEt3MXVUUVVmWmpEZGNDbTFLRkRmRU1ZSjBLK3BL?=
 =?utf-8?B?TUlwdE53VzB0SFpJQVNwU2RCSjl1MitkR1VwR0NLaXNPa0I4MlI2bjA4cmtq?=
 =?utf-8?B?cm5HYUpwOTZWc2l5UHA3WnVwcCtvSjdib2VDVnNxUkJsV2dVbE9zaW01RDVD?=
 =?utf-8?B?UnNRWjlWdUZ2ME5qNGxhWmRpQnM0c090SFFkbFU4aE5RQ2QrbU5DZ3dDVFgx?=
 =?utf-8?B?U0NVUHdLakh1blZGK01PYWlKcGVPUytCb1pxQ2Nxay9QRGRPcG1STTdicFZL?=
 =?utf-8?B?TW1GZ3NCejlrQ0hTZ0grNnJIdmdmdmdRUUlCTnQvVmNTZ0hPYlNhVjFTUUhV?=
 =?utf-8?B?N0pINzlaZ01IWmhVN3hRUzYrVnRjNkdXaTh2bHA4cGFlS2ZrNEdIbHh1Sk9p?=
 =?utf-8?B?dkNaR1JGWTFzaGJ0WCt4NVFJM3d6cnpObFZ2cWdzZWg3ZFlJdHQxVHJlMEN4?=
 =?utf-8?B?d3lqLytRSTRJNFg3dmU3dENKRUlVQ3g1OCtSRHBIWUorNCtaczgzcnBsbFhB?=
 =?utf-8?B?NzlNdU5wVXcyNzdIUTdJazRVTGsrQWY5Rjd0ZzU0aW85Tm9Pc1FGQ0pEWCsr?=
 =?utf-8?B?emZPQ3RkRHd5YS9tN1lyMXhMWlZFTUI4dEhrM0pRTHhWRXFlcFdzZ2J6QndC?=
 =?utf-8?B?MCtTdVZxbmlSY1RQZVZDdUFZOVZrQUg4ZmRsVlFIcW90Unk3VnVjelNzY2Qz?=
 =?utf-8?B?dUF2TERYb0sxUSsvWVVXUWE1MDZmS3BaVGl1dlN6N0ZnRFZPMkFESk5scDJm?=
 =?utf-8?B?NU1Help0QUxNTS9BYjMzUFRibWUyVDJZUTNBZk5GY01UaXZZR2FKcUNOSnF5?=
 =?utf-8?B?bEZ5T0RDelRNMWRhUll3bjhheGdicVpSMSs0ekVPcVd5QzJkM2ZDTk1PRDVB?=
 =?utf-8?B?YlhNU3dKejZYSTZwU01CcXJVMkxHb1M0ZTNndEZGam5sQ2lOUXhnQ0ZQVnZT?=
 =?utf-8?B?MW1vN2Y2UWVrL3FsenpSNUNYWVp2c01zS0hGZXBRN1ptN3RDQjVYalNSK2Jz?=
 =?utf-8?B?cHNhcG5lU3BRZnB5ekRoY3ZPeE5SSE10RlBQdis2T2pBSEJpUWNGK2FXNENV?=
 =?utf-8?B?UklDR3luMG95OE5LYi9mMHpFQUhJUVFldEM4ZDc3WFRhZmJ0NUtZT21XdEQr?=
 =?utf-8?B?SDZoSCtwT3lhQ0s3V2lUYmhja0tPalhFMUhhUEo1SWJSaFVpTkpTZzUrbTlO?=
 =?utf-8?B?elZSaUR3RGw3QlcyOW1tS2FVdmpISWJBeTBuZThCSWtNb1dhNGFjZ3VPTlg0?=
 =?utf-8?B?akJWMm0xVjJtNDNFV3gvYXdWVFBBZlNTZmhTWEJ6S0d3cHEwdVhodHBmT1px?=
 =?utf-8?B?OEF5bGoxY0dWaFp2K0E2d2JYSFFsTmxEdXF6d2ZkTHBWcGpXMnN4Q1h1R0N3?=
 =?utf-8?Q?SksdJnOYQpuyy/QVvvgUSQHJZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5163f3b-04f5-48db-13d9-08db3b516307
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 12:28:14.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0F1e0ycX5RJkPnw2GFS/WTXSTB2w0cNcSZGgfi9rIShmRZVKkgZrqkPvjU/xRigbTPN3pzVxNEHmtxBzy4cvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6801
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2023/4/12 19:43, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello Liang,
> 
> On Wed, Apr 12, 2023 at 07:36:30PM +0800, Liang Yang wrote:
>> Hi,
>>
>> On 2023/4/12 18:51, Liang Yang wrote:
>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> @@ -858,9 +858,12 @@ static int
>>>>>>>> meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>    static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>>>>>                       int oob_required, int page)
>>>>>>>>    {
>>>>>>>> +    struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>>>        u8 *oob_buf = nand->oob_poi;
>>>>>>>>        int ret;
>>>>>>>> +    memset(oob_buf, 0, mtd->oobsize);
>>>>>>>
>>>>>>> I'm surprised raw reads do not read the entire OOB?
>>>>>>
>>>>>> Yes! Seems in case of raw access (what i see in this driver)
>>>>>> number of OOB bytes read
>>>>>> still depends on ECC parameters: for each portion of data
>>>>>> covered with ECC code we can
>>>>>> read it's ECC code and "user bytes" from OOB - it is what i
>>>>>> see by dumping DMA buffer by
>>>>>> printk(). For example I'm working with 2K NAND pages, each
>>>>>> page has 2 x 1K ECC blocks.
>>>>>> For each ECC block I have 16 OOB bytes which I can access by
>>>>>> read/write. Each 16 bytes
>>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So
>>>>>> when I read page in raw mode
>>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB
>>>>>> is reported as 64 bytes.
>>>>>
>>>>> In all modes, when you read OOB, you should get the full OOB. The fact
>>>>> that ECC correction is enabled or disabled does not matter. If the NAND
>>>>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>>>>
>>>>> What happens sometimes, is that some of the bytes are not protected
>>>>> against bitflips, but the policy is to return the full buffer.
>>>>
>>>> Ok, so to clarify case for this NAND controller:
>>>> 1) In both ECC and raw modes i need to return the same raw OOB data
>>>> (e.g. user bytes
>>>>      + ECC codes)?
>>>> 2) If I have access to only 32 bytes of OOB (in case above), I must
>>>> report that size
>>>>      of OOB is only 32 bytes during initialization?
>>>>
>>>> Thanks, Arseniy
>>>
>>> Yes. it should return all the OOB data. i make a mistake on raw read and
>>> there is wrong code in meson_nfc_read_page_raw().
>>>       meson_nfc_get_data_oob(nand, buf, oob_buf);
>>> changed to:
>>>       if (oob_required)
>>>           memcpy(oob_buf, buf + mtd->writesize, mtd->oobsize)
>>
>> Sorry, please ignore this. the previous code is right.
>>
>> the controller changes the layout of one page; the physical layout is 2048
>> main data + 64 oob data. after writing into NAND page, it is stored
>> like this: 1024 main data + 2 user bytes + 14 ECC parity bytes + 1024 main
>> data + 2 user bytes + 14 ECC parity bytes. so that is right we only get 4
>> user bytes and 28 ECC parity bytes, total 32 bytes. that is the behavior of
>> the controller that transferring one ECC page(1KB) brings back only 2 user
>> bytes.
>>
>> because layout is changed by controller, so go back to the function.
>> meson_nfc_get_data_oob(nand, buf, oob_buf) try to get the right user and ecc
>> parity bytes from the right pos. after that, the other oob bytes is not
>> reading from NAND flash.
> 
> I have always been under the impression that NAND OOB layout falls under the
> responsibility of the flash driver. Is this specific to the Amlogic NAND,
> and does it map the flash layout to the internal controller layout?
> For example, different OOB layouts exist between Macronix and ESMT.
> 
> Apologies for any confusion, and thank you in advance for any help in
> clarifying this matter.
> 

This is the behavior of Amlogic NAND controller, not related to NAND 
device.

this design of Amlogic NAND controller is reducing the fifo(sram) size 
inside the controller.

To the NAND device with <2KB(main) + 64B(oob)> page, usually if the 
controller place user bytes and ECC parity bytes after 2048(column 
address). to finish the ECC calculation and checking, the controller has 
to read the data and its ECC parity bytes. if they are not placed 
continuously, the controllers have to read the whole page data including 
the oob data together or send random read command with column address. 
so consider that the controller needs a fifo of at least (2048 + 64) 
bytes inside. if the NAND device has bigger size of NAND page, the size 
of the fifo should be bigger.
in Amlogic NAND controller, after changing the data layout of the NAND 
page, it just needs <1KB + 16B> fifo size. the controller firstly sends 
only <1024 + 16> clocks and get 1st ECC page data and its ECC parity 
bytes, and then it can start ECC calculation and checking. after that or 
at the same time, loop next ECC page data and its ECC parity.

-- 
Thanks,
Liang
