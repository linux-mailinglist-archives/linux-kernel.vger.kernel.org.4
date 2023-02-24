Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8256A1572
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjBXDhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXDhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:37:07 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A46A75
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:37:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7s7e+aW3pC6pwuHCedY1ncZSJzZ7vFhKUPM8gwnWUxE8paMCMCpZS57aVihRF7F/BwdynSKPJwEs4Y4rMz+/NTBX+QBxDp0Bdp5V+V/+gaPV1tBaOaD/wW9vFU00AAsGw3G2AwOvPHu724QRpUKjdjsE0ffNHgk1Cpy6rFG1ZVZ9Ar/uhLQdv6sm50qgOGaJROJ13nqbRcPUwm8UlPW8yPcTHKGaIaFxWcBTIZCR664k5BchnW3AGJMgLqKRYNJI8qlz9PBtWzrCg8u37V7sdShhShfcEvvch7bD5mXToURelJNxcGqdYdxhnZWqnxTNeVHfyW4Cr9rVrBqvsA5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGB9m/YkfFSKUs2SZKJZ04Ms9edPjve1hqb/7GZpwEY=;
 b=AJRivgrj9/ml0Bq/SVDR4PhzvZhe0ASEiCA/PBCR6+niXn5UGofzupzMWv7KC+11MP0MI8WeKI9cIwiGUHUvDE7MWvcxFq7En9SfEU3/w+YDXqNSzDp86YlcXW2r7/0rTXnm3p1+chNYmxJkoid2T3G4rKKqcLDuj2/7KZlliXXoN8SU4aypWBb8CuLnSQ2Fj+nzWYwh7crRAw49FCNP/m4LJxZYwRZ+R2LJVsaIfFgPPlx4v+cS/qgi1eNc0ro14Ru6WhKUXuyiGWTdXWAfB87KQf/T/dd5eCjheuEKnfytk8BwDTYHbhTvpX4c4+2WaFduRJEDwNI6bgqxoo2LOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGB9m/YkfFSKUs2SZKJZ04Ms9edPjve1hqb/7GZpwEY=;
 b=QMJbwCafv+y/mi22ITcdzv2h997GLBoMdf2Y0/RBDaY8kPxDmO0otIwbJI8CSIf+e84+t9JSIfO8YkOpQjz4I15BbDj7UaH1vc7iay2aEQFyq0PtYsYyWej0XHLU6xQcUZWXxGNGLJh9RDoGz1KqPj+xtxxygZ5rnj/4h2TV97M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 03:37:02 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 03:37:01 +0000
Message-ID: <8fea74ec-8feb-1709-14f2-cecb63fdc9ed@amd.com>
Date:   Fri, 24 Feb 2023 09:06:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, tglx@linutronix.de,
        yue.li@memverge.com, Ravikumar.Bangoria@amd.com
