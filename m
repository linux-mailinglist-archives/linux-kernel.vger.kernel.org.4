Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC256620D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbjAIJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjAIJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:00:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8F183B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673254340; x=1704790340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ypbwe3NxwWfGQPMh5r9VzlIeAc1wXL5NFTK71SA4yGE=;
  b=FgnEUFC/wqIbKOi9UMohjCqsic6u4lQFA929DMYDyh3bCVdJsmbEEYbn
   fz1aQZBIzypuZW959UhD3nS9WnF/Zrbch8V0NaD8b0t2SerYBistwZUpK
   C8EtpBmpuZt/NY7hOfxXMtOVxtsUbLZy/8nfN8lTjt9yINKZwsUMwlH1B
   S1DcOlvrkwpfh5V1eDxYRzn+oGXDL4Y7ChLOg7tupkOUoPEh3o7k3MrJD
   OQLg3KzAtxSqelSyY/WSzTbrS1j3cuibSyT5qzhLDEKO1jCFK1vfzFAqq
   lBO5tWP32+6mwyWAzX7sl+BPDUc9mMvh9KoTHgpnfok8mnhzcrDcqRNr4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="324073234"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="324073234"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 00:52:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="719871535"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="719871535"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2023 00:52:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 00:52:17 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 00:52:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 00:52:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 00:52:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ6GpjiH5vPTGV4DT5kCgDF0pIUAb7EXiNvfIj8lOcxDBWvjzPHyk02HY9zpRERmoN6q2/XomILgKmdcjChUHKh2XDQrnFU/8HtGCbi+T+kzb8RSbvo1QAt/tu4Cwr2ZLu3Y213jKNwztluyg9h+HvcggcEugdyK/BROeO9FV7i2624xQE2t9+eIaDqtUjr927zvUMssJXcjpec9hy0q/d8L0WykpfvwpAJlza0b81JmwHeKOoiVP9leUn15+DAJR7KjiaVIOCHe35OtKK7vOPapuQK8qfdDB6TPqkyHSNLUYsdjsZhdG5u+UVYAZedbsswc7vle9cYE3TE3GL+npQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzzC+Xq41ybOk1OFMaFZj12TkuL5Xq4WjEQPKPW453U=;
 b=APnjduccphQz7TupBQVt7RQc9XyIcvBS6+D00rPYYspgfd1Ef8npu17ve23kLWRRe9fEoHmFa8alUz47i8P1aKNNYtGWwotlGgFNWlrZqxJH+N/XXUQoiTJ4fwZ7HLgu1CXwdy2ywBB9w3Lx3ZBbhURpVtLDOXm8sRgNJAaGEtPybm/16/wnSupiicu/w72YS/pNQ9FoN0F8nIkEMLydFwGbApyh9ybgd/NWte9M7+/C3Msy/qoYyLu2e+Q3qHzO3QRC76w/9ibKYW1s36cYRH9Nd2oXo1Yyxrs2ecIySX9XOSkSlxysLdx16Ry5PYc9Q2+IbQlbd2+dScBo8TH+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 08:52:15 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 08:52:15 +0000
