Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD287497A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGFIpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFIo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:44:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E8B19BE;
        Thu,  6 Jul 2023 01:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKuEzYkUvE0yJroDWvI85LK9aad86UI6LzFujmBN3AtfEtuhcB0C1iGrKDQM6mI/k4Bkgq+UUEsFWa8dlGZEhdxyVOglMSpAouxW9HXB4IwgKgITz+SVknchvfAd0C/+sdQoUd4+6D9va4Y50F8CFjUyvkWDXSuS3jxbYt7+KpCqCsYM79cr/XzXOwmDnYRbrfxR1erWVZy4obH5YOyBoIJ4fVxewl15CHFWsfnITXmfHfHyhZHoQIscf+YnIUyX3gVCsoiaglgahGwwiw4WQUtTPQoWYekebywHQ2KXupU1aLwy8C5Sobt+NdUW/ss3NVrAcaM71yjxtU2iksofkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY484SkOMkgpFQZ5yf64+WuWK7rmFeN8PwPbjghjyfY=;
 b=Sni7kY2wSOgxjWsnuXCaT+rHE8Yx5IYV3mnetPuVb50GI3sk8/3ldVwfjKet4VEn5zmIFK9xADW2KtDh8NnJqYbohQ6nqynjocNdGzQ3OqC2fYEP+pOvxc8sdM+6jjLQ4wSmwdEtEUjfoDmezx+g34pT7SOcN7CoytVcIAwI1IFYkhmj2eDF15pJlV7OenLNSqxUGwnNZQii6LDXy/OQD0Cw3rPoXQit4Nho7ISdyWpm2su2LH1ry0ksDb7NSD8/6dI6OdmZyc4UtDqkbQYJ1Z/4Oz0oQmS4vh4QMZg/rdvjgzl+8wDcu8EV+6HCEUoJSnIfwF86twekRsDTnkOznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY484SkOMkgpFQZ5yf64+WuWK7rmFeN8PwPbjghjyfY=;
 b=Fu9Ce3xsKFkYiTPTkPSWXvi7dKRHYPZWxdmE/7wx/+AdeJVVcE6hsllwleHAcjxM+KNGFWbCEfIBGZ+/hGCQWIcx6iAFJdT8H5mpcsNJ6fGGAL/HziBqWDnTq21ikEJoOjDW6alu8COD93lsN9MwdGocA23hvah4QoKOidg0MpqrWk6PCBNLBkBOjl+8KGMN1LJWwFld8XhrQ5Yo5PdDqKWCyDLhiXhi7Q5r0evn/1OTd7NVAAANXu70KV28rOZ0k8+d0oDAAVUfEcpra3keg7O2KXHqqvce2nh0dlj8nF57JspCdOvPi9Qsj6ZM7/1QK8VicgWbK9tK16ybX4wY0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR0302MB5362.apcprd03.prod.outlook.com (2603:1096:820:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:44:54 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:44:53 +0000
Message-ID: <8c1e84ab-e5e0-a3c8-517f-ced3dc516d3e@amlogic.com>
Date:   Thu, 6 Jul 2023 16:44:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: add board AN400
To:     neil.armstrong@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230704031636.3215838-1-xianwei.zhao@amlogic.com>
 <20230704031636.3215838-3-xianwei.zhao@amlogic.com>
 <112727a2-29c5-1402-deb7-f35119b4338e@linaro.org>
Content-Language: en-US
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <112727a2-29c5-1402-deb7-f35119b4338e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR0302MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df0d48a-8454-43c2-df13-08db7dfd44a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ/uT89+mFvX2kyLz8h59IbGbKFNnOvnbgyEsOYqWmnh/sufHaTp7UoIKUqbwuXIlCTMnG4iWERz931GjIANjE7W1FJWRilsRPhV3dclvLKqdDXHKG1Xf4KxZX4Kx376tdBdyOgh23ge2Cv0oGFpXkybnc9Gz5v6kXw/ZBGBAymp07H4VsbOB168JCIGAcHIx+YowM7CX6ZIZnPI7yQZ3OKIrre/f/9s9eRv1giMv2wQ63x0Yh5O978bfmy7QPG1tFtKhMoWONQuKWjtnUn607GnzLJfFtwttR0Jnj9jyaN5dHrpjZJEr9FYhVDZe4JOBOQjBPw8o+Ueuoufe5BfnoRQ0bM08w2WcBVwt2FfMcx3X1Yr1+n+C+BIInjXfngB4aoe4LZuwpHNPxXCrA/rI7vktQQxo3qmW9FDQGbX1KjcGWLXOzk8tv5inrI2jaarzGNEdtJCiJdAhsc2QKNF9vtdEt7sOtIN6QpNh2emd+TPYeJ7ilbWE+wILAa0r90504z+F1KfC9ngEwkfFEu89UOApQL6nBIHjzi754Z5Ba0DkoXlrvnOVVb98Qezam7n4bbGCMD/vIP7QX6sq0s6JkeYUvT6gyC9Fbhfx3leqkFLu3Ts3zp6TmUCiWzAdHQ1x+huZRtdQwQYHbQKaars4X6uvfqqaB5nDkYR5T2GaMEcQMulJ7rZf36aQEIwcZAEzw9OZVYChn9zfcHHB++t5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39850400004)(136003)(451199021)(66476007)(4326008)(66556008)(2616005)(31696002)(86362001)(186003)(53546011)(6506007)(26005)(83380400001)(38100700002)(66946007)(6666004)(6512007)(478600001)(6486002)(54906003)(41300700001)(36756003)(8936002)(44832011)(8676002)(31686004)(7416002)(5660300002)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVZcjhLSUFPaC8zYWFvNU9jdzNFNWMvbTFSYytucENxdUUwQldkb1ZJbUlR?=
 =?utf-8?B?U0x4OGRJY1ZtR0VOMTM1RmhMa2JoUXZoU3M3Y1lXOENHS0RqMUJYNVNzK0Z2?=
 =?utf-8?B?NmsxMm4zTHVzVDJPeDc4b1FuOUZid3VEalhMY1J1bW0zK0Njb1NoNFFZZC9m?=
 =?utf-8?B?aHdwbmpmS3RGQ3dsNzhocHBpZCtrZThnTkVsQnNmcVV2VmpVbXF0RER5c21y?=
 =?utf-8?B?V2dGM1FUQWY3RUc4VVBxNktzajJVRk5idWtlMExSNzBGQzQweEpoOXhicEt2?=
 =?utf-8?B?MVQwKzBHYXRSZy90OWtUWWdKbnBKc2czbGlRdFp1YUl0cEluTkpJL1NYUHpO?=
 =?utf-8?B?RnpUN3gycVUwQVR2bERTTkNtSXdDaWF6NTk3empkRWwwVGxwN1R4RHRYQkRM?=
 =?utf-8?B?dVFodG52aHRsNElNZ0NHZ0dCTC94T2RkSkYrSitCYW5TODU3bnlKZlB4Szlv?=
 =?utf-8?B?RHBJWk83dTRYMjM5UXRkOVVyVXp2VCs0UnJmV3IycnZ5bXRlWEs4OVBNd0xT?=
 =?utf-8?B?cnpZRm5oNDB0QWFCaEo1WnRqZ3RtZ3poN0d6VWxnVU5PTVFzbmd0UFRrSzVI?=
 =?utf-8?B?L0diVUhoYTR4VlZueklZWmlTUGRyR2hsT0s0SloyRlZCQTF0VUhVRVZFTmJt?=
 =?utf-8?B?YW5iUXprYkIyTEpCM3duZlVDR0JkcHpiamhGd0N4dnRkWWFib3U2aVRPUE1a?=
 =?utf-8?B?U3NCcS9MREUxdDBMUnh5TTVlejNLazhtVmRSNzdBdUw3UDJiVVVLSlg3dzIx?=
 =?utf-8?B?UXJaOHdzT0dVUTlrcVh0Vll6cTM0aGN1eDZ2d08veU5aZW1NaHc2WjhNQ0Vi?=
 =?utf-8?B?NnFwOVNxL1Y2WldReGJMbDZjeklUTHVsUlZFNStKUys2SjQ1MXozSWoxaS8r?=
 =?utf-8?B?VWx1aXdrVlh0SStVYjRGUVFHTjdnRURBUnpmSmFjUWowKzZvYnBnL0FzaDI5?=
 =?utf-8?B?VkJZZi84SDJsNVNwRVZCUGVWMHU5NDgxSUVTSnpTQjVHUnZGUW9BMVUrVTk4?=
 =?utf-8?B?ZVFIbC9wYnpTbjdGTDE3ayt1SHlFemF2eVRiL0IyWUt1L1VGeDdQeDU1LzJx?=
 =?utf-8?B?b2pkOUZOWnJXRnNPNzFWTjc1V1QrM3ZOSURlMHJwek5qdlZuY0xyY0tyb2Nk?=
 =?utf-8?B?UEF2SDNyby9nOFlHWlEvYW0xNG8rVG9FdVZyWTY4cCtXLzU5WVlJSHY5b2ZU?=
 =?utf-8?B?ZWdid1VYSTNIcDNRUjFvR0txN1ZGQlUyR1hNcTNGYTBMdko2SEVOR1F4cUx1?=
 =?utf-8?B?STltbVBlYXJ1NGZPUkJmdkowbDlQQThJNnRWNllFOVhraXdSbUZTZjE0K2I2?=
 =?utf-8?B?UTRBcFNScE5ORHhXZDFRSkdxbk1PQTVyN0IwallpaDNEK2hZNUkzVXFBNldk?=
 =?utf-8?B?ODBzUlZEY050VEZQNE9uTTVNK0tyWnU5WGZ4Rmx6Z0F4MmMyWENtTHg3bmt0?=
 =?utf-8?B?UE5iNFBzRVFhVVIxclZjNDBWY01NYkR2MnRDay94VldUV3JJRllSUm1Xenll?=
 =?utf-8?B?czFyTlBFOXJjT0d2TEQ1TVh2ak1ZUmRwczJOaFhaUStBd1MvUkUycVJXUjFJ?=
 =?utf-8?B?UVl5M2oyYTRENFZHQ0RxNFpLa0VRVGRoQktnUmFJYUxzdFc5MTczTHJsNlh3?=
 =?utf-8?B?UHh5Q1AxcUhmZ29NaWI0NllnTlRQaHNPY0tGbndjMDN6OW5oYXkrUWhrMHpV?=
 =?utf-8?B?bDZhd1l2UDMyTzlJelA3cFBVcWVnNi9VSjQyZkw5bW1jVkdmbVYzby92a1RI?=
 =?utf-8?B?MFpRaTl4MjdraUdtR3Jhb2IzWFUyVDZVR2lPa3Qyai80VW9iTGJldU5MVllG?=
 =?utf-8?B?ek1nald5dkZyZGlGMjRaOG9OMm9xOWVObE00VGZ1SFZlc0FPK1FLandWcjBn?=
 =?utf-8?B?cGFRUlR1NzU4K2hBaWhoOWQwTXBSZlkzYnYyOE9vSXdkNm9EQ1NkUzlmV25s?=
 =?utf-8?B?YW1VSWpncElhTDRHMmZlUnBXOWxrMGYxSktzN1ZqWERoTHBJdXpybFRsWUxz?=
 =?utf-8?B?WEFGaXIwbEsxQXBEZzdheW9zRDlUSEhTZ3U3SHZ6Z05INjlUVm5vSW1YTm9j?=
 =?utf-8?B?WmFiSVhBWTJnZTVhU2h0TEFWblRHSHViVVptQldaWEFlcThlTzRaS1ErZlFZ?=
 =?utf-8?B?QUJaQnY5dUhBd2dLUmRNY01WT3dlTURvVVRmWEUxM015ZkxpWXZxQ09ma0tY?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df0d48a-8454-43c2-df13-08db7dfd44a1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:44:53.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ppt/cWJwkz0Ng5qdX70EFRc1xq82lAyKI2gGTUyHq8bLJhQT5npxVGyfxI94WOifeuoqiTIjcLIoLGrp0zx4bLqHy672tdDDtFI2ffwy38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5362
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
      Thanks.

On 2023/7/4 16:09, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 04/07/2023 05:16, Xianwei Zhao wrote:
>> Add devicetree support for Amlogic AN400  board based T7 SoC.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>   .../dts/amlogic/amlogic-t7-a311d2-an400.dts   | 39 +++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile 
>> b/arch/arm64/boot/dts/amlogic/Makefile
>> index 91fa425116ea..8b6f57a94863 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts 
>> b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
>> new file mode 100644
>> index 000000000000..d755e1ee108a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-t7.dtsi"
>> +
>> +/ {
>> +     model = "Amlogic A311D2 AN400 Development Board";
>> +     compatible = "amlogic,an400", "amlogic,a311d2", "amlogic,t7";
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +
>> +     aliases {
>> +             serial0 = &uart_a;
>> +     };
>> +
>> +     memory@0 {
>> +             device_type = "memory";
>> +             linux,usable-memory = <0x00000000 0x00000000 0x00000000 
>> 0xE0000000
>> +                                     0x00000001 0x00000000 0x00000000 
>> 0x20000000>;
> 
> Please use "reg =" instead of linux,usable-memory, which is not a 
> documented property
> 
> Please use `make CHECK_DTBS=yes amlogic/amlogic-t7-a311d2-an400.dtb` 
> before posting DT patches,
> and make sure there's no errors except already in-review bindings like 
> here the UART compatible.
> 
> The result here is:
> arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: /: memory@0: 
> 'anyOf' conditional failed, one must be fixed:
>          'reg' is a required property
>          'ranges' is a required property
>          From schema: 
> /usr/local/lib/python3.10/dist-packages/dtschema/schemas/root-node.yaml
> arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: /: memory@0: 
> 'linux,usable-memory' does not match any of the regexes: 'pinctrl-[0-9]+'
>          From schema: 
> /usr/local/lib/python3.10/dist-packages/dtschema/schemas/memory.yaml
> arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: /: memory@0: 
> 'reg' is a required property
>          From schema: 
> /usr/local/lib/python3.10/dist-packages/dtschema/schemas/memory.yaml
> 
> Please fix this one.
>
Will do
> arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: serial@78000: 
> compatible: 'oneOf' conditional failed, one must be fixed:
>          ['amlogic,t7-uart', 'amlogic,meson-s4-uart'] is too short
>          ['amlogic,t7-uart', 'amlogic,meson-s4-uart'] is too long
>          'amlogic,t7-uart' is not one of ['amlogic,meson6-uart', 
> 'amlogic,meson8-uart', 'amlogic,meson8b-uart', 'amlogic,meson-gx-uart', 
> 'amlogic,meson-s4-uart']
>          'amlogic,meson-g12a-uart' was expected
>          'amlogic,meson-ao-uart' was expected
>          'amlogic,meson-gx-uart' was expected
>          From schema: 
> Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: serial@78000: 
> Unevaluated properties are not allowed ('compatible' was unexpected)
>          From schema: 
> Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dtb: 
> /soc/bus@fe000000/serial@78000: failed to match any schema with 
> compatible: ['amlogic,t7-uart', 'amlogic,meson-s4-uart']
> 
> This one is OK, the UART bindings is reviewed and should be picked up 
> for v6.6
> 
> Neil
> 
>> +     };
>> +
>> +     xtal: xtal-clk {
>> +             compatible = "fixed-clock";
>> +             clock-frequency = <24000000>;
>> +             clock-output-names = "xtal";
>> +             #clock-cells = <0>;
>> +     };
>> +};
>> +
>> +&uart_a {
>> +     clocks = <&xtal>, <&xtal>, <&xtal>;
>> +     clock-names = "xtal", "pclk", "baud";
>> +     status = "okay";
>> +};
> 
