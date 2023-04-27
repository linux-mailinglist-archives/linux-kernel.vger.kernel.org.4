Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6666F0359
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243320AbjD0J0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbjD0J0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:26:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35558DE;
        Thu, 27 Apr 2023 02:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7L6nW9Z1S3QUcKw3RUXcBHtANhrECPPDUj3PEC4n211cBXllPN/gSEMLhc8pGayK2EwfJGzxNA6de+xinPtj/I1KoI2tKzUni928Tm1HuqdLOiGIU3tKrOTPgkKowmmtR1Gn01a1nlpAnxLz7KI/3wtOi21SVtwDVwlYL9TmtPKiA0VXGI6pBYnQUOOwdHJillL1hlSG9JC9iBnC8FmiuvxBN5jFvlmdZPO8Gyh2HkpnKYDoj6gcQHYWw1R1IwdTzKbCEJOKDl3yfWcf/ycG+9tO5c9vCPAr5uJbG1bN11FZW0/6AJT5JWyJlJafNmG+yNOj+p4QysMU+tebk9nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8U8GJuL1xrZ+0HLBOt0VQxZr3xHR9RQDkj0LbUgmcA=;
 b=gVVZWnlMugA+Oboc94dNJ1xrpyyqJDXKMPN/NfIT4YPqPYurcoPOv2cB7K6lhI7okE/02Y29FLnB3QTvu01dm6U0kpvD8JHAMxXy7ifvc4Zl9QPf37CHIfBXyb29zg5C/UlWQgY7mtPtupszCXo4ZfYLlRwsWuriRhWgB07wtB5gH/hsAy/uizol+v5px3+P9rbtHA6LkLNrIYTmYzs9XqOcisfpVu+TWnx675HSzdKS/rqyI8tt+mQYMWUXgyHJa7WPxibJ+CDAHeTt6o/nYg4hgO2rjl3UWKUf1qhpwNJbzTvprBsjkDj5fnJPw3sHnKNL5evlVxvsxYqUBEn85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8U8GJuL1xrZ+0HLBOt0VQxZr3xHR9RQDkj0LbUgmcA=;
 b=Vwn/Y8veoGFf8nSQUi34viT7GnV6im63+sbOTmWl5QzOEi1rbm62KJt3V8ExGGDi9Zo8ExpkKrCG7xi4peKPrhNQdCFN3ZH6L8nhLuEV0tpWxs3ktFP0umvJj9E0LHlREow3f75LHBd+Mu18E4Y2sKBdjldTBHUXEa6z65XP4wqEjFetxFokbuud3XvxuVyZmYEG+TB8AjfeJZskYEtR+J0AA3IUQsZXJzVDmtW3S5Gn9rBDPIYk2T9KEje6JyT9zauy7MjFhK4PiLTwqML0pS/L4fgOoAq2zat6UrQjx7JFsc63W7l8FlcBfAI7NWZglk8lKC9za3c9115WDZqpqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com (2603:1096:3:21::22) by
 KL1PR0302MB5361.apcprd03.prod.outlook.com (2603:1096:820:48::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 09:25:25 +0000
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4]) by SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 09:25:25 +0000
Message-ID: <8cbc82f0-1ebe-b664-5d8f-98f1edff5842@amlogic.com>
Date:   Thu, 27 Apr 2023 17:25:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 2/2] arm64: dts: add support for C3 based Amlogic
 AW409
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-3-xianwei.zhao@amlogic.com>
 <4e6469e5-0f6c-4150-4709-7459597f06cc@linaro.org>
