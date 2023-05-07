Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C66F9691
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEGCUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 22:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjEGCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 22:20:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE20311DBB
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 19:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683426004; x=1714962004;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IiphwiXd983ri3wFnWzW4qPS2CfOTUv+64RcZTCa2Q4=;
  b=iqAO+xXl1KtvE3Pw6bl3IZjQdt0JjSrca1rwgoh/MFXSOwVX2NlNEw3b
   oCpVauUYrFSPLnYUK9Mu29GE2sl6evZbrHrFIHbbqdDG7aPX5PgDKVuwY
   tvm3NRJXTU/e/SDd2SdV6cntzONGhFQ6s+p3Ry7+IQWvBKwAYyNPz83Rg
   qHEbeuMHCZFB71pFMRdBLl7SALUIkr2Pp/yNj/LUsx0j2OP2Sa+eS0mLE
   RKKWkg+2/fv58iUbwwVbc5XRvPf8k4o+/BhiVhf98wWRC8Yue3fVJNOaJ
   I5uAvTBij2EgCbqRFAe4CDDvRClnYTStCJAnn0bqF2y305ELZShwk1u1x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="435758326"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="435758326"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 19:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="730852048"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="730852048"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2023 19:20:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 19:20:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 19:20:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 6 May 2023 19:20:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 6 May 2023 19:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfutMEYkRphwm3QZ0g7gHnLps9LlD+YVWEF3A9bVxqja+Ec84dWCnDoc9eVXSx+q58I+VZ/p9VNRN91cwtW/ua+I7ytJvWWZlb5Dw8sNJ3uQtRdedpITlAFTPshY1yt2/zZ8Te2d5jhVCOgiYQbbQSyViX21cUlxEYlvHrkw36iPfs373m9S+/cYZQtH3tArl7AJvtm2UESxAa/IUqxk99kh2xyBWj/s6HcIAS0CtIGSeIh0atKSrIUKQQzuPzASw7GlKShxRH8qriEpa2d4khj7DVbnWPrbduId38mzeYE0stR5M2Da31Ohpoq0ZDBtvqWrc2ky/a+bl3uCZh9mTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC3W2/UyWnMejfT5UjYU53O3W2knBSO5+fAIfbVvN3A=;
 b=f071t/MiMUeR/NLq0qtO3rgBaciVf/lE1/FUBy0b++nT27uNbk8sMMHveVcFmFA/RG9wTuQXCi+K8vy/3OuLdKaQVqthd9L/VTsPvlcn2bP72EnDJZeTRTxOTqWL9js8tjgOy/9yFpvuU2qXPEbkCDsnVAhi/g1154EmLFfNHDdtEJvX190dEij8StKtjrCfALUgPaA8x8sRNKmu5mcmNI3W2o+Hh8IRanTUmJsaZ9eL3bDXymcVDdB78O7+nGz7ZAMtW+MDPxJs5yQdDcok/lUW7op3/0k3HpecXVxA8d+pY43ms4PljirldVSYBf9zJ/wL8OtwakyClceaTu8C8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sun, 7 May
 2023 02:19:56 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6363.022; Sun, 7 May 2023
 02:19:55 +0000
