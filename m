Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885A76F67C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjEDItu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjEDItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:49:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20719.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A919A8;
        Thu,  4 May 2023 01:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J53Tlix1p+O53NelKpleVRvpUuY145AZtM60XwEdkzlo5dy0OCay26W3Aqv4/nCT0ERfBkQ1OOxmZ4Kz5BTbBFDA04+yOR1enXJaVD39xz8P0egUyEUKEZ8xiFb/3Eu8uLIBSKy7r5ykCcWTWc5b+KFN3LQRkizLryCmpr3dvAPMjwBkOHgNhsNpOQ5IsRtWqYiqQtAlI9cfVPxuEMnLXNI8iTSkybxazSFi/vkolItxO/EBtEDZT/Z+Puu8SJHMi1ldOFfoKklwxA5ijrN0GQSMpQKWLl4i3pXPW41TStTNJ4bhdUzU63BJR3WlR7dME/J78giMKJgeAB6lbt5sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwdH405tBE0XgVtxepfbf0AbgnPTb0TYol6Hin7erC0=;
 b=EcrxUcPTsfvrFbW99BozrkNgm+P49csiv9qrmXl6VypxCCJgD79JQfUCtxXlsc6VDy6SnvviOf84CPKtgKl7+GLM0pRVzkI3DQHaHTsiKWgC1jg/K9zH59JR8lRHfLUBixXjqMz55fyXd1FNmcB3fjeI1w/HEamKV8AHooqnVB0TRa0cbfyJtM7nJ/BwzOht79s8XODp+SNeKJkbURQhUHpwMwc6JCqXbDmIZX/BpRbvtF1qySjzZXoO5Tki7PFhNNEQLmlKAUXJWaGodSMwnLBbP+Zau2mmynLZ4GezqV985wqyvIoQ9EBTPNkrxroxsJAOO1n6qg6okHElOgxR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwdH405tBE0XgVtxepfbf0AbgnPTb0TYol6Hin7erC0=;
 b=OocAPI7X8lZYduTkSIPBL78pjCAvvXF2tLiMWa6wWCOzSlmcSXflRZhH8vZdNY7DwwHnZDfh2dbvbsqOsw6UqbW9rTWJXjTmJreNLT8be9k5gu8Ww2AsdCxFRuG+Ltkk68DylP0Mlmg701CKI6VR5qjw50g8cMB7ywztyRxdkFfIY14CuuladOn+q6avlLHkmNp87ezaNEXJOuABiyLakGKZTRllv7rqsa2Rh1Wa+FHq9A/J/hrP5a19L6AxXHpDV/0pBxh6NHr/X84kZxiU9LI3doWfEPq+/x5TOmS/a2qTh+BFMAELU9h0UJL0pa/y54XnWKxAc+U0HbqTHszIkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 JH0PR03MB7465.apcprd03.prod.outlook.com (2603:1096:990:a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.21; Thu, 4 May 2023 08:48:26 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 08:48:26 +0000
Message-ID: <22325c38-5524-b9c9-8507-ee60b89a9115@amlogic.com>
Date:   Thu, 4 May 2023 16:47:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V7 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-3-yu.tu@amlogic.com>
 <20230426104946.xiwsdjxris2faf7x@CAB-WSD-L081021>
 <98fdedba-2715-23e7-1d2b-2d9334f0c674@amlogic.com>
 <20230427085228.vktptr76wbcdcksq@CAB-WSD-L081021>
 <4f73fde6-bc67-ac31-08d2-3e84b0646e73@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <4f73fde6-bc67-ac31-08d2-3e84b0646e73@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::18) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|JH0PR03MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: ab553686-fdbe-4126-b039-08db4c7c5331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x78SdpJCAQy3o+vwbNMn4CIS0uwwohj1ZgSb/aWXs4VCDnnqJCHA7JwZ6+R9gyox7rObwwa3gsCLKoWUfPPBQ/E+usrn5hBp899/PJybxH4MaAmK/LJge3gUz78KQWeL6OLT2/j7sitsiVpMLFA4kU8QMkqhPH57M4U9SKV9d/cyJQXaxWi41hH3eawDg7q70lTHXygGhZgfSyZbIU4vU1ZlP/WjnvWzghXZe5Nl2Wq/tMmb4tmsr8INJVm5VQGxDwNISEWBoLjqdG0rBnOy24jI59iWmev6Cox09Hw97bDrA8aPPa5jCmj0kvj9MeFs6gPDDCWGTnaJU/T2B02EbMQ5mVTTRMBRabKbQZ49z/I6AWHm2nGJTLeY5pIivaEbo1euyqgOsftBwcCPgxPTOigkbTWjgXFyV+hnAJAoc6hR4pjqboGNCusz7ZZieJLKzc+C42jU1BPVKfs84VroBJAlNYrsj9yaXZdatIQZtQw19HBZ+eh316UbKYZQQweAfUDRDIKzfwc4gNMGcVRrJxcYoR7JZTZZy9evxWtqjyYwXvhDa84ADk5XXdadJViDS0vEMjlZQZFkSFTppUoDjZPXF+cQByS/RiL6g7Pd1yHUxYVaIR6uU8sXVq3miVWjGUPEVVbbmtA3cVEbqbpV7l9VAoNq0N+o5+APzxmXrJUr/Qvawq3NqZ670iSFIDAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(396003)(346002)(366004)(376002)(136003)(451199021)(31696002)(36756003)(86362001)(54906003)(4326008)(66946007)(6916009)(6666004)(66556008)(6486002)(316002)(66476007)(966005)(41300700001)(5660300002)(44832011)(7416002)(2906002)(30864003)(8936002)(38100700002)(186003)(6512007)(26005)(53546011)(6506007)(83380400001)(107886003)(2616005)(478600001)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdYdnpFbFdBYWFlZWNTVEkvTUpPamx2VmdsVGo2UVBCQzJUTWw1djFVNGJ5?=
 =?utf-8?B?TnEvenRsRkpGN2tUOEZFTFNPOFRKTVVieldCUmdNMmp6L0Y1VlZId1M0bXBm?=
 =?utf-8?B?Y1dNd01jYXkvRXBSczZFajZmZkRrbXF6T0NDOERJY1djMGFPMnFnRURzUGE5?=
 =?utf-8?B?d0ZSa1JvbkFkQXRvb05iYXR0bGtGb29zaVlWaFc1TmE4SmlGTUF5ZGJic1lK?=
 =?utf-8?B?VjAzL3NSWG5hVitJNUt1b20wZmlmSnZGamhDaUUzNUVha0dDenhCWlpNalRj?=
 =?utf-8?B?Kys4QWs2M3lxTTExWVhwWEZocTdTUHJ1R04xUTZ1d0lyNlFOZElpaHhneUV0?=
 =?utf-8?B?bitUck84RkJSVnF3OEdZeDlUbkxjbWd2eW5FSWpFUjd6aHgyNTI5RnpQWWdr?=
 =?utf-8?B?aXJ4bTVxdDVrK2I1Tm4rRHlWVVY1UXlSditBMG9UbXU2QlBhd0N1UXhuL2pU?=
 =?utf-8?B?cXJIM2dxUGdlU0xiU29sQ3VjNDlkL3R2KzZ4UEl6ZDlVNHVqdjdtRW9LeWlP?=
 =?utf-8?B?eDh3S3RZZUJTTTdmZFNsOVhJdmh5aHFtMm5PZDNTTUtrNXNETEpMd0swRDFO?=
 =?utf-8?B?TE92MUxacVBTekg4WnppU05SeVJDTS9qbXA5Q2pVOERCRjB2TE1lb0Exd1NV?=
 =?utf-8?B?OXIyeGo2c3FxVGRPczVGaXNlU2xZS1gvcUdLVUFvQ0J2Y2k1UFRuVFlsQ3M0?=
 =?utf-8?B?VXlYYk9xK0hzN1IxK3ZMclhCQWJoa1dETjZhNFAvcmQ0RUlRNi9EOUpxNWp1?=
 =?utf-8?B?OVFYay8yelJrYVN6eEdvN0VYOUNRVWlWNzU3c1lncHF1bWtMWmwrdHIxa3VI?=
 =?utf-8?B?dTlhODdQMHFJdlN0Q0JrNVJnZkNJZGVkejBRaEhxVU5IYUttRzZxaG9leG9V?=
 =?utf-8?B?ZCtjNGhRSXlyc1BGRVRFdmVtcjEzZTYvcWp0eldqOStNcFE4SU9KazdxRzgr?=
 =?utf-8?B?NU5hS1hNaXV3QXlieFc5d3d4UnN4cDJuaktlakpTa1FwNE9PZU5VWE9hTnFn?=
 =?utf-8?B?azgweWpqMzhmeUpWc0h0UnZhZU14SFhtck9JMUd5SFNnc3VzKytQeHpXTG9r?=
 =?utf-8?B?aE1QVStnVFh4ZDVkSUZSZFJVbVZVSXU0MmN5WVE2NWowdk5VSTZyanlEWXQ2?=
 =?utf-8?B?cXgwWXMzNnNGdXVHbGJNOEVwQmVYK3ByKy9uQTZvSW5FVmgxRjJRenFqYld6?=
 =?utf-8?B?ZFcwUnJjK2pUVDNBdERZTWxKQ3BsSWdSM2xKZUZ1S1pyaTNOalNIQldZM09Z?=
 =?utf-8?B?MUtuTlpxT1IxNG9Edk1ZTnZiRjRyY0lrbWJ1M2tSd1B1ZUtrYVBJYmZlRG9k?=
 =?utf-8?B?Y0VlVEJBZ3cyYldNODd2eWtndVg3aStIOWxlRGRoQmZocjhpMVhybklaZ2hm?=
 =?utf-8?B?UlJiVzF6VWdIZmtQazlkL3NKV2hzY0xTZHl6VjJya2hEVkMxN0N3L21QYWIw?=
 =?utf-8?B?bmZ0T0tNZzBuRm9wbFZaMDdKWU9CSWVvVjNHUy9rV0hQNlpwYlc4UmlQc0NR?=
 =?utf-8?B?Ykh2eVYvU3R1b3ZPYmFaZU9neGtvSGF3QTNLZjcyUnEzMVBVTlluMVRxM2ha?=
 =?utf-8?B?ZlYzME96L2ZpcWhzVGtDV0tyR2YzWXpMWnhiNEFpUStzZGdhNUM0Vi92bWxl?=
 =?utf-8?B?eUxsM1ZnMnZLYWRDRTdMT1J6NTRJNGM4Ui8wa0pMZkJoVmg1Zm16S0hlazN5?=
 =?utf-8?B?Sm9URHBoVHZrUXFScWZERWorSWNFSFpCSDU5SklQbCszL1VrWi8vRXp4RjI2?=
 =?utf-8?B?VkxLZmpaTmVGYmZrRklIWU5oVXlOV3pjY2szMHh1OUh4Ry83N1lrVW81MnRC?=
 =?utf-8?B?ZFJlVHM4VkI4YlRIZVdIaHlXR0c3aHJmaEZnRG85akNITmlJaEhUcWsrNzZm?=
 =?utf-8?B?QmV4ZWNSMnlUUTE5VHE2N1F0Rnk0RDFrME03K3JTNnQ3NTd6UGtWaVJyZ2Nm?=
 =?utf-8?B?R3l3dTZ6ajdlcys4NXJuSTBuc1YrT3RncDB1RTR1ZmVSOXo4TmxZQXlqRnU1?=
 =?utf-8?B?NnRFWk9sVlZXT01uS0xJa2draXNxRk5BQWp1eXhtbWZxcnZ0MnNTVXdSK1dZ?=
 =?utf-8?B?dFFTcXBJa3BYalVMTG5rNVhBTmhVRmlZWlhoSkFSWHhmSXU3SUo1d0k1cXZH?=
 =?utf-8?Q?wc3PHyMMFeLw6jdzynrMjLo4o?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab553686-fdbe-4126-b039-08db4c7c5331
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:48:26.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCeUFJrXb6HmdSv77jyykrCyjnEppO98bjJ4HVjzzkL/RUtG7UlUQBHdJdqgy1xDF3glOQSU9A+y9tqQ6AlquA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7465
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/27 19:36, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 27/04/2023 10:52, Dmitry Rokosov wrote:
>> On Thu, Apr 27, 2023 at 04:03:41PM +0800, Yu Tu wrote:
>>>
>>>
>>> On 2023/4/26 18:49, Dmitry Rokosov wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> Hello Yu,
>>>>
>>>> Thank you for the patch series! Please find my comments below.
>>>>
>>>
>>> Hi Dmitry，
>>>      Thank you for your review.
>>>
>>>> On Mon, Apr 17, 2023 at 02:50:03PM +0800, Yu Tu wrote:
>>>>> Add the S4 peripherals clock controller dt-bindings in the s4 SoC
>>>>> family.
>>>>>
>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>> ---
>>>>>    .../clock/amlogic,s4-peripherals-clkc.yaml    |  97 +++++++++++++
>>>>>    .../clock/amlogic,s4-peripherals-clkc.h       | 131 
>>>>> ++++++++++++++++++
>>>>>    2 files changed, 228 insertions(+)
>>>>>    create mode 100644 
>>>>> Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>>>    create mode 100644 
>>>>> include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>>>
>>>>> diff --git 
>>>>> a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..46b969a16a7c
>>>>> --- /dev/null
>>>>> +++ 
>>>>> b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>>> @@ -0,0 +1,97 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: 
>>>>> http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Amlogic Meson S serials Peripherals Clock Controller
>>>>
>>>> As per my understanding, Meson is no longer applicable.
>>>> As Neil and Martin suggested in other reviews, the term 'Amlogic' 
>>>> should
>>>> be used instead or 'Meson' should be removed altogether.
>>>>
>>>
>>> No. This was all agreed upon a long time ago. Corporate drivers and 
>>> dtsi are
>>> named after this.
>>>
>>
>> Okay, it seems like there may be a misunderstanding here.
>> Now might be a good time to ask Neil about the correct behavior.
>>
>> Neil, could you please provide the specific naming rules for the new
>> Amlogic drivers? Where should we use the 'meson' keyword, and where
>> should we not use it?
> 
> The current goal is to first get rid of meson in the compatiob, which is 
> ok here,
> then remove meson in the driver name & function names, and then wherever 
> it's a
> nice to have to remove meson in bindings & comments.
> 
> So if you where sending a v8, it would be good to remove the Meson in the
> bindings description.