From:   "xianwei.zhao" <xianwei.zhao@amlogic.com>
In-Reply-To: <4e6469e5-0f6c-4150-4709-7459597f06cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0114.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::30) To SG2PR03MB2734.apcprd03.prod.outlook.com
 (2603:1096:3:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB2734:EE_|KL1PR0302MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 28787a74-de41-4695-59be-08db470153cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMMXWHK5HFd/ckBnDuENtDZaIp9rv+Q2/vAiGOR0q2p7IfwpdyDzy58KY2gYzGfbEp8vajySyW+JG3dEjV/IJT9Yasz4Kge9ujYe27Q9CGdnf9BBVUsNoen5ODNzYYTAgxT8L70QnE0D494PQ0Hi5f474vRCHAwvDbNf+N1tLyn4aZI+8McytfT1lEW+J3hnA2corg1UvPXPD35kvSdjXbsQtZ8SzbJ7udDDJV50ejDUr2X2UD1+RL9YiG2jjjm3I36VcZn01M3CM8ItbhbUBT++Z2xrlNhSWbEiPhx72rFHHdcmlLNbIXeZ1n+CjhbMOlgcm8VMOm52LC1aaiMcyJuIUDwj2SCYTlzE5lONeLFgCWJ924Frms/+GNbbQJMaB1132rok2DUbfhhwGJJPIDCV9DeuBy/m96zr0zA4XNPTYmGg34Rp8HAPWKMsY+Q8uljCbzzRsEbsALic8X4tX0UDC3T2O+n7x/kPff5McrfkLEqfZEBxdPnkgdbgUQUD/Ki9pM1Y1G4qxQkqkptAqCxIZBTD7kd+x5Zot+aybfnJM63YfJgB0bwnBO0fu8TDpIKcWmJaYts1GNlcoUqoOULlXVAQn8b8mA6TGUrnhPKD6SPJ0hOTKUFZB/mYN9VJjXddOFbMvgJdlULeP84vpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB2734.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39850400004)(376002)(451199021)(31686004)(26005)(6506007)(6512007)(38100700002)(6486002)(966005)(66476007)(31696002)(41300700001)(4326008)(66556008)(66946007)(86362001)(6666004)(54906003)(478600001)(36756003)(316002)(83380400001)(2616005)(53546011)(186003)(8936002)(5660300002)(8676002)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xtVzRBZFRqajYwczhaYVVQK2ZSMVNLakxvVE40VWRRL0x2OHFMTWFZeVQ4?=
 =?utf-8?B?aThXcHZ3b3FxVHFZSm93U3BGa3NiczQxbVF3Ymx1a05hMkVSR0NqdmVmOFow?=
 =?utf-8?B?bkZPaUtjbkdoejJBUzlubjlFbk5QK1JrZWFScDBNT0hSaTFBQXRrNXlscFZJ?=
 =?utf-8?B?bDJDZ3BPbVc1YjBYSWVLbnR5aXZ1OHFnTmVXSEhwQmlEN09NQmI4ekpRYnZ3?=
 =?utf-8?B?aW1aWmIzV0g5eHRNTVA1cVZkQlkxdXdJcmVTNlVzV0Q3MFFGenY4bTRRM1BQ?=
 =?utf-8?B?dHJ2VkRmeWpIcVJFdlcxZWRoWGtJL1krVWYwa0JmcFFBNldhaTFsakJRTktG?=
 =?utf-8?B?VEdvQTdTM1kwSTl2ZEhsV2YrdnQwaHZTRzJHWmNXeG9BVHJnTFdHTlRsb1c1?=
 =?utf-8?B?Q0JYOWQ5T3QyaVYvVEdObUI2eis4ejlZV3pUTDQ5T1RINmRKN0ljUndmVk9x?=
 =?utf-8?B?V3ZPRHVHem5pc2Q0bWhhcGoxTjJzYUVEQXpZTloyWlRyZ0p1dHMrd29Vanpy?=
 =?utf-8?B?dWhhNDV3WXFONG1IWGROTUNZN0hqWUxkVGd0ZkJROU5rRDRMY2lnS3ZaK09r?=
 =?utf-8?B?Vkt4Njl2Z3VORFgvN21yQThSeUJSQ2xMVVl0SWF0Vk5jQm9pZzVIeWUrdFFm?=
 =?utf-8?B?SjlCRFd2ek4zOVlxM1V3VEtqQVNmdkVYa09xbXBXVExWTWVKUUNUamlNYVFa?=
 =?utf-8?B?SU5mQVg3UVlVNEVOR05ZWGpxVVRQNzNsaG5rTDNnaXNZYVNBY3hVaFVmSVNC?=
 =?utf-8?B?U2puL1NaQjIrZDhkN3NJc09ubGNzNjNzbXFmNU41ZEVTbTh5dUxxWHNaTmF5?=
 =?utf-8?B?L002L2xVNnEveWl1aG5xQmYzYm5jZ1ZUajIyZXM5MEFzeEVYSURTeThwakI3?=
 =?utf-8?B?a2tKS0Q3K3JZNWdmeXowcUovdytEcDhLZjl2OHlIVzhzM2VBcHUyNTRleG5Y?=
 =?utf-8?B?RjFTUmZsSENyOU91QmRFbkZmYzJwclZWN2RMQWV3R1krbDFLNFp3ajNrTTB2?=
 =?utf-8?B?eFBNbGhyQ3JSNzltR1VkSHpZNGlJTG5FSGQ4TTV5bW4vMzdWclFEK3JiT3Nq?=
 =?utf-8?B?dDczcmNnZ0l1Z01kaEhqVFJ1NkRjRjAwaWQ1bGoyVzJwYThFa0MraEFqaExE?=
 =?utf-8?B?NzFEV0Q1dkhVNnFzSkI0NWNQTHlmcVdDSCt5MzQ4RFpjczB5a0l0Zkx4dzFV?=
 =?utf-8?B?UkFNTWFkc1VYY281UDY1ajhvK3VlQ1ZNem0yQS8rby8wSVNraUVkWFQxVVpx?=
 =?utf-8?B?Rm1JYzNWRlp6b2tFRGlUS1h6RHRvb0lTVXRXclp4bktaV2lseTVKUUdJcDJL?=
 =?utf-8?B?bEdWUEZpRXdmakRTNFRSNHh0VVdVN1daL21Yb2Jaek5OOGQ1U0M3ZDV3bzY4?=
 =?utf-8?B?MWxqZzN5Y0hjNC83dk1rWUxqQ3B5aW5lTnRDK3pnVVEzUGxzME5mY1hqOFJw?=
 =?utf-8?B?NWdWc0MzZVlMMnZGc2JGOXRocnQ0bm5BNFYxaVd2cUdPYzJhZnNlLzdCS01r?=
 =?utf-8?B?cjkvU0JxUDJTRTRyRjZMRUtZbHloMWprWE10d0t6WHlFUDNQaUk1a0ZhRldp?=
 =?utf-8?B?ZnkzY3pOc1l0MFVxeDRseFpwNk1NNVVDMjdyV3cwV3NuOC9tZHMxYU9HQVJH?=
 =?utf-8?B?R2ZDaVBmNjdPYk5OdkRmUUx1NTZCZDFlTy9pL1VCeEFTc1RNdVhZMllZWHR0?=
 =?utf-8?B?d3dFY0ppNEJoL3FiT29xVEhZeDh2dkNUUlkwS0NRaTMrbGliUkhtbXpSMFYz?=
 =?utf-8?B?c0NiTHRsWnk4bVNZRkt2WDFwbnBSQi9DYjZ4Mm1XSnl1REpxZ0IwUHZaZjk0?=
 =?utf-8?B?dFNUQkFEc05ndVF3QU00eEtEcERuYzVjcFJUdTdRQ1VDS1JFM2Rzby9remJC?=
 =?utf-8?B?MmRoRlFTMTJGVHdlSGpwd296UEJ4NDdNV1hNR1hOOGk0MXdrUGdNWlVZRWkw?=
 =?utf-8?B?U29pVEtZOFpUOFQ3cVpUdnB3bkZ5N1hyUUxTZ3piOE1JT3BIaEpaZi9BbEF3?=
 =?utf-8?B?aHdibzNiMGRhVnBiVEtIaklaZVhBcWJEcTY3N2RPSUFiNEF0L05lRjArWDc3?=
 =?utf-8?B?MU0vZ1FmdnpDS0lLUFVRWDJjZkozYWZZZlp3TUVKRDdWSUNvc0VyYlBqYU04?=
 =?utf-8?B?bEdnYzQwRzMxUGMxbGovWC9hWjJaT0RMV3BGVlNBU2JTNTlrTmJSR3ozYXY3?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28787a74-de41-4695-59be-08db470153cd
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB2734.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 09:25:24.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opfjO0jKUk+9+1KlmzKsdvlwwT5i2TjPCXqhhKBhwJnLK55q9ML/dpqEKkdskatMISdXeASbeEdlZj0gEjwDhk1C4on5ny6VInFZFUnDuPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5361
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
             Thank you for your reply.

