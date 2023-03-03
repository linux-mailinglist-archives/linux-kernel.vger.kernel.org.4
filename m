Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528C66A9074
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCCF0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:26:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5631518A8F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 21:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfFCcIL8Wi/j8QDNpMVcnHshZW+7Bz+K3Pj5gscuv94AzJaB4VlmcVVGy54gPJIv/MWfA3aPl4pkSENkv/xpYV7LPQA+vt9z4qyEioITMcGKCw+oOUSBAglSenrm29h7eqtcN3z7sIr8xT34/ZglzpRkW24f2oOSpAQEMh8dxi2rsdkId103I5F8ht3600oLaOqNZii/6dr6S/noRRkhgtfAVv1ZX70WQmwlHRsU/O/aEdLpM+6ISbv2W/6kCVDBGJrO/HNyMszTCbSh2iENv4eU24O2gUG2GhVBdL8NxjNa8MUaFkOMhsFoB1T0EjvM9vY0DsJptfiMIy6hh3S1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s8yCLwr7UH0TIcsurUqwYFWHyrBAegYej99Pg3VnPA=;
 b=BLycVjC9vEKx84ZiVwAWQWeTkHSHwUifewnHesrvlAzlfesuHcTrD58RSOisSmomT4f7lbjmVJ3XfeWfUEzn3KeVPYMwbbNZ95AVxN2bUG6E6UdGOGcEO9mYSqU1zrfkhlWqcd3tlyujwuZ1b4CKlRZQx4oiFp9u3UbH3QnQRYvzRd6Fq5U6v7MDXy0F7hlISiy+1lSGJrjnubjeGjSF2+MLKI8jiQH489EIAVgnREJwzzQwKjup4aMX9YSHCBMwvsjtb8L8wiJt9Vy3phk8K0+EvPSP8yBFVquI+jejxLMPSSG4kGwuChJgZWwHuM+UXDPqhyP8bIRUWo0pNTu4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s8yCLwr7UH0TIcsurUqwYFWHyrBAegYej99Pg3VnPA=;
 b=RzsgUxdlQNiFVc/FVlK+BwhWlXMP0S2rz2ze/21doGnJG69j0+RNEnYC5tmUOuzw2pcxYG2ge7YYmEL+x/fqnDbj25cpPdWaXHI5Fvq2iSPAoJQabem3wfdqhTKEgl4A/XXktIQwSedYWqK89drnA7EJSTiLbs3akzA/Ns7t2Vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 05:26:06 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::fe66:3fca:2cb4:1e7c]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::fe66:3fca:2cb4:1e7c%6]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 05:26:06 +0000
