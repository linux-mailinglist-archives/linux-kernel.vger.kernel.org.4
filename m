Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19F07222DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjFEKDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjFEKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:03:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFEB0;
        Mon,  5 Jun 2023 03:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUFxbgil5U3Km/uolX+Gq9gX+IYoZGk5udMfkoT5BhwnwEvwesccEb5vjBY39mZVOh1k3cg0cF7CRv5LNYObHJ0+toz00R/bq6Y5GyLggrVPz5odxx4LlPpDcN8UAYDOtMNrWpTzL9t0/NvXrf8HJ6k0aFDxDFHh+B/lz7W2W98gfrNDKoFkZUJYIIQSjprOnAf4kwOxFMD5io/EtWJE8vdZGJwIVPT6LDV2b0wEJrPG79OkODc6jLYQr8wlOlmDIQUzu/PCp/ytOz0kFV4fn6oG6LFnLvpM/LfVD4128QmCHq7CsZ1j045DD/P0PKyEKHjIdQuXFxG/GgZI8ONsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP6KeQg0oQ7Yd+Ae97a/PSkLzjbY9a8qhIZH+v2D4QQ=;
 b=bgHR0jIOjlostufqbEQBHEpwAxzp+kr627lC3hStPgLg3kwf0Kgx/jmCZ86LY+XvS+9gigF5LIVdJzSdkckEDJb7gKwxMfQ6hVOnltTtLMl3qBq5d9Yg66WUij+A5aFnTELnbV2cl1E/TF+IBn09csU/niGNjj78hMNF7Ih/6av0JC/OD6d6XHWarj7RyQz+tzSzLaySi1DiBRwLQ+Jmqnf07tIRA2+RoM3DLacPSdKrPXZ1J0JgmR8fPRATv0pQ5QFZ3Hkh0vMDMPJEGSmy/3RW1bCQOn3dmzDiCoKcoJ5yVfI48Q4kI0L4V0mS/2hG3RLUhayXPhMfDM4X5emUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP6KeQg0oQ7Yd+Ae97a/PSkLzjbY9a8qhIZH+v2D4QQ=;
 b=OuTC4Ode2Lv1j7aPjERTqWSBV3C1R291uv/F35wrjI3HDme0KEZQ36dWplPyjQM+Fc8xEnwViaJZ6rrANsDKXBDvphPz2Oj8vLiRBmfJHeoQa+8zVyz9vS+Hy/tnCBColN9jRlXR92Yic8aNViZ+BZJ5yeBWrvv3GtZUNfwjORw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:03:32 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:03:32 +0000
