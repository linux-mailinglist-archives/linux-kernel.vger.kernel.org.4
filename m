Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC746F7AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEECUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjEECUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:20:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E6A27D;
        Thu,  4 May 2023 19:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN4GOXF17eFBAhUMaWIpj/bcJWk1LU/Wm/A/N2I8kbww56g6k8ZUhvJUiRKWUzZ+a2LcniF+4NhZ/1vAwQNudE1V30e/tblC/XYoe8T2AdmqxxUFst/ekVw0237cJKxaCvAUvB71RZjC5GObQmzMMkPmUL+G5Xp0jVr3tK79IBuSJiZKIBu4xTe7NAshcxo+nC0+jo5an1qht1cjQ2BK6C4w2xr6Uzkm5t4277bE9Q5GmNaLyDEvE9f8z/oR1hEDaPcBw5oGSaSp4G3lnlzBa0MihciMwQxFTchBTYSBGzRoxdroTvKzHDRWRlTutwZL8jbTU2yLvp8IKxjsJxe0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVgZ/GJPwaLCZaAMqmcJ5w9XyjaDKbnXAWAxfH3hBPo=;
 b=F06POU+D0o+SQQsiTdETeDvhbFpcIL41ulnsl3W8wmG+22xT18Uzs9l8U8Th0mMXc6ENzdp6IDC8TGplfAua2bboyzz0bB9/P6yIm1OcayKB6SKH8KIRMhFlCURKu99Y162kdQ1UPxbhaFoFx8C6dMbUDs3vnGadEiUl97GK+v/m9J148iI5t7eYSIeI7Q1bcraVWl6jb0ucLCUuRvTg8NEaZjeanjtaKOy5jiIuAlMQTYxDIEZW1vSjlB9wHAa5OfQqJFYxu4pRdClvGoPkJLH/7If+F2NHPOQydHUCrpwkKOwIkSh2ei+E8rxzFYuJonGgRipY87TMHQWFGBrysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVgZ/GJPwaLCZaAMqmcJ5w9XyjaDKbnXAWAxfH3hBPo=;
 b=xygVWRiyIPVvg1jJqf+vF8ZRu4EYGmYh0Ao7MlQBT1wOR1/r5aA4n90D1xd7xxU/RfARG7HOO+rQcNRAaCp0/HPenBtePDC7LdV+kr4IC09x1sX2hpTKau74ICw0rCQEkRz/kjEr6PzFtZKe/Ixy2EdTKc5+fEvd3HWljmgHRhmrxp12yEh6vhPWKg5+6EtjA0rEGRL5iTxpmBBwRdXeI7JwpJlB34eTNC3YUZO1m0Iyl6LaautXWhK3pb+e2goKMt3wORWPvz7M0VYjrp2t2tIfC55d+q29fU5442ZVu4qgD4OsfFumBvXGM2b5QVGGSmgWHknX0TStamBLNdivnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com (2603:1096:3:21::22) by
 JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 02:19:18 +0000
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4]) by SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 02:19:18 +0000
Message-ID: <f6c78299-1dcc-7231-a524-6eb64157e1cc@amlogic.com>
Date:   Fri, 5 May 2023 10:19:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
 <1C87B1C1-122F-491C-9D3A-1FE1EF6F2B87@gmail.com>
