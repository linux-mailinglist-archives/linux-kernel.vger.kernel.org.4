Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C653615C12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKBGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:08:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DA12E3;
        Tue,  1 Nov 2022 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667369315; x=1698905315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5Neyul2FZ0tSljpa7oIiLgr4Sg7PbAWADh6Vxf0O3So=;
  b=j7by7t1jphqCFpbZ/FgVIqjFnH2/DyAK2eVdIPBDXo9FbCqJ8CUruEl7
   BhjrUdc61V4Xp0nM6OjNBtAKyaaJudhTVhIgx+VOLPVxhuBJL+9xvPZBu
   mDA7yY8hZKXRwPHSlYoyBWlNWz4Q1xjnqNCeOhJdoMMYA1i0UW4X0ZWSC
   mApfoyyFVmDGnzhg4CTj+6yO6mX1pctGs0xZ0NyZaXOW4BH7ArQl9dbsl
   XhXFwPQ4n7XShQwtY0vPjgYmsIjaGdmoh3IQOODqcn82BHf64hkkDLzVB
   rnoGgiSXIHVsjTqrD3XKGofumCbfEXYpitVISwZ+2vPoCGaCR3nkU8s+2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="335997286"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="335997286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 23:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667459649"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="667459649"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 23:08:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 23:08:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 23:08:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 23:08:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 23:08:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ4BExbTP+7QxQi+D2/xFjAp8DWWYLd0/+lMVKV1YsffgmXq7AOeq0LjsYI95YuGWDcHz6ha/m0b5/Fbv1I03hOtjul7J7WjRikQcvwAOtbAx7At7nI6Gozo3FK70yJPr/KsTALgy+xaM85UUHRPyoO0iO2qnVefqBICiuyuxLSxFl/e57WzF6o9N2kB2B8R9smQOWQm4AEXS+at8MY+tZghw1ckN9LKJ0gqLwFv6FnDkMU81vIwq2ucDnASR3r76hzGBJ1iOeNgIHPB/jRfHaOQWwhukfu1yuSqwztTv/C07W2M8rUP5mZlvhHw1XAG4MA2fWDh5OUCx1kA58wWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwVKyfrDM2/VKFSJiauyEaMo1hVWUjs9VLYTmad790c=;
 b=g1CW5IurAAXDHbmFmjW+VDyg6CLmE4H7WPpXnMSLzVSYH1mJT0ugwAQbsEh3SGqVU0gFo+55pSdfadG6ZXUZOAB/qvbREWTBstLvam5e1Hrq+C3NUr7zosR55PRLt+lgZ00elFrvtv0AVSDnPpxljUiECu5sZiWYcITwXMyhMbQjAWqpJNP9x4P6QA0/QVvo30a7keP49lbEmizIi/mNZxXhx++PH1WHQujgTbzB6lFXpUxKDdHyIPcribwW3H+bnOXI3KYZmT0cItsFKXflKs6BrwHLsJyK23HwIfoycTrxezmDLcp6jT4tqaWBzhSVBq76hqM//kfAm0SOT2+5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB7539.namprd11.prod.outlook.com (2603:10b6:806:343::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 06:08:19 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 06:08:19 +0000
Date:   Wed, 2 Nov 2022 14:08:09 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     John Thomson <lists@johnthomson.fastmail.com.au>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y2IJSR6NLVyVTsDY@feng-clx>
References: <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <Y2D4D52h5VVa8QpE@hyeyoo>
 <Y2ElURkvmGD5csMc@feng-clx>
 <70002fbe-34ec-468e-af67-97e4bf97819b@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70002fbe-34ec-468e-af67-97e4bf97819b@app.fastmail.com>
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: be047180-fbe5-44be-cdf3-08dabc98a39a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGFrTeW/j9laA6URe3x0a5f+D7OzDXEnV2W+MwnZ9rTdlr9QMMbfxxbsxtCJTuUip6WfQT7GFksxfQr1ODK5FgQ1cjv4qtTbVgO0BshdZKNJdUBOdIYyycctIYk0UWxdqXZC/7jKpIEAUL7MWIZ71wVY4KApytHhfnuGtmX0cyk+FvFys6clWOjHxF3+l1bMZSIIVz1Whhqz7Xu6jBb/yIVem68RpZy1v+zTFn08r8kU9XNJGjC4BD0kNwYw223rRDt1kxkE+Gp4006IkQQvXtvMM0nruYfa+RxmAUz5lopcgLjrX38H0W9N88h0PrBPJWLxtIlyVpLVxjUyaxtaIBOYEMEsJyvg5JzH6zpMD79KhBeqos12i1BWv7WKWc/IFEubhujUOxmuJqAH4IY7itdTjB8uAVFmmFVWLRPvYagGkS3UfcK9H4L+hVxjIpntE/6ZG00Taky8BtNWsfT8p7cflNS4knjle3ABF9YHKWTZ/O1clbXZSInkWiiXIJ2vZHDR41RoJfc8r6/rzjxnVSFY9Rkflmgqp8pkBDb5Q0S1chlkWLuwNg3GSocCPvbpwog9pZet0DfXGqCPbwOKqTlizBAEtdoknhxpniiS7Znfy5jMM4ou1TySlDZwybm7XkiYgLWuKOgjkfXyKOW0iNw8Gdyh1pKQLcn/KUKkqbH9runrsYR1F9oHPvwLYiaHbGv809Rlbuknk9mK00bkQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(6512007)(54906003)(6916009)(66946007)(66476007)(186003)(316002)(8676002)(4326008)(66556008)(6506007)(2906002)(5660300002)(44832011)(9686003)(41300700001)(83380400001)(6666004)(7416002)(38100700002)(86362001)(8936002)(478600001)(26005)(33716001)(6486002)(45080400002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rExGpGzkDnpE7/CvZwenKFu5oAVkNscczSfQEy33iQxvEfHqgCyUjsxI96Wm?=
 =?us-ascii?Q?s5Te9CaDMyl+OCIop3DTRrTigJ/ytJ/1/8JbSuxUq1HwSxE8i190RLXn9xPu?=
 =?us-ascii?Q?MofEPH4LTO7q/qLaIyON6GASW+6Mz8Axty36DURclwjJJOMKOcCLrnWpimT4?=
 =?us-ascii?Q?v0XncsJz4VQYEKCm0aY0+3eEYTuwMGK/zBdtbXso+GgDsnJKPXdFnyu/bbJ5?=
 =?us-ascii?Q?2kurLHG4SEb3Uib6Ndp91ecdPKg2bDJE/eqzL0V22B/hhaUulwrwHTFfjHBr?=
 =?us-ascii?Q?4Zsb5239TPl9wlcWjtHz/VNJOV0UpjtIyb9MqVMc8lzqOl92d6o4BIhMIwzy?=
 =?us-ascii?Q?VFeZ4AhwZe3Wi46d6h+20bLGuFeh2Db+5457IETMbc+8Tyk9/8uv6AI4JxlW?=
 =?us-ascii?Q?bA5mkx8HGE7FYmIRF8UYB3ZtF0Lh2oFN/ELXRmeuAqnEGlJggMyspWmk/N0j?=
 =?us-ascii?Q?ktxLl/otZOJ9FRpFH90Rv6OzEO5vWJaUzXik0afRT4R3s7tEGdvgv7YfC6Kn?=
 =?us-ascii?Q?bz62slFqsMmTAnnQc3EUWwVAqAtBVko+7kZvLLTRb0i9HE8Mo3v4E6TyWtUh?=
 =?us-ascii?Q?RiAstUn7MOHY1eSlb4U1UgAaW/Ae6H4k8EzDCD1Pzd2vTXqBxFegSt1YzHOh?=
 =?us-ascii?Q?ga1ZHHKAr5orFNnqWqWufp6iq0cLd0H6or1xFCRZsR6+oqQ5VOH4R63NrhJP?=
 =?us-ascii?Q?VzpkZN7a4qLjiQ53W1XhjiI0D/WIYJ5j6RVSnHQHYq+eRzNtuYr+u/trFECL?=
 =?us-ascii?Q?S8ykcnfbDbw8e13WBl0A47mfYyNLRcT+c0VUMXyWnJp5oK9tfMfmkBwSoufv?=
 =?us-ascii?Q?5QaAnvJDZFcp1z8rQX75/w6n25yFl2wzIVFh5bY2CDRUrE7WJAHO+opUxy5A?=
 =?us-ascii?Q?vlT9oteNrBki8UGxZPtNKGGbteBVplg1iHKcRAod2rlOySLRF/ObatJx2zX6?=
 =?us-ascii?Q?LdJup3oJIbGaIFjrWHcVoKcLBu2pXDnXDMN2JWMVkRSBeM6cA/8LlY+6WF30?=
 =?us-ascii?Q?g97x9pBFIc70bhO85NoSwcRNqeeU3i/TOwU86HchAH/b1/dzGUn2FBNs3YG4?=
 =?us-ascii?Q?e2a+LAsDORKKE3nuaDz0Gno6Zcqe/l38bv7JkT58+PP+vWZsMvwY4RoR55Gj?=
 =?us-ascii?Q?BQ3WIJnTAGDBBVxf6TzdgVpaH/1N6VgTfIre4YCLo7J43HbRmPD6SCzSSfK+?=
 =?us-ascii?Q?P7kJjhaWcmKWdxKmwOF45NiC9/IZTXLRcidUwo7kvBbmeZ1d61wU1cFb4ywc?=
 =?us-ascii?Q?JDUwzsgKiLl05/Zu6SGdGRsI2m4GDDr+zmMLUfY4LsMia33Uq0rgP2GsrrR1?=
 =?us-ascii?Q?6485X7X+IXG+hSPyVsPGP/goJZCpDdXYHJOXnhmyd71yH33Twzg355ehqz9Y?=
 =?us-ascii?Q?OP/aF7s4cOpRqjTGyTxsBO88820gW4B8RAqwCIMsYM1gkzpQewT4xUOFZvAU?=
 =?us-ascii?Q?K7i1OmRfTMyaI250As4isgms1nN0vRnanUYLmk3GW0gV3ZkFkc4MSK0t6rXk?=
 =?us-ascii?Q?A8WJzvf4qmmHy2Jb5c2K5SRdPF6wAjP7d8ErLYXXoAtUTIG3eTjFvo5aHAfI?=
 =?us-ascii?Q?MWB0U5zq6BTpiOJkNcettwxfxttpSMI5aPSF6YaU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be047180-fbe5-44be-cdf3-08dabc98a39a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 06:08:19.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRK2te3iSPimRnxNIvF29ueW8qttdLsQ96owgSKLzBOck6CgHQr3KZJHGrVUrsXHadOvhkQpSPdMH/c/c2bX/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7539
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 07:39:13PM +0000, John Thomson wrote:
> 
> 
> On Tue, 1 Nov 2022, at 13:55, Feng Tang wrote:
> > On Tue, Nov 01, 2022 at 06:42:23PM +0800, Hyeonggon Yoo wrote:
> >> setup_arch() is too early to use slab allocators.
> >> I think slab received NULL pointer because kmalloc is not initialized.
> >> 
> >> It seems arch/mips/ralink/mt7621.c is using slab too early.
> >
> > Cool! it is finally root caused :) Thanks!
> >
> > The following patch should solve it and give it a warning message, though
> > I'm not sure if there is other holes.  
> >
> > Thanks,
> > Feng
> >
> > ---
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 33b1886b06eb..429c21b7ecbc 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1043,7 +1043,14 @@ size_t __ksize(const void *object)
> >  #ifdef CONFIG_TRACING
> >  void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
> >  {
> > -	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
> > +	void *ret;
> > +
> > +	if (unlikely(ZERO_OR_NULL_PTR(s))) {
> > +		WARN_ON_ONCE(1);
> > +		return s;
> > +	}
> > +
> > +	ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
> >  					    size, _RET_IP_);
> > 
> >  	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 157527d7101b..85d24bb6eda7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3410,8 +3410,14 @@ static __always_inline
> >  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >  			     gfp_t gfpflags)
> >  {
> > -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> > +	void *ret;
> > 
> > +	if (unlikely(ZERO_OR_NULL_PTR(s))) {
> > +		WARN_ON_ONCE(1);
> > +		return s;
> > +	}
> > +
> > +	ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> >  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
> > 
> >  	return ret;
> 
> Yes, thank you, that patch atop v6.1-rc3 lets me boot, and shows the warning and stack dump.
> Will you submit that, or how do we want to proceed?

Thanks for confirming. I wanted to wait for Vlastimil, Hyeonggon and
other developer's opinion. And yes, I can also post a more formal one.

> transfer started ......................................... transfer ok, time=2.11s
> setting up elf image... OK
> jumping to kernel code
> zimage at:     80B842A0 810B4BC0
> 
> Uncompressing Linux at load address 80001000
> 
> Copy device tree to address  80B80EE0
> 
> Now, booting the kernel...
> 
> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed Nov  2 05:10:01 AEST 2022
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416 kmem_cache_alloc+0x5a4/0x5e8
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
> [    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000 00000000 80889d04 80c90000
> [    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000 00000001 80889cb0 00000000
> [    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002 00000002 00000001 6d6f4320
> [    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328 00000000 00000000 00000000
> [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<80008260>] show_stack+0x28/0xf0
> [    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
> [    0.000000] [<8002e184>] __warn+0xc4/0xf8
> [    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
> [    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
> [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> [    0.000000] [<80928060>] prom_init+0x44/0xf0
> [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> [    0.000000] 
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> [    0.000000] printk: bootconsole [early0] enabled
> 
> Thank you for working through this with me.
> I will try to address the root cause in mt7621.c.
> It looks like other arch/** soc_device_register users use postcore_initcall, device_initcall,
> or the ARM DT_MACHINE_START .init_machine. A quick hack to use postcore_initcall in mt7621
> avoided this zero ptr kmem_cache passed to kmem_cache_alloc_lru.

If IIUC, the prom_soc_init() is only called once in kernel, can the
'soc_dev_attr' just be defined as a global data structure instead
of calling kzalloc(), as its size is small only containing 7 pointers.

Thanks,
Feng
