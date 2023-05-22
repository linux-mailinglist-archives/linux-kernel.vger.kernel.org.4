Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2D70B403
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjEVELb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEVEL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:11:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5CCA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684728684; x=1716264684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7PMXzUkrxIzlHQaIFjOFXcsP2yCwSmYkFkO1//XYU/I=;
  b=iOi48xr/ydMKWsz5+7LQjwBydOUD76TEnxNI1c/2ZS3qhoyUQOd5PCSJ
   Td7E4EsvyJKeZzC+VIvioQ4qKbfPzChA5FfS4hVmvn7nG65atTwT6t5CG
   d6KLermZh0zH6w1DG24nbOAxq4VrTDAnAYbV0luWmZLqTz5x+/hs0xfJV
   jrN+w9P+oNlB9f3uPZ2lTEtMjYAdAbJpTF191Py4UIParaPUVI4jYEtHz
   ZNLbH+uwia4d7SxAj36DmZQdMl+P3T6SnSN/TEXgyO13aQ5yICAum8yQZ
   SHiaBJ4QNBrpNMkuQIPpG0i2+9dj/UyXXcuarDZHz+LI99yCoT7EGcQmb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416282904"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="416282904"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 21:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="827562075"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="827562075"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 21 May 2023 21:11:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 21:11:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 21:11:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 21 May 2023 21:11:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 21 May 2023 21:11:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfgKFQZDUKdg6n0sBfqfQDH5gSgYJdqj66W4EGRI1gN5mbCkdo1rcvGko0mLoihEUKVWNEslR02tx7nZL1VDs8Kx3WJqvDq0S6eg6R8Sw2TcFi5veIt/zfxf4EKV5rVLuaDmsAYEB2VVNbWcUEU73+cgtD8926XFJD7wbJQKm8B9U9FrnPbykqoHRc6H8rJ6GJuLVRoccVmL/bEYyGKgE3VZiLcS+yO4qA3ItkQyPxl9XbF07MYO1+RwN/KoexwqpfeXebBm5DUI2Kos0+6MCUR7Hl/QjpMhPT0eDM7NBczZ0OeneQsOZosDXYK6eu1PWiu5sYewt03f6RgpLjvFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcvO6kP6QPNNnrxQB+CeA0XPk+sdCJprwuyzW1FfuqQ=;
 b=KaJzNfPrbzN9fk2v2XMHnXUDDxBxOePTihUrLpKFdjvQPi9A6cRXDhYlF/h+TNjWnhQ0jnfTrn9Xz7Nnd+TYmnc+hniZRrC/Q202aqMAiQ9Ve25l/8uQfODmjy8MpD/3cKDZB/7VFl/bXcM/CGs+LBpvMB9ggG0V3Ray+0O2C0PeEP2jLJ7dDS7/KhLGS/9+DdhvrxvbOVS5VAbrxXb5CDtZZnNBcA/LwzygAmBmgZlYcqDut1YKU1CaL4d3zZTL8/MmdLyKVP4nbQY0L6UXKLxxhZVDTa+im3T/MySEQfmZ9bpw1A1ay6hgmiYrk/LGigrPFWlJQlzoPnpXCr+YsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 04:11:20 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6411.027; Mon, 22 May 2023
 04:11:20 +0000
