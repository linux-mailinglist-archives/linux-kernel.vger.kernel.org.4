Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7F7000FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjELHEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbjELHEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:04:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A2D2CC;
        Fri, 12 May 2023 00:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJmc13D2+kfthVMKwfWSXrFYs1XXROh7qEwHYa+4BrKIF9WSufjacdiuEUjWX/DOf9opEu30HW6/P+9CVwOVvRFLN5XHHsMro+yerg9v6TWdQ1PkVrU/ZOmpR9rnAK6kraDvLybMgL0/fmdjTGqA1W9sJeDLZyNy8gF6qUWs0rssFB2xO2IkGIevuNMSImEFnfXVP2a/EnSp2ar+d4nDeTMs/J3hg9bBXsjtvNHYPcNrcVeOSfcqSsphZcr4Pg7oPWyN4snlrYZAjPSRt7+7mHXhs5hLBhDm853EKWIAmjF7a1H/vI6K+VCTRkYWCs+GgHwWO1PTIwQXxgaP8CdCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYf9MkzLlI9UHuY0kmi5781fqnXNqXjrqCdSN4OQ+No=;
 b=M19bxxgHmSfB3W9oREDCE7dcW64TBEOiUHKuHpVqG411a09B0Fd8pw8lSvNq1E1v8vSrIBC0FPpMkmkssCmeUjfP5zcxGA6CftdcWHq/qorP2bdqlMf7W/XbXZDpPIm7oI77zVy9B1voJseGyFlvjo85sIcY6R8tTcV6Wxz1S5jOF2WiUwT2wJO+zrxTBu8/E2ghfcfDU7ImtCf0swRl3dXQLXJaAYMJ0XBYEvA0hrFheq9pxLkwZqBJUy39lo9VWqIQC1PDCtcgEcPweXj2cW2ZDyCZaN1hLBf8muNiXjkGdv9mvgA1d9INpYHzVMdxEWEOoZGevp04MUj7mMKXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYf9MkzLlI9UHuY0kmi5781fqnXNqXjrqCdSN4OQ+No=;
 b=eDOefBAV+cm7bDLQUA1PMZDA7191Y0ejmZ6unCiN94iLOEXUtViIVWAqoUlyh2tGDhzr4jkAFIM2PzUHvtlQmF7RW2QzaQoKaUgc8oVjQpHT+kPbskEXkd5dwA9tXQ3Di3/7U5+OKVLRh0WnzLaH89EXwfm32m1WCyHJlMbyznad4ZU6EI/MNaLH4uvIJwkD60cOl+SkVsf4HpmcqCx/gtb+Ow+CRYwzEhK53i7GZw84FoqlADHCtZVyKFccAih3wnfNciqF3Tarh/iCAjeyC0tfIdHubn3TuPYalQlOvWG0ajq/akPbg3HDPzVl1QRq1ajQTyk8yq52wC9SetTCkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com (2603:1096:3:21::22) by
 KL1PR03MB6921.apcprd03.prod.outlook.com (2603:1096:820:bb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Fri, 12 May 2023 07:03:45 +0000
Received: from SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4]) by SG2PR03MB2734.apcprd03.prod.outlook.com
 ([fe80::9c6d:3128:b370:5fb4%6]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:03:45 +0000
Message-ID: <d588b62f-970d-a974-814d-5b116bc547f9@amlogic.com>
Date:   Fri, 12 May 2023 15:03:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     neil.armstrong@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230510091129.151669-1-xianwei.zhao@amlogic.com>
 <b2bdb00f-63de-40a9-ebe6-32f83607b5d8@linaro.org>
From:   "xianwei.zhao" <xianwei.zhao@amlogic.com>
In-Reply-To: <b2bdb00f-63de-40a9-ebe6-32f83607b5d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:404:42::17) To SG2PR03MB2734.apcprd03.prod.outlook.com
 (2603:1096:3:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB2734:EE_|KL1PR03MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: af6c3fe2-a8a2-4e8f-fa53-08db52b70711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDvwTMYjQk/hi1zAyqm0r8qIl01uHyISQjyYo3T/PKpC+Alixequ393yJv3+9IEEkTVbvh4bdvzvG0CY4irS727OSsmDlm9LJP2zzk8Q4K3qLzqpFmW0KrNVlntYetieeGrzR4y1+LoS51dRwbyFUT6gR5vEqCBvgcagfe1OmyhqOJXZc1a68GSLeDVzjCXw8x0dC1MR5N0zQZYMNohU71xdv/pmRgqhhwlzjeG/fQ5iCjY71ICp+nTANHb7AS866S+vyDai/F5gXer6Wp6llSaweTbk+Ky5aOCjFNRXK+pZmaqjfX6Zi3X894Dt8VDCtOuvp18EGY+tRKovQX7NpYE249Ql9Nqnf0pB4vmplUuNAtRQRP+OEuAZDn0YYrrjIS4tVkeB0Z7l/pysYRoWxP6rhVlidbfjWSz/wBsnoJROPkDwRN3WNkpcsur/373XMEN+qD7IDkWtwLimPEHeTtTf2No243LG71+qnSkady8sKaK9XnTf5bldy7dVxIHaxI94f160l7WvxrR97SOqZNUFdJKFCqzjtU/4gyVQ0goaoDYOSECflcmuXVVf5MRPAVWRB/IXJaaoUznLlqoWl+CTuICl/I+q4BRSi516+ew5AXehEVIcLcwvVrFZ+T+PYo0VwdcQRfLMMvOgzjU1LsZcQwPpTkjGeUPXU59oVMWdnVcriwnBLD5Sir9HIa0u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB2734.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39850400004)(396003)(346002)(366004)(451199021)(31686004)(966005)(4326008)(66556008)(66946007)(66476007)(478600001)(6486002)(316002)(54906003)(86362001)(31696002)(36756003)(83380400001)(26005)(186003)(6512007)(6506007)(53546011)(2616005)(8676002)(5660300002)(8936002)(7416002)(2906002)(41300700001)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3A1cXdsY1lFN000c0NkdkJaT1RxL2pkZkhncFZ2RnNUZGRQd1FkT2NOeUZN?=
 =?utf-8?B?MC8xRTg0eTVvZXRrUXZaK0pNUCtKR09HdmRjaVljUFl3WEl3bThtc3plUVRF?=
 =?utf-8?B?SzVTd2M0MkQwUldVUGRRLzBNTHdKbGZQMzNVMkZjV1BRV1l6M2N3ZTB3TUdo?=
 =?utf-8?B?Zm1PUWxyRGI3NXpYUUVndjA0ZVEyTjY4L003NWRoSnYxaHBDYU1UQmhiSHRo?=
 =?utf-8?B?L1ZaeWFBS1BzbzRNRXEydUpGdzlyN3RyQmxab1l5b3ZYMHJQSjY2MEZTWERZ?=
 =?utf-8?B?M3VONFIzMk9FS3FCWlA1Rklqd3plb29wSmNKYUgvQ3FxeFRzRTMwcEQyTmRC?=
 =?utf-8?B?MC93ZFM1UVlTQmlxb2ZWWXFaUzlGRm9Id3NVSTlDOEpPYXZvSFpsWEEyTzVh?=
 =?utf-8?B?VXIzVG50NkloQ0YyRUNHRUxSVGNEMk5laUk2cGVRcDBiVDQ4S0E5UkoxMjZG?=
 =?utf-8?B?M1hXTG1obHQ3M0lKNFB1MWV1aUt5Vy9BYXNYbks2T0lSVlVCU0tsV2xoZHV5?=
 =?utf-8?B?NGx0TUdxSHo5UnIvc3hjSys5Y21uT3plYU5BTlRyYSt5RFZaUGk4M242MTRO?=
 =?utf-8?B?cEhJaU9hamtuSWZ4N3lKa1BJZUxzb0lMQksvbXAwMmJ1NmNjVGE3NGQ4bnMv?=
 =?utf-8?B?OTZrSUJvSVZzdDJma2pLQ0c4cGd5N0tDdWhqdWwwQTBoR0VYYU1xN2JxU055?=
 =?utf-8?B?TlFPYkVmSTdoNFlSdE43TVREVmhEcXhGSjBWYnFjS3o5OVExUDFHelpBKzV1?=
 =?utf-8?B?a0JBS2RONDZ6UHZTZC85Wm5ncWZJdmZTUWU5dEVPeG9nZHhCY2pNcVk0dlJi?=
 =?utf-8?B?S1hKZSthdEE3Njc0S1Y3OXF4QWtVbFpLL1JsbjJpYjJaeDJrcXVNK3VMSXNB?=
 =?utf-8?B?cmdrS1Z5NjBRNXBUdnZjZm5BRTRxYngwMzA5b1dzSXVXcm9FNlIxdVpjVWhO?=
 =?utf-8?B?UkZlL3FuVnAxTGpaa255ZXJmcW9aVTlqN0habzdjNEdmcFFNdEdZWWFzN1F3?=
 =?utf-8?B?K0ZhRlZoVHNNNEkxVW5MTHpmbzlsbUFFTWRZZGlwYVJ2TkxLVWl4bWlyK3FY?=
 =?utf-8?B?NnBLZ3dUSUpncWRYb3h3Z2VQcHUyMlRSMHpXR1RVa2Njc2ZtdmdkeENXUkVw?=
 =?utf-8?B?Nkxici9NRXhIUzVVYVdjdDFZbko5MmFLMFpVZnRpWmh2eVlqQWZLa1J3QndX?=
 =?utf-8?B?ZnJHcXJnbXROZXRrWFBreFJpcVFEV3JhVC9Jb29LbTdiWW5pcm00MDVqZk1U?=
 =?utf-8?B?eUhwL1ZWb2dHOUpDZUlITmd1WlR6aHBaQWQ2ajF3L3pvTnlNRkxNQ3I3SHNG?=
 =?utf-8?B?SWV3dUl1cUpVL2NWUWJVQ2hsMnN3TEdSQzN0VFE4SHZ2VittQUFvenZCYWsx?=
 =?utf-8?B?aUFoMVhMOWZtNnk2RUVsMHBnTEpMK2c0SVN6anl2eVZEd0NJRzdGZitpNFFh?=
 =?utf-8?B?MEhjNGJ2YTlWWnpsL3dQS0o5bkxyRkZTbU1LWmJ4b2VPcXkrd2xLQlVCTkx0?=
 =?utf-8?B?bC8vMWFOQTZOUXhlSHJwbEFjejY0RDQ3UmxYR3JIWWl1bkZUYXNqRXdBbVhJ?=
 =?utf-8?B?UXU0dk1ubmRicXpiWU5NL0hMUDBkcll2R3E3Y29pUHVjeUVSdDQxNmh5Tk1w?=
 =?utf-8?B?RmpqYXFyU0F4NWRpS2kvRjdjZnVRbjhBSEkvWDZDMW12ajB1YkU0NTJrMXFk?=
 =?utf-8?B?S0Nqc2ltcmcxR1NpY1BEQmV1YkhtUzIvMlBaUmRBM1FCeGRXMVlGSjlnQklD?=
 =?utf-8?B?UWNWU0N3Yktkdjh2aFhiNnk5WS9nMmRQZWFCU0JvaERJcUZFMFZvT1B1YnNZ?=
 =?utf-8?B?cmpkcnU1V3FNdkovMWdPemJYaHhYVUhwbVc2dkRZN3piV1RLMXlzWGhsb3pV?=
 =?utf-8?B?UndrWmhpWTVDcTc0Zm83UWdkQ2hacnpxNnlxVXZKWEN2UWx0TXBzUW9HZ0xi?=
 =?utf-8?B?Vnk3MFNXUVNhbGhzSUR0c21XRWRwTFNTa1VKVE1MSWxRRHBWeFpxTVlCQXFH?=
 =?utf-8?B?S3ZPUm1aTGdEN21QQ3YzQ2lSSmdTbnNhT2p4emlxSWFDSVp5QlFNQ3VaTzYy?=
 =?utf-8?B?cWNyd3p2M1R2WmVPekdUV2x6bzBZN1p1ZitpSlI4V0FIRkIvZDV3WFdnd2lj?=
 =?utf-8?B?Z2NFYkd5RlpVbFUxQUpLTEpGeDZmY2RwTk5oRDZoM0VNSFdyNDVIcmhwanEy?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6c3fe2-a8a2-4e8f-fa53-08db52b70711
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB2734.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 07:03:45.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0RMFalTUeLHpdPGqGVcI1CVJKtE1E3k23ffkjFkP2uxHk6auuqRQnQ3NBvCxJXVTOs1ztpNsQq/t4POhKurPH4yAz9lR0O08m7O+mMIoNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6921
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
      Thank you for your reply.

On 2023/5/11 16:39, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 10/05/2023 11:11, Xianwei Zhao wrote:
>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>> applications.
>>
>> Add basic support for the C3 based Amlogic AW409 board, which describes
>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>> booting up into the serial console.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> Link: 
>> https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com
>> Link: 
>> https://lore.kernel.org/all/20230307222651.2106615-2-martin.blumenstingl@googlemail.com
>>
>> V3 -> V4: Move Link under the --- before the changelog.
>> V2 -> V3: Remove '256m' from filename;
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
> 
> This should be:
> 
>         compatible = "amlogic,meson-g12a-uart", "amlogic,meson-gx-uart"
> 
> to match the amlogic,meson-uart.yaml bindings.
> 

I will use strings 'amlogic,meson-s4-uart' instead of these, because of 
board C3 is only use 12M clock source for serial, the same as s4 series.

> Please run :
> make CHECK_DTBS=1 amlogic/amlogic-c3-c302x-aw409.dtb
> 
> With that fixed, please add on v5:

Will do.

> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
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
