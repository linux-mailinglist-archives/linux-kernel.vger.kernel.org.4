Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A285F0F92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiI3QG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiI3QGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:06:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D111C2F95
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664554010; x=1696090010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5l9E9C/jy0DXJ20IXs0O3NjWpK8wGZjjaggmAgMWHc0=;
  b=TnB+yo6OOtaqwb4ihvthlN1IcjxfLUqno9JEG6YTx9++YPjl7qRiOsKI
   ey0mZSiMYsABhdZADgAlaAa7c9FkXdT1eiQ4tEqZ9HLag8cihu+rnA5eQ
   SlIeJKKl+wMuWUWcS7ecHn7rPZ3aG2n8GsyVsujsMziLRZbSRHU1vNuOB
   oUN8rJ03ZKaJogPZf9N9u98p21Z42un5seeoQP/2aa1M3T/tf8SygnkfY
   t6afKdsEh4exF7ZRHO/uU0ds1ghzmSvzFhfxEOcOXEalYh4xy0DbdiyDA
   VkWA4B0OPcTCxU4krXf3y5Ob2IbygGgrmGVuQO9yU4xlz8QFLBbScEWoh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="302197285"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="302197285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="655997508"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="655997508"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2022 09:04:37 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:04:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:04:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 09:04:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 09:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQuHefiEPp2B/A5v7jxi0JVg7NbpibKh2G/HkpWoaK+C3QN4zN0yKpe02z+YEKK0fM5FAKUdtCutyW4Nvbya8BDKP4Izx9urJjqUN6MDMdd/JBb/W3FBi3gncvBnGDU83dFWP7dgPZ4J7/jRPu5v3vRuI9xN9f5uEGZtZy5rKqjJftF+//7G9Ca+vgTwQ+YfBvBqpYD+alNlW5ngxkFpJnijov5BNAfDTE7h8RGFl//WqMIJ1XUIKOG7caGp02s7gHLMGr2ILs/a+bKJ+9J3mW1QRYmNFkxcMcE4TzOryi/2xfpx1OUTRLsyvFoIpsBkNPPn/yN4g+e4cAB18OHpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEKQf8X8N4zHDhjPLmZVPcJkteyDENQNJwAPCWFw/Rw=;
 b=ix2zQMbyi5SgHrErFmPzKE/7yq3I+OmIWRBjSM/EQUNjEhv+Fo8K0PvkL35fW1MA5mCaGVtYokPFb4jY1Jw/wkRJb7F4NvzMLcX+8ODcrfCifklVulK/9YIS0MTrmZpcHdYZ8eS9i1X9STuFdJ1RkKGc/oR4JrCntmeDyQKRBt01iEfpDhJEDyi7qkXCg854nlgdguEeHVCDmg/zB+Zso5/QCMpV9UPeYl9Yo7FM6QVQqgc0wwECnqDHFUzJtJlr+OkHC2Hjgk3iKdd6bcoHgpausiF8lkFeO2c+euTKMGBm0fjrfgtbShgOsqCCca3JHoBU56a5bz+PLgckATc4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 16:04:10 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%4]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 16:04:10 +0000