References: <20230208073533.715-1-bharata@amd.com>
 <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
 <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
 <c3e79d2e-97da-726e-bcaa-0258e3ddfafe@amd.com>
 <87zg9c7rrf.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87zg9c7rrf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaab5fe-cc23-4559-6287-08db161863b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jqLUJT+xSMbBF+mJ94ej0FrlTRdHti5k2nao+6LO8lyKbDh+NREH6INnqogx2OF/8zBPFRF0F1/FnrKe4qjzPcxpqjTWUMCPSEHydm+GOs7+OlRabxWgfT9i0TeqIYqDJOEDUZL84xuSX8rGOyh3d/ydZqs+0pUDZmT0kg6JEm1uOKwc1RX4FnhuwfTMeSzsLN8m4uRHvViTwfGf/Lp7NwwVwi5bvROC55ySDKuTxojYBOyCDxpxJCn4fEXBCIitW06Z3EVIU+cdtGlbhAw1eZpkd0L/WUrSZjtiLepgN4hihtHYL6V4m1wDKrjAQqQrXiErq61/9CK4qceKCZQtz8AWji8Lg58g3JRhJpuqYrqtDhTSOlqv4jaUEmdgHBZDFvT0BHDm4ptkM2tTTHlS0D4JHZw9d224KPHdHFv4XAzvKJxMNGqCinrXTa9CDnMzW44x0HIrlYzEE91gHs00dRBEcrnGtWkvj/f/6Z93LEB7R7AiWXf61DN3Z+KHJH7OpmkojL21J99hvqrGmVg8KFRWVSD7wwpg9u6g+FBJXJFtg+CAwcY7nrT9fouL8sH4Iht3GySIMej2aec/emKM/Z3Pe0uyYE3EV4pi36ZunHpKR/GIP8ZLY+JJv553dCoM+rYZlncqkcZUrxfmj6jJcO05N1Qkwz7BExyS+BFruITGeCV5pfXcIQY1mI0Y+RvYv0cxvzb76w5OhMcP4hJBCwsEuy+Onb2cG9ZXnVnQhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(7416002)(2906002)(86362001)(38100700002)(31686004)(31696002)(478600001)(6486002)(53546011)(26005)(186003)(36756003)(66556008)(66946007)(83380400001)(41300700001)(6916009)(4326008)(6666004)(2616005)(6506007)(6512007)(66476007)(316002)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNjNkFucGpaT1BuL2Y5QUt5dmtGRUhlS0Z6amJodm1oZSt6U1J2Q2lQcXAv?=
 =?utf-8?B?QlhKaktDcldRcVJhbitJVmlvNUs0UDh0RXBPRzRST0FRYkdwMlFneXpPQmYw?=
 =?utf-8?B?M3BkUWo3NStNeHBXcVVORUFpMFpQTWwveHNGZlY2Zm44RWlzUHRrak91VEdy?=
 =?utf-8?B?NXJTODQzWkZjN2xqTDYzRGkweTkvVTFJcFloZEthSzdab2s2KzJJaDhNVEMx?=
 =?utf-8?B?cDZmSGc0ZzFFT3JZeHVDdEY1WXpYWk9mczdpamx5dnNzL0lHZDRpV1huZnNR?=
 =?utf-8?B?dUdoazJBM1VsdUIxc2h2aEhreS9DS2ZobXdpSmlSOTR5cWhqMDM3NVNLUVJP?=
 =?utf-8?B?dlJuNWVBUlZNWCtGcHBMV3lWOUxSa2dpbElLSWFPQVNjbnB5MkdPVFRyYkRM?=
 =?utf-8?B?QnJLSXZncVhKYlJZWEc0b1labFF1R1E3a2NZTFN4dk5pTUtIM1VRT3pXQWdN?=
 =?utf-8?B?NGxleHZLb29wUlBZRVBjaUtHVjgyQjhjZ2JDc1FJM3RHMzFxdnY1OCtUQ080?=
 =?utf-8?B?eGJxNEFCaHNFTzduQklsVlN4cXF4QnQ5YURNQ2RIWDE0ZUhwanFhRTJLUDBy?=
 =?utf-8?B?VzFmR2l5aDErV0VzV3g3VEYweHFmNGMvQTVMMGsydjJ6MzYvRUl1MzB6RFNN?=
 =?utf-8?B?MU5xNld2bHRscmtKWTA1Y0JuWGZCWE9jL1doMTFtZ0dYOEVaYkNZT3Y4bGJ4?=
 =?utf-8?B?Y2lnWFR2dlNDUGdFVk1sNnFVSVBuRGlicElhVldSK3pqY202bnFnRSt4TmVH?=
 =?utf-8?B?eDloTU44YUFnQUY1R3FySjFJV1ZyalNBM0trbWdMTFcxbHNBa1loMEt0Z2pm?=
 =?utf-8?B?b3Rrd2dNZGljakF6bzF2Y1NnUnYxVmdWcmtHTnR6Nnl4L1Vzd3BNWkZ0SHRP?=
 =?utf-8?B?alRJWFVOd2JPTWVrTDk5SlV3NUlWNlVDbVdvN0MrdHZkL1BLLzB0RTdXeGcw?=
 =?utf-8?B?V2dNUW1yV1hlYWZtdjQwYzRqcVRidmtZTHl5NDJSMWJNV3N6U3B4dWhURWZD?=
 =?utf-8?B?OTlMQm1sdTBKQ2lvZ1hIY0xuU2VKYzk3ZkIzZWRqbTc1L2RWWTJrSHRld3Ji?=
 =?utf-8?B?L1RMR3RDc0FRYTA1aWQzanFXNWJRS0tmNUthVml6U2diU2RTaVNTL3Y1a2hI?=
 =?utf-8?B?azY2U2d2VUpDUlJVZ3UzWFR6NEkrVkFvV1VJVDQrQVRYRHNzSmd0V2E1TnVm?=
 =?utf-8?B?TlRJNTdtaU9OUjZTVTk5NVQrVnNTQVZwd0lHcVlwUjN4UGxkdmx4d3BraFo5?=
 =?utf-8?B?SXBOQlZDMksxR2lyczZiSXROYnp1ZlRQUWEyeHh1eU1YZ20vUlFMay9yV0ZI?=
 =?utf-8?B?ekp0RXAzNDZLdWxGQ2VwbXRZR09mc1ZpVStlem1FZFNJNUJpd1BDRHpwdUZT?=
 =?utf-8?B?eldEQUY3MmZnVlo2OVhobVF1eFo3bnE5QkJzeURTeUhPMVc5cE9IdDU1RlB6?=
 =?utf-8?B?a3BMQkpNKzF1YTVDQkV1MHZjdFhLVm9pb3FybjdGU1MxdkxnbDFaNUsvV2NH?=
 =?utf-8?B?Y0oxUnpOc2l3KzFsNERkWHdTbHg0MGtYMjl3NWpCeUJsY3FiN04vaTVuZXp5?=
 =?utf-8?B?UElZMXpRRkFpUE41Uk9EVDNBaStadytrNDROQU9NNExHRTJhUjBJb2ZUdW1p?=
 =?utf-8?B?aE9KZEZsN3lkc0tzalNYQ1QvNWJ5UEZJT2dNL3EzZlMwdTFTUWFMcGdzaExo?=
 =?utf-8?B?WGhlblJMMjlCeTZBenQ2YjNNZ3J4V0ZNRFA0TWxFeUdNdjFtNnY5NUgvclFK?=
 =?utf-8?B?VlhLSGpISTlqbm1rbm83UFQyQ3dXTGhPMHN1bGJ4aVdLMzhYZ1hpQlJWRnkz?=
 =?utf-8?B?cER6TE84ZWQ0TUs5RVhiTXRqZjVDVlhFR0lhbDZRNVdLNk55R25KeG5IUWVN?=
 =?utf-8?B?VG5WTFVEejBJT2drSHRhNnIzS2hTYmJsSVV4alRHSS9uR1REZUc2MnpDRmFX?=
 =?utf-8?B?RFFXRTRPem5LclVtbStKTzRlZjBnYURIbWhSV2FpT3c1ZG01RWNqc2VsazNr?=
 =?utf-8?B?Y1M0NUpLUjZDMHhNSWNQRk9EZXQ1T2dRbkVRWVQ2VHB0ZGhHYzBOQW13NlpW?=
 =?utf-8?B?Z3Q2SkRhSk45VWNNTnM0TXhHdXAyWmRxRjVuUDIvdlRkUm1icUo3RXdlM05U?=
 =?utf-8?Q?frrWGN2XffcvdAWHjF61Ny8At?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaab5fe-cc23-4559-6287-08db161863b6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 03:37:01.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUq3gH9swJOwbzUcGKZlkQtSBPUHUYbXA7plRPKzScb47HJaNe4tmsIg7izKgA5gu79iRuUQIPk7i0AQezraGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-Feb-23 11:33 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 14-Feb-23 10:25 AM, Bharata B Rao wrote:
>>> On 13-Feb-23 12:00 PM, Huang, Ying wrote:
>>>>> I have a microbenchmark where two sets of threads bound to two 
>>>>> NUMA nodes access the two different halves of memory which is
>>>>> initially allocated on the 1st node.
>>>>>
>>>>> On a two node Zen4 system, with 64 threads in each set accessing
>>>>> 8G of memory each from the initial allocation of 16G, I see that
>>>>> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
>>>>> to complete a fixed number of memory accesses. This could well
>>>>> be the best case and real workloads/benchmarks may not get this much
>>>>> uplift, but it does show the potential gain to be had.
>>>>
>>>> Can you find a way to show the overhead of the original implementation
>>>> and your method?  Then we can compare between them?  Because you think
>>>> the improvement comes from the reduced overhead.
>>>
>>> Sure, will measure the overhead.
>>
>> I used ftrace function_graph tracer to measure the amount of time (in us)
>> spent in fault handling and task_work handling in both the methods when
>> the above mentioned benchmark was running.
>>
>> 			Default		IBS
>> Fault handling		29879668.71	1226770.84
>> Task work handling	24878.894	10635593.82
>> Sched switch handling			78159.846
>>
>> Total			29904547.6	11940524.51
> 
> Thanks!  You have shown the large overhead difference between the
> original method and your method.  Can you show the number of the pages
> migrated too?  I think the overhead / page can be a good overhead
> indicator too.
> 
> Can it be translated to the performance improvement?  Per my
> understanding, the total overhead is small compared with total run time.