Message-ID: <41b47cd7-1ba9-3205-165e-02e8384e7064@amd.com>
Date:   Fri, 3 Mar 2023 10:55:54 +0530
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
 <8fea74ec-8feb-1709-14f2-cecb63fdc9ed@amd.com>
 <87v8jnbl22.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b19e0c22-c80b-7223-6ed7-472502948fa0@amd.com>
 <87jzzz8tgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87jzzz8tgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::13) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d97c74-e1f8-4511-b965-08db1ba7c97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49ecB6+HJh0NXBHcl+dn3N0OJRrBCTwEcyySdIQYg4W1qurskCuvAs425L/syE5X6f/D1x7oy2jVLmrY+JJqUTaa9/yPJzidIfI0APBAXJb1quRgiL5uILINn7lF9sd9S6bkvmmxphorW5yyycYTn26Mx+RwnrsoVb6Z6X1WxNdXBrRotu1doApypvgDu+4RyS7CjMctJFRhPJQoQ2doBvjJyXSy6HtpruhTvMhJC6uj4MPlN/YLmYzLtCzIZ17B7wcI2kdcfK3sNSgZC5W54Ler5CMSNCq3g7PZtq+5dxMM7WngjNisRQHsaGz/f31LubZK+nsDNXTyOAPcR7ngW3ySC++TYm120wH/8a2uNakdRgt7zwoe/EmqR8q9ahMQUI1SUhV87VfpATdFvAJQhc7TGrLDkHs25lbjjDzMlXR0UZx7nn5XP1rT7MwbaoPiyDUphuJ0sNNy/2SpJajdLfbP+G0xEqGf7EDelwuTSoLM8lS/j7AeALWMzTxdYI3cQ9Q0PhZPSO0XE8ge9QzfwMCJsJEt7iZMyTi/8TDsWsXmZf1CUyiJRNwKbhlQsdqXEuPG6xejYpafUN18zTeaJ9EgZHvrBNT+hoHlg+gzi1oR3xWMDJDGLw8AwKPNYIWMlfjz22PbMQk6ZhSpMC7Hfo9TwBIzNTGxHqh7JRCHyruFSmVtR+YpB8dubtI1m0Ah17r6zxlNVZKijphS0XNvX9FnHsE8K4f0W/apwc9zOUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(38100700002)(478600001)(53546011)(36756003)(6506007)(6512007)(2616005)(26005)(186003)(83380400001)(6666004)(6486002)(8936002)(41300700001)(66946007)(66556008)(66476007)(4326008)(6916009)(8676002)(31696002)(5660300002)(86362001)(31686004)(7416002)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZ0QmUxeEpOWWM4L085c1IrRGpTaUFFM2tBVDg3YzlhL041LzdiZFRsWjZR?=
 =?utf-8?B?Q3k1VGxXNEFjcEU4M2d4bFB5dDF2aUJmOVk4Ynp2bVQ2UW1LWE5PWCtSUXBj?=
 =?utf-8?B?bGdHNFlZRk5iTGtYcll0VGpDK3NaSzE5UDlkQVY0VGZnMXphamRNM242dXlJ?=
 =?utf-8?B?aElCOHY3d1E4OVFVYWt5UURvaWtVNWYvTGdvVnJrZnFDazdNZHZ3ZkpBTmln?=
 =?utf-8?B?Z2VPeVlReDlKVFI3YXY0ekVkTk9QNW8wdEtzVDgvWklNQ01tRDZtT2dPd1dV?=
 =?utf-8?B?aWlwUDhZNWJoWmk3WUJlb1pQQVRkQmkrb1BDazYwZTB5WUxjNm8rajdnRGZi?=
 =?utf-8?B?VW4yMFNqa0cxejhwMzBUaXFPSXYzN1RQWmdFT25ucDRZSFdseTk1Unk3UmVi?=
 =?utf-8?B?QjlVYkVFck5XNnhONGdXZGtNdHFGVGptYWh4TTg3Z2RsOW01VUpTWlRZOHRt?=
 =?utf-8?B?R1lIS2krYitoWmJ5UklPU1loS0piL2l3WVB4QitVTjd4a0N0SXhkeHJtSjhq?=
 =?utf-8?B?Z0JwbmkzSnA0U3crRVRpdGdrOHFIa2lYR2pHclN3VFk1TzF1Q0pYa2xkRGF0?=
 =?utf-8?B?djY3NGhaeVhsN0pQeVRXNW5sdmkycXQra2cyczcvRWEzOTNQa0FjMEZMWGFZ?=
 =?utf-8?B?S2FyN2NHWVlGaFJGMWdoZlErN2w3U3REM2RXbldweEZFMkJaeERjUG1Faks2?=
 =?utf-8?B?OElqUC9yMkZnMWZtaS9sMGdGU09lQ2kwME05QXlacko3YXA3NHVNSWF4ZnVY?=
 =?utf-8?B?UWJiLzcxYTh2a3htNlZ6cDBRempTRDZMbGl5VmM3c2RiZm0wQkJLdGllbEZ0?=
 =?utf-8?B?YTEzSXdSN1FpMmZuODV2bEdHWSszMVJCaWlaY2pDSmJiV1RSK0VtK1RxMC8y?=
 =?utf-8?B?bi9TZTdlVk5SRHJNRCszSWJFRGdxY1BwTVFVakU4c05hSFR6RHFRMUdJNzla?=
 =?utf-8?B?UkFxOG5HUFhjM082Sm11ZWsrL1VmZ21RM1QvWUpxNVE5U2YzZEdLQXdNWE5C?=
 =?utf-8?B?Z3FTRkhYRU9hUGM5VzhVZVNkclJhTnFCRnREZFZsT1lDbGlqanFlVnowT3Nn?=
 =?utf-8?B?ekRlZ3g5RFpIU3ZtZ2JFNEIxNEcwWWJGOWwxRjN6emloTW85dzN5UXNMNWdO?=
 =?utf-8?B?Vlo0OFU2L01jQlZ2bHF1VmJHTUpRVmdmZzhod1NGSTFJZy9sOGZEbmVKTTg1?=
 =?utf-8?B?QjlZdlpzOUVXbGtyMWRUejBQbG5xU3F0aHdUeDZGb3ZyN1NLUjJLbmdRTFJY?=
 =?utf-8?B?cWIzVnEzcS9qKzIxRTNFeks2emxJUk9zRlJLaFVnQjJwNk9aZWszZkMxWGox?=
 =?utf-8?B?WG9xV3B1Y0ZvUE5QeVRzays1eWFxc0lzd1F3MklCUjBRK2lVL3FsOHppZ2lC?=
 =?utf-8?B?aThTTGUydS90aUlDWjN6UHp1V1YvRW5PaElYc3FXZVlyWjc5b3k3MkxZVVNy?=
 =?utf-8?B?ZVRBMEJQRlpnSTRxNlAzYzZZdXFwbkJzQmtycVNJWUtsSVZSMU02cDlSOEFK?=
 =?utf-8?B?b0xUb0I1V09CMG9JMTB4TVRlZ1JEY2FKOEFnVnFsSGJ6TmxFYWR1MG41Lys1?=
 =?utf-8?B?YUdyU2JXVlkwK1RMeE9CeXpaamk3b1huWThrMXd6YVB2RFpuTEI1Vll4TGlY?=
 =?utf-8?B?Q3JhamtCVDlETzF2L21SNUNXTkw1N0dhSzVNN0NyUUd3UGVXeUJYbFo5UEc5?=
 =?utf-8?B?TnRkVitTNnY4Tk5KT09GR1BwVTgyMURvc3JYRjcvNy9HeXhJSjRKQU1zcmIw?=
 =?utf-8?B?MHk4MzJJV2RpVWFkTFdEV2g1eW12RUNKN1BGZTdsV3JiTmFFSU5icDRjTnFU?=
 =?utf-8?B?TEJDWk1xcFA0dG5QKytZaHZJZFJMd05NTEx0dWxGVk1OOVRVSHFBNzhTZlZZ?=
 =?utf-8?B?Z0pRSUNBR1BQOE1mS0JoRk5EUFFoeFdKc08yaG16ODdvYWVxQkFqN2I1MjZL?=
 =?utf-8?B?Y1NoeE1SeVdta21nc3JoazNCbDdreEM4bXBKRGhENk1BenE0YllrL1FaQU0v?=
 =?utf-8?B?RXY0V0J6TmxaaXRmaUIrZ1NtSHVneUhraG9GTm91eFJtN3pqbHlaVFBweVpF?=
 =?utf-8?B?Z3ZpYms5SzMrTTduUGRVelpLWTNLbG1peHhDdE5jbXV1aEdCOGMzUGpVT200?=
 =?utf-8?Q?DukYmWuHkS12offRWPw7+bx35?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d97c74-e1f8-4511-b965-08db1ba7c97a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 05:26:06.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kkfdlnKaKUd65tWKDvs+4SFPzQwQbvJnwAidZW0focUZ5KHXI3v2D/VT+IFKWgO/kyuBQFa3/Fs70oSZBaFWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-Mar-23 1:40 PM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
