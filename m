Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64F73DC64
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjFZKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:43:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88BCE6E;
        Mon, 26 Jun 2023 03:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rhs/VHDGhzfk/MUqBSX4Sb+IpjAr2g4fsMelx6Bnj2Nnvi/kmyKY5ZDCsFLFN7suLLGPiljqgU4pv6et5PmfEfDbzyssByCIhyk33IWQRKVD5t+/6QvX6qU533KaELn2qdvXH1qdTQHk8nh7pM3O9ZoPGqk/YRZKQtiKysaJITOsiAPSHpjlhlsti3Nbvnq1t9P3Vm9go4i6NX5nVVPdOclI3dtO1QkstXauglcgy9ZyWkQAyS2Rv9qMWJMsQXy/hzDOgyMM+a2D88jt4YzSlWxbIVloHT2WDtovJM7dBwwKLit9O7sI1mi6RnH3fazngXguVGTzZAvTCL9uZNxxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwMQfWSN4dTjGdlSmUh5iHPFncr0nBK2WCNboOcpZW0=;
 b=VKZOa3LQZ7BbMpcLZCKo9kRYQPJZlGgkmYdXdnYyk0hhMLYdGOHncQbQuifMEmByAWsq4Wa8W6kGJ8e98r2155gLq/EJxLix8vxQvxKRjc57GW8iclzm4gyMCNrL5bclMHdXV8Th2CU3+vgMJR3hQTGXY3G7o77kKh5sCvuFvJFqDQWGo52le7OgwPshBWRqvehu5WgUTQn9eKJuw2fDjnCKtCkULzwm3CSwQdWDPKHHlNwl+dqkzGAn/+gCRwTqEAEe24ukZygQjQixyKkJivutMGa5Xk0S5LtQU8rB5mydoZu3VZT8jrYtu44ZJ16rpkC349uVcpF6sWr40xuspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwMQfWSN4dTjGdlSmUh5iHPFncr0nBK2WCNboOcpZW0=;
 b=INXXIChc9GdCh4F5RPLxdKCNUDf+4dhvEZgVomwO0Ub5doGGnvksnSHaFOY6nQ1pU8cRlmwsFF6hD/blj40faPTc96FSH+LwZYl0Mg6PmOdgaxrrFJyWsYx2JJQrQhkAyGGAp1Uj/6IyKQvy2HdB84fNIvWLlhnNQ6+kK1+4tpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 10:43:04 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 10:43:04 +0000
