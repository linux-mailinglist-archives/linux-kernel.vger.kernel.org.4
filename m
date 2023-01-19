Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA5673CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjASO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjASO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:59:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9E7EF9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674140362; x=1705676362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2KC9djAjmjxcnLGmT+Es8YCXikrXJKYhSwY1Awn3sPE=;
  b=LO/3lLFE8NFTrTN2wuI5hcBSqENgrN4DqxXSKeohcBggid/vYxo2stI5
   xzYFlnHRYrnyr6D2JJw5ELj5gPTP0xskw2Msd0AlTCb4L93P6JD1yDRjJ
   bcKROfVqS7Wj3wxbOMzkktyGoXon1GZCjRHb6hgvOhBCs534JnS01zhJp
   b07Vy/7hnx8dexRMWWl6zjk1GkFoUxjtM3nSGL6jCR/3EeJN9+QaD9YTj
   L+TAkXh32Q+fWldGTgVAGNoYfw2BEtf5avO0qYxSSpRiBzY1dLeYWPhix
   U4G9NEUxGQsTMzjaOWI68LEwbeuoCoXcYTKD6k5AvKjD5rIcFkrd5+tHn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323992389"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="323992389"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:59:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610087081"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="610087081"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 06:59:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:59:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:59:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 06:59:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 06:59:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvGljHsSpVIaIGdPUjZnW2Q5CbdFu2fjPqYF4ZCarkXfqE1VaHFAEXsiJL48z7TsflE0uEDoaJMLDEEedrnD6gunH4/8piRH3ArNYZwbyoTEuMWH6NlSZuMx1/Tig/Z++61rVDQc67ExZa1BJPUX9ljldCVz8oCTbkIYN3GXNzMBHckry1QQuFd9/ApoTuSbzCpknpccwkNnHyJoorEZzHXPLwdzmFG6KKZuhJbjK3CBgttOHobEJWaolkuFIR/NZm17mHCQW7/3baUeHBHpKGdd+bJdpAxMA4Y9uJOp6tW0beABWXiMn+cJmBGBHPvH7cTQaDKABndpHDWiAoaWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldLk4pOg3c59DBIrSgDe+THXtZNgDwo3eCn9ho1KO00=;
 b=dsOA2b/lNNXCffTXlEvgjetl/eUL6lqsb1dfwlgVqWQTSep7uoLj/wUb7oiP8yg7KyDiP/ocQS5ghCC0uVjdEbZ8WjwklXIpjNpOTst+gpvFCTWHOwcyKBAnKqnRtXl4QWaWYZ3y5APCZ1o+o9kBVjixaOl8/39Qp8KMwWaeEZ3v6XGgjbE8bANl5P0WkneSNhrXQvGy4Vmmn+bpphLiEKd3SRTZLQdfx2L8eqxIJfU2ctmooojzAIk0cyc+WmlLpYKRfpN5npVOgxSADX29xwSrZcjKPTHHcnLw4ot3hUKU2uhMX1aRL9aHam/LWQKtQJIjJ1Q8tuyiZ5jtfBbWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 14:59:13 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%6]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 14:59:13 +0000
Date:   Thu, 19 Jan 2023 22:58:49 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Tianchen Ding" <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task
 is running during wake up
