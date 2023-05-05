Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4626F7D43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjEEGuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjEEGt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:49:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2139.outbound.protection.outlook.com [40.107.215.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40B1609B;
        Thu,  4 May 2023 23:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQoYJOsEVep9wxYgCnpMCZ6L6788zsRiFr9H90dWOh5RWZSKGhgP3jjgSIDgfjNuBxxpbOOolMBhL18l+SOpNDNVd0/eqZZ6LgoPbFeGVd22UAa1b6CkCldtb5q8kMEUnkPuKchVm4vCaODbLmRHFcrlJSPbYbaBQUjloFhyU8EcYFpQXjEcVauXADUi34/A8oIayvnOXT8pWBAjLRJHQkfOefGgPTcUqvvBwRzg2tL6RGsWga4T7RTXzeN0fv+MDV4ryud5OoesIhp3W4rLpQOi4JCaiSg2QS+67ZP6wCdekJCgdVPU+N9FJuJtvgz0rKtNagWoeTKlbr7ovrNFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks2tbyO+YXbTuOE1ap44A0YRxnKawwtL+p6iayopjHM=;
 b=dK4OQrXsgAQgkvhV37lGRSDvDGHGa+4DF5Y6tHvx7lCpko4/knJ6JKyrOtWjeOZ4Qtzd7jnVTpnPer0Nd5xhmCTenOsKRp86EGSnGr6jHguyTrRDFJaXuYGWOdw5MW2U1bNTsHVkJLIfClJuz2LaQt02mOpH+cY8N/iluafmxDF+wKfMHOpFIjhqUdyAo7u9cwQ+/H5Ji/CNuB+IiTwoLLhEUowiVjHI52BZCJv3BBem9PFG+lLDIwvIvSr7YRIJzuNA4w2nDQH4CTFET4SZBa/pecNk+sgcan9JDibCYdPisWW0gEk8WI19gtAKmaNiqAoMCGNidvQlMLhZEbz4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks2tbyO+YXbTuOE1ap44A0YRxnKawwtL+p6iayopjHM=;
 b=JyxqzMYL/AnuLKlWIfwn3HXkRFDspVkb9FmrFnTuGcfdq2Cj/HDkQBosgNGw2EzTdPcJFQMF9HAEef39gzf1YRSeE244fLkkTHxUlN/FvSyN1dCy+4bB4uPq7RC0sd9lMNqzLNJebna38xdZ/NH0ndlQzWVwerAa/Zd94Fegddzh2vjb3iZ18DqNixgw3sSqrXrZOWkWsgbWLeouXMf6py1EBWGpwkd0N1xmiZ4GuQmHHYJypvbNop9A8tQmRh6KiMbI3EC8++Dwkzn+ZYLaeHdXPqO5h9XSnURT0VH1snm1AMfBsO73/qgITw6zBPIO01Y3aP8kAAEEt9IjhiHidQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com (2603:1096:3:21::22) by
 SEYPR03MB7250.apcprd03.prod.outlook.com (2603:1096:101:bf::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.25; Fri, 5 May 2023 06:49:04 +0000
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4]) by SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 06:49:04 +0000
Message-ID: <04b2a566-ed83-1e47-1571-e3d5ae4d3323@amlogic.com>
Date:   Fri, 5 May 2023 14:43:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2] arm64: dts: add support for C3 based Amlogic AW409
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
References: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
 <36e7a445-7d19-911a-1a94-ffc30172e1a3@linaro.org>
 <e3083eab-ba85-3e9b-b3f2-f50816163f9f@amlogic.com>
 <d2ca44b1-71ab-093f-0dee-fa66e4aa378a@linaro.org>