On 2023/4/19 15:48, Krzysztof Kozlowski wrote:
> [你通常不会收到来自 krzysztof.kozlowski@linaro.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> 
> [ EXTERNAL EMAIL ]
> 
> On 19/04/2023 09:38, =Xianwei Zhao wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>> applications.
>>
>> Add basic support for the C3 based Amlogic AW409 board, which describes
>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>> booting up into the serial console.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>   .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 30 +++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 87 +++++++++++++++++++
>>   3 files changed, 118 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index cd1c5b04890a..d2b5d0d750bc 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
>> +dtb-$(CONFIG_ARCH_AMLIPC) += amlogic-c3-c302x-aw409-256m.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>> new file mode 100644
>> index 000000000000..38ca98a32181
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-c3.dtsi"
>> +
>> +/ {
>> +     model = "Amlogic C302 aw409 Development Board";
>> +     compatible = "amlogic,aw409", "amlogic,c3";
> 
> Undocumented compatibles. Run checkpatch and fix all warnings. Anyway, I
> am not sure this warrants separate architecture. Isn't C3 standard Meson
> SoC?
> 
The patch related to bindings is committed, see: 
https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com/
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +
>> +     aliases {
>> +             serial0 = &uart_B;
>> +     };
>> +
>> +     memory@0 {
>> +             device_type = "memory";
>> +             reg = <0x0 0x0 0x0 0x10000000>;
>> +     };
>> +
> 
> Drop stray blank lines.
> 
will do
>> +};
>> +
>> +&uart_B {
>> +     status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> new file mode 100644
>> index 000000000000..c69072ac57f5
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu0: cpu@0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a35";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu1: cpu@1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a35";
>> +                     reg = <0x0 0x1>;
>> +                     enable-method = "psci";
>> +             };
>> +
> 
> Everywhere...
> 
will do
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +     };
>> +
>> +     psci {
>> +             compatible = "arm,psci-1.0";
>> +             method = "smc";
>> +     };
>> +
>> +     xtal: xtal-clk {
>> +             compatible = "fixed-clock";
>> +             clock-frequency = <24000000>;
>> +             clock-output-names = "xtal";
>> +             #clock-cells = <0>;
>> +     };
>> +
>> +     soc {
>> +             compatible = "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             gic: interrupt-controller@fff01000 {
>> +                     compatible = "arm,gic-400";
>> +                     #interrupt-cells = <3>;
>> +                     #address-cells = <0>;
>> +                     interrupt-controller;
>> +                     reg = <0x0 0xfff01000 0 0x1000>,
>> +                           <0x0 0xfff02000 0 0x2000>,
>> +                           <0x0 0xfff04000 0 0x2000>,
>> +                           <0x0 0xfff06000 0 0x2000>;
>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +             };
>> +
>> +             apb4: apb4@fe000000 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
will do
>> +                     compatible = "simple-bus";
>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> +
>> +                     uart_B: serial@7a000 {
> 
> lowercase for labels
> 
will do
>> +                             compatible = "amlogic,meson-g12a-uart";
> 
> So this is just meson? Drop new ARCH, no need for it. Anyway, you need
> SoC specific compatible.
> 
> Best regards,
> Krzysztof
> 
