Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE96C7888
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCXHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCXHM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:12:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9883823310
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679641972; x=1711177972;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AE6NSg4DhvUAR3Vtj9IL/QjvFrFWd+SJ7Cr3c7VAfEY=;
  b=ZnMno3CYQ8sBeP74Pwt6SR4I7kFHyqzZb1Z0vejnyBMIhy2NIVlyt28I
   RZdG9eX1K/zaP4k13FGznaR8zYxXSMgaW/7aqvayZMs1xy1NDkhLZBZ9c
   iSb+h44iYiH+uekaiZI06EKo6wlsyAWVdD/R8K9Lkf0iX5FdEiw13Emkf
   N7YviCgl/b4oZqsKJYez4NxbkHozS+jPeaqnyECpodf7034z/vlfU7jBG
   46YL2eU8TdsE4tMGJz7cxSJpO58DCnfZgf3EE2B60KTcOVHSHH35+W2+t
   cYOvQU0FDwFIikV6wO4Rss4U5iZ8rkVydpGj81/GavX8zBvmOq/fK/XIZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328127524"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="328127524"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="928547234"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="928547234"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 24 Mar 2023 00:12:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:12:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:12:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:12:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl+JzAmJ/l1ZyUX15Pg1aqyjEM+JbQ1QpLIR8mly1lwEQEQ57OCeNyaCf9eVVCFthScOKSRru+7Oh4SSEuVfCHgg8IDWV2MYD3JACx1zp2en4H2+UZPZOMHCV/YuXK2/7tCCg8fB2rl0jFA9YeEWO3j5x6o4Zo7ackxjcOBZqCN6TPZTDEV/KJ4N0APbG9Xjg0LjmkWerL6109NMqUTYuBEM1Oen3PJSOxIs8W/7iRhi8ua8EsEQSFDr+gR6gFPSuTHSQakIN99CBojSkPyvoeMsvh9PSc/oOeC1cSsanpni9T8uPj1joU8+lTLD3r3uOlPQNVk1kp4KnATuA1jVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3Dtbn4JGBuC0fvnHL21r4pOCeVPW7RVBNF6xU4d0Bw=;
 b=Ggbxa6sK0gC72r8QAUbHdysxHl3YbY4ArIq5NqjMISAlPF0RwUZ0KLgQtGODGXkk4mZl2R7rXujQo5YmjnnYexeP9AncCrMt2EkzRl0bq+DYVoOIYZVza0je0yv7PSKOqS/a+EygMNfGCWfwBdEW7kD2pDPrblUdTZXGLNulTiK0r3kVBWlDD8eNw8JrJHXFBQlkPawGTz+Vs/L8uoauvZ5qWeYSnmLuxPNHM/E+c0g0o1ao7S1xo2TMKECzcGonzNWv5Mg9Np6wWc22V0FimTeYuG3/zzmIsmF+a9xe1JbWqiCW9BnTTM3IELc+WbBf3LKFaFxlKjZPwyrz0v3/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB7860.namprd11.prod.outlook.com (2603:10b6:8:da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:12:44 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 07:12:43 +0000
Date:   Fri, 24 Mar 2023 15:12:19 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <corbet@lwn.net>, <qyousef@layalina.io>, <chris.hyser@oracle.com>,
        <patrick.bellasi@matbug.net>, <pjt@google.com>, <pavel@ucw.cz>,
        <qperret@google.com>, <tim.c.chen@linux.intel.com>,
        <joshdon@google.com>, <timj@gnu.org>, <kprateek.nayak@amd.com>,
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>
Subject: Re: [PATCH 06/10] sched/fair: Add avg_vruntime
Message-ID: <ZB1NU1Yc8DSi4zrW@chenyu5-mobl1>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.569748782@infradead.org>
 <ZBm39VNJCwioq+V4@chenyu5-mobl1>
 <20230321160458.GB2273492@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230321160458.GB2273492@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: a96705f1-da81-4a13-1d87-08db2c372995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fP+TEBbjKfNe/0t354Nw8tTih906d4WDtLIebOlUxypmQye2CpsZ/8qFrBduJWX6K053me+nQLR8rjYr60nQSgwvnvrJrhjU2KYldHfZDFB5FSh0dk5HgVGhaCTdrCOOFeoIlA9wxBBgOAqmEdOFGNmJXK2Ft010pTsDvaVtbMG9DCmGNJFVin8JpkAYbWxQ7dZPcigJAqriUQnmsoW8WImkmJmjkQrjpOKqPXZz3bKy67wZr2UjgKj3SK0/TIcAH0L/f6kvHRVi0NFj58Yw1vIpP/DaWC+S5FFa+0aKWMVQW1kFtTznXmPa3mAMrfFrpw0rWDHNrkLgl4xL1sDdQmnkVo+A/9VhIUZYzZvQJ8lThpkSSEQFsoC2o89e8s9XJhrd7dCEOHhLxxW/fcY10pLnGP/W1yU8diL+T41Co2bLnuo9SkaiOlsqptro1rR2JwhaTaJzwKVGHwHFfAlQv0XHVCQY8lFiyoiH0h61G6qLKMLTnaOYM66c5wx1JDtYdX/N0ncG8FE+AKCuaOnbU/J2pHGzwGGx1yIwu7c/5f5EtytOe7dsk18lyQ4Bce/EAQg9v1iTOUIAw+dpsBJIyZ/qFEhWfuHhUpDwWt2AMGGF0SuG12fOzAKP6444fi+lqvlb1++sUgz5HgMF8DaZTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(66946007)(66556008)(66476007)(8676002)(6916009)(4326008)(41300700001)(8936002)(53546011)(6512007)(6506007)(186003)(38100700002)(86362001)(83380400001)(9686003)(26005)(6666004)(6486002)(478600001)(33716001)(316002)(82960400001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvRL5FlV9hWae6QSCl7A3uCeodoAnxE9QSolnnWSwUP4aNzBHZrxOL27k58m?=
 =?us-ascii?Q?uSFdUICEsiQUYk8Xqkk24Ek4O+cJaFe5Y3+qydgtQXwDWVsKvsJvJhuxgs/k?=
 =?us-ascii?Q?K9jzXNh4kwP4eKB7k2Nb+DvpRuRrXFlEQdHIH+DtPOdsZLDy3CV+UHGcjqa+?=
 =?us-ascii?Q?ocH+xHVWojRWiQcigkyKc5HCl0L7QdkAT8dJOw4JyJ6DuaGerZBFcF6DVNiO?=
 =?us-ascii?Q?/HhTFDJGv/u9Pj4n9eLsd5EMT95K6yViu4ZVjNVXEmzrM/chUlX29fIuEL5w?=
 =?us-ascii?Q?K9VNlq+JZ0ruzpki0q9pt8To/a4Md1XFGAllMk7GMs9U3HR5a4EDvH5Mneg+?=
 =?us-ascii?Q?SLpbqpqQwJ27vqkE8iaAGFvrqZG1eUwLJFU47qyCTUD4sJSXE/mGOUQM0KxL?=
 =?us-ascii?Q?ZgPsdAHO6Ga+7XtNL3mrnIf3EEDs20uvQm87Wp27eybLtWxhFT0d/F9t8jWr?=
 =?us-ascii?Q?KOIF/3/shKo2vjcUXzeFAVwVidR7wploMxPCOukUlELT6ivazofocdc8tU+7?=
 =?us-ascii?Q?2lMJRC87bHwvkuZauvDfakdlHTf78tXKIaTm1YPB9FiQg049nfmpVQ4QpKcJ?=
 =?us-ascii?Q?gNo/AxiQa2x6S3zyasSMIvc4tzHKH8iSEirDNDKvmua8efNMgueCw7c7E27Q?=
 =?us-ascii?Q?dkooymNRjjsMh1jcDLyODFudeii8IK2bKkkOMfbFKLCZy+OQQruTowI81Y9o?=
 =?us-ascii?Q?0hBjNZiXIQNDT+Iey+YQkDndJlalgPCc27wohWNJXTTQ8RuAP0tEh3a7V+Lm?=
 =?us-ascii?Q?wo1tmWNXEJP0IKwLbLPOSfYPBl/cKH1A7UPfNN//wyeNgNQoJsQJKZHmwKWA?=
 =?us-ascii?Q?6biv6sctdXWMc0utMrwFI9ajF+U8S9C9tmgHaMcr6hKIfyKokvmP5GU9M6g5?=
 =?us-ascii?Q?yo/OeoCvS3HNBBxVO4gF918oucQuhDSgYpBfPvLpe7FODTXYygEevNRVFRXY?=
 =?us-ascii?Q?+0dTN7PvQB6Rdhmd2JzZtuInMedhQH5xnY7BIc1yzEkqNEOOZwxKtZm/2/gC?=
 =?us-ascii?Q?j9wYgtdJRY3Z0EbqzlCy25Tm+4clGAYP580/zu+SsCkyJANbcRHHTPepOEtJ?=
 =?us-ascii?Q?3NOikqxhoUQPR5/AFyE5Qt+zzOwyMraMxciW7n4emFCPmkDBUFBWBfOyr2QK?=
 =?us-ascii?Q?WzHjJfzWBVSLngjUZG/XgQ0KSa/QheSnzMMZYMh2FgYWW2GP9LFjmtXHE9qd?=
 =?us-ascii?Q?fIjte+hs2GTXPmodbjNsbXbt/Se1zPyMcka7dMSb4rDowl/6TiyEkCufJ9mC?=
 =?us-ascii?Q?ZpqaNxvy87JXXhrcEdR1+zsR7aGWRKJNdTj2/I5cXC4muCqpisaxgUc21Avk?=
 =?us-ascii?Q?pQamtmzz2cqw32W5vdCXQLD9P6rY1e5ClzmVOa83bUumYQRX3hYTf4rVLmm2?=
 =?us-ascii?Q?Vwm88XwaxiG0y7PTs5RHg8inpJCpMU4Gu1DGa2WrBgexKgRCEO//4SG7I5eH?=
 =?us-ascii?Q?SYmjfEwf/tdf67CbPr9nD3YNyUwGko6s/sqWSdcGZG1zEMskwWBS9iNynsjz?=
 =?us-ascii?Q?BOF5lvqUJp9WxO3N3MSxRkAFceRTKXsaV0Qf5mkAr5kVATLVXqTOtCFPejXZ?=
 =?us-ascii?Q?cjCVKs8YUMPRaN4dlH9HRxKZ31gHNsEAzdZcokQg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a96705f1-da81-4a13-1d87-08db2c372995
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 07:12:43.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9NPyvmATjA8Tn3MCkEzywGpgs/sbBhuUXyCIPwVNZWGiM0cQnhIXCIdoSet1/veZ5elAnfspNqxdz2H8207VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-21 at 17:04:58 +0100, Peter Zijlstra wrote:
> On Tue, Mar 21, 2023 at 09:58:13PM +0800, Chen Yu wrote:
> > On 2023-03-06 at 14:25:27 +0100, Peter Zijlstra wrote:
> > [...]
> > >  
> > > +/*
> > > + * Compute virtual time from the per-task service numbers:
> > > + *
> > > + * Fair schedulers conserve lag: \Sum lag_i = 0
> > > + *
> > > + * lag_i = S - s_i = w_i * (V - v_i)
> > > + *
> > The definination of above lag_i seems to be inconsistent with the defininatin
> > of se->lag in PATCH 8. Maybe rename lag_i to something other to avoid confusion?
> 
> Yeah, I ran into that the other day, I think I'll introduce vlag_i = V - v_i
> or so.
> 
> > > + * \Sum lag_i = 0 -> \Sum w_i * (V - v_i) = V * \Sum w_i - \Sum w_i * v_i = 0
> > > + *
> > > + * From which we solve V:
> > > + *
> > > + *     \Sum v_i * w_i
> > > + * V = --------------
> > > + *        \Sum w_i
> > > + *
> > > + * However, since v_i is u64, and the multiplcation could easily overflow
> > > + * transform it into a relative form that uses smaller quantities:
> > > + *
> > > + * Substitute: v_i == (v_i - v) + v
> > > + *
> > > + *     \Sum ((v_i - v) + v) * w_i   \Sum (v_i - v) * w_i
> > > + * V = -------------------------- = -------------------- + v
> > > + *              \Sum w_i                   \Sum w_i
> > > + *
> > > + *
> 
> > Not sure if I understand it correctly, does it mean  (v_i - v) * w_i will not
> > overflow? If the weight of task is 15 (nice 19), then if v_i - v > (S64_MAX / 15)
> > it gets overflow. Is it possible that v_i is much larger than cfs_rq->min_vruntime
> > in this case?
> 
> Or worse, SCHED_IDLE, where weight is 2 (IIRC) or cgroups, then vtime
> advances at 512 times realtime. Now, the tick puts a limit on how long
> we'll overshoot these super low weight entities, for HZ=1000 we still
> only get 0.5s of vtime for weight=2.
>
> That would be only 30 bits used, except we use double FIXEDPOINT_SHIFT
> on 64bit, so we'll end up at 40-ish.
> 
> That should give us enough room to carry an average of deltas around
> min_vruntime.
> 
I'm trying to digest how ticks could prevent the overflow.
In update_curr() -> update_min_vruntime(cfs_rq), the cfs_rq->min_vruntime
is set to
max (cfs_rq->min_vruntime, min(curr->vruntime, leftmost(se->vruntime)))
so, although curr->vruntime increase by 0.5 seconds in each tick,
the leftmost(se->vruntime) could still be very small and unchanged,
thus the delta between v_i and cfs_rq->min_vruntime is still large.
Instead sysctl_sched_latency could decide how far it is between the
se.vruntime and the cfs_rq.min_vruntime, by calculating the vruntime
delta between task1 and task2:

    sched_vslice(task1) = (NICE0_LOAD/se1.weight)  * (w1/Sum wi * sysctl_sched_latency)
    sched_vslice(task2) = (NICE0_LOAD/se2.weight)  * (w2/Sum wi * sysctl_sched_latency)

Besides in patch 10, entity_eligible() checks
\Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
and the \Sum w_i could become large if there are many runnable tasks and
bring overflow? But yes, if the vi -v is very small we can get rid of this
issue IMO.

thanks,
Chenyu
> But yes, I've seen this go sideways and I need to stare a bit more at
> this. One of the things I've considered is changing the min_vruntime
> update rules to instead move to avg_vruntime() to minimize the deltas.
> But I've not yet actually written that code.
> 
