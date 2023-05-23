Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E570DDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbjEWNot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEWNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:44:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA73CA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684849485; x=1716385485;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nzD8dpmzig3Bz920/073pPq/2ERIbylX71pjeR0XKhM=;
  b=anOMDvl9wJqQAaXNiMOLfHH7bfLbmRSX6hEKnlFVhuWo0KKwVMAuOAQ7
   2q/kcBZQEUoqyX6t2sC5Q/MBeASkx1ScTjqeGbNqRRCmD8fTJLPg+lA3V
   JcO/+Zj5cRUiOvuozjmGFVMh7/X1xYimEs6YmpeZ3F4TY3YhGVyH0Wott
   FbLZD4kGUv3jq1N7R44KsUaCEvHwks79Zpvvc0uHkPvl1C4otcQ+XGtSj
   KDv0/5XGCJ8kIqoLcYAjoNMUww8VyS4SFGlUSltYgdT9awXnl8oQkYObC
   58Sipf0vWNUme9jmwvkDovu5IVj2c2J4NezynL/jrvSkbLz6CSEKkMXxE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="353265334"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="353265334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="698053528"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="698053528"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2023 06:44:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 06:44:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 06:44:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 06:44:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 06:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCu5ZWRmupPV47Z/C1V4cdIt3vkLsX1kroyNPvtfPlTFLZax2ABtTN88+POHkOpf93phbevUVVeUD0X7y6MccF75V53ZB+BOp65EcjrMo1g5WuUgJ4OTAs4VlJV/nRfNlLaHg8eJLKeS/GD+31J2dm+jj7Z13VfcJ9VgJM1/Rb2zUzLDVMgmQFMV7gcVWTlfe8EdMQd9sXZbI38haYn4tKMkV9sVUQeWxvs9F8bOxxVpZZsR4Hokm/uYVqTyxcuvDn8IwYJaVCV/nzjUMMxJ8dbrV8yD0/1pzJhVGRZ7W/G5cGBBSnzfQP9hlZqMIej0VqcRimdZa4ZVd+Vv5HLwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpbL+6m4nJ0ZorztIyZ4ryzb2sUlD3eey+AW1pAGepo=;
 b=itrkvfNITw88WvAP4FC/AtU1IcPGRxkd+OXgSuiytbpH0VGbONfacTI6Tr/ZdQ+HJwY67kOK1+ZwOX1hJ5yik4xzkvJoagrAhgwYVXs3PY0yflz4DG2v4HH8HJKhIVZ2d+WXygP7LjIC1Jvp34mu746Klc4baz/sANlf7cwuiLJkmaUurikSbACJZe6cEAePANRxw2Jl5YqDRN5tEJw2sjzu3z+MNEB+S1bwLcMwy2P6ZOZs+R5lQ0onQIWwA63SuMc/W0oiWSffXmiECzbKhRKGsB3y+kMfCfSPnzYdeSPwrnuLvxsrrjf30sEJFDVigI654iNAUUbr2XQeWCACzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:44:37 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 13:44:37 +0000
