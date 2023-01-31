Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2A76822B6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAaDVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjAaDVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:21:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF132717
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 19:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675135306; x=1706671306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0RHhXnuvxWQ9nM/Bktey+5KM74KDMn96bZQd7VYs+3U=;
  b=JPt2RVXedpazQkY2Jg8oF2NWcQFsVvs9J82E2U4ushfcSuvtNEEHf7hD
   mawtE1JLFJEAeUOaUo6gulIgXwgcnSe+Hu0vWpI0qiJtVteHNaDfl5Hzf
   WWFRJxezBcMHy3MXOwTS0holwYBI63g6nvgKu2WYcvpHbIr42n1wp+lSG
   mklssPjkP1y/kPSutaC7i0jYOA0VNMEf8nGQ+cSK0ZcIwNXLkxT7Etzp1
   24V4Q0icjO6zjxmzDTH+vNFvyqvaPAyJc4Z5NGh/DAQyQl2ATdHktQPrY
   2KgVc8G9wv5bpcgvkNarQbn4CUhQvhVAdmMfIz6mnfhfqBgY07GNTa2HW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325436380"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="325436380"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 19:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732939656"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="732939656"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2023 19:21:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 19:21:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 19:21:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 19:21:45 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 19:21:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfY0zeVx2SlCdBklXWEAsL1mqm8vyM5VQptdw8Ndh3C4VIorG04CnK0m21sUA9S6X7Y9wwRLWrOSNjX+diWShIG6090YCro/eDSRPptA6d5/4IPz3OVSMDdiehkfC6On+LflapvtV5j2c2NyKwNuy49sxmrc6AXLmMqQSle3r9dMs+2FhB2oUeUcF6WgEkXMgLdLBO2ViNO9fCYKQao1WxuEatbFdhT6ZiwfrWbpZj3Fv9+uFz166QB4Jqq6pp4MmQ7yN0Xp4fX3rf4OAbMGciSM1kucqx0I90rIzyk+svjd3FaonOfn8nINVmx6hlf8wCYSQWFDwWfZCuBdRIkhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkCKmcqRrWCAPf95izsSM+Ctwc5OeDbjs2aTYAgdhR8=;
 b=Jr9mw20VAY51EKlcSi9vDXGv+pUnVlF6LRXWT/L37UdAZio07C4s0Fvb/8IrAN9ovRA3Y8PgXNXycH1NgAuI+FbS5jHyBG8YfbXn0xvWRldoXVmZXNMNEKTlwYgpDEV3/GwQBD2Umb7dkuS3DC5CxGcnWtMgyQPq16gxOaovurlNnj5Kr28Vjywj1iAKjWHq0Y/UDETKqXpzVoTUv9UUlogHPmaYmqNAVkTRNsMnG557CaFXEXki4AorQY3Tm/MWJoe/4cjvVlOxtZDPeLl1kbiCnm6QpAmULhxQGrjvP6yM2NAKvva4uqL3hBdhjvw2PAgJ6CSnoCXy+qrbfTDDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 03:21:37 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%8]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 03:21:37 +0000
