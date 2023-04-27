Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B56F0349
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbjD0JVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbjD0JVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:21:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260AADE;
        Thu, 27 Apr 2023 02:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIhJSU8nBnwbgJauLAfwnoYv19LGI5Bvxx4NxYqR0/0xkKtLX6PFtATdWP4odgTOoNhllulHBf+jFZZjGVesSAGG9AOp8azXjErHvO8LBZoqKi7xFPTIIh1Z798Pd985pxkHbDYGGXWzvOOwpaxqNvSrATNQWz9OeYzbWpgPeCj4Yqhawz/ZPRd44RbvuRiNuzeH+Ugptk2aI1HGjdbtS1B8S38TS6/XkWA59uOJzhGlfbUhUGfltUQrXNqxm6q7oD0poQklg2AtYzzA28GraPRt9NtCWjPYi5NNy6UKeG2wj5KlopBbR7howWIttpPRE3CNiyWcguP05bTyXSK+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8exmd1+omkDoErTskZyQXrcxPmfsDZT/+2gSDP+y2mQ=;
 b=TvBIALwN6BW5TYcEyIl4KkY8zan1pBx2/4lF5Ady7LGbmoXKCftwEStS1q7RMy5QjJrFfPkixPDvYqTtvVARx2CGCwQpAeSCaC3HD7xTXqt8HEGgItnbGrDo2KbNYeEQUaabhDXWnf5kuUzqPmf5JKxXKod1S2TxxThjEb6Nj9htPutuKAtR56sl75+xnrFBHTWhlZ2HWVmS7skYq1r+2CRmX8YnXCNVnJvWtePOnW5u0jv3ZeVfhNYAqMVElQpGTPKnIgbYhMCo/Waz4w97XFuZrtxbS2UnlVUhT2LXbl837K9ELCWbrvJWliR2YQ7vLOIVbcS2IXgZiEqleY4JOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8exmd1+omkDoErTskZyQXrcxPmfsDZT/+2gSDP+y2mQ=;
 b=mzMj0FZoXp12yZt5khyCXCW1E4NumkIWx5wE9W00masuykSkvh/43r/Nl3WCdunHkozYb3jz+G+PPPt0D3NCMopfwb7uFyLVNnzx2C5y0rN+mSJaLDVPiKoMbt1tD6zzRpCFxP+pZgDEWApgwBsRhPCyqyR1pS2/ksvwRXdxG0Svnp6VOUsGBM5vGfTJGVIpT8vlluhJSQSa8QdSZo3+UmXGHAhJ/Wv/mtKDEbpEt7Gv3IA11PWztONjyep6/i3wdimT3Nzg/julwrOwcvJN9fYGEC3GQ2Da9dcZ6Jamy30vTSMPZv34LsbNOv6+kAFTOkwgpatqz82eXo5wmriiCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7033.apcprd03.prod.outlook.com (2603:1096:101:e2::14)
 by TYZPR03MB5648.apcprd03.prod.outlook.com (2603:1096:400:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 09:20:25 +0000
Received: from SEZPR03MB7033.apcprd03.prod.outlook.com
 ([fe80::9d77:7adc:25da:b086]) by SEZPR03MB7033.apcprd03.prod.outlook.com
 ([fe80::9d77:7adc:25da:b086%3]) with mapi id 15.20.6340.020; Thu, 27 Apr 2023
 09:20:25 +0000
Message-ID: <74973567-dd00-1480-288c-3fa3a567df3f@amlogic.com>
Date:   Thu, 27 Apr 2023 17:20:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
 <20230419131416.cns3xvkbzjeyrnux@CAB-WSD-L081021>
 <661cea17-a4dd-75d1-6a7e-16efa5aea52b@linaro.org>
 <20230419160405.d7qfir3nv6tlxx2a@CAB-WSD-L081021>
 <427e79ef-156d-027e-9296-6f4e6513a04d@linaro.org>
 <20230419170043.auzfa32weevmrt4e@CAB-WSD-L081021>
 <1c7322c9-8d2d-1cd1-95dc-dd9ec861981f@amlogic.com>
 <9037aa40-c441-b610-ed7b-2c9840dff751@linaro.org>
From:   Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <9037aa40-c441-b610-ed7b-2c9840dff751@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To SEZPR03MB7033.apcprd03.prod.outlook.com
 (2603:1096:101:e2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7033:EE_|TYZPR03MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce69f11-9c4a-42f8-0b07-08db4700a21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OD4TdhYXFCYdLVG2MUmFutnMqmIIijr3+Woxm3xly1Iy3XTzatQQBUuDfjhSduK7RUrGZPl2lZOnYAxXQRcCTioUcLzihdlhsHSaWUaLPcbp/2c/LFg6t1QeQzDuFoKl7L1td4+TtgbdbskUT4Cxx8usmM9hgH8KuQRXxWLrbaMf8SIEUaSGjk0ygrErzBgnNWw9lmfg/JwHrnWicI8SLNHv6YV6JIgHFwmaYuSvjKyhiNLqcFfBrgBRIrRkuBCchscaT4r9Iikzi+jwX3JgSVIv++pLUMqqB9CgYP1/VrurujSu0Cp54Chqht438/Ssiv9/S39Vmo/x9xuWRdqdAZTgvfM+vjXGglHIxK/6FGBMMyO0JJYDPGOHArVkXP0f/YUD4lWDvhYOGvcrXKY5VLvZfBqPm+iXLUibbwTUkP7d8Bbk1WsyPG4E+2fFnX2z5wEFzDGrXQnDm2FXNqPuT9HJf9AlicSW8tF/DMoVFdFNkRbpDY5wq9bqkbyKc5sU2+6I4X2ey2XP8abzXsMG1aF2YRfwrM2buMqZVpbUVvGO3Pxe7g/9A5FhsHOBK6SmtxRGt1jzf47lHue1RI3MrYy4m0wYmnGc1//oeqNSc+PFWDQ4R8eKXwoFYIyyR5gVDiPZb67WQYzdFsXdcqMpkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7033.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39850400004)(376002)(366004)(136003)(396003)(451199021)(44832011)(38100700002)(7416002)(5660300002)(2906002)(8936002)(8676002)(36756003)(86362001)(31696002)(6486002)(6666004)(966005)(26005)(6512007)(6506007)(54906003)(478600001)(2616005)(186003)(31686004)(66946007)(66556008)(53546011)(66476007)(316002)(41300700001)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZKZ3I0M3ppTmZoTkJpcm1TVWVReW45dFl5bmo3eVBrbFpmTDE4MmtBT2kx?=
 =?utf-8?B?WTQ4MVRLRlZHQWZmR1dYMVd4Wlgvc0pNL21WUXJQWU5wUHdLd2FwUkZGZEZJ?=
 =?utf-8?B?aFUxRXdZLzZ6ZGVOZlBnaVQ5RUFneWlYM29nOFQ3VEJSZ3J4NGhNN1NOdTJw?=
 =?utf-8?B?Y2N2YzI4cHFPbnFFNDlQcWpDY1l4NVhuYjJDaXNSQTlLMFROMjMrYk0wcjRi?=
 =?utf-8?B?bTZZMDg1MlMxYjFJVlc1U0QxTHBNSUh6MG1zZ2VxVThwdzJYbUFBV2dJWVhX?=
 =?utf-8?B?NnpzcEU0RTBSbTc1eWlYc0xrY1l6N3A1Ym9TM0xXbS9UOWMzYjZORUxpZlVP?=
 =?utf-8?B?eGFubnh6YWpWMkg4aUZHY3BFQkxYdFFJVFRCUkplUlZ5MHYrdGZWQ0dqMWcx?=
 =?utf-8?B?Snc5SHAzQlNLSnQ5clVZT0ZvWTNHZVlldUhGU1BEc3RGQUh0MUVENXBsY2VP?=
 =?utf-8?B?aDliL0F6UUhkNXNJOVN2WERKMU56S2RxeVlZZEErQVVjcVo2SjhyekVjYXhV?=
 =?utf-8?B?QWZNRkhRL0dqM3VlUXd6UlpydGtUZTJSS0lYc21mV0w1SUtaUy9LcmlYMmg0?=
 =?utf-8?B?dVBtUVV0QmVaaDFnUnA4bUVJV1MzYzZEdmhMZi9mZExLaG11dW10TXM5QVNn?=
 =?utf-8?B?VTBLWkl1d004bzgyQXdnY3AyNkpxaDJRKzNrMHNmS0srVEt0Y0dtdDNCcGYx?=
 =?utf-8?B?WWp6eTdiTHJoZEVsWUVSOVcvMWNvR1ZQazBTVTRLWmJGTDByWkFJMWwyRzZv?=
 =?utf-8?B?cUJFelh2Yzg2Mzd6MHgrWDNxMTJtalRkM0QvV1hZQkF6MXVLeklWUFZKa3M1?=
 =?utf-8?B?Zi85dFBWRGN6M1ozcFZnYmswQ282WE11eUdOMDFLcVlLMHF2elNRK3dDRTl3?=
 =?utf-8?B?SXczbjRUcDJscUFtOWVBbk1LV3B0eStzRzNxR1NYOUcyZDZPWVY1dm5iYjJa?=
 =?utf-8?B?cmEwZWx1Ky80S3lHdStYUTlkMzVXNWFYSkd1Sk5GMFVIYzhMWmxVSkQ3Tkoz?=
 =?utf-8?B?cFdPZ2hZN2x3MzMzc3JidzNraHhZTVhjQ2ZYTjFORjZaK01LV2xxeGwrcW54?=
 =?utf-8?B?dTQwb05zUDFlZi9LRjFCdVJ0YzdwK251VWRCSVB1Yytnd2huY1c0WnFPWnFu?=
 =?utf-8?B?WkN6MGltWUpOWWJ1eUFzN2Z0VGVqU01jblBpZHIxeDQ0aFJxQWRvcllBbDcx?=
 =?utf-8?B?SExzTG5oZ1l5S2RzZ1RIM1hxMXpiYUNVREYyTGhQVEg0NUFNakc4Unpzb0d3?=
 =?utf-8?B?QkdIbU5mZHJlZVc3RUY0NG1JUXdkTWZvT3FMNFFSeFhiNnpQTDU3bW15NmFT?=
 =?utf-8?B?RklpTUMvVHJNN0hVdFo0V0szQ0VPZzl5aktFVzR3SDA5dXhUaXN3UEN6ZjRt?=
 =?utf-8?B?c0NYZVZGeHJaZkNsQWw0MFhGNzdobFVBQzBkQlVXd21kWnlKSFJUUlRtSUxy?=
 =?utf-8?B?RGJKdjE5QldyZ2JOT21ZdFVZcWpGTHRjSDhPMG1XNXowYUtRVFhsbXk3TFhY?=
 =?utf-8?B?YnlLTnR0aFFyaGlrQkxqL1daaXo1U1VYODVteFUyQUhuVXlTTTAveXFHMDlX?=
 =?utf-8?B?aUpzbW1NRFVPOERkbU45WGRoRlNlVGpqTmIzaEprazJOaHZiWHNXSTBpTTdD?=
 =?utf-8?B?b0pDTm56UEY5Q0F2Mkg3NllxbTNLRk8zekE2RjZMZ2RyN2FlODRZdDMxakVU?=
 =?utf-8?B?VGlMclNLQmc2ZGpzd2tDNHV5UEQrVXN2S3FYTHRmbTFvLzg1bHh0VnhBVnVV?=
 =?utf-8?B?K0FRZE9nNVEyMGk5UjZqV0F4cTFwTFBRMjR0NHVyeko2RkQ4dzNCTldqVWJV?=
 =?utf-8?B?eUxpNlpzOTZSOU5DaXhvTGNWUnVXVmtnSXd5ejQ2eDhGSUhISXFTM1dVVzZV?=
 =?utf-8?B?K0t4TkVPRUNpa2I0NHVibTZLYzRiN1czOENnUXluOE9lWi80YTBYQ0wwZ0tn?=
 =?utf-8?B?VXN5Mnl0UEVrZDdDQVhRQ0xvbVlMSERCL3FGRGxBQnZGZitOSFcvY2FoR01S?=
 =?utf-8?B?M1ArLzBhWU5HUXFvTUtjSGJzR2ExNTJJOHFKWFJOVWJWMXdXQ2JRZ2NKV3A3?=
 =?utf-8?B?N21ZOTRKc09PZmdDcDRxWUd3WGpZQ1dWVFQ2U0RkWGJxTlhRNitsdjJiZ290?=
 =?utf-8?B?WVFIMlBaMWcwUzN6dmNaV1BVRGlqZmpHcm5DMG9hTUxDN0pFeUZFRlc4dWtH?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce69f11-9c4a-42f8-0b07-08db4700a21b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7033.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 09:20:25.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyEf1onJHL41JqV8GorGmCz/zbWpQKObWHBX/FGn6rAJdmf7AfJp6HL3sK10VvWgH4FjOdCh6nUKiwyNqur5woq6e64Z0F+/dqcRaHiH5gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5648
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/20 20:18, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Kelvin,
> 
> On 20/04/2023 10:43, Kelvin Zhang wrote:
>> On 2023/4/20 01:00, Dmitry Rokosov wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Wed, Apr 19, 2023 at 06:25:07PM +0200, Neil Armstrong wrote:
>>>> On 19/04/2023 18:04, Dmitry Rokosov wrote:
>>>>> On Wed, Apr 19, 2023 at 03:43:12PM +0200, Neil Armstrong wrote:
>>>>>> On 19/04/2023 15:14, Dmitry Rokosov wrote:
>>>>>>> On Wed, Apr 19, 2023 at 03:38:33PM +0800, =Xianwei Zhao wrote:
>>>>>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>>>>
>>>>>>>> The C series SoCs are designed for smart IP camera
>>>>>>>> applications, which does not belong to Meson series.
>>>>>>>> So, Add ARCH_AMLIPC for the new series.
>>>>>>>>
>>>>>>>> There are now multiple amlogic SoC seies supported, so group 
>>>>>>>> them under
>>>>>>>> their own menu. we can easily add new platforms there in the 
>>>>>>>> future.
>>>>>>>> Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.
>>>>>>>>
>>>>>>>> No functional changes introduced.
>>>>>>>>
>>>>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>>>> ---
>>>>>>>>     arch/arm64/Kconfig.platforms | 12 ++++++++++++
>>>>>>>>     arch/arm64/configs/defconfig |  2 ++
>>>>>>>>     2 files changed, 14 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/Kconfig.platforms 
>>>>>>>> b/arch/arm64/Kconfig.platforms
>>>>>>>> index 89a0b13b058d..bfbc817eef8f 100644
>>>>>>>> --- a/arch/arm64/Kconfig.platforms
>>>>>>>> +++ b/arch/arm64/Kconfig.platforms
>>>>>>>> @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
>>>>>>>>          This enables support for MediaTek MT27xx, MT65xx, MT76xx
>>>>>>>>          & MT81xx ARMv8 SoCs
>>>>>>>> +menuconfig ARCH_AMLOGIC
>>>>>>>> +     bool "NXP SoC support"
>>>>>>> NXP? Did you mean "Amlogic"?
>>>>>>>
>>>>>>>> +
>>>>>>>> +if ARCH_AMLOGIC
>>>>>>>> +
>>>>>>>>     config ARCH_MESON
>>>>>>>>        bool "Amlogic Platforms"
>>>>>>>>        help
>>>>>>>>          This enables support for the arm64 based Amlogic SoCs
>>>>>>>>          such as the s905, S905X/D, S912, A113X/D or S905X/D2
>>>>>>>> +config ARCH_AMLIPC
>>>>>>> Do we really need a different ARCH for Amlogic IPC?
>>>>>>> I can imagine that it's not the Meson architecture at all.
>>>>>>> But maybe a better solution is just to rename ARCH_MESON to 
>>>>>>> ARCH_AMLOGIC?
>>>>>> It should be changed treewide, and is it worth it ?
>>>>> As far as I understand, the A1 and S4 families are not fully 
>>>>> compatible
>>>>> with the Meson architecture, and we haven't provided additional ARCH_*
>>>>> for them.
>>>> The GXBB, GXL/GXM, G12A, G12B & SM1 are also not fully compatible,
>>>> but they lie under the "MESON" umbrella which covers SoC since the
>>>> Meson6 architecture. It's a facility to include/exclude Amlogic
>>>> drivers/DT, nothing else.
>> GXBB, GXL/GXM, G12A, G12B , SM1 and S4 belong to media box.
>> So, "MESON" represents the media box series.
>> Up to now, "MESON" works well for all existing chips except A1 and AXG.
>>>> If you compare it to BCM or NXP, it's different situation, the
>>>> different ARCH_* actually targets totally different SoCs from
>>>> completely different Business Units or from companies acquisitions.
>> Firstly, the new C series is totally different from previous MESON 
>> series.
>>  From the perspective of application, the new C series is designed for 
>> smart IP camera applications,
>> while MESON series is designed for hybrid OTT/ IP Set Top Box  and 
>> high-end media box applications.
>>  From the perspective of architecture, the new C series integrates the 
>> sensor interface, image signal processing unit, Dewarp, video encoder, 
>> neural networking processing unit,
>> which MESON series does not and will never have.
>> Secondly, there are C1 and C2 besides C3.
>> Moreover, more other series are on the way, such as T series.
>> If we always stick to "MESON", people will get more and more confused.
>> Therefore, I think it is the right time to add ARCH_AMLIPC.
> 
> Thanks for sharing such details, we are all happy to see Amlogic's
> commitment to upstream of these SoC families.
> 
> But as I explained, this ARCH_MESON doesn't define the SoC type
> but badly defines the Amlogic SoCs support.
> 
>>>> We should have named it ARCH_AMLOGIC since the beginning, but we
>>>> can't change history.
>> Shouldn't we deserve a chance to make it right?
> 
> Yes, so the right thing to do is to move to ARCH_AMLOGIC
> 
>>>>> In my opinion, it's a good time to split the Meson architecture into
>>>>> proper subsets, or rename it treewide (maybe only config option
>>>>> ARCH_MESON => ARCH_AMLOGIC).
>>>> MESON is only a codename to differentiate from other SoC vendors
>>>> because Amlogic used it as a codename for a long time.
>>>> Compare this to Allwinner's "sunxi" or Qualcomm's "msm".
>>>>
>>>> This config has no functional mean, it's only a config namespace.
>>>>
>>>> Renaming it would need renaming it in all subsystems Kconfig/Makefiles
>>>> and will certainly break builds with custom kernel configs
>>>> in various publicly used builds like Armbian, meta-meson, LibreELEC,
>>>> Debian, Suse, ...
>> Let's get back to ARCH_AMLIPC.
>> We just need to add ARCH_AMLIPC in the necessary subsystems 
>> Kconfig/Makefile.
>> This change will keep the existing MESON related code,  and will 
>> neither involve renaming nor break any builds.
> 
> The goal of mainline Linux is to build as much as possible and
> be modular at runtime, the only supported configuration is 
> arch/arm64/configs/defconfig
> and adding a new config to differentiate an Application type
> doesn't make sense.
> 
>>>> So it's pointless to change, and even add a different one since
>>>> it's not a family differentiator since the Kernel is modular
>>>> and works around DT to determine which drivers to probe.
>> Proper names play an important role in understanding the code, right?
> 
> Yes, but stable config names also play an important role for the
> users for mainline, and there's a big number of users relying
> on the stable naming for all SoCs starting from Meson6.
> 
> So if you really want to get rid of the ARCH_MESON, migrating to
> ARCH_AMLOGIC is the right thing to do, but it involves doing
> a treewide migration and there's no easy way to do this and make
> sure the users still manages to build for other Amlogic platforms.
> 
> So as the Amlogic ARM/ARM64 SoC support maintainer I must make sure
> breakage don't happens, and so far I don't see how achieve that.
> 
> Now, you can post a RFC so we can discuss on something.

OK. Let's continue with ARCH_MESON.

> 
> Neil
> 
>>>> Neil
>>>>
>>> Thank you for the detailed explanation; it makes sense!
>>> Actually, I disagree with creating a separate ARCH without first 
>>> reworking
>>> all of its subsets - that's why I started this discussion.
>>> Now, I see that you share my perspective and believe that C3
>>> should be added to the ARCH_MESON subset, so I have no objections.
>>>
>>> [...]
>>>
>>> -- 
>>> Thank you,
>>> Dmitry
>>>
>>> _______________________________________________
>>> linux-amlogic mailing list
>>> linux-amlogic@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
