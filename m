Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9892573A579
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjFVP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjFVP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:58:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22891
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:58:55 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35MBprAZ027958;
        Thu, 22 Jun 2023 08:58:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tD9iET0Qu2QcxB6x5gqYURv38Db1hG92TXwJNLKh/es=;
 b=ieT/qy0+uN/V1tzVuCWZhlHzZFgtN/FYj4wk1bdn/SRN2Bwj2VWDkIjkTvk8AMU1n94Y
 +W0MTWu5+QM+DII8LDkzuh2ozixegqzegbvNfRHl/7i+0tgC02bn2X2Hytfy4TnfZxvv
 cTQePZNJubKACdhDk8AG3SQyMpi2bSPVmc1Odas6foGbYO4C15ni2tB0VomHRE7l2Lb7
 c2PDtr1sI9HPP2szt6pTbG5/sZ9BT3BNUUNv7s4UW2zdXmwcGUu3YGuTqa2zWy7EKFWH
 n7ZljiFDxAaShAdAH/XEhXMroyH6PURChypHZ6zoD1VMLCaQR5SAt32q9mcNxBuElf8e /w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by m0089730.ppops.net (PPS) with ESMTPS id 3rbnmp7ydj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 08:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGhl23X6tEj0sJgE4XPBDi2OikZKivQxD726BjDVDbEpX4U6vW2ksch1zDQn6Bn6dYPZKfSBIsj1+NXBRJ4kGtiSvi9AeWWqBsjRKRQ1iLNpdWInh78N0WcLMtE+f/tHEGltMCktiM1fg0oyCIAFnkxIknLCOp8MAUk9MiCrYlri0KuUKWLEjKaLiM0MrsK8ojZIHUYNBWiajz63upwp0rrmkNF/IocXNXAEsJKqf1LxwdDJ/Om9FP47R0yE3hlXVj0b8IJ8BKpH3Ncj5ElNNurS3p7HDOpcdpQbKKmpSVex5Wa5TUJicq0a8ejjNUVelFgllynjcT7t3mX0Qnf+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD9iET0Qu2QcxB6x5gqYURv38Db1hG92TXwJNLKh/es=;
 b=ATkZ6apy40raxr3BzJNwdgwZmGry7pXnUy2IxIckbGXMPMuj1UGw3iebUYkvIgSxKKFQEDo0J7Dof2Ixjt5NQjOPpAtjjHCECaiJ8EDy6bY0n1ze921CB7jxkwEDlO4fgZaHIOcKXx32das6YIP2UfVZxuBzHUZq3gAOcaw1hNK3GiaveSaELX1XHBbZaZXTdT7SuZe2DncJHqr+g6JhNKAQENQ1jKsxY5YS/QAcr/cS9NIZN+9Igo1Zq9bSn+3/VN7TQo7h+WRGQ1eJPolL8zfdxUvWuYtZpLgl6Aa6ZLKzbvT2BqkcHOUlG+mJu0iOlOyERZwNMygLz0DxzMj30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by SA0PR15MB3759.namprd15.prod.outlook.com (2603:10b6:806:83::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:57:52 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::1f5:8d6b:3b9a:77ee]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::1f5:8d6b:3b9a:77ee%3]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 15:57:52 +0000
