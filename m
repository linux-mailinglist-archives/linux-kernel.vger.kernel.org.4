Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2CD704C66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjEPLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjEPLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:32:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0EE26A2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684236777; x=1715772777;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aTO2BLPyWwWmzTSSGVxSCW4tnFrsw63Mq+eVjzSugt8=;
  b=cbxWQ3oGmcquDXujTetk8NYi8mNNgioQOFgOHNcmQmsuJrVAdL9o3wVX
   Fu5jw/1oWIxJGN3Gmx9aJQGNknDjCHL2AdZfh9WulDLHoX1EyrNBw65CW
   R0Lq6jGvgwvNTaYUzmh0N5ih9PPKV3NCoS4joRo3pfN9f+51YUWHIpUGf
   Q2qgTURD9jyZwmhEuvdwB4caDfQND5rAsgxeUKnt2VY6q7Ys1ie0TZpJs
   wSPJ9AENvtvJw6ZsERbz0+EQae0H+kFGWcZ2bHnbqI0frjZy5AF/dNUEk
   RllStaNsFLcIDMsLA3J5CSl1pWSeDFzvctszcdEtuJQHkRPch3al5FxA0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331814700"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331814700"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="701313495"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="701313495"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2023 04:32:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 04:32:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 04:32:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 04:32:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 04:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHagt4S+MPKQaTAlHqtiacj58OByhIhkf4A/rnQP4DUCHPPhxREOksORhgx8YQ4DAjDoLU/xpacN7sMTnJDKEoMj2khjJvJU1ZEAoqB6R9u4qSrz2IUn+R5f40J/nSMQASkzOGy+lVHOTHPPG4KxljPt6Wpm6nQIR1LQtexcG6iUR0oIHTwHfynUAQbRllV43+dz0o6lwlohhITu2wGJd4IZWYyaeyGY+YQvxWLG8apYCiXQCG9HmrLQJ9Vw883EpLHHxchsRe74qUDnlWNyGru7LjRjbu/kAg4MLkvMs6WiCnmExJ2W0wzYuhweEVnoCUw15LXhdBmGKyw4HPbeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE8xVAyaSSTELwt5b3vUI3Vx04l+rkY6wjIAEb7985Y=;
 b=AIJ/kGkj5JXIhelSPMYteRH0AHFKXq8HpByL0F9qXTWQ0nJVlZ4MDz7jF0sbv47JvreL288LPWlnlpgWk7sh0/bE4WUfbH+JcLSmVRv8GbSHtDi4tbwEhfXUhbkzxvtUFgDjW17Zyb2yNaTUG3pbnLmz0eYvTvTgsTeHBneud1IU3WY3zPhoszORY46nFgIkr874v6RFiCXwQEAdXqWNG5kgGytF/u4ZQ3DnfgoyLDG0pV1OhwNe2TK2b92GqmhabeKAtHQdJG26Fdm58abRsHybAFgiCXxAhpcbSCRjuSB/xMbjf7KpaGhIVsUqAqFoyg+Dfti8NAshGCE1ERs8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 11:32:49 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::eebf:2b53:89e9:4a09]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::eebf:2b53:89e9:4a09%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 11:32:49 +0000