Date:   Tue, 23 May 2023 21:44:14 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        <tim.c.chen@intel.com>
Subject: Re: [RESEND PATCH v7 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
Message-ID: <ZGzDLuVaHR1PAYDt@chenyu5-mobl1>
References: <20220915073423.25535-1-yangyicong@huawei.com>
 <20220915073423.25535-3-yangyicong@huawei.com>
 <ZGsLy83wPIpamy6x@chenyu5-mobl1>
 <46e8d4fc-993b-e1d6-5e4c-cb33513d7888@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <46e8d4fc-993b-e1d6-5e4c-cb33513d7888@huawei.com>
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA0PR11MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: f1279edf-6994-4cbe-1f34-08db5b93d930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YX1ZfqQPMWqwZT6a+sp/l9vhgh4vHbmG9ylPTXnbAOwmCFVJkz4bAZX3mVM+iQZt/nz+31QEeWyb3hXVZX7gHR+K1/Ap+txJXwkGyJ8C2iezCgc/0nTMXboEPPLj6REB8NzEN48n7cXWLSOTenxglkyBPgn523YLN9BeqVGawzLSjhAmoI47Z6EtQR9/+E/PKKkZyibZjeSCwlgskX320JvZP4RFRjsGvR/TVEeoLp7nnLXeNFatqaSVvbuLK6rpS5tmQkVNLCkrJGIvZWtKbWKxMA9ZvXkJGlNRO9xAp7sb/IyvCT417Z1cH1Puk5XbZt5pIn+sVzUaQma5oKA/+qxo+o/U6OVFqIVpXJmnsU5cJpB10mn+XZzlIwQjuyPJ4nojD482WRwEJrqwMRLHcELNJ4ZVYCNloVggSq7MQXwPasouro8ar+hVMJpVarBC13tCwoxtoghEe8mUThQdh7V9vV3NT64y6GV1RZBDRO9EpfwSgef2yMBAnMkrMr/3eLEXjQI/cpetvpDPNfPdbGMvu6sD9Z95Td42CaTDI86fFp8kyCHyMRBexsusN+SO+Lx7gYUJp/AS7Ahyu9JUJqwcrRpX3y2I4LJP6EHjCW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(7416002)(33716001)(186003)(53546011)(83380400001)(9686003)(6506007)(26005)(86362001)(6512007)(38100700002)(82960400001)(41300700001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(4326008)(6916009)(478600001)(2906002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9R1bU/wsa4Fh+7rwGDgypq/dDdFQ4asz0nLthMgtaukxvafyzscdJEikAGw?=
 =?us-ascii?Q?b+lUfBxCj6i/84+MLp9+G4pGmzYtL2yJxc2bSJpkUJ+kDf7obRQpY9uG5VGj?=
 =?us-ascii?Q?7oLRlOTPtyCvnSXerfh0+xlI4ow0J/RxgQFyspmY33h9lclawNnmfYB/5Fns?=
 =?us-ascii?Q?f/uj2QwcQWq+vCM18mGbnFgfD/+hGC30MIqMVz5SIO19AGYrip6FYp9LLgpz?=
 =?us-ascii?Q?t2nfPM4OMMTugeRx3uG2JPVQ0yrlB8Itq590i4oqM6L6WwWVTHbl/nEI/luO?=
 =?us-ascii?Q?Fucbs85eI36E4mVpHUTzEaa0xLvjFadkdOtm5uReSGZ2OVgIGlAfiTmuBm8x?=
 =?us-ascii?Q?rcPCcRSzq8xDIhLbXWdVBgzSyTkIVD0Hgqg7JOn6E+UtxBQEv+xgddpvUX+C?=
 =?us-ascii?Q?Ro3/pRtkfjMv6dSS65XeYwbyUvFTAaZWl0PsF3tvjPhnkpYQhcseWUV5ApLi?=
 =?us-ascii?Q?Pr0TxddOMXEUC53bgmiFYTibbCHnH1MzIs0q64X7K2jUTy6F07iYO8tipYu6?=
 =?us-ascii?Q?uMWIZR6T5f7woUHAlBT7HPuf45C1QkaGsL9wLu6ubchOAxzHL5AQ8RgGw2hi?=
 =?us-ascii?Q?1PFPDYRxJe6LDv51IN3b211WgYIuewsEY2bXE2IQ0QtTFIgwD4I81sdqCeu1?=
 =?us-ascii?Q?8tysW1Zj31ubyBXsQPPdF6OPk1E+72ZuAGgwTz1737awiYPtJj9cVyFspwQN?=
 =?us-ascii?Q?KzoNxVGSk+ZwKOpEC7oapovNE2cfRXuSwnSHBGnx2OTTj8cnKACRozz01qxl?=
 =?us-ascii?Q?z8q0uDLjjIKXMt8hvuqUO86tKD/qNr+DR3MEaw9JRN55jB8i/efSieqoeV3s?=
 =?us-ascii?Q?yRcdClmQfCKPuMceNyKIjQji2j0eZmwNFeS5TN2JI/Mb0jPcKcNncTaST11a?=
 =?us-ascii?Q?ErR5gFidAzDsM29/cWtBC1N2IPN1fHoy1hy5gPaZjRzVCP2Ag+TV2j6hrTHP?=
 =?us-ascii?Q?IK4a9z5ww948F5k7+brbJmP4xSyOlMxkGBtdJAqoevUOSdYKRzVG4mPuyTF+?=
 =?us-ascii?Q?Ua75KKz0v/WEhtNTQWG+TcT6iBwaRdJ7jDT4f5INdvbkk65z0pnJAZtR7QoY?=
 =?us-ascii?Q?0UlMYczIqFYMSs+9eAk29ncbNksAYZHxN2jPkm3LB8CVODgghCxztTqM4oDp?=
 =?us-ascii?Q?tAUi5SrCZTDBIaHLCANN89niMRC+SqTr9mPLdWaCIfy7DbvoUYYlkcZz6uXx?=
 =?us-ascii?Q?3E1JdXuPKguVvXpaLrlNH1qfQrGJEQbVoOoqRC+z7a6u64V2OWT8AGXYof7l?=
 =?us-ascii?Q?QcWzlXlEg19n+sapEqGYruhWzdRn0ny4K4iAK3vKHD55S52DTEiSaY1n2IhK?=
 =?us-ascii?Q?bLsIb3XrtSU0+NMVvARppwbXKnGS7PohaLovG/Hp124GhNcXYnea3nFhyVi2?=
 =?us-ascii?Q?mRlnRtETvAsGzb4wyFC7R11IdgyvOiARWCDoqE8fF3rBAZbYeccVqRDoqgUK?=
 =?us-ascii?Q?Y8qH2uJsGuY6Oba9wmxqdKZgqJUR7Cd+xhLozvmiwWf0EByEnyR2zMDOuM1w?=
 =?us-ascii?Q?EUL7vzF7DzHiZANpfQC85Sovj5Sr1v2KoRD5wLHJM6SrX7tsvAyTCrT/21Ey?=
 =?us-ascii?Q?FQfzxSlE06ydRInPZ//FmKcrgnEwC/Ozv238Wv9X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1279edf-6994-4cbe-1f34-08db5b93d930
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:44:36.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjvqSGn6d5m2gyeuy9m+1yq29/WHSlsZEopk76bCu5F9JLY3MyO9horIuvDYRttOmTBRYENgrufgp10s7pYxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
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

On 2023-05-22 at 20:42:19 +0800, Yicong Yang wrote:
> Hi Chen,
> 
> On 2023/5/22 14:29, Chen Yu wrote:
> > Hi Yicong,
> > On 2022-09-15 at 15:34:23 +0800, Yicong Yang wrote:
> >> From: Barry Song <song.bao.hua@hisilicon.com>
> >>
[snip...]
> 
> Thanks for the further information. The result of netperf/tbench looks good as we
> image, the cluster wakeup expects to gain more benefit when the system is under
> loaded or well-loaded. May I know how many CPUs sharing cluster on Jacobsvilla?
>
There are 4 CPUs per cluster on Jacobsville.
[snip...]
> >> @@ -6550,7 +6574,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>  	/*
> >>  	 * If the previous CPU is cache affine and idle, don't be stupid:
> >>  	 */
> >> -	if (prev != target && cpus_share_cache(prev, target) &&
> >> +	if (prev != target && cpus_share_lowest_cache(prev, target) &&
> > This change impacts hackbench in socket mode a bit. It seems that for hackbench even
> > putting the wakee on its previous CPU in the same LLC is better than putting it on
> > current cluster. But it seems to be hackbench specific.
> > 
> 
> ...without this do you still see the same improvement at under-loaded case (threads less-equal the CPU
> numbers) for tbench/netperf? 
> The idea here is to always try to wakeup in the same cluster of the
> target to benefit from the cluster cache but the early test for the prev and recent used cpu may break
> that. Keep it as is, at low load the prev cpu or recent used cpu get more chance to be idle so we take
> less chance to benefit from the cluster and gain less performance improvement.
> 
Right. Without above change I saw lower improvement at lightly load case for netperf/tbench.
> In the hackbench case as you noticed, the utilization can reach 100% ideally so the SIS_UTIL
> will regulate the scanning number to 4 or around. If the prev/recent used CPU is not in the same
> cluster with target, we're about to scanning the cluster and when found no idle CPU and has
> run out of the scanning number, we'll fallback to wakeup on the target. That maybe the reason
> why observed more wakeups on target rather than previous CPU.
> 
Looks reasonable. When the budget of scanning number is low, we can not find an idle target
on local cluster and terminates scanning for an idle prev on remote cluster, although that
prev could be a better choice than target cpu.
> In this case I wondering choosing prev cpu or recent used cpu after scanning the cluster can help
> the situation here, like the snippet below (kinds of messy though).
> 
This change makes sense to me. I only modified it a little bit to only give prev a second
chance. With your patch applied, the improvement of netperf/tbench remains while the
hackbench big regress was gone.

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  2.35)	 -0.65 (  1.81)
process-pipe    	2-groups	 1.00 (  0.42)	 -2.16 (  1.12)
process-pipe    	4-groups	 1.00 (  1.84)	 +0.72 (  1.34)
process-pipe    	8-groups	 1.00 (  2.81)	 +1.12 (  3.88)
process-sockets 	1-groups	 1.00 (  1.88)	 -0.99 (  4.84)
process-sockets 	2-groups	 1.00 (  5.49)	 -4.50 (  4.09)
process-sockets 	4-groups	 1.00 (  3.54)	 +2.28 (  3.13)
process-sockets 	8-groups	 1.00 (  0.79)	 -0.13 (  1.28)
threads-pipe    	1-groups	 1.00 (  1.73)	 -2.39 (  0.40)
threads-pipe    	2-groups	 1.00 (  0.73)	 +2.88 (  1.94)
threads-pipe    	4-groups	 1.00 (  0.64)	 +1.12 (  1.82)
threads-pipe    	8-groups	 1.00 (  1.55)	 -1.59 (  1.20)
threads-sockets 	1-groups	 1.00 (  3.76)	 +3.21 (  3.56)
threads-sockets 	2-groups	 1.00 (  1.20)	 -5.56 (  2.64)
threads-sockets 	4-groups	 1.00 (  2.65)	 +1.48 (  4.91)
threads-sockets 	8-groups	 1.00 (  0.08)	 +0.18 (  0.15)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	6-threads	 1.00 (  0.91)	 +2.87 (  0.83)
TCP_RR          	12-threads	 1.00 (  0.22)	 +3.48 (  0.31)
TCP_RR          	18-threads	 1.00 (  0.41)	 +7.81 (  0.48)
TCP_RR          	24-threads	 1.00 (  1.02)	 -0.32 (  1.25)
TCP_RR          	30-threads	 1.00 (  4.67)	 -0.04 (  5.14)
TCP_RR          	36-threads	 1.00 (  4.53)	 -0.13 (  4.37)
TCP_RR          	42-threads	 1.00 (  3.92)	 -0.15 (  3.07)
TCP_RR          	48-threads	 1.00 (  2.07)	 -0.17 (  1.52)
UDP_RR          	6-threads	 1.00 (  0.98)	 +4.50 (  2.38)
UDP_RR          	12-threads	 1.00 (  0.26)	 +3.64 (  0.25)
UDP_RR          	18-threads	 1.00 (  0.27)	 +9.93 (  0.55)
UDP_RR          	24-threads	 1.00 (  1.22)	 +0.13 (  1.33)
UDP_RR          	30-threads	 1.00 (  3.86)	 -0.03 (  5.05)
UDP_RR          	36-threads	 1.00 (  2.81)	 +0.10 (  3.37)
UDP_RR          	42-threads	 1.00 (  3.51)	 -0.26 (  2.94)
UDP_RR          	48-threads	 1.00 ( 12.54)	 +0.74 (  9.44)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	6-threads	 1.00 (  0.04)	 +2.94 (  0.26)
loopback        	12-threads	 1.00 (  0.30)	 +4.58 (  0.12)
loopback        	18-threads	 1.00 (  0.37)	+12.38 (  0.10)
loopback        	24-threads	 1.00 (  0.56)	 -0.27 (  0.50)
loopback        	30-threads	 1.00 (  0.17)	 -0.18 (  0.06)
loopback        	36-threads	 1.00 (  0.25)	 -0.73 (  0.44)
loopback        	42-threads	 1.00 (  0.10)	 -0.22 (  0.18)
loopback        	48-threads	 1.00 (  0.29)	 -0.48 (  0.19)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	2-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	4-mthreads	 1.00 (  6.80)	 +2.78 (  8.08)
normal          	8-mthreads	 1.00 (  3.65)	 -0.23 (  4.30)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0989116b0796..07495b44c68f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7127,7 +7127,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util, util_min, util_max;
-	int i, recent_used_cpu;
+	int i, recent_used_cpu, prev_aff = -1;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
@@ -7152,10 +7152,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_lowest_cache(prev, target) &&
+	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev))
-		return prev;
+	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+		if (cpus_share_lowest_cache(prev, target))
+			return prev;
+		prev_aff = prev;
+	}
 
 	/*
 	 * Allow a per-cpu kthread to stack with the wakee if the
@@ -7223,6 +7226,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * Give prev another chance, in case prev has not been
+	 * scanned in select_idle_cpu() due to nr constrain.
+	 */
+	if (prev_aff != -1)
+		return prev_aff;
+
 	return target;
 }
 

thanks,
Chenyu
