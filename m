Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348FB7106B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjEYHsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbjEYHsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:48:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C851B4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685000888; x=1716536888;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L2B6pmV1mFrHWGocabJv/c72Da4WuHufoT5udX1jxcY=;
  b=WAL93Nd7GrUh6KlkhqbeAs8xoEgz5l+sd3FBvvbHq2iJrPQ7642bKKqe
   9/MeF7tu2dqP/fCjFEJCTNfp/QHc0F7Pv/v0alREW06EAttilJ0Wxt+mD
   wv0xitYouVStdZEExldObnwggQJAwD59oRTpvJoO4Mk1dnF21JUrou0Ej
   vq20u7W2U/uctBYWFuAMJez/KHREOkVpT6xoIwK1ys6B8lNSezuVmOGi6
   WRnJJVVTqrvJtAJLju1kpnOWxU0LtHi5Ias9pRX6rz+78e3YpVAp2g4GY
   PChXce5GeI77ElDu8kPVLgKWiaPlwYZdNNF1YRK6ZMtFYE0DNGQCbZ8qw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338391137"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338391137"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="828932577"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="828932577"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2023 00:48:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 00:48:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 00:48:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 00:48:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 00:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZEqvSU6LkoYtoenrLFWsvK1j7PRsZEUjqvPFEQIQx/UyQTWrZ47wuB1ov6qjfoc3b7Wz0blR0eLXH34+47+2FjElq75GsrOwYznC+hCMc+pXoUxa0/UmdGIxuH58HUhyBSFaGnZE0svWdd3KheqiZUYrVZuXJyov3oPWqz/YYTfKBD4+1K7e3FPOwsy+OuaDRC/IlCHY+KOrnrWC60Y6WL2okjRTcIvY8KEuON/Lams4/Vq/jVIg89xHzZsKcs0Dfl1E7gzfpiJB1OgDWBigRQKjscRYrIODn2gNcYcWg0OYO2z9qrVViYiuhekt+MW9s2XaMsF9qvqCaNxkiJWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRXDJgOfkfCAhyt0SBzwmKGcSDK8Qkmy8mCNps0YGkw=;
 b=W2+Rru2ZV/e2krr8fPra2oq8jeH0/09M/29pVr5NPAv6om+PimE39LiiXGefc3jdXCRbvOyPzipVKV6WsgNu2UPDOoj5x8fVNSVemSeUqwdPe2GKwLIhvpP01UbMC8QzmJzMJShTGoyp6KwDm1g8AD2llEMfBqiQPMLMQaUJCzN+Gl5+rr5btHr0J9o2yCXn9dCue7sOlaG8z+IK6MEmRi6Qc09lOYLUbSkckVieDSr5VNJAtMxU7Z7kIA/tlW+bJSZ12cgTThwIXTM36MRddLrPxWF9wqkd2UXXZ8x/jMmsNv3v1/WnG+KSpjd6WQ/F43+DZHOOItmzt/AP1q0ArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 07:47:56 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 07:47:56 +0000
