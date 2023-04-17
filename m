Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9066E4240
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDQIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjDQIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:10:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A43558B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:10:41 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H3N4qW014276;
        Mon, 17 Apr 2023 01:10:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 from : subject : to : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=iJftWS3GesfKz4XKpjpyvS1J74LKzydTYSPe9+ExzyU=;
 b=b7OVCSAlH17Urp3rSywBoiWHoOepj8R0D/EGJE6BkVtEN7guA6lDRZqiqa7ERaP6aw2s
 +pvhazPFOG7buHvA1U5BiorLAfXKToMOpkNsMkxBwXkpEbGt4gOECkW1YsKLAun973HB
 vlHCWISl/cbx74JTpyUwCrBHhNbM+oiSeSsXU9wdNO0u2WbwPCC8FSmdcWzBbmnQTg8B
 rAvMzLKcJsiCUYuATffWosdcWL866Ga2yKiaOnhAd/y7xVOaHB5xwtP+nAeziRhFUQqW
 nnQbpr/uxHktWg/JKTr0wyMthU01uc32ZGasDdFwmfW4hHk+4x96sa3f0LLLyoklkdC/ 5A== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pyq8qqwfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 01:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnJsOj8zhoPQAxl7066mDpzsJVsXY1/1Z8Kb08S5aQApftcOF0lXy2k+HevkVk541CarMgQwpwzfDxMQEoQSYKycApqmnQ0dGKtCJO1w2KXvQIafBk5OOsXjtOwXshB/GlDjebhN5JZa23vl9jx/GXndbX/6UHAbvyVlhnDJ46XsKmEYkZAW+iAoD5bZ+eGJ2vuUb5WifjQFJ9L5v2py5meqUE2Ufrn/O9NZaAu7Ky9lLlnZoCHo4/QgIVeMfOrpXCEyJb8WMJJeREyUmn5usBi7u2MYGI294URGjyI/w+7cXDTkHeOS7DxlXShOVNcbQqyB+swAn+DgstUsEt7qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJftWS3GesfKz4XKpjpyvS1J74LKzydTYSPe9+ExzyU=;
 b=i2op/zbKd2CYLfGxPWzDHWvOMMx8dFxVdmF3uMXdSSitlb7PuYfVdcwkWGOJ3ko1rkswiwSnyAW0usGb0AtD/q5Q+NVYXhD8QFmztOq90NJuPDW8w3egJrr/2sE45CvqJXyb0edfw5fxj90PEBdApcLOXoHhDov3hmYzuL/qVB2fgFfsmkfDfWutoFxsA5BVqLimkXZUnRpkWFNvNnVRSzyy7T5Gon+LpwL4LKRDq4UcTGB5ySDv71dz5mlL/f3IaNACJ6QsNeMpbe2UvMq7CPA/IZwiqmJ9FzmVVgm2buP1pKqL1N2aieS/bhLd44YeAB0shj4wwLu54/D8jhBWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by BL1PR15MB5338.namprd15.prod.outlook.com (2603:10b6:208:385::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 08:10:30 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::48fd:d25b:5e9c:7fd8]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::48fd:d25b:5e9c:7fd8%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 08:10:30 +0000
