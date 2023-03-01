Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3CC6A6B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCALVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjCALVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:21:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B943B64F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:21:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnGVjKav5B/obmaRu7nrKa/xqxQZkLBPTrxHJG/z6O9awCC1wGqvHvN55EcOgudvYOd7MEb3SY9o58joIohg5nG3dGqpTX6SUI5CTKo6htgUgIVja3JfnSp8I0Y+kRLu0XAxaSNO97fj/cLh07byiPPRJEp4XR3W4u3VsOgim3UPjoPy+tlrEUqFR/4zBeEx2To31nb5IeCuPFWCnH+EUz2vepoOWmDCa1ljhurGrWDni2tmSmfcj+/zy4ulH5fLXge/azTVpSazO3gqs1cC/rZ72xylo+2hNru2Vm9hArsVj5ao08/OspbdH7T2nMhVUWDS11NVIWhHInLf52POTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnEYuf167uX4LoFsxa6qhxng7FMpn1zOnKBYIyR2rOM=;
 b=d46cZKiORwvsQfA+jt8g9qSsvE2ZSLF50JTTEUjQD8rArTyNoAz58BDdjFVLXH/qo8XkcvQ5HuQvi/ssWA8Hcmk3d0hebPpzt1/nymRHhh4Flx7B2v+b9D87WIXBrGTOeMFI01uKrD7SW6a/xXSiasuvjDh35Ia5QkX5UbbxV5tALhsIo01ee+ddRfAwvJLct3qe+kjqTJmZTDDN1/d/y2vyVMvnv++a8vG2xQeNtLtjlTaCYStwJJ13SFIkiUvWB5CXEzSzWEeUMTtqvwdGK6M9sL2rbTF1PhCvCwqi1L09SUF+0Bcwzyksib5VR5vC0OhfM5HjhBvYBJLL8o4GiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) by
 IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 11:21:40 +0000
