Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEBE6EF42A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbjDZMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbjDZMS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:18:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04AE2D4D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcB796A60YtmZDg2gOHGm1eMxxigvTg4nTBDMpFK2DRxhVDi3pBW5v9FjCbbUIu/9T+tW06/SAbbvczFrsavFaD8frhCa2sT0wsGiERLuNRBvsrhIqiaCGCVcNDYZpIxzTzjNWLbqbH4HPoirG5+rRQ1LubeYP/cLVyXKV/VPvSJzgxah6zk7nwD/GRsG3J9w6QYupd6/YpkpKDIRtqaza0+UcHFkjQXiKR7ep7Jihnuu5ciCryPgtKKDmAz0F160xkFqBkklCcImZ3OenlgxJvErjaEyletoQ5+odojn8ic68nsr++nTOEQRKFXV2v6thOGUyX2qzzN+7E6gviOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfzvh1j4dDrXAnmINyFKWDRBU4btnEp+HWtq5Z5a8RI=;
 b=jiCECTddKbwJHmPGuGaU9+DNIUeRiwvMcnpnawin5X8I7N7ZM/h8nEDmIvDXCAjTAfzA9Km4/gYPmyxv9IZAx71bM1GRvh0RXO5FkNJsRycrsYdaFRhaztCzwBnqd4NHbxpIpC7vFkGOffhbDI/+7QmETsF8RS35unS107WMvUg19eibmaRCwBRyIdP2PlZmktHlFy6iYgq+2wAlmnxKktf4RegqVdYCTLtjVWQrj4CwoJGG868/ZdP/++O77zX4cvTQV7x4SdP4QNAIPuHddQgqm1//0F7CIJrwZgOjnrHLH9EyjtRRaX5mshZUERZ+13J5sv/BBN1srYBnYMQRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfzvh1j4dDrXAnmINyFKWDRBU4btnEp+HWtq5Z5a8RI=;
 b=zzaQEi1N4l7PqoBTo0lohcd/hM6AQlKIkysWldKAXkvpRY803NeZ6G9+jb1QL2MjqArnr0dc3rQgR8vuywCnOurwx07p3+I3z4T0ltCJKwFLidMzYcoLEAkvrLAoO988HCdp0D2XqO8k9YObMYc/3va7Q5BIaxZHewV/emxYrkldwL5Gh2YsVJn32AmOoV/fF4q/6xYof5QIRold0CXkFR9k9xEZKM2d6MId1cE1ofgt6q54zOkni/Su/hBtv+oAL1qtc9AUU6nG0MzkFliOG2Lc3Wd3ZUns9zrn3SMl70+HFbkDzfnK1eKj+0S9DcG6Da0ekLzzICxcoKYcrVTSKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by KL1PR0302MB5220.apcprd03.prod.outlook.com (2603:1096:820:45::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 12:18:03 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%4]) with mapi id 15.20.6319.035; Wed, 26 Apr 2023
 12:18:03 +0000