Date:   Mon, 22 May 2023 12:10:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <ZGrrUVZBY6qqeS0K@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
 <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
 <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
 <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
 <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
 <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
 <ZGWmveL2YTiXp2XR@chenyu5-mobl1>
 <12061140-4f09-b83f-843c-2fb8ff9f6e81@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12061140-4f09-b83f-843c-2fb8ff9f6e81@amd.com>
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 0863e868-bb43-4164-c532-08db5a7a982a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5RJMLyAXidwqAZdcJ7elmjx8CPHD/O9N9ElPlJ+9poECE2QZMroCLx+lQP3GFOt+dvpJMnPxZRUp1AZwR4/rpLqZfGE1vyDmzCfhJLse5dIDU4LmabfudAAudEugaoCq19kJ+PQbS7Hcrt2CyqPKkOu+LfIm2XypEYme9LHvGXGg3jwMJpSJ4/DyYgfihG5xUUzI+TRAGrNLhAJU4cLyiWvcCE6AE5JJhK6PLQ7qx2JewES8xCPHVcdOV7GRNd+sVi2yhVjHgce2gGrm7mCMum85ymMJt/BW2JcStu7uRpbZvhs0ITQ4LFEuNsvPFiMjfw35jTkMxUJ4uE965og3dOPIyNuNjr7yIfOz6ffbh7vv6Z9lKSaDeiHkhqpD4J4/KHomZiQhgt03SWcarjrHn8ciLYC2lR3eLFQyG9fgFn+fqpRa/rwjDJCvZycy4ainhbyt0qCyM46aux7/t7Xo1zajhh0YZ4xhalEpR1I+PSlCBYTvoi+c9xef/+d5MBaxa1w2Ks39giagaZ5jkywkgVw/P+m3IP0yJiz+ONWOZEyi1kJSZUOMspt0fyAg3Ut
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(7416002)(186003)(33716001)(26005)(53546011)(9686003)(6512007)(6506007)(86362001)(38100700002)(82960400001)(41300700001)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6916009)(4326008)(478600001)(54906003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7qjebyzTTf4ersh/U4P3vu0iwjkhgGDqYbit0Is1u3QBH2k6ptnr5fXHebn?=
 =?us-ascii?Q?zpdUOSOZ44xzCCsCw+YdY5XoXU3dvf6YkQGYbuk+74TR4N3KgsfPIo6/eJrh?=
 =?us-ascii?Q?9kAUuSDo3aaisyaOYMIhCrO67HCuwZIQBeMfLtuBiMVw5PE58XOwV+sDKcd7?=
 =?us-ascii?Q?hau45zdqYdSAA0tzTxQmdwXEGEtXmU1oh8hBk6KJ19d7R52uFXzUWyD4v6JU?=
 =?us-ascii?Q?rzTo4zZO56Uc3MAF3b0FGEwq/cNojShyMbXUsF97wF3ZvMWmvNpF/cgpAymn?=
 =?us-ascii?Q?0PhKS9O4jo/6ND0ZrSgfvUE25kjm6LLYJB4bgtRFU3YmTBj3CcZeZS+nUt1P?=
 =?us-ascii?Q?nUfyUmFZ7pka4v6qDPmfabCYjbl0jtB3Gj6RL9lKNzeYDncLUOzsO1+xeaB4?=
 =?us-ascii?Q?nx5kLUEqwjhdjOevU9jaULiyQHrNDv7In3s4Ei5+vDf/GQ17fH+EMJ9UBVwz?=
 =?us-ascii?Q?a8dgCFcSFqnIugLyrrqmU4Zcsp4l6LcEhe1K19LbIhIZ3CLT+E+Jf8wihhk8?=
 =?us-ascii?Q?UwosnJcv9zSAhstXT72HYt1Og/Cm3tFmyPpBcZog21S5rZOZy9dy+ZQcKJPv?=
 =?us-ascii?Q?FX64Pd8eO3kV7y/4JM2quCqWxT3uunpAkL3bKwTe6bRwpB2/YeIMhkkXWh3Y?=
 =?us-ascii?Q?rn7Cjr2oIrGeVXqLspj1HFW5hOLWHNK4z+BzY6ckkXERBXQPMxBJMoINv3O1?=
 =?us-ascii?Q?sg8XEPfaiTln2ZIxPZRnUQE8pvCZvCMBX9L2FBWeWb5WEr4JyBOyZyjUf7jr?=
 =?us-ascii?Q?ze6YCes9lanQkbGz6fB65yRZQvD/72d7pX00aEDiN1WqAtb/M4FVUrLSCJHO?=
 =?us-ascii?Q?mic0NVI8JGkUdihQTjxW5LIFIGoOpZSmdaV4zjeavKbnSMn9R6Huh/orYr5B?=
 =?us-ascii?Q?oQXKGQJ11eOh6KP8jd+dfW0fxR7+upfOg3UdoimbcTvQL25E0ekU9ADdkp5b?=
 =?us-ascii?Q?pKQTpDKLevmQ4N6LcGNv0OIxwmMdMINALjZVQp7vPgwKvyfc4IxeoKjdoVg9?=
 =?us-ascii?Q?aPwZkySCb6wnGO0oEaKOan48U1HWg/Psc2C0DC2BmFqiPC1fxdp4zL6lD6R3?=
 =?us-ascii?Q?5lyp5qJ0YyYpFDe4waW4NcpCsZ7o3vPVohsEVdfALijhy9qeMGWALRWix5HR?=
 =?us-ascii?Q?4N9idgR60mipcLzj0C9CJv6I7xwdDtJqKkkkh3Mb40EA34+coXf5nZzGVVCu?=
 =?us-ascii?Q?6ZuTW4QO05k5FI5YGEaxEBYdFBItGfjNol9o2Jvv0gNjMgfJZsKzVm8twcmy?=
 =?us-ascii?Q?zT1oCorNXggivgT4+tU5kWAM6iVMOtB/QSfW50dpey1UerLo3q/oJ6EsHtEA?=
 =?us-ascii?Q?6JIrT429VhGJh07h+6931VFtkHrMNdcYpxC9ol0EImupJisdY82lP1hqjAbO?=
 =?us-ascii?Q?csKhHRCxcpmiGf67V+VQK/BawEL4bqf1ZR6dhpdQF44jQLbL8XlxJqC+2HIt?=
 =?us-ascii?Q?ydS/M4yAnejGfcIGngFv0KGTJ++H7h29xuGZpEzGSjezFBXL0XN6VFkJFe3V?=
 =?us-ascii?Q?NwXOaNUdIpCfxPMnfL/AWkfiwoKtwEqdWQx01Zdzk/eekTwxWIQNUVXszq7P?=
 =?us-ascii?Q?cm2LwxkGGJK7sT0YSUGnadAB0arPPPt3r7drR1HV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0863e868-bb43-4164-c532-08db5a7a982a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 04:11:19.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9D3hMpzJaf4UDfQZ22BcjQSRdg0QjTNSz4lx5XatpMSOaOvtDoCgbXjAPZ2ZgnAU/+W8d1nmQMrRGL9pCBI9UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-18 at 15:56:12 +0530, K Prateek Nayak wrote:
[snip]
> >>
> >> Also wondering if asym_fits_cpu() check is needed in some way here.
> >> Consider a case where waker is on a weaker capacity CPU but wakee
> >> previously ran on a stronger capacity CPU. It might be worthwhile
> >> to wake the wakee on previous CPU if the current CPU does not fit
> >> the task's utilization and move the pair to the CPU with larger
> >> capacity during the next wakeup. wake_affine_weight() would select
> >> a target based on load and capacity consideration but here we
> >> switch the wakeup target to a thread on the current core.
> >>
> >> Wondering if the capacity details already considered in the path?
> >>
> > Good point, I guess what you mean is that, target could be other CPU rather than
> > the current one, there should be a check if the target equals to current CPU.
> 
> Yup. That should handle the asymmetric capacity condition too but
> wondering if it makes the case too narrow to see the same benefit.
> 
> Can you perhaps try "cpus_share_cache(target, smp_processor_id())"
> instead of a "target == smp_processor_id()"? Since we use similar
> logic to test if p->recent_used_cpu is a good target or not?
> 
> This will be equivalent to your current implementation for a single
> socket with one LLC and as for dual socket or multiple LLC case,
> we can be sure "has_idle_core" is indicates the status of MC which
> is shared by both target and current cpu.
>
Right, in this way we can avoid the issue that target and current CPU
are in difference LLCs and has_idle_core does not reflect that.
And asym_fits_cpu() might also be needed to check if the task can fit in.
> > Let me refine the patch and have a test.
> > 
> 
> I'll hold off queuing a full test run until then.
>
Thank you. I'm also thinking of removing the check of last_wakee,
so there is no much heuristic involved. I'll do some investigation.

Meanwhile, I looked back at Yicong's proposal on waking up task
on local cluster first. It did show some improvement on Jacobsville,
I guess that could also be a chance to reduce C2C latency.

thanks,
Chenyu
> > thanks,
> > Chenyu
> >
> > [..snip..]
> --
> Thanks and Regards,
> Prateek