Message-ID: <43e59aee-dd94-0b95-25b2-dd6d14bd7c7a@amd.com>
Date:   Mon, 5 Jun 2023 15:33:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
 <ecc69e40-f975-69e8-a372-6aafde66e0af@amd.com>
 <ZH2w0hIAEIpEXjk2@FVFF77S0Q05N>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZH2w0hIAEIpEXjk2@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f82ec8-c6ee-45d9-274d-08db65ac1e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMWt013KV6doBXN0/R0uaqXFED4NFvKiPohLPPIRgbpWLDm95N6+l4sgzgDJIYge1RCVjTcTSjWXbz8XsoALDS4R4UJVJ808wpZAyR4D3WZa+QUUzufRNOujzuRXq+HFp/I2+oEwE/zBCnoog5I2YIUlu7eMECCaaGPoxm+PxnkdtvOmIqZv+aGHdrQkDcqrn0UKxWfALBaiG1ag5fgreJ9mwhE9f0uzrtDK3gjj9a4IGlVongtms8vInODLsj2GJVpVrxcq8E6EfQ4ky9FIGXXgb+rBgZnmfXcIxnABZtLeqz8/6tbjAftD8FtdJnfjYgw8EI1Nv5/FIzVfJgtn8KvnZRwFW90CoSik0x1op2R8z0wkkuAn/MOhN3yuksuQ7J5ewk46hlgmw0LqykpxCqIVkwiW9Gy+ae/gR/OxGaeJCYnJBG9WM2rkKtm4QiuZW7RF73zx0JNL2/i9OA+/l0xeiIoLRem6zkqQ8AkZDgNmzXzhAGqb3OQu6G3CUPwBWf0o2XyH4aIjAL7qNxWeL+s+GNBcgNEkofic4bryYO/S8x/8yWeyXob1JUuseWt3Ie0Dpn0CrLhSfbguU1FgByYfCBDrXkYy066F+3s4MLmhcd4oGJcbwWGpSBSkMKO+2ATiUaJjOcyZDMU8hIBDTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(8936002)(8676002)(478600001)(54906003)(41300700001)(5660300002)(6666004)(316002)(6486002)(26005)(44832011)(7416002)(186003)(31686004)(4326008)(66556008)(66946007)(66476007)(6916009)(6512007)(53546011)(6506007)(2616005)(83380400001)(2906002)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZtTTd0a0IxeGRsTEVFWDdYd1VrclVESy9aUnVmbGF0Mjd4eXlrUUFhbFd0?=
 =?utf-8?B?bkhpY2l1VUQ0WFllK1BnRkx6ZjJVNVVoUXpxbHNxcnZCdWZDSlFRVW0zRTdQ?=
 =?utf-8?B?dTFoQUR2bTFqY0k4NjJnRkhnb2VYU2c1NkpBN1RaZ1pvaUtVay9CNVozOHZL?=
 =?utf-8?B?bENKeFcyTDQ2Skgya1VFUTlINUI1RElOc242TFkrZzRpVGZVSldkVElMMnQ5?=
 =?utf-8?B?YnloVnM4OVFTMUhNakhWV0IxQkpTSXNaTVBOVmRJRWYzYjdGTllnM3BPYi9q?=
 =?utf-8?B?ditoYllZeXAvUEdudEEzUmI1Zm90YkxkOVlWRElhVjJsNU5sQTk1dkNtV0dK?=
 =?utf-8?B?djZVTXlTME5Qd2djcEY4NVpVM3VWek1HVGZ4MnBxSy8veGl5VXpYNzYzM2tP?=
 =?utf-8?B?bldYWlJBaSs0R1Nzd3IvQnBPN0RMbzFXM1h2Y1pkMUxqb2VET2NvcjJQaUVa?=
 =?utf-8?B?bTh2OTI3NU1OdTVWRWdIZENoQjBFS1BIbFZTeG5vRTcrNzhVbVV4S1hLM0Fh?=
 =?utf-8?B?UW5TVVI4cDIxQ3p1OHZCS2Ewbnk4bUxTMFIyTU8wQkFqZndFb3hOMTBqK25S?=
 =?utf-8?B?RFYxN0JoTFJvZi9HL3MzRzRHY085c2JZeEl6L1NFT0M4QlM2N29SUFVmNFJ6?=
 =?utf-8?B?Um8rTHVsQ1RRSVVhV0tXT2w4VVNEWGx5dkl0ay9mK21tMkJWbmNaSW0wWDhs?=
 =?utf-8?B?TGtQM1dGSkZMbHBISVFHVmVmMDJvWi83MEhlSTJsVlpQeXMxOTE0Q0RYdGVM?=
 =?utf-8?B?MUU5bEtWckRMWmRjYnlxY0ljT2pmL3F3NWxzQ3RqeENQUk9paWROeGZNZGI1?=
 =?utf-8?B?L3VqbXZpd3BIdENRU0VZRityakF6YU80S2ZDeElDcldTS0hhclYrZ0thNUw3?=
 =?utf-8?B?TEh3cUpQR1dCMVZnZUswcEE2NlU3ZlhIK01FNjVJYzgzRzlsd2l4ZkJ5aTNy?=
 =?utf-8?B?eVJ1ekIwbnNxODJNUWRzOUw3Z1hySlhBU0pZSWYxT0dqLzBEVGpZblZUVEln?=
 =?utf-8?B?MjdJTWtPSkdKVk5FUUZ5bVBBV1FGVzdGZHZlVVBkRHJPdHhKczkvekZGMS85?=
 =?utf-8?B?alRxdVVjaTVHRzFPY2NWOEhQcWtuWVRHQkZ2Q3VWbW51NWNrUWV6cVo3MXND?=
 =?utf-8?B?Q0lVeml4N1JQWkZTOTZzYndpL2E3d3JBakFnRmZtVURZeC9nUC9qYmIzZG83?=
 =?utf-8?B?MXBnNkpUVUx4cm9vVkN0dldMNFlyV0NRbDBadjZHazdyQ2pvRkxoZ0tyNHJt?=
 =?utf-8?B?UHdZakdiVDB2a1kyd0R5L09WOVhnS0VWVk55aFVOUnRKc1NMS3E1enJXK0FG?=
 =?utf-8?B?ek5wVS9JeW16REREbDczcnV3OE0xLy8yWFJ0bWc4eXlCcWJtRUtNa2lOUXhU?=
 =?utf-8?B?eDYyeFQvSXVvYkszUHNTNE9IejZRSTBnNW1xY2pacWpxT1JkdmNuVExaT0ox?=
 =?utf-8?B?cGQ5ZzhjSG5YWC9sQWxpQ2U5L1BFZC9SK1JOTXhnd1g5c3JubHpkdVJXLytB?=
 =?utf-8?B?ajN4cVdwV1NtQzEyejlsL0t6S3QvZm9HT2s4YjBPRDBseXIyY2wzNy9kK1dY?=
 =?utf-8?B?WGxjUmh4bVF5QUgwY2Z4YXV5ZUpjMEc0eGczRUhwbFVrUTF2VkpUVVMvVURz?=
 =?utf-8?B?aEhBaVFiaWFUajVnNC9WWVBqbXpEUDkzblJ4bFIzbUFjNFE1VFowYVV1YnZF?=
 =?utf-8?B?NGVXaDI0UzRaVEpTMUhNNjc1ZnBzRFUxaEtsUkt5OG5zeDg3WXRQaHh2a2lG?=
 =?utf-8?B?UHNsU1MybE10d09ZcTRMU0hBSmRlUlZhamFZYjZOd0VWWk13aHZ3SnVTQmNi?=
 =?utf-8?B?M0FBdzhZR010Vk95NytoeTUrblJZYzdtVmhPUDBmWVU3eTYvYjd2dm53QTFq?=
 =?utf-8?B?K1hDOEx2Tkl3WXU0a01XZURiYUh0SnNscGIvMExpZEtHYXIvemRNdzcvRjFT?=
 =?utf-8?B?cmZJUm9PSG5Dc2IzZGJjSS9HM1dFSytkR1IybWhGbjdlSmlDRXpHUzAwL3lz?=
 =?utf-8?B?aXQvbVBBTTBHbjl2MU1jVFhsaFN4T2Q1T2J0ZU5wNU1IbkNtZTZ6M3MvTEVY?=
 =?utf-8?B?MHQ4cDdrWi9YTUV1bjk4OUdRNnMwYXFYV3JhcFJ6b25qUHpLRnJZcXZPLzJL?=
 =?utf-8?Q?15zCrH6vpzRvEpraA/eZ/ZU59?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f82ec8-c6ee-45d9-274d-08db65ac1e44
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:03:32.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfaaHJR8NzLhSy8EqfSDXkqsUOZIu3GTeau1cNq4BGGkUOwz6SRMG07xkl0MQRnMHuVsILBMihfX/nNV5oN99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Jun-23 3:24 PM, Mark Rutland wrote:
> On Mon, Jun 05, 2023 at 03:04:45PM +0530, Ravi Bangoria wrote:
>> On 05-Jun-23 12:40 PM, Mark Rutland wrote:
>>> On Sun, Jun 04, 2023 at 01:38:10PM +0200, Krzysztof Kozlowski wrote:
>>>> Hi,
>>>>
>>>> #regzbot introduced: 9551fbb64d09
>>>>
>>>> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
>>>> searching code") as first one where all hardware events are gone from
>>>> perf for ARMv7 Exynos5422 board.
>>>
>>> I think that commit 9551fbb64d09 is just wrong.
>>>
>>> The commit message asserts:
>>>
>>>   Searching for the right pmu by iterating over all pmus is no longer
>>>   required since all pmus now *must* be present in the 'pmu_idr' list.
>>>   So, remove linear searching code.
>>>
>>> ... and while each PMU has *some* entry in the pmu_idr list, for its dynamic
>>> type, that means that events with other types (e.g. PERF_TYPE_HARDWARE or
>>> PERF_TYPE_RAW) will fail to find a PMU in the IDR whereas they'd previously
>>> have been accepted by a PMU during the subsequent iteration over all PMUs.
>>
>> Not sure I follow.
>>
>> PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE are aliased to PERF_TYPE_RAW in
>> perf_init_event(). And PERF_TYPE_RAW should be present in pmu_idr if it
>> was registered using:
>>
>>   perf_pmu_register(pmu, "name", PERF_TYPE_RAW);
> 
> As I said, the PMUs get registered with a dynamic type, and there's no
> registration with PERF_TYPE_RAW. On arm/arm64 systems, *every* CPU PMU gets
> registered with:
> 
> 	perf_pmu_register(pmu, name, -1);
> 
> ... and *none* are registered with:
> 
> 	perf_pmu_register(pmu, name, PERF_TYPE_RAW)
> 
> ... so those all get a dynamic IDR type, and nothing gets placed into the IDR
> for PERF_TYPE_RAW, etc. We rely on the linear search to find a PMU that can
> handle PERF_TYPE_RAW, etc.

Got it. Thanks for the clarification.

Ravi
