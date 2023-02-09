Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C0690017
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBIF56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBIF55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:57:57 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5A71B548
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:57:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azs/KFFrZaQEp6PnABUtOFvnnR8VEChBea487Igi2jN/GhKyVb0haq1ckiPCmxhl3noq/hIcZcIDCtdyGtUD6ECdNKsRheUn4J6z8ppIelnIi712zx7we5qzLATbcwflNYrCqYq7hUre9VluKF2f4EPxHPb7Temcwb/VT8FU41FRtPFNNJj0Wb38x9vtKkKK613RJbtKFA6YNk0Vw8JqmznLNSyDhAx9mEy9nOXQHulXBC41PP+DBNBKW3+/wr9pTQoetb7XBL9RUAAAXCuWWQEmFBDkBSimp63YzWn7SpagYd1fMlmUBwkgfu8al8CJ8k7fLtsvAL/qnHtrHlTUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiEpcWT0ZJfF28mbcVDlbgLlnMKS9EfSwFV5ktB5nxE=;
 b=lPVJ+IxCLSFzKPHrStqw+B/JHVrXYH7BQDgQ/W3BIjCFBQKwLc0SGUfQz8vYy9GFB6gyvHkylj/dBvK8YY1bB8Yfvsg8jupu87T5PrRTJ1CRyM9+kwTeKrUq+mzAeCO1kLPHpb0X8YuxtzqFjufESmQMbt2aRz351GXrvBdE9U/LG+uR4r7ewpInS2mUccRKvTvdU1NXN27KsWDOkI08AkftfDb1nK4csGqfqhbYABmVuZHNrn44yaLZAkoDX+mtG8JQNMVnuq8JojtObeBMLNAnNOT6KbMzqM/RAh0wFeekvcdEURyoib3TNrSIkNsOK78vgm2SljAKNdIpoqcB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiEpcWT0ZJfF28mbcVDlbgLlnMKS9EfSwFV5ktB5nxE=;
 b=nu4uVqUouT+IuvdC1mXujLzVhJC25VrIU3nIn1tfcLwvlvVmOuV+IwVCoxvH4A5kGpgFntEsuay5XJ3ohjeNbz/JHlW0Abk22Zb48k/1z1Ce+syTcz5uKz48YypTzpaJlXy+Eg87/w+XJDfSxGRYIGtkjU0+ZCsTegEfZgtE+ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 9 Feb
 2023 05:57:52 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 05:57:51 +0000
Message-ID: <a0127c3c-22c9-ac46-1e9f-200978fec392@amd.com>
Date:   Thu, 9 Feb 2023 11:27:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com,
        Ravikumar.Bangoria@amd.com, ying.huang@intel.com
