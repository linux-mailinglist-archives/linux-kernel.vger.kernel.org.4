Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21586F52BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjECIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjECIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:09:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E649E6;
        Wed,  3 May 2023 01:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbK5WyfhjruV+y687Xl0j/Ron0Yi6zOCElOgh5qWPVhfrsckvSg2KqtfC3a2UZplmuOhCM96SGCVcCwk++Wrf9o3ggYEM1Fk5rL/lGX12L0f7guWEaToh/r2BhbDv6wDN0kZ2e+bR4Af0sXNYYEwo/arJrpC2GjAd65VEPc2rrHmKeR584iUGxw5cUi23DusIK/4oECV+Z3Qu10BODFvxFlaeSrSPuMIAz9ZiaD8EX09CNs/cU28fAoajZGVNtD4aERqAPyJWW4ehcK3Q/kl2IHbjfmUbfTilsFeD6qeD8TXbpcGeeztX7y6OVYYvr4R6MJ5NyM56YYmuBkDjE+g+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxFliDIiG1EWU7AfkVcqLnI29K4WXrsPGUiDwBFew04=;
 b=J4LDbXWkOQ0HtQRSw0bCv0+w1sB8v84jjmqaxA9IinI6TiHpwpPVnzjW8N0ZY7WV0j2suc7QH0HR9ygSrVeFWrK/18Qj4d2mLYLiyHYgFsFjAxWMFe5VrwtXRqxSHrgoSc6IXlrRMcH8PqkWske37HTEPA5mKSoCJ4REL9O0catMfKYLPSF6R/FfPq1iV5KBqOiatmTKBRpDciVHJpBBFKSY/cChpbAFhHBfUt8UZWZPqxxyaPoc2dyP4WkeiySpnKDXCrQXZellVnWWaFdHF50ZURyLnETyYTCggc9GxqGi+o+hGRh7csCYYnkgBDmk8kBlmT7L5KRsIHXkxGH03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxFliDIiG1EWU7AfkVcqLnI29K4WXrsPGUiDwBFew04=;
 b=IKDdf5LCDiRuSDC0YECQgfVcKnpXNrZw+3Z+rqjCHptrTV7ISpCj2KYAGyYLiMUFtggGwvt4VrtYD0ZDq3eftQWaEUmMvDEHN2sWltzlvWCUTfQPxTeNQoGDutVKv8oHS1lTkMrOtn/Nph3+cxnZTL2yXvbDRl5kybQps68ey9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Wed, 3 May
 2023 08:09:16 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 08:09:16 +0000
