Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA73636FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKXBYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXBYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:24:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3308111E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669253060; x=1700789060;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PZZJi1FYJX7AK/LIo7bfp02eQMOei65txkDLB/pDWTI=;
  b=Y7dIfVNjIWvzKveHXfV2bM/EFbgLEHsw6CNwsGf+wF7gj6WxwtA3ufqQ
   8Gf0CIfuPY+La56oAWcg8SYPYE3gDCll98DMl46FlxbZpZlIo9dSwWriz
   kIVQCnCM0LFiJzziJTjCZ+LUEs1HxgLjb+r3xYoPWSPmJKZ/4Iv2Yi7cI
   f0I9qTIinV98BKqGL4ygmdfpUZCRMdg5na+X6edfdiTMeaNCCQSdquq5V
   QlaLbDZSo9mqtdnyj82GKVdWOBfKUaQvF2OAOsnFV6nruZtuM2Q24NGfJ
   ON2QHryCd3beK4ZRx2wbzqizljJajYYFpN5yNtmhNL9jS1qps/r4qtCBT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="293896889"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="293896889"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 17:24:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="636105186"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="636105186"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2022 17:24:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:24:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:24:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 17:24:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 17:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5hjCkzJLHswN6ZaORcJ5rAFO9c5+OqEtH4hv/XlLvRoD1Ok3jlnZFNXOy5/AaXqH20MYUE0vG3+H6jMIeTunaUyi5QZpMzMO5Bb0Z9QdsrjtG/5zu1nrtQzworF2dj2ci1DqoLNc1ol1hBudDhmU6G785RP2bCKMpwsvvVO8KQJ5xEgB0bXu/wdBRO4yCOl6X0tWzJ10s0SsTzz3GPt0bPVC6Oo73mwfcKJ7APEztqyJkruZVqEg9uWdF19FAFehwdEFGNZh3lGy2CNF88K49BPS0JilYM+cD8tHo/97brI7qfBND9zwe8rtX7rXKiwbDc6lqjgUW5hy5YNK7GefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM8AXRK1dGCK60KZ4QHkEeYRuYT8NufyT5gZCkuseKc=;
 b=VVmjDj3nc6cpuANm0kGRJDXiufPY4VcjAy1+Qk4Nw++Rc1yqtj3wM0VfOh1iNB2f640XsYLu9iRgqW6QTwfVllJbvHhGZtfXliX8ykNgh6qDnT4vcoXolZvitXdF0KzQdWCwhuk6RO1UCaBN8yVUyz9SuQF19JU2S77eXy1FHqWlKkb5+qplBojZWOrQobK1mOrplP/K5KiZX02j2WizC0wUHbO+hC8ro2qaQP+KWIgv0HM9uvgLUErSE3j9ZeJEDxhX2Hm1X8arGcJU1074e8pekRcBG6tWNpz+1eLWiwTTreK+3T9I/W3oZjartAYYFs8M77jOEgaEpCNcGJ9SNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 01:24:18 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 01:24:18 +0000
Date:   Thu, 24 Nov 2022 09:21:09 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <linux-mm@kvack.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next 1/2] mm/slb: add is_kmalloc_cache() helper
 function