Received: from DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::74e4:9cfb:afc0:d9cf]) by DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::74e4:9cfb:afc0:d9cf%3]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 11:21:40 +0000
Message-ID: <b19e0c22-c80b-7223-6ed7-472502948fa0@amd.com>
Date:   Wed, 1 Mar 2023 16:51:25 +0530
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
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87v8jnbl22.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DS0PR12MB6439.namprd12.prod.outlook.com
 (2603:10b6:8:c9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6439:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 887d0131-9ea8-41e4-1a5c-08db1a4720dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZeme3Yjlsajt1UJDU79oaBkQzbZWlVfH278ROkTGbV9X7i6aacfVp50QXMzQyug/zZ4mTYaGubemWqLFvpRYvblVrgDnZP+wNBwUcOuObiPXHF2RgUR7JFoubRhaKGPCCfz2g18Og+RZH4I+GbXazRp31yJDNFFvISXPkW4r2LS09pcQM8EUYHB3Q2awxvq27BwLamzHMeZmD7tjMJTA130ZIeIZyyycr1lvWvVi1mA6msIkwhHcBgCZLZ7HHEkos5YPrzFDsfsQUOWV9fKSag2BYdA9Kpdu0ro8A1lm9WA4bEFAuLTEWbQ5VPX32WJqXL4ZIyCH+TlXnCc21eKq1KsaW0hak1vAm7mRiAKA+b5Tk7+DGf6Nl4P3w4eIp6MkJS1fDjhcz01rJGP+AiSne/Lyxc46nSGVDfVLj+xI979ByA4SyTYRH4UCkF8XjDFehp7YcwprPRCp1vfzpXhvN2oAUyLXL9fOk23tE8q6TC0kUZkqxUCFnSjUWXQAfCUF0ouV5jticxxbGvKTLFEodINTSaktdie7c043JLv0dmSe/WFBeQwLN3tx/gWCA+nCOAO1mfoqEZ9ux4BJ4X4kqtPax1t5C/O7R+zgxNib1gnKyqYZikFUxp39YSYisBVZdsTWM1EQTJO2U0PIGAUoX5JgDFOJ0TDefJeaNGQsVhSIqfRtzdI4dUIYoP1uUNqv4SM0xH99afL1OrSpqr0Sd+kKFRqMKdT2EsdJ6VYoDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6439.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(5660300002)(7416002)(8936002)(36756003)(86362001)(31696002)(83380400001)(478600001)(2616005)(6486002)(6666004)(186003)(53546011)(26005)(6506007)(6512007)(66476007)(66556008)(66946007)(38100700002)(41300700001)(4326008)(6916009)(8676002)(316002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnNuckNPNG5hNzNnUVRBbVVaQUNMVEMrckF2anZUd2xJbERHclFFeUhON2dr?=
 =?utf-8?B?M2hob1RqTzFuQXpkNWN1VXVEbisrU1RoaWVMeFpBMXl1WUxNOFJJaFJtVTNz?=
 =?utf-8?B?WGFQdnFMNitzOHAxR3hTNTMxTmNvY3U2N2Rpb3gyQk8yeTJIY2ZVaXVCeUkz?=
 =?utf-8?B?c2hjOEtaRWlFVnovZm5SeFF0eisxV2tGV0tnQm9IbE1nUzM2Y2U0bnFwU0xm?=
 =?utf-8?B?SVNGZlpBcVN4bmtWZXd1NTd2VHVsY1BEZTVNMWhtQ1c0S1dtMk1rRVdKWmx0?=
 =?utf-8?B?SDFTa2lrTkFkazlSaE1OdmJWMS9lMHV2NEE4TzR2TUpXbnl1VDlYTUMyem53?=
 =?utf-8?B?OUxYbEIvdkQ2V2hMOHBxK2R4eVlRbnhadkVreEduNWNQWFM4MDhSN2svMzNN?=
 =?utf-8?B?ZEs0cHZhcXBTNnJ2K1lqWnZqMzVCbkpnaGp3Ry82R3VabEN2RXZzNHRFNG8x?=
 =?utf-8?B?YjRTYlM0TGVKQTVrYWZGdGFqRkZlM2VaRnJ2NzF0Uk9pbEtXVFhkZUROUDVF?=
 =?utf-8?B?ampRaUhMRXR5RUZZcEZqenBwTnRqS3VRelBsR1doc2JkUWRVSkF6WEtsNEI4?=
 =?utf-8?B?QU5IbENNOGVzT1E4T3c5MWhnTHJTRGtVK3dyMkN1clkrVVRrSVVMZ1VHZ21v?=
 =?utf-8?B?OUo0YVpBdXE3UlhXWllPMVlMVWNpcnhoaVUvMk1WMnpta3R6SG9VT0Z4Kzgz?=
 =?utf-8?B?UEc4MVUyUUZBNzMzQXVReTNnbVBHQzJiMG9zWkRwSzgyaDFNd3NCZGVNai9l?=
 =?utf-8?B?dlFDOVZ1dlhPUzJuSzFOMHh2Z3BQMTV0aFQ0aEd2Z280TlZaM0hFcnpkVmd1?=
 =?utf-8?B?ajVXZ0dwNktEZ3p3T1pwMlBId2ZEdTNXVWlGSHhPOC81ZTVRKzZtMzNTYTlo?=
 =?utf-8?B?N1d5REloS3RWcnVXRitObzRlWElEdjJxaFVpdnI4eVpVcmtvb0xGZE1yMGQr?=
 =?utf-8?B?bjd4U3laZlpoWDJ0QUN4c2IwTnMwYzJvZkJvTndwRWJYQjM0S25KdEUvaVUz?=
 =?utf-8?B?aEt3V09neWdyYldXRzhVZjFpVUEwcWs4NHRiOVc5TmNLV2tteE13d2RoRDZj?=
 =?utf-8?B?dXZ1Nk9EMHZlZ1kweTdDYmJWKzc5MnRoMnMyZCtpajJsUjZIc0pTWHdJOS8r?=
 =?utf-8?B?Sjk5WEpvamtYKzdIU3lIciswdTZNUWdUZVYzcTcweFYrZUJ0SlB3SFZ2cU9B?=
 =?utf-8?B?aXNXT3pmMDgvRjBHVzR3cGVTeU91bFBhWi9KYlV6ZTV6T3VuZktoWW1OYXcy?=
 =?utf-8?B?TGxFNXl3L0M3anh3U041UDJDWmZmOGFRTTBiZkNKMW02UXZkVmRqYUIrMDN2?=
 =?utf-8?B?T0JXQjBYQmdoM2pTM0EwcFZGcUdhSzhFQVFKUHFCS1RoVW9nRjl1UkczVW1o?=
 =?utf-8?B?NEVlUkRRaEJ0MldZZUlMbzZ2bFBwQVRuUW1IaWZoSW9BdTVHc28yazd5aENO?=
 =?utf-8?B?NlJxTDZXaThkMTdVMGlRV0VPRnJvTUtmUG9BL3JGSzFLV3RGUlBWdXJLMmNM?=
 =?utf-8?B?QWpEWElVWlV4YUF1b1NGWitkTFRMd3FvWnJjNFFoOXk1cmV5WkE5cno2YjAy?=
 =?utf-8?B?dzNqM3J3a2k5ZTVNSVl1QmpXMGFQQTJ0RGdMNHlIdEJkeEVKLzh2ZENUeFNt?=
 =?utf-8?B?N2grMlFNaXZnN0prV2dkZG9sd3NlU01GSjVlNUplTFI0TFVHOGExSFRsWXZV?=
 =?utf-8?B?dkRYVjU3RWt4VWJnNlhJMWRpb2FuNFV1anBDaExjOGN2ZVg2WERzYXlOc2dq?=
 =?utf-8?B?MW84QUtEUkxSVGZEQjl2K0xGT0JJeGZXcnJyRGh0a0d5V3NoVkdSUHlXTUdH?=
 =?utf-8?B?cU11YVIzYmxHYzl2bkc1OVBuMUZSUTVzSXQ2WnFQb2NQakN3Smpvc1Z1YXdV?=
 =?utf-8?B?bWlKd2tSZFJiTmxUckJxS3NzRzFIdHljcFFkQjNyUE54bG1mT1lpYXkrVExC?=
 =?utf-8?B?SEFQMW5RTGErK0QwMmtzRU5iV2ZCenNVN0pWT0l0eWJEMUZpTUY4L21ZOEh4?=
 =?utf-8?B?SVczYXdieTNXZ1VNLzRxQXh1V3VBWmxpcy9OUTAvdVhxdW85WW9MaEIwbWV3?=
 =?utf-8?B?Y1c0d1VHZHJLb2Jhd2VvWTFGYmY0Nko0U1BFMWNWODYvUVd0cVM2bU9QRzNm?=
 =?utf-8?Q?uTdocnYr1JpdgxGflYcROImM2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887d0131-9ea8-41e4-1a5c-08db1a4720dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6439.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 11:21:40.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2BysL3ndqpSWe48SH5ccyR88X1UoD9qZS314r5n8vbrDVMcOGurGpPF6Uu/LeImL5M9q6pvIbgd2IuO4yk5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-Feb-23 1:24 PM, Huang, Ying wrote:
> Thank you very much for detailed data.  Can you provide some analysis
> for your data?

The overhead numbers I shared earlier weren't correct as I
realized that while obtaining those numbers from function_graph
tracing, the trace buffer was silently getting overrun. I had to
reduce the number of memory access iterations to ensure that I get
the full trace buffer. I will be summarizing the findings
based on this new numbers below.

Just to recap - The microbenchmark is run on an AMD Genoa
two node system. The benchmark has two set of threads,
(one affined to each node) accessing two different chunks
of memory (chunk size 8G) which are initially allocated
on first node. The benchmark touches each page in the
chunk iteratively for a fixed number of iterations (384
in this case given below). The benchmark score is the
amount of time it takes to complete the specified number
of accesses.

Here is the data for the benchmark run:

Time taken or overhead (us) for fault, task_work and sched_switch
handling

				Default		IBS
Fault handling			2875354862	2602455		
Task work handling		139023		24008121
Sched switch handling				37712
Total overhead			2875493885	26648288	

Default
-------
			Total		Min	Max		Avg
do_numa_page		2875354862	0.08	392.13		22.11
task_numa_work		139023		0.14	5365.77		532.66
Total			2875493885

IBS
---
			Total		Min	Max		Avg
ibs_overflow_handler	2602455		0.14	103.91		1.29
task_ibs_access_work	24008121	0.17	485.09		37.65
hw_access_sched_in	37712		0.15	287.55		1.35
Total			26648288


				Default		IBS
Benchmark score(us)		160171762.0	40323293.0
numa_pages_migrated		2097220		511791
Overhead per page		1371		52
Pages migrated per sec		13094		12692
numa_hint_faults_local		2820311		140856
numa_hint_faults		38589520	652647
hint_faults_local/hint_faults	7%		22%

Here is the summary:

- In case of IBS, the benchmark completes 75% faster compared to
  the default case. The gain varies based on how many iterations of
  memory accesses we run as part of the benchmark. For 2048 iterations
  of accesses, I have seen a gain of around 50%.
- The overhead of NUMA balancing (as measured by the time taken in
  the fault handling, task_work time handling and sched_switch time
  handling) in the default case is seen to be pretty high compared to
  the IBS case.
- The number of hint-faults in the default case is significantly
  higher than the IBS case.
- The local hint-faults percentage is much better in the IBS
  case compared to the default case.
- As shown in the graphs (in other threads of this mail thread), in
  the default case, the page migrations start a bit slowly while IBS
  case shows steady migrations right from the start.
- I have also shown (via graphs in other threads of this mail thread)
  that in IBS case the benchmark is able to steadily increase
  the access iterations over time, while in the default case, the
  benchmark doesn't do forward progress for a long time after
  an initial increase.
- Early migrations due to relevant access sampling from IBS,
  is most probably the significant reason for the uplift that IBS
  case gets.
- It is consistently seen that the benchmark in the IBS case manages
  to complete the specified number of accesses even before the entire
  chunk of memory gets migrated. The early migrations are offsetting
  the cost of remote accesses too.
- In the IBS case, we re-program the IBS counters for the incoming
  task in the sched_switch path. It is seen that this overhead isn't
  that significant to slow down the benchmark.
- One of the differences between the default case and the IBS case
  is about when the faults-since-last-scan is updated/folded into the
  historical faults stats and subsequent scan period update. Since we
  don't have the notion of scanning in IBS, I have a threshold (number
  of access faults) to determine when to update the historical faults
  and the IBS sample period. I need to check if quicker migrations
  could result from this change.
- Finally, all this is for the above mentioned microbenchmark. The
  gains on other benchmarks is yet to be evaluated.

Regards,
Bharata.
