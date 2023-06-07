Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6894725D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbjFGLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjFGLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:41:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89021730
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi3Rg+B9CazQ5JUNM3a+c3Uib5vCxgoZQgtDnZMVJIo1lF4l9nXTcQnQeTADrdk7YsAtcES+zpuVDaXRgMTjYVNjxHZvYcaswA1ERiPpDgqBQatuG8fHaoHCwZm2hgu69r/2kLKCQw2HoePTJq4OkhhcNUL8SoKVN3PbR8c9eUxo0eGYQWYmDJaBBZGZNXBpNinI70m34p2TdaqfPYBcQpXQHHEeVwQrmCbSbYMA13pehhK1I5ioKL3ZVzch5Q4sB+RcgF3o2lT6ZJmZw3FDx0PiANIZaB3VmwF3XR4/P5SZNRVSgP6fLqBp+p2XtmBvbAEFD30Z/sDbzm9nLHouHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiKxmEAXBAxPIHuRWvOcA2keZ98D0jbx/04BYuTPKSI=;
 b=OjzKRtEqaqmkq7JaV2CPBWwWY7cGKG1DjVh4LQ90xkv6WZgbFHMOp2QSgtrMHtnQz01Ah8hBcQc3Ou4G0nu1PzDM+tUS6MRDqKKErhYXzs+Lxcp5okzE+NGjddol6OMunvtzk91KfXNW8WKj9L6nRDaBL/9RVUwGio3j+FV8SP7T0ZlEZjzbZiCLvPZzEAv+eDs5pEKg4zXVnebi5WFx35UuvhtP/zxy/ijYbBoi8Y94H4bmgDUq5SzzWEMFC2xqqQG0JG9ojWJi/hCAUW18wROVvOA6gQP/CDrf4MArKDQ07bK8BH+aR8glHMOkEySg6dm+FlQ0bIKbJnqqLtF9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiKxmEAXBAxPIHuRWvOcA2keZ98D0jbx/04BYuTPKSI=;
 b=y0+xxjitcO1ofVvc9+azdoxaOExayoeluMFHELBAoqfnqjFnl/MItif/ApwwULjhjXZUmmrQwFh2s410E5BrpBrY5lY5L28Z8RkMHBsZ581U8NsoSkm+GBijz2w4IUxg0G1zfNRJyeCfAUsz8h/0qlHyyhNaPe3bzgMTnLtI1L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 11:41:10 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:41:09 +0000
Message-ID: <53f3872a-4cbf-563a-2658-9222586680da@amd.com>
Date:   Wed, 7 Jun 2023 17:10:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 0/1] sched/numa: Fix disjoint set vma scan
 regression