Message-ID: <a6c21b11-880a-8209-b45f-bba10a7acc68@amd.com>
Date:   Wed, 3 May 2023 10:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ARM: zynq: dts: Setting default i2c clock frequency to
 400kHz
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4dde5d1eb8e4572dae4295a19a4c83002a58e5da.1683035611.git.michal.simek@amd.com>
 <e0b50ae1-b501-cb41-829f-736903e5794f@linaro.org>
 <958f4336-8c38-4cc1-4313-06a54e397d42@amd.com>
 <89276de5-ded8-2f38-bcea-708fdd35ca6d@linaro.org>
 <bfc2c9f9-a8cb-84a8-0800-fc90f6ec2eda@amd.com>
 <1d11d36b-9cfa-4d39-c521-aab2153e49a9@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <1d11d36b-9cfa-4d39-c521-aab2153e49a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cc3a4c-0ba6-4ae6-843c-08db4badb058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPCYC0mAv1PjctskpTM5sTDaWhklzsrqYzjcifasPFAwiqr9HRP1vDgTtx6HaOi124jYsDuOFoPwYq0mgNn9djdqbZisMDpmqC+E4DIuaX3vsTJCKjFzOoDq9SZe1CiVauAlGPYkhH7PRZxLQ1Tcdg3GehfBTo+8aCsaAw5EhjtzQRt53mn4r/xF0/PnSPEAWIH0pxcNrZdH+MY29y9JixqUn7tqVdGG+Pd7ABiFFJDyDIjIBkZMoft5ZU664ZXficwdpiTtLcBMW/6Fha3vGLYSybWQeZdM5PFhD5vkSl4ciPLSMsfQcSBC60WsFc7qdTsgdvc/YmakWydqUGFGSYc7BktJ/+uWO+1TokMRzRlnjoRtcCD9xi0OOQiCDCxomDDe3no8ktopWOeFiFVDQUFCFHSJeupvxFPrIaw/sOlTblrAT2uFHob3STMVMLUUsglxnw7mQJtfLjVYPjR8ojn4Id7Ii2SQ0XcyVs68j4o786WGNo8ffo1nxw9x9aoXYgrypNodTb9nIIxKKP0VtKswsn7PpGp1fP0xzRkikoendgao6OSleEW2/FxXa6uyYH46/E7/fiSCqV+91ymA+tMeqrWkhrqfzaL6xRUDIWn0nUEYebCDImzG/3UaRevj4kr7KurkelJnfyXas0lGmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(31686004)(66476007)(66946007)(2906002)(2616005)(86362001)(31696002)(44832011)(66556008)(5660300002)(8676002)(8936002)(36756003)(41300700001)(4326008)(54906003)(478600001)(316002)(6666004)(966005)(186003)(6506007)(26005)(6512007)(53546011)(83380400001)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1N2NXZiQlZEMlBLbDFMdDVCVktoQk84SURqamsrUTg2b2s0bmZZbDgvU0w5?=
 =?utf-8?B?a04wQVBXRE1IWTZ2TUhTMkJYRGMxUWRoRUw5L29kZ1Y0Yk8rclExZFVzRVZB?=
 =?utf-8?B?dFJHNzJLQ2NFejFTQ2ZtUW40R3Q4cjJLSnl2UmxjRHF0OXFJSlkrV0hYNkVK?=
 =?utf-8?B?YlBKdk1kN2VCYzVhQWVUaEpOYVk3VUJCYUtPZ1pIS2FwOWhHNmpRR0pGVTVF?=
 =?utf-8?B?VkFSQkhXbGllNThPOE1HMGVQbEFXeS83cHo1cG5UM0F4Q0FqL3ExTzQvMVo5?=
 =?utf-8?B?b1pwYS82VUs3ZXIwT1VTeDk4QzF2QXVxM253bjB5eVBJRmFSRCthSHdUVHA2?=
 =?utf-8?B?T3R1MlYxYWhHNjhXUkJ4Y2ZzZHZyc1RFeVJSSHpkVTRpTnhicFhtK2MzMlpQ?=
 =?utf-8?B?Zk54TmcvQmUyM3YzcTVZdkhTWUh1RUVhNXh5R3ozQzJ3RmhMVFozRlhWRVU4?=
 =?utf-8?B?UmdNS2VVSDBmSnpNVTM3WWIzcmY4R2tHZ3dpMlRVaSt6VURhMXBkVXc3Z0lw?=
 =?utf-8?B?ZkhYOUdXWXhiQngwWGpkWlZ0dVRNK1UxM0tWczRqcDczWitCQlJUaFg1RHVM?=
 =?utf-8?B?M29IK1QxcEdCRFZVSzd3TURFZUt6MlpSMGQrWVE2a3ZBeEN0U2N6NXljU0hH?=
 =?utf-8?B?dHd4N1BPb3hVQlFDUVh5c2JHNE5OcVh5bE52MTJXRjMxRlZDRDNqWTRRZHdC?=
 =?utf-8?B?ME13SDBudllycktPcXhPQ0lSUUtPanFhdUozcllwUTMzMUp0WTlJZXFQSHJo?=
 =?utf-8?B?UThnUi9DOS9nRkxlQWVCVW5nRmZxMkorMFdVQ2d6NlJpT3lNaHorQnZPSEN4?=
 =?utf-8?B?WWJSWUhJdjZ2M2QzWVZlQzc1RHVOd1JMTUJlSFhOYmtNaFVUcHlhQlgzT0ty?=
 =?utf-8?B?a1ZaMG5SdlJvYlN2TTFnUkRIaHVCc0FNUkNLRGM4aDh6Y3lsN2xQU08yWTZT?=
 =?utf-8?B?d2VyWjAzeDdaWklyV1lRUm5sQ1dRbG1QMGVKU0xDdWJOYUN4eHJEMGl6Tm51?=
 =?utf-8?B?bHFCUnVKMURORFFzWkZkUWFWRWpESkNtc3VSNkFXdElVR3hsVXdVQ1dxNWw4?=
 =?utf-8?B?S2dEU0diaXpkOCtFdytnSGlLU2dOZUZUV3Jmemh5ZW9JQXJ3TmhZSDdsdWV6?=
 =?utf-8?B?UlQ5aFdHNE5TT2E1UmN6Z0k3YjY0OEg5aTJNclV4MjhKY0U5cTlRZFl5MXNm?=
 =?utf-8?B?MmI2N1NVMkxuNzlSaEtIYXVGbmNxVkZ0OGMvSnBmNjlsSDRkZDlaK2xUYmJp?=
 =?utf-8?B?Q3F0eVcrSEoyNk03RThobk1PVTFKc0ZaNGxoMytPeGMwNHVQSzBrNHJyem5j?=
 =?utf-8?B?anZnak1vVmpWcElobFkzbFFKTXllSzR3L0haZmovK2hNRTBFR3pNRGEvK1N1?=
 =?utf-8?B?TXcybGx6aFpGaitvMUVBRFR5aUdvd3VrdXlXT05FMXphUGhQS3FmdXBQeFV3?=
 =?utf-8?B?enp3MGxLU2Uzem1hYmtreElJZG14c2hqU1lVTjNneVJHNEt6RW9PZXF2REJM?=
 =?utf-8?B?Vmsra3F6TGJ5NkllWGVzOTlDUDArKzd0ZjZtb2E1SXZDamR0ZDc2NTJTdEpB?=
 =?utf-8?B?c2xjYlZvWnJzOGJ5RkswR3JLZWFIUXFvU2VaS1B3UEZkeGljakZGZEwyNW8r?=
 =?utf-8?B?ZjQ2ZlJRaFB3Ri9RS0FOTVltU2VNTCtoSTgrbUJPazVEQjNNYms0dWE0ZDhO?=
 =?utf-8?B?bmc4UHhZaVg1UjhyN0tTeXVkS0RzYk5LdnovVXlrbzRVYlRlZ2RiOTdYdkJZ?=
 =?utf-8?B?NzFWQTZJU3Qwd0NWbGJsbzB6M3E1NmlMZDBMa2x0aTlQWWpzUGc0Um9BdHRZ?=
 =?utf-8?B?ZXkrN1AxdUcvWVVvR3MrQWh6U1FJb2VBOGMvU1VkWWRHME9KRzgybElZazFS?=
 =?utf-8?B?b2RuS280b2t0eThDb3RYdVNHY3BHb0hXdlhPZkFpcktVVS83clRibHVjckxH?=
 =?utf-8?B?LzZSakg2aEIzZHZNeGQzZTh1Q0tHbEE1RHFsdzkvTTErbFlYQnBmVzFNbjZz?=
 =?utf-8?B?NlhOTy9kdHI2azNZWkMydXZ5MzJ1N2N2V0NVU0hMeUIwMVl1eExwdURYeTN5?=
 =?utf-8?B?OU16cS9RSTRiZ3F5amdtWUhnUnF2bTFCV0dKdlRJaU5ZcE4wblMvYWQ4RXNr?=
 =?utf-8?Q?omP6pV3a56uMClI12s2wO9dmo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cc3a4c-0ba6-4ae6-843c-08db4badb058
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:09:16.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmSgrDqsbDUP0Umdxk8pS2ZlQHU050MgC+sT1PI4u9vRGs+8LeSUMO7J3G6dwxNi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/23 10:06, Krzysztof Kozlowski wrote:
> On 03/05/2023 10:02, Michal Simek wrote:
>>
>>
>> On 5/3/23 09:40, Krzysztof Kozlowski wrote:
>>> On 03/05/2023 09:27, Michal Simek wrote:
>>>>
>>>>
>>>> On 5/2/23 22:13, Krzysztof Kozlowski wrote:
>>>>> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>>>>>
>>>>>
>>>>> On 02/05/2023 15:53, Michal Simek wrote:
>>>>>> From: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
>>>>>>
>>>>>> Setting default i2c clock frequency for Zynq to maximum rate of 400kHz.
>>>>>> Current default value is 100kHz.
>>>>>>
>>>>>> Signed-off-by: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>>     arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>>>>> index cd9931f6bcbd..a7db3f3009f2 100644
>>>>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>>>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>>>>> @@ -149,6 +149,7 @@ i2c0: i2c@e0004000 {
>>>>>>                          clocks = <&clkc 38>;
>>>>>>                          interrupt-parent = <&intc>;
>>>>>>                          interrupts = <0 25 4>;
>>>>>> +                     clock-frequency = <400000>;
>>>>>
>>>>> I think this should be rather property of the board, because it depends
>>>>> on I2C devices, right?
>>>>
>>>> We have 15+ boards with i2c connected and from this count I am aware about only
>>>> one configuration which is not working on 400k.
>>>> It is a question if make sense to update all boards (except for 1 and not all in
>>>> kernel yet) to 400k or just say 400k is default and if there is any issue use
>>>> lower frequency.
>>>> Obviously this patch is setting up 400k as default and let "problematic" boards
>>>> to setup lower freq.
>>>> The same approach was used for modepin description.
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/xilinx/zynqmp.dtsi?h=v6.3&id=53ba1b2bdaf7f481fdd878e9c18cd0e54081fac9
>>>>
>>>> The next point is that 100k is default in Linux but doesn't mean it is default
>>>> in other projects.
>>>>
>>>> But if you think that it must be board property I think we should setup 100k as
>>>> default in this file too to make it clear.
>>>
>>> No, if it is conscious choice, it's fine.
>>
>> Is it Ack then or you want me to extend commit message?
> 
> Ack, although you don't need my acks for your platform :)

you spell that properly. But I can. :-)

> 
> FWIW:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks,
Michal