References: <20230208073533.715-1-bharata@amd.com>
 <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 3265db30-a572-4a4a-a3fd-08db0a62943e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aaOZhfr+j8wt5vU4TDcyp5XPkczkKDPi9CL97/yU5pZGizZAjELDdHizPSZdFhgrJR2jl7kPyikWhDt4QH7I2mXfkWEykYUjdgRUk2hHfI4DX1j8fWPEJIVVeqZrt+Rusof8TTpKml+KD15T/VnNLjb6ZvQYG3Jp8gAZ6sbdJwSjk70B3aqTh8h2JHXlL58TUVByp16cjHI52Tpj4SxOJLJLsvgg6uoyHwWXO5ZFFmKURzBsafYrfc1AqkPlNI8sYuhfiC32KfoN28PH8HxePnwGpcYcckDbLlE3XlZYxj8qs8WS2m/XGabyyNjf12JN9Hc6bus7N/TcTZ2bYSXTGMf7WJIIWm8Bp3SlINKBa68+CiNbJUX0UYVzYhzChzRXSSU5pJ/8Ya/B7zWNjb6o79iHsFDNVQuigVxZaVfGqlmMOUKiVmDA8j4Hkj9+8BWT3lrtlU6UjW+WpRXbOvzcRsgAR3Onw8NySuTKlbg6bgIu348ydJlkoKrx/QvziovqD7+Ic74kJszs4HTdw/ZRDzZ29Cm/tJ6o3DjcX5nu4nx8xjw3wHv/CwcBJ0LZtOW3eraO5Aaxak4tvruO2NEQrV4PjzuuWmBacEOruVm2YPKm+eaMHQvYb0bizt0istpuetXKNnKys10ot6Tip/5bjPHLKhrPwV4Ev1dMwl5JHfRNaXPi4NXrhvBzXdBNZf5zTTfElOBZmz3VyPv9bJ7AtJZPqfFGaHUgUxp7IGexAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199018)(2906002)(31686004)(7416002)(36756003)(8936002)(5660300002)(41300700001)(83380400001)(2616005)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(38100700002)(6512007)(86362001)(186003)(53546011)(6506007)(31696002)(26005)(478600001)(6486002)(8676002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bllrdERNZDFxVTJtTXhCV2w0a2VUa1E5M1ExYnE1VTJRL3lxaFdiSzhWUy9T?=
 =?utf-8?B?SitkdVY5YWwxM0E3WEMray9wcHJtTlhDdGFSK3Nsa3BjcG5qRFhnUnZGVWZP?=
 =?utf-8?B?NlRRaG1NSXpMS2Z1SzBrMFd6cDh0TlFPYkN4U3gybjBaUzRza3liWlZ0MmNj?=
 =?utf-8?B?U0JFQzBidktYNXduWXhtVXl0L2hoZ0dRRHhZRG9qYS9YOXl1NWM0cDFHb2dD?=
 =?utf-8?B?Zjh4N21hT1QxYkxwVlNJcWd5a2p6ajNVM2txVU9CMzkwYkhBZWUzUWxIelhq?=
 =?utf-8?B?em5YdTNLTGFERHJQaklMeTVPSkd2Y2tUNGE0NHc0eDRiaHhnVVdXZTQyTHBO?=
 =?utf-8?B?SHcyMjYwc01EOEo4UzBnTUhuellFNVF3R3lKcVBFcHJoMHBzK1RBMGpJRlV4?=
 =?utf-8?B?ZEJobFFBdDVUY2o4dzBicFNnbkp0UUVEUVRHV3VLMHJIZEFlaWJzRTUrZ3RE?=
 =?utf-8?B?T0tUOE9KdzU3d2UzaTRmckJSbjloVzBZdlFhUnFXU09rRndKcVVSNFJVbGhI?=
 =?utf-8?B?MHZJNmx2eW4vcG5zWW5UellRa0J4ZXk2cllGMEJBS2FaM3dwSFB4ZlRWTGFW?=
 =?utf-8?B?cVdiR1BlZU1UOHJXU1hPam1oL2ZTQi8wN3RmODI3QnI3Mzl0N0djQUpiVWJl?=
 =?utf-8?B?U3o1UGd2MUJZbFhCbWkrNERldU5QWmtiS25XTTI2RnR2QjExK2NOTmNzY3Ry?=
 =?utf-8?B?QnBSQ0d5T2RCN1lRazA5K256L3JJNE9kMEJXYm5SQTFqelJQV0NNWXZRNnVn?=
 =?utf-8?B?WUE5VUdMWGF6eFFsQ3dhZ2YzcUsxdFdud2JnTVdIdlBoclFra0MxeWd2N0JH?=
 =?utf-8?B?ZHlzSzdEQTBucVFsRzZCQ1ROWDI5NUQ4ckU0RlBjZDl3bmt2cXN6OEthQnZG?=
 =?utf-8?B?VmpPd2JqcDZ6dXV1ZUFSTTh6TW9RSmpsekQxb0kwaWZPcFBPbmE5QmNUUnd3?=
 =?utf-8?B?djdCU1YxbWVJM0VVMjcxa0tHOUVhRW5kUzMwenV4clFrU0ZpRFJPQ0hJZVFx?=
 =?utf-8?B?L3dSeEc5LzdSTnZFYnRSTDJHKzlqcTNLZk5maDJmU1pOTDFqcm9ZNWs4eWhl?=
 =?utf-8?B?ZFhJUUVXaVFUV1h5dHo3eFU5aXMzMkZoaWM0QWE4MnVVSHYrdFJZaE9tQStI?=
 =?utf-8?B?Z3ZyREN0Rjg2ZityWHJpYnFqeDBCS1FoNDVPWW52MmNjRUxzVXEyYlJIcXla?=
 =?utf-8?B?YU1FV3U2aDQzRnlsSUVmSXBVVXZSdVdQZlVtemp0cGhSN3B3cWNwcnlhZ0NF?=
 =?utf-8?B?RnNkLzF4U0ZiSjJFeG95YVlrdzJKNzRMSkJaNkIrTFlCb1JwSWxqZlZycWFS?=
 =?utf-8?B?OGU2Y1JLMDFlUndTdnFXY1VWRjgyeUFCU1JnZ2R3Q0ViOFhvWkVWWms4bzBZ?=
 =?utf-8?B?OUNJM3Y4OTMrQmxDTThpM2RCaXhyUlloZjJoTGJJSEtKclhOL3NkQ0xENlJU?=
 =?utf-8?B?TUk4K3NuZ3N0UVZ6ZVdyL3lwSUc2Umo2dkhVMGROYTc3cTV6VzZ0STRWUUR0?=
 =?utf-8?B?OThmNjZQSVJYbnNvQVlLbjdVUVh0Zlg5WUNaRFVHa0dmR1FIYzRPckhza3F5?=
 =?utf-8?B?aHhqQjRqcHZ5NXl3SHdKaTVrbThFS0pwcEdXeEs2R3JGY2pOTzBZWUpoc1Bu?=
 =?utf-8?B?TzZlOFlYYWtZc3pqM21EY3l1ZWNTMXFvbUZXSVd3NHNRNDNlMGQxeE95NS9n?=
 =?utf-8?B?TTAzWDdGSG9UVUlTUW9KWmNNd09Dc1dkSVVGTlRyNFdVM1BYNVZJRjNaQTVF?=
 =?utf-8?B?bzlZMmNhcU9UN1E0WjZMeDBpS2IzdFE1bHFFdGZUNTg5bUlvWWRkbmFZcUV4?=
 =?utf-8?B?T1lMNFdkZ2Q1V0JxcndSSDhPSnFsSkhSQmZsVklhUnVIOGk5ems2cjZ1MUtI?=
 =?utf-8?B?bk9nbUs0TVNuY2xqSGVVaHloYk82QTZNTnRmOWR3cGM0QjRrbzEvTlpXZ1hQ?=
 =?utf-8?B?KzVpNUVJZWE4ZFJveXh0Q2IxV2FPeVllbG0rTWZRTXBFR1NCNEp0WSt0Q3lC?=
 =?utf-8?B?Tk1HTTZLeTJGZlhOYk1WYUR2STNWeDZkSGVlN01SL2RDb29hc3dDMStmVU5q?=
 =?utf-8?B?R1hpcjhNVHNkZWdyZ2sxT1dwYmNHOWxWVXAvRnAvYy91eUszK1BIZDJ2Ymg1?=
 =?utf-8?Q?8N1xUv6MiW3uVgO0XiKu5OZbL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3265db30-a572-4a4a-a3fd-08db0a62943e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 05:57:51.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0P9E+2UM1clqEBb+9R20EXXF3+kmA5nYjVAB0fj8b/bOl67J/PxsFwZrh/BS9jfp8RqF6m/D2kQSB5ZoSfu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2023 11:33 PM, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 01:05:28PM +0530, Bharata B Rao wrote:
> 
>> - Perf uses IBS and we are using the same IBS for access profiling here.
>>   There needs to be a proper way to make the use mutually exclusive.
> 
> No, IFF this lives it needs to use in-kernel perf.

In fact I started out with in-kernel perf by using the
perf_event_create_kernel_counter() API. However there are issues
with using in-kernel perf:

- We want to reprogram the counter potentially during every
context switch. The IBS hardware sample counter needs to be
reprogrammed based on the incoming thread's view of sample period.
Additionally sampling needs to be disabled for kernel threads.
So I wanted to use perf_event_enable/disable() and
perf_event_period(). However they take mutexes and hence it is
not possible to use them from the sched switch atomic context.

- In-kernel perf gives a per-cpu counter, but we want it to count
based on the task that is currently running. I,e., the period should
be modified on per-task basis. I don't see how an in-kernel perf
event counter can be associated with per-task like this.
	
Hence I didn't see an easy option other than making the use
of IBS in perf and NUMA balancing mutually exclusive.

> 
>> - Is tying this up with NUMA balancing a reasonable approach or
>>   should we look at a completely new approach?
> 
> Is it giving sufficient win to be worth it, afaict it doesn't come even
> close to justifying it.
> 
>> - Hardware provided access information could be very useful for driving
>>   hot page promotion in tiered memory systems. Need to check if this
>>   requires different tuning/heuristics apart from what NUMA balancing
>>   already does.
> 
> I think Huang Ying looked at that from the Intel POV and I think the
> conclusion was that it doesn't really work out. What you need is
> frequency information, but the PMU doesn't really give you that. You
> need to process a *ton* of PMU data in-kernel.

What I am doing here is to feed the access data into NUMA balancing which
already has the logic to aggregate that at task and numa group level and
decide if that access is actionable in terms of migrating the page. In this
context, I am not sure about the frequency information that you and Dave
are mentioning. AFAIU, existing NUMA balancing takes care of taking
action, IBS becomes an alternative source of access information to NUMA
hint faults.

Thanks for your inputs.

Regards,
Bharata.
