Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6656F7B25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjEEChz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjEEChx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:37:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F712499;
        Thu,  4 May 2023 19:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co7RHowkl2y5J7IkOXYhCLFDRxE+DKt3oJg0MtPQ3w4889nMzkpSz7Q37BlFgiuQ/lKaDuzFNlD3aL1zZzsoHAPYS8JGezcAE1ZvaEvVekBVp0TQYYtJyujHWP+2qZI3uZWiKV1b7EzxGSe99p7s/lTywJBB82OLR1NPEyE5FxzEjmfxo401ywtJl3y2u/z3QeoHQ6F+upui8vHkrIaDV1jE5Cxp6jeuAEz9EWpcKl7zEQ29FKPJTiWmzIpY1RXwJCXlGdwzwM9/xNuwPR7v9K3cY0SYKG0UBqLwy2Tr0H0MwiU+L0zyfoumLqvp73ryU1EfrjVHkrmdKxX3RzfoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHF7BSXd6z4hLofN1zF1+oh3ep1qjRjrtp0hDxf4DNE=;
 b=h5f9M/3TzBzxonoh+5bDd2SLEXrAAyQgruyL0j7li/5anvdz5Uh+r6Q/Jjkfnw9qNd1G1ab7YswyidgVOo3aKEUGVByXjJ1VuUEQarL55OIaxK0C1JoA4A0wBUY/1hezZ0MXmJ+OO0zZkAyK3xu8y3OMHvUu3PXJ/J8ACxYqsTc6cySknCW5nNfcMxvRp7VSWmsWRGjOhYiQTRlECunsh/s1T5Wgi89W00DildcjhI4v23A+2wEdCpYxjwaJsuG8ox4TowB67K2Qjqz7kZ2v4KUbaUZ9OHZ/lBBpO6y4o1w463CTtpxScu1yiXfLqnstzQS5R910iGNRb7MODj7luQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHF7BSXd6z4hLofN1zF1+oh3ep1qjRjrtp0hDxf4DNE=;
 b=nZdpd4RyS6TrnfH8V2X/8J8r10RQ8CGQH8bH+g61dvEfp5kdU3LLnGo6IGqGTRr+m5U/8F9wF2E0yncNGoP3uPaICRHfAXHslw4snZKsZXTpf4v4Bbcw2C2/MZLZ0UtOyKWATAW2Jhoj/TzkfnaQfuk+UqBMIeohsxmyYUjR8IwUN+WisNY1LyLNrd/Yo5U6JwNfklvzhvd4egodAiWkreQcVEKDE5A5x5y82b+q3tpHctCUWfe6TcHsIFDzu8DAmXLPgNRAzOgk3X5ar1WBVVG7Qe9N1hj6vaeITbesOeol9JiQ7Yn82jSmbmP3PxoECDsoOT+ycAztrT5OmvA4Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com (2603:1096:3:21::22) by
 PUZPR03MB6104.apcprd03.prod.outlook.com (2603:1096:301:bb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 02:37:46 +0000
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4]) by SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 02:37:46 +0000
Message-ID: <e3083eab-ba85-3e9b-b3f2-f50816163f9f@amlogic.com>
Date:   Fri, 5 May 2023 10:37:41 +0800
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
From:   "xianwei.zhao" <xianwei.zhao@amlogic.com>
In-Reply-To: <36e7a445-7d19-911a-1a94-ffc30172e1a3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To SG2PR03MB2734.apcprd03.prod.outlook.com
 (2603:1096:3:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB2734:EE_|PUZPR03MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2990ac-b739-4271-5425-08db4d11b54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O80LkiKzO6t+d3WYu1BkE8eTBgtS8SFyoquYAPKZ1Knh2/zjKcrFWO38jPnMH/Q1rwA0nMTq0isprTyOyKudvZ2UzOinsW7BEFgryxzgrSZTP9NrwliFvj+e5Q3HMdaOEFnbn+Oq2K9QmGTA0ik+hkCHGO12SF/NdpLBkkJNTSYq6Wmvu4WBiMinXO7orU3P32Yy16CM0QwzaO7lc9+BvimudPDBvARlr+f0oXujUBbrFq6Qt8yjc99PW8LYxX3ZQcVwXkSKTy+XA7w3KtyJvuEcm6XjtI2pd+7LN7KUUp05g+8mnjWfMr5gsXB4lhg1TdczbJEUoO123kpgI8mN9R+8R0pqTrpeBVkq5oiz17HD/dN9dZqm0tM5cPlnH7tUQgnJg8S1mUyuE0pSH8XaoVCidAGKoEzW0qU/hOfB7wKCuyeSXhZ0amCNmXoa0jsxVTeCylP1UDeF1MAyT+Ohj9lYule7X8frM0sdV2lhMGKk2FwpS/eV9C7s+jxX8Jvp13ldywqLiu+zyRjg1ocyYq9rUy+YLa1JW2E3ZG2T2wKgZF4Nf92Fcung5b5eab5rda4pwpMjtam590O3Mk09On/y3XeyqdsGEIwFA1Qakg7VyV+jUG1wSYICRh6Ze4q4vz6oWZaEQuQvSMAFRxpotQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB2734.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39850400004)(366004)(376002)(136003)(451199021)(31696002)(316002)(86362001)(38100700002)(31686004)(8676002)(8936002)(41300700001)(7416002)(54906003)(478600001)(5660300002)(4326008)(66946007)(66476007)(66556008)(2906002)(6666004)(36756003)(966005)(6486002)(83380400001)(53546011)(26005)(6506007)(6512007)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpicTdVSDR5ZWtjZGZ2ZnVyNEhtUElmY2UvYXZUQWdxdmpjbGhmM083djFu?=
 =?utf-8?B?UEJTdjFUNXNDR01mbnBGT1RMRnhaeXZ0L0hhSkR1aXI2VE1TWTJoSE5Ybzk2?=
 =?utf-8?B?RDlDSXZhQ2dlMzJBNjlQNDFScS9vT1dDbStPRVo0QUkrRkozNTExeDRoeS9D?=
 =?utf-8?B?Q01FTFFMRHhOaWhJSnBIUW5ZVjBPUS9HMWFXWGhMdkR4V0VmeUFMSlhFYXVi?=
 =?utf-8?B?aVI3TEZCVWZrd2tnL2RYWG12RG5DV1EydU1GeCswM3NGREdjZ21PR1dMN1Vm?=
 =?utf-8?B?UHk5S2dTUFlCQTNZTW9CU08va3dJb2ROYnZlVUZHb3AxdWxWb3hta0RUQjI0?=
 =?utf-8?B?RzZ4OEIxbjRqdGJLbVA2bTE2bDJSa2xhVzVqUEFFVjhPaTZqODE3SjcwNU1R?=
 =?utf-8?B?akZOVVBPbFBXV2RteE92T05mdEN1SjQyZG4xR0hzZlAzR1ZrQVc1REo0ZGNP?=
 =?utf-8?B?WWgxV1ZvVGFmZHFIZnIzTGdaN3BKbjhCaHoyWlFrRUxrTzJGSnd5VStVR0ZP?=
 =?utf-8?B?VnVJT0xmbXdIU1cxV0FlZUxQdW56ZEZ4ZTdCRVFXMkpSdmdEdVd4WVp3dXFE?=
 =?utf-8?B?SDhXeTkrWnVSVVUwSHlBOTU4OWN4Y0dsa0lxWktmZjVveTZhTUJaSmF6WHpr?=
 =?utf-8?B?R0wzYk0xV0JrU05kblJmMzhZRytHcHhXNkhteVJ0QWJwNk8rNTVORk9SaDla?=
 =?utf-8?B?UkNXbUlRQ3c4dStyUkR0K0FHcFpMTVRwdE94NjBTV1ZHZXhuT1hzbHJpb0JN?=
 =?utf-8?B?WExvTE85ZFRRakJHY3Zram9VRnRvcVlnVE85UTdiZm9SaExpdUo3ZXlGRWhl?=
 =?utf-8?B?RUFPSWJnS1RpeEtDMUJRVDlTd3lnakM4REJYWXoyVEprS3lPU3kwUlkxbXJv?=
 =?utf-8?B?NnVzODZWQVV0dVcwanB5NExpUEFQeERIVDV3NVI4c0xOYlpOZTh3Z3FhN1Iw?=
 =?utf-8?B?a1B1VEJkS2NxNm5UcUtuVDJpS3M4QU5LQnphU0NNVlpYQ2F4ZDZpUmpQbk5m?=
 =?utf-8?B?L3BQZlBvN1BDQTM5d3NWenQ5OUlPM0Z0d0pGS1QyaVZRMHlvenpKUExBdDNC?=
 =?utf-8?B?N2R3Mk1naUNLVUtiaFZUdk5wdlQ0Nk9zaGY5WHQ5UFdMZysrbENVaCtqc2RD?=
 =?utf-8?B?UmxhV1RxaTVqTjhreXRtZjFPR3dBbWNtVkJXc1Era2lmTjUxVmxmNlZhNGpO?=
 =?utf-8?B?TGJDbEVHVWp4b0N0SHVaNGc1TzQ0VGZJK1J4NldpemhOMkRQOTQyU3M2ckNs?=
 =?utf-8?B?am5oVnR0WEEzNG9xREV6Z0pjSDdFOXp6d0xrZ0xRUjBvODN1clh6NGdtTVFl?=
 =?utf-8?B?K3lJM1RaUmtLeUtxZDE1Z2RYemFGMXIwL2FOakpjNXR5RTB0dHVJRGx6R213?=
 =?utf-8?B?WFlqb1lqbGpLTXRhV0diTTRlZnFXUFJRZFUzRnJLdEJETjZTTExhemJyakxC?=
 =?utf-8?B?YXFuZjBUclJrRm9GamNEWFdwd2EzL0NnRWY0YTdIbWNxOTJiV3dSYmJQVllx?=
 =?utf-8?B?cW8xaE0yamVaTDlWT1hGRXFpRXVlM3lCdlVrVU5iMkJKdnFWREM4RDJnZGVk?=
 =?utf-8?B?T2FMcDBQaFY2alBVQUFtOUFGcStjYVhqZUhLNkJ3RW9yUnZiL0JPellDNDcw?=
 =?utf-8?B?c0ZrdUVibjV5MjJhNUgvM1p4eWtCY2R2bWlJcXJFZjY5Z1R2OXlWeGhrSmZu?=
 =?utf-8?B?bXgzTy9WbW9JQkFLT00wYmVncWtYOTQ3K3o0MnFGZnR3L3grQnNWSHBrci9E?=
 =?utf-8?B?TGErVVhlL1BYakMrc0phYjRWRkJOK1FJVzlEWlMxRjFyR0p2VkRJVlB1enFH?=
 =?utf-8?B?SC9JSFZOV0lNZ0ZYaXhMZVQzcS90eHlGWWE2QUhVS3pLZlpQcG5RZ1NMM2RM?=
 =?utf-8?B?UDhocHN6djFpTlJ2UXA4OFVkVnBiOXRXZkdiZFE5V2lYM1J2bGlIZDdLamVz?=
 =?utf-8?B?NjdkZTYyZ3VsdFY3cDk0TkFOa3BDUm9MNGVFZVo0Nm9odGx5OEl2ZnlkOUxs?=
 =?utf-8?B?RDdwRVYySnJrSWFSZ2hzV01lZWRESmlYMmZ6aU5PY0g3VEk1TUMwZWZMWGly?=
 =?utf-8?B?VTlHVnNjUkRjdHVyZEZpaEVhSVZFbldnbUY3ZkpzSFRGcEhrR0praWx4VjhU?=
 =?utf-8?B?d0lxNjNJUHl5QkRaMzVLaUtwNWNaMFpnWVdaNmV0U1hQM1dNMjVaQUpaa1M2?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2990ac-b739-4271-5425-08db4d11b54c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB2734.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 02:37:45.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UWH5crrJnXvK6AY8tergQM/SErTlcfcOFe/aH5JCHd2UquAorvyKlQ4AIXRmldPlqI10qp6ysi/LURZ7+o9uRc2rgB37Zqrz3e533BNwbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6104
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

On 2023/5/1 17:58, Krzysztof Kozlowski wrote:
> [你通常不会收到来自 krzysztof.kozlowski@linaro.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> 
> [ EXTERNAL EMAIL ]
> 
> On 27/04/2023 10:58, Xianwei Zhao wrote:
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
>>            Modify node name, and delete superfluous blank lines.
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>   .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 29 +++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>>   3 files changed, 116 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index cd1c5b04890a..bcec872c2444 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409-256m.dtb
> 
> Looks wrongly ordered. 'a' is before 'm'.
Will do.
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
> 
> Missing bindings.
> 
> Please run scripts/checkpatch.pl and fix reported warnings.
> 
The bindings committed by Neil, it is applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git 
(v6.5/arm64-dt),
bindings: 
https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com/
> Best regards,
> Krzysztof
> 