I captured some of the numbers that you wanted for two different runs.
The first case shows the data for a short run (less number of memory access
iterations) and the second one is for a long run (more number of iterations)

Short-run
=========
Time taken or overhead (us) for fault, task_work and sched_switch
handling

			Default		IBS
Fault handling		29017953.99	1196828.67
Task work handling	10354.40	10356778.53
Sched switch handling			56572.21
Total overhead		29028308.39	11610179.41

Benchmark score(us)	194050290	53963650
numa_pages_migrated	2097256		662755
Overhead / page		13.84		17.51
Pages migrated per sec	72248.64	57083.95

Default
-------
			Total		Min	Max		Avg
do_numa_page		29017953.99	0.1	307.63		15.97
task_numa_work		10354.40	2.86	4573.60		175.50
Total			29028308.39

IBS
---
			Total		Min	Max		Avg
ibs_overflow_handler	1196828.67	0.15	100.28		1.26
task_ibs_access_work	10356778.53	0.21	10504.14	28.42
hw_access_sched_in	56572.21	0.15	16.94		1.45
Total			11610179.41


Long-run
========
Time taken or overhead (us) for fault, task_work and sched_switch
handling
			Default		IBS
Fault handling		27437756.73	901406.37
Task work handling	1741.66		4902935.32
Sched switch handling			100590.33
Total overhead		27439498.38	5904932.02

Benchmark score(us)	306786210.0	153422489.0
numa_pages_migrated	2097218		1746099
Overhead / page		13.08		3.38
Pages migrated per sec	6836.08		11380.98

Default
-------
			Total		Min	Max		Avg
do_numa_page		27437756.73	0.08	363.475		15.03
task_numa_work		1741.66		3.294	1200.71		42.48
Total			27439498.38

IBS
---
			Total		Min	Max		Avg
ibs_overflow_handler	901406.37	0.15	95.51		1.06
task_ibs_access_work	4902935.32	0.22	11013.68	9.64
hw_access_sched_in	100590.33	0.14	91.97		1.52
Total			5904932.02

Regards,
Bharata.
