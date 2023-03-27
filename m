Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4866D6CA826
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjC0OsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjC0OsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:48:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACEB422B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679928480; x=1711464480;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CRYoiaKRNMGJqjM0nIE1jT7nxhp/H2R+4eE8ZvyRtF8=;
  b=EzYUEvJ4cGdFa/eKGDHIRPFIDQfYxX12rbvhQGZhmm34ncWjfMU5TtHS
   B+IvabRjoO8DaPLwvDCiLkgA+DXymUM6govOJTRzoZ9IZ/sB2IDRyzjAA
   CYiarRJeWyS851X8zIRArBi/rRM+L3nyvbaasIzspZ55QUOkrN5ixYWKs
   lmKYQnUMHn/i1R8ijKdPROZQJOTo9upCHv7523vQzM9U8fDW9tUm7rBTx
   zNNAfaSI+3JxqeFJ0kwIrnQsBC0zaE5T0pFbm/m6T6ReAa/5qD0Se9qBm
   7WLi7aBsMev3zSbmhBXGfUJK71i3kglLpHzuD/8ctCuO/5jIfLRLuMcnD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="341856646"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="341856646"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="752722317"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="752722317"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2023 07:46:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 07:46:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 07:46:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 07:46:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 07:46:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPjK4V2+ThuXtC9LObjtZBCgfqDzTY4yLr7ZkPQfWhxoLPYiBaPtjccJwnKRiBEjqN/USRQj2Q6LG8UFn8/2wAlEKaIDxumKNc8+ppyqvgcg0URU9SgM/J4bxJrhh8/PVHuJyqr8Pxx6mO/RGR5fDi/QgLiekK2bmeyCrNV3wMC9CjyAQ0gcOcDKc0WZ916Pd2BWSV6RlD+mBu1qW6vsnSW6GSUhh/d6EoI0trq3poTw6cppaM/bv9Bj/WbmCSYyzMAwuroHmZ1hXkMFEcq2Vg57HCJLwqrEHFXayRPraHDMkp5Pn0uQCrwEXfUoN6OPG/VjJzDc01i5tp4b/SmSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpjsCi7dASVHd+hkutqUVu/OKAY4wNOa5X5bZLZLY98=;
 b=DmssmmX7CpxhH+3JbcMADHKMexdRxJqfpymLgSqtIF+wlydpWMMA4uTMVLBqu6Z9bJfANxUiDIF2EsX/XLWlyXcs88xzxiThlqe3QI+OxS6KTmY+xfYPZh5bqdQ9CPi7Eo1YuHC/K5wYNkl+w37RYV/lzjT1DZH7cFV5EkQgdRFDodlEI5hqG0uJYj5jxgg14Rw4RWLC7ps0KLbLqeDg9kYhT8e7+T8lMEAs2YDwpCByaeqUnS6QC+2lLT1VkRn0HaVIEtZvaVDhQWp5EYY1OT0GyDGY6sqiuUv9GQ3ZLGNspNdtngMjGYx7YpV0b+yvW/6Bv3DbTaXkGnGh1aru4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA0PR11MB7862.namprd11.prod.outlook.com (2603:10b6:208:3dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 14:46:14 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.038; Mon, 27 Mar 2023
 14:46:14 +0000
Date:   Mon, 27 Mar 2023 22:45:56 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
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
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <ZCGsJB36YYbgsgBW@chenyu5-mobl1>
References: <20230327053955.GA570404@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230327053955.GA570404@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA0PR11MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7eedfc-07fe-4c62-d3e9-08db2ed20384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU5dgVNzmV5Hj8mx+LlQu1CwgufxygHnxhBOiehkprJ+tl+jEGB6r056mFT2uIblq1Fww6A7I9PAKp4OWY7YiHEINRcT+jjxKXbxDV3QR5XW53PPKKnvDiz0nfHyQh/iHl326PMlCT3VEqvZzd9peD+qGIPLTilNc6SNN6XJyZrBS+90VVxfyhNFfE07NEgb3dZIqObrhw4X30G9jX8ZlChFkjEpH009xvE/XbfBCGr/D1YmBpBzjDMSEJ7m6CdcdQ4h0OiOCJBM7zebhG9vzkRP7ziksMlnOMwIWWBrNnfNRbBj/8m9xgafGVPH+5ffSL8oC3NEQm3YxruEBxU+BtxS7s6fQsNX/5p7HOiZqOEOFAjEKjhU9Uh32XwlarCO5a+W2eiucBHe3FIbOzL/ib19hoYkNLWrzwY9R67GvMg8DsvexzThOi9dNdE3vi/nct5688RvByl002LBaRzbp9hL2CQfqjKLpMH3VpeDCo8hMEn7xYjti+8HwEzAMpm29pKGgyvZbsWGrjEgQYmlooqeFliUZmcXzD9hLdhnGeFzWG/x6gBC8d3yUz1a59Bc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(38100700002)(478600001)(66476007)(66556008)(66946007)(41300700001)(4326008)(8676002)(54906003)(6636002)(33716001)(316002)(8936002)(6862004)(5660300002)(7416002)(82960400001)(83380400001)(6486002)(53546011)(2906002)(6506007)(6512007)(9686003)(186003)(26005)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdXogpDKYhdW3/fwCo3zdTIBDHQw1xvjZlESbgq8UQOZ3UfXiNLXtxZXPVfF?=
 =?us-ascii?Q?zbpyZkBJwO4xJk09lll/GzDoOWMtUnmPpdUD3tXTBK/m/E5XvwHm/L5A01yb?=
 =?us-ascii?Q?Ogzjk8pm6c3lWyq46xhYl2LnSXS45jgviizPP4z2PZVI2Lm3Sx8cJhTc6CDR?=
 =?us-ascii?Q?ec/bMqm1ZMlI+sXJBNvI+g1pMoI080e1KCpqcvj1dr3i0XTa6WFd3/tfj+fW?=
 =?us-ascii?Q?h/1Fjvv9b8VuCzeGqyrKZQnEJwM0wd9py9YYvDJJf+ZqmlXzE467YaTm99i4?=
 =?us-ascii?Q?Ziq2ZEjG6k9upsTycGvqQd8Zqq1LXpGfGhAQLotQC/eGXQuvVv+toQ30fUDL?=
 =?us-ascii?Q?UJiNoruVsezLSIjmXLERvW5+ekXhhQ06tnG+HfNp3MZ5oWuJOf413DMu/asR?=
 =?us-ascii?Q?1t+ybjS7QdvBJr1onM1SrpbYzhoy6cG7gEFkq0XJ6sCpju6UF4QjFF4yNPB3?=
 =?us-ascii?Q?pnCsXL8xGlIFGZLRJMwDf0kAbiYgIs9DinBRfTCaqXClWp8kVmrxgTOvYBkO?=
 =?us-ascii?Q?2WjbylCs6NOgAd4z5qw2n6MVx7vqb2ef19DeJjEbEN7LOu6rRgAZl6f3MVY7?=
 =?us-ascii?Q?f3QkBWpV7TyszYDdIqBS/WqyAdOndMhX59A9SfgRgi1H7PBkF8lWlhWbbBxL?=
 =?us-ascii?Q?ScORboTFzZeggdIyYexJvqyr553sw/hXyefX8hanrh+kudVsw6Bj4Xc6LfII?=
 =?us-ascii?Q?OYSoF/W+u/IMUEBGip/Iveo6yCfUTVRGoC164p896NJyC9vsADNdxKpYhYIy?=
 =?us-ascii?Q?OMr5SIMhiJQVQ3g4bgq97GsRvbWiICNX6rcsjjgYcSazTsdorXUJT93nbFui?=
 =?us-ascii?Q?Kkf63iluPyBAYkwklfFwETmdFaEBegAW/wtrqVXldBibOiV8SHWli8I0WTzG?=
 =?us-ascii?Q?93SABscISZSTujrkCDpx64ItE/pBIxYfU8psxJ9nbsNHlRPEqe7eqrDWUGDp?=
 =?us-ascii?Q?C4IxSCZnCpGhDer4bKrX+eZNyGtYTekeS4kBXJu4xio7A6bHs+WX/Z4D64VO?=
 =?us-ascii?Q?gTzDkD0EFuGLcnJNTyscUfUaGyCPfbE6EIXU5DR6JBJe+PREqrsS5txgx5Sn?=
 =?us-ascii?Q?OfTTFUfgBFLXpUMFsUx/oja6Z/mFR3t5Zr63cDIYw7nxsMky2EmaOnyrU2oY?=
 =?us-ascii?Q?IGq9jcHILCj4evOAELyNgA/snBOEPJvClXWpQI6iNjwItqZSmbSe8BhJjigQ?=
 =?us-ascii?Q?cVA7ehMGkU8HL40OAZB28JW8UQdy+xl9WNrqkYqapwIQ988gQRur7Pg+wYcp?=
 =?us-ascii?Q?Kn+vLYf9oSP5+qMklumA/cUrdXtcP7aqQQ21DjT5LQOizZAkVljTABd7wCjN?=
 =?us-ascii?Q?VEcv2d6YEYgFF7kGauNjT+eeL7j86wQavMyFuiM/1mcdaQ2mpxPGleHSvIj1?=
 =?us-ascii?Q?6bxG9Fqrnu/Fb8FO+xgHWmtF8C+0rQ+XANeMFlqi3gcPhbMcnR4rXWc0/Xzk?=
 =?us-ascii?Q?q9c5EbyRSw/v0gJIw0AFMP7uXDPNrDaWI6LOY9R5eGptWzYxlqV3o12ZG5f3?=
 =?us-ascii?Q?qsleVYkizYyi5aPa5ifcf+Bi8xry1lVo3/wSvv6rkx8evl2L68GOrNvifeHs?=
 =?us-ascii?Q?/oAMVkhpEYM6b2p78FS+qVORXbEWI5je4ekyJ0Dx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7eedfc-07fe-4c62-d3e9-08db2ed20384
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:46:14.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqvHomUABEwB3q78IW1917rVZOLpUTYWcwcyWtKTgihHxs+5HL+q2ZW9+Rfl/IYgL+/W0Hx+cQaQRChMeZV0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7862
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

On 2023-03-27 at 13:39:55 +0800, Aaron Lu wrote:
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> 
>     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
>      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> 
> While cpus of the other node normally sees a lower cycle percent:
> 
>      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
>      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> 
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side.
> 
> The reason why only cpus of one node has bigger overhead is: task_group
> is allocated on demand from a slab and whichever cpu happens to do the
> allocation, the allocated tg will be located on that node and accessing
> to tg->load_avg will have a lower cost for cpus on the same node and
> a higer cost for cpus of the remote node.
> 
> Tim Chen told me that PeterZ once mentioned a way to solve a similar
> problem by making a counter per node so do the same for tg->load_avg.
> After this change, the worst number I saw during a 5 minutes run from
> both nodes are:
> 
>      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
>      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> 
> Another observation of this workload is: it has a lot of wakeup time
> task migrations and that is the reason why update_load_avg() and
> update_cfs_group() shows noticeable cost. Running this workload in N
> instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> task migrations on wake up time are greatly reduced and the overhead from
> the two above mentioned functions also dropped a lot. It's not clear to
> me why running in multiple instances can reduce task migrations on
> wakeup path yet.
>
Looks interesting, when the sysbench is 1 instance and nr_threads = nr_cpu,
and when the launches more than 1 instance of sysbench, while nr_threads set
to 1/N * nr_cpu, do both cases have similar CPU utilization? Currently the
task wakeup inhibits migration wakeup if the system is overloaded.
[...]
>  struct task_group *sched_create_group(struct task_group *parent)
>  {
> +	size_t size = sizeof(struct task_group);
> +	int __maybe_unused i, nodes;
>  	struct task_group *tg;
>  
> -	tg = kmem_cache_alloc(task_group_cache, GFP_KERNEL | __GFP_ZERO);
> +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
> +	nodes = num_possible_nodes();
> +	size += nodes * sizeof(void *);
> +	tg = kzalloc(size, GFP_KERNEL);
> +	if (!tg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for_each_node(i) {
> +		tg->node_info[i] = kzalloc_node(sizeof(struct tg_node_info), GFP_KERNEL, i);
> +		if (!tg->node_info[i])
> +			return ERR_PTR(-ENOMEM);
Do we need to free tg above in case of memory leak?

thanks,
Chenyu
