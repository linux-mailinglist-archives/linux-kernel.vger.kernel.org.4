Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39478745988
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjGCKB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGCKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:01:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D52D47;
        Mon,  3 Jul 2023 02:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzCV25BnIKKLyxmEQcjfHepM5ZsW3zSFg2MpFRCBXMuNF96BxVhKwzrmr8IEQ4OcEvsr/WblouCypY7vs3JJyyQ0ZE0VfQH46X8BuiHzuKLnVpFVv5etMxDia2UozXyMIr4Vx4P0Q5YPytrlW991/ZFDIUKGTmqOG/XV/0GMCSg9viBeiraPlYh42owRCYNQHr1XxbQ6Vr2LqYvrULgzKaFw5HQkOdAgp+YY/OUKSvTa2R3fzzaRhifhL/LnS+6lufND/s5pvLS7zqfxPo9uXC7P7qIqUDFsegsps9YfXLJLrYArEyuvmkLtqXVa68KQfwLKkIY1Pa6MLVWC9w0t4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgdV5eMXKKfFJjeCCTAG0PTv2s8dGn1zoVkKcOOq/F8=;
 b=ND8BzOGsS0i5BQzIcDY7RHqRkxvbEzBmlAAUubm0O2+QSrB7k9MemjC03fOvRe7dWIV+CcfyZyS+GCpOHPAGBjd1NXuuAan8g/+fk3CExQs3QcNLppvVbIzX+yktnJkuzG98QZ86D7DR85wy+Ft1VGTsbqsVUOi3Z3GwHch4j2UFHI3SKZKMiRTojaxK1qAMLXMlmSjrP3PwJwos9cJzaH1+eraRDlzDJKn0JaR2puzJemAWsAa41atPwcFazzIZ3k5a3xDF4OiwYW1A8/gMBnjz3hFmot18I1KsWVTdOtPh50D0WgDk3res+3Jv0sTdV1eCpxH0BnxwQO1qqWNFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgdV5eMXKKfFJjeCCTAG0PTv2s8dGn1zoVkKcOOq/F8=;
 b=APGaEzfIT7BNekfPDF+UvU/0KNrccjbBejSB9CcGRiX2L6L5b1mW4TYTXK062+y/JqiClB0OWIpGlMKg5O/sbSA4eXf4GvwuqvPhSGXK+6MVB/v+Ee0SS+bgoXhROSJynJGh0g++8c5G9L5tTO1xAwwuX2dK1vTSA+/QZA3rftcP3d6+HyvrXIDpQS9vr1WodkqLrNzv06o+FIwQ77hCFzEQv5DBezX3OPSJqdX8qQrdu98uIUxx4uGYEm2GKGEcbIL7X+s6wOBCJOGcCyhUqVBgHQxyXVU+oIEQwttjR23D0k72MZUEhuluqocC7bdiRAbZDhWfdW5yE1R6PwiXSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Mon, 3 Jul 2023 09:58:14 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:58:07 +0000