Message-ID: <01605914-60fc-9540-389b-7dc377990f1e@amd.com>
Date:   Mon, 26 Jun 2023 16:12:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf evsel amd: Fix IBS error message
Content-Language: en-US
To:     acme@kernel.org
Cc:     peterz@infradead.org, irogers@google.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230626103958.834-1-ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230626103958.834-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 64916260-9847-4ffb-599b-08db76321f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KBzzxIluVQWuPzXKylqnMYLAT7InmpcdafHIv8kICGMV4bR5mrqBRE/ee3lJgH1dqAYC109cn7u0H2iLSGwLSayN4ONf7xsmlXO2QKlo6LfosUpA5pKmEcPfxmaRn/bIPMWTLUZ/rR3yu9PTEArcH1oiiDPGxkSu5354dlnFK++ViY/iY+qrIGrdHWW5Z5lX9d3qU1L4xFEa3MDo7S4EwP1iCjhca23jm4nAtP0rFZDIb3BK/9HpDs70mOB38Rsj7bvJnCxFme+r9YxJ6i5oqGkjax6xLkGLJoeysFoiipudH3goJ9+ibXE1Ba1R1/lJZeWuTJlCmhMvhVXxOLMr6ORPdAi3BR4NxB9Ps05kQOJAaROluUvJQAaPBBOWDhpnXiGEpUFPiTqSiN6TaLkYf16TEXz2vBHjw/XC1jJSqL37lqkKniT+IxU8peLo7nDrDNoIXHkNaLGvdf/sA9YyODLLiunPyWKYS2VJ7UGmw52x3CXpHtL0Bg6LRchqQtQuwtzDDaPoWH86xRookadXnSdqA7lG5NLi+JZCufeV4vABn46sj3MstvLqHTKvSfEHhj26vb6maEX81e9h8QCW+wmD+ohK33u3CXDoytMq3pxAEjkQ6Y2QAGwdEcuseDwL7P0fQVQJ6CPz40OziYxNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(4744005)(31686004)(15650500001)(966005)(44832011)(2906002)(6506007)(6512007)(26005)(53546011)(186003)(41300700001)(8936002)(8676002)(36756003)(83380400001)(478600001)(38100700002)(66556008)(66946007)(4326008)(66476007)(316002)(86362001)(6916009)(2616005)(6666004)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtjeGl6WGhZTVdkWGRLWjNVQzhhM0NqK0tMTk5JUjUxeXpnK3pGd3RQSFc1?=
 =?utf-8?B?T2hVU21QdVZzRGprNGxjSExHVFFNdGdvNmhXMmRtV3lEWVZlRFQvZktuMngw?=
 =?utf-8?B?eGlaTVZaZ1dyOWN0OGU1bGtaOHZhMDBnOU5rSHJHZVpCTmhBandlUXdmS3BO?=
 =?utf-8?B?RElmNkg1OUI5VDB1TXk0NG8yZ1Y2MzRaZzZYUFJIZmlPSU9SbVhROVNZNEps?=
 =?utf-8?B?RzRnWi9OVEdSd0tuaFpGY1FXSGxHU2F0OGtCQ2RqYlRPL2NYc2ZwRUZDem4r?=
 =?utf-8?B?cUZZYzNCMExBYXVWT3NXMldFOTJRMCtqWE9MengrU3czVXlzUWt4WjBMbzZj?=
 =?utf-8?B?dE9zL0thd0RySjc3QXBsWndQUnZ2UGVFQ1F0dFFSSFNJK0ZDaDVRWTMyQXFr?=
 =?utf-8?B?TFRNMXZPdzkyTDljWVR0Mm9aZlUyQVJjdlV5c1ErRlJiWEJHdTFtYis4T3dv?=
 =?utf-8?B?UnFkNjFoVmNGVW85NU9nTlExMjFVTVBwU1cvTUJ0ZkVKZE5EdTNMNGtRY0xr?=
 =?utf-8?B?bHAreDAxTDQzc2NBaVM1czkyYUlpK2RlMTFTS0hDeU5CZ0VNdmRDa1p2Mzlq?=
 =?utf-8?B?UlRUQ2xjaFVTZDJsbXNYL0U2YTZFUVk1UXF5Q2w4bGU0Zm5ldTdhR09VbTdS?=
 =?utf-8?B?SnRjdlRqbkRYdm54cjh0YmRaek9XaWREZkxqbHFYcDBzWXROd1VLenVCRFNM?=
 =?utf-8?B?MmVERXBiYllKM1Vmd2QweTdtRHZpQnBIMGlSTjQyUy9ybGxmTjV1UFllZDlW?=
 =?utf-8?B?TnpTNFRpSTJHRU1peVRCa2Q1UVZ1dndpdkVkRm5WQldiN2prZUh3Umg5Sy9F?=
 =?utf-8?B?QkJCeEkremlyWXRLQVRYZlJjY0Nxc09SU1VhUHNxdWQxR1g2aTY4Y3hJK1Qz?=
 =?utf-8?B?czFPS3ZvSzBrWXhuV2ZhNzdKeXlYSTNyWGlGMmJJazY3VVhUc0VvenpTT2pW?=
 =?utf-8?B?SzRjQmpaMGxBeGtscVNreDRZdjNkcFVGYU5IZU5rL2VnMlQ0eGdhc2l3WitQ?=
 =?utf-8?B?SFhuS0lwN2x0ZkR6Nnp6KzlySUV4T1V6dDI0RnZnS1Qva0tnUW9aU3JjRVl0?=
 =?utf-8?B?cTZmejZSL2Jkc1FlVUtWeWxWc2lZSXVJMDhQS1JLKzRiN2RWVDFVTkZuV2pW?=
 =?utf-8?B?UjVRcyt6Vjk1R3d1bjJLYlFFcEl5NDZnR3U1Q21JTmhIa0ZRSEpFUGpXbEpk?=
 =?utf-8?B?bWVMeXp6UXlHcDdSczRrY2RKQ05TWnhDU2xJUXFxd3dmTFlqRTNYQUdsZ1Ex?=
 =?utf-8?B?RzhOSDlnZXdDbDA0YUhuU0U2b283VkZ5a2xNS0JvbTk3OVBrMjRJdkdmSTlz?=
 =?utf-8?B?Q29SUnBuT3dGTXNEeDk3bFRYeUZ4dUZ3ZmZWUit2dkRYaVppcVBQRTUwK3Bz?=
 =?utf-8?B?TlNwMU0yazcwT3FMWElPeUs2cEU2WVNiMkFJemtHakFOdDNtK3k5d2t5c2NS?=
 =?utf-8?B?NGttMFZpVm9mOUFiVzdXelREL1A3Q0Zoc09EZkYzUkdJVWlYbTViKzQyTGsy?=
 =?utf-8?B?c2JEN0FRc0FGa2Fyb2ZmYk9ZNlFvT1lGdy85dlNPY3RHOGdWMzNHS1VFTEM3?=
 =?utf-8?B?OUMxSGU0VXlBandtQzBYQ1FHYWJ4SDZMbFIvb3QxRm9zNVBPcXYrbXlHNzln?=
 =?utf-8?B?MUlTQlQ0UXp0ZXd6UHdHemtOZnIrUE5jT0QrczcxUGJzTTNqbGZRWHdxdmM1?=
 =?utf-8?B?MDR2Wk9JTVIvbVM4MUpEM1lITk5paUdadE1IL2pwVGN4WWt3K2hiaS9ML2Fi?=
 =?utf-8?B?UFM5S1BvWU95N0FKUC9qUXpwZ0kwMnlYS01tbUVoeUVtZHd4ZjJZRWFqTEc4?=
 =?utf-8?B?YVJUTW5vSElwcGRIR0JubEd4SytnRGxtM2FReTdEZkxrZ3F5RkwzNlVWdlB1?=
 =?utf-8?B?U3I5bDhBeGJoOE9TakV1MWJqdk10bGhPSElGSUYrU2NQc1JOREkwKzFkcURx?=
 =?utf-8?B?TWNBcHpSYjVwdVdWNzM3QkZuMUp3ZzN4NlU1QkZsWHR6K0dlUUtIZGhrVVZX?=
 =?utf-8?B?WGpza29rZVlFQU9DeG94RzhnazFHckdBb1NKS2NycUswbjRXK1F6Q0dhblAz?=
 =?utf-8?B?cDJGZXdGcVlzbWg1dzJBSmloK1pmNThTU2JoaEdWMHJMRm8rU1M1cHJyWVRS?=
 =?utf-8?Q?fa4FJH3z4LgE7iE4t0Ci5NzoW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64916260-9847-4ffb-599b-08db76321f16
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:43:04.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUu5OufjDXDZyk+xrZcPZ6NhSP/Ks/ZJNiUsLGRv/vbzTUp3lw7GKLIcUNrevZ/f7zhE+X85q3FgMrfgSRsDiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-Jun-23 4:09 PM, Ravi Bangoria wrote:
> AMD IBS can do per-process profiling[1] and is no longer restricted to
> per-cpu or systemwide only. Remove stale error message. Also, checking
> just exclude_kernel is not sufficient since IBS does not support any
> privilege filters. So include all exclude_* checks. And finally, move
> these checks under tools/perf/arch/x86/ from generic code.
> 
> Before:
>   $ sudo ./perf record -e ibs_op//k -C 0
>   Error:
>   AMD IBS may only be available in system-wide/per-cpu mode.  Try
>   using -a, or -C and workload affinity
> 
> After:
>   $ sudo ./perf record -e ibs_op//k -C 0
>   Error:
>   AMD IBS doesn't support privilege filtering. Try again with
>   exclude_{kernel|user|hv|idle|host|guest}=0.

[1] https://git.kernel.org/torvalds/c/30093056f7b2