Date:   Tue, 16 May 2023 19:32:37 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230516113237.GA1943@ziqianlu-desk2>
References: <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230412120736.GD628377@hirez.programming.kicks-ass.net>
 <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
 <20230421150559.GA162558@ziqianlu-desk2>
 <dfkllxtzchrxeqykzyk24ppgwxbztk6rbbb6xyizpbhg7ctibi@fhk77qxo7yia>
 <20230504102746.GA137823@ziqianlu-desk2>
 <20230516075011.GA780@ziqianlu-desk2>
 <ZGNFkDkyipat5J8v@chenyu5-mobl1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZGNFkDkyipat5J8v@chenyu5-mobl1>
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cacc16b-5ff4-4df8-cdac-08db5601470e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGHbK9+67mxE49zDjwELijiE2FB3VUHJiJYowhtkhtGLN6NofO5JG35AmqtiYUlGlRUsSpEnVGvyXqeFmk73frCaqBb71FkkbU44GcCq8h6qfolaK8hlBWjj01HoDnxRLuivzP7+ldlP9Xqs9aWU4qHLVjLOYYKyOID1tHtcXFGvcHNN/Hc6COiV4k/hdzfsRFqSaIuYjeC7pHfrtz7uRz6HVm6nItRmI6kU/uDh1OxgqcKZBAo/+S4oglEwx25wgutVvmS+kOdMu9MzY2aiUXb3rCyUQ0vYeaKlgUri9s6iLNfEDxQV5P7CNE/6USTLyF7H03wMb4RtGLfLWABlmTpBxLpYlonhNfoOjHe+Mss5TC6HptQubREdowi5UN0wEWgNiercIqpSjGqoAvGe8eAE6CdnymTpQJ4IJntSjh9v7w1Jf4mYOVD4lcv8NitK9FIvXbt7ZvsT0ihPvsQIkJS1Sos1iS+OmQMXzVSDhT7TprW54kSZSlJ0/nuck/gDKVhoZInDDZE/mXdQL3Ao1d7kvF3Az/w5tIH22fqjPt2ZxP3xGbKv4JYnsDH27fuw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(54906003)(86362001)(478600001)(186003)(33716001)(9686003)(6512007)(6862004)(1076003)(6506007)(6486002)(26005)(6666004)(33656002)(316002)(38100700002)(41300700001)(66476007)(66556008)(66946007)(4326008)(6636002)(82960400001)(5660300002)(7416002)(8936002)(2906002)(53546011)(83380400001)(8676002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TBd0Uv6PHzOGm1wGRSo38e0jpbJ3aqMWeTj8MeQ2MY7fhnEenVXJzweOONc?=
 =?us-ascii?Q?VttXrSVy97jiQQ7UbJ/odXcGGmUCkBQ+2F2iAwVHpXNIlAiNWYUA1a45O2PU?=
 =?us-ascii?Q?almx7RtzZ8czX4DO6KVSLYSziikJqG3eyvtWVCr8Qexx7fgTh8xJSBrQIOaW?=
 =?us-ascii?Q?k1b8JkGPK3jZfS8k8GKqsbwxo8JkdYLlM+9pm+1o9wNpsz4suSqmQeCBljIq?=
 =?us-ascii?Q?CA3eiEwFwkY8LW19pNAHAf1uJTjBBdZLzHeYiXp3MCuYJy+K/lGcnXzis7sI?=
 =?us-ascii?Q?9HwJdMct2Zd805okLxDjcfVtXiwz7+6spN5kLFC0a3DLzmwAc4qHMTRNwPL5?=
 =?us-ascii?Q?pjrhce8w+pQEz4xkYlmec0cehvCz9szr2Gr+zeISh+IA28fajjDkgyR0QIYL?=
 =?us-ascii?Q?zSgj/rYgG/BKEZh4iSaWQr3d2xYhqPz4SW0X/PGv9LevLAneN7rYy+cbc6f+?=
 =?us-ascii?Q?M5jx2GCUJQ3XazSq3O4rZ1HacU+aT+m22aUFmv1+JauwvU+8HyWTVPrFJymI?=
 =?us-ascii?Q?385FByyrk5buc0P7hXE6j/cZ3uSjOS75MsN7I77RrbwjjCrNmhYmwUEADMis?=
 =?us-ascii?Q?7yATI7vqof7T1ET0+VlCeRuTJwTHlKh4T5QGPnFTI8syLpBKb7/UYP4W6msU?=
 =?us-ascii?Q?ubAuLcBdpItABHrSmBoE7v6DSQQfcVvTlXaSx2wRH3wd3NPNqTJV4DCAEfMD?=
 =?us-ascii?Q?/PCBNTfmz/sJJAwPt8yFnPzO4uQp525T3xxk8AsguHKANNRR8kc84OYQz7fP?=
 =?us-ascii?Q?Zf56x4bh7uGD1r6f0pwSDELdqLjdNsnGVryHPc/BW/F2YBz5uQh3cqkwB30o?=
 =?us-ascii?Q?UYezbRYDQFYsQE11DXUnbi1TPS/s1EkiB3b6syVQ4qF9HhGTEXezcIJ1YGU0?=
 =?us-ascii?Q?IwJgKhrQTfq7So7zkEPJhjJ2SDDJUAOcZQT/BScPf+MqRCw2Q1nRnVV33bJa?=
 =?us-ascii?Q?ijGunI/HGVkYMJfQXYVcTT8iUcd0aW1uXvzIlZm0/5vgP1fq1r6asLQjybwn?=
 =?us-ascii?Q?WpMuyQP4jeRktjr8Sfz54cPu8b/IdtmVfkQL1alCmKE0f6N/+qFiCCkOSvph?=
 =?us-ascii?Q?nGJcJUuiCpXV4T5XVq586s9eWTG6lkqQkaXW8Rat1UxGdVfuePFbNu3uQSIc?=
 =?us-ascii?Q?ysUPNJVw0V2H1GLY/nL4AUP5PBlMj4b0lmVB6bsmwt2W6DDx0taa7eoBthK3?=
 =?us-ascii?Q?oow2rJhcmrZwzMEyEiQbECpigbdXqUpp68MQOLEEYyOO96Bcc6ZQWyLvT9ub?=
 =?us-ascii?Q?gOBMJQFrGeSxf4M4hgTASGf6dg2JGJIY2yfHR3y2rAgHNZqujt48fRfxBCeH?=
 =?us-ascii?Q?1RUhm2vEJ9LYVl09vtEgFqHYXtttdg5jQryj9AWd3MGSlzA+MELiMuoXsOE6?=
 =?us-ascii?Q?DhGPyNnAAw1pho/emuxMkgyF0R+HO6MWRpcgdw16CBKSYnIKZejEegegcJ0w?=
 =?us-ascii?Q?mjIjHmbVvXkgT7pmBlBh4sImvNcBkzxrFAbBR1UtzbqBxiTR5Tv7shmnYV4U?=
 =?us-ascii?Q?0Ezm6rXcp301zqAOu/2P9bCZqyi8ooC17kX9FgWmZWyKZPCs5liuYWv/INu4?=
 =?us-ascii?Q?tp440WtNasecGQyNyzQ4FWoyINwT6dowgQuuUP9C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cacc16b-5ff4-4df8-cdac-08db5601470e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 11:32:49.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LQIu1Iybs3pA3QzlAqHvDkIdJGzMrolVf1tGtp6ADoeYKoqOmEHh1s0CIa6+v05633E0gF4eduxKYYoILeojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
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

On Tue, May 16, 2023 at 04:57:52PM +0800, Chen Yu wrote:
> On 2023-05-16 at 15:50:11 +0800, Aaron Lu wrote:
> > On Thu, May 04, 2023 at 06:27:46PM +0800, Aaron Lu wrote:
> > > Base on my current understanding, the summary is:
> > > - Running this workload with nr_thread=224 on SPR, the ingress queue
> > >   will overflow and that will slow things down. This patch helps
> > >   performance mainly because it transform the "many cpus accessing the
> > >   same cacheline" scenario to "many cpus accessing two cachelines" and
> > >   that can reduce the likelyhood of ingress queue overflow and thus,
> > >   helps performance;
> > > - On Icelake with high nr_threads but not too high that would cause
> > >   100% cpu utilization, the two functions' cost will drop a little but
> > >   performance did not improve(it actually regressed a little);
> > > - On SPR when there is no ingress queue overflow, it's similar to
> > >   Icelake: the two functions' cost will drop but performance did not
> > >   improve.
> > 
> > More results when running hackbench and netperf on Sapphire Rapids as
> > well as on 2 sockets Icelake and 2 sockets Cascade Lake.
> > 
> > The summary is:
> > - on SPR, hackbench time reduced ~8% and netperf(UDP_RR/nr_thread=100%)
> >   performance increased ~50%;
> > - on Icelake, performance regressed about 1%-2% for postgres_sysbench
> >   and hackbench, netperf has no performance change;
> > - on Cascade Lake, netperf/UDP_RR/nr_thread=50% sees performance drop
> >   ~3%; others have no performance change.
> > 
> > Together with results kindly collected by Daniel, it looks this patch
> > helps most for SPR while for other machines, it either is flat or
> > regressed 1%-3% for some workloads. With these results, I'm thinking an
> > alternative solution to reduce the cost of accessing tg->load_avg.
> > 
> > There are two main reasons to access tg->load_avg. One is driven by
> > pelt decay, which has a fixed frequency and is not a concern; the other
> > is by enqueue_entity/dequeue_entity triggered by task migration. The
> > number of migrations can be unbound so the access to tg->load_avg can
> > be huge due to this. This frequent task migration is the problem for
> > tg->load_avg. One thing I noticed is, on task migration, the load is
> > carried from the old per-cpu cfs_rq to the new per-cpu cfs_rq. While
> > the cfs_rq's load_avg and tg_load_avg_contrib should change accordingly
> > to reflect this so that its corresponding sched entity can get a correct
> > weight, the task group's load_avg should stay unchanged. So instead of
> > removing a delta to tg->load_avg by src cfs_rq and then increasing the
> > same delta to tg->load_avg by target cfs_rq, the two updates to tg's
> > load_avg could be avoided. With this change, the update to tg->load_avg
> > will be greatly reduced and the problem should be solved and it is
> > likely to be a win for most machines/workloads. Not sure if I understand
> > this correctly? I'm going to persue a solution based on this, feel free
> > to let me know if you see anything wrong here, thanks.
> Sound good, but maybe I understand it incorrectly, if the task has been dequeued
> for a long time, and not enqueued yet, since we do not update
> the tg->load_avg, will it be out-of-date? Or do you mean the task migration
> is a frequent sleep-wakeup sequence?

When a task is dequeued due to it's blocked, then its load will not be
subtracted from its cfs_rq. That part of the load on cfs_rq will decay
and tg->load_avg will be updated when needed. Because decay happens in a
fixed frequency, that's not a concern.

When the task finally woke and was appointed a new cpu, then its load
will have to be removed from its original cfs_rq and added to its
new cfs_rq and that may trigger two updates to tg->load_avg depending on
how large the task's load is and the cfs_rq's current load contrib to
tg etc. and that is where I'm looking for some optimization, like the
migration will affect corresponding cfs_rq's load_avg but it shouldn't
affect tg->load_avg so there is no need to subtract task's load_avg from
tg->load_avg by original cfs_rq and then add it back by new cfs_rq. But
I suppose there are some details to sort out.

Thanks,
Aaron
