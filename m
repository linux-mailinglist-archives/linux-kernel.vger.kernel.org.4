Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF52B730F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbjFOGGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbjFOGGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:06:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7AF2D67;
        Wed, 14 Jun 2023 23:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjH/aVVPk+wHCQB8TaR1+oOw8h5/K/pI3U3l4BVZs5lewFFsTQUa2U8UF+ZtDmMkPpk2aiiEpjvtNTDrlu3aKhwUZ8de2kLIOIdQCvKDPyaFKQkvydtDGu68TEFu4dxWwI00iEGO+D0N2wEBDR53hlRN1+2VWUvuyztQvDoiz5+moXKOjSJLUIJj2J5vVqiwUK/390MvcxC415SqbtIrfKBsDo4e4d4XV/4yQ2IQOO9l0yDr0YMLXL9j3VDsuATLb5tLmT54Ai6gtWDgh9Mmh1IcgntgSDC3qSiYeNc3rEUQOjt142AhMUlt5Txcw8y+AtWf8RrGWLwlIz1hO1sLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfq7zHKcaylmugKfgIKq1H4ibF0UXtQst0woo2hYm6I=;
 b=f47DftxIvpQpesKe+IwgqmgML08OOxmY+m33aTn45caFNz9D5Je78Zq/DplYqLPC7haR+4N3vgC8j9Ll+RdwhnSb07ozFxZctFcb7i7CSdwPw+qDdN0jR87Zhcv3tW/B5yoT5Qhg/ECugZLyo5ozPPoft/ZLc6ICFlf8+phOsF/ZxBhJwIPo93qZV7vOmhJfb5FI/HPcTmhoDnqOrqxa/P0LC6bmpmcB3EcWg0sxI+XWRj4Iv7Tcz35ATlSp1kyqnD8wvHhmEwt88IGtzJbLfuMWgg0GSqohBo3kg8roHor659hDl7ixwOaV1qZnd2gvDlod9Kmzob7Ps+SzsZCSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfq7zHKcaylmugKfgIKq1H4ibF0UXtQst0woo2hYm6I=;
 b=x6Rg5f2GRyH17JAN5E5E+CBDoco6vWvgLo5UooczpaEyhHHIQ4/5qBUBNnqygpErFYZOG3t1qJFwejvueyhWLT7a3PaYf3LNtdtCu2nx11B3PPqCowmUV9iIIBejw1h4/P7aznu1SMQDTIV086U2EOWVT/w2Hmfmnrh+Ea5C2Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 06:05:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 06:05:12 +0000
