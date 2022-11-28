Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B763A762
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiK1LwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiK1LwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:52:14 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F711167DB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQBzwepe1qkdK+3BlY3z73HELHetFF87GevfFxYh36cGtUJaQr8kMejJEonvqKwHBr753g3FF1s3MQsnSPa6N3NWPRWQXSrrinffMvBva2OLGDi3F1fLPLGpBG9tlsSY8w/gJoi2gZbYLOwxFbdL8gBiChu2n8Z42z+O1hlyyTLGpvGR4Cg5iolvmW+n8QlAWdfz7huugYnK9MVkbzmlsl67M3KfTgWWArvH2uckd6gAcmDgnGUDGnsbvhC3oTGKHjyXWWcjInuxNqLsAZiLiTmE/Fa3C9wyrT9TFUTN/5Uiz5avgGHKO12qUivRruvjA4KNVmOvH8qVcHU6GS7tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM5IsINMoLvjuPXtSPoZRcLP/A2pW8h1Js+sZoaZPlQ=;
 b=iuCmSK+NP42VCCiXaJ3DBvUYKYrWS7PaI4TRn8h/6jMjvA979XL24pqiQJtTZsr1i3So6UcqpPnEpZMjty1o8M540L/vb6gmh/OXcyuv8ZogpjH3dO1yUO/2dHVaq31ZmUW2dzLlgNBIHlWxJ/AvW8cDT+87UmLcz4MlzujSxi7McA96L5ZmVl3i4r9p+fKbYhFM6ckW4VC60BsXO2nwsrNTQjj11K+LFdeOXmAsux1A60V7EH0abeXrtYXHgfUJMAUgQRMyWfVlRl10uTCnAgj7sVYQT+LLk2l3uw3yBKN0UDwVC/el2M4OzoGuKYdHfc4q9F7yoyIXYGEKmDjUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM5IsINMoLvjuPXtSPoZRcLP/A2pW8h1Js+sZoaZPlQ=;
 b=jXch2zQCntGb2sNtobSQ3d4FeAkxxKEZm1Y0u5uB9M9WZSXJel+0IuzuzSNGVct9WMPz+6gwOXN9fNZq1b39UTE0USgzbDnuL8mpeOTt0FnoC8kHXoyMzIRS5Ruwm2ymXAq4YXxdbdaEvZAKvkivXoXvGdFd1+/AZtXKGXvMotw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 11:52:10 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 11:52:06 +0000
