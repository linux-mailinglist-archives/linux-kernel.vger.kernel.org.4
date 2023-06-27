Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B973F0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjF0Cs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0Cs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:48:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA679173A;
        Mon, 26 Jun 2023 19:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5LNDYZwhScur9upMTBQVxYd1JTJnf/5GhncEUf4+/+tm+X8AcIa7L5WMrIGdkcyQ+6FcXNSMNtsHbdnwflyK4tanI03g6CwdR/lJUOYFppjuhk+YN/hrez+0iAW/aKm1aZuIyuNnf4sFLZgzIGbYbW0gKiLe+luObKet49kvfijMmnlEZqzq/xLLA9uchN6Q3GmalTNNGsBrNGI/kr0OltvKa2ZsteDzaFk0Zny6Jv+Za+Qi49rCUCq1gFJbtfsvx6HmwH8VNz2eAtFOm0jkMVeNdHXnbsuXYC2+n8fTFcOKxRW4sKa8LObuv18lRUFim4zyAKR7icEXrPPIYbw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W43R9dryAZ44DCSewHkhgE4wrJ/KN+Ezc0zhoaVzsE=;
 b=e+Jze5fCsDZPRJl5WYd2N8VqMJ7TKQzeCPqlpVd8N2iBlKjBewFLeZ/Ny2h73rPta387bY2WUafX4BrS+lNyMhE8ec1l9u9xUKaLmbV6uqUwa5c/7aw04egYmGyyrY0CvYCPGrWRI3DXGe5UQlLNDxAXZkwx3ubYB19xk3GcXIXqxwzHTQQug5P/1uyXo7U8B4agNFv9p7q8fbjo2+Vt52kxY4urr5TqQhSMAMeEz/QE3zQ8cGd50Ycg8Vy/bBNBG1eoW/8FTwH/VbAv2U+Gd/heZsHPYEgbQ8VGdBq47yu7rhNaAMicHbBHQb/wMh2sx6y+ZMHMhNNmVs5/0XhyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W43R9dryAZ44DCSewHkhgE4wrJ/KN+Ezc0zhoaVzsE=;
 b=PHy0T5VnmstNZ6eH/hGHNUuijQwFKanE+V8FDbinlJscxEhJaemlbnkI5C9F4PqtmW1xAMChIe/Mg9G1A78aQyMQ/ocW4ggEH8zhJXZHzz40QtyKmm3hmIu0n9Kgk9f6c+BWMLxLHKYmOjDfPdnyackRSRNZCOfTgDAHxKMiJYLd6aBdJFcMo1y3JNP63GSy0yZtDPybeOLYhOrJ+Ao47HTneFeJvI9fDFtOzX381p8Cwc22H7CoexvoHWatTxI/JqjqetDQ/+xy9FawNh8Ugp/5AQFgG/hTYpqEI7yDm7AyxgTcpMVAk4XYhjicpiUWImQjIOPc4pu+z6TLA2yP2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB6622.apcprd03.prod.outlook.com (2603:1096:400:1ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 02:47:38 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:47:37 +0000
Message-ID: <dc840032-db63-5fa9-1c7f-c42766384e93@amlogic.com>
Date:   Tue, 27 Jun 2023 10:47:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: add support for T7 based Amlogic AN400
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626095223.721011-3-xianwei.zhao@amlogic.com>
 <9b49e979-4a24-f628-88c4-fd53f53d46e4@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <9b49e979-4a24-f628-88c4-fd53f53d46e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e15a0c4-5e90-4dd9-d29e-08db76b8ddc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PqIplCiWhD8qt/P5rwvY2Tf4gSPbodYkJZ6qAGMIs8xJBdcaU3gCzPeM3SVxLwEQcE1VjCFBekpU4V+9c/aBYv8saFrl1apujbmork/LR9aw55af44v0tbck2CniwqIH4iCaqnIwWdHxMerGsR+nh/p3YYDGG9wJM5+E7xWX51w+qrqIOOo/+ji+D7RKj+K2gRZ3cG1L+otsL8SHlAkUBAbRa2kjq5iPlwUCMHqjxO8w5+NJ8e6xEDoJ6Nep/2GLpPgs0aB/+e0GAPVtUyYXfTJF6bMxAmSLlGQgU89H8UJH1AdD9OS1hViF1o4pdKHjr9C1mhVJGEF6vosi+BPomWpca1wEV82emZcs6jGY9GA2UBkC2QE1Wzohw51tf7vJie+ZqNfW6fJnuT5sBzx4gy5i7tEo8czQHFFdWP7ztCW3+QsKJdBZ/qcd9O4y5CSBN27KodssCXzQ6z/vtpJe5DvjB05pfICoozMFF8YKJUu1aKGGGF3X2UsPNS4N1UlsXHOLHD5D8RTncXUp9lM5Gm7x957am/JLxZW15TEAQvCCPb6BcRG239TvI+E9/fq9gjr53vw8ClINEqy0iUalIYEgfXXOTpcA9MIBelInye8+oEyrZRCUutSKRM1SVUmWtgRPZMY4ctnEzaFgf8GJmXhpE7JM410yAwwOvwgYM7HLdEUfiDmdpROJVhBk9j7NYVj9/90l3N/vQfWv/rJPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39850400004)(376002)(366004)(136003)(451199021)(478600001)(38100700002)(36756003)(31696002)(83380400001)(86362001)(31686004)(54906003)(2616005)(6486002)(6666004)(8936002)(41300700001)(66946007)(316002)(66556008)(8676002)(4326008)(53546011)(26005)(6506007)(186003)(6512007)(66476007)(5660300002)(2906002)(44832011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R08rNTlIYjlGZ3pqNDlqa1lwRVIyNVRENGJ1Zi9ZNFpiVko4VUpkU3RLc1JF?=
 =?utf-8?B?SWNoTDZoUWw5WTljL0t0cFp2ZmJkZDgvZjV0cHJ0QUFrUkc5KzlERXZnTnVT?=
 =?utf-8?B?WDkrcDRCNUgrYXB4ZVRZMk9kSG1qVGdZb2dMUGtCTzJFTmd1TytKTXA5eWN3?=
 =?utf-8?B?TFV2ZVRvMWw4SkllSXVBNURWWlNFMjNkRXJwU2xpeUVyb1NEemR0RWVNSm5I?=
 =?utf-8?B?UzYxc2o5ZVorTTNLTSt1SkJzejlveTl5VllLbjVlVlJoeDlCRjBQK2pXU1l1?=
 =?utf-8?B?VUR6WktuaFZhRDZSOU5STGtMZjNUOHBRYmpjbkJrNzM0U2hXb3FIaktBSEVh?=
 =?utf-8?B?ekt1bU1BazdYVXp1N1E0dG9PV3dTT1NCYzlncjRjckRKOWpNU0JKT1FYWEhM?=
 =?utf-8?B?RWtjVWNBakx1L3loVjFDZWtMN09adXRlL1BsQ3FLYm41Y2E1cHBSSGVhV0Yz?=
 =?utf-8?B?bVJ1S1F1ZGtkNUdFNTdVeHczeGMyc0ZOR2dBdUx0bjRWY2M3ZlZZSlRiTC9T?=
 =?utf-8?B?RUQvTHg3OHE2MTN5cW13Q0xQZWVlM3YzTkdLcHFCK0ozUmM0TzFEUjZHVy9y?=
 =?utf-8?B?Nm1wUkVvbDBwMytIenFBdmZwbnk4NlQvcDY4c3dSeXAyQ2FzYjl5UXF2d09S?=
 =?utf-8?B?dDR5dDdtVnNkeE92L2lKZWJ5Ym5PNGhrRzh0N0J6bFphbTZ5UnUzd0dFUWJi?=
 =?utf-8?B?dlVwMmU0MC9YOWlCRVRTSUc3SHlaVHpNZkhCZS9mK0dtNDVFejJ5Kzl3NzFM?=
 =?utf-8?B?SHc3L3NLcXpBUXJXUzlMZUhtNThtQTBZTUlUQ08rRWYzQ3pTRlp0TGZnVlR4?=
 =?utf-8?B?RURMTEc0VHgxejlJMzVOSWxTVDJPTFRIcWJmWHE1d0NYTHh1Q2VjbjA0SUFl?=
 =?utf-8?B?Rm1BQ2ZhOU9SNWJIeXJmMGZoOUFXa1cwcmgyNzduMmd0RTFmQnZKL0s3R1R2?=
 =?utf-8?B?QzdqcHcyNTdscDhZRDRlMXVWcCtxdW4wTDF2cUl2N2ZaZXZvM3B0QWM1RlRl?=
 =?utf-8?B?RE90VzV0cGZmaldwNlpKbWFjL2JjcWVmampFTmVrbEtPTWNLU0FDV21lWUgv?=
 =?utf-8?B?V2hVUUk1d2QyT01DUkhpcnBRSHpHb3NidWRZVjlIV3Z0dS9MaUQrZkN0TUFB?=
 =?utf-8?B?d0lNTmdwWGxuMUlRZGY4NFphd1ZjS1h6dWNGQTVCRnRzb05XeXVIQ09wUmFZ?=
 =?utf-8?B?UTZMWllVUWhmUklwWk5Ya0I5eVdvVmRlRWhPVkRZVE4yZU9qa2dkbDBvazdO?=
 =?utf-8?B?aW5BdWJ0SHRydm5QUDRlMU91cHZmbFhQem9FN0xOWjhIaytRck5zVkd1Umpm?=
 =?utf-8?B?VDZtSkhSUnNjSTV5MHVhZmIzMm43ejdEblFPSkdxWkZ4M3c3L1VoZkY4bzJB?=
 =?utf-8?B?VzJQcnl3c1RSak5zSnJidUU1dDllRWdvbEFrdDUxdTdpamJOVnRzUzBrMDdU?=
 =?utf-8?B?dHZZd3hRMTF5M2pRN0VlbUUyN2Y2eVZvSEpCT3FoZzlEMS9IMFQrdVI3UnZN?=
 =?utf-8?B?cm5FNFgxSDJCOWRtMEszcUR4UjJsQWhsY20zOVgzQlVoem1VYm4yTlZ5ckVs?=
 =?utf-8?B?MzB3QzYvNkdPRUJCdGZldm5iek9xRGwveDllOWUvY1pjcE1hekFCdmtnekNx?=
 =?utf-8?B?L0NQcUpZU0UyNmk0TjlYZ05QVmhKWTFVdjBRWjFLL1lVVSt0VzBaeU9QYUkx?=
 =?utf-8?B?M3JzbnJUdUJodGVsamV3MTg4eGt3UzVmd1I1RmtYMWRsRDJCTWtQTzNVOHlU?=
 =?utf-8?B?b1BnMHViQUh3OS9OMnFHUmg4V1A4OW9XdXFPZUpwSGxIbk9GZG5iVmppMWNE?=
 =?utf-8?B?NmNNUy9iTGNjQy9HVzFvMzZSeG1EZmtiL09NY3NGRmhIcHVMSTRwL0dGenp4?=
 =?utf-8?B?UlluMFBIWHYvMDJFLzhiTEtDaUh1UXFaT3NGb1R4RHlMSDd3dXB5OGl1ZUhw?=
 =?utf-8?B?TGJ4MlJwZGFlc0w2WkNsZ25vMkkwbmorOWhublJ6azhNWktmTXpUSWw1ZXVZ?=
 =?utf-8?B?Skw2cHE2VDhGWWN5eXVvWlBzeHRsVVg0MTlkM1lLWENrUXNZR0hpSm1wY2lB?=
 =?utf-8?B?OGQwdXd4VEZpeEplNS96ajBtMUtwMjNIU2kzZGYveUpXcXhFUzd4c3Z0TkFy?=
 =?utf-8?B?WHI0SCsxTEdobEFCaWxCZ0ZLNXJlUUMzL1NBcFRYckdla01vRCtXYlVKb29k?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e15a0c4-5e90-4dd9-d29e-08db76b8ddc6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:47:37.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNq74dPpJyTXYZMtfr7XRM98ApDKWuZCIJMcoO+QPNyZT9m1Hdt0ykCZAElP6ZRlPbxQ7aQtpuBEw7qpWOY/hITE0BHOoR/vTUrSyhBxLAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6622
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
       Thank you for your review.

On 2023/6/26 23:41, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 26/06/2023 11:52, Xianwei Zhao wrote:
>> Amlogic T7 is an advanced application processor designed for smart display.
>>
>> Add basic support for the T7 based Amlogic AN400 board, which describes
>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>> booting up into the serial console.
> Few nits.
Is it possible to be more specific about it?
> ...
>
>> +                             core3 {
>> +                                     cpu = <&cpu7>;
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu0:cpu@0 {
> You miss spaces after labels.
Will do.
>
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a73";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu1:cpu@1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a73";
>> +                     reg = <0x0 0x1>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu2:cpu@2 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a73";
>> +                     reg = <0x0 0x2>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu3:cpu@3 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a73";
>> +                     reg = <0x0 0x3>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu4:cpu@100 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x100>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu5:cpu@101{
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x101>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu6:cpu@102 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x102>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu7:cpu@103 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x103>;
>> +                     enable-method = "psci";
>> +             };
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +     };
>> +
>> +     psci {
>> +             compatible = "arm,psci-0.2";
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
>> +                         <0x0 0xfff02000 0 0x0100>;
>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
>> +                  };
> Fix indentation.
Will do.
>> +
>> +             apb4: bus@fe000000 {
>> +                     compatible = "simple-bus";
>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> +
>> +                     uart_a: serial@78000 {
>> +                             compatible = "amlogic,meson-s4-uart",
>> +                                          "amlogic,meson-ao-uart";
>> +                             reg = <0x0 0x78000 0x0 0x18>;
>> +                             interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>> +                             status = "disabled";
> Please, don't put status in the middle of properties...
Will put status in the end of properties in next version.
>
>
>
> Best regards,
> Krzysztof
>
