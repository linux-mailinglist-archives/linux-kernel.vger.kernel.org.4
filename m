Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F16737B13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFUGEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:04:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45792171C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687327450; x=1718863450;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GuTdieGRibA8aBuReFFHyHEfXQIy3bWth/Cvvha6Yfc=;
  b=I7DmLBQsCzwmxjC4g3qAjcp702qTbP23s9RxQ6bWXsWJaEM0cPVQuxWl
   GU9C/OxuKMDpLICHgmaeiJVzsfgRh8jckprTrCnGpUJWfpfI4N23IBV8Q
   dZogPsKQwBfJl7WFdrbpO73Y0GudGm7m0O95TDVXGA3BimCJ+0Q8uJ/KF
   yjs/yBuphB9bP7qKAYUq3WGYrhRwcOKmHFsJ223+Pv01qrznZ888gHIYi
   yVX7BwLin/yfyaRWz16ib6qCEjIuUs7Rg0qBCXd6x5qMh+yDp5uzmF8OY
   En07oNF8mrp0YeRUNkcsCjJsy88eG3IBIDWk6eH+m9VCgOtgUCoysLRt8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363498267"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="363498267"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691717024"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="691717024"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2023 23:04:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 23:04:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 23:04:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 23:04:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 23:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi8nPUHADGhamSLpB8MzoOARTvMVs5CLUjjd1783kk9bEqB8kei8qrzn45/eXCMwGSR/bTDSk/xdbPK07UWaI7+GIGDPJOhYUTaF9Lw3pi6DCB4LYQEe20FJQ4eu0rhaamMCg26eBpYPLTrZRMsEs1VS91RdmpIDZsPKltrDZXk0uOO2oFTYgZhAvNC1D3iYb+mPPguWoptCHo2EnyHSkF+2CFND5es8Pe4cFWS9i5OickdEA4u5RGmBT/gXFeF95voCMHxAE3QPwD/6wBCBUUIZgXubK7tVjI95Z1QWqzNyAmwMVyuOVwbe5Ck0ZvP9RhxkrOoAERg9EHaCdLbrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8cn5uz8P75AGgyncwBx/0bLOsPwmfSBg4jbKRlCNI4=;
 b=ZcPgJKKl0J/R6zXn7BUJB9GMY96wuNLt6OnJwpm9f/9Mk/vVehUyw48KS/jySB7EzqYWP4xWA6z+40srbolcEFhpCq0Fjax2ddjLLludd74UqhAUCot24yn0obx8OBFWQqN888UFptMCQzV74AibUUuJ1/H3JxIr2GljPGUfsBY925s9W3PMOQxB5dQWD9+NB4Hl95mNxYFoO49xKzuNTNGOmshobJoQG30wxUH8GQ3TqKNZb0TUjQs/Ny7XOQ6X9/Mzhc1JhoKvD9jHhzzL2gwrObtIRhPgUblw68ITj6iwj79dLUTeke8cWNJ/q4gyS1zxeehsnbeV6779/K+nAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 06:04:05 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 06:04:03 +0000