Date:   Mon, 9 Jan 2023 16:51:52 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Connor O'Brien <connoro@google.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y7vVqE0M/AoDoVbj@chenyu5-mobl1>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-8-connoro@google.com>
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a40cd2d-189b-4f4e-4fc4-08daf21ece4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8hK1uld143d79zBlO7vp4tMUH9yEOCS2MxXjs816v8VjT5gaNVBEQhBrmguLAas4RIergTRYodCHpNrSTm+XEx0jh9R8OQV7Y0tCYOk21OmjPsyWQKpVIMlDlwVv+WP02IcUfU3SUsNzCyRhRts3HG1qxbiqEAp3i72JHN/C+IFeNriCbqRdU+PKXAAiYxjLYmh1wpDOiiFt8+OzHMSfN/O5b5w1ko8hLjKbM9vzEjY/Uln/uBviECDdcldcKl310rm3fUyZ5o8chsPhNb7uBeafsppapSleFKWlIDc07Yruw/fIFIWOCWdOuQesFxqadh157AHBplVP3NPfzOkhNJn2A+J3bpWa/HHfnbXPJzC2GC/h/j8idoMj78wNEeoG/H4kBnkKy2B13DkBp6H2VFTtguAsNI8FwkUq3rJVGQS6sWuH2M/WJ0rgW3yzuvRTSVFsiVw1gP9ZAgX2dRdG5g3kiAxqiZViyCJz7D0cF1Bz9ebfJJKHQfPq9Yhbr0SdYoqQpmuLh1Hr8960JcVPy2cvl2eAds7lhfStBlI+0mThJuP2wJg+WK8PHgX+AVpsjyuV2AZjPQnqrs6AkFv/5ANBrje1iz6tVOsrIOPLtcbRpFZmpmkrgiR9fwO2G/kXrPjLp6AM20v1UsiWc0IwLXJ8n56LXG/9nBK8+7YUuqNh8wDJ6Np7uieCAmGdXsq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(9686003)(6506007)(6512007)(186003)(33716001)(6666004)(54906003)(82960400001)(86362001)(66556008)(66946007)(66476007)(8676002)(38100700002)(5660300002)(7416002)(4326008)(478600001)(8936002)(6916009)(53546011)(2906002)(26005)(316002)(41300700001)(966005)(83380400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yfrkYMcxhOJrID+Gr0zUKDqZYptJCyE2CIL52Fjq614zg0K7GlE9DXkFLwS?=
 =?us-ascii?Q?TZ+i7P+kbFmYn6mjjIklNlNgyzqqPoz0z2txwaSboRPgl3yVcygrd7kuoITB?=
 =?us-ascii?Q?9xrp2lEn4CebdnC1G1E3I+ueCzPykAELTmFVA5xnbdAFVw6BOsvyn0KeHgCq?=
 =?us-ascii?Q?WAjXUHbrST5+N5mozbHstjTKVmf1AAxmrmGQkCtGa4GsesjrwYsRMZiZxKTg?=
 =?us-ascii?Q?TtGOMrk+YZ3Ez42N+uioBYgZ0BiwRnQRtPL/RcyPIcxjTJRHL+REfSTtNOWs?=
 =?us-ascii?Q?9472e1S2i1nPsfNloPS5NSNtCPp9XRrMygCRqZNz1eUDVHbU+SOsn+OA8Gtu?=
 =?us-ascii?Q?snbdjwJJCEAg9ROaa7qZ6EXOsNkzPznaikE+hO+wcBcFTMO+BOZrhblZFa72?=
 =?us-ascii?Q?8pVWE0OAU1JgWeU+rRP7r4JlMTY9dOL7BhIyuuBXxKuJhLi8681QRDwyRgC+?=
 =?us-ascii?Q?qFEJ9BLlg11fuDVZxx7mTMgBEX/4s/nq/P8BMMkEge0Wgs7FTmMIRZXMfXO2?=
 =?us-ascii?Q?5gofuUcCN1DccGDJny1HV6xjrbgOxjO2cQCikKoukhUHN7pNR7PnontOSa63?=
 =?us-ascii?Q?BqfAuG8ORAfme/+Gc+dbE1vHzr9y1qdW25JxExGJYZ/H/qJRW344Qkj3QuHF?=
 =?us-ascii?Q?dsaT5V+aH/JAKWafZoTU4ZO8BnrLOBdpna9IjihMErSVdaVTsjZqRxpyVrXa?=
 =?us-ascii?Q?Z3kaY60GOH0a/bV6dbB+/fBjdZ0tTw+N7NsNDrNEAiliS1ZeNKexx88Uq9q8?=
 =?us-ascii?Q?LMIddMAdWt0241zlAzMYZo7cFwjJGr5km0KLlNwMUYhfxi1dloJeOYrGWM1f?=
 =?us-ascii?Q?YUGFOD/0bdGY71IYbUP9fhPiB3JY8DofqqGeYvPlzfEyDNrguHiGm1Hwqy70?=
 =?us-ascii?Q?2zUFFicpo7NuvUqAZYzvCRBqjiZoptmfJtKIJn5C4jx2THo6Qdzas2nPzYUN?=
 =?us-ascii?Q?/gTX9zS7+rUApJgo+jC113ApMZ9FGk4z0c8FBjapupZ7ewj//mIgSJV/+uyo?=
 =?us-ascii?Q?KVpDlWwxhq7KC8Q9W7Lj+bxXbujeiwAPDk5wvU2ruqGZ5QrYMH4/CPdrDepo?=
 =?us-ascii?Q?Mc8md2deTJiDjF/7XaJMFyQnk50Vn7Y1GsCk+bEbPdAgVoXLVlrZUChvgsMy?=
 =?us-ascii?Q?utSOw9UyxBdNQXc98p65elBwDevBs270H83eerf1V1XcbFjpXhI0NrEVGu9v?=
 =?us-ascii?Q?s28c3g70cqLZv1+e0R46YuDr+52CyOUmewXtGFvAF8q/RMngrfNIpQcr+R5F?=
 =?us-ascii?Q?tDruVRyDyCuh2L+jjE4AsbuDLxnn0TxnN0sgqwwG2urYMvtRHwSiJOoMWeya?=
 =?us-ascii?Q?YjWoNujN/gpMmbsnNDUe0L7IjEHzR0MS8EQuyPSjFcBkaZC0NO+cdeqaB5zB?=
 =?us-ascii?Q?WAITSfV+kGabR8qNNfSmwuPwrtVwGuAL5m6QOlvLAElbKcJLOC+Vk0gpTADk?=
 =?us-ascii?Q?hJuyL9sk6i+YstLAUGMjtlMLYGPQYrWV/uIGN2RjuRrwABC9+nd+dgf7E2GE?=
 =?us-ascii?Q?Ov9KiFTsnmft69HIaHa6Bjf0Rux8XM9ZuRcWoxPjFxO1dS8iy503UWvO/DM4?=
 =?us-ascii?Q?bfnKN+xf6BjWG52IjnLR5EDp14Tqzf6t1ETOe+wc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a40cd2d-189b-4f4e-4fc4-08daf21ece4a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 08:52:15.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3Z1+GyMsidn00c4sZHi4PVKtR+L+tRBrCEmjiIy7qVCqzMziKuf0nQ62MOcfTTDHOfSRayBf5PGqrr7afCsjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-03 at 21:44:57 +0000, Connor O'Brien wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> A task currently holding a mutex (executing a critical section) might
> find benefit in using scheduling contexts of other tasks blocked on the
> same mutex if they happen to have higher priority of the current owner
> (e.g., to prevent priority inversions).
> 
> Proxy execution lets a task do exactly that: if a mutex owner has
> waiters, it can use waiters' scheduling context to potentially continue
> running if preempted.
> 
> The basic mechanism is implemented by this patch, the core of which
> resides in the proxy() function. Potential proxies (i.e., tasks blocked
> on a mutex) are not dequeued, so, if one of them is actually selected by
> schedule() as the next task to be put to run on a CPU, proxy() is used
> to walk the blocked_on relation and find which task (mutex owner) might
> be able to use the proxy's scheduling context.
> 
> Here come the tricky bits. In fact, owner task might be in all sort of
> states when a proxy is found (blocked, executing on a different CPU,
> etc.). Details on how to handle different situations are to be found in
> proxy() code comments.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [rebased, added comments and changelog]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> [Fixed rebase conflicts]
> [squashed sched: Ensure blocked_on is always guarded by blocked_lock]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> [fix rebase conflicts, various fixes & tweaks commented inline]
> [squashed sched: Use rq->curr vs rq->proxy checks]
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Link: https://lore.kernel.org/all/20181009092434.26221-6-juri.lelli@redhat.com/
>
While we are evaluating linux scalability on high core count system, we found
that hackbench pipe mode is sensitive to mutex_lock(). So we looked at this patch
set to see if it makes any difference.

Tested on a system with 112 online CPUs. The hackbench launches 8 groups, each
group has 14 pairs of sender/receiver. Every sender sends data via pipe to each
receiver in the same group, thus it is a 14 * 14 reproducer/consumer matrix in
every group, and 14 * 14 * 8 concurrent read/write in total. With pe patch applied,
we observed some throughput regression. According to perf profiling, the system has
higher idle time(raised from 16% to 39%).

And one hot path is:
do_idle() -> schedule_idle() -> __schedule() -> pick_next_task_fair() -> newidle_balance()
It seems that the systems spends quite some time in newidle_balance() which
is costly on a 112 CPUs system. My understanding is that, if the CPU
quits idle in do_idle(), it is very likely to have a pending ttwu request. So
when this CPU further reaches schedule_idle()->pick_next_task_fair(),
it should find a candidate task. But unfortunately in our case it fails to find any
runnable task, thus has to pick the idle task, which triggers the costly
load balance. Is this caused by a race condition that someone else migtate the runnable
task to the other CPU? Besides, a more generic question is, if the mutex lock owners/blockers
have the same priority, is proxy execution suitible for this scenario?

I'm glad to test with what you suggest, appreciated for any suggestion.

The flamegraph of vanilla 6.0-rc7:
https://raw.githubusercontent.com/yu-chen-surf/schedtests/master/results/proxy_execution/flamegraph_vanilla_6.0.0-rc7.svg

The flamegraph of vanilla 6.0-rc7 + proxy execution:
https://raw.githubusercontent.com/yu-chen-surf/schedtests/master/results/proxy_execution/flamegraph_pe_6.0.0-rc7.svg

thanks,
Chenyu
