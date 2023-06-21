Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D23737A77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjFUEy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFUEyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:54:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544C1738
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687323284; x=1718859284;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VZnBgjfbtReZhbGNBU5yejkT3IQ4UvkKzuPlmHdFueY=;
  b=RQV2bQaS03/xj8uLzT6C1M/KjMDtz3xwYgNLeXkx9pt4/06Xx1VdC3C+
   i9FjZqx/pe3Ooh9qMiQKnUBJxKtzHdx9yhav9NkQ+ez290Z6zJOohQox4
   3kjC0+bO+b8RZ1l0qIv5Z7NsqThNFUtroZzwchOAzSjaFwWnlDxfWZmym
   8ll4Sw7AMHj4gRmrD79PG7MqNa2v7P3dRCx8xFEf15ujKMJDPwBocPBOi
   Dmap5AeeCTdt2cFY96I9ESh6SSRM4BD9kGu9CbgoTc4amb7vbt72y+f0m
   YLhadt8eCV1co+GqsXvyEvrymKp+L4lBKsbo3pmIvM+mBFqSSqgh8//PK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363487112"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="363487112"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 21:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838468989"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="838468989"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 21:54:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 21:54:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 21:54:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 21:54:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 21:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhnYJe4/08IjXa1ZhAWdXVCgi02hJFQTswT1lXrwX9jdeOOoFlP/kCmngo1UXLR0JaQdI5yWrqaAK5oTwLSOwS9hQFnJchTKFXeSMMMSj3xP4kcanKVO+m2BmN3Hjcw6HKmqjfNJsrsugW7x1flZffYNZ+mhaaJb/UMBuFZOC50qQoXRj9/0zVwhwxw9UiVFMjSscd+76DvemheyoMi9ep4YbHX0CuHRBXOqHWP/G1IEfnfDdFiHYUkG2C/d4+lkcI81R/t1PqP9cgEhabyoZ2dlnhVUCWnWjGeuXxKaESoNQL0/BFponMDfvTgmXyhSoDjlh7kn+udEwtDi/h39+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwVW9nCV8WEgqTiGON9TKHBIOdJuaGKVA/fFJaZWZEE=;
 b=mLFU0tFwBlB+Hu1kxJwq/KtnfAQnadQhDkYvhhn/qI5+QHeWup7N1radBBY37/U8IUmDMEONpbKHIfevJFjyctOOgX5yxQSJ1ZXYnFatiZULpGqF3rfaLkBjLDvxGMcnqGzgm+O1t9QSEaspHyqv9o0QJDD5t1p2Ow0ONNKvyWSnLdRc+pN6NpyhExSSAd2lbDL1H4YZ/ftWGw8tLZyfWSzbky6sdTs5LkQcAYMY8yBH5Tr+uxEpE39e/KrkfBMF5i9Elu2U9MnYulHNd3Uxdi66QT7tpvtlJgDXIm4ltPqWdAnV7kpyb8Y5lW4yFdDc1FpzxtYraYmhunTWiRmi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 04:54:27 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 04:54:26 +0000
Date:   Wed, 21 Jun 2023 12:54:16 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <dietmar.eggemann@arm.com>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joshdon@google.com>,
        <roman.gushchin@linux.dev>, <tj@kernel.org>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230621045416.GA237582@ziqianlu-dell>