Date:   Wed, 21 Jun 2023 14:03:52 +0800
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
Message-ID: <ZJKSyC29PfQcQsAr@ziqianlu-kbl>
References: <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
 <20230615232605.GB2915572@maniforge>
 <20230616005338.GA115001@ziqianlu-dell>
 <20230620173626.GA3027191@maniforge>
 <20230621023534.GA236337@ziqianlu-dell>
 <20230621024300.GA15990@maniforge>
 <20230621045416.GA237582@ziqianlu-dell>
 <20230621054352.GB15990@maniforge>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621054352.GB15990@maniforge>
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DS7PR11MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: fae5e8f3-5241-4de4-9a19-08db721d507d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/kuaGPIcuiWahYeJoO3w+Nn0lUaHErQSyBnsy+gPuMPLwoMqW/1FAqu154BZWWgVi7cZIZ1jfqgION/goVGgKFf23DVMijEQO8sxO8u5MzMnzvCNZiJlESYMtamswPLiAkgQixckw1FvdouZtOG9qpBiWR4ovQzVkv9nZGaVv+8FG1gsn7+LnIA/neDcQAzaUcRt522j6ZPfDhx0ZeTNmvRw/ELwMcU2DNFPNzXWERIIu1aerWfUIMMpKkprE7aWBmqt/lOzErF/UiOmKw56dQ7yWCak7b23rdEYFb+RKFnZnkwHhUYBU1FEQ6aoPi41FcpDfeNXPEK3TeT4+pYlmAIYLf5UJasi2xY9FTzQph7sjBDg5BBVAfJUCprx+PiLRk7NUE8EhxtN+Gtlz3diV6iskZCapumBeBUduOSaDInnm59kpRuEM8CBwsBKFlotXKC6U19eeHIfH3y9DOaWfwf2vKkQB2FtNAxBYAFnWeTV/S2ct8DrBh5Ksxumd1h9Gjjo6teIbYPRZIDgTTlg4UNORoZ0JY4gudDXfNgWmlk3PU7k80iK3bnAlFaN7ei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(316002)(2906002)(5660300002)(8936002)(4326008)(6916009)(41300700001)(8676002)(7416002)(44832011)(66556008)(66476007)(66946007)(478600001)(6666004)(6486002)(82960400001)(6512007)(26005)(186003)(83380400001)(9686003)(33716001)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0OjUoZi4LkZc2gYBcOJsGXqS/Q11iKh5b7jocnyPKrYLVInYHi/t1MUROjq?=
 =?us-ascii?Q?7qSso8X9N39E3zBcIyL8sjy4mByr3s0TY8LXC+o8pFpBIgiFWsQlMJ+nXppi?=
 =?us-ascii?Q?raT28h5vuHBXVif59dTDLQrEY4Bn2DdW6eoRhgzI96coLdDVKXrKjKHJzYXE?=
 =?us-ascii?Q?qtFW9tiFgevXWxfhWGrPRViiAi51r1S/bcgioA7Llzl/KVFd83UbmfA0BIBB?=
 =?us-ascii?Q?bYV3vRwxgm3gS+WbFNhaPH0ia5W5ldCCZgHoYDu2ewARaup7/Ju7oMGAVjYC?=
 =?us-ascii?Q?jTSIjLwdXdWUwaGSUeh7t49XJ7jx6ReGFCdMdvlVz/eWna7Tcc/4uNv030w6?=
 =?us-ascii?Q?8Nty0BrqeMMs1hTQrb4x6/wGAHZTZ2Y9BsJ4VpBEOnfIvPzibVVYMJKB7H0N?=
 =?us-ascii?Q?qsuJ9yVdn2+zbs/k1X0fC5hSSCp4ROTIwAD/owT6+XgE5uY/IWt3/LWh8W2R?=
 =?us-ascii?Q?Tm4sdOTuRXv3rPUVWqXI2A1Q+50hCPv9tdc2xwq6dy1n4GPc4XcLO2IzYosa?=
 =?us-ascii?Q?lRX7QZLy2W7uCAgOUdUBeb6XPJFmqTiMYptwKFW2kNvO81F3yMs46Ndf5Ewc?=
 =?us-ascii?Q?IaRmUs6Q6j1uI7T9gnqqp1pXlhSir8spyq2sEj5p7G0Gx1T+gv6y+HBf9o53?=
 =?us-ascii?Q?kjIR/RIcPKZ1YfN6Ickz95s2hNp9mPMsSoDzQ/i5Mi+oOUakoTZ7dMj1fb3m?=
 =?us-ascii?Q?7P1vom/xCDVibPcUzEdLmbIdiFuRk+W7ba1W58ybssQg0MhYvzLbNvK0J55t?=
 =?us-ascii?Q?m756GiDvDP0RkBPJKmMBUOWFY/DW9nip6BvL/elz9+Ol7jOteGuLbpI0WD+i?=
 =?us-ascii?Q?OA31lfjDakQTkZwsXhdu/iHQh2Cf74+eGD1Jz/StVmHcGdf36ZVtXsu2l1Y5?=
 =?us-ascii?Q?6B9myGwL54Po1oBjXNcpwIvXSIwDYCH2lmQVz176shze8sr77FeaxvJurJ3N?=
 =?us-ascii?Q?RudXqKoRC2VxXuMZ8/+UXi7Qx3yNkARxq+FNc2IadLw1FghrSJMLqXMLi2jk?=
 =?us-ascii?Q?vI2wgA0uauJP+JfSCigIjG90eSP1GKOHGtMRFWO+OQHi7ZtjYjYSf2yEL4si?=
 =?us-ascii?Q?6o2QkQ2XtPRCWz0Jby8SV8VzLvBoMPmgxlnpnmCHF/eqinoaIzxYBjSHkqJF?=
 =?us-ascii?Q?43+ACHvPHiVMzdadfjt57FdAndxYBsENJlg92SL+IzqnP0Wt0Y1WU0Xu+1YD?=
 =?us-ascii?Q?MbWpiH8QoHQZP5jm2hCHS+iuiaQJWnZA0D0/iSVXL9l18cZSEaoo1YvTHw1l?=
 =?us-ascii?Q?F/hf5dR3pnIm7eOrITd0qBRWeXPiEuWuiIEqj8lKQkw1g/zyB0nJPf8jbXlG?=
 =?us-ascii?Q?JwocNaSzxo2Isy6KY/M/mqq3E93a/fcsow3cVIpOgvNevf0KOS8Z2FwW33r+?=
 =?us-ascii?Q?JnGfsuMo1WJ2meKwx/vdxNBSrDeoUbb9X7qN6/afUxPZ2wUDAUMtBKqB1NmF?=
 =?us-ascii?Q?OH6LI+KbQPyrcfVIuNQEU09XGre9/gpAG5kTiE9XoWjOQ8gFx9tXFws5UN5j?=
 =?us-ascii?Q?5ntWF+Gba/AXaTjH+TWOLd2B3bHCjRQHBB+OX2S8kaS8GRJiVq8dwrPuD1a+?=
 =?us-ascii?Q?xBlZCyIlSkwe/Zm+SEB1pcEaJAJ5FOgm7h+u4Hm/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fae5e8f3-5241-4de4-9a19-08db721d507d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 06:04:03.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnNnwMuD00lT4KztW6UENLcwLDOtPkK1LXpEqOrHCbwmN35A10tqtb/HGztWmzOrfWv9KHFat5F5V3hTsBNSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
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

