Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166816CBFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjC1M5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjC1M5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:57:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD4A1B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680008218; x=1711544218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NlCgTHXMVsHH074+a6yzp3hjY5FwBBTieGM19WlD9Wc=;
  b=DGU24D6vsUXq1uJ+ghDVfpB5x+S+WR6XAednPnsWm82YbDdDMY+Y2Ed1
   75OVVOlBMc1AW3gW3vcKZmZrftU62Zgkw/Hzt8IFl2nqYc9X9TJLBToFo
   kzwCpZ4fpRBOeO94Il93LDnulYr4+jL6MqPMmZh2O4oLVoSM1pim7gbSn
   dBpG61DL6FBeomyjOcSXUucpHIwsSg/a2xEHMYkmh22bLWTxTSjfBRtcO
   e+MgcMdkeGgwZ6MqqWCwnMISCoOJwU8kFGuw7xoHdRZt7/x54BzY7uIBs
   JN27ecbmjicqpT4JkzelxXC+tMvCoG44LiWzdMTgoG9hq/eSgrr6K/LhC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320207028"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="320207028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 05:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="634026402"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="634026402"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2023 05:56:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 05:56:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 05:56:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 05:56:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 05:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk7X3wZKRpYhLpWqtuaecdxFyjYHX+YlHunVZF6g+XV3+xl9Pln8ch519iFfEsfbJ1f64GEMeoIzVpJk4qsUNBRpBcqR206pYDw8Uqf/JCWLv7ztc5NmocRbSfNIiSF/GbinQfJPDZX8FzBsKE9E32x0Cqohj/4xTJEwm3/UdZlpAof23fVGZ0Ju/+Gd6kJ3fySoKrPH1nqN/MCrfbAE0KiSSy/9BscfU1lEfGZRqJ9nvS90YrirTztLAVS5qDXHiKKM404tJmywPKvS69GQKyGn7CvduJOrDf7XWy/4AOmpoPwRMJNbaK/pIlolfy74p+9mUWXkzZ1KdK2Hs5dYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzY9z9WLO2B4HUJjdetQoFc8LtNMDw+n1h9hOXKhGr8=;
 b=Yu/3LieXPXWquFSSHMpSxzl4YPZYj+/xTeLr+TzMFh0cMjWo8KqcucSFx2NsUk0HgBTJxWFcFPDyKoHVbFzMl6zivCVt/X4PvSNGs4rmFN7lnwBXEkn+mbgXdAo0x8YG7ZeGXcP20coL08uK9JWuFLYYrSStNkTJxPAxILWr0KapJoBiMZp7XttVxo5rTR1Bo7ZiQTpz++zlZM2LgziOpRUxvraKcCLiPA0tE7aVFd/M6sOvyWF0FAEqB8elv0NCDHbjq7PD2UV8NtDBf1APStodjOBrFVK+4x1CgZvLvlo9Gsn20Rbi85ShYKb6B/pZo8ou7UPeLoaidVXQQbTIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BN9PR11MB5387.namprd11.prod.outlook.com (2603:10b6:408:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 12:56:54 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 12:56:54 +0000
Date:   Tue, 28 Mar 2023 20:56:24 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230328125624.GA6130@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|BN9PR11MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: c153a2ca-4dec-4bc4-52b3-08db2f8bdc89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndHFr08KIL4gK78gEAALbdutyslKr7xarHiK/02giieVQfKqtoGT5HLqsLEYUZD+FEdH4yjmwjMaFYxe8gjxs2DyRFdlFa9YQUdaAbb9wDiZlvw7P4gClG6t+T5HrzRUoBpt9yuwJSS/QkDQE5pvV6CwsSmWr5YvFvM90VkDtCuO+Io1LDS+xRiU0jK64zYj8kW4ceh3FQqSfHCcHl68XFTcLeua3mPGnLOQXpRRk4pSN/HSuh4dTUJ9zBQpuHdMS2eXkso0tqG4mvjE5RUnP5qcUperUmY/HiL/84ZpcgwPCUhzvDVfXCLHSIpCzWBDVtO3mW+kKg/oXWqmMWxf5BBDwlCOyN7bwUN8yE3HiFNimRxLZ/qNICAsuOkeADUL+bDjJDyiqy0dKokM/ivTc2M4kNUYDO7w6f4gXiwRPWJvQY8NbfzG0Y4HhKWNp2zRDAKs3G6Di5tHbl5UUspqwnc1dM/l2VBBaEpRbY6StMnqa1FjBYoTOOzui8bVrY2zd8GCP2mX0cBGXTmVbjgpl1YzlNsyn4jhbPLtk1bdLkefgZTVzlsI02LTZjV9vwPPeGEdS+u2orRGNu11tcFvYZ6q63ehclPmLGXXabpxV+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(966005)(6486002)(54906003)(53546011)(6666004)(478600001)(8936002)(316002)(9686003)(6506007)(1076003)(26005)(6512007)(8676002)(66476007)(66946007)(6916009)(4326008)(186003)(66556008)(41300700001)(82960400001)(33656002)(5660300002)(7416002)(2906002)(33716001)(38100700002)(86362001)(83380400001)(44832011)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XnE3+d8VxVjP08ZtELbXh1UDXBKLvq2NLWad/UycOC6WGJCd5PW382IwKrMD?=
 =?us-ascii?Q?2CwDuR3KTKaEjIBhJ7V4eY+IWjAAaeJygZEMocct3fv3ZhAd//ilc5RZyc0i?=
 =?us-ascii?Q?07+n0rWLcb9ObzFujiotjEzeacFX3ebLCdGt40Eo98XSdixN5MTiXECfqD6n?=
 =?us-ascii?Q?aOPdFgANwC1K/80BMeNf6e2qTcH+Nz+YdWWL6hSPDINGq5ncnQ2/hZ07xBZE?=
 =?us-ascii?Q?tbf90OT1INOp21SV1E9TThB3d2XBhANNgw+wxvW7Ve98x6r+7Ayk6+xQS1v6?=
 =?us-ascii?Q?CdePmg8o8eA6lr53PZFapC0rums3zn4GEYGARzNmEMGxQ6g+6I0sSmd1lVlh?=
 =?us-ascii?Q?zLK2YHP0JBaTNhT2Esuutwr86x9Rm+v1ET1qpcI3oH3LUQUpGv1b3qJqK3Yd?=
 =?us-ascii?Q?Ajo5WIfMfRLWF8eA4v7AkIoscmGVKCz5XYyFsuNQYfA4Sa5LEfctcrWNq7mM?=
 =?us-ascii?Q?HmG18FYJxiQl+LUlVq49YtqpPUsEfF+F1jKHJD3IQzxK1JqEwpDQkLj0ANyQ?=
 =?us-ascii?Q?eTeP2Mv8UpSwf6Nh7lYIz1rTNpGS4QFLVgCx/sOrdnew/h+vMR/tu1c2RFEL?=
 =?us-ascii?Q?Q7VEYCmUSj+GnMlBODlsxHzP9FCqqqbX05oml1UBrBcswJysJFwbvV+2/X2+?=
 =?us-ascii?Q?l6KE2wrWyQerx9fl/yA7SVcNNGexVgRudxpTIk+b3P/HKqLCQyyfv3XsbC3b?=
 =?us-ascii?Q?xs0ww+V1X0Oh2P88FWqXkAbeEy40dlXuaT5GCkXy92H/UiAbSEV1RHM2LxAv?=
 =?us-ascii?Q?jL9g07+PI2vnkPA7/lAtW7RuIgVCa+tWlj31IkbgsuExNXnt5WM6bBSpqfMY?=
 =?us-ascii?Q?3dq8SFBZ76h9L8/vwySUw060p3nsdbrRPS7He044Rl64TJFLhfoLJ46iTsg3?=
 =?us-ascii?Q?/We57U6xEoJ93JzYPR3tKyX3OlVGQIkstI/aJvSi0ea9gEGRdZHhySlMg4I2?=
 =?us-ascii?Q?hHIcoSVhcpIiX5KvcK9e84vRp2gmEq93A7Hpfg+ydj6ODXbmhgZhglUA5M2N?=
 =?us-ascii?Q?sF0Rpj29Nk+QIIE/qY/lq7yMRRuAGECxrFKU9pqV9SUXEuQY1OSCZBOVDnCt?=
 =?us-ascii?Q?JlXW2/eHy3L/VVQEHq7KlavOo6mvF1tLQlhoYvoUcN9jfayg5nOta4iHyRxd?=
 =?us-ascii?Q?XBOWI1nkMoSgnJmuHPRyjETzAaAHt167k0azyNT7iIDD4kRQFSRzt/8tmOuL?=
 =?us-ascii?Q?Q9igX2iHF9tb87TUpr7AgbNd2nOurnK65+KH5cX65hK4UrGA/z/s3f63aEml?=
 =?us-ascii?Q?5B618NSSKKHD84U156qiFniJMrljql4KcGUsB+/Z12UkDzFSZCXOpshQLyYp?=
 =?us-ascii?Q?ylgbXBEWqGT0ZtEcTmfL7fuZjR2WtFDkEvGnZWGZEzWHUjDhuZ/c5DsHedaw?=
 =?us-ascii?Q?xblLg+18J2qUGL71mXAhR20WUJeXlhz3ZgG5uAeBQY4HDDMl+NDX0a+6867i?=
 =?us-ascii?Q?L36kHqQ/okLpSw30ooxoa37k10GCiYohNYWBDK+S5YO2TW+xc/0ThnP4mKVe?=
 =?us-ascii?Q?unwv7Vp7O917SSps0DqReJ0ZzlrJm0Hl8szzvLKgBtGGpHe0OiHwuQCGDD1O?=
 =?us-ascii?Q?0pN52ysQNqhnwvpQKVoknEkYa6x7iIa7bo+GkSch?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c153a2ca-4dec-4bc4-52b3-08db2f8bdc89
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 12:56:54.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn2B8jGzmAC/nQQLLXT4OoFihM5H2K8920Vs6yhzTnqm9nQop2L+aVIttVK20RnVWgBSCegwF8aoOOd8tm0EiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5387
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

Thanks for taking a look.

On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
> On 27/03/2023 07:39, Aaron Lu wrote:
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> > 
> >     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
> >      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > While cpus of the other node normally sees a lower cycle percent:
> > 
> >      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
> >      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side.
> > 
> > The reason why only cpus of one node has bigger overhead is: task_group
> > is allocated on demand from a slab and whichever cpu happens to do the
> > allocation, the allocated tg will be located on that node and accessing
> > to tg->load_avg will have a lower cost for cpus on the same node and
> > a higer cost for cpus of the remote node.
> > 
> > Tim Chen told me that PeterZ once mentioned a way to solve a similar
> > problem by making a counter per node so do the same for tg->load_avg.
> > After this change, the worst number I saw during a 5 minutes run from
> > both nodes are:
> > 
> >      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
> >      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> > 
> > Another observation of this workload is: it has a lot of wakeup time
> > task migrations and that is the reason why update_load_avg() and
> > update_cfs_group() shows noticeable cost. Running this workload in N
> > instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> > task migrations on wake up time are greatly reduced and the overhead from
> > the two above mentioned functions also dropped a lot. It's not clear to
> > me why running in multiple instances can reduce task migrations on
> > wakeup path yet.
> > 
> > Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> I'm so far not seeing this issue on my Arm64 server.
> 
> $ numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
> 44 45 46 47
> node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67
> 68 69 70 71
> node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
> 92 93 94 95
> node distances:
> node   0   1   2   3
>   0:  10  12  20  22
>   1:  12  10  22  24
>   2:  20  22  10  12
>   3:  22  24  12  10
> 
> sysbench --table-size=100000 --tables=24 --threads=96 ...
> /usr/share/sysbench/oltp_read_write.lua run
> 
> perf report | grep kernel | head
> 
> 9.12%  sysbench  [kernel.vmlinux]        [k] _raw_spin_unlock_irqrestore
> 5.26%  sysbench  [kernel.vmlinux]        [k] finish_task_switch
> 1.56%  sysbench  [kernel.vmlinux]        [k] __do_softirq
> 1.22%  sysbench  [kernel.vmlinux]        [k] arch_local_irq_restore
> 1.12%  sysbench  [kernel.vmlinux]        [k] __arch_copy_to_user
> 1.12%  sysbench  [kernel.vmlinux]        [k] el0_svc_common.constprop.1
> 0.95%  sysbench  [kernel.vmlinux]        [k] __fget_light
> 0.94%  sysbench  [kernel.vmlinux]        [k] rwsem_spin_on_owner
> 0.85%  sysbench  [kernel.vmlinux]        [k] tcp_ack
> 0.56%  sysbench  [kernel.vmlinux]        [k] do_sys_poll

Did you test with a v6.3-rc based kernel?
I encountered another problem on those kernels and had to temporarily use
a v6.2 based kernel, maybe you have to do the same:
https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/

> 
> Is your postgres/sysbench running in a cgroup with cpu controller
> attached? Mine isn't.

Yes, I had postgres and sysbench running in the same cgroup with cpu
controller enabled. docker created the cgroup directory under
/sys/fs/cgroup/system.slice/docker-XXX and cgroup.controllers has cpu
there.

> 
> Maybe I'm doing something else differently?

Maybe, you didn't mention how you started postgres, if you start it from
the same session as sysbench and if autogroup is enabled, then all those
tasks would be in the same autogroup taskgroup then it should have the
same effect as my setup.

Anyway, you can try the following steps to see if you can reproduce this
problem on your Arm64 server:

1 docker pull postgres
2 sudo docker run --rm --name postgres-instance -e POSTGRES_PASSWORD=mypass -e POSTGRES_USER=sbtest -d postgres -c shared_buffers=80MB -c max_connections=250
3 go inside the container
  sudo docker exec -it $the_just_started_container_id bash
4 install sysbench inside container
  apt update and apt install sysbench
5 prepare
  root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua prepare
6 run
  root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua run

Note that I used 224 threads where this problem is visible. I also tried
96 and update_cfs_group() and update_load_avg() cost about 1% cycles then.