Message-ID: <c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com>
Date:   Thu, 22 Jun 2023 11:57:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
To:     Aaron Lu <aaron.lu@intel.com>, David Vernet <void@manifault.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
References: <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell> <20230615232605.GB2915572@maniforge>
 <20230616005338.GA115001@ziqianlu-dell> <20230620173626.GA3027191@maniforge>
 <20230621023534.GA236337@ziqianlu-dell> <20230621024300.GA15990@maniforge>
 <20230621045416.GA237582@ziqianlu-dell> <20230621054352.GB15990@maniforge>
 <ZJKSyC29PfQcQsAr@ziqianlu-kbl>
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
In-Reply-To: <ZJKSyC29PfQcQsAr@ziqianlu-kbl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0047.prod.exchangelabs.com
 (2603:10b6:208:25::24) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|SA0PR15MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f51b48-885b-46cc-f7a2-08db73396f26
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qS2juoIMJY3DUmjBGRGeHoTbMWGjRoKSrpvfRjObT6CD0beNG27FKNSc7E51gXtQseZ3AnXmFQMn/JSLWB2ses+s1ZwgCq/uosNkP6+WQ951Bs5Loo4lEq7Kn37Boupj/nQUpH+LzDgSYUizonJ8hSPhBSoAWBKgInGX6AlL+dOiMRy3MD4Zawlx0lHmvNjKMounpB66AHmCdnnXyR3V0rMirmtprlg3D4AjWyM13W/mEtoc0GflWkoBXM8Hl7+kCQ+AoCYhC4JL9wp1v+7/FMCjaqHyX9VdszQV42oqGnxKFNQY/6J/NT45vAp5Nh/c4Wxk8t3dkbvBn/Hng9aq6KljyrSybZk2LTnxccbRcyLx3I6tlVzSeiN57Bl7E/XMb1g2Dn7l8OG0pJd4Jlol/bfgN2q0TXT+744b/wHzZ/BO045dpW1Di4PHKXQYI0qgJ5FrTGQ/+xPoE0t+j8QImdi9ksi5V5FdqnN4GdaM8mny6StQguwiUHZseebFfyhtwX9G8jNvYXX86CX+bEmsEDdt/EIq8a83V0RmgA9lcpxQbhk0YdLd5dIRbKoyVlBmlmUNnhrNGezlyqxCXdCAwypLT/hY21DA/caSV3Sd49xqsmGaf6huM2BbBMcELLnU6fm2pMoq/mKMMrMbJgXtCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(31686004)(38100700002)(6666004)(478600001)(4326008)(110136005)(2616005)(83380400001)(31696002)(86362001)(36756003)(53546011)(66946007)(107886003)(6512007)(186003)(2906002)(6486002)(6506007)(7416002)(8676002)(8936002)(66476007)(41300700001)(316002)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym8wc0xOc2lJc1Zxa1ZKNURvLzg3SVhiSklRM3kwZGRiQ2MwVUVjRHpJZURS?=
 =?utf-8?B?cXFhOFJKOWNzaURhSGtWOVd3V2xXdml1SktqakIzRVozdElGN1lPV082UUVq?=
 =?utf-8?B?U1I3emVvdk9WbGZJazMyQ2c1ZkxrNnVBM09jN0RaN3V4TVMyMmVqUE9JaEMw?=
 =?utf-8?B?anduK2dKQytGTnVHQVVvSmJESHVESUorSEhRWWcxWmkvZW9pTU5Zak54OWl0?=
 =?utf-8?B?KzdHWEhmdUF0T01sR2pOMVhzWlBvcFdFeWV3ekt3bHRFQitRdGFsckRYcjF1?=
 =?utf-8?B?SW5IUFloem9vYXh5dVhCM2VpK0YwMlhpQWtReTFLQlpZcEh6eHllOEVTZmRK?=
 =?utf-8?B?bm1xckdhRXBLSVd4eGg2dy9SQ09vQ2hEdnhDUFZvRUJOOFZ5UE1HbzRScVJn?=
 =?utf-8?B?Ky9uMjF6YXl1Kyt5OEtkcVBqWGp0c3F4azE1OGhUa2twdEJ4UTBIMkRvbmRB?=
 =?utf-8?B?RVRCR2s0VWVmVE5kay9iU1Y1cS9UeEs5VHk1bVQwV1NLU2Q5MUloRGthekov?=
 =?utf-8?B?U3FlT0sxckQ5OUZ6NFpySkRlYzBKLzIrTC9uNFRLWUJ0QUE5UFdGMlV1Tm1u?=
 =?utf-8?B?VHpka2RybmNDWURmTGV4bkdpN2VmS3UvZHUyM3pCQVhJT0dFaUxMZW1PUE4w?=
 =?utf-8?B?NmVlcVpEcHlJcXFPYmp1OTFiYWhxYlNLS3RvRWJkVTlTSzlqL0ZPV0JjQTFZ?=
 =?utf-8?B?czU0RGNQNHMxdmhGMVdQdDZwaHJWWEVYYUlJV05zaWkxTURIci8zZXJnbmJE?=
 =?utf-8?B?UGhSNkxvZFc3WXYyRmp4bHNEamtkT0RYWmFEL2dPeExOVHdkYWc0enhWd2Vo?=
 =?utf-8?B?eHFnYVJWRlBVMUNyY0dub1VDQXFkVUROamNhQVZjdVZialFEaGY5SWFKZkgr?=
 =?utf-8?B?NCs5U2g0VWJBRUkrZGx0RWRLaWg3Nk1oRFYxZXBxcWFBb09HKy9NZFhIL1l0?=
 =?utf-8?B?WFJrOFV3dE4rcXRCN25jRUZ3WDlJUHFHeGVOR1JuSzRHSlR5b1Rhay8vdmo4?=
 =?utf-8?B?bGlnTjN0ZzFQdkpZYXFMWVNmSkNJcFRMNE1XT3ljT3R3NjhLM0ZSN3J0ZHN4?=
 =?utf-8?B?NkZoU1ZVVFhRV3lkTVBuN1N2QUZQc3hSZGg1eHRNVEt3THJNWFBwK093QmQy?=
 =?utf-8?B?aCs0OHBaZGYyTDVCR1RLMDRNNzYzNXI2SWxkeXpFREpITUM4Z2Z3NEtEd2x6?=
 =?utf-8?B?Yms3d3ZHVERoaXhwb2s1TDlIK3RjWlM5WFA4NFB2WW5MSW43Y0hhejVLV2VV?=
 =?utf-8?B?SVNYeklEdFRmSnlnd2Iva0RSRy8wbkZnTDhENC9ISFBRZWhDbE5pK2NxbCsv?=
 =?utf-8?B?bVZMcmZmTTZodHVmVU9sV3EvVVZrSEtRNWtMZm0zb3p1WSs4UTdEOXJ6ZzlP?=
 =?utf-8?B?SSsweTlLaWh6TVczNDFHa3JFdTZKQSt2d2Z4cHEvWTZCR2NSUmJDbEd5L1Bh?=
 =?utf-8?B?Vmd1ZENySlNwVXVSR0ZzUEl6Vm5taEMyYkdMRC9ueUhtclhCK3UrRDNIRnFJ?=
 =?utf-8?B?RFBsbGd0eXNFVzFnL01pazUyTHM5MGkrdDhBRXFVUktsM21JSUZ4THFtWUFx?=
 =?utf-8?B?b0pHbjgrLzZTdURqZVJXZzh2ZzE2Sm9xMFdoaFFFczV6SWNHQUlJVk1seksv?=
 =?utf-8?B?LzFTL3RhczkybmlzdzVFcy9hRGpvQ2tVa1pHRDVZQmo2VVZvalQzaklRZXh6?=
 =?utf-8?B?Rk1nUGVWeThHeFBoQkpkQStOQzBmckFYZ2ZZMTBoZXlrWGxQQmduaW1TU04z?=
 =?utf-8?B?d1dGblpnWTNjVzZpL3FUQ1IwWjkvL0NmL3ZJRjhQOTN1MHBmTTZJaEVhUFhV?=
 =?utf-8?B?WG8rbGlJaVBobUJPY0UyQ1pRalA4aVFjbTlwUWpWaEtsYWpCWndjUFI2WFNZ?=
 =?utf-8?B?VFZuWVJmazhqa1QvWEFyc1g5azFaTnYwT2haL3htRkdYc0I2MXdaSmFUZVgy?=
 =?utf-8?B?TkY1dmVGcldUVzNQWmwvVUFnQy8rSzhrbk1GVXlYeUpxMEJIOXVkRlZ6YWo1?=
 =?utf-8?B?cXRnUGhINlA3TTQ4eUt2Y2hON2daOW5rOFgreG9tMjJhdmJpWm01K1Fvb3gy?=
 =?utf-8?B?RytybzZBOFk4MS9TNnlzTVo5N1BRbzJxa1drNTFTcWlDZEdsa3p3cEJuVGRz?=
 =?utf-8?B?WlcxT215eklWSjZ0K09Ib21BNzB5WHk5MUd4ZDkzeDdkVkMzc01pU1JyTlZQ?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f51b48-885b-46cc-f7a2-08db73396f26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:57:52.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4aVV7663SLyQQabfLjVOZJ0oVbG1VA+1q1wNezNgALjGYrMRIh4KRQWHTqJI70/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3759
