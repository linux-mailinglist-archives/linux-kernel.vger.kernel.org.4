Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0D6E06CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMGMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:12:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DE5B9E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A071mzNBulCeHUbCXmsDbeVyM97cLHkYZUZg4lzVOkKIfdpGhyNl9oD4wF06yAZgb5O2QhC9494Zt+NQdO8lWedpVOPhszETWOJQCvAtaFg4Rlbie6Lv7FH20PasjIKurP3qeqaw9rZUOkyyCYCjlnMLQ300ZWKYAkjdO0JNqE7g+rNNS+LnxWWld+8odg4OnE+G8hekGdZMwDOvWvVCVDOoKQR/tZeRbbiXy8cmM6LSCH7b3X2AMg18rvvnJILxmaVulLWT6jLN8PNPa5TfRy4joJ+10miF+ilXFg7XUx+WKzhslLnCRiUejM5IOtat5wkWvDSwpSJWK1PTjOdN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZGAg9kbqlFqEJF5svibhQ8SGVcPwerORkbR1MExTYk=;
 b=jHdKh2rfuJEczYkUFzzqLRDs4fZ9HtF0g8rwYgz1BdH1RMXqQs8wPhbEEt/M93eOdioNDvzxIybI7DLN741iCNJgeqnc5Uljyt23J9HHAprI7l3BkUZu/UWvXaxi9alk+8dMWiEG23evryKaUxzMIqtk4dhYrImVgdMKd/cAlKC2xnDPHGLo3lwOvrgrqKQorNzgYAUsKcKJZKXfKmcqKp1Cmx0JxFNiX3T7ELx4o6J4O+Y/qJdVBsKfkrzMnqMgWgRkDE/TpmucB2pp7DLEWKkfIpwS8WeHJ4Tt9/uioN4yeQTW3C3xOzt0jUqhL1uvnTJVWThFsDLyjL4dI870ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by PSAPR03MB6282.apcprd03.prod.outlook.com (2603:1096:301:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 06:11:36 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Thu, 13 Apr 2023
 06:11:36 +0000
Message-ID: <fbb8cb2b-0996-3029-b368-f67087d73487@amlogic.com>
Date:   Thu, 13 Apr 2023 14:11:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
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
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        "yonghui.yu" <yonghui.yu@amlogic.com>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
 <20230412094400.3c82f631@xps-13>
 <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
 <20230412113654.183350d0@xps-13>
 <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
 <20230412141824.755b2bca@xps-13>
 <eedaaed9-0a41-2c18-9eb2-792613566986@sberdevices.ru>
 <20230412145715.58c2be4a@xps-13>
 <7c996832-258f-001c-56bd-87bbdf23eeaa@amlogic.com>
 <20230412163214.0c764bb3@xps-13>
 <0c61eaae-053e-5768-a533-70b2ff0cc95d@amlogic.com>
In-Reply-To: <0c61eaae-053e-5768-a533-70b2ff0cc95d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR0101CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::26) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|PSAPR03MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: bca94fe2-8baf-4b55-619b-08db3be5ef49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhwuSspzfVOKwip+gw4enDDoRButqpnc4BFc2mTGGg+Ns5PgblBgrMxEy07ZTx37WmfxHNFhQAJ1KC6nBWO+DfUAuRQsEubzBMpnDhPXM7giUjxfeNnOAZAmYm6Ywa1M1nAbtr2sjsXi0Eb6Q3IflOyiuDVxjIHQzs1SAQ3z3/9c5fMTWqHNb1Zt3Uv+LbFe2noeE9HG8w9PCyOsos8qyHp1GKTS0LvADtNP76qcCSYD86uqf+nJWUlK9J3lFPbPxX7hdjst68uCiM7llfK98p91Bg8sUnK9ZTlWhcdlSObbodebg1YH+xzkI03mvdtyNxt7A4xACv4i7Q48ksnGKh/e1wrUE3iw/T/TZbMdjNOQ3bp/GLHLv1Ml+LN/Xm8iN3IS1SWVMuHzyKvq6tFfdYPZa2vYtxOZ59i8Y1pdstIIvNkRVDT/HBv6qjl+6D6sbTAyWJQeobv6AlwsivPp2ihk5uHWdGT6zm23dVfM2OBC2qVRetxdWqFdFvnpeAgJM4CmS3Ionp7fRsjOCyslkVA4LSCC+cinNinqZMel4n0RyaRqVpYL3xm/q2yroyEXyBI6kqvMoCeogiaJ8zZnUXKKlOAiqtKJK6bOLNEQJJOAOSMeOHJt/5Vtud2Abq+6/MMLhlw/1CO2HP7Ec8YGtbZIqvBmsCEf87JrDlLCZrYkDvT/8XoSl4siGqiNSJVIl8ulJk+2I4JHOcnkdKaYN4T7njO15bZV7p0te6xxKlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39850400004)(346002)(366004)(451199021)(31696002)(86362001)(36756003)(2906002)(31686004)(2616005)(6666004)(52116002)(6486002)(66574015)(53546011)(83380400001)(186003)(6512007)(107886003)(26005)(6506007)(66476007)(66556008)(6916009)(7416002)(8936002)(4326008)(478600001)(38350700002)(8676002)(316002)(38100700002)(41300700001)(5660300002)(44832011)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djF0cjdML2lvdlAwUHV2ZkoxK2JwOVpPYm56MXZjOWtLU3ZEWWtSQWw0ZUpD?=
 =?utf-8?B?MkxIR3JxR2VPN1dSbFNtSjdnTzd1L2JybHpzYm9tMUxDYW93K2ZmSmZwTk1T?=
 =?utf-8?B?Y01FTDRBamlSMXVmVTgzZTl3QnF3Z0xqcDJNUXFVQTVFSzg3cmd5SnpNbkU4?=
 =?utf-8?B?eHNma0NuZ2FiRnkvcHYvQUs5a3h3NDFoanBpaEZ4bmhZWjlZZ3BYLzhPV2hl?=
 =?utf-8?B?K3pnMjNyQ3Z3QVd6dmVCUmxSU0ROMHNSVC93d1NPZnROczVBaW5GMHlpZ0xt?=
 =?utf-8?B?dytxc2dsZHpZanBBYTYzOGlLa1RKMjNVOU5XV0ZaeDk0Qk5JaXl1Z0NkMlR4?=
 =?utf-8?B?amlhbFBqdkJzVjU2N0lGcWNjdDBKTGlTaFJqSFVUWGFyV2Z2RW0rS2lVWXpa?=
 =?utf-8?B?ZnZsK2xtRkpDYjNTZG1aVGZ4ZjluYXNBNnJUOEp6eFpkb1h4dU94Q2tocE1E?=
 =?utf-8?B?S096N1FJVVRPenZmWVNEZnNteGJ3SXZMVGlSemR4TWg1WGh3YngzOTd4U2J3?=
 =?utf-8?B?Y1gzeCtaUG1jU0FhOGVQQ1VscHJlejRDZzZpcnNOczJWMFk4clM1aHc3emxz?=
 =?utf-8?B?ZFo2TmFuOTZTUjBzdHE5QVB0R0tLdWVqOEhyWEw3TWtrY1ZzcG16dE03dUpk?=
 =?utf-8?B?cUpJMnh3RkFVTE0xQmU3aTJXemtsZWY1NllkeUlGbkdOa2xEcUhaVDI3VmRj?=
 =?utf-8?B?MFVHbGl0K2t2RjJWcFFabzEwYzBTZ3RUZjEyUUI5TGQwNUViVHNLbE9xR21E?=
 =?utf-8?B?NWdwekxpeHVWSGliRU9kVGNFb3JvTTBBSDZabE8za256dTA5ZzM0dHNHanhv?=
 =?utf-8?B?VVk4ak9hbXRybW4zcnNzeUpKbDQyS2N2THozT2JCNXZuMEo1RTZ4d0lwTHZI?=
 =?utf-8?B?cDN6UWJFY1ovNVlRa2djaHNIdS9Mczgwb05qcmQ0dlVxRDZqeXpqbTE1MUYv?=
 =?utf-8?B?dE4rQTM1MEtxOVpqcWgwc0l2cXp5UFpGNi9QMDBCQVNiR2tlQTliQ25PV2JV?=
 =?utf-8?B?RHA0ZlJXaWNRZlROMi8yVEJvVW92RmdwbU1MNWVSalZ5L2ZuRnVwODNpaUtz?=
 =?utf-8?B?M3NpZTR1UWJJcEdXTjhwUUp0VXo1ZlRPUnRrMmRHN2I5WjVXc2FuU1AyRnln?=
 =?utf-8?B?RDkwMHRTQTVZVGZnb3dhMDYrN1R2RXpEblRXZ1BFcjRiMFI1UW5oZ0loZ0o4?=
 =?utf-8?B?NGR2QkREcWlzNGFFRlhwb2ZTazBicVhFWXpGSXFnbThBaEZtK2JoUmsyODFS?=
 =?utf-8?B?UkFpdkx4THhOWEZsRDNaem9nN3gzUzhwRkVaSGRISEo4UFFHZjZYUEZLaDRv?=
 =?utf-8?B?SWtLVThzNDBPRUE2SjY4VzVGcWRMM2tBaVF5RTYvMDAyVHIzQUUzQ3g1RWxU?=
 =?utf-8?B?VmlVZy9FNzBjNjQwalBNcDUxWlRjUlZYem9hYWRwNFhLeHlWNHF1WXgrQjJB?=
 =?utf-8?B?ZXBRZ3ZjalliUG9PM2k1Q3ZKUWFRSkxVWWM0MHcvcDhEeU9GcjlzcTJ3dFBs?=
 =?utf-8?B?VlhVZmt6K0VLWlluZXFwTDYxMGlBbGhwY0JWakFiYWVqQU0rOXZSOXFTV241?=
 =?utf-8?B?MlpkTTN0RUJzV0ZiNXQ2c2k4UWJLWlRSTld5QUw1NW1GTTNNNkZoR1NETnFt?=
 =?utf-8?B?cUxVV2pJZmc0eUw2OTFpZjJPb1VzVHd4K0RXMGFmb1JudkZFUDVWNzJSdFlX?=
 =?utf-8?B?MldjWmRNUHcvV1ZnVHZpTmpaUmY1K004OWpJM05XNCtIbGRNS0k2Nnk2OFda?=
 =?utf-8?B?dlJ1cjdGR3lrelNCUk5BS05RTEo5K0crd3hVRDRuSjNYQWtVclpMdWNaU09B?=
 =?utf-8?B?VFNBUWpmUlNPSlRNZGROTjMwRWVONmlDcjFGU1kxTmVST3haY2NDTjRYRjhh?=
 =?utf-8?B?N0ZHZnR4aVFvc1VmYlRwWXh6cDdPOFRQaGJrUllOSytUMmY5QU4xWG9jdk92?=
 =?utf-8?B?TVN5WDJLOTlodWFNQi92TUQyV0xsOW90eC91K2g4SE5wa0F3QTliQUMwM2Zp?=
 =?utf-8?B?WmdHNWpkQ2hveGJaQ2I3TzBKM0I4MENjSTR2b3NZVDNTSGd6L1RqVnJ6TFFQ?=
 =?utf-8?B?eW10R0hmL1NpY05iSnZGdW9Ib2dxOUErUUNaNVMwSEtySERlb201UXYrQTQ1?=
 =?utf-8?B?cFFKVXVYcVBVWDhtQ0g2dEZBQWM0RFJBcjhGZGpRMVlFcFJmMjNmRHdRN2Vu?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca94fe2-8baf-4b55-619b-08db3be5ef49
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 06:11:35.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlc22cOmKWwSoTQ9KfwJDD49XtPWPNZptniaEwTOMaXzqH2wGXuffbx4Jn4KgyKeRKMgmyOY9Qoi5TENVufg+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6282
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/13 13:32, Liang Yang wrote:
> Hi Miquel,
> 
> On 2023/4/12 22:32, Miquel Raynal wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hello,
>>
>> liang.yang@amlogic.com wrote on Wed, 12 Apr 2023 22:04:28 +0800:
>>
>>> Hi Miquel and Arseniy,
>>>
>>> On 2023/4/12 20:57, Miquel Raynal wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> Hi Arseniy,
>>>>
>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 15:22:26 +0300:
>>>>> On 12.04.2023 15:18, Miquel Raynal wrote:
>>>>>> Hi Arseniy,
>>>>>>
>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +0300:
>>>>>>     >>>> On 12.04.2023 12:36, Miquel Raynal wrote:
>>>>>>>> Hi Arseniy,
>>>>>>>>
>>>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300:
>>>>>>>>       >>>>>> On 12.04.2023 10:44, Miquel Raynal wrote:
>>>>>>>>>> Hi Arseniy,
>>>>>>>>>>
>>>>>>>>>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 
>>>>>>>>>> +0300:
>>>>>>>>>>         >>>>>>>> This NAND reads only few user's bytes in ECC 
>>>>>>>>>> mode (not full OOB), so
>>>>>>>>>>
>>>>>>>>>> "This NAND reads" does not look right, do you mean "Subpage 
>>>>>>>>>> reads do
>>>>>>>>>> not retrieve all the OOB bytes,"?
>>>>>>>>>>         >>>>>>>> fill OOB buffer with zeroes to not return 
>>>>>>>>>> garbage from previous reads
>>>>>>>>>>> to user.
>>>>>>>>>>> Otherwise 'nanddump' utility prints something like this for 
>>>>>>>>>>> just erased
>>>>>>>>>>> page:
>>>>>>>>>>>
>>>>>>>>>>> ...
>>>>>>>>>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>>>>>>>>>     OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
>>>>>>>>>>>     OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
>>>>>>>>>>>     OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
>>>>>>>>>>>     OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>>>>> ---
>>>>>>>>>>>    drivers/mtd/nand/raw/meson_nand.c | 5 +++++
>>>>>>>>>>>    1 file changed, 5 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c 
>>>>>>>>>>> b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> @@ -858,9 +858,12 @@ static int 
>>>>>>>>>>> meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>    static int meson_nfc_read_page_raw(struct nand_chip *nand, 
>>>>>>>>>>> u8 *buf,
>>>>>>>>>>>                       int oob_required, int page)
>>>>>>>>>>>    {
>>>>>>>>>>> +    struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>>>>>>        u8 *oob_buf = nand->oob_poi;
>>>>>>>>>>>        int ret;
>>>>>>>>>>>    >>>>>>>> +    memset(oob_buf, 0, mtd->oobsize);
>>>>>>>>>>
>>>>>>>>>> I'm surprised raw reads do not read the entire OOB?
>>>>>>>>>
>>>>>>>>> Yes! Seems in case of raw access (what i see in this driver) 
>>>>>>>>> number of OOB bytes read
>>>>>>>>> still depends on ECC parameters: for each portion of data 
>>>>>>>>> covered with ECC code we can
>>>>>>>>> read it's ECC code and "user bytes" from OOB - it is what i see 
>>>>>>>>> by dumping DMA buffer by
>>>>>>>>> printk(). For example I'm working with 2K NAND pages, each page 
>>>>>>>>> has 2 x 1K ECC blocks.
>>>>>>>>> For each ECC block I have 16 OOB bytes which I can access by 
>>>>>>>>> read/write. Each 16 bytes
>>>>>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So when 
>>>>>>>>> I read page in raw mode
>>>>>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is 
>>>>>>>>> reported as 64 bytes.
>>>>>>>>
>>>>>>>> In all modes, when you read OOB, you should get the full OOB. 
>>>>>>>> The fact
>>>>>>>> that ECC correction is enabled or disabled does not matter. If 
>>>>>>>> the NAND
>>>>>>>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>>>>>>>
>>>>>>>> What happens sometimes, is that some of the bytes are not protected
>>>>>>>> against bitflips, but the policy is to return the full buffer.
>>>>>>>
>>>>>>> Ok, so to clarify case for this NAND controller:
>>>>>>> 1) In both ECC and raw modes i need to return the same raw OOB 
>>>>>>> data (e.g. user bytes
>>>>>>>      + ECC codes)?
>>>>>>
>>>>>> Well, you need to cover the same amount of data, yes. But in the ECC
>>>>>> case the data won't be raw (at least not all of it).
>>>>>
>>>>> So "same amount of data", in ECC mode current implementation 
>>>>> returns only user OOB bytes (e.g.
>>>>> OOB data excluding ECC codes), in raw it returns user bytes + ECC 
>>>>> codes. IIUC correct
>>>>> behaviour is to always return user bytes + ECC codes as OOB data 
>>>>> even in ECC mode ?
>>>>
>>>> If the page are 2k+64B you should read 2k+64B when OOB are requested.
>>>>
>>>> If the controller only returns 2k+32B, then perform a random read to
>>>> just move the read pointer to mtd->size + mtd->oobsize - 32 and
>>>> retrieve the missing 32 bytes?
>>>
>>> 1) raw read can read out the whole page data 2k+64B, decided by the 
>>> len in the controller raw read command:
>>>     cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
>>> after that, the missing oob bytes(not used) can be copied from 
>>> meson_chip->data_buf. so the implementation of 
>>> meson_nfc_read_page_raw() is like this if need.
>>>     {
>>>         ......
>>>         meson_nfc_read_page_sub(nand, page, 1);
>>>         meson_nfc_get_data_oob(nand, buf, oob_buf);
>>>         oob_len = (nand->ecc.bytes + 2) * nand->ecc.steps;
>>>         memcpy(oob_buf + oob_len, meson_chip->data_buf + oob_len, 
>>> mtd->oobsize - oob_len);
>>>
>>>     }
>>> 2) In ECC mode, the controller can't bring back the missing OOB 
>>> bytes. it can read out the user bytes and ecc bytes per 
>>> meson_ooblayout_ops define.
>>
>> And then (if oob_required) you can bring the missing bytes with
>> something along:
>> nand_change_read_column_op(chip, mtd->writesize + oob_len,
>>                oob_buf + oob_len,
>>                mtd->oobsize - oob_len,
>>                false);
>> Should not be a huge performance hit.
> 
> After finishing ECC mode reading, the column address internal in NAND 
> device should be the right pos; it doesn't need to change the column 
> again. so adding controller raw read for the missing bytes after ECC 
> reading may works.
> 
use raw read for the missing bytes, but they are not protected by host 
ECC. to the NAND type of storage, is it ok or missing bytes better to be 
filled with 0xff?

>>
>>>
>>>>
>>>> This applies to the two modes, the only difference is:
>>>> - with correction (commonly named "ECC mode"): the user bytes and ECC
>>>>     bytes should be fixed if there are any bitflips
>>>> - without correction (commonly referred as "raw mode"): no correction
>>>>     applies, if there are bitflips, give them
>>>>
>>>> Please mind the raw mode can be slow, it's meant for debugging and
>>>> testing, mainly. Page reads however should be fast, so if just moving
>>>> the column pointer works, then do it, otherwise we'll consider
>>>> returning FFs.
>>>>
>>>> Thanks,
>>>> Miquèl
>>>
>>
>>
>> Thanks,
>> Miquèl
>>
> 

-- 
Thanks,
Liang