Message-ID: <03d429a0-ce55-fe75-5698-c6cfdc1ed4b0@amd.com>
Date:   Mon, 28 Nov 2022 17:21:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 0/9] Add latency priority for CFS class
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
References: <20221115171851.835-1-vincent.guittot@linaro.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d26aec-488c-4390-dacb-08dad136f8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D2bOK8bxhUfRn+oaJKyTzvqgjxcug3eRZcSFLNt9JzS9hUdDbv2MqfZbiHBJ6RejMOKdBTAgRQ72e5/GPit1KqqFW+CCGbMH9HKRpDxhtd0SmJ6rf+XbH/rHHXJVTM0t3PYgAjOIsOTmrv7xvnb2tItD9bIyYuD+JmVC40jVZ8NX5VJe4pkg94FU5AHEe8w/V8aemU6LqU36GGdgjo3VXtFLrbIPQSPGxObbTp+2i/F9cTMbK1Z8WecD82KCO5/cajjlg/bwyto/lizB5cNrRzlvlsHwJWCi1oT7zYjNMnnqK2rYmDqPA/j3pWFbiOl6uNPgxDLdmNKvvrb8y6+AnPUgkFmTfG9XzTlRpKWs2bpPYGGgjVSWGaay9laKzrEr6r/r8SeRCfHqyKQTsLGKXX4o6DsIA2CJMUAB2QYhtDT/U/sTMKYw4BkAI3ymtbEz7yXcj/EGlLV84S1016nMknRxqmjXtO+U1vxBAUtjpgS3agU21K7CtlK6/YcqVALU47eo1klhrD/Gl+I2ffabpodH0kbOf2uZwmaTKfPkHLfb/zBtItJe8x1r3UUk93us4nG7zT41smEicyqJcaolTxW5QfGdBBt37HNPPAUy5g1gU3MPlKFjK9HvQ8P6EONCMhaW0uY2m7PP+hAoZoBk+1tqKnAQkX3f1ybmEwIo2xNATcdxUxzzeFT3fMitxROSmv6w2jp6mxioFonbWEqdQ4feZoG11+zftUHaGav5H4uvndKUODrG7kfMaCSepMNviFNfwoOVfcL5BcdtmjKi426z+9XLVOvGcOzDSuOyjNOcKqFC846uoH4JZ2cY4Hi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(31686004)(6666004)(36756003)(2906002)(83380400001)(53546011)(26005)(316002)(6506007)(6512007)(5660300002)(7416002)(8936002)(966005)(921005)(30864003)(38100700002)(6486002)(66946007)(8676002)(66476007)(31696002)(4326008)(66556008)(86362001)(186003)(41300700001)(2616005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dSdVFTbmFVTFppbkZ5RlhxK05lUVpBT1QvTW1jbEpFZkJ0MEx3ZzVGTVpJ?=
 =?utf-8?B?b2ZEZG0ybksrelNGczhWamdxYmlDU2Y4Ynk4Wmg2QW1sNFBlamh4NEh2dHFP?=
 =?utf-8?B?MUFQc0VPV2ZRQ21aZFMyRjF0MGxDUXArRGgxQkUwQjh3M256dzF2YzVURnk1?=
 =?utf-8?B?enByaTgzNUVTZ1V1cnVWcGxhclBDd0N3M05RTzQyZGZJL0dvUjh5TnZvc0lI?=
 =?utf-8?B?MjZjeVZEZzE2UU94YXE4dENHVW01VW5GbTh6TytQaHpVbTU2U0l1YWVHMUdU?=
 =?utf-8?B?SXNjM2lucG5QZWNLb3I5dFlkTXFGZVNaUGJhWkpLWTNpWUtqMFJUZmtKZkhm?=
 =?utf-8?B?WEJoNllQbjJwWkhqU3JiYU5JbG5jeDhlMmJkNDBtT0VZZFJUdHdJVHFiWFNu?=
 =?utf-8?B?TFZjd2pCdzd1Q21ka2NSb0dEcVQ5ZUFobmg5endqS0JGNUwwTU9zOExDOEhm?=
 =?utf-8?B?ZHhYZmhYc2JVNXVicm9HVUhPZG9XUWlUeXBtcVFTcE4rVXplVDdSTHBzR3Qz?=
 =?utf-8?B?emUyV3lIYlZqdU5WRkZRWmJmSFZsck9yOS9aSWJOOUx5UnVjUDE0LzhhT1pw?=
 =?utf-8?B?OFhMRWRzYnNrcWZUOVhacWczdVh0dTQ3cEQweWt0MW1uQkJLZm5QR2ZXdjhq?=
 =?utf-8?B?UExlaDUraENNeTl5aEc0OEJlNHVMMWdENlFwUUYrMWJBd3lUVUhtRk4rK3VS?=
 =?utf-8?B?dzhwWnljVnpwSTRLb2pBSWNRcHVXRm9QdHJMT3J2M3hUT0NHOGpGSndQZ0pP?=
 =?utf-8?B?bmpsbWxZd2ZYTERkVGRyRytlR3Aza3hTZ3JJUTFOajlLWlFaUWk0NnIyTXhu?=
 =?utf-8?B?Z0k2TzBCVFNFUFNtRngrdVJuM3Z1T29OMjFEZ0ZpekkrNjg0WVRLQk9MOUVD?=
 =?utf-8?B?MnZvS2xMUlRkRGpFQlFHcVUzeERnN1dONGpESHJJSmJaUkdsSk40WDBoZU52?=
 =?utf-8?B?MWRtRnJrMUdodkpUQy95MFlZQS94TldQbG9qK0pNYU4rbU5pR1lpQzJ6ZTJo?=
 =?utf-8?B?NmNMYkVrL2FEYkEzbnJLdFUxQ1RUdW5vYnZPQ0QxQUJLeFpuSTNDRWJtU1hY?=
 =?utf-8?B?cEw1TWxpR2ZNU09lS1JRa2wzamJram9yd1UxWWFxYkdmczBiVGtyVE5kYVR1?=
 =?utf-8?B?WHR0cXBybWptL3k3QllXVllMVWl6UklQVW5oa1lXRURVSWNLSlIrTW96UnFx?=
 =?utf-8?B?VEN1dzJpMDhyeUYwcVkzRXFzSVNRQjNhanZYbkNuVGhISU91bGdlbjF1Ymt0?=
 =?utf-8?B?bjhqTHNyS20rQUpuTlM3Yzh1ZW9aQmhXOGd6cDgzeDNhZjNyeWdUUjdHRUlr?=
 =?utf-8?B?NWFTWXZMbzZmMnZyaUdxWkprY1VBYjhEUlk5b3NWanB5YTVycVJpMUlTZU9h?=
 =?utf-8?B?VHptaXR6TXVUNUl3NGpUYXdlNURyZmhoUyt2aGs0U2thamoxckljZnFJdVg2?=
 =?utf-8?B?enUxMU1EZXVjazF3WlEyRFBtcDBWUjZMK1BFdmVNdUF2cmZqOG50RGd5T09w?=
 =?utf-8?B?eVJuMGJ6SVlXaTQxMFkwd2FkaitXL24yYW9WWEVSK3lUdnRJelVEOGtHYm5C?=
 =?utf-8?B?S2luZmgvR2UyaE1VeHlwU0pnT0lEejlKZ01WU1JnSGV5UWFST3NxbVZxREZL?=
 =?utf-8?B?R2tsNkkrZXRucFZ5eXMxTWFZTHNNNkQ0alRQRmFmQlpFUE5mdk9VaEpTNHds?=
 =?utf-8?B?czk1OXEwTnZIWlgyTk5XeWRBTHhoc2xxd0QzYzNZMXNzSE03Nmp2K0pBeFcz?=
 =?utf-8?B?NWxCckFqaVZmYVA3SjliWnM3NVlsRE4rZVd6WENtUm1ROHdjZW5QRWV5T3Nl?=
 =?utf-8?B?aVlLK1hrc3hjenZ5dmdDN2VJWDJoMHNkS0lhVVlWREUwY1lPdlNZd0JHaFRO?=
 =?utf-8?B?UGRQNWpSSm1EeTFoMldoSXVrTDdQUjVYMWJIbHloam9sUVNkRGxrcUpoYXh2?=
 =?utf-8?B?U29qTGNzZ21IMkFRK2ZPQ0ZRZXowMlk3WkcyNXNUNXR2c2hoY1hKU09Fb1Jv?=
 =?utf-8?B?TENxVDZhNFRZQm1BL1o5ZDliUndTb09yelg5cm8vV0kyOXlUMjZvUXl4dU01?=
 =?utf-8?B?MDVUcDkwK2hoOURSOFpNV05VRXhMOFhQOG8rTXpEL3lQL3pmUXdJOFhmMFlP?=
 =?utf-8?Q?pb0CgcHvYZPijGqZgjhOdS3ek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d26aec-488c-4390-dacb-08dad136f8b7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 11:52:06.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01twPGjj+b0GyeRjH3MNUvRglXsVUU+yIXmilur+SZ0cO8Ej4VKMe1hel8nPrzUZ8OWPIs40NvTcvvmwNsZJCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

Following are the test results on dual socket Zen3 machine (2 x 64C/128T)

tl;dr

o All benchmarks with DEFAULT_LATENCY_NICE value are comparable to tip.
  There is, however, a noticeable dip for unixbench-spawn test case.

o With the 2 rbtree approach, I do not see much difference in the
  hackbench results with varying latency nice value. Tests on v5 did
  yield noticeable improvements for hackbench.
  (https://lore.kernel.org/lkml/cd48ebbb-9724-985f-28e3-e558dea07827@amd.com/)

o For hackbench + cyclictest and hackbench + schbench, I see the
  expected behavior with different latency nice values.

o There are a few cases with hackbench and hackbench + cyclictest where
  the results are non-monotonic with different latency nice values.
  (Marked with "^").

I'll leave the detailed results below:

On 11/15/2022 10:48 PM, Vincent Guittot wrote:
> This patchset restarts the work about adding a latency priority to describe
> the latency tolerance of cfs tasks.
> 
> Patch [1] is a new one that has been added with v6. It fixes an
> unfairness for low prio tasks because of wakeup_gran() being bigger
> than the maximum vruntime credit that a waking task can keep after
> sleeping.
> 
> The patches [2-4] have been done by Parth:
> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> 
> I have just rebased and moved the set of latency priority outside the
> priority update. I have removed the reviewed tag because the patches
> are 2 years old.
> 
> This aims to be a generic interface and the following patches is one use
> of it to improve the scheduling latency of cfs tasks.
> 
> Patch [5] uses latency nice priority to define a latency offset
> and then decide if a cfs task can or should preempt the current
> running task. The patch gives some tests results with cyclictests and
> hackbench to highlight the benefit of latency priority for short
> interactive task or long intensive tasks.
> 
> Patch [6] adds the support of latency nice priority to task group by
> adding a cpu.latency.nice field. The range is [-20:19] as for setting task
> latency priority.
> 
> Patch [7] makes sched_core taking into account the latency offset.
> 
> Patch [8] adds a rb tree to cover some corner cases where the latency
> sensitive task (priority < 0) is preempted by high priority task (RT/DL)
> or fails to preempt them. This patch ensures that tasks will have at least
> a slice of sched_min_granularity in priority at wakeup.
> 
> Patch [9] removes useless check after adding a latency rb tree.
> 
> I have also backported the patchset on a dragonboard RB3 with an android
> mainline kernel based on v5.18 for a quick test. I have used the
> TouchLatency app which is part of AOSP and described to be a very good
> test to highlight jitter and jank frame sources of a system [1].
> In addition to the app, I have added some short running tasks waking-up
> regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
> without overloading it (and disabling EAS). The 1st results shows that the
> patchset helps to reduce the missed deadline frames from 5% to less than
> 0.1% when the cpu.latency.nice of task group are set. I haven't rerun the
> test with latest version.
> 
> I have also tested the patchset with the modified version of the alsa
> latency test that has been shared by Tim. The test quickly xruns with
> default latency nice priority 0 but is able to run without underuns with
> a latency -20 and hackbench running simultaneously.
> 
> While preparing the version 8, I have evaluated the benefit of using an
> augmented rbtree instead of adding a rbtree for latency sensitive entities,
> which was a relevant suggestion done by PeterZ. Although the augmented
> rbtree enables to sort additional information in the tree with a limited
> overhead, it has more impact on legacy use cases (latency_nice >= 0)
> because the augmented callbacks are always called to maintain this
> additional information even when there is no sensitive tasks. In such
> cases, the dedicated rbtree remains empty and the overhead is reduced to
> loading a cached null node pointer. Nevertheless, we might want to
> reconsider the augmented rbtree once the use of negative latency_nice will
> be more widlely deployed. At now, the different tests that I have done,
> have not shown improvements with augmented rbtree.
> 
> Below are some hackbench results:
>         2 rbtrees               augmented rbtree        augmented rbtree	
>                                 sorted by vruntime      sorted by wakeup_vruntime
> sched	pipe	
> avg     26311,000               25976,667               25839,556
> stdev   0,15 %                  0,28 %                  0,24 %
> vs tip  0,50 %                  -0,78 %                 -1,31 %
> hackbench	1 group	
> avg     1,315                   1,344                   1,359
> stdev   0,88 %                  1,55 %                  1,82 %
> vs tip  -0,47 %                 -2,68 %                 -3,87 %
> hackbench	4 groups
> avg     1,339                   1,365                   1,367
> stdev   2,39 %                  2,26 %                  3,58 %
> vs tip  -0,08 %                 -2,01 %                 -2,22 %
> hackbench	8 groups
> avg     1,233                   1,286                   1,301
> stdev   0,74 %                  1,09 %                  1,52 %
> vs tip  0,29 %                  -4,05 %                 -5,27 %
> hackbench	16 groups	
> avg     1,268                   1,313                   1,319
> stdev   0,85 %                  1,60 %                  0,68 %
> vs tip  -0,02 %                 -3,56 %                 -4,01 %

Following are the results from running standard benchmarks on a
dual socket Zen3 (2 x 64C/128T) machine configured in different
NPS modes.

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Benchmark Results:

Kernel versions:
- tip:          6.1.0 tip sched/core
- latency_nice: 6.1.0 tip sched/core + this series

When we started testing, the tip was at:
commit d6962c4fe8f9 "sched: Clear ttwu_pending after enqueue_task()"


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ hackbench - DEFAULT_LATENCY_NICE ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS1

Test:			tip			latency_nice
 1-groups:	   4.25 (0.00 pct)	   4.14 (2.58 pct)
 2-groups:	   4.95 (0.00 pct)	   4.92 (0.60 pct)
 4-groups:	   5.19 (0.00 pct)	   5.18 (0.19 pct)
 8-groups:	   5.45 (0.00 pct)	   5.44 (0.18 pct)
16-groups:	   7.33 (0.00 pct)	   7.32 (0.13 pct)

NPS2

Test:			tip			latency_nice
 1-groups:	   4.09 (0.00 pct)	   4.08 (0.24 pct)
 2-groups:	   4.68 (0.00 pct)	   4.72 (-0.85 pct)
 4-groups:	   5.05 (0.00 pct)	   4.97 (1.58 pct)
 8-groups:	   5.37 (0.00 pct)	   5.34 (0.55 pct)
16-groups:	   6.69 (0.00 pct)	   6.74 (-0.74 pct)

NPS4

Test:			tip			latency_nice
 1-groups:	   4.28 (0.00 pct)	   4.35 (-1.63 pct)
 2-groups:	   4.78 (0.00 pct)	   4.76 (0.41 pct)
 4-groups:	   5.11 (0.00 pct)	   5.06 (0.97 pct)
 8-groups:	   5.48 (0.00 pct)	   5.40 (1.45 pct)
16-groups:	   7.07 (0.00 pct)	   6.70 (5.23 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ schbench - DEFAULT_LATENCY_NICE ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS1

#workers:	tip			latency_nice
  1:	  31.00 (0.00 pct)	  32.00 (-3.22 pct)
  2:	  33.00 (0.00 pct)	  34.00 (-3.03 pct)
  4:	  39.00 (0.00 pct)	  38.00 (2.56 pct)
  8:	  45.00 (0.00 pct)	  46.00 (-2.22 pct)
 16:	  61.00 (0.00 pct)	  66.00 (-8.19 pct)
 32:	 108.00 (0.00 pct)	 110.00 (-1.85 pct)
 64:	 212.00 (0.00 pct)	 216.00 (-1.88 pct)
128:	 475.00 (0.00 pct)	 701.00 (-47.57 pct)    *
128:     429.00 (0.00 pct)       441.00 (-2.79 pct)      [Verification Run]
256:	 44736.00 (0.00 pct)	 45632.00 (-2.00 pct)
512:	 77184.00 (0.00 pct)	 78720.00 (-1.99 pct)

NPS2

#workers:	tip			latency_nice
  1:	  28.00 (0.00 pct)	  33.00 (-17.85 pct)
  2:	  34.00 (0.00 pct)	  31.00 (8.82 pct)
  4:	  36.00 (0.00 pct)	  36.00 (0.00 pct)
  8:	  51.00 (0.00 pct)	  49.00 (3.92 pct)
 16:	  68.00 (0.00 pct)	  64.00 (5.88 pct)
 32:	 113.00 (0.00 pct)	 115.00 (-1.76 pct)
 64:	 221.00 (0.00 pct)	 219.00 (0.90 pct)
128:	 553.00 (0.00 pct)	 531.00 (3.97 pct)
256:	 43840.00 (0.00 pct)	 48192.00 (-9.92 pct)   *
256:	 50427.00 (0.00 pct)	 48351.00 (4.11 pct)    [Verification Run]
512:	 76672.00 (0.00 pct)	 81024.00 (-5.67 pct)

NPS4

#workers:	tip			latency_nice
  1:	  33.00 (0.00 pct)	  28.00 (15.15 pct)
  2:	  29.00 (0.00 pct)	  34.00 (-17.24 pct)
  4:	  39.00 (0.00 pct)	  36.00 (7.69 pct)
  8:	  58.00 (0.00 pct)	  55.00 (5.17 pct)
 16:	  66.00 (0.00 pct)	  67.00 (-1.51 pct)
 32:	 112.00 (0.00 pct)	 116.00 (-3.57 pct)
 64:	 215.00 (0.00 pct)	 213.00 (0.93 pct)
128:	 689.00 (0.00 pct)	 571.00 (17.12 pct)
256:	 45120.00 (0.00 pct)	 46400.00 (-2.83 pct)
512:	 77440.00 (0.00 pct)	 76160.00 (1.65 pct)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ tbench - DEFAULT_LATENCY_NICE ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS1

Clients:	tip			latency_nice
    1	 581.75 (0.00 pct)	 586.52 (0.81 pct)
    2	 1145.75 (0.00 pct)	 1160.69 (1.30 pct)
    4	 2127.94 (0.00 pct)	 2141.49 (0.63 pct)
    8	 3838.27 (0.00 pct)	 3721.10 (-3.05 pct)
   16	 6272.71 (0.00 pct)	 6539.82 (4.25 pct)
   32	 11400.12 (0.00 pct)	 12079.49 (5.95 pct)
   64	 21605.96 (0.00 pct)	 22908.83 (6.03 pct)
  128	 30715.43 (0.00 pct)	 31736.95 (3.32 pct)
  256	 55580.78 (0.00 pct)	 54786.29 (-1.42 pct)
  512	 56528.79 (0.00 pct)	 56453.54 (-0.13 pct)
 1024	 56520.40 (0.00 pct)	 56369.93 (-0.26 pct)

NPS2

Clients:	tip			latency_nice
    1	 584.13 (0.00 pct)	 582.53 (-0.27 pct)
    2	 1153.63 (0.00 pct)	 1140.27 (-1.15 pct)
    4	 2212.89 (0.00 pct)	 2159.49 (-2.41 pct)
    8	 3871.35 (0.00 pct)	 3840.77 (-0.78 pct)
   16	 6216.72 (0.00 pct)	 6437.98 (3.55 pct)
   32	 11766.98 (0.00 pct)	 11663.53 (-0.87 pct)
   64	 22000.93 (0.00 pct)	 21882.88 (-0.53 pct)
  128	 31520.53 (0.00 pct)	 31147.05 (-1.18 pct)
  256	 51420.11 (0.00 pct)	 55216.39 (7.38 pct)
  512	 53935.90 (0.00 pct)	 55407.60 (2.72 pct)
 1024	 55239.73 (0.00 pct)	 55997.25 (1.37 pct)

NPS4

Clients:	tip			latency_nice
    1	 585.83 (0.00 pct)	 578.17 (-1.30 pct)
    2	 1141.59 (0.00 pct)	 1131.14 (-0.91 pct)
    4	 2174.79 (0.00 pct)	 2086.52 (-4.05 pct)
    8	 3887.56 (0.00 pct)	 3778.47 (-2.80 pct)
   16	 6441.59 (0.00 pct)	 6364.30 (-1.19 pct)
   32	 12133.60 (0.00 pct)	 11465.26 (-5.50 pct)   *
   32    11677.16 (0.00 pct)     12662.09 (8.43 pct)    [Verification Run]
   64	 21769.15 (0.00 pct)	 19488.45 (-10.47 pct)  *
   64    20305.64 (0.00 pct)     21002.90 (3.43 pct)    [Verification Run]
  128	 31396.31 (0.00 pct)	 31177.37 (-0.69 pct)
  256	 52792.39 (0.00 pct)	 52890.41 (0.18 pct)
  512	 55315.44 (0.00 pct)	 53572.65 (-3.15 pct)
 1024	 52150.27 (0.00 pct)	 54079.48 (3.69 pct)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ stream - DEFAULT_LATENCY_NICE ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS1

10 Runs:

Test:		tip			latency_nice
 Copy:   307827.79 (0.00 pct)    330524.48 (7.37 pct)
Scale:   208872.28 (0.00 pct)    215002.06 (2.93 pct)
  Add:   239404.64 (0.00 pct)    230334.74 (-3.78 pct)
Triad:   247258.30 (0.00 pct)    238505.06 (-3.54 pct)

100 Runs:

Test:		tip			latency_nice
 Copy:   317217.55 (0.00 pct)    314467.62 (-0.86 pct)
Scale:   208740.82 (0.00 pct)    210452.00 (0.81 pct)
  Add:   240550.63 (0.00 pct)    232376.03 (-3.39 pct)
Triad:   249594.21 (0.00 pct)    242460.83 (-2.85 pct)

NPS2

10 Runs:

Test:		tip			latency_nice
 Copy:   340877.18 (0.00 pct)    339441.26 (-0.42 pct)
Scale:   217318.16 (0.00 pct)    216905.49 (-0.18 pct)
  Add:   259078.93 (0.00 pct)    261686.67 (1.00 pct)
Triad:   274500.78 (0.00 pct)    271699.83 (-1.02 pct)

100 Runs:

Test:		tip			latency_nice
 Copy:   341860.73 (0.00 pct)    335826.36 (-1.76 pct)
Scale:   218043.00 (0.00 pct)    216451.84 (-0.72 pct)
  Add:   253698.22 (0.00 pct)    257317.72 (1.42 pct)
Triad:   265011.84 (0.00 pct)    267769.93 (1.04 pct)

NPS4

10 Runs:

Test:		tip			latency_nice
 Copy:   340877.18 (0.00 pct)    365921.51 (7.34 pct)
Scale:   217318.16 (0.00 pct)    239408.65 (10.16 pct)
  Add:   259078.93 (0.00 pct)    264859.31 (2.23 pct)
Triad:   274500.78 (0.00 pct)    281543.65 (2.56 pct)

100 Runs:

Test:		tip			latency_nice
 Copy:   341860.73 (0.00 pct)    359255.16 (5.08 pct)
Scale:   218043.00 (0.00 pct)    238154.15 (9.22 pct)
  Add:   253698.22 (0.00 pct)    269223.49 (6.11 pct)
Triad:   265011.84 (0.00 pct)    278473.85 (5.07 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ ycsb-mongodb - DEFAULT_LATENCY_NICE ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

o NPS1

tip:                    131244.00 (var: 2.67%)
latency_nice:           132118.00 (var: 3.62%) (+0.66%)

o NPS2

tip:                    127663.33 (var: 2.08%)
latency_nice:           129148.00 (var: 4.29%) (+1.16%)

o NPS4

tip:                    133295.00 (var: 1.58%)
latency_nice:           129975.33 (var: 1.10%) (-2.49%)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Unixbench - DEFAULT_LATENCY_NICE ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		      latency_nice
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48929419.48 (   0.00%)    49137039.06 (   0.42%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6275526953.25 (   0.00%)  6265580479.15 (  -0.16%)
unixbench-syscall       Amean     unixbench-syscall-1        2994319.73 (   0.00%)     3008596.83 *  -0.48%*
unixbench-syscall       Amean     unixbench-syscall-512      7349715.87 (   0.00%)     7420994.50 *  -0.97%*
unixbench-pipe          Hmean     unixbench-pipe-1           2830206.03 (   0.00%)     2854405.99 *   0.86%*
unixbench-pipe          Hmean     unixbench-pipe-512       326207828.01 (   0.00%)   328997804.52 *   0.86%*
unixbench-spawn         Hmean     unixbench-spawn-1             6394.21 (   0.00%)        6367.75 (  -0.41%)
unixbench-spawn         Hmean     unixbench-spawn-512          72700.64 (   0.00%)       71454.19 *  -1.71%*
unixbench-execl         Hmean     unixbench-execl-1             4723.61 (   0.00%)        4750.59 (   0.57%)
unixbench-execl         Hmean     unixbench-execl-512          11212.05 (   0.00%)       11262.13 (   0.45%)

o NPS2

Test			Metric	  Parallelism			tip		      latency_nice
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49271512.85 (   0.00%)    49245260.43 (  -0.05%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6267992483.03 (   0.00%)  6264951100.67 (  -0.05%)
unixbench-syscall       Amean     unixbench-syscall-1        2995885.93 (   0.00%)     3005975.10 *  -0.34%*
unixbench-syscall       Amean     unixbench-syscall-512      7388865.77 (   0.00%)     7276275.63 *   1.52%*
unixbench-pipe          Hmean     unixbench-pipe-1           2828971.95 (   0.00%)     2856578.72 *   0.98%*
unixbench-pipe          Hmean     unixbench-pipe-512       326225385.37 (   0.00%)   328941270.81 *   0.83%*
unixbench-spawn         Hmean     unixbench-spawn-1             6958.71 (   0.00%)        6954.21 (  -0.06%)
unixbench-spawn         Hmean     unixbench-spawn-512          85443.56 (   0.00%)       70536.42 * -17.45%* (0.67% vs 0.93% - CoEff var)
unixbench-execl         Hmean     unixbench-execl-1             4767.99 (   0.00%)        4752.63 *  -0.32%*
unixbench-execl         Hmean     unixbench-execl-512          11250.72 (   0.00%)       11320.97 (   0.62%)

o NPS4

Test			Metric	  Parallelism			tip		      latency_nice
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49041932.68 (   0.00%)    49156671.05 (   0.23%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6286981589.85 (   0.00%)  6285248711.40 (  -0.03%)
unixbench-syscall       Amean     unixbench-syscall-1        2992405.60 (   0.00%)     3008933.03 *  -0.55%*
unixbench-syscall       Amean     unixbench-syscall-512      7971789.70 (   0.00%)     7814622.23 *   1.97%*
unixbench-pipe          Hmean     unixbench-pipe-1           2822892.54 (   0.00%)     2852615.11 *   1.05%*
unixbench-pipe          Hmean     unixbench-pipe-512       326408309.83 (   0.00%)   329617202.56 *   0.98%*
unixbench-spawn         Hmean     unixbench-spawn-1             7685.31 (   0.00%)        7243.54 (  -5.75%)
unixbench-spawn         Hmean     unixbench-spawn-512          72245.56 (   0.00%)       77000.81 *   6.58%*
unixbench-execl         Hmean     unixbench-execl-1             4761.42 (   0.00%)        4733.12 *  -0.59%*
unixbench-execl         Hmean     unixbench-execl-512          11533.53 (   0.00%)       11660.17 (   1.10%)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Hackbench - Various Latency Nice Values ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

o 100000 loops

- pipe (process)

Test:                   LN: 0                   LN: 19                  LN: -20
 1-groups:         3.91 (0.00 pct)         3.91 (0.00 pct)         3.81 (2.55 pct)
 2-groups:         4.48 (0.00 pct)         4.52 (-0.89 pct)        4.53 (-1.11 pct)
 4-groups:         4.83 (0.00 pct)         4.83 (0.00 pct)         4.87 (-0.82 pct)
 8-groups:         5.09 (0.00 pct)         5.00 (1.76 pct)         5.07 (0.39 pct)
16-groups:         6.92 (0.00 pct)         6.79 (1.87 pct)         6.96 (-0.57 pct)

- pipe (thread)

 1-groups:         4.13 (0.00 pct)         4.08 (1.21 pct)         4.11 (0.48 pct)
 2-groups:         4.78 (0.00 pct)         4.90 (-2.51 pct)        4.79 (-0.20 pct)
 4-groups:         5.12 (0.00 pct)         5.08 (0.78 pct)         5.16 (-0.78 pct)
 8-groups:         5.31 (0.00 pct)         5.28 (0.56 pct)         5.33 (-0.37 pct)
16-groups:         7.34 (0.00 pct)         7.27 (0.95 pct)         7.33 (0.13 pct)

- socket (process)

Test:                   LN: 0                   LN: 19                  LN: -20
 1-groups:         6.61 (0.00 pct)         6.38 (3.47 pct)         6.54 (1.05 pct)
 2-groups:         6.59 (0.00 pct)         6.67 (-1.21 pct)        6.11 (7.28 pct)
 4-groups:         6.77 (0.00 pct)         6.78 (-0.14 pct)        6.79 (-0.29 pct)
 8-groups:         8.29 (0.00 pct)         8.39 (-1.20 pct)        8.36 (-0.84 pct)
16-groups:        12.21 (0.00 pct)        12.03 (1.47 pct)        12.35 (-1.14 pct)

- socket (thread)

Test:                   LN: 0                   LN: 19                  LN: -20
 1-groups:         6.50 (0.00 pct)         5.99 (7.84 pct)         6.02 (7.38 pct)	^
 2-groups:         6.07 (0.00 pct)         6.20 (-2.14 pct)        6.23 (-2.63 pct)
 4-groups:         6.61 (0.00 pct)         6.64 (-0.45 pct)        6.63 (-0.30 pct)
 8-groups:         8.87 (0.00 pct)         8.67 (2.25 pct)         8.78 (1.01 pct)
16-groups:        12.63 (0.00 pct)        12.54 (0.71 pct)        12.59 (0.31 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Hackbench + Cyclictest - Various Latency Nice Values ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Hackbench: 32 Groups

perf bench sched messaging -p -l 100000 -g 32&
cyclictest --policy other -D 5 -q -n -h 2000

o NPS1

----------------------------------------------------------------------------------------------------------
| Hackbench   |      Cyclictest LN = 19      |      Cyclictest LN = 0        |    Cyclictest LN = -20    |
| LN          |------------------------------|-------------------------------|---------------------------|
|             |   Min  |   Avg   |  Max      |   Min  |   Avg   |   Max      |   Min  |  Avg  |   Max    |
|-------------|--------|---------|-----------|--------|---------|------------|--------|-------|----------|
| 19          | 52.00  | 71.00   | 5191.00   | 29.00  | 68.00   |  4477.00   | 53.00  | 60.00 |  753.00  |
| 0           | 53.00  | 150.00  | 7300.00   | 53.00  | 105.00  |  7730.00   | 53.00  | 64.00 |  2067.00 |
| -20         | 33.00  | 159.00  | 98492.00  | 53.00  | 149.00  |  9608.00   | 53.00  | 91.00 |  5349.00 |
----------------------------------------------------------------------------------------------------------

o NPS4

----------------------------------------------------------------------------------------------------------
| Hackbench   |      Cyclictest LN = 19      |      Cyclictest LN = 0        |    Cyclictest LN = -20    |
| LN          |------------------------------|-------------------------------|---------------------------|
|             |   Min  |   Avg   |  Max      |   Min  |   Avg   |   Max      |   Min  |  Avg  |   Max    |
|-------------|--------|---------|-----------|--------|---------|------------|--------|-------|----------|
| 19          | 53.00  |  84.00  |  4790.00  | 53.00  |  72.00  |  3456.00   | 53.00  | 58.00 |  1271.00 |
| 0           | 53.00  |  99.00  |  5494.00  | 52.00  |  74.00  |  5813.00   | 53.00  | 59.00 |  1004.00 |
| -20         | 45.00  |  84.00  |  3592.00  | 53.00  |  91.00  |  15222.00  | 53.00  | 74.00 |  5232.00 |	^
----------------------------------------------------------------------------------------------------------

- Hackbench: 128 Groups

perf bench sched messaging -p -l 500000 -g 128&
cyclictest --policy other -D 5 -q -n -h 2000

o NPS1

----------------------------------------------------------------------------------------------------------
| Hackbench   |      Cyclictest LN = 19      |      Cyclictest LN = 0        |    Cyclictest LN = -20    |
| LN          |------------------------------|-------------------------------|---------------------------|
|             |   Min  |   Avg   |  Max      |   Min  |   Avg   |   Max      |   Min  |  Avg  |   Max    |
|-------------|--------|---------|-----------|--------|---------|------------|--------|-------|----------|
| 19          | 53.00  | 274.00  | 11294.00  | 33.00  | 130.00  |  20071.00  | 53.00  | 56.00 |  244.00  |	^
| 0           | 53.00  | 125.00  | 10014.00  | 53.00  | 113.00  |  15857.00  | 53.00  | 57.00 |  250.00  |
| -20         | 53.00  | 187.00  | 49565.00  | 53.00  | 230.00  |  73353.00  | 53.00  | 118.00|  8816.00 |
----------------------------------------------------------------------------------------------------------

o NPS4

----------------------------------------------------------------------------------------------------------
| Hackbench   |      Cyclictest LN = 19      |      Cyclictest LN = 0        |    Cyclictest LN = -20    |
| LN          |------------------------------|-------------------------------|---------------------------|
|             |   Min  |   Avg   |  Max      |   Min  |   Avg   |   Max      |   Min  |  Avg  |   Max    |
|-------------|--------|---------|-----------|--------|---------|------------|--------|-------|----------|
| 19          | 53.00  | 271.00  | 11411.00  | 53.00  | 82.00   |  5486.00   | 25.00  | 57.00 | 1256.00  |
| 0           | 53.00  | 148.00  | 8374.00   | 52.00  | 109.00  |  11074.00  | 52.00  | 59.00 | 1068.00  |
| -20         | 53.00  | 202.00  | 52537.00  | 53.00  | 205.00  |  22265.00  | 52.00  | 87.00 | 14151.00 |
----------------------------------------------------------------------------------------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Hackbench + schbench - Various Latency Nice Values ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

perf bench sched messaging -p -l 400000 -g 128
schbench -m 2 -t 1 -s 30

o NPS1

-------------------------------------------------------------------------------------------------
| Hackbench |     schbench LN = 19       |      schbench LN = 0      |     schbench LN = -20    |
| LN        |----------------------------|---------------------------|--------------------------|
|           |  90th  |  95th  |  99th    |  90th  |  95th  |  99th   |  90th  |  95th  |  99th  |
|-----------|--------|--------|----------|--------|--------|---------|--------|--------|--------|
| 19        |   38   |   131  |   1458   |   46   |   151  |  2636   |   11   |   19   |  410   |	^
| 0         |   45   |   98   |   1758   |   25   |   50   |  1670   |   16   |   30   |  1042  |
| -20       |   47   |   348  |   29280  |   40   |   109  |  16144  |   35   |   63   |  9104  |
-------------------------------------------------------------------------------------------------

o NPS4

-------------------------------------------------------------------------------------------------
| Hackbench |     schbench LN = 19       |      schbench LN = 0      |     schbench LN = -20    |
| LN        |----------------------------|---------------------------|--------------------------|
|           |  90th  |  95th  |  99th    |  90th  |  95th  |  99th   |  90th  |  95th  |  99th  |
|-----------|--------|--------|----------|--------|--------|---------|--------|--------|--------|
| 19        |   19   |  60    |  1886    |   17   |  29    |  621    |   10   |   18   |  227   |
| 0         |   51   |  141   |  8120    |   37   |  78    |  8880   |   33   |   55   |  474   |	^
| -20       |   48   |  1494  |  27296   |   51   |  469   |  40384  |   31   |   64   |  4092  |	^
-------------------------------------------------------------------------------------------------

^ Note: There are cases where the Max, 99th percentile latency is
non-monotonic but I've also seen a good amount of run to run variation
there with a single bad sample polluting the results. In such cases,
the averages are more representative.

> 
> [1] https://source.android.com/docs/core/debug/eval_perf#touchlatency
> 
> [..snip..]
> 

Apart from couple of anomalies, latency nice reduces wait time, especially
when the system is heavily loaded. If there is any data, or any specific
workload you would like me to run on the test system, please do let me know.
Meanwhile, I'll try to get some numbers for larger workloads like SpecJBB
that did see improvements with latency nice on v5.
--
Thanks and Regards,
Prateek