Message-ID: <1f32ad9e-fe2f-1248-164f-a5d328b22942@amlogic.com>
Date:   Wed, 26 Apr 2023 20:17:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/5] mtd: rawnand: meson: fix NAND access for
 read/write
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        "Aml_yonghui.yu" <yonghui.yu@amlogic.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-2-AVKrasnov@sberdevices.ru>
 <889cf54e-584c-9bee-2106-633155897324@amlogic.com>
 <3f247cbe-2798-4871-82a5-5124142fdcc5@sberdevices.ru>
 <4f552f57-c31e-985c-82be-081dff38d377@sberdevices.ru>
 <dc690524-51d5-7bb9-a106-fa153c4e6250@amlogic.com>
 <68f3bea8-4b79-db48-172f-712dcabce65b@sberdevices.ru>
 <d3d5cf52-cf1e-31d1-46c5-d1df06c61fb3@amlogic.com>
 <ac6d67ce-54e3-83f4-fef4-fb93bdef2515@sberdevices.ru>
 <6c573ffd-55a1-6a39-1ca1-c2681e0e960d@amlogic.com>
 <44dd5bcc-2b98-d402-7e8f-5e2d4babf898@sberdevices.ru>
 <ed74240c-5028-c151-7904-c437b87c5f2a@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <ed74240c-5028-c151-7904-c437b87c5f2a@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::10) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|KL1PR0302MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9af14f-1508-47c0-6a86-08db4650485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuKqY+Vh9WFDTSDG7dRD65ir490P4eT10ILbM2Gagvr2cWCZZW3Ukbxi3os5f2Nmz7kztNoy+IcQxtq8pq2DBZbIe/GZT/A5YTGkvfdfLqAMJXKKM+udTCBDDBpEcNGrjaUJAF/XIyfI28OfkrWNwZFyDN8e0dmKgzraW/90EY4msfTB8qxmAYa/fRpwk7gqT8dfjI7oo9HVGvprpm8738ujUIEJq9tDtgPMMYYF4tZf4EAywjFWg1geQ1NnGCx3M1XWdiWFXpVtoLNc2MdD96aNyuKpdoJHxv0ZnI7USfPHFxt0toj3HKbxsjfqKOObMURw2xjSBjkz5xr4DpsURdyY02xpMnpXgMkCHOOCT0aUpOJ1wOCiV09u+EU+bch9QllisWaur4hSPMreiasdtuI04kwM9+5nYPtAXMSpUh5pneGmiy/QYtXOdJ9REet1/LKZF5o0ni+zqmgeaS3LWh7G4NTNHLQmkyJuNaH/MLWA3Gzi1XCWXTd4kGVZxstfDacQ8cgFMLyEV6Ma1DcbWQtskW0n1yl8jBAAdDOSN/UvH6Bg8ubPL0mMHsdLu1vHieUmxDcIJyoVvP3XoAKd+AChbq/LqO12uJzd60X8kG+/sZNonYY7M8dYHupr/ClYkh2SF5zfceH2fsanJXGdY0I+DaZ9FB49parIh08iG6mrMxj/1rZYhdH7ML5ImmR0B5OmEkxN38SUtqccJEPcfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(136003)(39850400004)(451199021)(66946007)(478600001)(66556008)(110136005)(41300700001)(8676002)(38100700002)(38350700002)(8936002)(66476007)(7416002)(6636002)(6512007)(6486002)(4326008)(316002)(921005)(186003)(53546011)(83380400001)(6666004)(2616005)(52116002)(26005)(6506007)(86362001)(31696002)(30864003)(36756003)(2906002)(44832011)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDdpd1RodVRYaTMxaTVvRUlvWU1lc2NrNVIwNU9MU3BBbjVNTnJzams1MEFV?=
 =?utf-8?B?TGxOWkpLYThPU0JtSDMvWVpITXZGQVEvRkM3UlBtVEk1YUVlcXNYMFp0QzJN?=
 =?utf-8?B?bnFWczhKUUVyNmRRTW9yREZXblFGM0xmRzYwcUtXTGpZRmp3RitNdDVOMGV0?=
 =?utf-8?B?TGVUZWhZTUxZeUFRWHR3cmFOYmllNUw3R3Zmc09lTDNCMmtpbU44UHJaeW0r?=
 =?utf-8?B?VDNUNkhJY29CcXVGVkZjbUZDcDB4enR3S2tZYjdmYlU3VzFJbHJXdjNVbGJa?=
 =?utf-8?B?dGdiNXMwT1BLUmRoT2QzdnpXU1J5cFFqVEJqVms0aVBySENXOHVLZ0dPNzNV?=
 =?utf-8?B?VEZHMDU4OGRLMVdGSnpUNkZMMnd0elZvSHVDL0JmMmY0Tm5MSGVUbkNIaGVW?=
 =?utf-8?B?R1N6OUlBek9TdG5BK0tkRmZSNDdUSzRNS3o5dXJwZlZmTFhIY2FTZmVnNENC?=
 =?utf-8?B?TFhuRlBkc2NaMFlzTkFWYXFOakFTNXRNWG45ZDNHSWdFbzFLekFlaThnS096?=
 =?utf-8?B?MHRZNVRqT0p6RzVDZ29tQTNxWS9LU2M1dlpXL282TUhNT2FidXMybXFFc1Iy?=
 =?utf-8?B?Mk0yMDRBdXczSGwra3crd3Jvak0zcmVTUU4zMzdMckVQaXl3L0Vuemo5c1I2?=
 =?utf-8?B?cjEwVzVzOGpENEI4SWw2R21OWVQxQldlTnZML01WL0orRWpDRDU1WW9Oall0?=
 =?utf-8?B?ZExwWjEwYXJZbEQzczI2MXl6Q1N5RHpPeVZEeHY4V1owQnA0UFFMSzF5bnFH?=
 =?utf-8?B?akEybWJBNDVBc0gwOWgwSGZvSFllTjR4Z3JWRXEwR0tsaCtJcXk4aTF0Vm9K?=
 =?utf-8?B?RWlVYmdIcmtYamdyWTRRNUFyMDFkSVFYeGVyZHIvMFRINitmOEcyVjhPY1RM?=
 =?utf-8?B?MCtZN2duL0N5VmNaTmhIbmI0aU9zb0FLR3lTbk9EMEl3K3RoQmRSTGMzWkhE?=
 =?utf-8?B?UGx4RVJhS0NjYlprRGlCbGpIb2taZkFvWHV1a0U1ZlJQMWFvZzNjZnB0SG1o?=
 =?utf-8?B?MG5RMmhXRjlGTzNZSE0wRmtUeDAxcFJGcjl2d0FURmlOaytjdVh5V3pScnc5?=
 =?utf-8?B?aktHMmEybFl1ZXFRSkdUa0l0ZlRBbXRzalFHTFY4eGxEOFVyL2RvZXloQ1lp?=
 =?utf-8?B?VGoraFdBcmc5cEE1aG9haWVtRzlQVGE3Zy9rT0R0RTNZb3UrbSs4UXduNkM4?=
 =?utf-8?B?bERqanZhSzQ0aitnTjQrZWQ4UGZiQTF5aktIc2Q5WjlzTWppdHlmdXRQTXB4?=
 =?utf-8?B?N1dNVVNXL01BczNQMTJ6dWlUYndrYkY5eG5yQWJZclRRaXIxSEEvYlVlc2hz?=
 =?utf-8?B?Z1h6Y001czV3YXpBajNYVzM3eFJObkVtQnBib2Nxd3czaUs0K2U3RDF5SWpD?=
 =?utf-8?B?TGVGeWk5SjVtNm90bXNEeGxKN2c2ZXV3TWF2Q0o1Q1p5R3NwMXJSc2t5VmI1?=
 =?utf-8?B?T0VweU83cTA3ajUrbnJjOG5UMkxuWElDODBoSUtLc1A0TVlUVzYxTFRjR3Q4?=
 =?utf-8?B?eDExMHljcmg0Vjc2akVvb0FxeWNMNEh0ZWFwTUFGYnNDaWZvL08xdTNTYVRv?=
 =?utf-8?B?WjR5SndWU2JGdjZXcHYrSmxmWDJ6SHI3YVdPK2JkSGIrc0t3U0Rtbm5qN3N2?=
 =?utf-8?B?THhxSGU5S0o5QVc5MEptMFJkdU1xb0RRN2FFVXNsaU1aQjVIQWRqVHUyUG9B?=
 =?utf-8?B?WW1TSGxVWi9IOVYwL3IvUzJYb3d4cGlCQTFPMllDcVlsM2xtZUxUcGJwdDBo?=
 =?utf-8?B?a1MwK0VQWVZsVSs5ZmowRDUrN0VCVzFZL1RMZUdrVWpUYzFQQUNoQXVLQXB6?=
 =?utf-8?B?SWF6R2d2Y1RsNm5veDVWWWc5elhEZHorRE9PcmxRaHVlb3ZkNmRiUnVNL1VM?=
 =?utf-8?B?VlBGUnNIUyswTDlTUDBRUzhFSVJ0Yy9KY28vWHRGV3hmVUszdVRKcU1COGtP?=
 =?utf-8?B?bU0zdXY0VVV4dUQxUGZGTzhaWXhyTkFMWGozaEM0QmpiSTR4RDNDeFJzWlhY?=
 =?utf-8?B?VktnL0NWeVQvcHloc3p0Mnc5SmxlcEdadERuU20wT3BGYmhIQ0NGMk02dU5a?=
 =?utf-8?B?VGlsQ0Z0eEFGMFdlQTFxR2RzTFlPaHFIaGYxMmZpbUhSenc1UzBSNkdqcWY2?=
 =?utf-8?Q?oZrGCHEbUQuwW05PfL3NxG4F1?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9af14f-1508-47c0-6a86-08db4650485d
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:18:03.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhbpx0K/Fl52E20sOTUyNPSkuhkM+5f2F/ym1taCUB3oR8HJzSP8pHEmPAkNtYazOxfCCZmgy2j2fNHIPOVWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5220
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On 2023/4/20 3:43, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> On 17.04.2023 17:10, Arseniy Krasnov wrote:
>>
>>
>> On 17.04.2023 16:54, Liang Yang wrote:
>>> Hi Arseniy,
>>>
>>> On 2023/4/17 14:47, Arseniy Krasnov wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>>
>>>>
>>>> On 13.04.2023 08:57, Liang Yang wrote:
>>>>> Hi Arseniy,
>>>>>
>>>>> On 2023/4/13 13:10, Arseniy Krasnov wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12.04.2023 16:30, Liang Yang wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 2023/4/12 20:03, Arseniy Krasnov wrote:
>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12.04.2023 13:24, Arseniy Krasnov wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 12.04.2023 12:37, Liang Yang wrote:
>>>>>>>>>> Hi Arseniy,
>>>>>>>>>>
>>>>>>>>>> Thanks for pointing out this problem. also comment inline.
>>>>>>>>>>
>>>>>>>>>> On 2023/4/12 14:16, Arseniy Krasnov wrote:
>>>>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>>>>
>>>>>>>>>>> This fixes read/write functionality. New command sequences were ported
>>>>>>>>>>> from old vendor's driver. Without this patch driver works unstable. This
>>>>>>>>>>> change is tested with 'nanddump'/'nandwrite' utilities and mounting
>>>>>>>>>>> JFFS2 filesystem on AXG family (A113X SoC).
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>>>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>>>>> ---
>>>>>>>>>>>       drivers/mtd/nand/raw/meson_nand.c | 116 ++++++++++++++++++++++++++----
>>>>>>>>>>>       1 file changed, 101 insertions(+), 15 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> index 074e14225c06..256c37c76526 100644
>>>>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>>>>>       #define NFC_CMD_IDLE        (0xc << 14)
>>>>>>>>>>>       #define NFC_CMD_CLE        (0x5 << 14)
>>>>>>>>>>>       #define NFC_CMD_ALE        (0x6 << 14)
>>>>>>>>>>> +#define NFC_CMD_DRD        (0x8 << 14)
>>>>>>>>>>>       #define NFC_CMD_ADL        ((0 << 16) | (3 << 20))
>>>>>>>>>>>       #define NFC_CMD_ADH        ((1 << 16) | (3 << 20))
>>>>>>>>>>>       #define NFC_CMD_AIL        ((2 << 16) | (3 << 20))
>>>>>>>>>>> @@ -84,6 +85,7 @@
>>>>>>>>>>>         #define DMA_BUSY_TIMEOUT    0x100000
>>>>>>>>>>>       #define CMD_FIFO_EMPTY_TIMEOUT    1000
>>>>>>>>>>> +#define DEVICE_READY_TIMEOUT    1000
>>>>>>>>>>>         #define MAX_CE_NUM        2
>>>>>>>>>>>       @@ -255,8 +257,26 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>>>>>>>>>>>           }
>>>>>>>>>>>       }
>>>>>>>>>>>       +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>>>>>> +                     unsigned int timeout_ms)
>>>>>>>>>>> +{
>>>>>>>>>>> +    u32 cmd_size = 0;
>>>>>>>>>>> +    int ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    /* wait cmd fifo is empty */
>>>>>>>>>>> +    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>>>>>> +                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>>>>>> +                     10, timeout_ms * 1000);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        dev_err(nfc->dev, "wait for empty CMD FIFO timed out\n");
>>>>>>>>>>> +
>>>>>>>>>>> +    return ret;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>       static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>>>>>>>>>>>       {
>>>>>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 0);
>>>>>>>>>>> +
>>>>>>>>>>>           writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>>>>>>>>>>>                  nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>>       }
>>>>>>>>>>> @@ -308,23 +328,9 @@ static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>>>>>>>>>>>            */
>>>>>>>>>>>           meson_nfc_cmd_idle(nfc, 0);
>>>>>>>>>>>           meson_nfc_cmd_idle(nfc, 0);
>>>>>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 1000);
>>>>>>>>>>>       }
>>>>>>>>>>>       -static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>>>>>> -                     unsigned int timeout_ms)
>>>>>>>>>>> -{
>>>>>>>>>>> -    u32 cmd_size = 0;
>>>>>>>>>>> -    int ret;
>>>>>>>>>>> -
>>>>>>>>>>> -    /* wait cmd fifo is empty */
>>>>>>>>>>> -    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>>>>>> -                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>>>>>> -                     10, timeout_ms * 1000);
>>>>>>>>>>> -    if (ret)
>>>>>>>>>>> -        dev_err(nfc->dev, "wait for empty CMD FIFO time out\n");
>>>>>>>>>>> -
>>>>>>>>>>> -    return ret;
>>>>>>>>>>> -}
>>>>>>>>>>>         static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>>>>>>>>>>>       {
>>>>>>>>>>> @@ -631,6 +637,48 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>>>>>>>>>           return 0;
>>>>>>>>>>>       }
>>>>>>>>>>>       +static uint8_t meson_nfc_read_byte(struct nand_chip *nand)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>>>>> +
>>>>>>>>>>> +    writel(NFC_CMD_DRD, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>> +    meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>>>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>>>>>> +
>>>>>>>>>>> +    return readl(nfc->reg_base + NFC_REG_BUF);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static int meson_nfc_wait_dev_ready(struct nand_chip *nand)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>>>>>> +    unsigned long cnt = 0;
>>>>>>>>>>> +
>>>>>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>>>>>> +
>>>>>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_STATUS, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>> +
>>>>>>>>>>> +    /* 10 ms. */
>>>>>>>>>>> +    while (cnt < DEVICE_READY_TIMEOUT) {
>>>>>>>>>>> +        uint8_t status;
>>>>>>>>>>> +
>>>>>>>>>>> +        status = meson_nfc_read_byte(nand);
>>>>>>>>>>> +
>>>>>>>>>>> +        if (status & NAND_STATUS_READY)
>>>>>>>>>>> +            break;
>>>>>>>>>>> +
>>>>>>>>>>> +        usleep_range(10, 11);
>>>>>>>>>>> +        cnt++;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    if (cnt == DEVICE_READY_TIMEOUT) {
>>>>>>>>>>> +        dev_err(nfc->dev, "device ready timeout\n");
>>>>>>>>>>> +        return -ETIMEDOUT;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>       static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>>>>                           int page, int raw)
>>>>>>>>>>>       {
>>>>>>>>>>> @@ -643,6 +691,10 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>>>>           u32 cmd;
>>>>>>>>>>>           int ret;
>>>>>>>>>>>       +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           meson_nfc_select_chip(nand, nand->cur_cs);
>>>>>>>>>>>             data_len =  mtd->writesize + mtd->oobsize;
>>>>>>>>>>> @@ -667,12 +719,20 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>>>>                            NFC_CMD_SCRAMBLER_DISABLE);
>>>>>>>>>>>           }
>>>>>>>>>>>       +    ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>>>>>>>>>           writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>>           meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>>>>>>>>>>>             meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>>>>>>>>>>       +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           return ret;
>>>>>>>>>>>       }
>>>>>>>>>>>       @@ -720,6 +780,21 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>>>>>>>>>           } while (!ret);
>>>>>>>>>>>       }
>>>>>>>>>>>       +static inline int meson_nfc_send_read(struct nand_chip *nand)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>>>>>> +    int ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>> +
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>
>>>>>>>>>> it already calls meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute(). Could you implements this in meson_nfc_queue_rb()? and we can use the irq method.
>>>>>>>>>> also without Ready/Busy pin, the meson_nfc_queue_rb() should change like below:
>>>>>>>>>>         ......
>>>>>>>>>>         #define NFC_CMD_RB_INT    ((0xb << 10) | BIT(18))
>>>>>>>>
>>>>>>>> Sorry, I can see this define as (and it is used in the driver):
>>>>>>>> #define NFC_CMD_RB_INT          BIT(14)
>>>>>>>>
>>>>>>>> in drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>
>>>>>>>> Which one is correct ?
>>>>>>>
>>>>>>> we need to modify the define 'NFC_CMD_RB_INT' as ((0xb << 10) | BIT(18)).
>>>>>>>
>>>>>>
>>>>>> Ok, NFC_CMD_RB_INT - it is "Ready/Busy_Interrupt" ? You suppose that currently it is
>>>>>> defined incorrectly, so irq waiting does not work?
>>>>>
>>>>> Previous defined BIT(14) is for having the external Ready/Busy pin of the NAND device connected to the controller. the new define is for reading status by sending read status(70H) command and read status from the data bus(checking the IO6). the both can work on AXG soc.
>>>>> when the controller RB command is sent, the controller automatically checks the level of external Ready/Busy pin or the data bus(IO6) periodicity. and generate the irq signal if status is ready.
>>>>>
>>>>>>
>>>>>> Thanks, Arseniy
>>>>>>
>>>>>>>>
>>>>>>>> Thanks, Arseniy
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>         meson_nfc_cmd_idle(nfc, 0);
>>>>>>>>>>         cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>>>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>         meson_nfc_cmd_idle(nfc, 5);
>>>>>>>>>>         cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>>>>>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>
>>>>>>>>>>         ret = wait_for_completion_timeout(&nfc->completion,
>>>>>>>>>>                           msecs_to_jiffies(timeout_ms));
>>>>>>>>>>         if (ret == 0)
>>>>>>>>>>             ret = -1;
>>>>>>>>>>
>>>>>>>>>>         writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>         ......
>>>>>>>>>>
>>>>
>>>> Hello Liang!
>>>>
>>>> I've got small questions to clarify Your comment. You suggest two thing IIUC:
>>>>
>>>> 1) Send NAND_CMD_READ0 from 'meson_nfc_queue_rb()'. This means that extra argument is needed to
>>>> 'meson_nfc_queue_rb()' which shows that read operation is going to be performed. We can't send
>>>> NAND_CMD_READ0 for write operation?
>>>
>>> it is ok to me. but does NAND_CMD_READ0 really need to send in the controller driver? i don't find the other controller drivers have to send it for the old vendor NAND device.
>>
>> Hm, I found this command in the old driver. For example without it I get the following error:
>>
>> # nanddump -c -s 0 -l 2048 /dev/mtd0 --oob
>> ECC failed: 3975
>> ECC corrected: 47
>> Number of bad blocks: 10
>> Number of bbt blocks: 0
>> Block size 131072, page size 2048, OOB size 64
>> Dumping data starting at 0x00000000 and ending at 0x00000800...
>>
>> But data is not corrupted and seems ok. With this extra NAND_CMD_READ0 everything is ok - data is still valid and
>> there are no ECC errors.