From:   "xianwei.zhao" <xianwei.zhao@amlogic.com>
In-Reply-To: <d2ca44b1-71ab-093f-0dee-fa66e4aa378a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To SG2PR03MB2734.apcprd03.prod.outlook.com
 (2603:1096:3:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB2734:EE_|SEYPR03MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b725ff9-9552-414a-91a3-08db4d34cff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lMWi0aASB0Vvx2lbRTNHL3bjRaxPJug0SJAQMYCqg3/qKzr5bcCL+YwBN+ASaNMIYy8pA6Vjzu1T+MWUeDXE4jibCu5mLActGmv0mkdmqMoRVcLve7ijGK2/v8mZ+8fUAwcUc7wxtKF4rteGTgGDn3ZNepwvJY+TTXkKizXnZ4k31fF6Ljp2TCr7q/nQpKratmnT4WTM53jIfbZB8qspU+Ry1B9CA5aIgE1C1JpdywOYcpJjzOF8sDUbeXnlgk+vsodeDcP4yJm/Pi+3OKS7BK+9lYFtP0cRDBXQNxYUoBNqt9mYDQvpaW3Ixj7PTzOiV5cLGyTrdpJu6EXzZHmuW1v46GI1GxFZpbu2gCn65bhGUCZgj9UZF/+okXNfGqGFS9AEChq/pM1jNrd3dn5wG2bWHro0pQtsTZbLBDe1xb7prQUkayL3TpKEn7BNBi51x3JjDAgY8CU1TftIMQSoqqei3nYM7nWTig//6013RJpLfJ91410u/0MTSYlf0OHU5Zvjhcqs+qg/fMj/4NQ1ezsbgCIUDb3OR1Z6CXUbK+DaGpFYFR1DTORAzuASVbRzBwbldVSkKebjRflbuWw/Ou24hhJrkidzTIphxPMWuLr7hgBT77n7FQjeRHRxRsLfZVAohbiuZMQb/X4C2DSAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB2734.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39850400004)(451199021)(7416002)(478600001)(966005)(38100700002)(8936002)(8676002)(5660300002)(2616005)(86362001)(6666004)(31696002)(66946007)(66476007)(36756003)(66556008)(4326008)(6486002)(83380400001)(6506007)(26005)(53546011)(186003)(316002)(2906002)(41300700001)(6512007)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1IzU1QrSm9Ta2N0QkJiMWVBMlJKVEN5WnIvRmJXc3BjblgwNDk2cmlEN1Ba?=
 =?utf-8?B?UDMwMm1JQWRJT0RKZ1A1Y0p6UVAxWVd4VDRPcWJsMGJBQ1Brc2V2aHQ1QzVl?=
 =?utf-8?B?TnlTV25yTUV3anBBRHhxMk9iRm43Zk9MdXBWd2dmSFZJMVJWVklWU1RoVTBF?=
 =?utf-8?B?bXNmMEFLZDBFcEFuM29acVVBdUZtQlJhMlN2NlFvNVFSOC9qbVhpNGNlYW9R?=
 =?utf-8?B?dmZxejlzU2pNUW95TjZ5SERNZEFEaDFpa1ovbjZGc1B1VForU0R1bFFaN05j?=
 =?utf-8?B?WXRxZDEyNzFzRWtTRTFjYWZnanZKeGZVdm9xL2x5SktWaE1EV1N3RXVwTWdv?=
 =?utf-8?B?NmtiU21QSkc0YytJeU5QVmRjOE1lU1FoYkdxL1ZKYTFTd0pQSmFEZ3dsTDVB?=
 =?utf-8?B?ajB4ZmZhU0I4cmFDMmZOVXpzang3MXNTdkljRERpNTkxcVpxbmpQQUMvU0R6?=
 =?utf-8?B?VUNqR3hZS1FMUm96Q3JBRmgzbktFNVJ3VzB4dnJMMGtheDBKK0lLdWlRR09a?=
 =?utf-8?B?VUNtNm1XOXhoT1hnMSt3MGlTOUFXTlFPbmdHWkZDQ2hSQ0RoNEYwMUFZVXN0?=
 =?utf-8?B?eUE4amZBd1NvaXRGcXlvSzY5WEhHK3FiT0NqMnpPbTdrYTZhOXBaaWJWMFlH?=
 =?utf-8?B?QmFSUFM0L21CM0VSNVBJWlE0Q2tncFg4RXFLOG15UXpWeHFET3JhRTBBaVgz?=
 =?utf-8?B?aW5GdXRHWUdDQkl2Wm9OenlBcDZHbEgxNzBQZlgvUGpXSUYrdmtmenByS1p4?=
 =?utf-8?B?OU0rQ1BkMFVML1R0cklQempYU1RqZXdWeVZ3ZUZEc0dybUROUWRqTEUrWXpo?=
 =?utf-8?B?MWM4c3NsczA5NHhBRVpQcjdkam1sbFRNaFBZSmNUZFVmcmZwa3FMY2FhODNm?=
 =?utf-8?B?OFZFN1U4a1BIK01wL1dWc1FzM2w1ZGt0ZEhNUWw0NFRDTVBGSDNnTjBlNTFG?=
 =?utf-8?B?Njh2bFRybE5tL29KS1VUVzNiTXFwSFpUSXZCSUk0QXBCTTZCaWRJaGJYaEYy?=
 =?utf-8?B?T2MyZXpLeDlvUzVPaWtMOW9wTDJibStsc2lJQ25abjhxQ2VHZEpJYTlXcWww?=
 =?utf-8?B?QW16bE5Cd2s2Nm4yaUdBWG9BenFPZ2hydW5xcnJZeWFObzRHWEhvSkRVUXAx?=
 =?utf-8?B?eUduQS93eStJSitLcE01eS9oTDhiTittb3p6K3ZQQVFjVXFMOExjZVk0ditO?=
 =?utf-8?B?enJWSHJzeHI3U2crb1UzbzBSVUkrcjFBQ2RabGNHVjV5ZmR3NENjblJaTlNG?=
 =?utf-8?B?NUVuL0UyQ0ZTOERZZkhjSWd5N2QxQm53V2hUQnVMK1J1Z29WaFRFSVphekw5?=
 =?utf-8?B?S0dJYmZvSlJIaHp4RmFkUldIb1VZT1ZlN2pabXE1ZVVaOXlwaXFmSzJaaVdq?=
 =?utf-8?B?NXI1SFhNQjNOY1ZEc3ZNMnNFYlhzSUMxQlptb0I0cFF3OHVsWVZ3WmZGaExT?=
 =?utf-8?B?S2ZoaExYVVFjQmZYTnpXTUFxSHF5RHdERlJNRFVrd0dtb3V4RlVIRkc3Qmpr?=
 =?utf-8?B?WWcrSkxCL0xOWHhWNFcrYXczYUxGTXlTUnEySzg5MVdGL2NXcldQbngvY0pt?=
 =?utf-8?B?cHNYWjduSFlJbG1xM01aOUV5bUJCTnkyck9Cb1pzbzNzYVJHUW1kMC9Kb1Bi?=
 =?utf-8?B?NGgyNFhUSlhCU2tNTlpQMlZkVE04YlA4eHlnRXcwQ2NCVkJUcnY1RkY3QWlO?=
 =?utf-8?B?Q21hZFFtaHFKNDhGeWpMMHlIeTc1Q09nRWR2ZWdlQk9iaVhUZXNXOHJSOFlz?=
 =?utf-8?B?Ui9XRkhVWWdpVkNYcTZwWktybW1xcGVoSTNwRGhvQXFZWDRwOGEvMERpNm9a?=
 =?utf-8?B?YmNHOWdBbzJQTkFUeFFwY0VHZzNwSktCUUc1NFJCK0pBWGxRNWMvOUVhNk5R?=
 =?utf-8?B?aWc2V0d1UnF5ZkR1YVU3azlEeVcvWVgxbngwaG9UYS9mQk5aRXhld2xBOHpF?=
 =?utf-8?B?THJGdTI5L2RmS2drdWZnMzg2VnhKcDJGb2Zlb3FwSFdwLzRTU1hQeEhGNGdU?=
 =?utf-8?B?WlhCZEdhd1k0WGp0R1FTeTk0b3NuVUpQalJJeVhvdnQyc215SG40WWpMRnRN?=
 =?utf-8?B?YVRucVhJaEp5RUwyL1F3RnRtQzZKSERpZE1GWU5mOUNEaHIvZllhems5Mms0?=
 =?utf-8?B?d1JTNHN2eW43Wm85RzMzTHdNSVpLZVNGMTlwL2ZjTFBQd1NhRUhWV1FnUWR5?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b725ff9-9552-414a-91a3-08db4d34cff6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB2734.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 06:49:03.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoB1wNEGGVWom+X08Aq2uKEOELGAC4ISsUsLfKsrLqiiZWQC+uEC0QIgc1te1tV43lF/Ewe/bZWKDCrolMCDNvGC2PzwQQE2du/56Cn7kEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7250
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 14:34, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 05/05/2023 04:37, xianwei.zhao wrote:
>> Hi Krzysztof,
>>        Thank you for your reply.
>>
>> On 2023/5/1 17:58, Krzysztof Kozlowski wrote:
>>> [你通常不会收到来自 krzysztof.kozlowski@linaro.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 27/04/2023 10:58, Xianwei Zhao wrote:
>>>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>>>> applications.
>>>>
>>>> Add basic support for the C3 based Amlogic AW409 board, which describes
>>>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>>>> booting up into the serial console.
>>>>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>
>>>> ---
>>>> V1 -> V2: Remove new arch, and use ARCH_MESON;
>>>>             Modify node name, and delete superfluous blank lines.
>>>> ---
>>>>    arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>>>    .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 29 +++++++
>>>>    arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>>>>    3 files changed, 116 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>>>    create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>>> index cd1c5b04890a..bcec872c2444 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>>> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>>>>    dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>>>>    dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>>>>    dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
>>>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409-256m.dtb
>>>
>>> Looks wrongly ordered. 'a' is before 'm'.
>> Will do.
>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>>> new file mode 100644
>>>> index 000000000000..edce8850b338
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>>> @@ -0,0 +1,29 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "amlogic-c3.dtsi"
>>>> +
>>>> +/ {
>>>> +     model = "Amlogic C302 aw409 Development Board";
>>>> +     compatible = "amlogic,aw409", "amlogic,c3";
>>>
>>> Missing bindings.
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings.
>>>
>> The bindings committed by Neil, it is applied to
>> https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
>> (v6.5/arm64-dt),
>> bindings:
>> https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com/
> 
> It's not in the next, so please always link them. We expect them always
> together, so if you decide to do otherwise, it's your job now to keep us
> informed. Otherwise how can we know that you sent bindings or you didn't?
> 
Will add link in V3,thanks.
> Best regards,
> Krzysztof
> 
