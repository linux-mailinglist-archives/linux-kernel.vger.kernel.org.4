Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCD70439D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjEPCwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjEPCwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:52:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3CD3AAF;
        Mon, 15 May 2023 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684205528; x=1715741528;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HCaV47MQWYdUvDWVCccqkxtQJi1ZN2SXupXgx5r+cL8=;
  b=aJrwkrukpXONomRioFH+4/brRMeXnSCBzwz6Eyeba09kSmkbT1qbOI0J
   DtXAwKZsw0FyjdtH3fdPOFdfAvhd2GH4bWlGYNLyMcGddbE5uhHwh/mlE
   BvDcRfjYz15EZ9oLoHqaKEAJVYYMlDnL8WJPEnadgpen1OHkJ7wpd69mC
   cjwEUiZ5gDhTksZSHmBF8jMHPs8lwobnigjTygfBj1ip82xf93MBVl0Bp
   dGn4OPLZ8KoR7LYunYOaRAlLAP0ReyffvPAf04+5ikBOINO1VJgsADcmn
   3MTyym+fvnNPau8J1kNp/XgGGvLYz+m7Xg/PlbP34kpcusP4+umcr0XKC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437705786"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="437705786"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 19:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="770857786"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="770857786"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2023 19:52:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 19:52:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 19:52:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 19:52:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 19:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUWVEyxQge7Up6zeIjgKbMsv3PPnJzQVk8EMJ4rv/fyRN+KaHElEJ6Qq7aJy49lUoTFPnxFgFmUtRhPKHOWOwW5hbhHn/kO/FwQ/JRu8Xn1xzCHe3+eO0iF16OCqI9hhxq9Ik8bjqmQRNWy9AwY6xystvboccc0Qg3lBvjBdkn4XCBf3VZ9he/mkhtGRDhQN1prd48fjMH9E6r5s1LP9A/pNM0wvfPTyHXyEknxSdcyboQikJmy7n4vc5C7G6DEVwBrAAOPDHX8fSFy71jAlFVMyTlnHTwpSGJICt76BAEy8RVa7i8iZoeKIEMHZdG1TLerxnGA1/0zHJyt8FFXHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cto+8XIHXjKnjzAMh3hQ3OV1CXLb3qTl5tMcY2Bm2tg=;
 b=FN+mOZsJRmz8vpyBKuEBJIsMhxUWtanyGzFf5hCLvb3FKU/xAf84eBqvN/ycCceHeCZ7i5rRiyYCEmPtSOXZCCnHetwASEFdZlNg+wOFp4PfKjtU1Tn8DtOlZcnxsFsHaTvx4J0W4sssYVUNz9YowIVdDo5qNCCz0iboCJYzGuTWFRCKMDPxGpkzrJMdjTm7JAtY9LDCXiG1+DmRGHmq8kxJPTitxS5MLT7Tu4uw+7xKDzbK0ALFmy/aXJPs/p9y/r5Zqc4mkxjoWjDFtkTmyHn83/OZ3fLr+B/6firvp4bXL0pAnCSwsyGWlAJoGVEpWuLMcYdBjwIpv8JbY3blNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:52:04 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 02:52:04 +0000
Date:   Tue, 16 May 2023 10:46:17 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     Oliver Sang <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <ying.huang@intel.com>, <fengwei.yin@intel.com>,
        <rui.zhang@intel.com>
Subject: Re: [linus:master] [xfs]  2edf06a50f:  fsmark.files_per_sec -5.7%
 regression
Message-ID: <ZGLuea93wBdzJipX@feng-clx>
References: <202305090905.aff4e0e6-oliver.sang@intel.com>
 <20230509065433.GT3223426@dread.disaster.area>
 <20230509071053.GE2651828@dread.disaster.area>
 <ZF3uXe+cjAsfCLic@xsang-OptiPlex-9020>
 <20230512230504.GF3223426@dread.disaster.area>
 <ZGDyAOewWqjY5xvJ@feng-clx>
 <20230515222034.GG3223426@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230515222034.GG3223426@dread.disaster.area>
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: d166a7e4-c482-4ef0-eeb5-08db55b8877f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82SQVs3UXX1/4yWpb3k1OjZsKAE/RWcS8kw3GRosid7GK6elxVQD6yGGNRV4aCNLmEocAnrySC0tKTI1O0cMHub0FuY9844HnR7ph5HeQ4ObWOiVaiUtaFhWXJlyGrExu3ltvmRBZGziyMl4eu18T2pcfHZRuWTJwAHWqRwZs4QQ/M3SXvgo2NogpP+rB5kGXYpAMz1cj1C1qYDi55fmSkEkP8SsZoijEk5dUDh29K7l+4hN9/RLeU3bxgl6yS0N42oCOP1xbJJ4ypZdzP/f9i833yZC1vuQUUB2EBgpcN54zk2g7rPf9FXq0bXoye+IrHAcDG09bJ+EaVL0Fnn3CQDCoOtJ9ZaERjD7UIfTvVn5R7VhflLfPfBxwuCbhDUpp3Gemi80ajZd/ym86a0qAc2I2/htxJDurlgDdniBDsC4Yg0a4BOldYd+CGasuDZ06Iuhl4It66G9q4gKPcza59s6F6rn2JUHZvwlRf5QbiSJvYF0JfYxzFmm8IU4klx025Vl+YlPCVtvjHiY8L3Zog1Rft6pgaxjH6HNR2ak+xUZ3OK11KVa3u9+fDz+25Os
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(316002)(54906003)(110136005)(86362001)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(8676002)(5660300002)(8936002)(33716001)(44832011)(6666004)(2906002)(38100700002)(82960400001)(41300700001)(6512007)(83380400001)(26005)(186003)(107886003)(9686003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vd/UzFtnx1y9egayuj6B9N5ZDMkXaEQVJm1w+mCyOXGEdIiYUiQJI+EGWkwp?=
 =?us-ascii?Q?VoNNz300VsmWmNRO92fQgiZaLqahgOTRFM9/RTJkf+PrUtlz3u/6phRvbkMm?=
 =?us-ascii?Q?723f9iYUqEkBT52BP6OikmzDOjbShwBQU/LcKi+B2RotQy4B4rXywD+1hVBT?=
 =?us-ascii?Q?ucezLrpedteqAzMpXIfgeOV69QD0b+/PCdy4ieTTcMcio5fjrVVXbhjR8TSy?=
 =?us-ascii?Q?gcLMDS0odhX7G7KZIBWayCk7wDTP93koN15k7ui26g3kglzP5F3KwXY6+Q3L?=
 =?us-ascii?Q?AYhN4OJvclA9DuSpn94S4+mzR/xawMDe2Y3mAXZzHkowZjHK5JSftA2d+bvG?=
 =?us-ascii?Q?UujLWe+rTaGBsMjOrRcYfUzScDYF1OFOSXO89+hj8rhgrPFWUNfq2gYBI3VG?=
 =?us-ascii?Q?HWTTYJfIjAeh5vg6G+UoBMwNNHXNj4jzFr2rxR8OOU8UGsY1zwRmRNu8Mn5B?=
 =?us-ascii?Q?/NeL0rjc4/aq1ATe8Tl/kfhfilOfIquMu26oSLPW9CAwbDTYnIhkFoh5AS9+?=
 =?us-ascii?Q?PEVzlR+H1UZsWNuCvv0cMO0EAfnI2waGCq0TxiYLW3VsLfMZwQtPBaKvFIg6?=
 =?us-ascii?Q?0j6QlMoDPKqXoE6VF6enlwbU0cWUMPgVc/LTipTjP922vMCmlYzfY3j+4W17?=
 =?us-ascii?Q?uFsHcZfwPy5xNHWRjT+pj9jnDIHYxMLyezh0g8c8Qf/A8w4TiFUfaqT/splB?=
 =?us-ascii?Q?oe9wVrBCyhfr0TMFfO0s91VT/7m44v+qqfY4PXysCY0YHDcm2BWejzF1ghWk?=
 =?us-ascii?Q?sjpsAD9Cyzj2hyGSreHaNKGAxuZsLP0XwbHm+sEv84yyfkSY6o0fxm//RFLA?=
 =?us-ascii?Q?KuTcsQmCZI2KlCAuAjezM7xktQbh5drnWy4as92c3xCmdESQa2R60rw2rfdq?=
 =?us-ascii?Q?TGJI7nV1w5mQSVczxsKPc6Pnb5qKvHO3jtDBAUE/rLkEDRCj046cZLHk1uSE?=
 =?us-ascii?Q?ooPSHhIUGaxiWOwf8KOBQJYUNGptJCRK7u9lAbHVTwAcXkFZIy/dhBox4cWS?=
 =?us-ascii?Q?NEyhhfs054fGi0Y6mhWlTWeEo9kAwHq++3RIzD0mbxsxndrd1J+o4PYRY7zd?=
 =?us-ascii?Q?s+PMuatt+VGkAS81pWT50JQQUGbr3mbSxkaxvmQaoBSpM7Kul8lxiFcEkNlN?=
 =?us-ascii?Q?6eq3m4fPROzYx20BMW5qlq+OC9bGgW9pT/jB9xtBDr4Q6q2aN0CD9K54HvE2?=
 =?us-ascii?Q?cWtM0b9Bcmdx+GKwwF4JFCQSA2+3hYbLAyrkDZTvU5M0+ggtVsjCAqleekYz?=
 =?us-ascii?Q?Ep52cYnGlg/BfOVLU23C3712g+bQMb7M0Cke+g9v0DM8JDTACYZSqys0FLV7?=
 =?us-ascii?Q?tVZE52STuYGg/b4MlFfrfoNCjubFlwrawn9Pu2/j29xo0br5oYHpOD/PANlR?=
 =?us-ascii?Q?HyGM1vskl+qZCU/QvMioyeX8CxesKVH0sLFEHYswQS4ueUnp818ZyYKu7bP9?=
 =?us-ascii?Q?xoAOrW7RUUPcTY6/boqZJLrDjcns2Lu1WlCVSqf0MD24aRtfTNT16P2uXi5K?=
 =?us-ascii?Q?yOqGtGC0iJiWiRbP0ek9SNIiM2ILJGDNLFZFZr4gGU+3cMcEMUW8LEROfAL1?=
 =?us-ascii?Q?JTvV8Yh7ORR3i+NwltfetqceJgZYnch8D8lr2xF1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d166a7e4-c482-4ef0-eeb5-08db55b8877f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:52:04.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 875otovou7wyHvnyJ+ZC66roxyIrUjZX6NARTOZ/elAXskGZztK81GEVdCm1KxNMUzL+vzgf/82G2NHtVnN57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
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

On Tue, May 16, 2023 at 08:20:34AM +1000, Dave Chinner wrote:
[...]
> > 
> > For commit 2edf06a50f5, it seems to change the semantics a little
> > about handling of 'flags' for xfs_alloc_fix_freelist(). With the debug
> > below, the performance is restored.
> > 
> > 
> > ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4 68721405630744da1c07c9c1c3c 
> > ---------------- --------------------------- --------------------------- 
> > 
> >      14349            -5.7%      13527            +0.6%      14437        fsmark.files_per_sec
> >     486.29            +5.8%     514.28            -0.5%     483.70        fsmark.time.elapsed_time
> > 
> > Please help to review if the debug patch miss anything as I don't
> > know the internals of xfs, thanks.
> 
> Well spotted. :)
> 
> The relevant commit dropped the trylock flag, so the perf regression
> and change of allocator behaviour is due to it blocking on a busy AG
> instead of skipping to the next uncontended on and so all
> allocations came from extents in the last block of the free space
> btree in that AG.

Thanks for the confirming and analysis!

Late yesterday, I added trace printk in xfs_alloc_vextent_iterate_ags() 
and it did show the flag has XFS_ALLOC_FLAG_TRYLOCK bit set.

	fs_mark-28005   [016] ..... 14993.945487: xfs_alloc_vextent_iterate_ags: flags = 0x1
	fs_mark-28004   [002] ..... 14993.945487: xfs_alloc_vextent_iterate_ags: flags = 0x1
	fs_mark-27986   [006] ..... 14993.945497: xfs_alloc_vextent_iterate_ags: flags = 0x1

> > 
> > ---
> > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > index 98defd19e09e..8c85cc68c5f4 100644
> > --- a/fs/xfs/libxfs/xfs_alloc.c
> > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > @@ -3246,12 +3246,12 @@ xfs_alloc_vextent_set_fsbno(
> >   */
> >  static int
> >  __xfs_alloc_vextent_this_ag(
> > -	struct xfs_alloc_arg	*args)
> > +	struct xfs_alloc_arg	*args, int flag)
> >  {
> >  	struct xfs_mount	*mp = args->mp;
> >  	int			error;
> >  
> > -	error = xfs_alloc_fix_freelist(args, 0);
> > +	error = xfs_alloc_fix_freelist(args, flag);
> >  	if (error) {
> >  		trace_xfs_alloc_vextent_nofix(args);
> >  		return error;
> > @@ -3289,7 +3289,7 @@ xfs_alloc_vextent_this_ag(
> >  	}
> >  
> >  	args->pag = xfs_perag_get(mp, args->agno);
> > -	error = __xfs_alloc_vextent_this_ag(args);
> > +	error = __xfs_alloc_vextent_this_ag(args, 0);
> >  
> >  	xfs_alloc_vextent_set_fsbno(args, minimum_agno);
> >  	xfs_perag_put(args->pag);
> > @@ -3329,7 +3329,7 @@ xfs_alloc_vextent_iterate_ags(
> >  	args->agno = start_agno;
> >  	for (;;) {
> >  		args->pag = xfs_perag_get(mp, args->agno);
> > -		error = __xfs_alloc_vextent_this_ag(args);
> > +		error = __xfs_alloc_vextent_this_ag(args, flags);
> >  		if (error) {
> >  			args->agbno = NULLAGBLOCK;
> >  			break;
> 
> I don't think this is the right way to fix this.

I see. I understand this commit is in the middle of a series.

I should have stated clearly the debug hack patch was tried
mainly for debugging the regression.

> The code is -very-
> different at the end of the series that this is in the middle of,
> and I need to check what callers now use the trylock behaviour to
> determine how the trylock flag shold be passed around...

Sure. When the patch is fine, we can test it.


> > Also for the turbostat.Bzy_MHz diff, IIUC, 0Day always uses
> > 'performance' cpufreq governor. And as the test case is running
> > 32 thread in a platform with 96 CPUs, there are many CPUs in idle
> > state in average, and I suspect the Bzy_MHz may be calculated 
> > considering those cpufreq and cpuidle factors.
> 
> If "busy MHz" includes the speed of idle CPUs, then it's not really
> a measure of the speed of "busy" CPUs. If what you say is true, then
> it is, at best, badly names - it would just be the "average Mhz",
> right?


I found the turbostat.c in kernel tree tools/power/x86/turbostat/

if (DO_BIC(BIC_Bzy_MHz)) {
	if (has_base_hz)
		outp +=
		    sprintf(outp, "%s%.0f", (printed++ ? delim : ""), base_hz / units * t->aperf / t->mperf);
	else
		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""),
				tsc / units * t->aperf / t->mperf / interval_float);
}

Rui Zhang told me the 'aperf' is the actual cpu cycles of a CPU in a
period of time, and it only count when CPU is in C0 state, and will
stop counting when cpu is in idle power state. Like in one second
interval, if the CPU spends 500 ms running at 1000 MHz, and the other
500 ms in idle, then the Bzy_MHz will be shown 500 MHz.

Thanks,
Feng

> -Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
