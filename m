Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA55C051A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIURI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiIURIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:08:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3A9413C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663780134; x=1695316134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bO8fmt7TXkBQEIxBBS7oaRFstlGJO/H2i21h89CG7IE=;
  b=WpSIUiR3QBchstCRWMHC0nT3IbPtj7e5fSfgcTdmc7kCMgiKqhZCvvZO
   2OSYGTHJlpRJPPxo81tLFfmLpMlfRyc/Ni3MCQYrjXaiMl5lBLvnZg4uO
   SzWalJIDjUxaARIgAWLpnczr5FyUgfLGWVcRM19f1ojmheSUNRyKplVKp
   bE5NrbNPHDPG0wxYS+nGCRxPqH8iEJkug6vfih6GazpMZD3QS3mr5eGfB
   rUEom85wNSHOuh0czK8yDt4RKyX+E1y74olVqFFl0f4CVpp5zkLU0qbWf
   M3z2MPy1pPZnVwXJdV6aCFLfeA7SmepDvr7WAUgRuQtjQ4bPa8EcFjalb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300908374"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300908374"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 10:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597078124"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 10:08:53 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:08:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:08:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 10:08:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 10:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbQ7/738DN1A9/33yp4Y9FjQwwJQQif6Po5q4febIUL9zbeQT40i1+5ie/SwAF2PFeitzo8hIJNPdj6BlsM0Ab/Nto+5oLK4DRoV/wLdEz+uhzIHSGcTNlUvZzIJJu0u/OKnUmylpPlzPUo1HjIKOeGGmzcgzhlZ8Y4Uel1FvnjuoNgsYuC4uOQ8BGS4+z++UHrMdXlzz4k55l+JxHkvpDJJlNrsKdpsk2jIzLMYoyvvOo+e6niaKOgVWVtwZ4tld5xlnMhWV8XXJy/QjTojPfDXVRiD3JYbX8y9q63T6QtLmWoyU7py1KOUhuqCoLwCLzL/lNU6lulW6+ewMDhSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFa6+fKaa9C0m+MVeO52rJc6qWWbdFGVrGzJMMy0g1Y=;
 b=hFfykEgacLE65AYs6v102W2xx6Mm4Mt+RQsHMAs6idF8g2pZ8KeAU50MXhKYxK8+CA7LQe51C4NsfIUrL1FjGlx5R0H9Ts6zRzMSZRU0iL3XFwf4Mw5rAmcB/ol7IBW0ng7wnwePTSbnXbOB5IbwdilcDjpLpTTdTaX23BkMxPkagBrF7EtuEK/uOM6QOJYyCnamg1H2oGYP63/LPZwC0jBoWytiOkzESJqqhhCfIWWOeRgqc0vYHJWPySSkJmsPVM9deehIJVdNhSZnkXTt2F4lcCsHK/+jq8dDkvHxiDGH0astnHQJPvNjrRXx8ce+Z60yzYRzFghc61SRV3eYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 17:08:47 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac%5]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 17:08:47 +0000