Message-ID: <e63e6d33-6659-b63f-2716-c347aba7f525@amd.com>
Date:   Thu, 15 Jun 2023 11:33:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] perf mem amd: Fix perf_pmus__num_mem_pmus()
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, james.clark@arm.com, alisaidi@amazon.com,
        leo.yan@linaro.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        maddy@linux.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230615051700.1833-1-ravi.bangoria@amd.com>
 <20230615051700.1833-3-ravi.bangoria@amd.com>
 <CAP-5=fWkzHufJXV-iRAGifv_z11AOc5LKOyL-QvYL_N+gSPvzw@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fWkzHufJXV-iRAGifv_z11AOc5LKOyL-QvYL_N+gSPvzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: e9920172-8fc7-44b8-910a-08db6d667ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDA7PqSibOJ/WNv/d0txekcRXsfVsXisleaaS0N7xE4ipFVTaNxBIFVlfAeyOcq+s77Bam6DPFx8VHzfqzGkaKRbpfgXjkls9idL3KXqR85HuJR+nKHAy/jsLJudYIIZDhiHfe2A+Ig55qed0vSKVSl4GiBCJZ9jO/Cn0zXaVUvz1rBPBUXZHV2ItlMvF71a3TGVHTJikJXM0XF/pfY8s66xyn5udJeT2vqggxI9TXG1QEtVMB8T4YvTIWBmJKMNc1wryfadmy+BSxhiK3eHG8Lf27t2c7lbmspTPVjK9kXeLyVX+c5DHaDUXsVTcr9HLt9MQ1J6NGWV6zhdpfJq6c0iFh7I3Qc4uZC8d+sMbNxU4geLmtUW02/EgPatCw05sWKPr1CGS2eoTMfC9CZnK/L9k/L5w6gDbLkUpRB5CJc0R6YA8jTGvKkns8zvWKAdaKrGCgq7F7AOPH/6Q71IyW2EPhvxRYD8uHhpyxL4P6AzvOJtRj38g5tAa7vxDlfESxYPrRV9DSA6lSSDbSqMZUhAAAz8sascQzCUdto2CD1pttIpCV0nBwXMVtV5TGlgx4VCu/xQ5aWl4WVK/WWJM+aLOXTYiXsHdmp8ozwpvr4yCsPpQEf1YI8am2xRnRVvwqCi30P9yfdg00oN3cKdnsQHCqQNnJ4EGy4Se54rGd6e8jXKQk5kHml39k9P4/rd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(5660300002)(38100700002)(2616005)(6506007)(186003)(2906002)(26005)(6512007)(7416002)(44832011)(478600001)(66556008)(6916009)(66946007)(66476007)(558084003)(316002)(6666004)(8936002)(6486002)(8676002)(41300700001)(86362001)(31696002)(36756003)(4326008)(31686004)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzJrY1o2SE9mS2pRaVhQRHYvNUY0WUFxS251YmdxUzdiSkVjQXdRSE56Ymg0?=
 =?utf-8?B?dlphckhzNWJhd0pRTlZmcFgrWlQ3cDNaT1ZKUXBDZzVPdUdOZ1NHQWNLVDdm?=
 =?utf-8?B?NFZlRmRJR3JvUWJHMHduTEtDN01JcHJiOFhZeGs0a2taL1pGbVVWSkJvZk13?=
 =?utf-8?B?R2xNeDdYM3RBMnlXNW0xWlJGVjlIaEd4R2doSE85UzN1VCtJanlLOGJNYi9z?=
 =?utf-8?B?SW1ybHNCcDVQVWUrOEg5alFCcGRBYXoyZ0FPanZMQXFmajFrY25ra3h4SFNr?=
 =?utf-8?B?YTU0S1pWenBRa1ZIL2xLMUEvWTNlZ1VKVjRVakljRlhzdDhwOG81blVBYnox?=
 =?utf-8?B?eHJaSFZpMTlscS9GR3VkMHMwUXFqYWFlT1EzRWpZR2JCUVVjdnA4UmJTWDlF?=
 =?utf-8?B?Z2F0cnAzYmpKeTBpT3ByR2JFVnVkMHdobUhhU3h0bGY3LzVib2lpZElGWFdi?=
 =?utf-8?B?ejhsaEhsM2xucXFyWXVKUTQybXpyWi9RWnNpSmk4anY1cDBuZjRyd0FrelVu?=
 =?utf-8?B?TEwwbkhYYXpsQTJ5NStFcUhDVWJadGxTL2VxY2JTSlJkNmJDOHIzMWI0WGlq?=
 =?utf-8?B?NHlLSUJjRnNwTjVPNHVRTGtQUm1rYjdNZUVqMXc3SWRpSEw0OXIwL0FreXhH?=
 =?utf-8?B?bVVIbGFBYlp2VkdzRjlkeWllUmlQMFd1R1d4N2d2ZU5NQ29NaGYvNGtONGVp?=
 =?utf-8?B?a0cxZVlJNGJJN0s3QVRpRk1MMjFtTDZlcVp0QWkyY3ZmTElZakxDTzU5UzJ0?=
 =?utf-8?B?bWZrT2crbjRSRFZZL2JFd0dvZWpuUm1FdElqWmRiS3dSUmlxVDNVdndoZjBT?=
 =?utf-8?B?K045Zjg1Q1UwRnMxSlVqZWdoQ1RRcmZOMmdNR0o2RkhOdmhRQUNNVWVKWTkw?=
 =?utf-8?B?OGJGaGd5Qk0wN0lhZ0Y3ZlJKdmNrYXJoa0VlL0tteGZjbGxFbzhjdzJHanBX?=
 =?utf-8?B?VkZTakhseXI0T2lrd2JmWWZrd2FEQ3pUSjlWbFlEZDc2K1YzTURZblVRdjJj?=
 =?utf-8?B?aWptWFNXZlZjMWFQSm9wODJsZENEaEtGb01malVrTUZLeUFaTFJzd2JUTWNQ?=
 =?utf-8?B?cTFEUXNPVDNwTzNVU1hjSFdQYUlXRXE3Wi93SWhIeTZjUzhNMWxIRXBlSEUw?=
 =?utf-8?B?Y0IwRjhZR2QwNTRxajF5REhVcDdGK0ViNGc1SFRhT1N1amZyYnd4MG8wRGky?=
 =?utf-8?B?UW1OaVVKNityZXRNTmtVTUYyeUQwbEJQbmZQRHBJNk9zRFpqNzlINFpsaFBi?=
 =?utf-8?B?ZkRBR2tQVmVPTWNNeXpiQit6dk1GUk92UDk4NDdVZjk0K0E2a3NHcGZaS2ZO?=
 =?utf-8?B?MFZ1ZEFBQnFFSnlmNEkzY1BTS1E4dHF4MFdrSzBGT1I2Kzc4K3FiaFBYU0px?=
 =?utf-8?B?dXpBN0ZHRHltMVJmckdITm5haHZzaEg4VFJoV2hPQXZ4UlJzaHQrYy80Y0k5?=
 =?utf-8?B?c1hyTjhzK2UzNXYrR016SDg5MHBRZHl6WTFiV0VnNlRUQThIRU5MYVNMVW41?=
 =?utf-8?B?VDloS1YwSUVXNEY3c2dyTUJ4YnpKd0gxTEVYdXQreVNaNU5KYnkvM3JiVG4y?=
 =?utf-8?B?c2czcXZRakJaQm5OdlNCc3RxcGNXZVdVVThKOHR3NXorTU8zR3dITUg1YTNp?=
 =?utf-8?B?Z0p3WjNXZ3ozYWV5cnBKWkxwSXdJbWZINU52UFZoaGlKWVRaSU5jZ1pFcEhE?=
 =?utf-8?B?OFdLU2FhR2lZRVJxUmZsK0kzWHppeEhmbk9vV2FRb1dQQ2kzTm00QktRUytj?=
 =?utf-8?B?bU4zTGhnc0VVUXdWM0Q4L3BZam5hdUNiOUdWbG53bzhJU2xzcjJMYUtLRDB5?=
 =?utf-8?B?UFowdE9lYUMyZnR4WDJXRjJsSysvdlhxVXVWZGROVlBLcWQzayttczlNNVFX?=
 =?utf-8?B?TVErZ1JxZHFtRS92aEt6V2RlTzV4eUNEYjRPVnA3SnpiY3djaXhaeWVJSVVx?=
 =?utf-8?B?TS9BTDdCODdSb3BXaGdoM2xOalp6Qm43cWxURzdNVGFJZVNKVkw2Tms2UVl0?=
 =?utf-8?B?N1c1T3ZNNkpWYTBrMXNnclU3c01RN1c5aTVMTlBFby9DZEkvSGNCWWtrZFNU?=
 =?utf-8?B?RGZnZnpyWld3dGF2cWxaVjVBbXJvbjZaL0NIWjJFcXRETVl6UDRmdXlyWkhz?=
 =?utf-8?Q?n23QPinaw4ZP4YVS09Mjdkgd5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9920172-8fc7-44b8-910a-08db6d667ab3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:05:11.9888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8urhlt91bderhmceETYaGrxc8Pj+neuGeV1JzxwO4V8yV1b5NUgWCfgcxWzs9DAN5XYGJUX+ciV35b4YElsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +int perf_pmus__num_mem_pmus(void)
>> +{
>> +       /* AMD uses IBS OP pmu for perf mem/c2c */
> 
> nit: could we just add:
> AMD uses IBS OP pmu and not a core PMU for perf mem/c2c

Sure.
