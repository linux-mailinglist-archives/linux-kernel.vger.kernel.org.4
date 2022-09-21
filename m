Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8891D5C0545
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIUR3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIUR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:29:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADE979EE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663781389; x=1695317389;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lbwl/TrWBGNLGuL5q2hh3clVW4Lr+HsXx+hLpFQRmrE=;
  b=Sv16nEK7whOsg9/Tj8PQcO7jzlNgYXzeo5uNY5iBielfKyGDq2scN6cF
   RxPXkMdLRcGTYBb/YH5JZuGFGBNc4qtdYFkkfqM8kLJiZgDfuMFO5QIQc
   MaZGzOrXTl8miMW1N3SIn1jyVWH5RlpbNlX1FQK9GsPNlQKykJKWP6yr4
   zKBrfeRS3xx+zv9bff4tjIV/9PhiFyjBqKwdbCQr2oKSB1NGhprgdiwrC
   O2gAai6h2wkWmh3Tls9nzL1a7TAYvwDLKhds7i/csnxpJeUQu2DjmIDlr
   kK+3iqxKbYcQ+PhsKqnaBC5eXRypVxi+4FWMpzqqgDWVXhdJV08bb8xoq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279795763"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="279795763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 10:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="794765358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2022 10:29:42 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:29:42 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:29:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 10:29:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 10:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiSuMKHzr7eRRcXDidSBEtRCklaqDBejHWXR1n/po8rvFpGi65Zv4bh/NJjntwvrpAI0pt7U80D/Y3zwqNEetkky0zTiiwxgrB4tDBdd/CTgYw21tHQZEi3j3leubZqwXd/M8eHMAz8FzOfwn7UNs993k+ELlnF7EzMaZSyUfhUqxGma2UHEAD1W8hC2tofVnsZG7AmogMZKsGDRE7JqLc4gGRUCckrUj6+qmnDX6GHSBG7dJU+i6ISqhkQrLGfCDEdTIS7koi4CzdF8df0ODav9cel9lcqieVeaat6nKV+jBzAwMjiN22cILb7XQ7oRmWKhx610EdNwP3+umI1oqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCTaC3CYshg7URNFeLrFH/945Grw+Bgg/SFFHhNYxT4=;
 b=EIaqfM2oOaX/Z7JEZgIs1nMt5cPHGk+tZBZrJc1cKd61IDQHobKe9sYzoBKIY12/b/XfuUPSTxlrVx50P2d+OTR7wnNWBzvGDSx10j5fDD65JzWF3QNU2xMjC3As7tJpaiuQYQwaGA4GxBvjQ2qEjfeKR6sfsGzkpVQO+HGsFAKJlKdMlsU8FhfGhJtt4dLPuYXxFxY1D6Y8r8/R6IEYg+8QaQhJIx69JFpLhNERQdmE/ireyqEqQm84fpxbK8P8WtRKAVUO5GUQzPx1jd/F67fErvolkcl+lgM/MfptJNVyXoMCNFOaLkwXBQPKGCz1/v/odv1jdMM1zLLeeRCi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 17:29:37 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac%5]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 17:29:37 +0000
Date:   Wed, 21 Sep 2022 10:29:29 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "Taras Madan" <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Joerg Roedel" <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YytJ+VbOrZ/gaWmS@araj-MOBL2.amr.corp.intel.com>
References: <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad6d9b9-9c09-445c-c154-08da9bf6db49
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFlWfZdo3NcP0wb8pa35p40x/cesCEIXVxfM6gaxk7LGeK+08YQ/1s05Rdb2A/9FI8eLrlBrZRmKIQrjRnOWu3JMyI5z4NZ8a0YnWXvUvxw2gggiqRkjWtyp4lvPQqg4+5+gX4ie1/feu6jqzXtacGmqYOV43/dR3Vsogx4Eyi9lYLMhzLby9d3geYSZkZSPa3p30d3vaL8kEB+pYbOqQKUXQjRVdxNHtqe48/2+7OTZaqmq9QikcBhpw0xtA912GOMH6+FQvexC1R1eA4jnjGPGTlfD/XA2bBTHBkl2/5gf1b3CJAEeNuouG3/0EefD4bFVG0a0ERgboq0/bpxfvpquZFhYSswwjIVPPKmQu9pjd2CwY+v2KHFy/iWMIgf85BmlhJLeax9KrDO++kAwqqSFswqdRM7sYcB+CO3OcmQldRTPceXtZUMbsy7IzJRHpO665Ppk2JBOBtGS//ZiOM5cUtdWFAS1Wg2bDm1OURCXzVTzu+JjECKHo7znqFkwVCnes1/V3a+WqWdmkLTXXHi6AJHQN3rSVnq/+KJ0otHNk4cgf01rzfc8kzblbcphuL7ltxoh22iEj5NbLmeX70p6gUOQB+7krycjZU6AW3OHVc5tG+0hZx4TBr9F4PG8OsCDdArSzNNnJGBP8g3oTO2VLU1OBn7ZJJVXMVe9zmMAavlfesUbMl2JLzukbs+OVTgcEb+3esb/L8cNoqa/hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(6636002)(4326008)(86362001)(8676002)(66946007)(478600001)(6486002)(66556008)(66476007)(186003)(6666004)(6512007)(6506007)(53546011)(2906002)(26005)(6862004)(41300700001)(83380400001)(7416002)(44832011)(8936002)(5660300002)(316002)(54906003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nHx4o9Wkw9ImoZw1FLCKN3rIqaeDR7Nrs1aREu1oQKIIslZp8p7vPYONfzy4?=
 =?us-ascii?Q?zB675wFX4dt+xbPRwot6Vo5TwKayezsvbfC/Kt4Wykb8xxdIXsdTGxrWqdKu?=
 =?us-ascii?Q?fQmKdkoEiS8Njy0+4tSYoILdgW4BXC3/UX261ca4oJHt+E9vn4nGWCq6/afY?=
 =?us-ascii?Q?Yj4VCp6ytppVBiZSl6QEZ7EMi8h2IsAQ2I648G+xT3P5grEGyrUt9z4Q/DM5?=
 =?us-ascii?Q?7TmbCyTN6X9aPe76qPiZiFtRLF8dACMWF21Sw2DJdJPNyxFsCPu/rpQb8o3/?=
 =?us-ascii?Q?Q4c7+eZ4z7b+lEAMnOHbfHaDda837MO0mVEN1L48y1m3cxmZ5e7slW1s+EmX?=
 =?us-ascii?Q?7pnSujWg3rIH2TF6OqOJe6jXbHJxmn1ZoKkgu08xtBNycmz7jGDYux/TM+Mk?=
 =?us-ascii?Q?mQ/fQ8IyGAUDAGTs7sodKONVpSeKrdyUFXU2BaayoRE4ToYyluONaaLSPmz7?=
 =?us-ascii?Q?8qAiNs0R3lYhvYAgPYBPJoT86Fifj28FpVrHaJ+l+IhOBfQ/79GeXngIigxf?=
 =?us-ascii?Q?/pf8wO6HyCjAkc0qRbX4ixz3DykkYsv8h3hF7f+iSNvSFt0Vi2/b1tr3XGOH?=
 =?us-ascii?Q?AWeTgK9XOH0UpTNBLSCQ8eC3XjxxNpR6uqM3Cwb9cvovfwPNTu+ZzIeisU1O?=
 =?us-ascii?Q?/sXIhC1pAi8MvCUleuJIr6mFZZlPczfxdPfA/MzhqWRwJwPUfFgSJ/wAWYwg?=
 =?us-ascii?Q?8jrYXfpqzxIJe5UWM0UrIGhF/JR3z55qWSiFPCpl2YYthM/s4GyDjq8xf6Hk?=
 =?us-ascii?Q?JjTcnssHMeFh50IgQNueK84iyGE1wyR2eRMsVwEOlfkWBJFVzCfzhqcPp8AI?=
 =?us-ascii?Q?S/1FENgX9bvX6gU9vYNmGww1F2QR3tWBQ6JQL5nw7xTHtXl5FynHYEdNWT0L?=
 =?us-ascii?Q?f9C2sNrsauNP6XYybp0LItVakbDlTVZqdVBa9NOd/IY9KfOauTiGiiSudnWk?=
 =?us-ascii?Q?sn1CQhHwWUUVlN44y0xrQXcfCoqTE+6rADs5GMx5jqkTyH7fJ3xN5wins8jJ?=
 =?us-ascii?Q?kIK33jkT9AETlAmpPZ4xmswvW8Yy7fRewfjtZsV+X4374cGw6ZFsjTmgj9Sd?=
 =?us-ascii?Q?Anbw33ozZ3TqModze4h7fiHNN0iPwQkBXZ72OTNv2vAYMwt9pq59YT9gwCzY?=
 =?us-ascii?Q?YTrH+0jj+mPwv0yaK/gyBz+3ifQ+aW6HsTDUIjyTXE/cXDTr+V8NNtrwR40i?=
 =?us-ascii?Q?Yz+M/yhNI+EwprLnLo2KsLniAx5rsLKtv+PXmhCypgwazjS26mWSUghgvIVM?=
 =?us-ascii?Q?AKYaSvvsQG16yav52Pi2LOnQY/SYiQrO2/wU0H5oUi44CDNX8RTfBhltPu1f?=
 =?us-ascii?Q?5FEL2niJDDzCW5dw+TNys9fig5pF5sl9UentdBQBI+/PZe+aa7tH4YjATjEm?=
 =?us-ascii?Q?vMyWmb9PzO0lRrKUljWFehC//XPjr/Z5hzTwISZ1+lxGgtvvukqiucnFHmOR?=
 =?us-ascii?Q?JRtr4TQOdQbxJEam2NCMfML0GhxgdM32QnauV20JJ1x+kvox3/rFBZRduuSy?=
 =?us-ascii?Q?TgVnlt6S8vasEBj0lURdyj4aJu4PB4YYno/kEQ61dBmEwGhr//Boc3t55kTR?=
 =?us-ascii?Q?azLVo+Apl0I8fWXBApamqo1Hg5fnLkRtrjNi9ZgL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad6d9b9-9c09-445c-c154-08da9bf6db49
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 17:29:37.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD5LpcfLjrCbCk4ylJlkDk//MlhNnTcLyNMA1CFsgs5izkVTUz6h0pLdgKH2sJGQ0KrPd6GZO4D0tcbpvkRHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:11:46AM -0700, Dave Hansen wrote:
> On 9/21/22 10:08, Ashok Raj wrote:
> > On Wed, Sep 21, 2022 at 09:57:47AM -0700, Dave Hansen wrote:
> >> On 9/15/22 10:28, Kirill A. Shutemov wrote:> +	/* Serialize against
> >> address tagging enabling *
> >>> +	if (mmap_write_lock_killable(mm))
> >>> +		return -EINTR;
> >>> +
> >>> +	if (!arch_can_alloc_pasid(mm)) {
> >>> +		mmap_write_unlock(mm);
> >>> +		return -EBUSY;
> >>> +	}
> >> Shouldn't this actually be some kind of *device* check?
> > The device will enable svm only when its capable of it, and performs all
> > the normal capability checks like PASID, ATS etc before enabling it.
> > This is the final step before the mm is hooked up with the IOMMU.
> 
> What does that mean, though?
> 
> Are you saying that any device compatibility with an mm is solely
> determined by the IOMMU in play, so the IOMMU code should host the mm
> compatibility checks?
> 

To check if a device supports SVM like capabilities it needs to support
the following PCIe capabilities.

- PASID
- Page Request Interface (PRI) for dynamic page-faulting
- ATS - For quick VA->PA lookups.

The device purely works only with memory addresses and caches them in
its device TLB after a lookup via ATS. 

When device does ATS, it sends a translation request, and IOMMU will
walk the page-tables to give the PA back. It can use it until it gets an
invalidation. 

So the device doesn't need to know page-table formats. but if you use
tagged pointers its something you want to check device support for it. I
don't think there is any plans right now to support something like the
following.

- Check device ability to work with tagged pointers.
- OS should configure the width to ignore etc
- Device TLB's properly handle the tagged portion without creating
  aliasing etc.

In order for LAM and SVM to play nicely you need 

#1 IOMMU support for tagged pointers 
#2 Device ability to handle tagged pointers. 

#2 above is an additional check to perform in addition to PASID,PRI,ATS
   checks we do today.

Cheers,
Ashok