Date:   Wed, 21 Sep 2022 10:08:42 -0700
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
Message-ID: <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
References: <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cc6dfb-ae2f-4305-488c-08da9bf3f21c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6tDyJQGMlESud2R0DOyuVAe5cKVmLSDYdsiHLr+NnMPhoMOo4EmcGo/2PERDbPh/YUIXCzMDqtJi+++WGULt0by6++n6YsGLBL0P7U8D+wKL9x5CX/A03qF2R6+Id5WOmZ32DP9D7MslMYoa+WfummbJI1kIfrWudn4wjCFYzYYof23g3AnZabqV5R2ErwXbCzdFc7+g1Z/ILZsAum+fji96anH7oxUEVogNqGNFDP28kkPBc6oYRh6+pejq3tHi7gjjZFGK4YgJ4KHW3Z9Eca6aPL1W6EX+Jw323g3CVJkXU1bIHFHq8Hg2SdFoQhDbr8x5uxevJiTGVFcWIW4+0d7b6UNjgLO7U4l1+0kf42qxpGYt1AXJjqyyZw9HkIQGlHz2yJVdw7cLo5FW1PBnQY56bL0W1ypgxzc8arZvBof7jIHUU7Th/k2qsBifwYtXzLbKsGNkFQxqGJ18rzfeXvNANNJ5D9oWky2ngfwu19NSImnpDn4t78qsXGTL2R/ZgvTKFvOLcd88b6uQ66A3SMuQCiPdysnGCTJjQBJVHbDzoie59gEtdQR+dBQfwKKHKSE//W5wc6g+s7LU0KErVYNlMh481Rmv6JBFpM4hBIiXcchFOd21T5xqsjT9a65EKEVdBW+9WeUuU7OyXi1tfsJ9wLWuFhCMBWmxNsaPEOiqJw6VS88pObd0YgNus7HxaTTqLVlSWfE9BrWdKgraA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(83380400001)(41300700001)(6666004)(186003)(6512007)(26005)(82960400001)(86362001)(38100700002)(66556008)(66476007)(66946007)(8936002)(5660300002)(6862004)(4326008)(316002)(7416002)(44832011)(54906003)(8676002)(6636002)(2906002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pe1BC2tRc4/sJmF6IrAZCrZw71BcSJQFdyXj6mm3LWYJbBddc/H/zk1YpmiY?=
 =?us-ascii?Q?nS0lBYAdvkRo6peTbdkAWVhaVSEGYLHwDlQgGeWKJVIbCq/8qF9iYXknTJwD?=
 =?us-ascii?Q?6FGSZOMlUaeWqW5j7XiYp/ZLRrs3C3n2ysxUPDhr82gmDE/P6EGOKTyBW2cG?=
 =?us-ascii?Q?KwrKPh1gIBVahpFzGzkCe6VP7H4oLQJ/RrHNvssa2mJYxU04fl6gFeJSttz2?=
 =?us-ascii?Q?Ul9KA5EFCEynadp/qc5LhhLb4KYnjRPWiuASaxVa0elabhFgclrWiZTQ9mn6?=
 =?us-ascii?Q?ZiZ/sjsxHaB5ePwhk1ZIDU2+7AL0GEdaCHRzJR0Np2NybKEX96DV5enhNXzP?=
 =?us-ascii?Q?hjS897rFphxdMXDTZJlieU5OYnbGRmaOTPwkNhHeikq1osrBw4sMcRUUMECb?=
 =?us-ascii?Q?W9EsKN2MLe1Bp2T4xckuXqZH4YHRKZOj5GoxtM6A5EFwvFE6XXgIX8BH8TUg?=
 =?us-ascii?Q?TH7GmfC3DNX3qsiAEGqPCrVK2m4bfVBA7X/p/Rx+KU884/cqB0tNEJXqILnP?=
 =?us-ascii?Q?nYUWSQVx2rOD7b583JIMXUv09whdS0AVE/EBa15EUtO8fTr/CcGie0KLCahs?=
 =?us-ascii?Q?eaFVM81jz5MNpn1E8Mz420+oByy5Ivu6MIZtGMGOdZQJAZS4RDdicfu/gYOi?=
 =?us-ascii?Q?r36OXxv1sDcQU/nOO/mVhhhK4csHq6mw3YJZs0zbWeVOFfbG4fhO3hzXRmqn?=
 =?us-ascii?Q?jNyv2neXJZ5VCZroLAC+4o5bWjimq+dXjfRnqxG9eH8rzOfCsBNy8fj39EM+?=
 =?us-ascii?Q?tkieGy/5wccRVGOQJ7I6/2Rp2smNf14TWpaXX3MkmZGRZa9fhcwuYWqAZEpD?=
 =?us-ascii?Q?uAaNFn3Mad3VMEd8kTFN37QRUdhJevOYBi01QerCcM3YAGm88KWiihurZajP?=
 =?us-ascii?Q?Lzplu8H+7PRk6nd2r1SR/HWW0OCyK6MpdMKE/vwGZDcVMnubn355TRl+LplW?=
 =?us-ascii?Q?bII3Zl9379X3bGZKfni+Xj2PNNsS7GVEbVJE9H5IXz144LQpHRe9r5PdHT1V?=
 =?us-ascii?Q?zpMEMcVhyFxuHl9d6eqqh+4zPcrcv9wUY59qM2J0yAuItG94LE0idXoJXUh5?=
 =?us-ascii?Q?3kPTmuKsHg3OO3puwZW4dgO36Jq4u2zHBvm4FmAwFXWV9qxLANif7m3bcNPv?=
 =?us-ascii?Q?c+/e90UDafaEIpaDXhaexYFqk1Z9zj4iAqzIWfKqW6O69prLLh509lmvL+dt?=
 =?us-ascii?Q?Qkj2wsQXxxkyN0idMXkekS8rdCXas7lK2jqqSJnQ2jPv4ranrrxDcFCi3hXg?=
 =?us-ascii?Q?Lg59zr+TWGIBwDZ2wht1VFxDvnR6dFQae3Hrt9g6SJ2GFW0FNkvIBl+bXj+Y?=
 =?us-ascii?Q?wPK65IdcxxWfhWf1EnDGCuMtO88YlBZ60ngpluSU89IQUBWQGt2KoBRMde6F?=
 =?us-ascii?Q?LOT/DSmKy3mF7YLi99VvvPN+G/auo2QCOsECM8Bvuuojt8PiBjslT30C8GJX?=
 =?us-ascii?Q?wVAf7qP6G0jPszNvBdSd5lz+eqPudyq9BSt6QbXg+UTrHGdOIixG0UxHpxkr?=
 =?us-ascii?Q?QfF61ReXhNiPOQPtbQrx3sc8GOoknKyQFG6cyMQMgr34z+8pHYbEYvOZVlwM?=
 =?us-ascii?Q?t06xjuy6SpAu7gn53F4VO6MsJVLqzhrMxc0TnfCm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cc6dfb-ae2f-4305-488c-08da9bf3f21c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 17:08:46.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq/RSNEckzp0PahMCg6kyX3jga+tQWh+sG42EJf20GJ/3T98rVUjgrFcsVJ6wyf18H4LM6i7n2xJv4ntDU7uOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 09:57:47AM -0700, Dave Hansen wrote:
> On 9/15/22 10:28, Kirill A. Shutemov wrote:> +	/* Serialize against
> address tagging enabling *
> > +	if (mmap_write_lock_killable(mm))
> > +		return -EINTR;
> > +
> > +	if (!arch_can_alloc_pasid(mm)) {
> > +		mmap_write_unlock(mm);
> > +		return -EBUSY;
> > +	}
> 
> Shouldn't this actually be some kind of *device* check?

The device will enable svm only when its capable of it, and performs all
the normal capability checks like PASID, ATS etc before enabling it.
This is the final step before the mm is hooked up with the IOMMU.

> 
> The question here is whether the gunk in the mm's address space is
> compatible with the device.
> 
>  * Can the device walk the page tables in use under the mm?
>  * Does the device interpret addresses the same way as the CPUs
>    using the mm?
> 
> The page table format is, right now, wholly determined at boot at the
> latest.  But, it probably wouldn't hurt to pretend like it _might_
> change at runtime.
> 
> The address interpretation part is, of course, what LAM changes.  It's
> also arguable that it includes features like protection keys.  I can
> totally see a case where folks might want to be careful and disallow
> device access to an mm where pkeys are in use.
