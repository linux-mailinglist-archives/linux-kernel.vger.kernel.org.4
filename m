Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E973707888
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjERDmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjERDmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:42:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72A30E8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684381337; x=1715917337;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qVZTJDeU2Minncpt34dtRmxyKt7MyI3eJ9CImYKwhUw=;
  b=NCWrE4TehcY3d1j/dBMayw7YNVZjwrsX7OU3YwtwAJMyfHnFbhJo0cBM
   DgLwRUgcbb5AxC1Var32A3BT1c+cxGGmTJBzGnG+aRcVxbPbShkMQjsbO
   t71AyPWYYoH7f9EyYinTbmRGAn3B2BWfuNsQX4FWS9vKRQdo48vnHyph9
   fK5qR8eRC6fGXdxPWy53nniOWx5wqGjkIlpSDpJoZ5aYK6O01JWLCxJDt
   jwz3hD41+hj8tAo/TDrybyBrMgp739Qr+oPJnmQZ+E20aMcq0neCqgkng
   LD+iD5XQxJL3fP9VPOkJzNbqB3R2GqAR+2vs9usH8h/k1gWLTsOXc+Uvr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336517326"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="336517326"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 20:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="814159717"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="814159717"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2023 20:42:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 20:42:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 20:42:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 20:42:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 20:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz0pALDyWZ6UmBJlwTT8RuAo38gk8EwLmZze6dKclcJmbVpBHyNgE1XnXKcyASx0CvqswZQhkwGsORaHTE5lncvIYDIFPJLAxM2aKBR+YgrMrILE/1wti7n38Mm/g4ZfTZcQVZRQoJ35odcusKzZefgt4qjlaVRxHLMIw7vb6sXK4WnIPWVK+fAk8sq+eiLkyon+waEJOIues4IcbyEvl/GsPAbUAIoI9LMSvrpRy5Em3kw4V0cmNEC+HiNaWC6AMgbnG7sMem9jIR8ThMN7ja8RaXICQk342aU/s/jaHwMUqme1vIDhAlE8KvXM7TehmkZ9CbnMqkUdVB+VGHbQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HQSwL/VjwZLKzTnkymt6h6GrZNTHsaTma9Ttb6GZUQ=;
 b=OIKQHBzfAkYEob/7ze+2TWGPHl5OvNIvXkXaFOOKgvoBQLkFh5seEN/FpnrT5BV22yjL8JVDg10cUtjkm4PvCgNFbGrmmZSVDU0fnFPRxBwppll41y6KYZycPM1iy4VdQHnQKgplviIDVuWEoqgB0RBSG1romWBBuz6jiXgpDBoWCpBCsr3dZmFiaCe0ZXeCCWo0DaxKHhdtwKiog5XWTs8ohAvimi/Ih8xen9FHT3DY3DN0DE3zsobQKp03GiB8R3Qo0ouxV4k914lXO2Veifq130s4e4gmSgexIM8ppv8ysYE/hwQZl8LiEyCDzFeGkuwzB1YgtT7Imm5Bskdvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 03:42:13 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6387.032; Thu, 18 May 2023
 03:42:13 +0000