After sending NAND_CMD_READ0, address, NAND_CMD_READSTART and read 
status(NAND_CMD_STATUS = 0x70) commands, it should send NAND_CMD_READ0 
command for exiting the read status mode from the datasheet from NAND 
device. but previous meson_nfc_queue_rb() only checks the Ready/Busy pin 
and it doesn't send read status(NAND_CMD_STATUS = 0x70) command.
i think there is something wrong with the Ready/Busy pin(please check 
the hardware whether this Ready/Busy pin is connected with SOC) or the 
source code. i have the board without Ready/Busy pin and prefer to use 
the nfc command called RB_IO6. it sends NAND_CMD_STATUS command and 
checks bit6 of the status register of NAND device from the data bus and 
generate IRQ if ready.

>>
>>>
>>>>
>>>> 2) About code and define above, I tried to replace current body of 'meson_nfc_queue_rb()', but it
>>>> didn't work. May be I did it wrong, because what to do with 'meson_nfc_wait_dev_ready()' and it's
>>>> call sites? It must be removed? Could You please explain Your idea in more details? I'm asking You
>>>> because I don't have doc for this NAND controller, so it is very difficult to me to add valid
>>>> logic to this driver without any references
>>>
>>> Could you please try the following? i have tested it on another SOC (not axg).
>>>
>>> static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>> {
>>>      u32 cmd, cfg;
>>>      int ret = 0;
>>>
>>>      meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>      meson_nfc_drain_cmd(nfc);
>>>      meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>>
>>>      cfg = readl(nfc->reg_base + NFC_REG_CFG);
>>>      cfg |= NFC_RB_IRQ_EN;
>>>      writel(cfg, nfc->reg_base + NFC_REG_CFG);
>>>
>>>      reinit_completion(&nfc->completion);
>>>
>>>      meson_nfc_cmd_idle(nfc, 0);
>>>      cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>      writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>      meson_nfc_cmd_idle(nfc, 5);
>>>      cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>>>          | nfc->param.chip_select | nfc->timing.tbers_max;
>>>      writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>      meson_nfc_drain_cmd(nfc);
>>>
>>>      ret = wait_for_completion_timeout(&nfc->completion,
>>>                        msecs_to_jiffies(timeout_ms));
>>>      if (ret == 0)
>>>          ret = -1;
>>>
>>>      writel(1 << 31, nfc->reg_base + NFC_REG_CMD);
>>>
>>>      return ret;
>>> }
>>
>> Ok! Thanks, I'll try it!
>>
>> Thanks, Arseniy
> 
> Hello @Liang, I tried this code, seems with this implementation NAND driver works very slow,
> here is for example output buring bad blocks lookup:
> 
> [    2.060835] Scanning device for bad blocks
> [    3.350085] Bad eraseblock 20 at 0x000000280000
> [    3.536389] Freeing initrd memory: 11808K
> [   39.133952] Bad eraseblock 581 at 0x0000048a0000
> [   44.837917] Bad eraseblock 671 at 0x0000053e0000
> [   45.677964] Bad eraseblock 685 at 0x0000055a0000
> [   83.637917] Bad eraseblock 1279 at 0x000009fe0000
> [  132.833318] modprobe (56) used greatest stack depth: 12672 bytes left
> 
> 
> Take a look at timeouts. I used Your variant of 'meson_nfc_queue_rb()' from above,
> #define NFC_CMD_RB_INT is ((0xb << 10) | BIT(18)). I tested it with my ports of
> of dev ready calls from the old vendor's driver.
> 
> Thanks, Arseniy

