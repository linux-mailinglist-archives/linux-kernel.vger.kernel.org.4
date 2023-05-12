Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB8700199
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbjELHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240263AbjELHhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:37:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2041.outbound.protection.outlook.com [40.92.52.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1562DC71;
        Fri, 12 May 2023 00:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3Sqjm90CDc5zl8oBDEIJLQveT62PawK3smnyqqFjhJzEqiIIGCNj3FTYRJohvOIVQHsjqsGw+pLtieyn6IC/fiLbUNHvDvgZ8h16NMItiyhx/Q/3Xw5Cw+kGT4XW01Bd6VxOrDwy4fE8qgj8abeb0KRCDslDa6OmSL4P0Z8xpHQbEkFqlqSaP9yBxo/5hbN6T0OsKZHMCcNs3R6OXQ3pEgYW7VHDh/otP/8ZvospM3Y3eo+8rIEOm+0Af62RGmMOv2YLeXI+ebJZdPegUcV7t11Oz69sguYhKvlqaMDMwZruWU0G8v50Bm7jc30LLDPhHXyKdmtzfVkc/MHybfudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TG3JxEARI2CsqsflwkOh/VRCdbCHKPbi5hFThvkKG0=;
 b=ma5+4zeXGBQ+eaBc5WMOmaDkpCj61DHisT2yx4tMNWPUjeRyCKthq+Vpma1MvVe8Wn/MLgDXYhMNKGxILSt92N0/oKVXhFSiEy+k5jm7oUbR+OTmk9LuKidG7JcU6hHtv/Xz7pwvIq0NFqicSmg4H0/Jx1TWsc5SZ9oBpiENHum5QBADorl0TipGP5ohOUYYqAliebaUIDZBJnG42V3WQKgaCx2hGAwbxH5mPdO07ZJS5JEQHFLrm5yfxKL6MtFHrTz4zze2OOHPvvFPu5w9vK7kSTmpBil6DdVCllnDvPRrAH80aYJIT7XiE8mcprEXLpewbtCpnBhsZfqpHKBDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TG3JxEARI2CsqsflwkOh/VRCdbCHKPbi5hFThvkKG0=;
 b=TDYbQw8XhJVWAYhJONpAzM3SfJRjd1qj1kNzP6leBgTyPobpZfVWb7grdruD3UqxXbYpCM3IGP4MEy/qCQYED14sJEFg7tbu8QNPIcyJHj1wpzg8glQCSrD2Uq8VR2yYHS839cYIu6nnl+iGYx8BCozBFh6m0UWqMRTwZA9R/eKJ5LiK2NUxPV/gTQbXBCPofev81z0j7LiIr7xxkFPEsGPDa6S3SMoHUOpF1yh9BELX3eOyrTZdzsvtyx35mrlhqd299msiNw9c7ZHwNiyT59zZ6QVhQM71bvRt6fXNi/gkguHJ18xgDo+2FT4kTfmt5Ojzqom+H704xntjWT1Ycg==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by PUZPR01MB5261.apcprd01.prod.exchangelabs.com
 (2603:1096:301:11b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 07:37:20 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::93cb:1631:4c4c:1821]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::93cb:1631:4c4c:1821%4]) with mapi id 15.20.6387.018; Fri, 12 May 2023
 07:37:20 +0000
Message-ID: <KL1PR01MB54484CA1950D9468D0228C08E6759@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
Date:   Fri, 12 May 2023 15:37:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] gpio: gpiolib: clear the array_info's memory space
From:   Yan Wang <rk.code@outlook.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <202304232146.7M89pwCz-lkp@intel.com>
 <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <ZEk4YNQeYohEwnSg@surfacebook>
 <KL1PR01MB544880BE86B3890E33609C5AE66D9@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <CAHp75VdFqL4e=awSg0pxnzEYLvWRenTYohRfZ5p-ZOc2B5Lzgg@mail.gmail.com>
 <TY0PR01MB5444D77F48A2BF19F3A44087E66D9@TY0PR01MB5444.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TY0PR01MB5444D77F48A2BF19F3A44087E66D9@TY0PR01MB5444.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [/On2VNSdjSAj8zQjQ/l+dJ4x0I73i1ov]