Okay.

> 
> Neil
> 
>>
>>>>> +
>>>>> +maintainers:
>>>>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>>>>> +  - Jerome Brunet <jbrunet@baylibre.com>
>>>>> +  - Yu Tu <yu.tu@amlogic.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: amlogic,s4-peripherals-clkc
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: input fixed pll div2
>>>>> +      - description: input fixed pll div2p5
>>>>> +      - description: input fixed pll div3
>>>>> +      - description: input fixed pll div4
>>>>> +      - description: input fixed pll div5
>>>>> +      - description: input fixed pll div7
>>>>> +      - description: input hifi pll
>>>>> +      - description: input gp0 pll
>>>>> +      - description: input mpll0
>>>>> +      - description: input mpll1
>>>>> +      - description: input mpll2
>>>>> +      - description: input mpll3
>>>>> +      - description: input hdmi pll
>>>>> +      - description: input oscillator (usually at 24MHz)
>>>>> +      - description: input external 32kHz reference (optional)
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: fclk_div2
>>>>> +      - const: fclk_div2p5
>>>>> +      - const: fclk_div3
>>>>> +      - const: fclk_div4
>>>>> +      - const: fclk_div5
>>>>> +      - const: fclk_div7
>>>>> +      - const: hifi_pll
>>>>> +      - const: gp0_pll
>>>>> +      - const: mpll0
>>>>> +      - const: mpll1
>>>>> +      - const: mpll2
>>>>> +      - const: mpll3
>>>>> +      - const: hdmi_pll
>>>>> +      - const: xtal
>>>>> +      - const: ext_32k
>>>>> +
>>>>> +  "#clock-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - clocks
>>>>> +  - clock-names
>>>>> +  - "#clock-cells"
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>>>> +
>>>>> +    clkc_periphs: clock-controller@fe000000 {
>>>>> +      compatible = "amlogic,s4-peripherals-clkc";
>>>>> +      reg = <0xfe000000 0x49c>;
>>>>
>>>> I was under the impression that reg as MMIO address should have four
>>>> cells on ARM64 architecture. Are you sure it only needs two cells?
>>>
>>> Yes. Maybe you can check out the clock file for other yaml.The two 
>>> cells and
>>> four cells all are ok.
>>>
>>> It's not a problem even in real DTS. How many cells are needed to 
>>> look at
>>> the parent address-cells and size-cells definitions.
>>>
>>
>> AFAIR, it depends on which OF API you will call for retreive address
>> and size values (u32 or u64).
>>
>>>>
>>>>> +      clocks = <&clkc_pll 3>,
>>>>> +              <&clkc_pll 13>,
>>>>> +              <&clkc_pll 5>,
>>>>> +              <&clkc_pll 7>,
>>>>> +              <&clkc_pll 9>,
>>>>> +              <&clkc_pll 11>,
>>>>> +              <&clkc_pll 17>,
>>>>> +              <&clkc_pll 15>,
>>>>> +              <&clkc_pll 25>,
>>>>> +              <&clkc_pll 27>,
>>>>> +              <&clkc_pll 29>,
>>>>> +              <&clkc_pll 31>,
>>>>> +              <&clkc_pll 20>,
>>>>> +              <&xtal>,
>>>>> +              <&ext_32k>;
>>>>> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", 
>>>>> "fclk_div4",
>>>>> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
>>>>> +                    "mpll0", "mpll1", "mpll2", "mpll3", 
>>>>> "hdmi_pll", "xtal",
>>>>> +                    "ext_32k";
>>>>> +      #clock-cells = <1>;
>>>>> +    };
>>>>> +...
>>>>> diff --git 
>>>>> a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h 
>>>>> b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>>> new file mode 100644
>>>>> index 000000000000..073396a76957
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>>> @@ -0,0 +1,131 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>>>>> +/*
>>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>>> + */
>>>>> +
>>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>>>>> +
>>>>> +/*
>>>>> + * CLKID index values
>>>>> + */
>>>>> +
>>>>> +#define CLKID_RTC_CLK                        4
>>>>
>>>> I believe that the CLK suffix is unnecessary since it is already clear
>>>> that the object in question is a clock. Additionally, it is redundant
>>>> to use the GATE suffix.
>>>
>>> No. These prefixes and suffixes are very friendly to the people who 
>>> write
>>> and read the code.
>>>
>>
>> Jerome has already pointed this out in another review for the
>> A1 clock driver, there are redundant suffixes:
>>
>> https://lore.kernel.org/linux-amlogic/1j359y82fn.fsf@starbuckisacylon.baylibre.com/
>>
>>>>
>>>>> +#define CLKID_SYS_CLK_B_GATE         7
>>>>> +#define CLKID_SYS_CLK_A_GATE         10
>>>>> +#define CLKID_SYS_CLK                        11
>>>>> +#define CLKID_CECA_32K_CLKOUT                16
>>>>> +#define CLKID_CECB_32K_CLKOUT                21
>>>>> +#define CLKID_SC_CLK_GATE            24
>>>>> +#define CLKID_12_24M_CLK_SEL         27
>>>>> +#define CLKID_VID_PLL                        30
>>>>> +#define CLKID_VCLK                   37
>>>>> +#define CLKID_VCLK2                  38
>>>>> +#define CLKID_VCLK_DIV1                      39
>>>>> +#define CLKID_VCLK2_DIV1             44
>>>>> +#define CLKID_VCLK_DIV2                      49
>>>>> +#define CLKID_VCLK_DIV4                      50
>>>>> +#define CLKID_VCLK_DIV6                      51
>>>>> +#define CLKID_VCLK_DIV12             52
>>>>> +#define CLKID_VCLK2_DIV2             53
>>>>> +#define CLKID_VCLK2_DIV4             54
>>>>> +#define CLKID_VCLK2_DIV6             55
>>>>> +#define CLKID_VCLK2_DIV12            56
>>>>> +#define CLKID_CTS_ENCI                       61
>>>>> +#define CLKID_CTS_ENCP                       62
>>>>> +#define CLKID_CTS_VDAC                       63
>>>>> +#define CLKID_HDMI                   67
>>>>> +#define CLKID_TS_CLK_GATE            69
>>>>> +#define CLKID_MALI_0                 72
>>>>> +#define CLKID_MALI_1                 75
>>>>> +#define CLKID_MALI                   76
>>>>> +#define CLKID_VDEC_P0                        79
>>>>> +#define CLKID_VDEC_P1                        82
>>>>> +#define CLKID_VDEC_SEL                       83
>>>>> +#define CLKID_HEVCF_P0                       86
>>>>> +#define CLKID_HEVCF_P1                       89
>>>>> +#define CLKID_HEVCF_SEL                      90
>>>>> +#define CLKID_VPU_0                  93
>>>>> +#define CLKID_VPU_1                  96
>>>>> +#define CLKID_VPU                    97
>>>>> +#define CLKID_VPU_CLKB_TMP           100
>>>>> +#define CLKID_VPU_CLKB                       102
>>>>> +#define CLKID_VPU_CLKC_P0            105
>>>>> +#define CLKID_VPU_CLKC_P1            108
>>>>> +#define CLKID_VPU_CLKC_SEL           109
>>>>> +#define CLKID_VAPB_0                 112
>>>>> +#define CLKID_VAPB_1                 115
>>>>> +#define CLKID_VAPB                   116
>>>>> +#define CLKID_GE2D                   117
>>>>> +#define CLKID_VDIN_MEAS_GATE         120
>>>>> +#define CLKID_SD_EMMC_C_CLK          123
>>>>> +#define CLKID_SD_EMMC_A_CLK          126
>>>>> +#define CLKID_SD_EMMC_B_CLK          129
>>>>> +#define CLKID_SPICC0_GATE            132
>>>>> +#define CLKID_PWM_A_GATE             135
>>>>> +#define CLKID_PWM_B_GATE             138
>>>>> +#define CLKID_PWM_C_GATE             141
>>>>> +#define CLKID_PWM_D_GATE             144
>>>>> +#define CLKID_PWM_E_GATE             147
>>>>> +#define CLKID_PWM_F_GATE             150
>>>>> +#define CLKID_PWM_G_GATE             153
>>>>> +#define CLKID_PWM_H_GATE             156
>>>>> +#define CLKID_PWM_I_GATE             159
>>>>> +#define CLKID_PWM_J_GATE             162
>>>>> +#define CLKID_SARADC_GATE            165
>>>>> +#define CLKID_GEN_GATE                       168
>>>>> +#define CLKID_DDR                    169
>>>>> +#define CLKID_DOS                    170
>>>>> +#define CLKID_ETHPHY                 171
>>>>> +#define CLKID_MALI_GATE                      172
>>>>> +#define CLKID_AOCPU                  173
>>>>> +#define CLKID_AUCPU                  174
>>>>> +#define CLKID_CEC                    175
>>>>> +#define CLKID_SD_EMMC_A                      176
>>>>> +#define CLKID_SD_EMMC_B                      177
>>>>> +#define CLKID_NAND                   178
>>>>> +#define CLKID_SMARTCARD                      179
>>>>> +#define CLKID_ACODEC                 180
>>>>> +#define CLKID_SPIFC                  181
>>>>> +#define CLKID_MSR_CLK                        182
>>>>> +#define CLKID_IR_CTRL                        183
>>>>> +#define CLKID_AUDIO                  184
>>>>> +#define CLKID_ETH                    185
>>>>> +#define CLKID_UART_A                 186
>>>>> +#define CLKID_UART_B                 187
>>>>> +#define CLKID_UART_C                 188
>>>>> +#define CLKID_UART_D                 189
>>>>> +#define CLKID_UART_E                 190
>>>>> +#define CLKID_AIFIFO                 191
>>>>> +#define CLKID_TS_DDR                 192
>>>>> +#define CLKID_TS_PLL                 193
>>>>> +#define CLKID_G2D                    194
>>>>> +#define CLKID_SPICC0                 195
>>>>> +#define CLKID_SPICC1                 196
>>>>> +#define CLKID_USB                    197
>>>>> +#define CLKID_I2C_M_A                        198
>>>>> +#define CLKID_I2C_M_B                        199
>>>>> +#define CLKID_I2C_M_C                        200
>>>>> +#define CLKID_I2C_M_D                        201
>>>>> +#define CLKID_I2C_M_E                        202
>>>>> +#define CLKID_HDMITX_APB             203
>>>>> +#define CLKID_I2C_S_A                        204
>>>>> +#define CLKID_USB1_TO_DDR            205
>>>>> +#define CLKID_HDCP22                 206
>>>>> +#define CLKID_MMC_APB                        207
>>>>> +#define CLKID_RSA                    208
>>>>> +#define CLKID_CPU_DEBUG                      209
>>>>> +#define CLKID_VPU_INTR                       210
>>>>> +#define CLKID_DEMOD                  211
>>>>> +#define CLKID_SAR_ADC                        212
>>>>> +#define CLKID_GIC                    213
>>>>> +#define CLKID_PWM_AB                 214
>>>>> +#define CLKID_PWM_CD                 215
>>>>> +#define CLKID_PWM_EF                 216
>>>>> +#define CLKID_PWM_GH                 217
>>>>> +#define CLKID_PWM_IJ                 218
>>>>> +#define CLKID_HDCP22_ESMCLK_GATE     221
>>>>> +#define CLKID_HDCP22_SKPCLK_GATE     224
>>>>> +
>>>>> +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
>>>>> -- 
>>>>> 2.33.1
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-amlogic mailing list
>>>>> linux-amlogic@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>>>
>>>> -- 
>>>> Thank you,
>>>> Dmitry
>>
> 
