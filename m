Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFE65FCE0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjAFIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjAFIgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:36:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D668785
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 00:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672994101; x=1704530101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RlU3RaXN6sfs0/gJAKZrF65NdwRNdr9XEbIjwD8HLQU=;
  b=FSTMQZ+lvPMl1cpnJuRwuUoeW5k+cbG+k/MtQyyME/1L4OxayhnsKyru
   GUsEFtYOe0iKAVwbdkJlmZrrEADkRu9GtUOPeF46GTvB74NS0q0rFMw0L
   MLFvCuMqtc9VFsr0oxeVRvK7v8xu55E7f3XW4M7syMFP6l5SnOFIsZvET
   MQTEmAc1gwVbGsvxXfZgBEeGYN1FzGcZS7av57kRdiZCJq89TEm+lYEWM
   J7WiKK83NU8lFFjpZBrwjxiellLjOQ8s9WKb45e0EAScK1wdEJXj/YrAC
   ZW3kHmDHkjRRZEudInCPvA5Gy9GwM1NXGeiAZzQe9MjOLgHhCR0FjkSTq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="349646520"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="349646520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 00:34:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="686407282"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="686407282"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2023 00:34:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 00:34:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 00:34:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 00:34:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 00:34:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khyje0/G3YBKmcyTgWyI4usmT/gOAEnDocE8fI2xO5oK9v7AzzzXjxsoPMlpvkQ3W7o3B37JZA17DVj6loONAk31R1/aIqAKTOmexzsLOT7OcdNnMVUYYc1Ln3sgtAMLRtkgeQLDrKqpPZHG9yd2gctZ68x3w+n3/oDRUhE95zYwldcSqzCj8QcKMSgnVv6jkYaFZ0Fxf2Kg024mLnWKPdwpqc9udXDnGSQdRu/TyAHcMD0KkLyOsLVEt1x388gzvdngBaur4q5gWALlkoOIGXI1Q9hkc9yuP1uGTLfJYe+HwNU3vdT+Sgc3Fe59sKQMoE4TNGIHayUQOZleQ4nWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvxgy5CmDoyiKvB0yyuzwkgyLw/FHI5xcymMAQNsrKw=;
 b=UQCzxT8lz7RXbjuCpuy6Tt6SSRzpZ88S3s5FXG9VbUddWpAH0RoCWBAo26QqvJtZb+KMtve6OIxKE+Z67NHIByycCXJ4HIBcrnpa9BEISosAc4AnyGGhFsgttqIsGQ4EcFE6K6vHiugcxB9Q7Tz71GbJzvCrv8fpaT7BBjV73oZsOCtF+ae5tw/u4Ar2CJczIHvmWX3rPBaQEQ9Hk292ADOa6k/uWc3KZCyIGf912DAxljBalottbevOuXu5cJsX/Y35s8JcXXrDJ+rkQ4hH5ahNSLiVRy2Fs2Sqaag+VhZ5R0VNKEyzx+8ghzifZdUc+5rN5kPilXVNWzq4ged0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7640.namprd11.prod.outlook.com (2603:10b6:806:341::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 08:34:51 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 08:34:51 +0000
Date:   Fri, 6 Jan 2023 16:34:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Yicong Yang" <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [RFC PATCH v4 1/2] sched/fair: Introduce short duration task
 check
Message-ID: <Y7fdEruJGTux4fYH@chenyu5-mobl1>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com>
 <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: dad06920-6e01-4a27-02b1-08daefc0e096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD5BsUI8OAeT5stBlIDEoktT8rRMOeY4E4jKTH7LkYGL41RU0rL+ahwe+dmXF6tfDAPfXgsu4b8BlLXpxnTsFxCi1llHe/VsWIAG8zyKhcJmahBo6DyJiDDXnMWcUdc/wOWtY5Mt2sfZeYA+nSQQqWj6+NpucUFROTn9S3YbNikWYO2jA2tRIi0I39Tj0bP116BIXwJO0VPOlU2a+cSMy7P8QQjAbKEdVQA8lxc9SKAVR6DJpJKYl2K8+5pu84ati8EpzNPlWk1nyAGulyjXbL98BnFB8kTDX5SYWJKor+g+KaOsYaVOExwSfYivd7/EDZTwqvUOS1Rp5PVHhwjthAhwyG0HPltDMXWf2HBBW49fom6XblOzdHgSMNpvg+d4aE+syzE85pn8ju8dFyfS3V8OYLm2zdDjxEXf73weKC/nyB6vzc2dlrBuIV6xnw2mPEzY4kh8r99p8ZcWw0QkxrO4ntriB7mFS8CzOuBRYB90/ecgxsaNenTJ6RYPyAcX+i9L/fun42hlD9ah6cPn+RaA+u+SZDD1/UsqdAjnUIzlTP1vCKfXEoficEE7GYU1EyWqqjsHzNaPfk4h+JLsvIFPQlEujmyFbpCN3UlhXdGLtKnjZnxPmM450NvMIXWMVykC/p8BjZkiBP8ZNdpqcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(6512007)(5660300002)(54906003)(186003)(26005)(9686003)(6666004)(66556008)(316002)(66476007)(6486002)(478600001)(8936002)(7416002)(41300700001)(83380400001)(4326008)(2906002)(8676002)(38100700002)(6916009)(82960400001)(66946007)(86362001)(6506007)(53546011)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Dq3uNGzJKefIouRu5pJNbYRWHvwGgb9787eHSYVqJMFxVI28luOk6LXm/DQ?=
 =?us-ascii?Q?Z4kXMzUajjO42RARDavWyzyUjjZ88CEyKRdAyB3kOHhonWSoLziUzivVqVvK?=
 =?us-ascii?Q?PERZIqTxzsPjsOaG80ycSVs3Za05Tte/v2T00WeFT5rriOcKAVPR1/LyFfJE?=
 =?us-ascii?Q?vVUBaENZO9cTzU/t6s9brNaGj1+4MytZvux+vx/UX19Zxr9rQiRz/4j28i3p?=
 =?us-ascii?Q?khT5SrTRcze0JFXpqy8ALOxifWIfI5HjOAWOKO7qcv/loVoaKlMFKx+h5H8H?=
 =?us-ascii?Q?jRELWAhF2zM60TWj4stV83oA4LReQPIxi1rYMhXH+Sj9PPaPU9fjtvM1l0w7?=
 =?us-ascii?Q?IFw8PR6TzcT3xvP0F1i2b7vIN7zj5AnwmnrDhZ6lAqO5p818ix9drQw1Vs6K?=
 =?us-ascii?Q?cfMIEw3N+OdVMO1TIXZIykov4pMlZg8TNRnGmmCbIPZYOxfealUvdp+9rT/P?=
 =?us-ascii?Q?g43I9zCiBeGey6nnEZM03ZR46dYdz6K0mz9AFSydrEeaEw3xPV8oJj23LU2T?=
 =?us-ascii?Q?Rlsp0oJtiS+bSHfCapjo0OkoDMmTikUj5yeMpF1hDmCYfRqe1NV3Lg4MMX/D?=
 =?us-ascii?Q?jz/jfM2+wakojk/GAAMKt36LVp7eE8tl8A0uI+puMwfkLSSH4GAaMkknBHP2?=
 =?us-ascii?Q?cvlkCXIUL0fLX3L3Gf9b01fZPu5JOu96BCAW4sU1gpWwdMWY7jCXl3G29Yze?=
 =?us-ascii?Q?5ccfBntU+//NpldV0cJhyIDVtY697RvzNZA3ZDpJ8PwupN+RwG+oG1UXIg2d?=
 =?us-ascii?Q?Cr1YPIXh7TracHgp30As2vJokyBUamKbRSS5NwxMDWzPxTid+AGCUe22R5SF?=
 =?us-ascii?Q?XCQoaF1zkJZUEw7+KGJ/IFLfBp0mIU3h+oEnfP4vgAgjbr3cVLWaOgZBW4yn?=
 =?us-ascii?Q?FI6M6Ou9mUFONcaP5YDdKfE6y6whjS2u4SYAC6GDChjJqFbAEBQ35Att3ysy?=
 =?us-ascii?Q?jZcQ9I2jas1j6J/klxNN20OqXU53VaZe2CsiCIk4+P7MhR46sanH+nu83fkN?=
 =?us-ascii?Q?Oax6Y2MsNxb4LPg3BQ3E5iaHaUkqS7070O6znrnMTGWAUzq99dJCMibpFZW3?=
 =?us-ascii?Q?M6yFnkucUxkQX77K7w3v+meJqhNzAljX+TTnYZ8hK3SlwXL0wCAXFjkq+rWb?=
 =?us-ascii?Q?MgQU9yXXi1EATuJNUTJBflpjJ5hEOVjO4XTr21Znt3f8ijX4UhxmxapGoaZZ?=
 =?us-ascii?Q?MqtKgMHG7AiyLCafLpJB3eHd8mcoQJDZys2Hk9MsVJmziaOM/IYM7J4zoBdE?=
 =?us-ascii?Q?rtuKZag03WcJ4gkMfLiWiRulW+aRzq0BEoxGasMeSciUqijxREY+kVZio7wd?=
 =?us-ascii?Q?spTFQ8GtLGyiUxEEDXbzhiKaqLfNCZXsIiPEazcYoeFpAlLKor2224Qrn1i7?=
 =?us-ascii?Q?McB+GmHIIWQx/o573R0Zyfp3ZsHIv7JRmUOHVJIR0M27wuyJucqq80hcD30d?=
 =?us-ascii?Q?Dfo7tZAWlp8cto2IqiOPf2EZajTUDGyY8/U9esJl+kFRl4JJv0ZtC7/xnnv/?=
 =?us-ascii?Q?P1wldsRqDIHfxKZobANRjO+6ono6hxToBjry0XxRBi3Iy0KMdiLpvAZO8AL0?=
 =?us-ascii?Q?GHvH++yrwwqkRBJ/nD9YJbngkX78U1AdPHB5jdil?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dad06920-6e01-4a27-02b1-08daefc0e096
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 08:34:50.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9d1CV92MqIwtGwwTXLzav8LaJ9ODqZy9rKoGCBwxm6gq86c4MziB79GK9eUHvvjhjSW+kTeaLOePofGfLYZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7640
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

Hi Dietmar,
thanks for reviewing the patch!
On 2023-01-05 at 12:33:16 +0100, Dietmar Eggemann wrote:
> On 16/12/2022 07:11, Chen Yu wrote:
> 
> [...]
> 
> > @@ -5995,6 +6005,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  
> >  static void set_next_buddy(struct sched_entity *se);
> >  
> > +static inline void dur_avg_update(struct task_struct *p, bool task_sleep)
> > +{
> > +	u64 dur;
> > +
> > +	if (!task_sleep)
> > +		return;
> > +
> > +	dur = p->se.sum_exec_runtime - p->se.prev_sum_exec_runtime_vol;
> > +	p->se.prev_sum_exec_runtime_vol = p->se.sum_exec_runtime;
> 
> Shouldn't se->prev_sum_exec_runtime_vol be set in enqueue_task_fair()
> and not in dequeue_task_fair()->dur_avg_update()? Otherwise `dur` will
> contain sleep time.
> 
After the task p is dequeued, p's sum_exec_runtime will not be increased.
Unless task p is switched in again, p's sum_exec_runtime will continue to
increase. So dur should not include the sleep time, because we substract
between the sum_exec_runtime rather than rq->clock_task. Not sure if I understand
this correctly?

My original thought was that, record the average run time of every section:
Only consider that task voluntarily relinquishes the CPU.
For example, suppose on CPU1, task p1 and p2 run alternatively:

 --------------------> time

 | p1 runs 1ms | p2 preempt p1 | p1 switch in, runs 0.5ms and blocks |
               ^               ^                                     ^
 |_____________|               |_____________________________________|
                                                                     ^
                                                                     |
                                                                  p1 dequeued

p1's duration in one section is (1 + 0.5)ms. Because if p2 does not
preempt p1, p1 can run 1.5ms. This reflects the nature of a task,
how long it wishes to run at most.

> Like we do for se->prev_sum_exec_runtime in set_next_entity() but for
> one `set_next_entity()-put_prev_entity()` run section.
> 
> AFAICS, you want to measure the exec_runtime sum over all run sections
> between enqueue and dequeue.
Yes, we tried to record the 'decayed' average exec_runtime for each section.
Say, task p runs for a ms , then p is dequeued and blocks for b ms, and then
runs for c ms, its average duration is 0.875 * a + 0.125 * c , which is
what update_avg() does.

thanks,
Chenyu