>>
>> Here is the data for the benchmark run:
>>
>> Time taken or overhead (us) for fault, task_work and sched_switch
>> handling
>>
>> 				Default		IBS
>> Fault handling			2875354862	2602455		
>> Task work handling		139023		24008121
>> Sched switch handling				37712
>> Total overhead			2875493885	26648288	
>>
>> Default
>> -------
>> 			Total		Min	Max		Avg
>> do_numa_page		2875354862	0.08	392.13		22.11
>> task_numa_work		139023		0.14	5365.77		532.66
>> Total			2875493885
>>
>> IBS
>> ---
>> 			Total		Min	Max		Avg
>> ibs_overflow_handler	2602455		0.14	103.91		1.29
>> task_ibs_access_work	24008121	0.17	485.09		37.65
>> hw_access_sched_in	37712		0.15	287.55		1.35
>> Total			26648288
>>
>>
>> 				Default		IBS
>> Benchmark score(us)		160171762.0	40323293.0
>> numa_pages_migrated		2097220		511791
>> Overhead per page		1371		52
>> Pages migrated per sec		13094		12692
>> numa_hint_faults_local		2820311		140856
>> numa_hint_faults		38589520	652647
> 
> For default, numa_hint_faults >> numa_pages_migrated.  It's hard to be
> understood.