X-Proofpoint-GUID: b-8ViZmmnNWkkh5gKvTk6HQrtyOXC6ut
X-Proofpoint-ORIG-GUID: b-8ViZmmnNWkkh5gKvTk6HQrtyOXC6ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 2:03 AM, Aaron Lu wrote:
> On Wed, Jun 21, 2023 at 12:43:52AM -0500, David Vernet wrote:
>> On Wed, Jun 21, 2023 at 12:54:16PM +0800, Aaron Lu wrote:
>>> On Tue, Jun 20, 2023 at 09:43:00PM -0500, David Vernet wrote:
>>>> On Wed, Jun 21, 2023 at 10:35:34AM +0800, Aaron Lu wrote:
>>>>> On Tue, Jun 20, 2023 at 12:36:26PM -0500, David Vernet wrote:

[ ... ]

>>>> I'm not sure what we're hoping to gain by continuing to run various
>>>> netperf workloads with your specific parameters?
>>>
>>> I don't quite follow you.
>>>
>>> I thought we were in the process of figuring out why for the same
>>> workload(netperf/default_mode/nr_client=nr_cpu) on two similar
>>> machines(both are Skylake) you saw no contention while I saw some so I
>>> tried to be exact on how I run the workload.
>>
>> I just reran the workload on a 26 core / 52 thread Cooper Lake using
>> your exact command below and still don't observe any contention
>> whatsoever on the swqueue lock:
> 
> Well, it's a puzzle to me.
> 
> But as you said below, I guess I'll just move on.