From:   "xianwei.zhao" <xianwei.zhao@amlogic.com>
In-Reply-To: <1C87B1C1-122F-491C-9D3A-1FE1EF6F2B87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0182.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::9) To SG2PR03MB2734.apcprd03.prod.outlook.com
 (2603:1096:3:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB2734:EE_|JH0PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccd2f01-2161-4d18-7cca-08db4d0f20c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8or8s1cfKPlUKziVlMOWUGkY7cb8fKQX7Q6+an5Cpxngxh46jgkXXnaNv3b6o/KvmgCCN0RGegZPZExzIf1aTQeCjyk2jvs8mfW5Ld+0xVkD0Li1ZQlTmco0CgaX8e1w4SX89nn7s50JeZ61pJ6OUz48fGieRLeWhAHhTj38ctOz+SeNHXGbsb/hWtlkSH+FKm4JI+mll3IVyOmqPiG1p5FdvUCJvZfvKf457MPvgqY/KRtC5vCUjqHGzoDSIqUY9Mhs1brPDtmNStMmnaABiSOvWno25zDhkBYUU0D4s9KaZBZhrklVugXwuRlCL76oBUxzdYN/Xf0hOjszGmYkCxf15lf+g89VGqMDXv+cyyD490Uum/miED4N+eu9SJ6D3VOJODYA885/luAShaHIT+uYMg1lea06n2EEc7J0SQwKTuOTMi9ZJxwMxrlK82kMqA2JfLZoog/P5U7UgrW5M+OJcCuA5EC9r7Z5tETUa77cl44s57zro2xml5SB++3eOqJrL6nXWyduyB83ShIZ6CdHDZJozU/9387W3nA0sONa7B3cDBze8iia/kmx8OhNBkoiFyYjB8KFspD/26biF/m8JA9lrd+zC7Dto2zWqeFHYjr1JcXHz4TD82E+mn84XkQCSz4uKkAz3N4XcaguA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB2734.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39850400004)(396003)(451199021)(5660300002)(31686004)(7416002)(31696002)(83380400001)(86362001)(38100700002)(6486002)(4326008)(6666004)(2616005)(966005)(8936002)(41300700001)(478600001)(8676002)(54906003)(36756003)(66556008)(316002)(6916009)(66476007)(66946007)(2906002)(186003)(6512007)(26005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThteVRkNG1OZVkyQWVuQ2hIR3NiYll3Z0hIeS8rSmRERTJ2QU03bjY3bWpK?=
 =?utf-8?B?ckxNMjlEdnROTWlORS9JbUllVGdHQ2svYXQyb1hCNGpRdzF0eE1TbUV2ekNn?=
 =?utf-8?B?dDk0ODE3VXVuR0dIazNydUxzQVFuT1M4eEd4RVNKc2ttUDM0dTBZTWVIbWQx?=
 =?utf-8?B?VFJSclZ0aW9wc1JUWVluNjdqL3JMK28yVXBGYVh1cGh6dDVvRms5amV1eU82?=
 =?utf-8?B?dHAwY1Q1VVVMYVFnU1lLNFkvTVZnTDF6bWdwTE5PUllBUE5IVTQxZVV5UFpR?=
 =?utf-8?B?UDFqOVFDc2NFRTE5TTFzeEsvSFdDUzFYUGVoVkNiWjVlTStSOVpCMERpNnRs?=
 =?utf-8?B?dU9kZ1RHYUJxWE5la1F1WFhDeXFpczRjQkU3bWNoUFM3VGROU282YTNDMWhk?=
 =?utf-8?B?UEhGU0RpTFk2elJ0aktGWDlUWjNsT1hVTjJmb01qR0podGxKUnEwNFN5WFNX?=
 =?utf-8?B?L1QycjNlSm84R2M5REM3NUVBMFJHS2lDeWZUWXNRUzh6ckN2UGxKZUVnNTlJ?=
 =?utf-8?B?TlNybWJxSEVjb2pIY29XSDdWK2RCYmNMdFhxRXlQL1lxblprYVlFN0Iwd21S?=
 =?utf-8?B?d05WU1Qwc1hRaHlicm5QdFEvZGJJVWdwdmtHYkthODl0OTZ6ZFNzZmNTMmI5?=
 =?utf-8?B?SUhleUFkdkI1QTRoMExRS1Z6U2o4dy9WSlc5VlVxaGpBMk84VTBEWHU3UTgv?=
 =?utf-8?B?aVpSOEJGdVYyeFFzZDQxb24wYnQ2cHphZHpaQ3J2dDNoVS9IWFAzUnFIVm5i?=
 =?utf-8?B?RmExRnNKTkhCb21KcHFRN2N4VDdDVUVMZytiN3hGbjBjclhrQS8xV2tuZitu?=
 =?utf-8?B?eE1DNVl1RGdubUY4VG50UlcwQU5MQStraGNsOE1KMnYvdUJvbURDRVBmZm1R?=
 =?utf-8?B?UlgvaG8ybUdXTlVFVnlwbnFEeXdLWmo2cVV5dTJ6cktIVHFKbDgxSWVHSWJ3?=
 =?utf-8?B?YWxCWUF6cFY1SVdaaXNPS2dUNnNlMXZkenFhUm5FVk45cGRac1pWdzhhbHdq?=
 =?utf-8?B?eVdJL3RGdHducE1tVmZvSkFKS045S1lpaDlDckg1OVM1NWF2eU16TDdaaGht?=
 =?utf-8?B?WjhpR0wzMzRGVC80LytRQTEvc1YxeWxCTHFSOHQvbTRlNkw0ZDA2dkMza1V6?=
 =?utf-8?B?OXgrd05iZjkvNTV2NVV4WmhQbVZZN0dlcFhMWGZPd1EwUW0xT0Q0b0hZbGlw?=
 =?utf-8?B?UEh4b0Nhd3M1bXF1MzJsYk0yZzNDOEZPOVk1SGJJZUZneWh4YUJuQ0ZPeVIv?=
 =?utf-8?B?TXo4N2RWM2pzSXdOQVFDZk4rdGxCTkRzZjBwa1A1eENEVHNsZ283Ykk4QWs2?=
 =?utf-8?B?YVVqTkVmMzNWTm5UTEt1eTJZVTJSRWVWZ3k2eXRHbzFMcEdPdHNCMmI1Sy8z?=
 =?utf-8?B?ODJwV1MyN25WQWUzZ3RqWW82NG53NVA4Z0xCU0ErMVFwTytrYVkxN2xqSzJo?=
 =?utf-8?B?NlhHMy9sTk5HTGtFc2lFZ0xhOCtHdFJTSk1nUHc0TjhKd1p6a1ZsNFJsM3pH?=
 =?utf-8?B?SHErVWpuRkRIWFhmZXU5amtSTTdSbzgrYkNIWThQdC9ZMjMyeU5wNjlwODF1?=
 =?utf-8?B?U0hIVFpCSFhJdTczQlFyMGprOU5jMzE2dzh0R3MyWGJ4U3ZqaUlmc3pDOGJy?=
 =?utf-8?B?RjlvR1J3TVl1YTRNN2xWd0xOakYzZHYxMkpJNEpKUE1JWE1ZM3hhVnQyYVps?=
 =?utf-8?B?K0YxNGovUnNjeWZjS0JBNmNUT3FmdW83eWZzbk1oelovTDR3NDlyd3l1UmdL?=
 =?utf-8?B?L2liMmZnS2F0QzQrakVkM2grR1pRZGhRMmlOWFZRT0RtZEMxVkdzQ2VkalJL?=
 =?utf-8?B?RStrNnVRS1lvRTE1Z3lVc0d1Q285YWdXV1JteEZrWGdNZUladUFzM3Jnb0tG?=
 =?utf-8?B?SFRhMXRaV3hCZXN5Ym5FWVpKV2plUzR6QzRxR1JQWG5RNFZVYTdzc1ZuVTB1?=
 =?utf-8?B?eTEvc2FSRWNFZVNmSmFqcXY3a05NWVZ2RUNNZy82MzFYS1RVejZCN1VKN3My?=
 =?utf-8?B?T2M1RFl0d3lLbVpML0piVEpFWVZBYklFZXlWWS9BdEc0MjZHbUFGQXl0eXRy?=
 =?utf-8?B?WkFUOWZMYUNKQlBrQ3V5R3JIaUFTbmxUVTFZQXY4RjhuNGFPVGJjeUYrWlRh?=
 =?utf-8?B?L3pFYS9VQjhPdHptSjVSMDUvNGpqQ0dZTjdyanRxOVRyZXZCV3hYVXBYZklw?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccd2f01-2161-4d18-7cca-08db4d0f20c9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB2734.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 02:19:17.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utxoNcRB0EUAjy4tT+ykElaYxuR58t/3nNoR3KtkQlVkFuDhwk9iv0XBN9aWf3RcM8nhpOIYsmBLmqB405TevlI4Ez8l7SRZkutGW00qKXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,
      Thanks for your advice.

On 2023/4/27 17:28, Christian Hewitt wrote:
> [你通常不会收到来自 christianshewitt@gmail.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> 
> [ EXTERNAL EMAIL ]
> 
>> On 27 Apr 2023, at 9:58 am, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>>
>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>> applications.
>>
>> Add basic support for the C3 based Amlogic AW409 board, which describes
>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>> booting up into the serial console.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> ---
>> V1 -> V2: Remove new arch, and use ARCH_MESON;
>>          Modify node name, and delete superfluous blank lines.
>> ---
>> arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>> .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 29 +++++++
>> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>> 3 files changed, 116 insertions(+)
>> create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>> create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index cd1c5b04890a..bcec872c2444 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>> dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>> dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>> dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409-256m.dtb
> 
> ^ please keep the list alpha-sorted, and 256m is described in the dts
> so there is no need to include it in the board filename. I would also
> expect meson-c3* to align with existing filenames, but I’ll let others
> comment on naming rules.
> 
Keep alpha-sorted will do in next version, the characters "256m" will 
delete also. The word meson will be removed in the future before 
discuss, so use the word amlogic.
> Christian
> 
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>> new file mode 100644
>> index 000000000000..edce8850b338
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>> @@ -0,0 +1,29 @@
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
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +
>> +     aliases {
>> +             serial0 = &uart_b;
>> +     };
>> +
>> +     memory@0 {
>> +             device_type = "memory";
>> +             reg = <0x0 0x0 0x0 0x10000000>;
>> +     };
>> +};
>> +
>> +&uart_b {
>> +     status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> new file mode 100644
>> index 000000000000..93b335aef605
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> @@ -0,0 +1,86 @@
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
>> +             apb4: bus@fe000000 {
>> +                     compatible = "simple-bus";
>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> +
>> +                     uart_b: serial@7a000 {
>> +                             compatible = "amlogic,meson-g12a-uart";
>> +                             reg = <0x0 0x7a000 0x0 0x18>;
>> +                             interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
>> +                             status = "disabled";
>> +                             clocks = <&xtal>, <&xtal>, <&xtal>;
>> +                             clock-names = "xtal", "pclk", "baud";
>> +                     };
>> +
>> +             };
>> +     };
>> +};
>>
>> base-commit: ae68fb187b59bc8645974320808ab2d7c41b1833
>> --
>> 2.37.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