X-ClientProxiedBy: TYCP286CA0324.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::12) To KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <a3d3e9a2-ac1d-4f45-986a-4542ebf14f99@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|PUZPR01MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 02300722-6114-4b4b-ff8c-08db52bbb7d5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pB9E1+ELTVIKYBILEoMaO3OGEIWCyVzuK8tnMThdy6rYj458B3aZqgOHV8ytICRzVqeqeTqVQ2KZGRhSj6V6jL4Svfmn/tC8R4VEXPQvanTIYWvhCx4+vdp4QhsALhLV1N9tCcSNdBjYXFvwBqqzX4zYEzzXSwjfaRPLqn7sjUUJQaN8cKw8cOxsTOug4BqL5xlyA8CYe1r6YM4dYvAi3jf/bqtyfWgD9Aa+bDICfr7xUdPNQ9E+K1VQQIMx/hnjDKnIxf6tuSF1L0ZjBcZeOxJWvkGwwNfAnRPy1jDuRobXSoU727HY5BqUvjTKpRDuAFeXkCs6q4qzuRuRafkyrxUBNA+I56GwIYg8rFxiTLGee5f9u+IFASu6rYwVH3ww3W40OLf7fRGjT/gtb2oNZA32Ejfv6B1PdKRFfqZ+KAw9R/37oihiv/lnmpvsoP8uBuiQjG/iiauqhOPv44zyVl10jZsLkD986vv1Z+OLA75YdH2L0stqdbsxX4KlOwgUAwb3Wb+qzpHxVPmzqSYGV2qBgQ6+3MG72zAomNSIEw3Y6+7UX9D95xufyubhY96IdqeBy7r3K83z0pgTDyWyOmblTBersTord1hkpoxczCU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTZmSHBNL2tiK2xuSmQ2eDk5VnlIUlNmc0FRejB1K2I3WWxLZW9vRWtpajNV?=
 =?utf-8?B?NjA2YTI4UU5LRllZWEtRU2lybmRRMmVTMzl2QnVzM1pvTlQxSmpRNW1vNE83?=
 =?utf-8?B?ZjFHN2xpN3RkK2JHSnFCNFMvanhlMkw5NXR6dE9kb2JWdFk5UnZEUnY4aDY2?=
 =?utf-8?B?djFiWmEvbzl0a3Z4MDNvNExHVTJENTJTWnVYdm1CeVJuR2ROUmhPVmJ3d1FX?=
 =?utf-8?B?VUFWc0NFVVkwTmJNakJ6YmhDZ2ZXblhTUGJ5d0M3RzlxK2xyeHBiOVAyL1BO?=
 =?utf-8?B?L1hxMGtzK3hQV2pFTFI3ejdQQUdQY1pvL1FiSWRvRjRNK2pLSThuKzZjdnpo?=
 =?utf-8?B?c2ZEQzhQRXZJc20ydE0rdmUvdmZYbFNnbHp0RDZ2Tk05OUVwVGhlbmx1cW5v?=
 =?utf-8?B?bjBjZ3o2YmREOG4yRWc5MjljNmthOHhsRmp4eTF0SDA0eHFzSm5LVFJvNmpE?=
 =?utf-8?B?eXVUZXY5TEYxTFJTSFRwTUs5NFVmOEptTGlNcUlpNEVCTGIrM3BYMkcxSXBZ?=
 =?utf-8?B?Z01zaUJzTGsvMVNHanRneHZ5NVZRWVVYTlEvZS8wSFBTUTd3MzRsbWh0UUoz?=
 =?utf-8?B?ZUJuek0yazJOZkhyRnFibDJDTGRwNjZFeVB5MjN5YU1HRW1OSGZXMzZKbWFs?=
 =?utf-8?B?SUR2K0xlbGdHSVhwK0JOYTdObU5kT3F0VGI1VlNlV2U3VWM2RXRMeWEyZlFG?=
 =?utf-8?B?eUo4VjhoUGJjOXpZZWo0QVRTVlE3dGxWQ3BOM3I1QVpGckRhMDdicDk3cFRN?=
 =?utf-8?B?TXdBVE9WT1laWThUTktUYXpqczQvby9BaWNxVmdUUXFLd2hPUW80ZWJibTdQ?=
 =?utf-8?B?TEJINXBTRXROR2p6N3R2MWhNZ2pvTTlBbGZId3Z3a3hwS3ovZVRwcE84MjNt?=
 =?utf-8?B?Q0ZPb1hOS3V3K095Sy9qTzhGeGJGUkVKL1IwTzJEOGVJeHpHSytHSzVGc1g3?=
 =?utf-8?B?YjhVcUIzL3FXeGYyTVI5blRqOXZZdnR3TTFjTU1lTElhdnByOVNzZ0xQT2Yv?=
 =?utf-8?B?Zmt3VVM0Rm5JN2JpRENuWkZKekVBM0R4elpTaWhSekxUSC94WUI1RmdGSCtq?=
 =?utf-8?B?Q3JLU2RLRkVrMk5BMWUzUlBxcE85NERUSEZDK0sxOXlCVW5TcGI2K2s5QzVa?=
 =?utf-8?B?QmpwYUY3b01VUUNqVTJKQU5xZjB5WTFoRHcrZC9Xa2ljMkU1cFpLNGRRSGtz?=
 =?utf-8?B?cnVMWkhESmlNUk5oUkVDNmR5Y3lWWWZEL3pENUViZ3BjczB4V3Z6ZEM2cGlC?=
 =?utf-8?B?UlcrenQvUFlxUFo2LzR3b1RpV3hjUTRmZVFJVzZTREs5NmlRVWhkeS93WWFj?=
 =?utf-8?B?enpoOTc3ZTRaT29VVXhvQkJLYXlZVjFqUE1PTVF1VStkYXdJVlZLK1Y5RDhC?=
 =?utf-8?B?ZFBhQTZRZGJONlhlYTRqMU1HNE83Tk1Tak1mRkN4MEhid01vbnhqcFdJSk11?=
 =?utf-8?B?M0ZPTzRTeVNWSzVIQ1N6dU11Q1BrNTBxOWNBdVI2UHgvRUJlYWRkZnhObnEz?=
 =?utf-8?B?SG9nTHdJMDhxd2NtbUo5dWcvOEtMNnU2b0F0YWYwdUZ4aXlEaGVCbXZUSURj?=
 =?utf-8?B?SkowQWc2TXNIQklVQlhEc2tZTXpVMkxSNUU2T3I1TVpiK0Zzdll1VEhiK1Vm?=
 =?utf-8?B?R0JscGdsV3MrY3ozS3BOcit0K3d0Ync9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02300722-6114-4b4b-ff8c-08db52bbb7d5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 07:37:20.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Polite ping

