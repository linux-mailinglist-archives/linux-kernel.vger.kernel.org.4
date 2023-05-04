Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7E6F67E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEDJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEDJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:00:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9224F3C3A;
        Thu,  4 May 2023 02:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8TKP0WfknK3+cNWk6yAQu3ghHTCnhY72NXMPyxfwASzdrkWNtwcDk1LI4OcYIB0+B4t4thwiZMSimAktTCcrTgmi9CYVG/Pd1l7j1MBMhAy8jAGyFtxOUTeQ57vun7e+DZXTvN2Pn65xFhLUA6m9BW0XcIEaB6qN/YcbTGjQkLtMaHF019HOjapkdGNpGcGQrSIA8QUG+QMbesF9BHSBSQi7EOs1pXuVPYnb+A75Kw3iCYPXWauAtwCZXwPmlSd/BZkbA9gTiXVo+4paowBQhlXlV9TFd/pj9E6M6dr6CRx02WTc//n4dhWebbekCb1aoRSuqiKunQQhdMAEPtS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1F2eRGD9viHQg9Hkx84c02jrck22hQBI82zfmwXwDU=;
 b=ofHCzaoCtSx1fNdFMLxVZAzqneC7Cn4gkkH/ALd5bV/k4T6u237VjFvBqxjwMGLXic2EtZDbOVhvC+Yg3BDHwBCKjvpdPM3SOOOzEnpxjfNEhONHUzzrlhMQdxLSmarobW7x8vTEf30Q+4SfrIBnRj0GAykXbJG/SdNyd9BNio1Fq/vOItx3s8NdcE6B4sKNzQINLHMQ4LpS+27jWtULQDvhCKRAtCogqYeNrIaANAb7lDJ3FrEcVNimUu8wkQAy+2XqXYsFy/27sSvSk/ebxjyce2q8pGh8RrgaQ0PGyoLYR6f4MlzS4yIp8IR63B0qL9gKl4V6/EOy4T/0g/Zq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1F2eRGD9viHQg9Hkx84c02jrck22hQBI82zfmwXwDU=;
 b=AEJgVznG+pzXutn8zIMknM5bTrCiZuWwQoXoqS3ljmn6SYJ+QoQu9cRFNUb7Infq+IgewX9P8Q2AvEjnXNnwJkjLaS3Sgpd2T7V9QaHny6/1WG+HjYVsC9DFYrfxW1qA4zFYl38BvgRKWjn5ImRJR350neWMzxPaHlm8CxlXby5WybocpCFqmmSNRC73ng6giQN/PxA9Xtk42T0lhr/+MkrXY/tbsMf8RbIuS7qI+sxzHEvHI1KyYFBXg0DiulNNNO/qhPLEn+Qc70Gwkm4o+BqInBceyfoK8kemuhikMI4M23zwimH43Ic/5OPrBqYI+7q80M1arC0zBB1vwIKQzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB6594.apcprd03.prod.outlook.com (2603:1096:101:76::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.21; Thu, 4 May 2023 09:00:11 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 09:00:10 +0000
Message-ID: <f00990ad-22db-ee70-d76c-e52fc45d8f5e@amlogic.com>
Date:   Thu, 4 May 2023 16:59:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V7 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>
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
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20230427085228.vktptr76wbcdcksq@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEZPR03MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 5059973d-2328-4a86-505c-08db4c7df718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5Ju/MuimGrD4M/pPzzGhww9ygAcu4ZfA4k5rpVfQHDgDC4HI/o+oMKLtdFYcRF88Ic8UvscfM0NZoKKcKtjwQwzHar7VYdPsbQVGj+CUFb30WXW8XUIAO+egekePxHS3Kcwgdylyfv3E/vAauQhYORxPAKciF+fovew/SQiK6PwCowGVEG8hc6MMxwZZ3pmx0RFztutwxQgPlO0HHRPLpibct/AEHYWuad4vwzW/Ud5+ELdMsr8h+qJUrgUjnGqmFqjA6vpKOZAHRroJg7e3m0W+YvQT6FYjHIzsZICi2e3OQouxGuVUiUnKT0his3ShpFG6Ci4Qk0/PAYZkF7X9Rlj0vDhTtomXiXWWZWQitDs1UMLmyU+kI4e2jilSTKMzkpb7Z1t6CywjqMrRRvj/8d/HL8+ZzEjP8+jc9Wi4YrVACmcoC3/VPio68uaqZKrILCJHSbYBJFFWJnv4u2UwdV1m4/az4U9Kj7zdTR+8gVeKu3QEaMt4Zqu98sIp3JpgemSNjoHH0+HY9R8LSV64DD3tXV93HDejNjuDGZHOvSZeAXrhjgHct8f6CATMhQx104wY0p1WmdudulRundFgdDlkgq6ePhQRJ5380qkx0/JqZr4OP3maUymQoHmZQ4QT7TwAVwIZDJb/BZbib44wrh+0rXLV2EPNJt589j8heT5nO0kgw2d/HogdxJo5SAa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39850400004)(366004)(376002)(396003)(136003)(451199021)(110136005)(83380400001)(966005)(2616005)(478600001)(6666004)(6486002)(26005)(107886003)(6506007)(54906003)(186003)(53546011)(6512007)(38100700002)(7416002)(2906002)(30864003)(31696002)(66476007)(5660300002)(36756003)(8936002)(4326008)(66556008)(66946007)(8676002)(41300700001)(44832011)(86362001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHQrN3kvQkFSekF4eXFzWnlnTUQzaGVmSnlnNS9keVgzNTI4OFhDZnM4OHdN?=
 =?utf-8?B?ZEtwRk8zSmlMc2E5YVNkQWVKZi9lR2gzTE5qWjBoZjdqQWYxd0pOYlJBRDVl?=
 =?utf-8?B?Sk1RWFpoNGJ2SkwxcFlhSVI0eEx0YXBlK3RHdHZTRExSUEUzZmk1WWUycG96?=
 =?utf-8?B?T3FrTVdRdDdSbGpJQUZjZlFLamZmdlZtSG1FcjBZWk9Kdk1QN0dMNkRpd1Fr?=
 =?utf-8?B?WHFveXVPT05mUHA0Z0p3c045aGxGUVZ4SUxtY1VxTDF4cUU5d0hHT2NSMVNZ?=
 =?utf-8?B?aDdma3pHQThIRkF1Z1VaUkhobEZwQ3pYSmlPOThkUmc3UXk5S1JLelZON0hl?=
 =?utf-8?B?SnZoSGs1cHFZK093T2w5YmFqUHZwYlZwYmhpTEpuRjc4Vk9leDVBWDVHVHJG?=
 =?utf-8?B?U0dBS25yNFVXSndranJ2VDc3ZHByUUMyUEgrUVltUnNLY2Q1dXcybFBsVWR3?=
 =?utf-8?B?TGcwODllbUVob3VoYVg5T25ZNDZ6R1REbWZSRnZCaVJqUWpuYWRvVHF1c3F1?=
 =?utf-8?B?V1VPVGlORW94SEIrTm1JVzFUbGlQR092NHF0dFYxd3lwb2VlUFVPUG1yL2M4?=
 =?utf-8?B?cnJ2RktwMVpORk43bDIvTlBkOFlnQVprNVJtS0ZJYUVTYktNTGlqTmJIcDMv?=
 =?utf-8?B?aUhCdm1MRFRtT0dyZUlkdHo1eVFUeDVlVGpKRE9mUytRM3pydFpDRjZGbk5F?=
 =?utf-8?B?YUNGSHJNQ0pqaTFLRVFOMHM5RUsvakVhdG9GUCtHWkxmQmdiQmgzdnpmMkNn?=
 =?utf-8?B?S2orNExKMmRNVmxGQjZhQ3JxdmpIK2NzK3lqUStla0NiaGl6aUR4M3YzSHcw?=
 =?utf-8?B?Ly9UOFArL1lhR3lMTkM0SG14ZVdZS2xWa1UyYWRmbW8yZDdwZDhma3NsY3hX?=
 =?utf-8?B?ekhRUkJ5dlY3VGVDdVFydVEwMmlhZWlpdkthOW1MQWtnNzlRMEE0WVY2M2ZV?=
 =?utf-8?B?RDBvaHM0eWxNdHJsRHVieW1qdHN6SkF4Q29RQU1JdStLTFZycmlkdE5vQ0dq?=
 =?utf-8?B?N29GNVg2dFMvdWZZM1hJOS9BSVQ5NUhKd2FJeU0xdlJhWjBScWR4b0JFQTFW?=
 =?utf-8?B?YTVLOHNWSldNVWNvT3ludGNxYjhacXVjTXBDaG1zMXdDVThlNnZnUUpIdjVD?=
 =?utf-8?B?dFdCNXJ0TWdYV2x2Vi8zVkg5NXpRUW94ZWQrZVd2TUVxUlBiNFdIK3JycmN2?=
 =?utf-8?B?a2RhKy9VVEQrVFVqQ2pOUXlFNFB2Ryt6UlhNUFBSYUNyYzQwSitibkUxTTVS?=
 =?utf-8?B?MEorSE1RdTA2RzE4Y1pMbFBQSUU2eHlxcmxTMVlKRHgxS3V4SFc0SjRGT3dp?=
 =?utf-8?B?ZDJpRXdKY1hXRS9aRlhoQ2JMR3NQYmVxNlNiV0orVDVueW1WdFFDRmtyamJ2?=
 =?utf-8?B?c0QxckVoY1NoL3hnd1NFZmJic0ZkM2xBNEczTGlMYUZmSWxDcWRlQStFakVn?=
 =?utf-8?B?bmNZNlJLUDViR3BzTWc5LythYWVpWHZRVE5YUHJ2clRkbUtZZ2MyNDJnbXFQ?=
 =?utf-8?B?UGxScHdjVmpzZWVBeSszZzkrcW15NG5Qa2F6VVQzV1dVeXZicVZYczFIaDNP?=
 =?utf-8?B?cFFYaXJ4bEY0T1VlcGdPQUI2UEdDYm1tQ24wWFRPNlJiSHRUNXFXR29DeWk4?=
 =?utf-8?B?OWpoWU4xalAwZHlzeThVMWpnMk1UdkkzdzZQUjZ0ck95WmpaQjJTTGJnOEl3?=
 =?utf-8?B?TW84Zzh6Ui9JVkd4VjViZnBHMHpoTzJGTld0dTBvVjBjeUVPczFPSnVXdS9z?=
 =?utf-8?B?ZWNGRm1YaEhBTzRIcFlKM1NTcThWTzdMSE5JWFhFSWI2YWxLVTkvRHRwM0tG?=
 =?utf-8?B?RWxJWkdnQnlqaXdzdVJVV1lyelhlQTZPSTl4K2lpOEUzTXF3RjFZMHpValoy?=
 =?utf-8?B?a3VHTUdGT1FTZUlvVk8ydXhidEpBL0x3M0hMM2RKdnNpK3FkQ3Z3b2lZNm5T?=
 =?utf-8?B?ZE1BcWIvcFRwY1VUd0ZET2kwQ0RVa2NoOGhSUkRNeTRWVFlXbXZrMm95a0ZE?=
 =?utf-8?B?VjNNaUl5dDFDUUk5SmUzUHZLOHMzWjJydlNQZ012Z1pGMHBsYmU3SWdGKzNZ?=
 =?utf-8?B?OG1ZU1ZDcVhjM3dwS3JXL3AvNmhwR2huTDNsUUwzTHEyNXMxd21nMW0zN2N4?=
 =?utf-8?Q?Ya0T9qntCMDQ+JDFIcbZKfFDN?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5059973d-2328-4a86-505c-08db4c7df718
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 09:00:10.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdvfi7/EWz8rH8bihO7v0/CNGeKZcrj9evJ6TavM8+2tZL8risy1chOzOMkfXgW6fv8aw587OfKhrK7hPXfRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6594
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/27 16:52, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Apr 27, 2023 at 04:03:41PM +0800, Yu Tu wrote:
>>
>>
>> On 2023/4/26 18:49, Dmitry Rokosov wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hello Yu,
>>>
>>> Thank you for the patch series! Please find my comments below.
>>>
>>
>> Hi Dmitry，
>>        Thank you for your review.
>>
>>> On Mon, Apr 17, 2023 at 02:50:03PM +0800, Yu Tu wrote:
>>>> Add the S4 peripherals clock controller dt-bindings in the s4 SoC
>>>> family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    .../clock/amlogic,s4-peripherals-clkc.yaml    |  97 +++++++++++++
>>>>    .../clock/amlogic,s4-peripherals-clkc.h       | 131 ++++++++++++++++++
>>>>    2 files changed, 228 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>>    create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>> new file mode 100644
>>>> index 000000000000..46b969a16a7c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>> @@ -0,0 +1,97 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Amlogic Meson S serials Peripherals Clock Controller
>>>
>>> As per my understanding, Meson is no longer applicable.
>>> As Neil and Martin suggested in other reviews, the term 'Amlogic' should
>>> be used instead or 'Meson' should be removed altogether.
>>>
>>
>> No. This was all agreed upon a long time ago. Corporate drivers and dtsi are
>> named after this.
>>
> 
> Okay, it seems like there may be a misunderstanding here.
> Now might be a good time to ask Neil about the correct behavior.
> 
> Neil, could you please provide the specific naming rules for the new
> Amlogic drivers? Where should we use the 'meson' keyword, and where
> should we not use it?
> 
>>>> +
>>>> +maintainers:
>>>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>>>> +  - Jerome Brunet <jbrunet@baylibre.com>
>>>> +  - Yu Tu <yu.tu@amlogic.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: amlogic,s4-peripherals-clkc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: input fixed pll div2
>>>> +      - description: input fixed pll div2p5
>>>> +      - description: input fixed pll div3
>>>> +      - description: input fixed pll div4
>>>> +      - description: input fixed pll div5
>>>> +      - description: input fixed pll div7
>>>> +      - description: input hifi pll
>>>> +      - description: input gp0 pll
>>>> +      - description: input mpll0
>>>> +      - description: input mpll1
>>>> +      - description: input mpll2
>>>> +      - description: input mpll3
>>>> +      - description: input hdmi pll
>>>> +      - description: input oscillator (usually at 24MHz)
>>>> +      - description: input external 32kHz reference (optional)
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: fclk_div2
>>>> +      - const: fclk_div2p5
>>>> +      - const: fclk_div3
>>>> +      - const: fclk_div4
>>>> +      - const: fclk_div5
>>>> +      - const: fclk_div7
>>>> +      - const: hifi_pll
>>>> +      - const: gp0_pll
>>>> +      - const: mpll0
>>>> +      - const: mpll1
>>>> +      - const: mpll2
>>>> +      - const: mpll3
>>>> +      - const: hdmi_pll
>>>> +      - const: xtal
>>>> +      - const: ext_32k
>>>> +
>>>> +  "#clock-cells":
>>>> +    const: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - "#clock-cells"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>>> +
>>>> +    clkc_periphs: clock-controller@fe000000 {
>>>> +      compatible = "amlogic,s4-peripherals-clkc";
>>>> +      reg = <0xfe000000 0x49c>;
>>>
>>> I was under the impression that reg as MMIO address should have four
>>> cells on ARM64 architecture. Are you sure it only needs two cells?
>>
>> Yes. Maybe you can check out the clock file for other yaml.The two cells and
>> four cells all are ok.
>>
>> It's not a problem even in real DTS. How many cells are needed to look at
>> the parent address-cells and size-cells definitions.
>>
> 
> AFAIR, it depends on which OF API you will call for retreive address
> and size values (u32 or u64).
> 
>>>
>>>> +      clocks = <&clkc_pll 3>,
>>>> +              <&clkc_pll 13>,
>>>> +              <&clkc_pll 5>,
>>>> +              <&clkc_pll 7>,
>>>> +              <&clkc_pll 9>,
>>>> +              <&clkc_pll 11>,
>>>> +              <&clkc_pll 17>,
>>>> +              <&clkc_pll 15>,
>>>> +              <&clkc_pll 25>,
>>>> +              <&clkc_pll 27>,
>>>> +              <&clkc_pll 29>,
>>>> +              <&clkc_pll 31>,
>>>> +              <&clkc_pll 20>,
>>>> +              <&xtal>,
>>>> +              <&ext_32k>;
>>>> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
>>>> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
>>>> +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
>>>> +                    "ext_32k";
>>>> +      #clock-cells = <1>;
>>>> +    };
>>>> +...
>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..073396a76957
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>> @@ -0,0 +1,131 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>>>> +
>>>> +/*
>>>> + * CLKID index values
>>>> + */
>>>> +
>>>> +#define CLKID_RTC_CLK                        4
>>>
>>> I believe that the CLK suffix is unnecessary since it is already clear
>>> that the object in question is a clock. Additionally, it is redundant
>>> to use the GATE suffix.
>>
>> No. These prefixes and suffixes are very friendly to the people who write
>> and read the code.
>>
> 
> Jerome has already pointed this out in another review for the
> A1 clock driver, there are redundant suffixes:
> 
> https://lore.kernel.org/linux-amlogic/1j359y82fn.fsf@starbuckisacylon.baylibre.com/

After discussion, we think that the CLK suffix can be deleted, but the 
GATE suffix is convenient to look at the code even though it is redundant.

> 
>>>
>>>> +#define CLKID_SYS_CLK_B_GATE         7
>>>> +#define CLKID_SYS_CLK_A_GATE         10
>>>> +#define CLKID_SYS_CLK                        11
>>>> +#define CLKID_CECA_32K_CLKOUT                16
>>>> +#define CLKID_CECB_32K_CLKOUT                21
>>>> +#define CLKID_SC_CLK_GATE            24
>>>> +#define CLKID_12_24M_CLK_SEL         27
>>>> +#define CLKID_VID_PLL                        30
>>>> +#define CLKID_VCLK                   37
>>>> +#define CLKID_VCLK2                  38
>>>> +#define CLKID_VCLK_DIV1                      39
>>>> +#define CLKID_VCLK2_DIV1             44
>>>> +#define CLKID_VCLK_DIV2                      49
>>>> +#define CLKID_VCLK_DIV4                      50
>>>> +#define CLKID_VCLK_DIV6                      51
>>>> +#define CLKID_VCLK_DIV12             52
>>>> +#define CLKID_VCLK2_DIV2             53
>>>> +#define CLKID_VCLK2_DIV4             54
>>>> +#define CLKID_VCLK2_DIV6             55
>>>> +#define CLKID_VCLK2_DIV12            56
>>>> +#define CLKID_CTS_ENCI                       61
>>>> +#define CLKID_CTS_ENCP                       62
>>>> +#define CLKID_CTS_VDAC                       63
>>>> +#define CLKID_HDMI                   67
>>>> +#define CLKID_TS_CLK_GATE            69
>>>> +#define CLKID_MALI_0                 72
>>>> +#define CLKID_MALI_1                 75
>>>> +#define CLKID_MALI                   76
>>>> +#define CLKID_VDEC_P0                        79
>>>> +#define CLKID_VDEC_P1                        82
>>>> +#define CLKID_VDEC_SEL                       83
>>>> +#define CLKID_HEVCF_P0                       86
>>>> +#define CLKID_HEVCF_P1                       89
>>>> +#define CLKID_HEVCF_SEL                      90
>>>> +#define CLKID_VPU_0                  93
>>>> +#define CLKID_VPU_1                  96
>>>> +#define CLKID_VPU                    97
>>>> +#define CLKID_VPU_CLKB_TMP           100
>>>> +#define CLKID_VPU_CLKB                       102
>>>> +#define CLKID_VPU_CLKC_P0            105
>>>> +#define CLKID_VPU_CLKC_P1            108
>>>> +#define CLKID_VPU_CLKC_SEL           109
>>>> +#define CLKID_VAPB_0                 112
>>>> +#define CLKID_VAPB_1                 115
>>>> +#define CLKID_VAPB                   116
>>>> +#define CLKID_GE2D                   117
>>>> +#define CLKID_VDIN_MEAS_GATE         120
>>>> +#define CLKID_SD_EMMC_C_CLK          123
>>>> +#define CLKID_SD_EMMC_A_CLK          126
>>>> +#define CLKID_SD_EMMC_B_CLK          129
>>>> +#define CLKID_SPICC0_GATE            132
>>>> +#define CLKID_PWM_A_GATE             135
>>>> +#define CLKID_PWM_B_GATE             138
>>>> +#define CLKID_PWM_C_GATE             141
>>>> +#define CLKID_PWM_D_GATE             144
>>>> +#define CLKID_PWM_E_GATE             147
>>>> +#define CLKID_PWM_F_GATE             150
>>>> +#define CLKID_PWM_G_GATE             153
>>>> +#define CLKID_PWM_H_GATE             156
>>>> +#define CLKID_PWM_I_GATE             159
>>>> +#define CLKID_PWM_J_GATE             162
>>>> +#define CLKID_SARADC_GATE            165
>>>> +#define CLKID_GEN_GATE                       168
>>>> +#define CLKID_DDR                    169
>>>> +#define CLKID_DOS                    170
>>>> +#define CLKID_ETHPHY                 171
>>>> +#define CLKID_MALI_GATE                      172
>>>> +#define CLKID_AOCPU                  173
>>>> +#define CLKID_AUCPU                  174
>>>> +#define CLKID_CEC                    175
>>>> +#define CLKID_SD_EMMC_A                      176
>>>> +#define CLKID_SD_EMMC_B                      177
>>>> +#define CLKID_NAND                   178
>>>> +#define CLKID_SMARTCARD                      179
>>>> +#define CLKID_ACODEC                 180
>>>> +#define CLKID_SPIFC                  181
>>>> +#define CLKID_MSR_CLK                        182
>>>> +#define CLKID_IR_CTRL                        183
>>>> +#define CLKID_AUDIO                  184
>>>> +#define CLKID_ETH                    185
>>>> +#define CLKID_UART_A                 186
>>>> +#define CLKID_UART_B                 187
>>>> +#define CLKID_UART_C                 188
>>>> +#define CLKID_UART_D                 189
>>>> +#define CLKID_UART_E                 190
>>>> +#define CLKID_AIFIFO                 191
>>>> +#define CLKID_TS_DDR                 192
>>>> +#define CLKID_TS_PLL                 193
>>>> +#define CLKID_G2D                    194
>>>> +#define CLKID_SPICC0                 195
>>>> +#define CLKID_SPICC1                 196
>>>> +#define CLKID_USB                    197
>>>> +#define CLKID_I2C_M_A                        198
>>>> +#define CLKID_I2C_M_B                        199
>>>> +#define CLKID_I2C_M_C                        200
>>>> +#define CLKID_I2C_M_D                        201
>>>> +#define CLKID_I2C_M_E                        202
>>>> +#define CLKID_HDMITX_APB             203
>>>> +#define CLKID_I2C_S_A                        204
>>>> +#define CLKID_USB1_TO_DDR            205
>>>> +#define CLKID_HDCP22                 206
>>>> +#define CLKID_MMC_APB                        207
>>>> +#define CLKID_RSA                    208
>>>> +#define CLKID_CPU_DEBUG                      209
>>>> +#define CLKID_VPU_INTR                       210
>>>> +#define CLKID_DEMOD                  211
>>>> +#define CLKID_SAR_ADC                        212
>>>> +#define CLKID_GIC                    213
>>>> +#define CLKID_PWM_AB                 214
>>>> +#define CLKID_PWM_CD                 215
>>>> +#define CLKID_PWM_EF                 216
>>>> +#define CLKID_PWM_GH                 217
>>>> +#define CLKID_PWM_IJ                 218
>>>> +#define CLKID_HDCP22_ESMCLK_GATE     221
>>>> +#define CLKID_HDCP22_SKPCLK_GATE     224
>>>> +
>>>> +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
>>>> --
>>>> 2.33.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-amlogic mailing list
>>>> linux-amlogic@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>>
>>> --
>>> Thank you,
>>> Dmitry
> 
> --
> Thank you,
> Dmitry
