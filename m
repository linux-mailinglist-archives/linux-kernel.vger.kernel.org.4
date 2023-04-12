Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6346DF3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjDLLjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjDLLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:38:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A87EC7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBlXTripQtVPVxmU6pTifGp8d8RUJvy+p6yA7bi7iaSfHd1WZaggbW9bFheTXOn3KIiInB/q6ViPDyTaxAd4Blg45bzIS1PjtJJobTPjaUTNOa19aMQl1c/DXaavllud0Mx7LaOxrKKFgK45u1WbQRTK6YRFZU5C0O6X72nQsZgMmTbzcbXdp4JpmNqf0JcMpP3l/JXisNXbKzCPb35faAiWUdKUC4ENkm0QDo9CBfdZ/ne4YHpAApnlxiw/nEB1kPelaI+8zG9bLxtidYWHfqH+dOxOJPr65/o9lODj0uSRpMNctHmbd66UDEUY1tpTGTFHvta+Ubjz/gqvrl9irQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIVPjKdFVvG5ofUj/UxhfHR1dGkzwnnpQNOOYl8eGWM=;
 b=iQtxSQMmsE42GKHgqIM7Y8DUJ7e5FqVkxQEqiYZ1ZTbxGdo+QxMOxrMvVaeid8JCCdiyaNHw6XWRajkV21W51IOLZQ8mKPBK2ZTy2/PI5E0mmQE72hA29Ra0dL6W6cwqPFcu/3MVkpeXF2GDUV/rPRTzJqTPAPnguK1/ngQDjhXc60vQGutrtq7nLp9AARM9CtXdQTHoElg82ftsjL4fYXhpYpr/3u/+uVUSUDlFe922H/rHXD6FBW9p6TldJge/YC5p2oJokEGPcj51xvVlvpmxK9B89YLQRypcujRp50Qd0ymfXkLWbRMd+6SNiBo94uAumBESs++6WLWdxvbb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SI2PR03MB5829.apcprd03.prod.outlook.com (2603:1096:4:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 11:36:36 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 11:36:36 +0000
Message-ID: <fe03919a-3468-b79e-5971-1f7671684ee9@amlogic.com>
Date:   Wed, 12 Apr 2023 19:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
From:   Liang Yang <liang.yang@amlogic.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
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
In-Reply-To: <4baac18b-c223-d346-503c-f5f9ae49320d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SI2PR03MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 379a777f-1c99-40f3-dd40-08db3b4a2c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCW5sSdefSCVBlNi7p/Pn3dtY4PqanW6SUJR2rgNH9Lx0Ldn7DRApr8rhpySeU5vPsGaGybHrTrIMsCedgyj8poBo+hCZYua/nCpx/C0cLbLJXUieEKI1nO1nKtO65S/aGZ81N/Ak2yw/1COpylAzdnK1uI90Q9FEpLa0lRnoq2mkkqXZ64P4wG+h6jCTqjtyuGsNS2gg1sYNFY8MSWBNOomnd0xKK54tFuYdLjwQ61NveUX2wD0FN8njDg2K2wJgLgYyHistYTbrn09Y03yAsCenWt6CZHNgzFsp+BaDry4xTZmHHddwg9//T4fV3XpEJYY5uBcdptw8/7pVmOysPSy85+FJWtmPjWhYPCl65NJDYhNN6GPLb7pTf8N8h+2auGXI+X2w172yOk+VKiJ7/UW7AFdXPjN9Wl4sjO8EdH6sx0nqqaSHU/YDce8N64X5YnwQWbyNfHvHVBPHbcWGkc+knpZ77IbV7Z/CX/RSWgRP6ABFR+Wt3XloL7DcKMvUeqe72InAlf2PNBHVAvfike+1hSr+rEAZc5xfI8RxvtmXZB35Qsj95ptgWDY2oothEoxn1eE3BNFh3NOLBZDlgWxbCJt06HosFhtXe3brHKS1fvadE2gA22Z9jLtrtlZRk1MukYuBsgKnzIJBFALIe07YZvCmKMVlQ/b/jMB1bvtZvZcEvyRnn8+S7ebhim4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39850400004)(451199021)(5660300002)(66556008)(4326008)(478600001)(66946007)(316002)(110136005)(38350700002)(7416002)(44832011)(54906003)(38100700002)(41300700001)(66476007)(8676002)(8936002)(186003)(83380400001)(53546011)(52116002)(6486002)(6666004)(2616005)(6506007)(6512007)(26005)(86362001)(2906002)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5pQ2x4UFJxalhBZDhpc081Y0I3S0F6VjRiRHRqTTdBS3ZXK0ZjVC9zamRs?=
 =?utf-8?B?a3ZpdFowa0RKVVNrTDluMjRyOEpCd0tvdjNOVE9HRUdsRS9OaUFhTXdGS0J5?=
 =?utf-8?B?U01XSHdyOWpudmkvSkVTN0UyeWF4S0ZzWkNBa0VOSHczeDVZV3N4SnM1WFky?=
 =?utf-8?B?QWw5bHg2SVpyQy81YXpUWnUrMTVaZFdVZzVTOUkzQ1I1UDh0T2ZGa2Z1UnVx?=
 =?utf-8?B?UnQwY3J2M3UySFRrRVhnSTdHOENMeUVoaWZ1WXk0cUp6bER3Qnc3aUxhUDN2?=
 =?utf-8?B?eHZmZ2pucDE4RnpwdGgzYzQyUWs3NjVMRmJRZDV1QWJka1Z2ZmJYR2VEWnpK?=
 =?utf-8?B?a3AwUXBpanZnV3gxbjZMUXRsZEZNbFVCbDZzRXoraklmNno5SVRZK2RKWnNP?=
 =?utf-8?B?eUJNeWN2ZWhsMXBWTXdBellVODYzWDNxbkl1UDEwYTFHZWllNkJQZUNDM2FG?=
 =?utf-8?B?TXZJUHhPSDhIekQveDVMdFpYVmNCWDlvdks2eXkrSGV1U2I1emFUTnpheE5Z?=
 =?utf-8?B?VU1jWm5tSExXRThjcHFJVkt0ZHljZGRQME85bENOY2IvL2RDdTVhMWFEczBP?=
 =?utf-8?B?RWZoTzNodmVqYnpyRDNLZ2piZXhtVHlmV2N5bHZuS0RQVHNSa1pMYTlrdHE2?=
 =?utf-8?B?SkJMcjAvTStoMU1ZY0ZDNFN5QXpUbUphcVU2ODJWVHZNb1BFZ3ZYclZHZjl4?=
 =?utf-8?B?OUl2UVVOaWhsRDN2WUFkbHp4RVFrWHRRQ3RDcnh4V1NyYUMvZTB3eE5lNHpE?=
 =?utf-8?B?K1lQSzcvS3pGRnpKQ0FkYS9MbURvTVY2Y0lEKzlnUTBDK0xmQy9HNkxLTktp?=
 =?utf-8?B?WTVaUGFpT0RZdjJVT2ZTR1FmVzhjN01wNnJjVGwyMjRsTVBRL2luMVh5WEoy?=
 =?utf-8?B?SEtNZ1k5N3gwR0xZR1p2WWc1bmV3WTQxQ1QySHRYT0tBVHp2U2M5MnBKSmNr?=
 =?utf-8?B?TWZWUFphcmJwWno3M3ByM0lrL0Nvb3VsMXZpc0hJRkhTKzkrbElDb2JYZE5C?=
 =?utf-8?B?TmZPZ085S0hYUUtJTGwzVU1RVmhYRGFseTgvVzg2WkpIT2NLL2djQzJ4ODhV?=
 =?utf-8?B?RC9hOUJLNEIvOFpHUjBaOXBYQXJwT0gzT0xhK2ZHVGJ2QkE0UUxyTDNlK2pl?=
 =?utf-8?B?SFgyNEpyWjlzSU9SS1Z1OGMvZzM5SjhIR0QydmU4c1M4NDhha085eGVua3V6?=
 =?utf-8?B?czYzVVJTbEU0SENZZ2JCNHpKUWxIS0NIRXM0KzgzSGFMU1B6eDE4RVo4TWhz?=
 =?utf-8?B?bUNDYlo4ZmJ5VURMcUhBcnhnVW5ZOUdYRlBWWTJxOVEweU9zZURqd2RoUDRS?=
 =?utf-8?B?RVBUTTlVWHJqVmhjaEVhYWxoYWkyZzVsbkFpcEhub0sraWdqcVc0bHN4K3M5?=
 =?utf-8?B?T2ZhMEt2ZVNMS0RGQ0hGRUNudG8xTXNBMjVnWlpNaEkvYlJQZ1dhSTNDTjYv?=
 =?utf-8?B?ZzRVR1AxeG1XdDd5YnB5OVI2RFFjTGZ5QnNtNVpoSm5QYlhvbXlkbm1Kandl?=
 =?utf-8?B?aUkxUkREQkZlM0tyMFIyZGM5WEZ4aHhDWFpvQmdHWUU1QVM4N1B0L3M0T0Fi?=
 =?utf-8?B?M3B0UytLdjI3eE5HTHQ3ZHNrSUpvT25IN0tTa0VuZVJJQ2RLMzlUNUd1Q2Fp?=
 =?utf-8?B?b2JtcWl6b2pBRDJwUExUdjlMV3JIc0h4WW1UZXNXbnM2dmkyLzdCOTRtaEhm?=
 =?utf-8?B?Z2hCbmJzcWNGVnV0N3BWNVBrNkhnNlZxQ0JUU29PWDZSNTZvaHhPNWJ4bkVz?=
 =?utf-8?B?b2JOVjNEb010Vm5hRmNWK2JyU3VmRHNXUmEwbUc2Q1BveW5sdThuRnFyQTBw?=
 =?utf-8?B?VjRSNjNsOTlpcnozVmhySmRuSlBXa1lqYi9UMjd1Nmx3TllsVW5FODllRWFL?=
 =?utf-8?B?M0RWSU1lL1FnNUs5MGVmSGFQcXRnNFZrU2dOd1BUbTFJdE43NVhsaGw1VDZS?=
 =?utf-8?B?WTB3QlJxZEE2ZE9obUxxdU5KRGFrTTNqMzdpekR0U1plVDhoVG5veWlEcWsx?=
 =?utf-8?B?aGg3bmhWOGNpN3psNUxtQzhCQ1pxYUErY0w4UUVQVm9wZGU5czFVRjk1YmlG?=
 =?utf-8?B?R2kvVi9KTUFOc1BQMzlQTkVuT0V2Q1hFQXc5emxLRW9Edm1IWHpNQk1YSDhH?=
 =?utf-8?Q?7R1Md1lSkjFxEMxODWv2MYr81?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379a777f-1c99-40f3-dd40-08db3b4a2c32
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 11:36:36.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ujRLHvuWpx2AA1i6r7dChF90jsuFK785gMAisYpPXrXSetyJwpioQ905l0SWVpoDex1QjcpykV0E6+k3FAelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5829
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/12 18:51, Liang Yang wrote:
>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c 
>>>>>> b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct 
>>>>>> nand_chip *nand,
>>>>>>   static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>>>                      int oob_required, int page)
>>>>>>   {
>>>>>> +    struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>       u8 *oob_buf = nand->oob_poi;
>>>>>>       int ret;
>>>>>> +    memset(oob_buf, 0, mtd->oobsize);
>>>>>
>>>>> I'm surprised raw reads do not read the entire OOB?
>>>>
>>>> Yes! Seems in case of raw access (what i see in this driver) number 
>>>> of OOB bytes read
>>>> still depends on ECC parameters: for each portion of data covered 
>>>> with ECC code we can
>>>> read it's ECC code and "user bytes" from OOB - it is what i see by 
>>>> dumping DMA buffer by
>>>> printk(). For example I'm working with 2K NAND pages, each page has 
>>>> 2 x 1K ECC blocks.
>>>> For each ECC block I have 16 OOB bytes which I can access by 
>>>> read/write. Each 16 bytes
>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So when I 
>>>> read page in raw mode
>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is 
>>>> reported as 64 bytes.
>>>
>>> In all modes, when you read OOB, you should get the full OOB. The fact
>>> that ECC correction is enabled or disabled does not matter. If the NAND
>>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>>
>>> What happens sometimes, is that some of the bytes are not protected
>>> against bitflips, but the policy is to return the full buffer.
>>
>> Ok, so to clarify case for this NAND controller:
>> 1) In both ECC and raw modes i need to return the same raw OOB data 
>> (e.g. user bytes
>>     + ECC codes)?
>> 2) If I have access to only 32 bytes of OOB (in case above), I must 
>> report that size
>>     of OOB is only 32 bytes during initialization?
>>
>> Thanks, Arseniy
> 
> Yes. it should return all the OOB data. i make a mistake on raw read and 
> there is wrong code in meson_nfc_read_page_raw().
>      meson_nfc_get_data_oob(nand, buf, oob_buf);
> changed to:
>      if (oob_required)
>          memcpy(oob_buf, buf + mtd->writesize, mtd->oobsize)

Sorry, please ignore this. the previous code is right.

the controller changes the layout of one page; the physical layout is 
2048 main data + 64 oob data. after writing into NAND page, it is stored
like this: 1024 main data + 2 user bytes + 14 ECC parity bytes + 1024 
main data + 2 user bytes + 14 ECC parity bytes. so that is right we only 
get 4 user bytes and 28 ECC parity bytes, total 32 bytes. that is the 
behavior of the controller that transferring one ECC page(1KB) brings 
back only 2 user bytes.

because layout is changed by controller, so go back to the function. 
meson_nfc_get_data_oob(nand, buf, oob_buf) try to get the right user and 
ecc parity bytes from the right pos. after that, the other oob bytes is 
not reading from NAND flash.


-- 
Thanks,
Liang