Date:   Tue, 31 Jan 2023 11:21:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Roman Kagan <rkagan@amazon.de>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9iJLQxyXp9+x2aF@chenyu5-mobl1>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
 <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
 <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net>
 <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH0PR11MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f75f100-adcf-4e77-e2c0-08db033a4306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wJ/gE0FT4D5pf9frByUjHpvHCNV5etMosMEC4pXO1gJL/VzVFg6qY/zLr8iuAL5dOJuUpuVW2v/GBZCR1glSJMtd35zP2Epp4MtJ8K1pxlUhEalQxkirqZquYHSWEL/A1gwpwxVP4zbF26KSILpFn7TlSDtK+p4vQx2lcx/nFFyaz63DGge7gF7CuhL8Cz5zqH3BE8fac2vkBSQSEtwNTXw+zezZ7/MY6g+Wwo284lx8JNheK7L4BzRLBfMmKZtHlBspQGpxmAjOX3WplqrNfovm9BUNc7VVWy9OSWOkKNMyeDVfS/GpF8B3L6rq7sWGUEYeM83Kl0MGAp0aTrwG1kQYky7EcwN8ytj1HCSODJRgaHNqJgG8v6u3vyypiXE1Ki1Kddbdz2cgeqkD8444ldw/eqoERCXUsuItgEZUw0aHJRnowSbhLh1A5107SGiMLN+Uvw545CJiFjw+f3yEWPmCLfmdczh2AAICSehwf4BMVxAmOQUCdNLMur1FyjFD1PIsw4PVsj83MAiDsO2v9Ht8zPNOVNY63Xr75xbosiND9tTAZTU/ZgcABLKY7CVFp0aSfoKG8DDeDKXTjAMwHPc9oBfNntmb54CcNsEoRpU8LykeP/zQp0lMjIlxUI32MzrFc02dt4CgLzn/iRhj/ef1wBNIZ2XbQQUzJBYKpmO1byXUhX8o+Lsb6NSSoGt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199018)(2906002)(33716001)(316002)(54906003)(83380400001)(6666004)(6486002)(478600001)(9686003)(186003)(26005)(6512007)(6506007)(53546011)(66946007)(4326008)(6916009)(66476007)(66556008)(8676002)(8936002)(7416002)(5660300002)(41300700001)(86362001)(82960400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoRD+R3pxDIoiDFL8nVqZgYpglQgDUbnnXG2kK2Ma8jvMh1Im+GPHEmqkuLC?=
 =?us-ascii?Q?QPCAnSCuEDO3eGfnzqF39tdfydUVdP6EAuaaaFea4zdkRhbd91RUFmqFOcAf?=
 =?us-ascii?Q?Teml17EnHDUI0nIUnw0o0mPEbNFnO6UfUOagpqroQDg4uBpkvjO53Tp8b6J2?=
 =?us-ascii?Q?tw6PgxEw17pVfFyEBBNnXnGK+SNL+/enmGumebakMjjhyts1gYxoKyXlk0Vy?=
 =?us-ascii?Q?Oicc+tQN129eOk4mswrpNZCxbuqTgb2r/jMPgN3/8t++7DtS1NafqD2HTw47?=
 =?us-ascii?Q?IBPRdlMg3I1nlheV8/uk/fEbtWM5iZenqFGARdKbVigg1qz9utBKFvrEcAHx?=
 =?us-ascii?Q?phH/59h3dma8XdYaybVOHINqiLttM+2tIju1BeFn2S+l7KFm7ciwoejfxw00?=
 =?us-ascii?Q?gJ3fpYT7kHXHbRstX6ki38/vsRp3gcP6nqgEHmNoP1THhciMTp9Bi1A+g21v?=
 =?us-ascii?Q?z/6dWoixxxBHgksS33ndTfBbKm9peel6H+op2H+QSX5mfm4oGIV7tJVtaSsi?=
 =?us-ascii?Q?9At/Lf3Rh4SbXroqzOiyZfeJjpZQmr6DIXz8w/HEwK35eS7/Fc3SPveL/MBy?=
 =?us-ascii?Q?XJfBlnEI9QFktBiKd9vFO/GBY9vWoqTIyuKe3deQDrfeSg7jZGJgkxhRI6JN?=
 =?us-ascii?Q?txkxoBImzLHNgCfA6XfR4TA0OjZ4nm9a2hvxVHk2m8QLYoeR3MvOwFTm4HCm?=
 =?us-ascii?Q?6w1BCWIb0KO28Y4xVYY7BPUGdgtTEw5wq/fuFevgorrgAjQBc8rqJLTu610Y?=
 =?us-ascii?Q?+LmXGKxQGW37PT5eFnba4Z6egHIowY+Js3n0BYQ1hl3cGoVi2ARrPA+PU1QQ?=
 =?us-ascii?Q?T3samqSdROJKLOlm1mXUj5K5YVAj6o58BYJtKBk77LORFkSy4Uk8mIiourvL?=
 =?us-ascii?Q?QymFvf4/et6egJaUGJsdmt9DLLbyoKLx/xfcP9z1Hq6PQaJQRx4WM97IV4Iv?=
 =?us-ascii?Q?LMJRJU09+1uT1dzq9q8h60rgoU5y5o53uokxd0ONlRooSSO49ZOv1qNMscLC?=
 =?us-ascii?Q?PfWdP9xsSkzMyEu2Uoc1ryX6eArBmDhFEsGOC5CpNi01L82xMQ6AcfrfD5er?=
 =?us-ascii?Q?K6ya8CpLifTSiwrq/5kwR063xvF5PPG/QnJtcTQyqQW2kMF5Spt3IQyhIVGP?=
 =?us-ascii?Q?zgQncpOJILzbBt2WcALiiXz3rK1KUmi48FYmK5ssTTCL3gO+hkJzWPsVte95?=
 =?us-ascii?Q?I9l7a58D/DxmmhB9Ndm10SDuyjdHNBcVKVR+dwoKNZdX6HZtkoVCJbTr2hyq?=
 =?us-ascii?Q?TOCauuR0HNSF01xQAIDJiaofOsy2WUc0PffrZrGRcJrEoNOZwMoAD888gBiN?=
 =?us-ascii?Q?OQ8lsoODBF1wpdZLOO5WohdtRXwjDY9qhHtxpAJdaIP4yIl2Ft/ldYdttpOJ?=
 =?us-ascii?Q?Q0+gxjo+wu0SPNFWBPzUD7mGYfmemIgkOGsyRvfsLgTrBFzZY8gDEX+ByMp8?=
 =?us-ascii?Q?lk88G4EAc2AHPEWeR0jJkXpc8461j3CCoBEM7d8TQlCYT636V66lLaWe7EtG?=
 =?us-ascii?Q?N+QnaVUa6BvfVETvq2ZOPYa+A0mErbgJ1vVU4/mfDWrkmcP+4S6DoR0uPPHL?=
 =?us-ascii?Q?lx4urJOdnq0iGchikJalqQRMUQFLIVYtVpIk39qm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f75f100-adcf-4e77-e2c0-08db033a4306
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 03:21:37.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToOzPpPQiRLc9XOYYBp8F+oeWOBeqXUTRn8/a7mY6yLgP6HnTFl4kp2NA0I1OtalcNkF++44msydSLPem1idvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-27 at 17:18:56 +0100, Vincent Guittot wrote:
> On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> >
> > > > All that only matters for small sleeps anyway.
> > > >
> > > > Something like:
> > > >
> > > >         sleep_time = U64_MAX;
> > > >         if (se->avg.last_update_time)
> > > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> > >
> > > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > > others were suggesting?  It appears to better match the notion of sleep
> > > wall-time, no?
> >
> > Should also work I suppose. cfs_rq_clock takes throttling into account,
> > but that should hopefully also not be *that* long, so either should
> > work.
> 
> yes rq_clock_task(rq_of(cfs_rq)) should be fine too
> 
> Another thing to take into account is the sleeper credit that the
> waking task deserves so the detection should be done once it has been
> subtracted from vruntime.
> 
> Last point, when a nice -20 task runs on a rq, it will take a bit more
> than 2 seconds for the vruntime to be increased by more than 24ms (the
> maximum credit that a waking task can get) so threshold must be
> significantly higher than 2 sec. On the opposite side, the lowest
> possible weight of a cfs rq is 2 which means that the problem appears
> for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> value instead of an arbitrary 200 days
Does it mean any threshold between 2 sec and 2^54 nsec should be fine? Because
1. Any task sleeps longer than 2 sec will get at most 24 ms(sysctl_sched_latency)
   'vruntime bonus' when enqueued.
2. Although a low weight cfs rq run for 2^54 nsec could trigger the overflow,
   we can choose threshold lower than 2^54 to avoid any overflow.

thanks,
Chenyu