Date:   Thu, 25 May 2023 15:47:36 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
Message-ID: <ZG8SmByO0g5fjOc7@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
 <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
 <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
 <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
 <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
 <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
 <ZGWmveL2YTiXp2XR@chenyu5-mobl1>
 <12061140-4f09-b83f-843c-2fb8ff9f6e81@amd.com>
 <ZGrrUVZBY6qqeS0K@chenyu5-mobl1>
 <5ffb7ebcc75c106d791d4b5c4dece4b74c551245.camel@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5ffb7ebcc75c106d791d4b5c4dece4b74c551245.camel@gmx.de>
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL3PR11MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e0e9ae-105e-4e7d-38b2-08db5cf45a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9pxED2nFr1uI2qfZjHtBoECbFRx6VjiRPjVqQfERnP1o1NhyMXiN/xKyYck1vfAMo92g/QxilbR9H7YYDsvIphLkPT3VPPcwUsJKNauDEKf27O85Cbgfq3tssbZI3gfG3TD3yw/YTMwEsU+u4lub4ye6dpdamvXFSnxiJiHAE5dWwcIzj2sWq7r2f5OSs/RRlKQC87rW5BM5p2+V+WB284WU9z5Ci64fF/aaeCmDJkOr1/KFZtezOy99wX98R/0o2lNSdEEWlcTnYE2TBXuCVNOhglOxSIVV33y4KD2mg2g1Iq7LA4Lx1RQ3vHgUU7yMhm6AV8a+CSsTJCulXZmwJi1Pkh0w5UCqNjXKflnuYh62HKyaQzm+kU0p+73wKQEcPy7UdFNB3SzyevO4wi6riYc25UPRXiH6tQ6GEcfPJHsn1h9FYPu0RJ5/G7bLAgsyZwaoTnEK/ExUQeC8AdzvcmBPyVyKFchxvdb8By3VFqZ183+YO2OkvWaQ3B39/38OaeR4EuFYiyzyQlsu/F4zcytdfT375BK6kCI0xHY16E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(54906003)(478600001)(33716001)(966005)(6916009)(38100700002)(4326008)(66556008)(66476007)(66946007)(41300700001)(6486002)(86362001)(82960400001)(5660300002)(7416002)(8676002)(8936002)(53546011)(9686003)(6506007)(6512007)(2906002)(186003)(26005)(83380400001)(316002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NdSCfmMnnIaq42ku/rJYstdqcZ9RpNzcPw/p+lgEBTDlAfWKixACdL8ehkIK?=
 =?us-ascii?Q?hfLpCVg6njvKMEAUf4oSysokBG73WPQNetrdOQHkkQkQW+5yIx9eO9ahge1a?=
 =?us-ascii?Q?yJGjdl6HO2ikbdl+Qf/nxaPIgn7LwxR23D59c7KGvBgNwL0/zGE9QtKGrW0R?=
 =?us-ascii?Q?iV8BOG9hMDsEHlrXkfs+BhlZTkTyDmVGdl2FigrB0L5eo2K5/qW0aICoUc4e?=
 =?us-ascii?Q?ldJN+mmg0wuhwraGQAUrsI1nnbxReEZKJ4W1f8SFBToafwHynkBcptz/oBH5?=
 =?us-ascii?Q?TwKXxDyo4DJ43quYwPbWRjRqWFhfRykDYs15lfn9AmWVxLiAQqmVLhGQubJ6?=
 =?us-ascii?Q?B5PbaqT0O0LwaarnJeuNj+jTkL4IDL/ME+lzeCb3zPE/e9qY4MZCFozIXMRF?=
 =?us-ascii?Q?CrUfkBOIMimVC5uvnjr2wm11w4QM7DBWxII3tlWriD2atCswLhOym9ScH+at?=
 =?us-ascii?Q?bRth6q1pZ4vgb5fIxrT8n1joMgTXUP7LdMoWD+NRPOtGx1l0NEwUTYAGm1xJ?=
 =?us-ascii?Q?D2dQWVR1VsOpmmlBTVGHDELdJuKzxemU3efMUzCak4wq3WHo9lT7DDRjsiAq?=
 =?us-ascii?Q?wg/ufOxrimQaK8o4Chb85Y86Odwp6Ca/51M6yom+vCDZKoq04y50XLsSF95X?=
 =?us-ascii?Q?PlEwcG3O6DlHpq7p2prRR21Ey/Yy8G09RzKduURQ9cFLinRvE9oYb/27yWVy?=
 =?us-ascii?Q?oOwIkk+6IYs2cs08LTUrx79mtAf3YJA38+B4Uxz8AZigveTo0N1i3o0ls57s?=
 =?us-ascii?Q?GjgW1+59cTqy9GB1wqUXzgQnGsNPnQaxgpINj5dqllUOzhKUoaAlC0+iEz+o?=
 =?us-ascii?Q?ZJu8BgzCdQZ7FfwcZXfkNJFLU03WpT3IN/vgqtt1qCLFa3O1u7iO/ajCmrIX?=
 =?us-ascii?Q?tvpdxbrWu/2pyKRi3z5hMpDyD+jWHevuk7qQXPDNgSnyjJu1ZKEiB0N730qE?=
 =?us-ascii?Q?J+R3KTyKPKAIdk8IeEMQda9jW3Mnuxqyj3zYUDSKLiU0iK1M4hZdn4QGG0wS?=
 =?us-ascii?Q?qMhvgBlUWD89uvL9h+fLiLc5qXBIHRk0CMz53WsgGMdXskip/t4pL7nCv98H?=
 =?us-ascii?Q?uHvQv2or6kQO78f+wiYwy0tsU3czpo8fU6KqTi7X7Dmg2gXXKJKHzEqHTJOE?=
 =?us-ascii?Q?jJy93sM/gaM8nt2fgIBnq2SEXaZEiksZb6dP6sv95oQ6h5b743JVq1+r0h0F?=
 =?us-ascii?Q?R4EpkLzR0/MT3594ON1OG5sZ7V9m5hQi/8yjr7sbtatnr2a+dU9E2G9B4kNy?=
 =?us-ascii?Q?8r7pZnuBUM6NgZOfIBv7vWPzBLAaIWIxrivTwovevO1bzl7MSHxmnmdnJVSC?=
 =?us-ascii?Q?a7DXDfbc2U3vt7tpNQdI+PeB0v5+4eEMTbGh+nNTbH4+yTkBTGN4hvcy1Sz5?=
 =?us-ascii?Q?GQi9mLUfoLJqjFF+NhLEgR7r5FwPJ87ayKzjUHPIZ86+lYeZxQsfcl9NBS8T?=
 =?us-ascii?Q?5ZjHHFglw4h3KjXzjRkw5xcjXMTbP6Kp0zC/F+fVYllAAurMl0Jx8PbiFMwB?=
 =?us-ascii?Q?tW/HDDHV3ufa1db8+WJyOiQkkZY/v9oLtHUckmXseYujH4i/DqYwJIZoDcOW?=
 =?us-ascii?Q?2obCyn6H0QQYlqSI8qa7fe6uixj8ANpKdYHy7Tn/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e0e9ae-105e-4e7d-38b2-08db5cf45a27
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 07:47:55.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWalJ1K9Xjc+0tAhdilgpHlfzGrkne6T7sIKl3gAiivgRARo1P/xDqPkMGyIgh66ovu7HhQLJq1hrRvqYdrlOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 at 09:10:33 +0200, Mike Galbraith wrote:
> On Mon, 2023-05-22 at 12:10 +0800, Chen Yu wrote:
> >
> > Meanwhile, I looked back at Yicong's proposal on waking up task
> > on local cluster first. It did show some improvement on Jacobsville,
> > I guess that could also be a chance to reduce C2C latency.
> 
> Something else to consider is that communication data comes in many
> size chunks and volumes, and cache footprints can easily be entirely
> local constructs unrelated to any transferred data.
> 
> At one extreme of the huge spectrum of possibilities, a couple less
> than brilliant tasks playing high speed ping-pong can bounce all over a
> box with zero consequences, but for a pair more akin to say Einstein
> and Bohr pondering chalkboards full of mind bending math and meeting
> occasionally at the water cooler to exchange snarky remarks, needlessly
> bouncing them about forces them to repopulate chalkboards, and C2C
> traffic you try to avoid via bounce you generate via bounce.
> 
> Try as you may, methinks you're unlikely to succeed at avoiding C2C in
> a box where roughly half of all paths are C2C.  What tasks have in
> their pockets and what they'll do with a CPU at any point in time is
> unknown and unknowable by the scheduler, dooming pinpoint placement
> accuracy as a goal.
>
I guess what you mean is that, for a wakee has large local data cache
footprint, it is not a good idea to wakeup the wakee on a remote core.
Because in that way the wakee has to repopulate the cache from scratch.
Yes, the problem is that currently the scheduler is lacking of metric
to indicate the task's working set, or per-task-cache-footprint-track
(although we have numa balancing to calculate per-task-node-statistics).
If provided with this cache-aware metric, the wakee can be put to a candidate
CPU where the cache locallity(either LLC or L2) is friendly to the wakee.
Because there is no such accurate metric, the heuristic seems to be an compromised
way to predict the task placement.

The C2C was mainly caused by accessing global tg->load, so besides
wakeup placement, there should also be other way to mitigate C2C,
such as reducing the frequency of accessing tg->load.

Besides that, while studying the history of wake_wide(), I suddenly
found that 10 years ago Michael has proposed exactly the same strategy to
check if task A and B are waking up each other, if they are, put them
together, otherwise, spread them to different LLC:
https://lkml.org/lkml/2013/3/6/73
And this version has finnaly evolved to what wake_wide() looks like today
in your patch:
https://marc.info/?l=linux-kernel&m=143688840122477
If I understand correctly, if wake_wide() can decide whether to wakeup the
task on an idle CPU on local LLC or remote LLC, does it also
make sense to extend wake_wide() for SMT domain and L2 domain?
Say, if wake_wide(p, nr_smt) returns true, then find an idle CPU on remote
SMT domain, otherwise scan for an idle CPU in local SMT domain. In this
case, does has_idle_core check matter?

thanks,
Chenyu
