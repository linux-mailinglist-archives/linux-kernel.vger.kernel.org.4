Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8868DDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjBGQTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjBGQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:19:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7C61B5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675786758; x=1707322758;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u7WbjpNdZ3/MeU72K5cGq5LCu9NaSE/ITzy6c53AFBk=;
  b=bUMO1IInvh0lujZv3mHW+XVhge6Bbq1XnLnm9Pgwe0Ts8tZgeF/ULuex
   zKTj/PP1lZl09ysODJzkaZlRTLEd6Li1P+USf+pq++ZGZ2BMAa+i9WX8T
   OQIHEjMFBdxkvfoHXDaEMZ+3gX12DVsc1kBDmfRHQc5MV6wHeBfgLgMnD
   AAhPsxmoi9DBmWMibWaPdrnsh1hSX0HV7w0BBHs8W3E66QtF5UWcRmJ25
   KvNdbgs6gVkB6GEs/wel/uX3+Jx6sZeB6KrDsw8yPGnwVOOTvTlmvLB68
   l3tk1RfryGhXZundjd7HP5iJARF15ER9k7QhYJWW9Yiwzsz2iU7+5gWXx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331680742"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="331680742"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 08:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="995785001"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="995785001"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2023 08:19:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 08:19:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 08:19:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 08:19:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 08:19:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS1T5hqRx2Mi/brsfZspHuxCB7ojvK0hokxgpuTI2oy6Y9YyKQ0QFeXYbYYg/+w+cGVVjXeD7Ofq7RGb+XQ7Hk0AdAgfx8xl5HswcD0hSPIXBwNTAVEg7IjlAhZiqlGwtevRaL3xPwJIlPJLZPP0/+CmPyUcyxE0FNAgtiQcUkVpG+h2G0llEqGQdHxJyIdrOAgcxX6pvXcfNDPhAD6ZLk6gjMNwdXZoHlVyXHmu1VSA/ruPY74Ri7AqxWdejusFyxawEA2d9E82O+s6SH3ye3Ng4pgf/4DeKOYSqS1w+Nh3j9Q7RDyioAFNTg5a0son70w2rj6cRncc+RXODafEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKPFqEzRdSbOeIF5We3UbGQ7nO7DcYuT2/EOBigM12A=;
 b=X9pUG6bYmu1Li3FG7VoUhssh6I8NOe+TXSc2lli0269iUWe1Yy07osXLR6ugQtXKNxxPpf1Moycfipngu6QBp23PFvrQPeHyJwTaU51vNHpqJpBbNclQCiKXOJOqfjcgkNlF6EfJ1QBgVKMNaQObdK6gKtaW4g9zcWE7X1zI1LMF6XuMIqYjNtHgLGZpsfOkSCPdtW/w4vpAGz4QGQPaacpcPysJk+2DCiAxb5Bhj6S20FRm/iVPJEuV6OTc/2HUHqf9rYKx+GMYOEeDODq5IwzZcYbzusOAAMC/2yhy43xmkZczeqwZXVj4npDeLlCUGHzUSFcFGg1OhU573rySaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 16:19:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 16:19:07 +0000
Date:   Tue, 7 Feb 2023 08:19:03 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>, Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-mm@kvack.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Message-ID: <63e279f730612_104ce22946f@iweiny-mobl.notmuch>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e06d0e-9652-4ac5-1bad-08db0927096c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1Ho2w9ymtdCTyBl5tb8kv/aF4BK77WaFAK56GrYuCDkRmLpEw1lgxRt43Fi2ZhmJnIAYDe6/liCBiJ+g3nJ3XcpsRTHSSwTRQuAuCBgF+Xot5ANKSzXyW+wd+GrMMSL5RW2rZmrbNt8XJ5ESoGSeezc1ANzFAvPIHd3vWC5jIk/aRrEcngjw4Z3/srLdl7avAxMs6gUB2xHduob566nRj+R45MZnYmhpoQiBveI05d9+XEkJtU2XQa/cm+rDRTbVqvFb5Q8rSonXC9ZsiwIahTUMl9DwOTU+rdzHnGS0MB9wTw68wK/xI2yd3OyoZMF8QVkvTy1ytmVWXxGiVyFp/5Po7GiCV8o7JFCbiyEDr6nUuZBfOqI19alkhaGB/iE8Mda57vNvabl9TDCxm2yidaVnJIIUOkdAY6/uIrpfx7skzGZQTSR9Pgjcej00W2gybZUIdP7lzSoNo0kUODwr6la/6JGTSYBzQXlob80c+wcgvtnXJWf5DJ/+Uk8zCKEkBrFcQJ7y26BgUMP/nLQ3LDO4lRES3lySN5XW+l+mkOEQtrCcWsTT7ZU5cD+U6NO2acaXlUxaCVzaLaHRwalmOX2lCWN7XdBVzxtNq1Zt2iE45X29SibFZOKNFxvMbrHeDxTtAYBCH6slsty7MkK1SwurWG9xVZpZ7TXDniX0K0CEgv8OzV61/iKqVRDGgy0++6fVUdL2Qy8IRQsk1nn8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(966005)(9686003)(6512007)(6506007)(26005)(6666004)(186003)(38100700002)(82960400001)(110136005)(54906003)(316002)(5660300002)(41300700001)(8936002)(2906002)(7416002)(44832011)(66476007)(83380400001)(4326008)(66946007)(478600001)(66556008)(6486002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6CR6K6IChj/JjSIqe4+M+T2MUWESCOvvK3fB1lrafbjSHcrD3ijxlGchHsU?=
 =?us-ascii?Q?qdEIJEs4L0uBf5Nfh09w8Babq5ErBDv4fbZ3y1/z5kLJ8LmKOSEh1EJORezG?=
 =?us-ascii?Q?etcBDpBOqyv6gqT7T6IuyTIS/1F6eHdyXmxx4NZWOPT51kby3K/UKih9aaiL?=
 =?us-ascii?Q?2UONkPIImoVJ5dLbKBeh5sjcH92ptwB1MoWv/ipLdYF+n955D8Eshe53yTxG?=
 =?us-ascii?Q?e0d456f8EGKF5rf2trR5xASUN+5f5PWGEqpvHQJEbPJ6U+2sggK2bdDWW0WY?=
 =?us-ascii?Q?ORA0AVhi7lX2VV+midLlfOQ+kTdgP0CJsRZ7R6Jw5EYvdexLd55I9A/343lY?=
 =?us-ascii?Q?XnEP32/1m3tOO+xin5fdB3EsznzfGDlp87V7wmBy4dPMXlx/u/UQwZG75gg7?=
 =?us-ascii?Q?G+G0RtdYnex5xIu0OiPu8xyx/5OrBZDqQME2x/gw9H4t5RFht3C/15e/UR71?=
 =?us-ascii?Q?SvoVBRdeipYvJBY6nNT3w4apwd0ef5dx9WCYj2HCbPJachTckUzYSU3i2/Es?=
 =?us-ascii?Q?E7Vj+xQ1hM5KY+J0MMYxUj1IPOA/ycQzkU7SGZ1t5heHlJJK+0d7khvI5w0I?=
 =?us-ascii?Q?1GyP/UpL7hHK3t5c6AEABndCw0rzl795bBm0jKGrETmUnFuwtjM8hYtI+ynH?=
 =?us-ascii?Q?YiKDEJYyn2DM7Jpp9V/VEWx/k3yc+YLgxOB0zrcNfOcWUgUU8Vdf5df7IfI6?=
 =?us-ascii?Q?NkQGxDg5oE7Y/O2A8yRmDd0dW/VZP8dki1/omBD21fChmVGK3NUTSlBNGoFB?=
 =?us-ascii?Q?KopFYmAwQPo1Tmw0EaEXqupuUwQFC3Dz8nlmIq4rNVADFAUAyORkI+1yxsVz?=
 =?us-ascii?Q?wiP3R68VmOQUQwHSFUqRoyBsGqzDn6VPLatGR4+3gJ16ebHS46ab34ys6vES?=
 =?us-ascii?Q?KF3HQ6WSs4R5MyE3WCI90Zr17OZIRaqZ0fpf64KrepJc9B1uVjsJKk/X7Wwi?=
 =?us-ascii?Q?9SFx6gWcrPm2u5FLaiKiYbThQcmIa2EjNIMpYbf4jugzPp0F/Ret+Wl3daFB?=
 =?us-ascii?Q?hGgZceiooPf9CchSj3WC3eBb9TDAXB++gcDx9Ae64Ophp8jNj30fM0dXqj9B?=
 =?us-ascii?Q?wbw4+6OLeaKi6dKWjEgZfzrnw/RuXzMtnMhfD6PANn5wC3OkDhj+CFYYNzDQ?=
 =?us-ascii?Q?ZDIg5kvuc/G0yAF95hfbZ9FBE9h7AuHe4RvgECMM0RujG8HvgIxanvQp4kEH?=
 =?us-ascii?Q?YuAe5QN/D0PIMl1mgkL1L4o9lckiv5yNU1ygkLk5v6MrxjgMOvIm/J4JcvsJ?=
 =?us-ascii?Q?nmeT/wmpE5yXqd1s1PV213rgQvs9OJ2wzaJnd02o2gfo/tTbmxP6zsI0a8MX?=
 =?us-ascii?Q?JaKeBK8Nm64o3sHFgt17ttF5ChooRBUSoAXdfqVMlWmvMP8dEEUckFgmmZlO?=
 =?us-ascii?Q?KOYWp1o+OqE9iPBnaix9r3A5Mckl99xrDyCikn/xKrd6Xb15A0WC/O1j+DuC?=
 =?us-ascii?Q?Z0I59PUZWX2inY/uFEFyi3Fa7KxD3VXElpJq3bw9FX0cELX9jAhJE2T3wJO3?=
 =?us-ascii?Q?MHzIKDlHWbqU7Ratanaw0L/11+0Uk64OtWNzLU007NnbBnr0ZDJFdV47lbaM?=
 =?us-ascii?Q?snXx01TIcDqfHmMqPa5N1aVPwrXcEFxoRTO3irTt5JVl+YVgYJe7NQjuYz49?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e06d0e-9652-4ac5-1bad-08db0927096c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 16:19:07.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvzsbP8DHCbPxljn8gIa21wiepLRWcLobawOed3AyM7QeZGLwAsVRKKv/RY3Fp0ktalSONXKGdJU7OGa7MKURg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sumit Garg wrote:
> On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > Sumit,
> >
> > I did not see a follow up on this series per your last email.[1]  I'd like to
> > move forward with getting rid of kmap_to_page().  So Hopefully this can land
> > and you can build on this rather than the other way around?
> 
> Apologies Ira for keeping you waiting. Actually I was fully involved
> with other high priority work with my upstream review backlog
> increasing. So I wasn't able to devote time to this work. Sure I will
> rebase my work on top of your changes.

No problem on my end.  I just wanted to ensure that I did not miss
something.

Thanks for the reviews!
Ira

> 
> -Sumit
> 
> >
> > All,
> >
> > Al Viro found[2] that kmap_to_page() is broken.  But not only is it broken, it
> > presents confusion over how highmem should be used because kmap() and friends
> > should not be used for 'long term' mappings.
> >
> > get_kernel_pages() is a caller of kmap_to_page().  It only has one caller
> > [shm_get_kernel_pages()] which does not need the functionality.
> >
> > Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
> > get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
> > does not have any need to support vmalloc'ed addresses either.  Remove that
> > functionality to clean up the logic.
> >
> > This series also fixes is_kmap_addr() and uses it to ensure no kmap addresses
> > slip in later.
> >
> > [1] https://lore.kernel.org/all/CAFA6WYMqEVDVW-ifoh-V9ni1zntYdes8adQKf2XXAUpqdaW53w@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3@ZenIV
> >
> > To: Sumit Garg <sumit.garg@linaro.org>
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Al Viro" <viro@zeniv.linux.org.uk>
> > Cc: "Christoph Hellwig" <hch@lst.de>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: op-tee@lists.trustedfirmware.org
> > Cc: linux-mm@kvack.org
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes in v2:
> > - Al Viro: Avoid allocating the kiov.
> > - Sumit: Update cover letter to clarify the motivation behind removing
> >   get_kernel_pages()
> > - Link to v1: https://lore.kernel.org/r/20221002002326.946620-1-ira.weiny@intel.com
> >
> > ---
> > Ira Weiny (4):
> >       highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
> >       tee: Remove vmalloc page support
> >       tee: Remove call to get_kernel_pages()
> >       mm: Remove get_kernel_pages()
> >
> >  drivers/tee/tee_shm.c            | 37 ++++++++++---------------------------
> >  include/linux/highmem-internal.h |  5 ++++-
> >  include/linux/mm.h               |  2 --
> >  mm/swap.c                        | 30 ------------------------------
> >  4 files changed, 14 insertions(+), 60 deletions(-)
> > ---
> > base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
> > change-id: 20230203-get_kernel_pages-199342cfba79
> >
> > Best regards,
> > --
> > Ira Weiny <ira.weiny@intel.com>


