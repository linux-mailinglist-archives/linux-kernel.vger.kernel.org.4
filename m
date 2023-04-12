Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A46DF3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDLLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDLLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:43:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEF761B2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681299773; x=1712835773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7iHpqsdbaJa1DxTzjppqIarnNPqy8HGj/Ps/0bsyqag=;
  b=UYc+9H1SSQGi5eK7CXMHAH+PPV4ukmYpbsnIUEnzE1MIjYdBWpv0Y2FL
   avGZnPeDn848HtnecncfmikohCqPYPueeydIPy9EKfW+t6If6iU+YWBSy
   uBt9d6XfVg2iVFZbTH7W3pmTAr5leQzX9xFzQ7ZkCpKE5dlFxg7x6x39N
   k2vY2rsKN8oGmAq91f1gkkOh+1Ij1Cjx8GaRHTOu6ssrtnZPLbIZDgqej
   WCFB3ugvKMivZZbYuCzSbNhl8FjI3akT8z8G3l2/YDBdR4IfuiqdTwKh0
   G1/u5hlJWZ9/5DOoiTrfE/UoZHxsi7COX7X4pBdpQXgNIzozZHjONPQgq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345661407"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345661407"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="721538059"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="721538059"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2023 04:42:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 04:42:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 04:42:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 04:42:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 04:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbSu94xOBJbF/GemFgKaNf6rjbNQLBBUBGwBGyqz6E2Sj70USTACYY8iv2LOJ/1zit13llBfkKeZoU+IHgqFPKlx6KUPHpzqoFDQ4vy/HFPCsBNKEQr1sa4vOJ4QirTMLtUXlfnPpt40DeGDimXw6huS9L3M8D4IQzJ/N1l8z8eoR0cFGhBN9LCardyAiGB8UesuNZQo1OugOUQ2zfehA73Hm+o+wkkfJV0/mlyp24jXc1dveS9HJDG1HAu93rq48Re86QtXbpDFch5uEiyumQHxM8Vpu/kZ9PXXjrlVxmoNeW5L60dRcBAnFuuTXXKN8nMshMRFTt0zNOsP+8I+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Drx8D5z/zzpK1t8UwlbQosEbv9c2j2Q4DlpqL5ZtFNI=;
 b=KeTgSGkrxY6Vv/bcQBcpT9tbYyh9yXmhqhLK+0Dc0Z1HpgI2VeUmpD2bw0EZMWD9SCCvfWTfATeKrEyoTW6okCXHHuzWjac/afSFTF3vT3pmSqXQ/I6kOSsfoPPzXtXPbxcaclWaOPdoTN+0CAiuJOPiqosgRLY/aAbg/698lnNS1b3VMzNaZ1eOLJi7EFehd+SrdQXzgWQ4RU3Gm1quR74U5mq8TMhixtS5+pAPk453uX05B5E/olV4J1/ITo3beHtm/FYZEIrEiF1dRP+CG4vP9hHj8u0y85iKqtsSvrQt0zrGyCuVgUioPwdoAn1uATcgtUhvEoH5sV4Rpbeh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 11:42:49 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Wed, 12 Apr 2023
 11:42:49 +0000