Date:   Thu, 18 May 2023 11:41:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
Message-ID: <ZGWeg6UaZ3WJ6ykI@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
 <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
 <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
 <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
 <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
 <a2a4cd5b398390dcf01b800c964b80c6eba89d18.camel@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2a4cd5b398390dcf01b800c964b80c6eba89d18.camel@gmx.de>
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CO1PR11MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0caf9e-79c8-44ec-c668-08db5751ddbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dUAYw3lfaS7+CFflhg4A6QEcNwr8xw7SIOejFMorop7P47oHGW3y657LFlnZwq9KyvCvXixGbI6PHCGNCyTDEkqzg58BZ2DmM5u8LYHITSQ5L4uf9G9q/o2Do3Lq0QZQp0MKMKp61baFRJd35rMHQ1ivizj+sKkEN09OsbiiO1dDm72LqAOnY4C+lKjnOHBsCpVvKAFmhCndTpMkk4HYRqVE0/vf5S1B9OXmJCrsLyxH00SPAmyNk6kstSDodcDb/x+5DAMqLd1HRzi4uld7ADxMEQJtE3Xt+uYEBKWAgTVfCyGwz5wkHleMm+n7NCMnuIlATd+RBL3gSg0ypc5WzVAVA1P8E9AicPEuqLix+q8jBxTfRxL/XSzLdWEduk2zwgmdV9/D2AlNn0Uy6h+f3pjn3VKv8klQvXCsW8QqvRQDbxLCsnhz13BcAzQcpPvG44AWasKbZfom2BjKrt4TcpDUlMRQlBTTsko9htKG4YXRYeL+DheYTEgu8utInG9sFYg9Tuy1crRiGUhC4yV16mC2n14Ihn1/nctsletorz+oPFD2G6RDHZyDzRbl6Cr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(83380400001)(6486002)(478600001)(54906003)(6666004)(186003)(6506007)(53546011)(6512007)(9686003)(26005)(8936002)(5660300002)(8676002)(7416002)(82960400001)(41300700001)(6916009)(38100700002)(66556008)(66476007)(4326008)(2906002)(66946007)(316002)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AikNVUaAYHlEAYt4csl7sKunlhWTAvcz/dCl/KmlJib1cGkSPdD2r+f/ga?=
 =?iso-8859-1?Q?Utw8NjWhG6Jx0eXxhxOAPCNgbmNutRJVeovFG0GNoa6kICZmsgNpX5ZTey?=
 =?iso-8859-1?Q?gkrR7jOsDQ8csJ9CKHA7VLW5j178TG0Xr33lu1uABADGYOvXBOOYTop5+b?=
 =?iso-8859-1?Q?ZNnEjSsgnkUyubLOm5ETTm6o2xNQkaT+53E3oRp0Jg2oBEhWeGOByuowIO?=
 =?iso-8859-1?Q?MAYyAHJATO7QHtWS1VodBiXcI3zNeUx1tQcnoWMqVZzcC5P+qxDdBTU9SB?=
 =?iso-8859-1?Q?Tu6iXmhdedkeQ2k/woRD6mWj0r7J3XfUvql1NPzomRXYiUaM3Z9M29NaJO?=
 =?iso-8859-1?Q?GdUJ5I+flDP42HnEjE3dSy2eem5rK8aiwwrOVe4rXTMV4Coe2AOB6r7r2/?=
 =?iso-8859-1?Q?fds4fWMXHOc409+/STDTRsWrqOlM1DqPV85Ub+ifim7n+c02qLkM/IE/Ah?=
 =?iso-8859-1?Q?QIn3UJCLIBSGuYfYy0ZuDDLs2NgRnHBLb9W7UMDCYfTsUVlQ+5DzNsguUj?=
 =?iso-8859-1?Q?uVEjBMlCUOLg+D7H1u2MXZcrzOtuecVPaV2WDdp9bz7WMnes7LUZfXNwhx?=
 =?iso-8859-1?Q?SJwqP0FVDiQBQG+OnpzI7XBsdKtr1jtlunv0oFYZBo05mGPea4jpUhK6/z?=
 =?iso-8859-1?Q?BNnKYlmDsUXfQAK8xPwe1bCVmg0Yq1gSLKmqKuN2CyEq/e92LsfDjpPszP?=
 =?iso-8859-1?Q?5C8wuqtJyQUQCWyuN/MqD/7BBCwgmPLJeSE5vJ+zRbFr4B4r4HXp6CS/Wl?=
 =?iso-8859-1?Q?rO5Y2TVGwQq7BJp4V2/PAfIf8k/fT0DquvSr5iuNLqVDF+V2SHcOuif54Q?=
 =?iso-8859-1?Q?XnceZ6wR53Oyc5pKOkprJmWEXEfEnQre13McoeAQSQrorWsNhA/Y4vQ6/R?=
 =?iso-8859-1?Q?RZe9ENRzcVPMWmfE1OvGxC/IWuSlgo3gVt3i9sWzGmM2pqk95bbzlwr0HY?=
 =?iso-8859-1?Q?pIfI5ZguEJb+mCXXbBwbvoV5uRAt3uVrrmuYX5lx6G1ftYvFbpllkZRbHI?=
 =?iso-8859-1?Q?iJry5WDc7NBiEd7a+0lomIaDiX/PK7SU/fVZ3qKI4xixZzsqxUi+6J2T8k?=
 =?iso-8859-1?Q?lCKLjQMq7231CydR+nIB+Ke43FygfvGIUcWxvN8YKbMNfhrJ6MTPN6COoq?=
 =?iso-8859-1?Q?YBHtHIIutMQYSTfkyQ/sB/TES5Zk1LcIn89/0IFZhxqUtow87bQrDaPFdK?=
 =?iso-8859-1?Q?zy3RtdnNsmhIj3oDpyYJcGSK7Wu9ToshVx7Zzilj5spsW3KtIQ5OfrpONL?=
 =?iso-8859-1?Q?tL1jALPpTXhhYcxmiyVTFxvnCet6YKHn95Cl8ZegvVsqnktj86SMbPSw7b?=
 =?iso-8859-1?Q?ddbGG4q6AGuqTSapG1qkiz+J3d3vECIpNIhmc38awxGJjU+kXiDOpKjXth?=
 =?iso-8859-1?Q?eZbgva/1pu70cuCkeqrltxpn6fZh0wD8RSSZKD1yc959s1a1U5u6jHZyFn?=
 =?iso-8859-1?Q?kaYZFhjisV4OFVSnSlcs3dzY1jOu6LJZgL6NEctVFnzxQPQ1lQOJ2q0FFQ?=
 =?iso-8859-1?Q?Fh3Xf8kHy7jhXTyqGZ5XXBsNnsAm9nsqjEHFzohd6DnUKpx4U7sueRVlof?=
 =?iso-8859-1?Q?6XAIgduXHfFw7Z+bPX1yAokPUpNw9xeETQ/57BjD8MfSngJQ6MOKbc0iXs?=
 =?iso-8859-1?Q?/9JU9qUpDFTUan5MH2kGB9APdFEvbeb+vC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0caf9e-79c8-44ec-c668-08db5751ddbd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:42:13.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAzJP/7kDtigZJCFYJe3zU5EOJvlp0JGZVjxCtwUY6OrEgtCXldyIirME1XZfqhOAzIUSlJIGd1/BHc+nd6mFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-17 at 21:52:21 +0200, Mike Galbraith wrote:
> On Thu, 2023-05-18 at 00:57 +0800, Chen Yu wrote:
> > >
> > I'm thinking of two directions based on current patch:
> >
> > 1. Check the task duration, if it is a high speed ping-pong pair, let the
> >    wakee search for an idle SMT sibling on current core.
> >
> >    This strategy give the best overall performance improvement, but
> >    the short task duration tweak based on online CPU number would be
> >    an obstacle.
> 
> Duration is pretty useless, as it says nothing about concurrency.
> Taking the 500us metric as an example, one pipe ping-pong can meet
> that, and toss up to nearly 50% of throughput out the window if you
> stack based only on duration.
> 
> > Or
> >
> > 2. Honors the idle core.
> >    That is to say, if there is an idle core in the system, choose that
> >    idle core first. Otherwise, fall back to searching for an idle smt
> >    sibling rather than choosing a idle CPU in a random half-busy core.
> >
> >    This strategy could partially mitigate the C2C overhead, and not
> >    breaking the idle-core-first strategy. So I had a try on it, with
> >    above change, I did see some improvement when the system is around
> >    half busy(afterall, the idle_has_core has to be false):
> 
> If mitigation is the goal, and until the next iteration of socket
> growth that's not a waste of effort, continuing to honor idle core is
> the only option that has a ghost of a chance.
> 
> That said, I don't like the waker/wakee have met heuristic much either,
> because tasks waking one another before can just as well mean they met
> at a sleeping lock, it does not necessarily imply latency bound IPC.
>
Yes, for a sleeping lock case, it does not matter whether it is woken up
on sibling idle, or an idle CPU on another half-busy core. But for the
pair sharing data, it could bring benefit. 
> I haven't met a heuristic I like, and that includes the ones I invent.
> The smarter you try to make them, the more precious fast path cycles
> they eat, and there's a never ending supply of holes in the damn things
> that want plugging.  A prime example was the SIS_CURRENT heuristic self
> destructing in my box, rendering that patch a not quite free noop :)
>
Yes.. SIS_CURRENT is not a universal win.


thanks,
Chenyu 