Message-ID: <64382cbe-d445-e229-d61c-38b2be94f417@nvidia.com>
Date:   Mon, 3 Jul 2023 10:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: tegra: drop serial clock-names and
 reset-names
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
 <55cece9b-b4b8-854c-f948-2e30895f36b0@nvidia.com>
 <9fba446c-f0eb-ef44-8ced-f7a0bde8d064@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <9fba446c-f0eb-ef44-8ced-f7a0bde8d064@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f125d0-0aad-4c94-1e79-08db7bac0085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0N+lbaxmFMCK4fWbelYa9AP6fq4o4UnBbm378+FcTsGQiygbIqOlvzgbZPoWLyz+iu9iJMOPlWbzYJS49hf5/cWhADcyHrjWHRuQQZvoHrN1vynoX51CvSA6YGdHuSeUxjHbEetEWfIkxt7dS/KR7f2l80wupc1AQcyyRAbsyd+NKid5UyKgskq1NdTp0xfJuXTcXyEGTHetPQJtYvDummCr4fUjJP7jo0BePQ8JVepdnTiCVmZdJhlfhJcIFAwquqYa5ZmyK4q6I8/uj4LDXUh60DmVpE6qtSDYm91wkQjHdncj0A8UtFo460Zc6T80g/loDyptEsgc6M7CNo33Blo94yBi7lkw2Bjjv1UrmP9bs/zCWWcRV55+gRV0ptP7W4YSFqQT636AMWpiru0Zf8RqlR6n82rPFzVUr1T+rQwbQerfDoE17Pm5ap8yzt7+UQaBr35N2O7/wb7SEsEsmMz6nqVuUleCIb0J/F367V0Gq5Sj7UttJrPpVzPiQ8Mh7ljim/bUvUk+wsPh+F+PW4JTczbNcsqVF6fxJyCTAJ2BlI+9UrwhX5K9ErCLZRsOD1X0uhLLjhNk646A+SXPYt35KntGzU3qT8vKh37f5I4OqiCIntOyHxt1Z4+5I0RjICB5wveSUVps6oV+K0qG2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(6666004)(83380400001)(6486002)(2616005)(186003)(6506007)(53546011)(31696002)(86362001)(5660300002)(6512007)(8676002)(36756003)(2906002)(110136005)(66946007)(66556008)(66476007)(38100700002)(478600001)(8936002)(41300700001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lytsem9XOWVRK1VkSWdmTFlZSTJ1VjdianNJUnZBTUlFeEo1U2s0aGJzT0lo?=
 =?utf-8?B?Ui8zRmpKbVNSbkpVTGVkeVR2OXdnWHJsWTVPOElsNzUvMVJqK0dqb1k2YTZl?=
 =?utf-8?B?WmdhRWhCNnFnWjNxZ21GR2FpWmtrUjdvK1BTY1BwWTBOZUZyZWNqc0pudGc1?=
 =?utf-8?B?TUxsSWJTR2NTNmxLdWh5cUtHZFNiOFFJMzY5eTJldXlqZ3A1WVJuVlpHVE03?=
 =?utf-8?B?KzFMeHRDMmFqem5mSnljcUdnYVZOWjJBQ0Jld3hNaU5WYW9uTXoxNm10Ujk5?=
 =?utf-8?B?eEdjam5xTFliK3V6blNXOVAvc0NsWERWY0VlaEhpUURSWjMrQ1JtZ3hQSmx0?=
 =?utf-8?B?SFVac1NNbDBEeVF5QmFPczdYN0lVQXp1d3B4TGY4OTZpY3hDSm8vVmdQUkNF?=
 =?utf-8?B?WERFWFFiSURUUXozT0hTcXZEZ3pyNVF1RGhDT3JhMEtoa05TNUQ2VG9mSWV1?=
 =?utf-8?B?RE5YVkJqcktPYzNKMUdhZTQxVlBJMHRIRlhhR0Z1TTV6NnczWHVkN2VuZmtS?=
 =?utf-8?B?L0pqajgra2NURlpuMm5mTFBTUmpEQnh5MEI2aGVqZGx3UmJTRGhWZE8yYXRs?=
 =?utf-8?B?ZFprOTRweFRicGhSZTNQeGhrVnNjS0xmOHk0TnFrMjhneFFDcVJ6Ry9xTGlY?=
 =?utf-8?B?VjViQmcyaFFPT3FWd1oxQ1BVVTJnZ1g1UEx4eUVnZHQ5MkVWSWE4a1VwTWhQ?=
 =?utf-8?B?TGdyWUp1dVNxU2hGbUNlRWVuMWcxUko1c0tLVU1SRExZWTN6NmhvbzY1QVhI?=
 =?utf-8?B?bXhUZ2tFbkZCN3pTeU4yY1I1Q0N5bHcxeU9WQzJZT2FYUzlxWU03cVZZd09l?=
 =?utf-8?B?QmRoZW5uWURGYVp1ZENZV0FiTFMzK0VIWFZpTXo1a0J6U0NYQUI1YlEzRnY5?=
 =?utf-8?B?SThHOWlzL3A3UnllS2VQZ25LZXR6dXBjbmFMN0VUbmFESVVoTEwzTEdLb3Rx?=
 =?utf-8?B?a0lvbU5VVFQ3eWlUVXhUdXIzUE5ORTdLNlpZUDAyN2FKTDlTRHhHZ041Rm5p?=
 =?utf-8?B?TTNERE5abHVsRXZiaDFjdklBUDRneUNpYXpUYnArd2YxR1dKS1BNMUdyaXZu?=
 =?utf-8?B?Qlh5dlJMTHM3Q0U5ZnRkYzdNZ3FURDlGd21ZSkVXZVU4eUl1dlZ5S3NiTitN?=
 =?utf-8?B?WWs0VmRrYmlXOGVUOFlCYytXRHR4Skd5cmczY1IwMkhQbk1kRU90c1dLL1dI?=
 =?utf-8?B?VHFhSHRKTlVvbnFDYkxjZTdCaUVQRHFza1YyTDdwd3FaODBGdStaaEZ6UzRF?=
 =?utf-8?B?OUsxQ0pvNW1FbWtGM0NuekgzWUJIQWp4eUVPcWgyZkNpRHJZbXZZazRvaWZ0?=
 =?utf-8?B?N044Y2EyZUdWS3pxV2JmQ3JpS0pQMHRnY3ZKVC82a2JPZVAwVlJaM24xSDky?=
 =?utf-8?B?MlI0aGwrVUxOWmQxbnhTNlF1VmgvbHJhb1BmRENWWmNPcE1uTUd1ZVg5WE96?=
 =?utf-8?B?eWYvTVhMUWlUSlJ1MWZndC9PalRxalJpdUJ1b1FVeWF4eTV3QXJTUE9RSGFw?=
 =?utf-8?B?TklObjZ5OWZRQkxuWnZSMTZvM1A3WC9yeEFzZmJlMTF6Qll6ZFRlNEZtcEta?=
 =?utf-8?B?TUlzQmRVendJL3RwTXFncmQwYnAyTWoxY1RDa1Npb2NEb0JGMXRncjU2SXp1?=
 =?utf-8?B?QW1yRVExRG1wVnVaOHkxSFdYTG8zYnErNC9Weis3N2F3RGVWeCtWcDY5MDJo?=
 =?utf-8?B?Z1dzbE04Tlp2azR5dW4vdmdMR3lvaW5JcC9xWER6aGR3bGQxMmNOQzdCcFdp?=
 =?utf-8?B?YTdSanJvbTc2QW1kVHUzdUZzWUxqQjZMNWdtNG92T3Juazd6VVVhQ00xd1BR?=
 =?utf-8?B?YVYrMlAxSStZRVFuRk5ZVkQxQSs0dGhBR3ZNckF6UXpTTVBHMkRqMGhkbWh4?=
 =?utf-8?B?eWpFMTVSWFVUblduWXp5L2RxcktIU0psS2ordEFReXR4bkY2aUpDR2dEcTRC?=
 =?utf-8?B?NXNocEVkKzJXRFBsenJPZDVOcVRDcHordFdKMXpqQVh5ZUxUcllRWWlZTmlD?=
 =?utf-8?B?RzQ4ZjgxejJDZmtvaEd3SlFYWm5DeG43SWZmNFZ6UmJEVlA2TCtZODFTUUN1?=
 =?utf-8?B?S0pCbkdGZ3Y3V0JDVVNWSWNXMzQwTnljVnNFNy9OOUE3dCtnYlV3M0FDQ3ZB?=
 =?utf-8?B?enJPVlBpTWtJamFTbWJNZlUrbjhXRk1DY09FWExMMFNGTGFaSzhxaWg2QzE3?=
 =?utf-8?Q?psbTs5FyZO4RrpxQTxzvWH6RQs4xCvzNO078ieTIIEmm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f125d0-0aad-4c94-1e79-08db7bac0085
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:58:07.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwIQ6LkTiR30S7BDZknI3T1O5EKu5EM2xtzYukaV5zxIyu7l6R0memTKbqpBMp3NCCAAPTSlPKbb8d4StvC5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/07/2023 09:14, Krzysztof Kozlowski wrote:
> On 28/06/2023 11:58, Jon Hunter wrote:
>>
>> On 23/01/2023 15:15, Krzysztof Kozlowski wrote:
>>> The serial node does not use clock-names and reset-names:
>>>
>>>     tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not allowed ('clock-names', 'reset-names' were unexpected)
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/nvidia/tegra132.dtsi | 8 --------
>>>    arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 --
>>>    arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ----
>>>    arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 --------
>>>    arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 --
>>>    5 files changed, 24 deletions(-)
>>
>> ...
>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> index b54353f31df5..372be226a7f4 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> @@ -676,9 +676,7 @@ uarta: serial@3100000 {
>>>    			reg = <0x0 0x03100000 0x0 0x10000>;
>>>    			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>>    			clocks = <&bpmp TEGRA234_CLK_UARTA>;
>>> -			clock-names = "serial";
>>>    			resets = <&bpmp TEGRA234_RESET_UARTA>;
>>> -			reset-names = "serial";
>>>    			status = "disabled";
>>>    		};
>>>    
>>
>>
>> Thierry, do you have a patch to convert the Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt to yaml? I have noticed that the above change now cause the hsuart to fail on Tegra234 ...
> 
> my patch was touching only the UART (8250), not the HSUART. These are
> different compatible and different drivers. Why do you think HSUART is
> affected here?

Yes they are completely different and your patch is obviously correct. 
However, for the Jetson AGX Orin board we update the compatible string 
to use the HSUART driver (in 
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts) and here 
we don't add the necessary reset name which we should.

I was just flagging this issue to Thierry. I will send a fix for this.

Jon

-- 
nvpublic