Content-Language: en-US
To:     Raghavendra K T <raghavendra.kt@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
From:   Sapkal Swapnil <Swapnil.Sapkal@amd.com>
In-Reply-To: <cover.1685506205.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::19) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: c2036827-fb46-4674-ed24-08db674c164d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4lwdqfBvo7oH+dpThqwHi/bX1AQe3NrmWUFO7+o1T1g5684SNEDg21y2whbAuXdAtxPGaaZA3q1UyKtKJ34hlHcLHyW+vxvDsmFCr1qJPSVB+JiMhPdEljBClpgpvbPx1IsFqRDsfLffG8cw9omT8ldd3qLftcwlxS+l4ftP/t81jFfqpCP6Pofn9UYhN/ezsuGfsOCBkkv9YcKPggjMT13DAk0C3JkkF2/PMKoxWMM9M9L3VS/UBZznMYuRWvD8sBP0IBBAs+dAU9oBlnkJ399oLFz3H55ZRqfyZFhe+PgLEQoTCofUcAqlq7JuKm5vdTn4C+XpebzsRj7MzGTfFEo1L2IUsMy8hfsWnrX47BdTb2008E6XglOznxfTflfsiC2dWmdTju7vZN0a8J56YUoG1Dsge72GmfY+xjCXdvV94hW6dsgsJHKpyOI68LoYH3rAjAqInjbJzGPPXMoj2j3AXslZz+gwVm2E7GZrOlgVNeV50ET7Wtxup/rvMb1RHj1l5IwS88laZf0+RKUcm0A6qngUpS0GjxeWwOb30wmCluWUIJuaXWLjA1YbE9UbAIPckrHdS971bajnq1eEQUNEqZufG9s/VEdpyE9trgZlKAXD5TEEITmaR4Kcjj/JM/+igTMfH/05PM5p+Eh9pGdk5G2CFX+K6lUwF8iq327yk9WLFhHr1fmukhFK6+Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(478600001)(2906002)(6486002)(966005)(36756003)(6666004)(83380400001)(2616005)(6506007)(86362001)(53546011)(186003)(31696002)(26005)(38100700002)(6512007)(5660300002)(31686004)(316002)(7416002)(8676002)(8936002)(66946007)(66556008)(4326008)(66476007)(66899021)(54906003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZtaWpISWx6VW9ZZDRqRWxXWTUrVkZZWTJzQXM4YVlJS1FWUkJTc2hrS2tv?=
 =?utf-8?B?QmYyeWpaTXkvYlB0b2hlRkRnUGprK0d5T2lhRWxWVkFWTHlLZ0lVTlhCNUNx?=
 =?utf-8?B?dzVBZ1EreU1WamJnSHNtZFJtSDdCUjN0RkNtcTlWYjFSdVR0Tm11RnZVYzli?=
 =?utf-8?B?VHM1MU5YK25zNzk2ays1NFNkTXFhQ0NxRmIwL2F1ejJkUFNoUHRaeVNrM0Fl?=
 =?utf-8?B?QW9UdWVEVUxtR2Y3SjBiWllzYy9FQW95RzdSTGxyR2VlYzNwelJSanlqVzI5?=
 =?utf-8?B?YkpGNzIrSWtrY3YxZU9YV3hjemxISTJtVG9Ic25GZXYwMkQ3QW14NG1WU1Fl?=
 =?utf-8?B?ZStQV0wyenNUYzJQZXl0TjBSdFBYM3RsYm9wV25Wa1c3NHYwVGprZ2pvQ2hO?=
 =?utf-8?B?ZEo2YTE0TVNQcEpHY2VXVzdxQ1Zjd2M4QTI2eWdIN2REcVRwcndFN280YVpQ?=
 =?utf-8?B?VmtSaDNqMnBJcVVuN1lvb04xcnJtcCtjRnJtQzA0SVB6akJva25MMXd2ai9E?=
 =?utf-8?B?M0t0d3RwbVNzTjN3U0k5bGU3b3kvZ0dSWjFPeWV6SldpS2x3d2xXdUpqWkJQ?=
 =?utf-8?B?bUpHbURuTjBYZy9XajY2azU3bU9uQnhtVENWUkNyd1h5cWNMcXZRVExFSU4v?=
 =?utf-8?B?dzhHT3huMmlXRHRsVFdZYXk3UzJEOU55RzltZXlMMDEzNm90SURFcXdCSlFx?=
 =?utf-8?B?U2lYY253S3lIcng2bmdHaXFUQUdRMzlmYXBSSHptS3BJb0l1dXlsV1FxZmRI?=
 =?utf-8?B?MUE2Ykg0RTVxeGJQdEllK1VNQ2RYNHcxNkY4QzBUdzVReFE2a3ZtdFkraEJB?=
 =?utf-8?B?SEtLYmxodFZ1WVFZY0xpTE1xNll0YWxzelVNRE5EblU0R0lkck9VYzJoelJU?=
 =?utf-8?B?dVg5VnhaWDBhWUg5WVpwQkNzcjlBdloyQ21nQTJRaHlwYjlBMFFvbXd3QjIz?=
 =?utf-8?B?KzJqNytUNUNTU1RlelAxU1lzTWRJcjduanBVQ1AzTG1FSGtvUXBUZDgvaSta?=
 =?utf-8?B?Wm5VL0Y0cHN1YW5YOS8xMU5NZjkvUSt0R1hETDRqRnpoYXhva2JFRHlyNHZZ?=
 =?utf-8?B?WVJkdWtKQWFEY1lhdEhsOWxQQXp5bmVBMHlqM21ObVBWbU9kcy8zVUk5Qyt4?=
 =?utf-8?B?Sk1yUUV2Rk05UFdpdklMM290dlk5cGE2WldUbGVySzhzenZYTHU5NktJNmZG?=
 =?utf-8?B?SkNydkJ2eUY1RWVYM2Q2aXZGNzdLbjYyMGtpNlcyMjV4Q3FYSXVRU3BBOEFz?=
 =?utf-8?B?VXBxdkVTenI3cFRrdXUzZUJCMHRybVA5YlRvekNHS2RGSlBFZ0haNFpZc2JW?=
 =?utf-8?B?Tmx6U0Q1RStQb3FyazVQQ01LQWd6ODFHM1NFTVBYblBTK3RJTlkvVDJHQ3RP?=
 =?utf-8?B?UUk0cUFTSGxWdmgxY0Z6cTFuVnhRWGk5Qi9SQi9UMGU1TUhsc3lYZjZCUlpP?=
 =?utf-8?B?YnEvekU3OU9DejhlQ005NlFQeElFNVVlUXpvZldVRUM0MWdOdUJGeEVFSk1p?=
 =?utf-8?B?ZDJpbHBDK2xXN1NRSmx2OWdVK25KUXFudGN2bW83UUNhdmdEcDg4S2t5RjdL?=
 =?utf-8?B?SVBwMk1UNlN3OCtJYjd0QlpNZTNtZVVSKzZheVkxQ0E1TWozcWc2d2VWVW9L?=
 =?utf-8?B?SHlUU2tvYUtZOWFpYm5rNWhVVGhYRDFJYmY1YUk1UkcwRi9jVWpSNDlvNnp3?=
 =?utf-8?B?Zk9XL0VVZWxMVTRObjdVSm5hQzdGN0VIRDB0c2pMcGE2MWcyNUZGQktxcUZ2?=
 =?utf-8?B?S3lIMFFyNFFhU0pYMkZmQ3ViUUt2SFkwNnRQWUdsbDhJWmMxTWdNd1IzNndE?=
 =?utf-8?B?WndvU0ZHV3JHdHI4K2Jlc3dReXZnZytZQ0xVNzZ4Q3MvNHlSTWs4S05NbHVH?=
 =?utf-8?B?Y1ROaGJ0ZXoybzJSME5EYjRkRUxxVlpYdVBOZzQ1N00ycnNTVkt2cXhibU9D?=
 =?utf-8?B?cTZsdXk2Wmk0WGpjdzh4ZERBZHpRT0JWSnJOYVBGTWhqeHIyNTFlSzA3VGw1?=
 =?utf-8?B?eGNXMmkrMEhKUXRLSlhZSzk1d3ZRaElGamM0MzY5b3Z2eGg0UHp1UTM3M0J6?=
 =?utf-8?B?QnRvWG1nRGlJZGk3TUMvdlZsQWhCRzdwUFFqS3hlcWkzMjQvUzN1NnNKeWhD?=
 =?utf-8?Q?wKGVZgVV5LFrEaiS3k2MMxwRk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2036827-fb46-4674-ed24-08db674c164d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:41:09.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVgsz0Hj2FtAXsiIPubT/7BKnu6A/gZVe0reQrl5bupSjtzYylAx80VEU4Hje+Dlar0LSRwNaPUP0FFsdhkHwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Raghavendra,

On 5/31/2023 9:55 AM, Raghavendra K T wrote:
> With the numa scan enhancements [1], only the threads which had previously
> accessed vma are allowed to scan.
> 
> While this had improved significant system time overhead, there were corner
> cases, which genuinely need some relaxation for e.g., concern raised by
> PeterZ where unfairness amongst the thread belonging to disjoint set of vmas,
> that can potentially amplify the side effects, where vma regions belonging
> to some of the tasks being left unscanned.
> 
> [1] had handled that issue by allowing first two scans at mm level
> (mm->numa_scan_seq) unconditionally. But that was not enough.
> 
> One of the test that exercise similar side effect is numa01_THREAD_ALLOC where
> allocation happen by main thread and it is divided into memory chunks of 24MB
> to be continuously bzeroed (for 128 threads on my machine).
> 
> This was found in internal LKP run and also reported by [4].
> 
> While RFC V1 [2] tried to address this issue, the logic had more heuristics.
> RFC V2 [3] was rewritten based on vma_size.
> 
> Current implementation drops some of additional logic for long running task
> and relooked some of the usage of READ_ONCE/WRITE_ONCE().
> 
> The current patch addresses the same issue in a more accurate way as
> follows:
> 
> (1) Any disjoint vma which is not associated with a task, that tries to
> scan is now allowed to induce prot_none faults. Total number of such
> unconditional scans allowed per vma is derived based on the exact vma size
> as follows:
> 
> total scans allowed = 1/2 * vma_size / scan_size.
> 
> (2) Total scans already done is maintained using a per vma scan counter.
> 
> With above patch, numa01_THREAD_ALLOC regression reported is resolved,
> but please note that with [1] there was a drastic decrease in system time
> for mmtest numa01, this patch adds back some of the system time.
> 
> Summary: numa scan enhancement patch [1] togethor with the current patchset
> improves overall system time by filtering unnecessary numa scan
> while still retaining necessary scanning in some corner cases which
> involves disjoint set vmas.
> 
> Your comments/Ideas are welcome.
> 
> Changes since:
> RFC V2:
> 1) Drop reset of scan counter that tried to take care of long running workloads
> 2) Correct usage of READ_ONCE/WRITE_ONCE (Bharata)
> 3) Base is 6.4.0-rc2
> 
> RFC V1:
> 1) Rewrite entire logic based on actual vma size than heuristics
> 2) Added Reported-by kernel test robot and internal LKP test
> 3) Rebased to 6.4.-rc1 (ba0ad6ed89)
> 
> Result:
> SUT: Milan w/ 2 numa nodes 256 cpus
> 
> Run of numa01_THREAD__ALLOC on 6.4.0-rc2 (that has w/ numascan enhancement)
>                  	base-numascan	base		base+fix
> real    		1m1.507s	1m23.259s	1m2.632s
> user    		213m51.336s	251m46.363s	220m35.528s
> sys     		3m3.397s	0m12.492s	2m41.393s
> 
> numa_hit 		5615517		4560123		4963875
> numa_local 		5615505		4560024		4963700
> numa_other 		12		99		175
> numa_pte_updates 	1822797		493		1559111
> numa_hint_faults 	1307113		523		1469031
> numa_hint_faults_local 	612617		488		884829
> numa_pages_migrated 	694370		35		584202
> 
> We can see regression in base real time recovered, but with some additional
> system time overhead.
> 
> Below is the mmtest autonuma performance
> 
> autonumabench
> ===========
> (base 6.4.0-rc2 that has numascan enhancement)
> 					base-numascan		base			base+fix
> Amean     syst-NUMA01                  300.46 (   0.00%)       23.97 *  92.02%*       67.18 *  77.64%*
> Amean     syst-NUMA01_THREADLOCAL        0.20 (   0.00%)        0.22 *  -9.15%*        0.22 *  -9.15%*
> Amean     syst-NUMA02                    0.70 (   0.00%)        0.71 *  -0.61%*        0.70 *   0.41%*
> Amean     syst-NUMA02_SMT                0.58 (   0.00%)        0.62 *  -5.38%*        0.61 *  -3.67%*
> Amean     elsp-NUMA01                  320.92 (   0.00%)      276.13 *  13.96%*      324.11 *  -0.99%*
> Amean     elsp-NUMA01_THREADLOCAL        1.02 (   0.00%)        1.03 *  -1.83%*        1.03 *  -1.83%*
> Amean     elsp-NUMA02                    3.16 (   0.00%)        3.93 * -24.20%*        3.14 *   0.81%*
> Amean     elsp-NUMA02_SMT                3.82 (   0.00%)        3.87 *  -1.27%*        3.44 *   9.90%*
> 
> Duration User      403532.43   279173.53   359098.23
> Duration System      2114.31      179.20      481.54
> Duration Elapsed     2312.20     2004.48     2335.84
> 
> Ops NUMA alloc hit                  55795455.00    45452739.00    45500387.00
> Ops NUMA alloc local                55794177.00    45435858.00    45500070.00
> Ops NUMA base-page range updates   147858285.00       18601.00    42043107.00
> Ops NUMA PTE updates               147858285.00       18601.00    42043107.00
> Ops NUMA hint faults               150531983.00       18254.00    42450080.00
> Ops NUMA hint local faults %       125691825.00       11964.00    32993313.00
> Ops NUMA hint local percent               83.50          65.54          77.72
> Ops NUMA pages migrated             13535786.00        2207.00     4654628.00
> Ops AutoNUMA cost                     753952.10          91.44      212633.14
> 
> Please note there is a system time overhead added for numa01 but we still have very
> good improvement w.r.t base without numascan.
> 

