Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC1B633511
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKVGIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiKVGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:08:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE26729C98
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669097317; x=1700633317;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PMnjuCtfzio1lqPWcAr7YdvsUq1FLu4bUjVPpijFZEQ=;
  b=agRU5ikgh2qWbRoDApVrc/d7iPRMQY4m8nlOXuw2ogFbI/AuGeO0joBr
   1dNckggZPYtiwEEB3WkXit39N2o1RDuiuyISOrANWuYRdiJA4vjeB4uXq
   /azCPIHMT1zxy24vEVlCEidZHkEBmLVsqvcdKuAj2NDKYLLpbLdmnc03K
   WZkKIUvSemiAvFVG7SV7MRBZ6PM4o1pwDcmZ08C0IcKK65TiVThOv0ilD
   GtlELuF+zGUINsN2cVT7hbD8B8fI0Z1uO6iLU5Tw+6b/j25BTfemQuPj1
   qcs318DOsz68ZBM5xj2gUSxOkGzZfBWkmCgxu5bq7K2EkM3YxfnuLR48x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="293452321"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="293452321"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 22:08:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="886404420"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="886404420"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2022 22:08:36 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 22:08:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 22:08:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 22:08:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 22:08:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5jeDAxQ7rysMJLpCKqrUa1v9ahfTNEY1m1dk/MNxV8QbQpp0vXi1oOawiq/EVmE5NEnOcaNaWAIgjL7KIIIS7fLHsBow32YhakT0NTerLXN2T+PCXAqtSy8E1sbPJG0OZndZmge8caBusPv2lni4aRhIQx3ZF4vB7YPRChn1Eb9DCwyUvSSYT1+9bSelCdnyL3dEVhRg0pPH7EwBKnaP3+XedbL7MzxvLEgbpMa1ony1Sy9zKuWQovJj1FwGeyfu148xkEF8LucgzCZoM+35L9NqQgqz7eKMMME0yl2XVbSGYuVFNT/Qrp+A8ioI+5ameCqy2Drn+KNoeHIp/gsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDoIGfKBwhaQwv6cI9x9wR9Vp2wESUYyg+HHkSJcHlk=;
 b=m3hxGfdnaE4wyWzgtbEk5+UaFCl1EEaAb+D//NtNpEeBh0O6DIPtDCgQ5CtRJAoHtpNHQHRNtyxeF0kYiQ3coFe+mCtUp4g3H1JqOSUdDguXP3+yGNoSKJYEhR82eH++KyPg1bbyUGibmCl7ve/3/ik8RWopJ8+LkXMVn11hyk45vYvhBluSUyXjA+K4APTPYvoEDLtfPcaW+7l7C6nsiWa216GzPRkgfly/XUx+Pk/b6VjyRUAUx4EJpOfrR8HYwyMpznmTzRdjFT9eqFFqw9OFRx/uguDzfc4/WiJOgcJCj+8Q/BG34VBGE3eH4nsxkkEb8wW2yrmKnZO5abzEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 06:08:33 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d3d0:e250:56:26a0]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d3d0:e250:56:26a0%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 06:08:33 +0000