References: <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
 <20230615232605.GB2915572@maniforge>
 <20230616005338.GA115001@ziqianlu-dell>
 <20230620173626.GA3027191@maniforge>
 <20230621023534.GA236337@ziqianlu-dell>
 <20230621024300.GA15990@maniforge>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621024300.GA15990@maniforge>
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA1PR11MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 51471eb6-db80-4180-de19-08db721396a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKa7Uo0LqZy0v26owsiyhzpGN0gN5IYA2aOha/g4+XeES1nd2wBNMWHN8IH763uqEzfvMWQohaAQIe6pixPYO/Q/bjNOIXzO9XsqPRASvNgH0R1Xa/u8Zv/JBxxE4jfNrydyyCuRL0msOhsyV1iB5qyIeU325WjUw8oHSvsKrQRPbuzjP/qlD76ySMaIvfst1fxjf2rg2iGzBPET9EnATnN/PxyzK/U6ESuMAwopTjS3cA92dJqeOJrMhBkfyDNXSCUMHAMAjr2CHo73xCbrcVefkFGUuQqYpwe7VVpkMhOnEtsMl+IGGXlZ278pS8oBQwA+7Trl0mAjgTsym8FJdXNhlYsrlsxulHqfBATmXZicsPeFjpvBNj95DQSgA9Ksb0eT6JEqgp2Owl5XvljOWsSzg5Pdt0GVPqTJPDhIBVWsmQ6Dj0DlopyBwUCz+o+e4AB2BskgmWscIcLkjH9PAgoeB7laB6s25gFSWsfW4WAqFkpw3cg1S08XJo6nMttsUew9Qf5KtaROl4Nc6Qd3irXaeHwFV/1nGj2sPOOyWkNOwkCtt9sBT65G7N9OSO29
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(186003)(8676002)(8936002)(66556008)(66476007)(5660300002)(66946007)(4326008)(26005)(316002)(33716001)(6486002)(6666004)(33656002)(41300700001)(478600001)(6512007)(1076003)(38100700002)(9686003)(6506007)(6916009)(7416002)(86362001)(2906002)(83380400001)(44832011)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XN1bHCSI3Onir7rdRnr6T1M5m8o89BYBctnBDBQiEUtgtctY3f9BBMJPaFTJ?=
 =?us-ascii?Q?Gl5l2uGOGr8tGbuTF1n63qaMx8weB8FTlay+ZnBkk6FZ9i4BtOa/RnF5ocgn?=
 =?us-ascii?Q?0NgRCUFqkdS86It0jzazk9KpIZ/KicGopIoD4GeEIVDUQv258p9mqZH5WLJ7?=
 =?us-ascii?Q?ioBnssAKWZwY43XwXwYYdjFecvhclprhMWegWL337UNsndhEz1IWWO98Fl09?=
 =?us-ascii?Q?MU3S31PqnV9PSPpKy8CE4k89jgjk0354f62uHmLsmRH75ar8+ggYjNr9CwOG?=
 =?us-ascii?Q?AYbEtpcQwMSYC4UAW8BTmwZUX6oxlisn6UA0vQKvDzw0ybP4pwNGjBSPFyRD?=
 =?us-ascii?Q?hvgpuEAwhA3HYGIcYR6GOAJ47fdDKcELFUsShDIfHQR7621smhEeHTed/zo1?=
 =?us-ascii?Q?CGjQKGt9Q+J194v7yY0kKkJlL+nCVNibCZ+AlQHoVMQWtiXrGt0YZSoHEMNi?=
 =?us-ascii?Q?qdx3CWa8AtAqYI+y2Wl2fx4Cy0fNwMrPTASYL5JIsFb1B3HZGLUTBOioMeCS?=
 =?us-ascii?Q?EKuQPomP/mCIFzP5VgR+8im0QTGsBD7up9Ive88csseNwRoLjDBC6wlVMfrZ?=
 =?us-ascii?Q?PdnNs1Wcmrd1ndo7yBEo2XqtwS1J0NF2H4wYP29TvzWIVX24hLLWgwx7R4tP?=
 =?us-ascii?Q?5SD0tyTj5PUwA3Ir2U0TsscXFQaLIiEqR6zrjwkrSXWZL2v89krQ5+Og8wqx?=
 =?us-ascii?Q?h2NhhXyFsRpJI8Dt+ZK6Wx0KMkgFEgWsfdWT1z+hnqJNpmUnRf6Z4Zkx/1Dc?=
 =?us-ascii?Q?hPJn08mc/qD7/vGKEhgvmZ+X2nLOctxsvjRY0cXkBcIhaZmxjH2l4qwO8kaI?=
 =?us-ascii?Q?hBxcbosDRnczZFAJw8ddEGKq1p1sz+hBTXG4N0aoPxGhbi8TOImFeD0wdG1l?=
 =?us-ascii?Q?nMhmQzDSA/N8ZzZJTZj/achPlpc/+28Y1P4DVNaeWK6H5RqqTtoGjM8frWI+?=
 =?us-ascii?Q?CZUYQ0gkG2Ihg3RjY7UOBS+Chz6J+ESzrl13BTSc9hMoeL1pg4350FCOnzwD?=
 =?us-ascii?Q?p5GV4M6a7stjJyDYKK4oiOZD66KIitlsGGeXz3VI/9E4MyNFEQ+qZYRSK8RQ?=
 =?us-ascii?Q?TRuFMFug3a0Lw6y20aRJ/QDr/JGvpZQrzvAt1I2WhtCv2adupnjdJoDip3s4?=
 =?us-ascii?Q?dEnIlbY/ISJhh5DiJoRzjXwsrtVZJqPtKsTxmzel0PGBFGDpV59Np1OJjt25?=
 =?us-ascii?Q?rTc3zlylHdDldSteJPeEiwXfet5AFmrN+sMrGopCnpLOl9mb0DGWocQ4eNAQ?=
 =?us-ascii?Q?GGbAqJSdp9iQRhDJUky2CNVwL4YbFaBsO1w4H1HyV6dWKUVlE98aHRYIyGXu?=
 =?us-ascii?Q?tk1a1/lT0yTUjQrz9l82sWe91irnDYp1cgWbjlfk8ErdUj5cpbELJiVTW8Fb?=
 =?us-ascii?Q?Z8Y7CmeT/oH/aF5VU6KnNK+de8+LAMRUM05PfltH6ugb2tnkDX9J6iuPhM6x?=
 =?us-ascii?Q?aVQbyov/wfIdxH9bWwcd3PszKm9m4pAHJjaZ2WCB3W2xoEXwXXjm2U1uKOur?=
 =?us-ascii?Q?AFFINHVMckt1IraJ7l3HIiVOYrVjPuq4QAhg+S3W/x98etc79bcrLeB2mNJq?=
 =?us-ascii?Q?empXwUL7/ajCYAvLVVRtGZ6HswAUildwTM3frg73?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51471eb6-db80-4180-de19-08db721396a8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 04:54:26.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtlNJ/8jPZDNjAasZDc+qZadq51Bugf9H3frPi73tDuIxPfFL6C8xiC398twOWlebMvMRLF09tAoq5qJek1oHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:43:00PM -0500, David Vernet wrote:
> On Wed, Jun 21, 2023 at 10:35:34AM +0800, Aaron Lu wrote:
> > On Tue, Jun 20, 2023 at 12:36:26PM -0500, David Vernet wrote:
> > > On Fri, Jun 16, 2023 at 08:53:38AM +0800, Aaron Lu wrote:
> > > > I also tried that on the 18cores/36threads/LLC Skylake and the contention
> > > > is indeed much smaller than UDP_RR:
> > > > 
> > > >      7.30%     7.29%  [kernel.vmlinux]      [k]      native_queued_spin_lock_slowpath
> > > > 
> > > > But I wouldn't say it's entirely gone. Also consider Skylake has a lot
> > > > fewer cores per LLC than later Intel servers like Icelake and Sapphire
> > > > Rapids and I expect things would be worse on those two machines.
> > > 
> > > I cannot reproduce this contention locally, even on a slightly larger
> > 
> > With netperf client number equal to nr_cpu?
> 
> No, that confusion was only the first time around. See below though, I'm
> not sure what insights are to be gained by continuing to tinker with
> netperf runs.
> 
> > > Skylake. Not really sure what to make of the difference here. Perhaps
> > > it's because you're running with CONFIG_SCHED_CORE=y? What is the
> > 
> > Yes I had that config on but I didn't tag any tasks or groups.
> > 
> > > change in throughput when you run the default workload on your SKL?
> > 
> > The throughput dropped a little with SWQUEUE:
> > 
> >                  avg_throughput    native_queued_spin_lock_slowpath%
> > NO_SWQUEUE:      9528.061111111108      0.09%
> > SWQUEUE:         8984.369722222222      8.05%
> > 
> > avg_throughput: average throughput of all netperf client's throughput,
> > higher is better.
> > 
> > I run this workload like this:
> > "
> > netserver
> > 
> > for i in `seq 72`; do
> >         netperf -l 60 -n 72 -6 &
> > done
> > 
> > sleep 30
> > perf record -ag -e cycles:pp -- sleep 5 &
> > 
> > wait
> > "
> > (the '-n 72' should be redundant but I just keep it there)
> 
> At this point I'd say we've spent quite a bit of time discussing netperf
> results. We understand where the contention is coming from, and yes,
> we've established that there are going to be some configurations where
> swqueue is not well suited. We've also established that there are
> configurations where it will and does perform well, including on
> netperf.
> 
> I'm not sure what we're hoping to gain by continuing to run various
> netperf workloads with your specific parameters?

I don't quite follow you.

I thought we were in the process of figuring out why for the same
workload(netperf/default_mode/nr_client=nr_cpu) on two similar
machines(both are Skylake) you saw no contention while I saw some so I
tried to be exact on how I run the workload.

If that's not the case, then yes there is no much value continuing this
discussion.

Thanks,
Aaron