Thanks for bringing this up Aaron.  The discussion moved on to different
ways to fix the netperf triggered contention, but I wanted to toss this
out as an easy way to see the same problem:

# swqueue disabled:
# ./schbench -L -m 52 -p 512 -r 10 -t 1
Wakeup Latencies percentiles (usec) runtime 10 (s) (14674354 total samples)
          20.0th: 8          (4508866 samples)
          50.0th: 11         (2879648 samples)
          90.0th: 35         (5865268 samples)
        * 99.0th: 70         (1282166 samples)
          99.9th: 110        (124040 samples)
          min=1, max=9312
avg worker transfer: 28211.91 ops/sec 13.78MB/s

During the swqueue=0 run,  the system was ~30% idle

# swqueue enabled:
# ./schbench -L -m 52 -p 512 -r 10 -t 1
Wakeup Latencies percentiles (usec) runtime 10 (s) (6448414 total samples)
          20.0th: 30         (1383423 samples)
          50.0th: 39         (1986827 samples)
          90.0th: 63         (2446965 samples)
        * 99.0th: 108        (567275 samples)
          99.9th: 158        (57487 samples)
          min=1, max=15018
avg worker transfer: 12395.27 ops/sec 6.05MB/s

During the swqueue=1 run, the CPU was at was 97% system time, all stuck
on spinlock contention in the scheduler.

This is a single socket cooperlake with 26 cores/52 threads.

The work is similar to perf pipe test, 52 messenger threads each bouncing
a message back and forth with their own private worker for a 10 second run.

Adding more messenger threads (-m 128) increases the swqueue=0 ops/sec
to about 19MB/s and drags down the swqueue=1 ops/sec to 2MB/s.

-chris