Date:   Sun, 7 May 2023 10:19:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        "Morten Rasmussen" <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        "Abhijeet Dharmapurikar" <adharmap@quicinc.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Message-ID: <ZFcKus/4Jo5oRuU8@chenyu5-mobl1>
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
 <ZFSr4Adtx1ZI8hoc@chenyu5-mobl1>
 <8276e5ce-b1f6-19e2-095b-abc6952bd1c7@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8276e5ce-b1f6-19e2-095b-abc6952bd1c7@arm.com>
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b9c90a-d4ea-45da-ead7-08db4ea18bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbgE3Co/LoPBBsLH0qTo8t9iJorzj/bddF7gW2socdakvwQotwZcubJpYfaCAPQz7l6oeVmpYm/2s+f9SFb1QuVYM4VSqDj/e+aI4fXLnQdf5ytqY8Eme42rj5KEw0z1iaZMEkPHpOYfazIQ+Gy9NcmoDuuHcGcfhuSfMiXeAsMxU2Gt32LZRb/4uTWRkwQ981f4ToFuyhMZ3JnMTP/g/b53LSQmLcsN/phbeZ7zO4cC1VSFFelgfX1nYCgH2h0ObyGpumMCucQdo9J6TSMIV1HphMWNvC9sVtHdAX1dxbymzrSaYnEgU018YrIos10K4GBTorstD1AlU62cGPAkruHGiiShWAwdXOxhqDph8SuPdkO/5wDy1PgpMUFlE8fmq6bJCdCkYVY9s/SERlclmenB09cefBlLdA5jUoBF5MXjZoRvFo+eAsBRwpIaXvV5zLKv6DPqq4uhoevItmDV3C7nBiRN/Gk6YN+PzYmYkSznWIgTkEtRbGfKq4xHnJjl57ijGsQyy4ThGmEMCF4C4JinqfhtouYzc6AX9FRsd50r1nMCL9Me6yf7d2AqDmnp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(5660300002)(8936002)(41300700001)(7416002)(8676002)(2906002)(54906003)(66556008)(66476007)(4326008)(6916009)(66946007)(478600001)(316002)(6486002)(6666004)(33716001)(82960400001)(53546011)(9686003)(6512007)(83380400001)(26005)(6506007)(186003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UnMl9VBRjZ/pEMw+uhbXoAUkvDLHf+ap55BoKQoDomgAPrJfml99X7fuA6UB?=
 =?us-ascii?Q?qEUEtdLYXskTAJulanYwyofyE4Pr0j0H4vVa7brGX43TZ0FQdWYeMIb3H4ft?=
 =?us-ascii?Q?OjZamda/+FhE/zbQlabcG6HsZv37SoApSdvL8ozQloqtrPuD9uIV9+PaZXGl?=
 =?us-ascii?Q?Xsr8/wAqQyKkal6gqTYNYK6+TPsyJmzNdo7tdsVcDmJZxqX+VOXmaPtNpyyL?=
 =?us-ascii?Q?FqrZ15yZI+ovNCqm8M6rQVRgVheulvumtllLKdGCNNX5AolqHZT/ApaeE520?=
 =?us-ascii?Q?zchGttoGZat1r2HhSXmTE2BFgmq44kaKy3hGFl2xvxXlEJbDWfp9ZQX62Vq8?=
 =?us-ascii?Q?13YMgCCxCrJyayTEvkyAawrWDZ3GUsvc0rzfeCkSvdnwGUFyWuAwDBW+zelC?=
 =?us-ascii?Q?jRafajGogYS/qf1lg8F8x2+lwY0JNtDrfXowlb+HflSG5vEn2ktKo/Ym9MOY?=
 =?us-ascii?Q?KRfBC0vuGMTS9C+9zXgc0+StrJsWWqqNQwcnoXbvwYPipq7wdIp+5MVp5r6O?=
 =?us-ascii?Q?VpKvmt1gHTov5bkckECq8HgHCeWsB+0fw3+gyZOdpYH78Nf8WDjXbPoChZK0?=
 =?us-ascii?Q?7ORpR+6ngpqax2qE2BabcJdDx+HY5aDNci0Y2eDWRS1yOtrNvssnvaKySnWD?=
 =?us-ascii?Q?I0UkTDZxoWPLNV/12nh65RuMEhpcTkNZMFsOGMhXx2401nVAAwXY7G0tIUYa?=
 =?us-ascii?Q?yrQfI2Jwjxd8v57Vu3BnQrmU8zPsdGrj75TvN4LWJ3rD3olpuqoXI7wo9gCf?=
 =?us-ascii?Q?EN3iJj+SjhQKnAHq3O/WXA1r1Bey3VjSRqmLUOnKv5nNbbMLSSgPbCxQidkk?=
 =?us-ascii?Q?LuErZ+p2DLjL8oq6+To/qw+bHscyg7hro1WL7k3715kOx7a2JLc6aRGRX9Py?=
 =?us-ascii?Q?qv0PFN7uMjlU9KPNWxAlMSqbcy4C4BIA6gAkrU4Z50zJj/AHVm+P7itXYgdh?=
 =?us-ascii?Q?7fo/H1AH+LXhD6bfpasYMOYEBv1l+9ks66ND/Iz9NaGxKVWBUhBc3N1uLmWV?=
 =?us-ascii?Q?nAbjeyNbi9c/lI/jNXLBiAKiwu+s919h9YwTh7/UIVjjcskhfbWDTaGT4i2e?=
 =?us-ascii?Q?eHhnbQTABBSdXbVVAeceMsuUzIYXoJgptUlEe1JVBP2qBja65EpKYZymhcdW?=
 =?us-ascii?Q?tZqe9OnusOKagperGuG/K5cdMZUZHbrpa3h7FZCG0PzhiIvlP5kuuW9+aR7W?=
 =?us-ascii?Q?+IshytDsPHSc30QW9cHBWR11nq2dzLjRlmQpTRsETYAEe0VGB3MSf7SnPuRE?=
 =?us-ascii?Q?7oMcqI52UEbtm30FpUZitRMe+G91wPrwOYQw8k6TUczEGb6Aa3UDhlFP+xOw?=
 =?us-ascii?Q?SQZgK8+qgPcHio0AX/1rkCGKDDeYt3iiCBS+PJG63e3rWMbiI3nWmgPbP6l3?=
 =?us-ascii?Q?6yZiGhMj9lFgiLKykaxXmqkG91cWM47/2+8KZvSWDkp003ti4KKcL0oJxQVc?=
 =?us-ascii?Q?IsjDlPYDR/RP5Yemx0GKtAAjacq+GiIWj4SetZo6WAItKAUBjAxJE6uxv8Lm?=
 =?us-ascii?Q?nBSOsk5gQMZdnzWoTghcOCCIvcVmO1VWQhrrEGk+P12AeAMsYUwSuQnURFag?=
 =?us-ascii?Q?dWpZrtrFtfB3cYbhAGnic35MBIoeleUUVT/rpz3x?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b9c90a-d4ea-45da-ead7-08db4ea18bc1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 02:19:54.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMLRPDaovjFpqWUoPYhM3+Cvj45hLaU/AISsux+WkN6Hg1tN5kDM0Y79KT4vGKDChD2GbjdyBu9LKolEAtlGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 at 20:02:36 +0200, Dietmar Eggemann wrote:
> Hi Chenyu,
> 
> On 05/05/2023 09:10, Chen Yu wrote:
> > On 2023-04-06 at 17:50:30 +0200, Dietmar Eggemann wrote:
> >> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
> >>
> >> The former returns max(util_avg, runnable_avg) capped by max CPU
> >> capacity. CPU contention is thereby considered through runnable_avg.
> >>
> >> The change in load-balance only affects migration type `migrate_util`.
> >>
> >> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >>
> > Tested on Intel Sapphire Rapids which has 2x56C/112T = 224 CPUs.
> > The test tries to check if this is any impact on find_busiest_queue()
> > so it was tested with cpufreq governor performance.
> > The baseline is the 6.3 sched/core branch on top of
> > Commit 67fff302fc445a ("sched/fair: Introduce SIS_CURRENT to wake up"),
> > and compared to the code with current patch applied.
> > 
> > In summary no obvious difference and some small improvements on tbench
> > were observed so far:
> 
> many thanks for the test results!
> 
> Could you share the parameter lists you use for the individual tests?
> This would make it easier to understand the results and rerun the tests
> on similar machines.
>
Yes. The test parameters are all tested with cpufreq governor performance,
turbo disabled and C-states > C1 are disabled.

netperf:
Loopback test. Launched 1 netserver. Launched 25%, 50%, 75%, 100%, 125%, 150%, 175%, 200%
of the online CPUs number of netperf client. Tested type is TCP_RR and UDP_RR
respectively.

for i in $(seq 1 $nr_netperf); do
    netperf -4 -H 127.0.0.1 -t $type -c -C -l 100 &
done

tbench:
Loopback test. Launched 1 tbench_srv. Launched 25%, 50%, 75%, 100%, 125%, 150%, 175%, 200%
of the online CPUs number of tbench client.

tbench -t 100 $nr_tbench 127.0.0.1


schbench:
Number of worker threads is 25% of the online CPUs. Number of message threads is
1, 2, 4, 8 respectively.

schbench -m $nr_message -t $nr_worker -r 100


hackbench:
Number of hackbench group is 1, 2, 4, 8 respectively. Work types are "process" and "threads"
respectively. IPC mode are "pipe" and "sockets". The number of fd in each group is 12.5% of
the CPU number.

hackbench -g $nr_group --$work_type --$ipc_mode -l 5000000 -s 100 -f $num_fds


thanks,
Chenyu