Yes, there is something wrong. i make a patch and it works on AXG 
platfrom. please try it. Thanks.

diff --git a/drivers/mtd/nand/raw/meson_nand.c 
b/drivers/mtd/nand/raw/meson_nand.c
old mode 100644
new mode 100755
index 074e14225c06..529d1a41a4a4
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -37,7 +37,7 @@
  #define NFC_CMD_SCRAMBLER_ENABLE       BIT(19)
  #define NFC_CMD_SCRAMBLER_DISABLE      0
  #define NFC_CMD_SHORTMODE_DISABLE      0
-#define NFC_CMD_RB_INT         BIT(14)
+#define NFC_CMD_RB_INT ((0xb << 10) | BIT(18) | BIT(16))

  #define NFC_CMD_GET_SIZE(x)    (((x) >> 22) & GENMASK(4, 0))

@@ -392,7 +392,7 @@ static void meson_nfc_set_data_oob(struct nand_chip 
*nand,
         }
  }

-static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
+static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms, 
int cmd_read0)
  {
         u32 cmd, cfg;
         int ret = 0;
@@ -407,17 +407,29 @@ static int meson_nfc_queue_rb(struct meson_nfc 
*nfc, int timeout_ms)

         reinit_completion(&nfc->completion);

+       cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
+       writel(cmd, nfc->reg_base + NFC_REG_CMD);
+       meson_nfc_cmd_idle(nfc, 5);
+
         /* use the max erase time as the maximum clock for waiting R/B */
-       cmd = NFC_CMD_RB | NFC_CMD_RB_INT
-               | nfc->param.chip_select | nfc->timing.tbers_max;
+       cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
         writel(cmd, nfc->reg_base + NFC_REG_CMD);
+       meson_nfc_cmd_idle(nfc, 2);

         ret = wait_for_completion_timeout(&nfc->completion,
                                           msecs_to_jiffies(timeout_ms));
         if (ret == 0)
-               ret = -1;
+               return -1;

-       return ret;
+       if (!cmd_read0)
+               return 0;
+
+       cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
+       writel(cmd, nfc->reg_base + NFC_REG_CMD);
+       meson_nfc_drain_cmd(nfc);
+       meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
+
+       return 0;
  }

  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