I tested the patch with lkp autonuma benchmark on a dual socket 4th 
Generation EPYC server (2 X 96C/192T) running in NPS1 mode. Below are 
the results:

commit:
   6.4.0-rc2
   6.4.0-rc2+patch

       6.4.0-rc2            6.4.0-rc2+patch
---------------- ---------------------------
          %stddev     %change         %stddev
              \          |                \
     501.84           -12.5%     439.14       numa01.seconds
     228.66            -1.8%     224.44       numa01_THREAD_ALLOC.seconds
       0.51           +21.6%       0.62       numa02.seconds
     107.17            +0.0%     107.17       numa02_SMT.seconds
       2936            -9.1%       2669       elapsed_time
     794910            +3.7%     824178       system_time
     474520           -17.5%     391331       user_time

Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

> [1] Link: https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
> [2] Link: https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/
> [3] Link: https://lore.kernel.org/lkml/cover.1684228065.git.raghavendra.kt@amd.com/T/
> [4] Link: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
> 
> Raghavendra K T (1):
>    sched/numa: Fix disjoint set vma scan regression
> 
>   include/linux/mm_types.h |  1 +
>   kernel/sched/fair.c      | 31 ++++++++++++++++++++++++-------
>   2 files changed, 25 insertions(+), 7 deletions(-)
> 
--
Thanks and regards,
Swapnil
