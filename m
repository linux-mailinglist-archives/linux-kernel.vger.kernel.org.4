Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06970FD82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjEXSJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjEXSJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:09:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34BB6;
        Wed, 24 May 2023 11:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyJZ2E5Lo8gHNcdFSJ+AePz+IcneJPYFQEz1EoGSweh6/5Qpvfv9zW+RhwRQK/jgMp1Zpn+TapmSr5xZ3LOSGHT/PMnMogBnr3t+HVvaiTQBHlLbhFVXEK4tSSopWIPz0/F4J1dCrsyE27tveENsWWGwnb4dC6YNFMk5cUKNrPpl+hsNgyJUA0wWsGyz9bPq2Yuxt4cIRSCQqrXzi45MvOc+yt5SGm02K9AzNnou/qXEss8ysn/3H9Y688vCXe9PeizFeX+GxHniNR5yLUjn7xo+LpLAxN20zhUyD1CLtpH0RmmZKhtVsW/6oOLQkIM4tG+e04cO5gxYOMzELU3/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTKbpjUwlmZDZ2jBIa0vIRaiaTDsXUDoUYYPpXWppAE=;
 b=PUn+Wrre3WtB2SivavFGgkvm4UmLA6/f4+ogAT9VhNKYUUlYOHRbRdOsrCHcRz2iZIhKKkCnT9ehVlNqlI+ZNRb4TuU4gFPPmZU60AAVA6ooTllqB4qc/Wl1pwXhlvSthbx+hP9KrX7yoZ7kx4+SCnRkZdfdCan+lBRHs4IkZKlBsnaGj0ptunmRXVjUEDvQR36aWNUfhfncqtcWcVoqVgxuPbVAJRmL/h9ONmEcghOmCEqtjvy4Pasgfq0tsLCPG07lDxap0u1uR/tD1veNY90+cnZLWpgdbLpjtgEE/RRWFxN1wDQ2cvyzUaHVHp0zrokAtJns1Q93ajc/MvMf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTKbpjUwlmZDZ2jBIa0vIRaiaTDsXUDoUYYPpXWppAE=;
 b=Wi6m8HNwRsbcEClnGK24EAb4lBWtgUdRDbCTI+NSIc3wtZdntMK8M2J1xRTEZkOE9bZm6j9eAbzwgo8mrI1Oc03XtbKyKUjljaBzxdOnNBA5x/ueQFl4lUN5MBYdXmrSuEKFwwaQ/QMx9CypmQuVTgihXWwmcxqmoM6skdD282s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7492.prod.exchangelabs.com (2603:10b6:510:f3::6) by
 PH0PR01MB6376.prod.exchangelabs.com (2603:10b6:510:19::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Wed, 24 May 2023 18:08:54 +0000
Received: from PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::e759:5cb4:2706:2771]) by PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::e759:5cb4:2706:2771%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 18:08:53 +0000
Message-ID: <364029b8-3a73-60a3-b875-0d7323dcdd27@os.amperecomputing.com>
Date:   Wed, 24 May 2023 11:08:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        wangxiongfeng2@huawei.com, xiexiuqi@huawei.com,
        liwei391@huawei.com, linux-acpi@vger.kernel.org,
        weiyongjun1@huawei.com, lenb@kernel.org, viresh.kumar@linaro.org,
        rafael@kernel.org