@@ -623,7 +635,7 @@ static int 
meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
         if (in) {
                 nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | 
NAND_CMD_READSTART;
                 writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
-               meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
+               meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), 1);
         } else {
                 meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
         }
@@ -669,7 +681,7 @@ static int meson_nfc_write_page_sub(struct nand_chip 
*nand,

         cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
         writel(cmd, nfc->reg_base + NFC_REG_CMD);
-       meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
+       meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), 0);

         meson_nfc_dma_buffer_release(nand, data_len, info_len, 
DMA_TO_DEVICE);

@@ -952,7 +964,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
                         break;

                 case NAND_OP_WAITRDY_INSTR:
-                       meson_nfc_queue_rb(nfc, 
instr->ctx.waitrdy.timeout_ms);
+                       meson_nfc_queue_rb(nfc, 
instr->ctx.waitrdy.timeout_ms, 0);
                         if (instr->delay_ns)
                                 meson_nfc_cmd_idle(nfc, delay_idle);
                         break;
> 
>>
>>>
>>> also we need to check and return the return value for meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute() and meson_nfc_write_page_sub().
>>>
>>>>
>>>> May be I can send v2 patchset for review without this change, as v2 already includes udpate for OOB
>>>> handling which is I think more critical?
>>>>
>>>
>>> sure, it is up to you. it is more important, thanks again.
>>>
>>>> Thanks, Arseniy
>>>>
>>>>>>>>>
>>>>>>>>>         Thanks for reply! I'll try this code! One more question about OOB processing in this
>>>>>>>>> driver (as You are author of it):
>>>>>>>>>
>>>>>>>>>        OOB size is 64 bytes, but for example if I have 1K ECC, 2 bytes user bytes and 14
>>>>>>>>>        bytes for ECC code for each 1K. In this case I have access to only 32 bytes of OOB:
>>>>>>>>>        2 x (2 user bytes + 14 ECC bytes). Correct me if i'm wrong, but rest of OOB (next
>>>>>>>>>        32 bytes) become unavailable (in both raw and ECC modes) ?
>>>>>>>>>
>>>>>>>>> Thanks, Arseniy
>>>>>>>>>
>>>>>>>>>>>       static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>                          int page, int raw)
>>>>>>>>>>>       {
>>>>>>>>>>> @@ -734,10 +809,18 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>           data_len =  mtd->writesize + mtd->oobsize;
>>>>>>>>>>>           info_len = nand->ecc.steps * PER_INFO_BYTE;
>>>>>>>>>>>       +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRREAD);
>>>>>>>>>>>           if (ret)
>>>>>>>>>>>               return ret;
>>>>>>>>>>>       +    ret = meson_nfc_send_read(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
>>>>>>>>>>>                            data_len, meson_chip->info_buf,
>>>>>>>>>>>                            info_len, DMA_FROM_DEVICE);
>>>>>>>>>>> @@ -754,6 +837,9 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>           }
>>>>>>>>>>>             ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
>>>>>>>>>>>             meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_FROM_DEVICE);
>>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