Message-ID: <bc85a40c-1ea0-9b57-6ba3-b920c436a02c@meta.com>
Date:   Mon, 17 Apr 2023 10:10:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
Subject: schbench v1.0
To:     Peter Zijlstra <peterz@infradead.org>,
        David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: LO4P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::15) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|BL1PR15MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ee65a1-739f-4795-5020-08db3f1b356d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wJPAY4AwQXcBKijs4aaahzyVVYgi1J0HvjzDdC9++5ruAGxvqPrKZyAW41gqN/PTP1FUrQFUEMUHf1++MKTXD82F3i1i92t4UnSSsm/c2NnEs99PicndKuVx/nsGxMn9k1x9WjNntDPW12vtZMeJG0U102NyaEIGCE/GBHAsnIxH8kJ/1o05N8Z8+kVYvyeKB0tUnzV4RkjK6ngJyNAnqxg9TX4E9TlnTKMbSrY6jeJp+rRJW9QjH6T2nJsPmtK4UWwzJgCWJoj5RT8eydhFnqrCOF4VG89wQ53kIc+p4oELemCtVw5gHpaSCwEZ6RlY9GKEsPp6qkEoiXaBWpOia95MLE3IJ7PUKR5J6IxFY/9ZdrusGQUJkTyg1qq8P/sVBFdEL8UnDCyndT5YBGPAUXDLdoAZLeBSRcdnUFwRQ9WA9NzsO1gCjTDCJVWWZ/QOWM5JRqTRSXDOxhvGWJm95oNIzWUSmxb2S3tlH8kSrDHY0+8HHArexuV8w2XURfIbbT2O9PWQJ8bSbY2pOjHLN7IwqHqrsPwp3s4W6ORdxdeUxW0X1WtB64RUAhnuWHifQrh+LbFdfURuVNixY7E13xjGy2Mey1swPGjRbhyppfsjCfWN2mQofiJ48WXYxEA2UiOj6Pc8Gz8PpJBD8klbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(36756003)(110136005)(316002)(66556008)(66946007)(66476007)(966005)(6486002)(478600001)(6666004)(5660300002)(8936002)(8676002)(41300700001)(2906002)(86362001)(31696002)(38100700002)(2616005)(6512007)(6506007)(186003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJPVkhJQS9kUG53N0Z2OGVJakRCd21mSDE4Z0ZKWTFuUUxUakRHcGxwVFhu?=
 =?utf-8?B?TWZzNW12YU5Bc085M2JRcC9wcko0RS9WLzEvOHpKY3FDdUFnbURGWEU0TnNu?=
 =?utf-8?B?MkZtYVBYdmlPdk1WWGVra2pBLzIrVmxmM01YUHVQdGpFaDZWUU1uWWFiRS8w?=
 =?utf-8?B?dnJTQ3pMSTZiR1pCeU9HKzVuOGRLTkswZ2VPcy81OVpaNGlCVC9Xc3UvdnBQ?=
 =?utf-8?B?Ri9XRk1ReE55cU5oOUUwWkFGQTkvMkZuNzVjVUJmS1hLV1ZSQTA4NjA2c2Vz?=
 =?utf-8?B?dkt3M0NWenM1alFJWEhzVGNhNXBiUlNSSDdHNE43d1ovNW9ybmJKc3RqUG1u?=
 =?utf-8?B?L2FkVmpKbmhyTWpqZmt1ZVRrSzlSRUR3QmhpWjlDZjcyK0h6T3J0bWU0emZ3?=
 =?utf-8?B?dkpKNjc1QmVaeVc5cmhBLzdxcCs3UlNNUkRzQnJnaXMva2p0bjU4YkRzVm5J?=
 =?utf-8?B?UUVrV3ppT2pxZE1TZDAvOEFUVU5oYjI4dHhtODBLdGx2dGx2NitmbEs5ak9P?=
 =?utf-8?B?Q3l0aHZiVXdkdDlERkFLdTFnRml2cFlmSXlQNnZITFdESkVzVndTSGlTN2hh?=
 =?utf-8?B?VmFaaFRraGgxa3VhRHRMTkEzRWRiN0JJYUhSaFFwaDFuMjdoNDlZTm96UVFL?=
 =?utf-8?B?dEFOcHVLS3g4em4xWmFob011UmhvOHRybU83RENRYlNaS3QzYS9mSDlMbHQr?=
 =?utf-8?B?MVhVdEE5dFpkbVVtQnppemVRbnhLSWJFL0NQYzJoK2UzT3ZHTk5jNlhOQ25E?=
 =?utf-8?B?US9wYTE4T1lKbm9lbE9XUXJhMnJzcGtselc1UFVUbHpSYlU3WkNLSjVCZmI0?=
 =?utf-8?B?ZER3SitEclBKaVFLVHdFdVo4NEg1ZW9SMFlSYTlLdlprUTBMY1E3bEZWTlZk?=
 =?utf-8?B?dW1NUXFiM29QUldHa1U5bHMzcENaNSt5V1M3ekhlZEZOTGFqR2tqL3pGMEx1?=
 =?utf-8?B?WnZTWlM2Ty9MWW9PbVNqTDNyYTdqMWhFVUxkaUZXL1paQTNtWnF3dDJpZnhT?=
 =?utf-8?B?Mzdua2c5Rzk1VjIwOGdQeWNUcWZZNGFtekVkS0RuUmtIMHVYQU5kdlE5VXpL?=
 =?utf-8?B?U0U2dDM2OEdSYVM3US82ODFVbWpFYmIvWXp2TEtJNUtqenNNeTRUVWJ2cmpB?=
 =?utf-8?B?QmRYcnRSYmZ4c1pLZktVdFBGUGFpM3l0ZXJNQ1FSY1AxWjIvZkxVYTNTamEw?=
 =?utf-8?B?NVAvMHlVNkpuVlZ3MG5ybWJWUE1SVDlGUFBRNExsQlNYK21EN2hjMTE2MGtQ?=
 =?utf-8?B?UFVZdXdldVVob3ZlVkZuazZrK21oMzFiN1dkZUlJaWNsWjFxK0tUWWlxOVZq?=
 =?utf-8?B?OFp3TVc1ZWFLb1JFU3RWZHJzL3ZPMThLSHZPK0hSSEphZmdnMHFIZmJpOWdw?=
 =?utf-8?B?cjRYS0dxWFBubXVSeTZZZkd0Q3FUSkxtZDByejZoSGlqVmtGeE1wbW9XMFhB?=
 =?utf-8?B?eUVvM2l2ODVqWHkyVG9sNGJSWVpLRDhzcjcwUDJKczhIOUZBSnRRdnB6MFFi?=
 =?utf-8?B?UmFPZTV5eUtPb0dJTGlPNTNWeHhSd0RWeGVLVWcrYkJMTU4yVlcyY2VkM0ha?=
 =?utf-8?B?M09JT0hNWlpIM255b1hrMFB3UkxXdXRzc2IxWGxaZ08xdi9vcCtCK2s5c2ha?=
 =?utf-8?B?anlwd1F4WHNPSHhoTE4wZU1IcVdnUG5wMStPaXhET3FKQzZ6eUlHRjd4OHhP?=
 =?utf-8?B?K3hXOHNUcDZ5b2lmcS9tSTRmTjROeUdPbUkwdFJvSTgxNEMxNVpFUm1RYldw?=
 =?utf-8?B?aGlBZDMyOWlmUW1URldGUitRREIzSzJRR1dtOTh4SXB1eHU2VkZXWXc2eVEw?=
 =?utf-8?B?bitEb0ZUYUlRSTd4U09QOVR2SEdCK05ZU2FIZ1o2dTFKQm1rQ0ZYMUpOWGNl?=
 =?utf-8?B?OS9ocTNzbnZQcHg4N0pTUzMwak8rK3NpM0lrVGJrREZ5K3RnR1QrMFNHdGZO?=
 =?utf-8?B?WHJQY1U4T0FOMjVoamxrTTlveGJCdzBIeVpTTTJ6WEd0eU9DZFdlc3hIUXdX?=
 =?utf-8?B?SWdYMGs5QVp4NnNjdEtRUmZ0aU1NRC92T2hIallLbWR4ZzJUUmNBYzdOc0VK?=
 =?utf-8?B?TkoxQUJXZXhvdTl1SWcrTUhWd2pHaUlhUDhtMW9aY0ZOa0huNHNVUlpZeVgx?=
 =?utf-8?B?eEhUd2FHOUJaOEZCSFhiVEJrR2hpMjdTRzdrU2dCUW5UL2Z4TXo4MlZxMGsw?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ee65a1-739f-4795-5020-08db3f1b356d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 08:10:29.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/lq5gDI3eMJIcNQqXS7OnHUkZdSx1C81xdD17AcHZ58auYptUI4VNUDRfquQ00N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5338
X-Proofpoint-ORIG-GUID: lstR5KKNOjy6_rPFQuzYqMja16CdtlhC
X-Proofpoint-GUID: lstR5KKNOjy6_rPFQuzYqMja16CdtlhC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_04,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Since we've been doing a lot of scheduler benchmarking lately, I wanted
to dust off schbench and see if I could make it more accurately model
the results we're seeing from production workloads.

I've reworked a few things and since it's somewhat different now I went
ahead and tagged v1.0:

https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git

I also tossed in a README.md, which documents the arguments.

https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git/tree/README.md

The original schbench focused almost entirely on wakeup latencies, which
is still included in the output now.  Instead of spinning for a fixed
amount of wall time, v1.0 now uses a loop of matrix multiplication to
simulate a web request.

David Vernet recently benchmarked EEVDF, CFS, and sched_ext against
production workloads:

https://lore.kernel.org/lkml/20230411020945.GA65214@maniforge/

And what we see in general is that involuntary context switches trigger
a basket of expensive interactions between CPU/memory/disk.  This is
pretty difficult to model from a benchmark targeting just the scheduler,
so instead of making a much bigger simulation of the workload, I  made
preemption slower inside of schbench.  In terms of performance he found:

EEVDF < CFS < CFS shared wake queue < sched_ext BPF

My runs with schbench match his percentage differences pretty closely.

The least complicated way I could find to penalize preemption is to use
a per-cpu spinlock around the matrix math.  This can be disabled with
(-L/--no-locking).  The results map really well to our production
workloads, which don't use spinlocks, but do get hit with major page
faults when they lose the CPU in the middle of a request.

David has more schbench examples for his presentation at OSPM, but
here's some annotated output:

schbench -F128 -n 10
Wakeup Latencies percentiles (usec) runtime 90 (s) (370488 total samples)
          50.0th: 9          (69381 samples)
          90.0th: 24         (134753 samples)
        * 99.0th: 1266       (32796 samples)
          99.9th: 4712       (3322 samples)
          min=1, max=12449

This is basically the important part of the original schbench.  It's the
time from when a worker thread is woken to when it starts running.

Request Latencies percentiles (usec) runtime 90 (s) (370983 total samples)
          50.0th: 11440      (103738 samples)
          90.0th: 12496      (120020 samples)
        * 99.0th: 22304      (32498 samples)
          99.9th: 26336      (3308 samples)
          min=5818, max=57747

RPS percentiles (requests) runtime 90 (s) (9 total samples)
          20.0th: 4312       (3 samples)
        * 50.0th: 4376       (3 samples)
          90.0th: 4440       (3 samples)
          min=4290, max=4446

Request latency and RPS are both new.  The original schbench had
requests, but they were based on wall clock spinning instead of a fixed
amount of CPU work.  The new requests include two small usleeps() and
the matrix math in their timing.

Generally for production the 99th percentile latencies are most
important.  For RPS, I watch 20th and 50th percentile more. The readme
linked above talks through the command line options and how to pick a
good numbers.

I did some runs with different parameters comparing Linus git and EEVDF:

Comparing EEVDF (8c59a975d5ee) With Linus 6.3-rc6ish (a7a55e27ad72)

schbench -F128 -N <val> with and without -L
Single socket Intel cooperlake CPUs, turbo disabled

F128 N1                 EEVDF    Linus
Wakeup  (usec): 99.0th: 355      555
Request (usec): 99.0th: 2,620    1,906
RPS    (count): 50.0th: 37,696   41,664

F128 N1 no-locking      EEVDF    Linus
Wakeup  (usec): 99.0th: 295      545
Request (usec): 99.0th: 1,890    1,758
RPS    (count): 50.0th: 37,824   41,920

F128 N10                EEVDF    Linus
Wakeup  (usec): 99.0th: 755      1,266
Request (usec): 99.0th: 25,632   22,304
RPS    (count): 50.0th: 4,280    4,376

F128 N10 no-locking     EEVDF    Linus
Wakeup  (usec): 99.0th: 823      1,118
Request (usec): 99.0th: 17,184   14,192
RPS    (count): 50.0th: 4,440    4,456

F128 N20                EEVDF    Linus
Wakeup  (usec): 99.0th: 901      1,806
Request (usec): 99.0th: 51,136   46,016
RPS    (count): 50.0th: 2,132    2,196

F128 N20 no-locking     EEVDF    Linus
Wakeup  (usec): 99.0th: 905      1,902
Request (usec): 99.0th: 32,832   30,496
RPS    (count): 50.0th: 2,212    2,212

In general this shows us that EEVDF is a huge improvement on wakeup
latency, but we pay for it with preemptions during the request itself.
Diving into the F128 N10 no-locking numbers:

F128 N10 no-locking     EEVDF    Linus
Wakeup  (usec): 99.0th: 823      1,118
Request (usec): 99.0th: 17,184   14,192
RPS    (count): 50.0th: 4,440    4,456

EEVDF is very close in terms of RPS.  The p99 request latency shows the
preemptions pretty well, but the p50 request latency numbers have EEVDF
winning slightly (11,376 usec eevdf vs 11,408 usec on -linus).

-chris