Message-ID: <Y37HBTKnLVT03H5y@feng-clx>
References: <20221123123159.2325763-1-feng.tang@intel.com>
 <bdafa84a-e5db-471b-fdb2-34ecbf09c225@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdafa84a-e5db-471b-fdb2-34ecbf09c225@suse.cz>
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BN9PR11MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b3761c-0b7d-4f03-0214-08dacdba9b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYEwjX6i3CutSeI0n9HWhBwNe4P5NdAvbodNgZ4+VN8Zx1jXaach63bbgS/XoDW8sG1Txb4Pg0PMQwlqkYXpbvVGDxye5p40wqUuRJZMExEC05VWp7o9OFoAYLr6Kl+PbthAu+5xYiijLD95zPrizb9NNEwRYNxdG6B/HEwjgeGhQCr9k+mFZUUk5bKW7etHlykZWftML9SknTSB0WXBHIt5NvomUfmS5W5Sp3POe8Y181bLSZQxv/4m02ps3Kgt2WCMv1+PYK7jK4Mb8JTx60/OLGpjA71otMj/SnlqbfGjVPGd0mdZNdZ2Kzq9deCnDvXzh1ww8VRvhFhlZmeFgR20hPS8MjfxgY+yIhes4XrUW8xiu35lleZqpQCZjQKOE8wnBhff6WGlh2CuRenB4tutdffVFxCw+XcDUQjnmzMvgsYsYGi1fBuTzV1WsTChMa1RR49YtHZe7+n7BIRhKiPwjdQ18ozuuj5JSzh4Ah55posKuSzhZ0iEc27qxIi77AxTfIhj/r19+bdUrQ8a2rcv4FO8f3Lr9fX0pqiqYk+R+kdsE+RbDS8uJ/rvOSYCIrbeAoGi72pbdhIfht+T4YiUTTDiIT2AfWq+g9sdte2ns7gXBakKyZ2q8T+GqjnnCyhg4x3I7Z2THnttOv56UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(38100700002)(6486002)(33716001)(82960400001)(66946007)(53546011)(66556008)(83380400001)(5660300002)(6666004)(8936002)(44832011)(7416002)(2906002)(4326008)(6506007)(8676002)(186003)(478600001)(26005)(316002)(66476007)(54906003)(86362001)(41300700001)(9686003)(6916009)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AAn1vxFSFRa3WsJvfg+che4alWk1kenxdCai3WRqzqLqzY7VrQs6pHKWix/L?=
 =?us-ascii?Q?53KtP2dQ//bR78XkVea/GRRzmBhWK5e4zbTF7cPQHMBGuAfzeEWsvcxqTRxn?=
 =?us-ascii?Q?3dEw4fAd1gvWwYoLfjsfWMFLOy341yZQp2QGkt7uc3fnPaUAJJIZSOa5++eR?=
 =?us-ascii?Q?TnX6MjBxc2AyDFa7uSmbMebLmHZyNfz3dVIBeSIXxxK7dmifiMSwETNW34n2?=
 =?us-ascii?Q?h/AGDpCHIIJ2jpeEQy9LSnjpo5h8GwEzqyFvKA4Bne0JPn+B7cvaA/xB6dlk?=
 =?us-ascii?Q?ndCoPppkIFrjgF9wg+jk3Kk3G0tJotsKwINzY2Wc9zf0fYgi2qHoeio1qjwh?=
 =?us-ascii?Q?oEjZo5f4DYyHE/VCZROCQPKv2o8cgUpSnM5qa0H71GEfes9qnMkqDrP3zZ9D?=
 =?us-ascii?Q?wqwOSLh1QXgAtmf0/ZYnXdJ6WuQLhYxiK2NDHYIDbxSSxCQa8TAzGdF46nYK?=
 =?us-ascii?Q?nZ5OAfC1+bNSG5Y3nfCCEb09Jdv8q0G2+vVNdjeeXGpQgjMIsiquvGirWUFg?=
 =?us-ascii?Q?d+Btfcm1LGtrC7mmsAAojL2HkwRmpQQrYFwT0Slmjv7HSm43oRIfvIIUPNkv?=
 =?us-ascii?Q?noVDdd2p+MHth/SYDZwsYah5LZciRyttFRKa82QCLhfITFF6bsPidethlvWg?=
 =?us-ascii?Q?DEva66PU109TlDBip0qj3n8a9td62sIpQ/AukIG2iFkC6plUP9p0II6TkNNl?=
 =?us-ascii?Q?Uu/EKAacJGxwkoM3R35NcD5j0sgXK/aWBhf9FRNeTD8EuZ5kWrM216FUqb+K?=
 =?us-ascii?Q?mkyaDBYj73Z+SfFA49OK9zEK785Rh5exCdiQhfv2fDo6WdgEbIXpnAzZOSeO?=
 =?us-ascii?Q?c3RJPt4BY47wSFosFbAyhIFtaIfsIIP9U52TRj+59XbqvonMAzD3FJB0kW4d?=
 =?us-ascii?Q?2yxHNHcyGSkzc0vi+HZXYlosjpgzTpko3lc87UmqEfHkJvAqA6H9VOYsrsdH?=
 =?us-ascii?Q?p9k08boENHFAaM/8gzP207feuHwkWzJ1A5lmilDU3MToktYueuD/GipzrGBG?=
 =?us-ascii?Q?xJA80Ou0WEHse9ZLRajlRaHP5vaJ+I5tPMbCowwSeJqMrTgdrY1VSM2NMhYO?=
 =?us-ascii?Q?2iL+u6LecNHHkh6+BRrDml4qUU33dYh/Lb4CYPr/QzbLLVasQfU5Lgvy18L7?=
 =?us-ascii?Q?qCRp6cIKkx/DpaognOnxdq1XuwupZ99Z5phnDdfWifAmg4sASSxmEQuohPxS?=
 =?us-ascii?Q?yXimlIYpN8qKQazuvQ7mWd5/b49U6OaDc0ihBJkHHjyO2+NcVOo2VNt2omxZ?=
 =?us-ascii?Q?L/AD9p59d4kyNjsf333lTU90OLNS0B7cDAv8HgmfCkplJ5H2uKycSfJRXB9U?=
 =?us-ascii?Q?pMg6KZBk7NxVGRhWdD9cV/q4mayLRULUqcOMpngMbL7hM7OM/3GCNi8iNTk9?=
 =?us-ascii?Q?DurzvCgvUNinhslEp7xI1g7QvEMIlDAnxrbisMoczp7GgJRpQtthgIa/q3vi?=
 =?us-ascii?Q?E1L+ZG0scJopxRpEeft/FFr8fjUdP7rTOMmctMTdn3N16ZhitILYyoiDm9kC?=
 =?us-ascii?Q?vMQYbxdhb+Pnb14PmhJDv84eXmoSwiVNMDOg11JKxx/36izq3/YRb0EIVf+n?=
 =?us-ascii?Q?j1WADWPbLvOGwrwnqvxxnOOIlJWaF2o2qYFBTj/e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b3761c-0b7d-4f03-0214-08dacdba9b4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 01:24:18.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05KDTf8ivWfZh2zvAyXc6zM2Z6D69pkaGN4JKGt8ujc7sWKZEu9yvTvKyt0oIrzwjoyaaC5YKCjdFU/dQN6F9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 06:03:26PM +0100, Vlastimil Babka wrote:
> Subject should say mm/slab

My bad, thanks for catching this.

> On 11/23/22 13:31, Feng Tang wrote:
> > commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
> > kmalloc") introduces 'SLAB_KMALLOC' bit specifying whether a
> > kmem_cache is a kmalloc cache for slab/slub (slob doesn't have
> > dedicated kmalloc caches).
> > 
> > Add a helper inline function for other components like kasan to
> > simplify code.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> Patch 2 seems to depend on patches in Andrew's tree so it's simpler if he
> takes both of these too.

Yes, patch 2/2 change many places of kasan code.

Hi Andrew,

Could you consider taking these 2 patches to your tree? If you think
it's too close to the merge windown, I can respin after 6.2. thanks!

- Feng

> Thanks,
> Vlastimil
> 
> > ---
> > changlog:
> >   
> >   since v1:
> >   * don't use macro for the helper (Andrew Morton)
> >   * place the inline function in mm/slb.h to solve data structure
> >     definition issue (Vlastimil Babka)
> > 
> >  mm/slab.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/mm/slab.h b/mm/slab.h
> > index e3b3231af742..0d72fd62751a 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -325,6 +325,14 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
> >  }
> >  #endif
> >  
> > +static inline bool is_kmalloc_cache(struct kmem_cache *s)
> > +{
> > +#ifndef CONFIG_SLOB
> > +	return (s->flags & SLAB_KMALLOC);
> > +#else
> > +	return false;
> > +#endif
> > +}
> >  
> >  /* Legal flag mask for kmem_cache_create(), for various configurations */
> >  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> 