Date:   Tue, 22 Nov 2022 14:08:19 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Josh Don <joshdon@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y3xnUhjSb56ex9XX@ziqianlu-desk2>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 5409b9d4-4688-487d-c12d-08dacc4ffc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbTfKuLlvd+pdC12o3FPqJgGIdJ1KaCihzfnaR2OGxuX8k0czVPlkJL4cguiX6tpVJ92n2fOT+F1BASoxJhcwca5X4o0H2+YBJQIYp6QsmYH7zd5LIDRB0XpLP96sxYeJLpjNxTxjJb/7zgTm/95xXrhuZSZ3/KbfMpUkon7sRziP2D2ZwAzs2L5QXjRAajAVSJdwsswz6+C9t1EjfxeUsj4ukozMATNLfafymJJQjq4NYkGwf0z2pwZytUMwEPKjpZgYzO69spmhugEslScOHhQ5W1bn6oSiRhuqY/HtlWAiCKdcoJh1WFk3dRLZzy9YmjKEtyid7bqjubVsOVrTyB2XCFsrbb5kXmWC10ppgIL5BnUvYTDdzf3vDMGMVy+G39M1jjVVJaTIlgIIZTgznIeo6F4/JOXN8s/rsx/bW/80VxWdbkNhuYRkbyL/EnS3D7R9p29Ks8fGwAobzWBWmvLAUIo3YKnRdHQ/Xv+Lp6uA/EPInIzViSBIxQBnSu60AgWyxjKgSlAFlAV1OYlAlh+vOiJctCyuV4w4ECW4oDMXVXUZ4OMZHHIGBzc/nCYHsM/iPNRpaP+0lgJ6Xkcz84hry+seFpOzBA26djRZvU9ykKKpYfOPVhsutPeFJDiRGyOsGmeP0NQaqaZRa/j7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(26005)(9686003)(6512007)(66899015)(186003)(83380400001)(7416002)(38100700002)(82960400001)(4326008)(8676002)(41300700001)(2906002)(44832011)(8936002)(33716001)(5660300002)(66476007)(86362001)(6916009)(316002)(66556008)(54906003)(66946007)(478600001)(6506007)(53546011)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jmEcmg7IykvyijYZDgc6IC3B9XbmsAlbV1ZaTF3TmY6vUGmbpbQe2HNp0WJ?=
 =?us-ascii?Q?wwDqJ0TWFMydY3vHbefNBQcMSyyS7APfP1FFjfKnKLfClTHQeX76rpwpyFVs?=
 =?us-ascii?Q?A4aNQI0xlEIW1RYVQBJWdYmM6sTsFJSOkYB9P3OUdDQ54x9omDVi1ZWXpzJr?=
 =?us-ascii?Q?EyKpAY3fJZoMamO8w2p+JvnGhgRgWgWBHlWS6NJyUctxQXU6ovylSl82qRcJ?=
 =?us-ascii?Q?Z32fuJzIONU4/IhMo+UINYR5fkszPEPjcVqqBfeL1UvUiriGD87WeCHfZGbJ?=
 =?us-ascii?Q?ycsq2luClgjyKxf5SgOKb85jX3+8wqwMYS2yBuSgd+F/BD2gscatbg9QMoHM?=
 =?us-ascii?Q?qild4x6NwWwsCsaShEE4pJ++WtwZn39zkZpViiC3rfyN2K0iUNWN7/xwfL5Y?=
 =?us-ascii?Q?RVwLYFXjO0Nhl9w1J7N2WIV60WZ7BjYZnxecSRJoaTowsTWLZ8bTwQiFKTWf?=
 =?us-ascii?Q?4GKGy93esUnY7lL3x7SvTBUYjSgSelvV5OhyK1fsxwfMf2S92Cu5QMSaI9L6?=
 =?us-ascii?Q?qQVUNcerHFfg5ToTT98K3eqp5tOABfZWlVHkajpzs93COvM4+60hgWuszSaT?=
 =?us-ascii?Q?fW2bpTWSMQp7JIb9TAC2YzeYJgr1pjK/SAPWfnmIrf7sS7KiuzPxGrOPfoZe?=
 =?us-ascii?Q?W+tb+CFaXV3rl55qkR5/KPELtlSd7Jc3IiQZ/Svj/9uQfKTEWaEWUiraodj6?=
 =?us-ascii?Q?6VnSXPcoV+6UrVEtQyOE8ZnTju9hvgwyQQKdeLGN2RQvzU8QpJh5Bn8vRq0U?=
 =?us-ascii?Q?MHf4Csa2OvMoK8tSiVO9yoCFUvZ3KA/xn6W6/Nkoel4uULNo/0KOfJhsLKhk?=
 =?us-ascii?Q?EilmAHSbJOOLKao06B97LVDDd63WKdQhK5T/INdAP//Y5RxpyrvuXD+qRVms?=
 =?us-ascii?Q?2CU9wm7m9Vnuc+TqHRgY9gQYGM+/DX4tEGDQ5vDP4Ixiagf3RrIFTtg+bSlY?=
 =?us-ascii?Q?GFRnwYGDodzyve91LCuQN3mg/M+roFnhcZ3x5IMhf7lz4AJCXXpluNJ4qj3z?=
 =?us-ascii?Q?kdeWstaYAM3L1JJcne+B/6MoMEJFgu6FBAsWVG4gVTYmfQIUzxoL478Nv+4+?=
 =?us-ascii?Q?nyKeceSCPayRX2bFtQ0bIy/QlPeDOJ34v/ewmmRbPd4erwielLSBVi4DXU04?=
 =?us-ascii?Q?uuRlJc2Ol/4dWL6CgfxSsydc1HNfCIBR7Kf8hhcnjEiX3r960sGgTEVAb5fJ?=
 =?us-ascii?Q?705FbTDve2fMv2/Xma87SCjw7Tdeix1zBAhGkqdGzWETFOw0RCpCURQDLkfU?=
 =?us-ascii?Q?JTAxqGNB/+OYyZz7j8PJm82XjFadjHlbuz+bdkCWt+nNo3Zbxztiq5A03gxp?=
 =?us-ascii?Q?8r9YC24osCJoxQS9I9Ru6d83EBfAIVGAD1Csn9WFQCkapFGl7lAegcJt3Ud4?=
 =?us-ascii?Q?8qKACxvvNXkRt0aQPVMKIqdxkTUDHOyKi70Ymf2xV3epsgjizdVlYRGw2cIl?=
 =?us-ascii?Q?/OJeCsGd1uwdlIM9g/9OxuZiWXnV3uECdTBgJtXoxF1lS/ggpj85wUsf18P6?=
 =?us-ascii?Q?AlrPAQ8GCBBwmYDtURw9ZG6sb9eZXwcsg7S49+CFQlVnCQ0XkrIOTbGTenai?=
 =?us-ascii?Q?UFAX+R18Z4pNaacuxEqXEyFbvX+2nJya2EtKYw6m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5409b9d4-4688-487d-c12d-08dacc4ffc12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 06:08:33.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arWvhnswUyjNzY5n8PTgseKCCWcDbjqOc6glpSqFes5Zmokid7oP8jLpv6YbG5MWx65UujTq8Wd5/9qesygi6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:25:09AM -0800, Josh Don wrote:
> On Fri, Nov 18, 2022 at 4:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > preempt_disable() -- through rq->lock -- also holds off rcu. Strictly
> > speaking this here is superfluous. But if you want it as an annotation,
> > that's fine I suppose.
> 
> Yep, I purely added this as extra annotation for future readers.
> 
> > Ideally we'd first queue all the remotes and then process local, but
> > given how all this is organized that doesn't seem trivial to arrange.
> >
> > Maybe have this function return false when local and save that cfs_rq in
> > a local var to process again later, dunno, that might turn messy.
> 
> Maybe something like this? Apologies for inline diff formatting.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 012ec9d03811..100dae6023da 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5520,12 +5520,15 @@ static bool distribute_cfs_runtime(struct
> cfs_bandwidth *cfs_b)
>         struct cfs_rq *cfs_rq;
>         u64 runtime, remaining = 1;
>         bool throttled = false;
> +       int this_cpu = smp_processor_id();
> +       struct cfs_rq *local_unthrottle = NULL;
> +       struct rq *rq;
> +       struct rq_flags rf;
> 
>         rcu_read_lock();
>         list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
>                                 throttled_list) {
> -               struct rq *rq = rq_of(cfs_rq);
> -               struct rq_flags rf;
> +               rq = rq_of(cfs_rq);
> 
>                 if (!remaining) {
>                         throttled = true;
> @@ -5556,14 +5559,36 @@ static bool distribute_cfs_runtime(struct
> cfs_bandwidth *cfs_b)
>                 cfs_rq->runtime_remaining += runtime;
> 
>                 /* we check whether we're throttled above */
> -               if (cfs_rq->runtime_remaining > 0)
> -                       unthrottle_cfs_rq_async(cfs_rq);
> +               if (cfs_rq->runtime_remaining > 0) {
> +                       if (cpu_of(rq) != this_cpu ||
> +                           SCHED_WARN_ON(local_unthrottle)) {
> +                               unthrottle_cfs_rq_async(cfs_rq);
> +                       } else {
> +                               local_unthrottle = cfs_rq;
> +                       }
> +               } else {
> +                       throttled = true;
> +               }
> 
>  next:
>                 rq_unlock_irqrestore(rq, &rf);
>         }
>         rcu_read_unlock();
> 
> +       /*
> +        * We prefer to stage the async unthrottles of all the remote cpus
> +        * before we do the inline unthrottle locally. Note that
> +        * unthrottle_cfs_rq_async() on the local cpu is actually synchronous,
> +        * but it includes extra WARNs to make sure the cfs_rq really is
> +        * still throttled.

With this said ->

> +        */
> +       if (local_unthrottle) {
> +               rq = cpu_rq(this_cpu);
> +               rq_lock_irqsave(rq, &rf);

Should we add:
		if (cfs_rq_throttled(local_unthrottle))

before calling into unthrottle_cfs_rq_async(local_unthrottle) to avoid a
potential WARN?

As for whether the local cfs_rq can be unthrottled now after rq lock is
re-acquired, I suppose it can be. e.g. another user sets a new quota to
this task group during the window of rq lock gets dropped in the above
loop and re-acquired here IIUC.

> +               unthrottle_cfs_rq_async(local_unthrottle);
> +               rq_unlock_irqrestore(rq, &rf);
> +       }
> +
>         return throttled;
>  }
> 