Date:   Wed, 12 Apr 2023 19:42:40 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230412114240.GA155547@ziqianlu-desk2>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2>
 <20230411131221.GA7356@ziqianlu-desk2>
 <20230412091043.GC4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230412091043.GC4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:54::22) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 64529f39-cedf-47ac-1d5e-08db3b4b0a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLR2cWBZe0P9aeG5tXLlYTn5GYvz4wE+eomRkhBp39wHFyxIVHVRBluFaGFuVIFu44+qh9yVm7ZaIh/dYq+G9eYnbVli9kZtoKBjyaqnTXW8iCUE5d+nuzWwhCjH7gEFW3e+zs++akMkvF1Wn8VRR10S9ZSys3KkCaNa3+IZPdcHK1bsTVSGk+lawNFYm81b2EiCjd7sLtyAuYl3jOMBLFyFQc7PKrk8B0Xl1LEXCTpyUt+bx/PGQ09cCUaWFvSI2loZ0Mt90ZLTGcAHkOY35GbxHcKeLQG4cPtbUaDGjO6neO6FeJFwe63OSJzWEVNzZYI/M42FV1xiQljEackuGw7t1lvJ6mMV6nFJ+/rO5o7TkcezUwQe2QMzugQJMntaY3TT7EVeyy7LtZgj5dsacxTsXl0cKuGI050DWUUgaihiMYFYBeIiiOPlDiGgpVfKX7u0ongBZDfiMMnXwMCx3KA4ov1fFabZaEdd/x23a3jrMdK3jdunJfLVHNdW4ccns0ooM/yZZIrxmkmeA+NKzr4q75M0k72+aS8w5EXxGzx+KepWhayNjipx6PTOcf4N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(6486002)(316002)(66476007)(8676002)(4326008)(66556008)(66946007)(6916009)(54906003)(478600001)(41300700001)(33656002)(86362001)(83380400001)(6512007)(6506007)(9686003)(1076003)(26005)(6666004)(8936002)(2906002)(44832011)(5660300002)(33716001)(82960400001)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ir/HE1FuZccbROtkXhte0w2JXDBFzWU1Of6wh+ZvH33ce7SQh9tfb8H5Y8C?=
 =?us-ascii?Q?Z3MdyF8uycu9bz/5ayuOuIGoYjnLkWTLbJa8Pqb6v7uOcp3IU7YCJcqoM8p6?=
 =?us-ascii?Q?wu5iVh2PEo9vefrrCxCTdRpZ/M5ydLtviqipORgjU8ejld/pMgB4srwjlL1p?=
 =?us-ascii?Q?UzcfQ7GnWhT4Lz+R6GoRYvcCGmU3A5skmsyw/wRH0BKamCoxTAd1I/6pKADx?=
 =?us-ascii?Q?VaJy5VCllcFopHiq4/Q8qLETl7XZfYQGLDENBDCBilxIK+5LdCPMlCltlw5R?=
 =?us-ascii?Q?ifqRf0ZdC03JPGSmKNfL1E9Lzy/nN2y1tIfBYbWaI5unbeSnZeqWir4q74nJ?=
 =?us-ascii?Q?mwp28bXXyyZCEHylwV4ZE0xc5zEWY7g+1D+qd5x5O78spGZMURN476IAbERx?=
 =?us-ascii?Q?gpyUMSuf2PsCPvws3mQTSCjy7JkPE4SMPFQ2ya0jRLMAoCBvLrk5HM50hBoy?=
 =?us-ascii?Q?nZURlXGavDbIroxDYQG7X1LBtsmeoDH5PVreDQ2ys0tsv8osYU9MGFT8gA0L?=
 =?us-ascii?Q?IEhpssRXkdudGr2ZeRzpon1gmAnn3g3ii/rbLtgWG3iYJbJGciG53e0iUjQ1?=
 =?us-ascii?Q?K3gl389PD65oHISx60bIc7KP4PLGsU5t79nR+CbW+XXtPp3wDoPjlQRhAcNS?=
 =?us-ascii?Q?FX60GOWsSsWFD6EfvxosOPQmAHOIiTOlP402rK1iDO2Yt5TiMnXYesT3wBtv?=
 =?us-ascii?Q?Du4gz+rPloUQ5OJY4AdPhRLr8kviI0FkcwyDd6MJ6qHkmI7BlJUK6C5dEG/b?=
 =?us-ascii?Q?B/HQF6LUvxkmXFiWHyVHtcBEgCXp7G+IaicROQa021au0/mbHZezN+MqM/Ri?=
 =?us-ascii?Q?hNvBy8377bO+1ZIzXLxoJpgh1F+K7k4LNi/KE2rgCWrMDC6cXDAr7kh/PJw5?=
 =?us-ascii?Q?Q4RXikbM3AMdc8keFZWs7xUF44r7Cyj/BtOpAPlRcTmmgg/x/ZGt/I7Om9Bp?=
 =?us-ascii?Q?FyChAua1Qr+7eQKF2RFF3rmaJLm3FisOEHFy9weI1x2btJCs7cQdkcCylIkc?=
 =?us-ascii?Q?CPEh5hSAOOI9u/b3fbs6tQSQbcY07Cqxow5hJE4aIz5Mt9ph4jC+hCrRWas1?=
 =?us-ascii?Q?TwEgj/mKuIzeDnAljUVu6wcITrRPyKty6CT8zqkrsmdzIHXTZ8M+APzTRpie?=
 =?us-ascii?Q?4uoILDVgBZkJBnpli8xVNrJK1t5cIprOLOGNqm4V79AhX/Vlf2XqI55bRrMN?=
 =?us-ascii?Q?Rw1sKXw0n1McMNtSjDTAW5S6yXlRJ+oYCVB4uzz39WR2RVk3d8jrKuVNLcQx?=
 =?us-ascii?Q?cq9GT2WRqtGrSpkhHqhtQbauITQFqNLNhuHlrjH9qWn1pzsAlg70Q3ENDg70?=
 =?us-ascii?Q?5SF/6y8/eHEJzEZ0TEBl9WqvxHjLe3eDuxKivY361KL5mWec/8YnC7ssjOf6?=
 =?us-ascii?Q?4jfnwhYPfPkIcMFltQugvlna7bqbPtNWMfUKNZ52wXn6BCNf9SNjCn1Rk7Kv?=
 =?us-ascii?Q?KzZ+MKkYa7voelb7NYRy9MbYZ1JydojUyu6TMTUBiXrU61Uu/D1HhOv+ATn/?=
 =?us-ascii?Q?k6WjPuSKrL7FyxnykCLTP4fizSt79PuyVuomswmlzxOOoc6bPOkaoMbv2/gt?=
 =?us-ascii?Q?BjaIK2ppbmbqLyn9X1BjyYYlFVOuPDoPGK5tjcwL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64529f39-cedf-47ac-1d5e-08db3b4b0a8b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 11:42:49.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGd5LrOx47Lopc4Y5RaAMeEJdYxdZrRiz521kfz+S4/N0nPTWZUicNukiQVnxbI5tP9vxpYVAUeGRjgBUbAVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:10:43AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 11, 2023 at 09:12:21PM +0800, Aaron Lu wrote:
> 
> > Forget about this "v4 is better than v2 and v3" part, my later test
> > showed the contention can also rise to around 18% for v4.
> 
> So while I can reproduce the initial regression on a HSW-EX system
> (4*18*2) and get lovely things like:
> 
>   34.47%--schedule_hrtimeout_range_clock
>           schedule
>           |
>           --34.42%--__schedule
>                     |
>                     |--31.86%--_raw_spin_lock
>                     |          |
>                     |           --31.65%--native_queued_spin_lock_slowpath
> 	            |
>                     --0.72%--dequeue_task_fair
>                              |
>                              --0.60%--dequeue_entity
> 
> On a --threads=144 run; it is completely gone when I use v4:
> 
>   6.92%--__schedule
>          |
>          |--2.16%--dequeue_task_fair
>          |          |
>          |           --1.69%--dequeue_entity
>          |                     |
>          |                     |--0.61%--update_load_avg
>          |                     |
>          |                      --0.54%--update_curr
>          |
>          |--1.30%--pick_next_task_fair
>          |          |
>          |           --0.54%--set_next_entity
>          |
>          |--0.77%--psi_task_switch
>          |
>          --0.69%--switch_mm_irqs_off
> 
> 
> :-(

Hmm... I also tested on a 2sockets/64cores/128cpus Icelake, the
contention number is about 20%-48% with vanilla v6.3-rc6 and after
applying v4, the contention is gone.

But it's still there on 2sockets/112cores/224cpus Sapphire Rapids(SPR)
with v4(and v2, v3)...:

    18.38%     1.24%  [kernel.vmlinux]                           [k] __schedule
            |
            |--17.14%--__schedule
            |          |
            |          |--10.63%--mm_cid_get
            |          |          |
            |          |           --10.22%--_raw_spin_lock
            |          |                     |
            |          |                      --10.07%--native_queued_spin_lock_slowpath
            |          |
            |          |--3.43%--dequeue_task
            |          |          |
            |          |           --3.39%--dequeue_task_fair
            |          |                     |
            |          |                     |--2.60%--dequeue_entity
            |          |                     |          |
            |          |                     |          |--1.22%--update_cfs_group
            |          |                     |          |
            |          |                     |           --1.05%--update_load_avg
            |          |                     |
            |          |                      --0.63%--update_cfs_group
            |          |
            |          |--0.68%--switch_mm_irqs_off
            |          |
            |          |--0.60%--finish_task_switch.isra.0
            |          |
            |           --0.50%--psi_task_switch
            |
             --0.53%--0x55a8385c088b

It's much better than the initial 70% contention on SPR of course.

BTW, I found hackbench can also show this problem on both Icelake and SPR.

With v4, on SPR:
~/src/rt-tests-2.4/hackbench --pipe --threads -l 500000
Profile was captured 20s after starting hackbench.

    40.89%     7.71%  [kernel.vmlinux]            [k] __schedule
            |
            |--33.19%--__schedule
            |          |
            |          |--22.25%--mm_cid_get
            |          |          |
            |          |           --18.78%--_raw_spin_lock
            |          |                     |
            |          |                      --18.46%--native_queued_spin_lock_slowpath
            |          |
            |          |--7.46%--finish_task_switch.isra.0
            |          |          |
            |          |           --0.52%--asm_sysvec_call_function_single
            |          |                     sysvec_call_function_single
            |          |
            |          |--0.95%--dequeue_task
            |          |          |
            |          |           --0.93%--dequeue_task_fair
            |          |                     |
            |          |                      --0.76%--dequeue_entity
            |          |
            |           --0.75%--debug_smp_processor_id
            |


With v4, on Icelake:
~/src/rt-tests-2.4/hackbench --pipe --threads -l 500000
Profile was captured 20s after starting hackbench.

    25.83%     4.11%  [kernel.kallsyms]  [k] __schedule
            |
            |--21.72%--__schedule
            |          |
            |          |--11.68%--mm_cid_get
            |          |          |
            |          |           --9.36%--_raw_spin_lock
            |          |                     |
            |          |                      --9.09%--native_queued_spin_lock_slowpath
            |          |
            |          |--3.80%--finish_task_switch.isra.0
            |          |          |
            |          |           --0.70%--asm_sysvec_call_function_single
            |          |                     |
            |          |                      --0.69%--sysvec_call_function_single
            |          |
            |          |--2.58%--dequeue_task
            |          |          |
            |          |           --2.53%--dequeue_task_fair

I *guess* you might be able to see some contention with hackbench on
that HSW-EX system with v4.