Message-ID: <Y8laqT+7OX0I3pCu@chenyu5-mobl1>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <105eede3-2125-5a1e-836c-954fc67f575b@amd.com>
 <Y65RNzj522d7Q3OI@chenyu5-mobl1>
 <45b9c3e5-7ab7-0256-790e-cee92c37762d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <45b9c3e5-7ab7-0256-790e-cee92c37762d@amd.com>
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH0PR11MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ccedfd-a46b-45a1-c72d-08dafa2dba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99Rv0bbfMBixWXtcwgQS3AkmFoqCfcP3aPDT+ivSJ4Q65/TG1pUraVOorTr+zIbROUqbspJjSShFjuYohBtEQolz4wKzDwGhOzbtO5Tac0AcfslVnHM2BJQIkspX2A4eJ9gx7p1xGTnPyGyw9bv8UAgludTIbPVUUbiUvpRiNbRKano7xj+vf4TtVjTqxfhFTOItFPFQjvqb5C0epoeSf6YdiMjEAgx8nxluwyewarTKydDVbJ7IN3zymHUnv7XSIWMC5uvNSkEmcEDW84kEwhUw5EmriLwqFtMlhBeEEzarnxL1K4fKVTqzUBasV4QNgBSX8RTsiJBBsk1h7Xb/AIM86GkLpzkjmcDjhGuXcJs9IS69hAXGRTHUMZyhQS9SE/EcY+PqdkBez7BY/jJaNyy1aIW6/nBCmZM28TqUUEfgUbUeigtG2gTkcH4y8ht6rJ8PvjBYEQA0Hrgc4GCxJY+9thKNrZdAJ6FMNTIHXslIGWqHH5jj7bwx8AkbY3x4WW5twVik6EtTBPuwxppvvbHIi0ZRPJPBHJRt4sD2msgL6Mu/tV2NRanwdaszFV7i5uB8q0XWVcaB0RYazIVApA5D2+ozxHzirJyoZXz73YiaSHxixPWhvteJw0RVC+EO7EdC6ZZl8xGvu93L3cm8zIS5yUY1wPfQRkpYKkhccZzWbQCwurUtJZtrvrIAj3nD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(66946007)(4001150100001)(66556008)(7416002)(8936002)(2906002)(5660300002)(66476007)(82960400001)(38100700002)(54906003)(6666004)(53546011)(316002)(6506007)(86362001)(6486002)(478600001)(33716001)(41300700001)(8676002)(6916009)(4326008)(186003)(6512007)(83380400001)(9686003)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b9bRXnAGXumCub+xa1EcsCqntQgyBREhtiu7Arcq0rPzDDmNI69OQjbJA6pL?=
 =?us-ascii?Q?8Aiv4YcZC1yjqh4seNOTxdDzc5DfCYeNKC22FQANVKQb+stzYQjOK3mKPS4c?=
 =?us-ascii?Q?BPwKFW01zeJjK42Gl+Zwf+rC7vPzUwrB3SCvyVft5YH9G8G6syLUx/Oyk/go?=
 =?us-ascii?Q?GOnWARKN1i9EieXkyqFORNPKv5FCwkQ0WLSHRxBGdI6JNz5L2WAglX1+unwo?=
 =?us-ascii?Q?Z9T57TZBUmGHPgv73azbG335by5Nf57REEEj+J0X5XvwrK5q/o3U0tlBdiX6?=
 =?us-ascii?Q?vLmUYRsK2MU1CgsN0SV8NdAQ70H4w5Yot7ug5yXx49YYjmpXvrBxYa6N8LDh?=
 =?us-ascii?Q?7jNirqH7w1C0cFcsA4AenL/6wZNVyY0E20tRmkEegJmDVZRGnmFalR+ihSQz?=
 =?us-ascii?Q?jepkk/VXHly8OWIetDwgox/r+JMaz8MT/hmfCG9N/yg04RmVr9qAvXmTisgF?=
 =?us-ascii?Q?GU8HrF0IK/Yggq130fCvo/pd74y9heln1YotuKkb3uWmz0hpgXMbYY25xpxv?=
 =?us-ascii?Q?O/cenO9Jk2zjjaw9K1Ti+nVvzINysdwxnCisa/J0TTPEYrqtPsPlQvens9ls?=
 =?us-ascii?Q?IBdROab+YcvqZFTzgKvV6S/1kS+2Cds0JoUMJVuva4flF1INboNWm/aoqKvQ?=
 =?us-ascii?Q?qyjVOdwDD8mUOsuYgHn0/lcvfbeFgQl2RII8a+k2PjR1cDKnfXn7/NXY7a0p?=
 =?us-ascii?Q?7IZ/S0WJvUTu2LHXdeERgaZdtAGvTw04Yd8Mnv6z5wgfE1UQ/KS3j3Msn4Zk?=
 =?us-ascii?Q?JKmiX16YKCDZiH5Ffbl/wyi3BBvLx9MV3U70pI8RGGm9EZZLyRKJmla661os?=
 =?us-ascii?Q?yKhA9ScqeQzSLLcQf7reHDz4+ToS9zT3ch/bqrYVUirpbHa7PYRnOUOmYBUr?=
 =?us-ascii?Q?L0qpCbjksDY0u7rxUCguEJSO/sCF6AAEpaNHVrymwYZJJ8zQ5YCSm9mJPyF1?=
 =?us-ascii?Q?ryRtrgw7P2nIzZXm0rW5tRmwPINK1HDqh/qLSfREoAMiRk+LWtDDknXLZEih?=
 =?us-ascii?Q?x6DQKMfXswzzC9igGcre4kAd6PaSC8lUPY+KL3Jwktl2WUMkun8umPQ29C44?=
 =?us-ascii?Q?Nve1/0Ubt2ikYErZsBXXQZGwXfP5X0vqs/hR4uLW9GODyRSB2zjyPYXEKzt6?=
 =?us-ascii?Q?v2gYCs02xcK18EEJbz4eFj+uTDE17Qw9GT9LkxcDb0a0KP8TqKRR9Sw0rh1f?=
 =?us-ascii?Q?HEtSTNzwLuZj/KtBwyIttfx1uet69k7f32tfkCjt6IHNavC62MbBzDWkhEuf?=
 =?us-ascii?Q?0HhXS9bwXkbyFoS6fUKWfq0OUX9BQ3xsSQdUM4hggvQZdQ2lfoU7jvyoGakN?=
 =?us-ascii?Q?ocTurtjQXOrt7xh/LJ+qXvfnffAG1ydIMOVB08nA89CB1LH1P+cb6EQ2XInv?=
 =?us-ascii?Q?mg5BaL3RwYH82UCKZYoHSdfmgJ5Qf15DTI9pjUWZqW80pnE0Ik9i/XSD0rQ2?=
 =?us-ascii?Q?T6fEE8qDsAemrGcWM62kaZq9JTWQPzhWlaaNt4vTK+sAKqaE/6Js8sWWFqQE?=
 =?us-ascii?Q?+9TaalpYkFEaK9q3Pq7CtYDZFlPXHTRNhhLgu4TIoYRucpYp3amukXWvFlhB?=
 =?us-ascii?Q?WsbaiO97C5iDSWjtAr6AALIa59wkDGvMIMyri1CC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ccedfd-a46b-45a1-c72d-08dafa2dba4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 14:59:13.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1J/iks0ytg1/5wmHkT9wH1mmaEhOgsYiT9cAcNJkwUOxwf57JpR6t0XFme06mB6Tz5+aCM5i3LyRwAfmRyyPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-16 at 16:23:13 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 12/30/2022 8:17 AM, Chen Yu wrote:
> > On 2022-12-29 at 12:46:59 +0530, K Prateek Nayak wrote:
> >> Hello Chenyu,
> >>
> >> Including the detailed results from testing below.
> >>
> >> tl;dr
> >>
> >> o There seems to be 3 noticeable regressions:
> >>   - tbench for lower number of clients. The schedstat data shows
> >>     an increase in wait time.
> >>   - SpecJBB MultiJVM performance drops as the workload prefers
> >>     an idle CPU over a busy one.
> >>   - Unixbench-pipe benchmark performance drops.
> >>
> >> o Most benchmark numbers remain same.
> >>
> >> o Small gains seen for ycsb-mongodb and unixbench-syscall.
> >>
> 
> Please ignore the last test results. The tests did not use
> exactly same config for tip and sis_short kernel which led
> to more overhead in the network stack for sis_short kernel
> and the longer wait time seen in sched_stat data for tbench
> was a result of each loop taking longer to finish.
> 
> I reran the benchmarks on the latest tip making sure the
> configs are identical this time and only notice one
> regression in Spec-JBB Critical-jOPS.
>
> tl;dr
> 
> o tbench sees good improvement in the throughput when
>   the machine is fully loaded and beyond.
> o Some unixbench test cases show improvement as well as
>   ycsb-mongodb in NPS2 and NPS4 mode.
> o Most benchmark results are same.
> o SpecJBB Critical-jOPS are still down. I'll share full
>   schedstat dump for tasks separately with you.
> 
Thanks Prateek! I checked the task duration for these workloads,
they fall into the short duration task range, so SIS_SHORT takes
effect.
[snip]
> 
> SpecJBB Critical-jOPS performance is known to suffer when tasks
> queue behind each other. I'll share the data separately. I do see
> the average wait_sum go up 1.3%. The Max-jOPS throughput, however,
> is identical on both kernels which means sis_short does not affect
> the overall throughput but only for the critical jobs, do we see
> the regression due to possible queuing of tasks.
>
If I understand correctly, most workloads on Zen3 prefers to be spreaded
on idle CPUs in the same LLC, except for the scenario when the system is
extremly busy(and SIS_UTIL handles that). As Zen3 has 8C/16T per LLC,
it is unlikely to trigger the race condition I described in PATCH 2/2.
I'm preparing for a patch to also take nr_llc into considerdation.

thanks,
Chenyu
> --
> Thanks and Regards,
> Prateek