Most of the migration requests from the numa hint page fault path
are failing due to failure to isolate the pages.

This is the check in migrate_misplaced_page() from where it returns
without even trying to do the subsequent migrate_pages() call:

        isolated = numamigrate_isolate_page(pgdat, page);
        if (!isolated)
                goto out;

I will further investigate this.

> I guess that there aren't many shared pages in the
> benchmark?

I have a version of the benchmark which has a fraction of 
shared memory between sets of thread in addition to the
per-set exclusive memory. Here too the same performance
difference is seen.

> And I guess that the free pages in the target node is enough
> too?

The benchmark is using 16G totally with 8G being accessed from
threads on either nodes. There is enough memory on the target
node to accept the incoming page migration requests.

> 
>> hint_faults_local/hint_faults	7%		22%
>>
>> Here is the summary:
>>
>> - In case of IBS, the benchmark completes 75% faster compared to
>>   the default case. The gain varies based on how many iterations of
>>   memory accesses we run as part of the benchmark. For 2048 iterations
>>   of accesses, I have seen a gain of around 50%.
>> - The overhead of NUMA balancing (as measured by the time taken in
>>   the fault handling, task_work time handling and sched_switch time
>>   handling) in the default case is seen to be pretty high compared to
>>   the IBS case.
>> - The number of hint-faults in the default case is significantly
>>   higher than the IBS case.
>> - The local hint-faults percentage is much better in the IBS
>>   case compared to the default case.
>> - As shown in the graphs (in other threads of this mail thread), in
>>   the default case, the page migrations start a bit slowly while IBS
>>   case shows steady migrations right from the start.
>> - I have also shown (via graphs in other threads of this mail thread)
>>   that in IBS case the benchmark is able to steadily increase
>>   the access iterations over time, while in the default case, the
>>   benchmark doesn't do forward progress for a long time after
>>   an initial increase.
> 
> Hard to understand this too.  Pages are migrated to local, but
> performance doesn't improve.

Migrations start a bit late and too much of time is spent later
in the run in hint faults and failed migration attempts (due to failure
to isolate the pages) is probably the reason?
> 
>> - Early migrations due to relevant access sampling from IBS,
>>   is most probably the significant reason for the uplift that IBS
>>   case gets.
> 
> In original kernel, the NUMA page table scanning will delay for a
> while.  Please check the below comments in task_tick_numa().
> 
> 	/*
> 	 * Using runtime rather than walltime has the dual advantage that
> 	 * we (mostly) drive the selection from busy threads and that the
> 	 * task needs to have done some actual work before we bother with
> 	 * NUMA placement.
> 	 */
> 
> I think this is generally reasonable, while it's not best for this
> micro-benchmark.

This is in addition to the initial scan delay that we have via
sysctl_numa_balancing_scan_delay. I have an equivalent of this
initial delay where the IBS access sampling is not started for
the task until an initial delay.

Thanks for your observations.

Regards,
Bharata.