Date:   Sat, 1 Oct 2022 00:03:48 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Honglei Wang <wanghonglei@didichuxing.com>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YzcTZBTF2H0udyk1@chenyu5-mobl1>
References: <YzUrITfUn96puCtv@chenyu5-mobl1>
 <a6e38a33-0003-d3ea-de9b-cf805aef647f@didichuxing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6e38a33-0003-d3ea-de9b-cf805aef647f@didichuxing.com>
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH8PR11MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df38bba-e056-4a1a-51b5-08daa2fd692e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AVQ6kxSgk+v/KHQkqa/lBmOasZZ5U5pCTuAtsIA9zJd7DDfoTk9mxPJ2bghKHXDJ5qLY7+rSepdyKhGOCDEU/4uZxZcfH/LTGGjSBE8D+Eb2nGr6zbpwtQuL1nY8/lxRLmL6e4AviDpDpysilwzhSsuSU62xf4w7bUZCjSQaJBU09lEkredAWZ1FT+mfMPmdNhMKRYMFSxuNuDMndqegALMbiC6OP2btY3RzCn6vSgusqsrmVrzxvlqXAnsNEvGf2A/fJGgs+/cxCUvkiKPoWqETC8mScgjeu228XwGJZVOrBTIPxLfxSJ0EJksaoDp8k9rOukDCYYy5cRqfPDpEX2Gt2VwkLa4/RAV2ABRtc5HTO7ZjIBFhzHI8htEtqRUHLDrRl7WH351eeYnPFfw8jB/tVv44DWb93Zdy66TYVUCNEAaxoKbSbqvEYNukey3vy6RnrpN/mPW1PLAHGMhvddn2cSwI1x5M8BDlAVKnswQKRCpwIC/S9cPzbWVClhvPsgghczIBjvQZY82QKBlYQXDm17ck5UMmgspmrj2tQspklvLhU4vOwAl8yJ6t+UIjqy8wUHbVAIL3J3FQD9qWxOKv2GX/MKkNyv9e6gEVBDkM5C38fA2AbKRu+rbahnCkzYxqvCBEEuuM68kBgkjhC+1sBFjMoQNivQYgJLlETv3sAZoE3UBhyS6ts+v5ph8E8AsMIpaVXdqtPjSgJv9ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(478600001)(66476007)(5660300002)(66556008)(2906002)(7416002)(53546011)(6512007)(26005)(9686003)(6506007)(4744005)(41300700001)(8936002)(6666004)(38100700002)(82960400001)(186003)(66946007)(54906003)(316002)(33716001)(6916009)(4326008)(6486002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lVjWxiFG7Y5+O4hWFEcd2b0P8KXj87GnqqAD17ydl1BRUg4s+fKmsTAejCUb?=
 =?us-ascii?Q?J+h+7/oAk0/wltGXS6PDXRUWIrbGx1PS67GgyT5ghNnwS9sjEKk7L+iearGV?=
 =?us-ascii?Q?zzpakncRrtwPAXhFlBicN4iAU9pAaU6MtgdVw4u8b0PuDx7vuu5C+q02hzdY?=
 =?us-ascii?Q?w32G8LY+heV/2RBg4PlP4jaTBVbG1pebferraDrBlEiKVeoYfpn8e64BfD/b?=
 =?us-ascii?Q?hnSQ8YPADqvIHcR+ONWTD8RXzf+K3Gu+ewxfdjJh9qqN1vH3PgkkYbVJQO8n?=
 =?us-ascii?Q?03OEQ5zQWaBi5DFjt+3WEh8YtD/SIt/9pueT36HOoa1SUKSSiiDuctPOBHJr?=
 =?us-ascii?Q?y1kLoOjq/S8gN2VMktUfUDgjatQm6kM0LxqCCb78YgFuAzILb3KNc+nM80c5?=
 =?us-ascii?Q?GEXoXOs8UqDWfT54+/IdrFGhWiivuthdd4o8dX6HrrLiqXpp1XiQR8FFmLcU?=
 =?us-ascii?Q?L3eo1zJsW17XmxJMfGAAnBl6GbU7kfxaH5hL1XUU0cNI24alQMuox5uzVWuF?=
 =?us-ascii?Q?jaNmzLfb5xGDJcaMfSlL6HFHLcpGWrcP+T7LPXIGMzwx+wMbSUupZm91Y0qx?=
 =?us-ascii?Q?op6iGi7dYLddGKSkGjNTCdbMONzcI7s9cGotPLuU/pBiS5bivIjBiV+uqKjh?=
 =?us-ascii?Q?c5FfHuhwhXSzqxFwgVNyuoJgJTFAnYOBF+Eyrlk7ek7kTznemfjOVakj3YzE?=
 =?us-ascii?Q?fJ5DPY8DSUreYQ+HY/BNRfMp3magdksconGZpUUnSO/KKTdBUUGto2cN9kFN?=
 =?us-ascii?Q?W2zpTj7FD0nCk79Au5I7MbWZYQ5dRV9dNpQu2q9yu5SMX3tv40hy0eNfoGpG?=
 =?us-ascii?Q?fCAEZsBBngry2wiF4tCWrzwZEaOQkGfSqeLi0JZpn52xoIas0E+SBjZDoCY3?=
 =?us-ascii?Q?Js4x0EEWPZKOw0g9SA38Po1got04h5Gp8PNigyoF7dduDQifppHtG7n4nlPY?=
 =?us-ascii?Q?VLvf2anGbcKueRF3ooZlStOQd3bw019Q/FBGBwtWY8YpPg6nbT2WNYD0QxLZ?=
 =?us-ascii?Q?yuUlT7vw/LAxnMdoCSnx2IIHjLdY2H6eOz/sqFLhNJ2ysOM7ifGJoiBNn+qP?=
 =?us-ascii?Q?xLZg7UxgkiV0pTiPEmEO1Og0H6WcRgNfFpfJHCKWZJFCnwuwTijKz1iDb4/r?=
 =?us-ascii?Q?SxhNvIjOM7pxBmBiLiOcEE8OwlKKggXLiptaF4hA0WYhvRx6+N4gb+WxfE+H?=
 =?us-ascii?Q?c6E9TLJS4kT9aM95qpTg8P6CDYkH2PbUOXapKDgS14GSG/bQEuM5DKx1eY/a?=
 =?us-ascii?Q?V7ywDUkBfHPPnprh2l/Gra4HKk88JeiwliWJNwgZXboTIhfYu5o67D8ubkI3?=
 =?us-ascii?Q?Tn8xP1UAfzMNV+Ts8Yc1ioJD9daElJNId/8K5JulmRduVlKRXAhcEDGCoofv?=
 =?us-ascii?Q?+R5aw4iqhnM5o96BPyHZ/eszZrHzZjkFf53KhwiuOmASXcdq+n4Fp6m87OMJ?=
 =?us-ascii?Q?qb9u757oRIDccQ66Snq+qPz8vw+zw+dYh9cJdoP6ngMHL9JQuvR/V9uj2xbX?=
 =?us-ascii?Q?yisCS61PeaNr9zbgRz5pIsyjT+aIRK3+ecba8c45RWAQhqzr28rKNIXl2NSW?=
 =?us-ascii?Q?bHttL7IxbyvnL/KEm44VOGNWhsxtkBAZm9LgzoKv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df38bba-e056-4a1a-51b5-08daa2fd692e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 16:04:10.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg6LkgglbqeD1M03GUMHROuJr4VUFuwlpkA/zcDvVwdI3eF4/SWiF45lgRiOqdv3GI/Znz36tC0lachkM7BaKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-29 at 14:59:46 +0800, Honglei Wang wrote:
> > > > @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> > > >   	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> > > >   		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> > > > -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> > > > +	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> > > > +	    is_short_task(cpu_curr(this_cpu)))
> 
> Seems it a bit breaks idle (or will be idle) purpose of wake_affine_idle()
> here.
Exactly, we should prefer previous idle CPU to 'potential idle' this_cpu to keep
it consistent.
> Maybe we can do it something like this?
> 
> if ((sync || is_short_task(cpu_curr(this_cpu))) &&
> cpu_rq(this_cpu)->nr_running == 1)
>
Yes, Prateek's experimental results has proven your suggestion.

thanks,
Chenyu
> Thanks,
> Honglei