On 5/4/2023 10:15 PM, Yan Wang wrote:
>
>> On May 4, 2023, at 19:36, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> On Thu, May 4, 2023 at 12:38 PM Yan Wang <rk.code@outlook.com> wrote:
>>> On 4/26/2023 10:42 PM, andy.shevchenko@gmail.com wrote:
>>>> Sun, Apr 23, 2023 at 09:59:43PM +0800, Yan Wang kirjoitti:
>>>>> if hardware number different to array index,it needs to clear to points
>>>>> memory space if the array_info have been assigned a value.
>>>> Can you explain a bit more what's going on there?
>> ...
>>
>>> I use gpiod_get_array() to get a gpio array form the node of DTS.
>>>
>>> the node is as follows:
>>> ...
>>> gpios = <&gpio1 0 0>, <&gpio1 10 0>;
>>> ...
>>>
>>> First scan pin-0 of gpio1,its index and hardware number are 0,
>>>
>>> if (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) {
>>> ...
>>> descs->info = array_info.
>>> }
>>>
>>> Then scan pin-10 , its index is 1 ,but hardware number is 10 .
>>>
>>> if (gpio_chip_hwgpio(desc) != descs->ndescs) {
>>> array_info = NULL;
>>> }
>>> just set array_info = NULL, Should the array_info point to memory be
>>> cleared ?
>> This is a good question. The entire algorithm is a bit difficult to
>> understand from the first glance. I need some time to check it myself.
> Looking forward to your test results.
>>> if not cleared ,I use the gpiod_set_array_value_cansleep() to pull up or
>>> down pin-10 is invalid.
>> I'm not sure I follow. The array operations are against the given
>> array of the descriptors. If you ask to have that operation done, the
>> all descriptors in the array should be considered.
>>
>>> I found that the set_mask and get_mask vlaues of descs->info are seted
>>> 0x03 in gpiod_get_array(),
>> Yes, this mask is for the argument. The 0x03 is the correct one.
>>
>>> I think 0x401 is their correct value.
>> No. You have an array of two elements, and not 11.
> Due to hardware number are 10 and 0 , so this mask is 0x401（bit10 and bit0 are 1）.
>
>>>>> if (bitmap_full(array_info->get_mask, descs->ndescs)) {
>>>>> + /*clear descs->info*/
>>>>> + memset(array_info, 0, sizeof(struct gpio_array));
>>>>> array_info = NULL;
>>>>> }
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko

