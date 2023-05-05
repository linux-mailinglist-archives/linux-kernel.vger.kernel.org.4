Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99C6F7FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjEEJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjEEJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:12:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ADC5FDF;
        Fri,  5 May 2023 02:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmHpaOd5z5HJNrmTfP+mLJzp3eGsDgdz7upf6gR/EZGRGtP5aiPGpWoXIPbcAk+0YEkWvkoU2sECaW/JZrlDRUhmq/gjbd8hy+gnp+SLuV8SUHbQ4WRrOE+k7v1iiDldJv1CmWT/wvo219wRccc0omb6DolBwcTy8SHLs+fkbx77Y384Yaow5ZMR7200mDluun60H5DezUa+jSuE4IlvbVpOjq9VYwgK3C9BtokxuZ5SrH9bLHg68YH2j0YbdypiCjqDXOO086qTA0uoj7CkzLaOOFBw7b1ZrNhv6inxGlqcc4fRFqFU6ptCjdx27+cE/F98v2eNOSv5ldic1EU/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQLz2FeLekfyJ9KI2uhEn3jn0wOBP0TwalQKvwcugqE=;
 b=C93xbUKQrjIMVtKzn9Vuldnxq37od+4d20Jc8v4hSBykzfeWGqqPlThF1yGvbo4s5z4YQLYNRl3+JGyykmaQTNgXnP+CooH+IQoY9Y8vlDKwAMGTy7SpdVwAy7HoPr7f1BahR5hijWhj2k3WNL8mhbiytnWY0otOW9WqoMIEXdwxiRUbRMxDjqKnKmjm2AkWlKcn+s5A00+sqv94kyOsDPg2bNhrPTsJcVVYxEQiqDmlo0RhwOXN0TTPVADzrwqHLcN3jfoT+99KCjb5BA18wKj/keMqdgMCJo39NyVeC/e1uZC4AKaiPE7+6XmDgH/npPk2kZjcPXalQFODC+2Mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQLz2FeLekfyJ9KI2uhEn3jn0wOBP0TwalQKvwcugqE=;
 b=gj9VEP1ih1eF5xlG8RieeSxBX66k+4dbOr8PjhvtOzHRDuT2pgBy9TgTfuKtj+VCSTD2Jt/y1KluLWi3DorecBhr8G32dlsiqh+CtVIq3yw5qQ/EVWChnHc7e5oKY0MXpH8hXsjTvYEiUMGTZ9aV+Z0OSyRrgbQJp3hNcIYtHNyTdyUgAKt6IUiv7sncyv8SS9ekUSCPSeBo8ynHazLbyGbBwY1adfQShu0SHUhIGE998lgR/rsM9Is4ReIRG8ZO7o06QCUeFdxtqQUnjoCta0s6q/rNUg6a7IXtknBZrXdipSjjjWKDgEIJ0P99/LLTpldRODe35kjl/eeekGrPLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com (2603:1096:3:21::22) by
 TYZPR03MB5200.apcprd03.prod.outlook.com (2603:1096:400:37::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.26; Fri, 5 May 2023 09:11:44 +0000
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4]) by SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 09:11:43 +0000
Message-ID: <41bb29b4-979b-3851-a7ea-5399f1edfe95@amlogic.com>
Date:   Fri, 5 May 2023 17:11:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     neil.armstrong@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230505071254.2571429-1-xianwei.zhao@amlogic.com>
 <ca4c87f4-c496-7fa6-2945-45e4fd9c2020@linaro.org>
From:   "xianwei.zhao" <xianwei.zhao@amlogic.com>
In-Reply-To: <ca4c87f4-c496-7fa6-2945-45e4fd9c2020@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To SG2PR03MB2734.apcprd03.prod.outlook.com (2603:1096:3:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB2734:EE_|TYZPR03MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 7126d30f-2c16-4f44-ec29-08db4d48bdf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joPYvZgl59sSVtCuCDaEWu0TWMMA2rlMzwuNFAfulfta46U0zz5i4uOheZyGTdJlTqWHJ5rmDCwbX+CPfSZoqXbvTij6MkMPT54o1roCmNSWzPpUDemh/AysQoB5r9f9wT+DLxM17I+WA80cs+SgumwRJrpkfONl5LmjYXD99BriIl451Ye7pBr6Gei1cW2fFTbRNHWDYvrV2Kw1zHHM1zz5wqs4bpyr9jWX5GgeZ2KfKQophDqgfQQdOCdIdxF0VoWbU7ys5pzeoEWU+oEyk7pUgZXfO03JYhvLpDVBbJyRcdfU7c4dql4zj/d9rxt8s+2Prs0ocq529kkZtayGMFlZPsJocYD7Zebd+yb5LyO5l92lZqAkcS3eTL/Zv/v5YwkTB+tEPJrQ681SNiGiQwGAqoHZcQmb68T9oVZNuZHJLfT3YkqLSotc1miyn0m1DUslnEyd8UQPPuChl13GkPCq9hbRYlJTIynwopM4OnE5pL0FcOp9+fMXJTZbmsgbFW46+E+jbgsXCY9uzfyfmFTk9w4syDJhcQRRk4xtVq+WzsmtCWxmJl13cx/DGlEPPuQM72Elhth3ithdXPBXSjB2vvGbrfnpGSaq908eILjCci5p1VkOabSAy2IYZzgaP+YlYxK4vWttL6vF+7pIvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB2734.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39850400004)(451199021)(7416002)(478600001)(966005)(38100700002)(5660300002)(8676002)(8936002)(26005)(6666004)(31696002)(86362001)(66556008)(66946007)(66476007)(36756003)(4326008)(83380400001)(6486002)(6506007)(316002)(53546011)(186003)(2906002)(41300700001)(6512007)(2616005)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVRIUFJTMUpxVk80UE82ZTdjc2Q3cHVXTnBlcGpEYnZtU1RGL3JSSmdHM21W?=
 =?utf-8?B?Z0ZBKzcxSExvZno3V1ROSjExZnlqa3B6Mkw2bHowOS8wb1VRbEREK2tqTXMx?=
 =?utf-8?B?bGd4Q2VVRGo4R2ltSW1zaVFNWTRscjVJUnhMWXh6bjFNTHBSL3BseStKSDdy?=
 =?utf-8?B?RmVZYkNVdEdLdW9zSld2UWlRRFZiWTJVQ0x3MFkrMXU2SVFYNVhPMDZNSjda?=
 =?utf-8?B?Qks1QnN0Z3Z4cENvU1ZmN1NpTC84c08rUWc3d0lvR1hXUitWcmY0Q2haU0Z2?=
 =?utf-8?B?S0tQZVFWZlM1S1JXemVTSFAwMFFqK2FJS05QT3lMRmFzR29Uc2JTRzNsUmxF?=
 =?utf-8?B?S2h4MTdGVm15NUFCUnk0cXNGTmxYcDVIQmJTSjZPRW1aeU5nSUpaMkQrT0Rj?=
 =?utf-8?B?MnkxVEhYRDB4aUlrUitPZ2J0TEpuMFlOUUk0MU00b2JSdzlrR2pNVjgxTXNP?=
 =?utf-8?B?NnFyRS8ycUdWN3BDeFNCdFBSMEFsL08zT3gyYjFmTlhTbXpaZ29CK0lqaFFT?=
 =?utf-8?B?d1ZHZlFDaHMvdmJXRzhrK0xyV3dnZEFaN1dzeTZUbFlrMHljcEtIeHRKTHJn?=
 =?utf-8?B?eDdsbzhMMDA2dHJ6RzJNSUNnTWpySDdJcWw3VHNLb21BNlpidTAxT21qUVRP?=
 =?utf-8?B?aTJ1ZzNRWGVwMHJpRUdsSFF3cldIUEZyRDB2a25ldVpZenlSQ3FrVldHZEda?=
 =?utf-8?B?TVVSRGE1WjdYbWx1SDdBZXFzNlVSakZReTF1cndocjdTUFFESnhPZy83NFFX?=
 =?utf-8?B?aUtrYmtvRVNsV054Wlg2UDdEcmpZdEZ5Rlgwb2diYmdWK3VPZW5zUk5tSnNn?=
 =?utf-8?B?Tmc1RWo3YnhVc2FiNjFaQ1FibmJNYmI1dndMc3VRbE50bDF5WERxWUdCRjhr?=
 =?utf-8?B?ak5hS2JoMGV3dmVjUnREZy9KLzlQblo4NUhnQW5RYU5yVjZEYytpb3NDY01Z?=
 =?utf-8?B?Y3BMTVdHalhsSGF3MXdIU1JPQk45Wnk5RWoycHRWYmVRRll2MkFQL3ZUeTZ6?=
 =?utf-8?B?S04xRGdOLzh3a2VjUEJzM1FLa1d6bUVnT1N0V0ppZGQrYzJrOVV1ZU5WcGR0?=
 =?utf-8?B?ZUlpZlBRMzdWNDRPd0c2TllKcXlmQVliTWVSZm53b0ZRU041UlNuNE1CaTZi?=
 =?utf-8?B?dzEwbGtkQkp3ckF0MVRlT0Y3Z2lNYjZtR1A1ckpCRFltNHVocWhSN0xiMjJ6?=
 =?utf-8?B?RWN1MWpjN0hFU1lkaml1Y05ZQTFVdXcyN1NSWjZuL1VLNTYrSmE0WnpGTWFh?=
 =?utf-8?B?Q1FxWERDVThtaXovOGFFc2NaaUZYcE1iajFuSFdnU1NpcmZ1MktGVTZ2QTVv?=
 =?utf-8?B?TE9FQkkrYmViQTZ6QlB4RERqZkM4SjhjSjJWWmF4M1luN0Nmc1A4UVNUVkJK?=
 =?utf-8?B?d3ZKYy92dlZ1dU4zbzA0elBMajdNZUR4R2xTaDlwdUl4dUg2YmlwSEZMbm5u?=
 =?utf-8?B?ai9zZVJEVWxrZTlLVVBZaUkyZnhEeEd5ZlU3UE5pcHZ6UzVQOWhwVkJOWjRp?=
 =?utf-8?B?VVVJUTlxQ0dnR2lPdk1ldFRvWDRXYkpIRWxDQk12bDBYNHYvUWJBWGovdXZF?=
 =?utf-8?B?OTBuTGxtSzJ6RjZMZGZ5YXVYTkJEc0Qyd1ZjUGVteklxU2l1dytZcG9OeGlm?=
 =?utf-8?B?WVdtbTZNeDRlNkNqOFgxdXdoM05FcFZRSzVUTmVXMkkwL05qMnBTSDJOTDNR?=
 =?utf-8?B?cjBGdnp5Y0tDb2NzN1NSUVY5aTRFQzhJaHZLV0w3Sk9IMThIeTUzb0hZdlFN?=
 =?utf-8?B?Z1d2RFNDS1dWdm5reGJnQk1zVWRMR0ZOdldaZWhZLyt4Z0RGb2YzaUVpWnlS?=
 =?utf-8?B?K2g3SWZGYllyaTZNM0I5OEF3aU1sMCs1UDZJR0s5bUJZd2VqOFllSDRVbTB6?=
 =?utf-8?B?UGgxbml1cGVqenJMek5xc1MrR3pRMkNkQmRPYkI2b1RhSklBbTg4d2t3b2Ns?=
 =?utf-8?B?b3NEYnE1YUt6Y2Nwb3ZuUUZ2QUxmN21Vb3JKaENWQ1hQSWVkWk94Um15QUls?=
 =?utf-8?B?N0g3MnZQKysvZW5XbnN3VFhUQUhWZnpFRUNBK2gxZ01GN1FTa2kyTytPMjhK?=
 =?utf-8?B?SVdPQllvU0ZySHBSK2FtQXdFWEZQSmZLaUk4RVU2QnJiKyt0T2RBYWhRSGJ4?=
 =?utf-8?B?TjBlUURzYTJDb1YwUDMvZHp5Q3hKSDJvai9Od00rbG1LOHI5YzJnN3VGOG9T?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7126d30f-2c16-4f44-ec29-08db4d48bdf0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB2734.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:11:42.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ergoPd0qpTyBImLK6hQiMrwcyrwukAfMsSU/B6kFjC2zju/jHHIkqKku7yeksnH2h2osiwtPfVC9F3EAgQ3OjAYqVr8PcWSd+INmN4RZv/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5200
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 17:05, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> On 05/05/2023 09:12, Xianwei Zhao wrote:
>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>> applications.
>>
>> Add basic support for the C3 based Amlogic AW409 board, which describes
>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>> booting up into the serial console.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> Link: 
>> https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com
>> Link: 
>> https://lore.kernel.org/all/20230307222651.2106615-2-martin.blumenstingl@googlemail.com
> 
> What are those links ? If they are dependencies, please add them under 
> the --- before the changelog.
>
Will do, thanks.
> Thanks,
> Neil
> 
>> ---
>> v2 -> V3: Remove '256m' from filename;
>>            Keep alphabetical order of Makefile.
>> V1 -> V2: Remove new arch, and use ARCH_MESON;
>>            Modify node name, and delete superfluous blank line.
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>   .../dts/amlogic/amlogic-c3-c302x-aw409.dts    | 29 +++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>>   3 files changed, 116 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile 
>> b/arch/arm64/boot/dts/amlogic/Makefile
>> index cd1c5b04890a..6f61798a109f 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts 
>> b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
>> new file mode 100644
>> index 000000000000..edce8850b338
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
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
>> +     model = "Amlogic C302 aw409 Development Board";
>> +     compatible = "amlogic,aw409", "amlogic,c3";
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +
>> +     aliases {
>> +             serial0 = &uart_b;
>> +     };
>> +
>> +     memory@0 {
>> +             device_type = "memory";
>> +             reg = <0x0 0x0 0x0 0x10000000>;
>> +     };
>> +};
>> +
>> +&uart_b {
>> +     status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi 
>> b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
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
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu0: cpu@0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a35";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu1: cpu@1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a35";
>> +                     reg = <0x0 0x1>;
>> +                     enable-method = "psci";
>> +             };
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>;
>> +     };
>> +
>> +     psci {
>> +             compatible = "arm,psci-1.0";
>> +             method = "smc";
>> +     };
>> +
>> +     xtal: xtal-clk {
>> +             compatible = "fixed-clock";
>> +             clock-frequency = <24000000>;
>> +             clock-output-names = "xtal";
>> +             #clock-cells = <0>;
>> +     };
>> +
>> +     soc {
>> +             compatible = "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             gic: interrupt-controller@fff01000 {
>> +                     compatible = "arm,gic-400";
>> +                     #interrupt-cells = <3>;
>> +                     #address-cells = <0>;
>> +                     interrupt-controller;
>> +                     reg = <0x0 0xfff01000 0 0x1000>,
>> +                           <0x0 0xfff02000 0 0x2000>,
>> +                           <0x0 0xfff04000 0 0x2000>,
>> +                           <0x0 0xfff06000 0 0x2000>;
>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) 
>> | IRQ_TYPE_LEVEL_HIGH)>;
>> +             };
>> +
>> +             apb4: bus@fe000000 {
>> +                     compatible = "simple-bus";
>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> +
>> +                     uart_b: serial@7a000 {
>> +                             compatible = "amlogic,meson-g12a-uart";
>> +                             reg = <0x0 0x7a000 0x0 0x18>;
>> +                             interrupts = <GIC_SPI 169 
>> IRQ_TYPE_EDGE_RISING>;
>> +                             status = "disabled";
>> +                             clocks = <&xtal>, <&xtal>, <&xtal>;
>> +                             clock-names = "xtal", "pclk", "baud";
>> +                     };
>> +
>> +             };
>> +     };
>> +};
>>
>> base-commit: ae68fb187b59bc8645974320808ab2d7c41b1833
> 