On Wed, Jun 21, 2023 at 12:43:52AM -0500, David Vernet wrote:
> On Wed, Jun 21, 2023 at 12:54:16PM +0800, Aaron Lu wrote:
> > On Tue, Jun 20, 2023 at 09:43:00PM -0500, David Vernet wrote:
> > > On Wed, Jun 21, 2023 at 10:35:34AM +0800, Aaron Lu wrote:
> > > > On Tue, Jun 20, 2023 at 12:36:26PM -0500, David Vernet wrote:
> > > > > On Fri, Jun 16, 2023 at 08:53:38AM +0800, Aaron Lu wrote:
> > > > > > I also tried that on the 18cores/36threads/LLC Skylake and the contention
> > > > > > is indeed much smaller than UDP_RR:
> > > > > > 
> > > > > >      7.30%     7.29%  [kernel.vmlinux]      [k]      native_queued_spin_lock_slowpath
> > > > > > 
> > > > > > But I wouldn't say it's entirely gone. Also consider Skylake has a lot
> > > > > > fewer cores per LLC than later Intel servers like Icelake and Sapphire
> > > > > > Rapids and I expect things would be worse on those two machines.
> > > > > 
> > > > > I cannot reproduce this contention locally, even on a slightly larger
> > > > 
> > > > With netperf client number equal to nr_cpu?
> > > 
> > > No, that confusion was only the first time around. See below though, I'm
> > > not sure what insights are to be gained by continuing to tinker with
> > > netperf runs.
> > > 
> > > > > Skylake. Not really sure what to make of the difference here. Perhaps
> > > > > it's because you're running with CONFIG_SCHED_CORE=y? What is the
> > > > 
> > > > Yes I had that config on but I didn't tag any tasks or groups.
> > > > 
> > > > > change in throughput when you run the default workload on your SKL?
> > > > 
> > > > The throughput dropped a little with SWQUEUE:
> > > > 
> > > >                  avg_throughput    native_queued_spin_lock_slowpath%
> > > > NO_SWQUEUE:      9528.061111111108      0.09%
> > > > SWQUEUE:         8984.369722222222      8.05%
> > > > 
> > > > avg_throughput: average throughput of all netperf client's throughput,
> > > > higher is better.
> > > > 
> > > > I run this workload like this:
> > > > "
> > > > netserver
> > > > 
> > > > for i in `seq 72`; do
> > > >         netperf -l 60 -n 72 -6 &
> > > > done
> > > > 
> > > > sleep 30
> > > > perf record -ag -e cycles:pp -- sleep 5 &
> > > > 
> > > > wait
> > > > "
> > > > (the '-n 72' should be redundant but I just keep it there)
> > > 
> > > At this point I'd say we've spent quite a bit of time discussing netperf
> > > results. We understand where the contention is coming from, and yes,
> > > we've established that there are going to be some configurations where
> > > swqueue is not well suited. We've also established that there are
> > > configurations where it will and does perform well, including on
> > > netperf.
> > > 
> > > I'm not sure what we're hoping to gain by continuing to run various
> > > netperf workloads with your specific parameters?
> > 
> > I don't quite follow you.
> > 
> > I thought we were in the process of figuring out why for the same
> > workload(netperf/default_mode/nr_client=nr_cpu) on two similar
> > machines(both are Skylake) you saw no contention while I saw some so I
> > tried to be exact on how I run the workload.
> 
> I just reran the workload on a 26 core / 52 thread Cooper Lake using
> your exact command below and still don't observe any contention
> whatsoever on the swqueue lock:

Well, it's a puzzle to me.

But as you said below, I guess I'll just move on.

Thanks,
Aaron

> 
> for i in `seq 72`; do
> 	netperf -l 60 -n 72 -6 &
> done
> 
> > If that's not the case, then yes there is no much value continuing this
> > discussion.
> 
> We can iterate until we find out why we're seeing slightly different
> contention (different configs, different amount of RAM, maybe you have
> turbo enabled or other things running on your host, etc), but I don't
> see what that would tell us that would meaningfully drive the discussion
> forward for the patch set. Is there anything in particular you're trying
> to determine and/or do you have reason to think that the contention
> you're observing is due to something other than a lot of tasks waking up
> at the same time, just as it was with UDP_RR?
> 
> Thanks,
> David