References: <20230516133248.712242-1-zengheng4@huawei.com>
 <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
 <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
 <7caa9878-c910-06f2-6eee-64cc55d8a207@os.amperecomputing.com>
 <0dc000e3-9b85-0841-03c0-3589e2e5d34b@nvidia.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <0dc000e3-9b85-0841-03c0-3589e2e5d34b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To PH0PR01MB7492.prod.exchangelabs.com
 (2603:10b6:510:f3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7492:EE_|PH0PR01MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5e9f99-a751-4c03-47f3-08db5c81eefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7qp2dQizqjx66llHXJOJ5mXGj+OY8x9iF+CLZwbkLRIW7TDloIEWIthd8kMceFs1LcGNjuFB1wHOoi59PbQCgHJ39U44jZJ89O27k1ZeJ1+InQtJSvmE7BKSX6nZINUqChbFc/jtGiZZQg8zFGCjJh2ChSxAJvTtONthRDCycVDWv7bgGn1jT+lnAHe0WWe91+67Tubmf+CnztSYB6XkmZxHujPTsCRS1MFZriD+l4A7JJqJmu7CRHpFO2VC7rHkg68KZhWOOg87DylGHzXHPANW3rSqHSHAcFtwBu+hHfKn68eBqZeqWwllMJQxiOrMCKhoPKv+lAMlnG5AEUXR8UxkXeQmZV+c5z5dvqQufKFe4t/SEqzl2/EDRUQKxkPC1xUr1xa6DoHM34CyYnjf4z4sCEflyEAtcOorLj2CQJ9XJcrhZudknScANtIgC4rf34hQsguN4pdzgCt2Hvwre2YnnBeWtX7w+pOqzMYHfDlX0+OJoaSRBGTVVy08mFawU0kyLZ4l3SJ32XMiTbW1ajFI2mFhMcR/bWhKChyqKl3Lsq15OWW8EU3B6kv2mSxhbvFEGxPXS6NmnbGruXmys1mjH1eIrzlWucvp+hKaAQWxlZm9Ea7Ss64vpUdoN/qWL53o5uNbN/adcEvuYXZDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7492.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(451199021)(6506007)(53546011)(6512007)(26005)(52116002)(966005)(86362001)(2616005)(83380400001)(31696002)(38100700002)(186003)(38350700002)(110136005)(7416002)(2906002)(31686004)(4326008)(8936002)(8676002)(41300700001)(5660300002)(66556008)(478600001)(66946007)(6666004)(316002)(66476007)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBXT2E5bExoSUJiUjJuVTczV1cxYk9WV2xwZlZuSmpvOFB5UDlwNjVTMUFk?=
 =?utf-8?B?b1ZMYTVoRDZibjdSSWFRbGRpY0o1b290V1JMNmpabGs1SnluanRBeU96TjJP?=
 =?utf-8?B?MHBjTkQzajdjREU3QzJoSTZKcHZNa05uMytMd21nU2dITmdkbGJQYkVLNzlV?=
 =?utf-8?B?eEF4NnMvTVZTYWhHT1EzZml6MXNhMWlhS0taeWpRRkt3QWcyVUdLaStOblZa?=
 =?utf-8?B?NEFFYzcvVERCS29BejR6bVFhZ1NEVGEzNUowMkJMMUdpL3gwaUpXaE9XV2Nz?=
 =?utf-8?B?RmNGTlloNEh0WjhYYWNEamNIN240U0c0U1BUdWVrV3dzYVRmWU9xN2xuQ0l1?=
 =?utf-8?B?Y1hsa1NkK052Rkk0SGdDR3VMTXd5eHI5b3M4TnJNUWViQTVEdTRieVF5c3Ax?=
 =?utf-8?B?WkEyWFZNbk1icGRFd0oxSkdBVk03OGRsRmEwU0wyL0wydjdwVFR4YnRqVkow?=
 =?utf-8?B?Q1hpT0h1c250WmpmRkVnS3FqektDb3dnaGhzN0NPdDFHczc1dUI4dGpFTWRS?=
 =?utf-8?B?eW9UN1lHUm9sMzBvcnRsN2V4VFU3QWlTTHFCTWZ2N0FHUHJITXVlemU5ZXU1?=
 =?utf-8?B?OHE3dXZBMTFpTXZJUWZnb29aSDRocDh1RHlPalpnNG1IR05MZUg5TnZKZVl2?=
 =?utf-8?B?OFAzWHFHTlFMVXhsalJLQ2tRZWNQRVBGZTdEcjdKSFpGbGpRQmw2cm9jMjdj?=
 =?utf-8?B?VVlramtHbWFQRUhua2JzQStKNVBod3E5ZjFhQnlIelJjWkpCaWFvUEtVd2h1?=
 =?utf-8?B?ZVRiTjZMVDY3cG92SWQwY0w1ODZKeVhxbEF3NDdmZGpGNTRjQXk5SFlDQ0wr?=
 =?utf-8?B?ejdjSmVoYW1sNHFlOUZJVEg2MXVVNFk1aVNMejl3SzBGSGhpT0tQcDlWVklI?=
 =?utf-8?B?MlZCaXVzeVpCc09McHlPWW1GTkh1dVRzTXZ5emQzYWNGQVVWWUl1dEFoWnRt?=
 =?utf-8?B?QmRITUp6NWROVDJKTUhGbGlxVUY5QUtRbHdFcDFtU1FnSzcyVXloVFZIMmxM?=
 =?utf-8?B?alAwTVRaUE02NTRkc2UwWlRsVzBESkVLZGkxTkRFb1JlSXQrMk5YZWJCQWIy?=
 =?utf-8?B?N09uS3YxeVNOVVZIbVIycFkvTjk4MDRnUjN2VFlvdklUZTFsbnJ5UzVudUtz?=
 =?utf-8?B?K0Y1cDRlOXI4ZFZzNDRlcDNtYnA1WnI5VVEzbjNEZXpwTWExYnNEWkplTWEr?=
 =?utf-8?B?TC9TYWF2MS81WFVkQ0c4SVF4U00vOXc4TTgrQjVYSHhzblJvLytHK3hFR1NW?=
 =?utf-8?B?UG44SXRxTTRJTUR5Y0F3R3dGQTJhTUhSQVBmSmhhQUYxRzQ0TGZPVXE5QmIr?=
 =?utf-8?B?azN0dlBrYXNvQUFYVE54cEE2RmNxVVppV21XZEtlYlR0elI5SjhabmZzTUpl?=
 =?utf-8?B?ZnpjZzMxSzhaUCt3VmU1eEVCVktVcWF2MzBJblZDckZsSklYejZxVGVJNUMr?=
 =?utf-8?B?cjZoVXQxTGl5TndXNlo3YTZ4cWQrNkxHQjhCeVhtQzVUUDE5YjE2S25VQ3d2?=
 =?utf-8?B?ZzBraEZzVmd1UllhN1FlbnRJU0JHSndFNDE1WFRGOXczZzBqYXdRMHphYVk4?=
 =?utf-8?B?a1lSVkJGZCt2MmowUmU2NXJGSzQ4eWNwd0puN2tWSVdhUkhYb2VXODhpQXF6?=
 =?utf-8?B?cVZrTE1vMC9SbW9QY0hOTEZOL0MwYVFlbU13WXEvUnRGendtM1ZaV1lhbWE2?=
 =?utf-8?B?anJSc00vdlNTYlU5MldFZXFzOTh5Q0UwRXlRdVVNWGxvc3pBQ1B2eTJQM2M0?=
 =?utf-8?B?cEkrYi8ranBKLzNtZ09CZFNHVjVnSVZjUHp3b3lpaXREUkUwK0wyaVRMSVJm?=
 =?utf-8?B?azFHck9vbTRmSVpyOXRBcS8vTVNORVBkTnoybUpMeFJHZHczNHVEVVBsQmRZ?=
 =?utf-8?B?ejFCQW5OY1RhcXRyTWI1UW5mL25ib0c5YjRnOVIxRDFBaTVSOUdhc3pTSjNV?=
 =?utf-8?B?YWh0Z2xyS0J5MDMvVlRKVHYrbm9FWERXeStoTS9aU3JpUGZLem8xeFd5ZTFj?=
 =?utf-8?B?Z0M2Q2p2czQwdE10L2lZYWhxYUJpMUtGRzFJUyt1b0VLYlczWTE4dThtdGph?=
 =?utf-8?B?a2Z0RzU0MThuS3ZFdDdkVllYMVpaaDBuYXFDL01GNm8wRTJpWTFRRnBaZVVu?=
 =?utf-8?B?TWkySGhTVTdpVDNScGowRWJaeHR2SXdGcDFqS2EzcFNHdUZ3QkswdHp1Mmx0?=
 =?utf-8?Q?rJhvOJ8SZtm8aChL7K83sII=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5e9f99-a751-4c03-47f3-08db5c81eefb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7492.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 18:08:53.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWij6/KDILot6NCLswckh2ykuIyeGbiZ/k5s+yAvh8PDxcQY4ZXXt0lHzhoQxNj4oOMI7BrhdkgpbJd71BDFyjtBCFWh7SYCrOiWqSd5fcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/23 7:40 AM, Sumit Gupta wrote:
>>>>
>>>> +Ionela, Sumit, Yang,
>>>>
>>>> Hello Zeng,
>>>>
>>>> I think solutions around related issues were suggested at:
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>>>> [2]
>>>> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/ 
>>>>
>>>> [3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/
>>>>
>>>> About this patch, it seems to mean that CPPC counters of CPUx are 
>>>> always
>>>> accessed from CPUx, even when they are not AMUs. For instance CPPC
>>>> counters could be memory mapped and accessible from any CPU.
>>>> cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
>>>> and [2] had an implementation using it.
>>>>
>>>> Another comment about PATCH 2/2 is that if the counters are accessed
>>>> through FFH, arm64 version of cpc_read_ffh() is calling
>>>> counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
>>>> to specify the function must be called with interrupt enabled.
>>>>
>>>> I think the best solution so far was the one at [3], suggested by
>>>> Ionela,
>>>> but it doesn't seem to solve your issue. Indeed, it is not checked
>>>> whether
>>>> the counters are AMU counters and that they must be remotely read (to
>>>> have the CPU awake),
>>>>
>>>> Regards,
>>>> Pierre
>>>>
>>>
>>> I think the solution in [1] is simple and solves all the three cases.
>>> Also, it provides better accuracy between the set and get frequency as
>>> compared to [3].
>>
>> I don't think [1] patches work for our case. We use mmio instead of AMU.
>> Increasing delay could help to mitigate it somehow, buyt 25us is not
>> good enough for our case. IIRC the fix proposed by Ionela works for both
>> yours and mine.
>>
>
> I have added the CPC_IN_SYSTEM_MEMORY check from [2] in [1].
> Could you please test if the below change works for you.

Thanks, Sumit. Sorry for the late reply. I didn't find time to test your 
patch, but the visual inspection shows it should work for my case. The 
deviation in our case is mainly caused by:
   - interrupt
   - congestion on interconnect

So disabling interrupt when reading the counters + longer delay (e.g. 25 
us) could mitigate it significantly. So as long as the two are covered 
by the patch, it should work for us and your patch does.

>
> -----------------------------------------
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..67aa09b5f15c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct 
> cppc_perf_fb_ctrs *perf_fb_ctrs)
>      struct cppc_pcc_data *pcc_ss_data = NULL;
>      u64 delivered, reference, ref_perf, ctr_wrap_time;
>      int ret = 0, regs_in_pcc = 0;
> +    unsigned long flags;
>
>      if (!cpc_desc) {
>          pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1350,8 +1351,17 @@ int cppc_get_perf_ctrs(int cpunum, struct 
> cppc_perf_fb_ctrs *perf_fb_ctrs)
>          }
>      }
>
> +    if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
> +        CPC_IN_SYSTEM_MEMORY(reference_reg))
> +        local_irq_save(flags);
> +
>      cpc_read(cpunum, delivered_reg, &delivered);
>      cpc_read(cpunum, reference_reg, &reference);
> +
> +    if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
> +        CPC_IN_SYSTEM_MEMORY(reference_reg))
> +        local_irq_restore(flags);
> +
>      cpc_read(cpunum, ref_perf_reg, &ref_perf);
>
>      /*
> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
> b/drivers/cpufreq/cppc_cpufreq.c
> index 5e6a132a525e..23e690854459 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -46,6 +46,8 @@ static bool boost_supported;
>  /* default 2usec delay between sampling */
>  static unsigned int sampling_delay_us = 2;
>
> +static bool get_rate_use_wq;
> +
>  static void cppc_check_hisi_workaround(void);
>  static void cppc_nvidia_workaround(void);
>
> @@ -99,6 +101,12 @@ struct cppc_freq_invariance {
>  static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>  static struct kthread_worker *kworker_fie;
>
> +struct feedback_ctrs {
> +    u32 cpu;
> +    struct cppc_perf_fb_ctrs fb_ctrs_t0;
> +    struct cppc_perf_fb_ctrs fb_ctrs_t1;
> +};
> +
>  static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
>  static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>                   struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> @@ -851,28 +859,44 @@ static int cppc_perf_from_fbctrs(struct 
> cppc_cpudata *cpu_data,
>      return (reference_perf * delta_delivered) / delta_reference;
>  }
>
> +static int cppc_get_perf_ctrs_sync(void *fb_ctrs)
> +{
> +    struct feedback_ctrs *ctrs = fb_ctrs;
> +    int ret;
> +
> +    ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t0));
> +    if (ret)
> +        return ret;
> +
> +    udelay(sampling_delay_us);
> +
> +    ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t1));
> +    if (ret)
> +        return ret;
> +
> +    return ret;
> +}
> +
>  static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  {
> -    struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>      struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>      struct cppc_cpudata *cpu_data = policy->driver_data;
> +    struct feedback_ctrs fb_ctrs = {0};
>      u64 delivered_perf;
>      int ret;
>
>      cpufreq_cpu_put(policy);
> +    fb_ctrs.cpu = cpu;
>
> -    ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -    if (ret)
> -        return ret;
> -
> -    udelay(sampling_delay_us);
> -
> -    ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +    if (get_rate_use_wq)
> +        ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_sync, &fb_ctrs, 
> false);
> +    else
> +        ret = cppc_get_perf_ctrs_sync(&fb_ctrs);
>      if (ret)
>          return ret;
>
> -    delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> -                           &fb_ctrs_t1);
> +    delivered_perf = cppc_perf_from_fbctrs(cpu_data, 
> &(fb_ctrs.fb_ctrs_t0),
> +                           &(fb_ctrs.fb_ctrs_t1));
>
>      return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>  }
> @@ -1002,10 +1026,18 @@ static void cppc_apply_workarounds(void)
>  static int __init cppc_cpufreq_init(void)
>  {
>      int ret;
> +    int cpu;
>
>      if (!acpi_cpc_valid())
>          return -ENODEV;
>
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +    cpu = get_cpu_with_amu_feat();
> +
> +    if (cpu < nr_cpu_ids)
> +        get_rate_use_wq = true;
> +#endif
>
> --------------------------------------------
>
> We can add additional check to call smp_call_on_cpu() only when 
> CPC_IN_FFH if we want to reduce the scope of calling smp_call_on_cpu.
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 67aa09b5f15c..3d8348911403 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -110,6 +110,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, 
> cpc_desc_ptr);
>                                 (cpc)->cpc_entry.reg.space_id ==        \
>                                 ACPI_ADR_SPACE_SYSTEM_IO)
>
> +/* Check if a CPC register is in FFH */
> +#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&    \
> +                               (cpc)->cpc_entry.reg.space_id ==        \
> +                               ACPI_ADR_SPACE_FIXED_HARDWARE)
> +
>  /* Evaluates to True if reg is a NULL register descriptor */
>  #define IS_NULL_REG(reg) ((reg)->space_id == 
> ACPI_ADR_SPACE_SYSTEM_MEMORY && \
>                                 (reg)->address == 0 &&                  \
> @@ -437,6 +442,29 @@ bool acpi_cpc_valid(void)
>  }
>  EXPORT_SYMBOL_GPL(acpi_cpc_valid);
>
> +bool acpi_cpc_in_ffh(void)
> +{
> +       struct cpc_register_resource *delivered_reg, *reference_reg;
> +       struct cpc_desc *cpc_ptr;
> +       int cpu;
> +
> +       if (acpi_disabled)
> +               return false;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
> +               delivered_reg = &cpc_ptr->cpc_regs[DELIVERED_CTR];
> +               reference_reg = &cpc_ptr->cpc_regs[REFERENCE_CTR];
> +
> +               if (!CPC_IN_FFH(delivered_reg) ||
> +                   !CPC_IN_FFH(reference_reg))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(acpi_cpc_in_ffh);
> +
>  bool cppc_allow_fast_switch(void)
>  {
>         struct cpc_register_resource *desired_reg;
> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
> b/drivers/cpufreq/cppc_cpufreq.c
> index 23e690854459..4109e00b957e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1034,7 +1034,7 @@ static int __init cppc_cpufreq_init(void)
>  #ifdef CONFIG_ARM64_AMU_EXTN
>         cpu = get_cpu_with_amu_feat();
>
> -       if (cpu < nr_cpu_ids)
> +       if ((cpu < nr_cpu_ids) && acpi_cpc_in_ffh())
>                 get_rate_use_wq = true;
>  #endif
>
>>>
>>> This can be merged and can later still be improved in Upstream.
>>>
>>> If OK, I can send new version by changing the patch to apply for all
>>> ARM SoC's with AMU and not specific to Tegra.
>>>
>>> Thank you,
>>> Sumit Gupta

