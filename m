Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E035E7E62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiIWP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiIWP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:28:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92341438E3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663946926; x=1695482926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3Wv3MHgjYznXfOEoKChC1IDCygYgNF0cN4wcy1JR8KM=;
  b=H9wstxoooI/MhVLzOkpxU0hDiqGUB9T5MkE6JLHkFaHmMBPRo19miCil
   zMt5qfbNg4KRczB/lKAVc5XJDNdQBj2x87CrL4/XqbuQPAAukd8hXxSUk
   mQ+A4I3ASvj1B06cKJ+UMBQxAdUWaua9UTYGJozwcpKBTSO0EDDVAJAeU
   Q24XVwa0bOGJ+NtK4LfXnZIddOEwL4vbcCyEVdCVcvf4sVwz/FVQ9sCF5
   zgX/Vah7ikfqNIRxbx63xx/NXSKYMLI6o/9l+5+EvwK6omBYkquXuVs09
   QwABNnhnYFYX46/ri5mfAudHM10eq6Rb9nRyyq8jocvVVWJqYuH62FQtr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="302063972"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="302063972"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="745828617"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 23 Sep 2022 08:28:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 08:28:45 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 08:28:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 08:28:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 08:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMlnLlxedk5VUZYk1eC4dndc2wpYPQsRrM/1laY1yJ4PaTqMps7O6XTDTpLBJjpRI+gHc/dv/ty2zI5mffJmbZmP4QfuOQp1XPtSize3MZPxooQausXSRmVaHQr4DISRm3Jwk8xhQgIg1775y8ntPtV/bmHi+oxQOEALZUoHpGhR9Rz5gdigKDbsmxx03AoplH+u+5+bteadlPlWhVDMe/xg5hW6buk9XGrH7HxmZdQDuci4Ood4le4MIcUGWCp6PA3eN/xGqQgJBx4nYoqHm573KRm4na65WQ9agChDm1r0NIXKgwsMg/+MeNmxuU9gn/oYZRw5GwRbDXCaUZk+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUw0bVXfyhfwN/jKBCLScDRzc++PUoW1bfAt9R1sqZE=;
 b=Mkdz1yaKUs+P6d74baeQT7+Zu2cbj0NS5VTfomfZTzF3VEAcybON0xmk5u1+dsKXs0sMrY3iNF0rj8nuqZpC89su6mSn/BmiM9SwK7PM9byPJQ2aguTYjQOUjDOkkSWeblpKE+bfquWNPJOI+irs39oh+RjzhDzvjqWYh0PVg83Kpqxr/l/QmIZfEpOmzS0JEhP2oxyGKMzhAMAM7oEmbPboJUtzHz6+GPZCSMi4qEmTg6w/Td3JU8KQjlUNNB7dPXa7ZDbbTCHo56z67Fu6rYciKuCKfI6S2nII6S+UBq4PxUD+GYit51AQt7hGbGDHCDnqPxDRFgSuQyTqTBe4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA1PR11MB7272.namprd11.prod.outlook.com (2603:10b6:208:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 15:28:41 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:28:41 +0000
Date:   Fri, 23 Sep 2022 08:28:36 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yy3QpOnsNJQ6MykN@araj-MOBL2.amr.corp.intel.com>
References: <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
 <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA1PR11MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aab4fa0-43bb-4b3a-37b8-08da9d784b7a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRhoyHn3NPkUdUcaOuSQVCYQ2C8CeWbthBcwpMBhDGZMC5ui9coBpxSkTbNiv/mwe8jdXYMKcYEgXdk2Snr5fZtwC9n058pS/x34X2fXHRbRt5/Rxb4wziKMUWNEKz18yk/oEbHarb3rnIB1I19p6aOOj5jpWusChQSzhtxIpw6Ssj0OOSLONcHBm/hZl7ngpeyruBnuoEz+mbnxqkuW0sut993Ej3bavgABIt4GpZsdP8UAy8UxVJbKEWxsoxWsXhZUHWw8YI9NI7QXnmJUsiUPWuageKLu+T/sQ3R1pLCTPwG0MHYpFoS45REdMWqQJq9PsUTqqvPSVguJEjwSBebLwqPRv5CBrgHsJJ0MuQDmv/1cCMP5zaO2hMG2+w9d9av0f9NIawthtW51inylCb7tz3y+7ry8wF5jHBGQM5LPYkJfodf+qdK11KLIwg07d1t6psc/O130fwbj7gmWEFDk2MdStv0el21E1wpHAr0FQ88l0r+USuvIfzwVF6uvOxqakBikuf8AHccZ4BPe99RCCx74CeZymWVe1XKC1pZNgqsZgtE60E3LiyJS6PjGneXYI7Ee7RcgM3lofQaAlAaLR48nb5IO1gKh7hMSfvOc/wSLlzAL6y4n6ZtnBg7NUNZJStiwg27IRVVPUHdrsaJi8mfXii6Jsus9IC4QXmu7gqDTV7QCzhUyNKEvuFquJYqdBWT8HKAaVKICrG6hlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(136003)(396003)(366004)(376002)(346002)(451199015)(2906002)(86362001)(8676002)(82960400001)(6506007)(38100700002)(53546011)(6666004)(6512007)(26005)(54906003)(6636002)(316002)(6486002)(4326008)(478600001)(66556008)(66476007)(66946007)(44832011)(7416002)(6862004)(41300700001)(8936002)(5660300002)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sNWBEEqCJWFABVlUkqbIGQIN3PP7rbF2KMWA3JnmLXaGzrqt6j2NmIJj/oVS?=
 =?us-ascii?Q?5/unaQUR3ilmRvyfdtThwV1rJP3rK6xLbIIf/IOfPFKjFN1gm22teUjN0aEO?=
 =?us-ascii?Q?GhGEBPzGxPHFr+ildWRRqfWxCY54uk3ZZOX2a+EukWtGsBvRAvA+UCFn8Bpg?=
 =?us-ascii?Q?kk7NFN6b+70Dz5Ff+7SF5ho8uR9M4gh/FqIc+iHmpq4QEQcELFSMbJxEcKzP?=
 =?us-ascii?Q?I45pU1XvPU7/NxAMHsu/TnOc99pLqOPfQ/zfP++xc/EVar43A5qUhbfhsS7s?=
 =?us-ascii?Q?Maw0lxo8SYwd2eUCzxbd7788oYJ6De8hY9jQ5JqDBq1Gubc/pXLKkU+GRe4J?=
 =?us-ascii?Q?cs8xZQkM4+rvolQMpS9Bb3ruOtUxDJqcNU/WAVKWHydq6hDCvPhgbpuVzQq6?=
 =?us-ascii?Q?5h3WzFyOGi44B+Um1qc5Aymn69ESiJq7msBb9bKYNa1CGnolsD/7VO3+Xfqp?=
 =?us-ascii?Q?wMUkYg3pb6DjDn8UdOu4R6qDrIxnrwhEg4hi2nTTlKYZoPheVZ9Fvf9JjKVF?=
 =?us-ascii?Q?q2wrTvjDkYddeTNB+lNOhwsWAlkmOovaGRf5sJcMlIzrb7ClrHQBgPdAiIy7?=
 =?us-ascii?Q?Dc15M0QfF2d/YAOn+C29WBxBgoaRQd+5HJMOjvz4jHS0SB5A52ebi+9vz6oD?=
 =?us-ascii?Q?j6Iyv2YzQOZQcZxciXPPrQHeXtk/SdvHW12A17dnLx2lYJzl1oRcWuv2N0mX?=
 =?us-ascii?Q?iGRQ2jPNzLCTZarHKF5pK+QRpm6BOhW4jj2KiLcffG/BB0pQk48rKvhGn2d1?=
 =?us-ascii?Q?ayllCB+GPyRxbKOBDvDPyvhMjlSOx1hQZB/hwbKhnY1EYaw+ggD/0r2+ZFvh?=
 =?us-ascii?Q?HBt4e0A5MLyWGRM8gxqKGalg1gqgyWbnQC25r8rI+rHXpuVC3xl7386ofbZs?=
 =?us-ascii?Q?EihKUxtKePH8Jzu9iUhE9NhGF1k43H9heSC3C/6dW3+A/7dCX6jEdupTn5rB?=
 =?us-ascii?Q?NCtbSOP1ls0dp66HrOqKWOFRNVh8BaxC/pdBeFb+lYK6WobinVMCbu1lhcZ+?=
 =?us-ascii?Q?QCwBE21QiFh/NHfGzInYs8QoE+B28kOoJMgrl5Os6djTakV1UGqnFGADyTnU?=
 =?us-ascii?Q?/6+oGPXvq2gU65bHMrMDDHjuE96WcYvPtgaqFF16h/GalEgPl1v3ozNkuqwb?=
 =?us-ascii?Q?o9ouNX82OBMO4Cy3+FpBSxKt22fXAAPalBCwo7oPgMPsdjunCKrP7x2g/dvc?=
 =?us-ascii?Q?rQ24B5LsVSKv+PI7y4akpaAXC82AdM7ORIUVzA5I60ElN30y4WcOr4Jp7qUc?=
 =?us-ascii?Q?C6PQALYhQGsO/wHb8Et1AhXZxUPpl65PnCTk6Oq5y0tFye1VYhTjGlDD4xXv?=
 =?us-ascii?Q?8mDwVKKtFzRhaymUUuVKD14db5G4h8WiOMHrbMAOCOs9oUKoVIC2ty++Qls3?=
 =?us-ascii?Q?T9IrIBJvnV1LVKg28GCqrN6c1cN9Np4pThcxY19a7XIkCH0ej8lh66UPo/aC?=
 =?us-ascii?Q?wSChGn5/YpkNXnhrno2Z+x3212LOua95+bmaYAj/yAp/J0lhwGc3cuTq7kLx?=
 =?us-ascii?Q?cXG2Xw0qCO8Wtzv3v7u+CnP4wN3FmZif/Ew5qEwF5T4TROP4g5P08wDYCrhQ?=
 =?us-ascii?Q?f4d3S5CUD8G89Uyzu1D/nmwZap7Xtf7EUsz+OGPc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aab4fa0-43bb-4b3a-37b8-08da9d784b7a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 15:28:41.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj9g8URBKQ24v5hEscSwdvys4HR2lgMDGzOx0V8YyuwJxb2XDBmG5JpZAHlNN5l1nbx72r8zVx8mUbrnAKT0/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7272
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 07:18:42AM -0700, Dave Hansen wrote:
> On 9/23/22 04:46, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 12:38:26PM +0300, Kirill A. Shutemov wrote:
> >>> So I would assume an untagged pointer should just be fine for the IOMMU
> >>> to walk. IOMMU currently wants canonical addresses for VA.
> >> Right. But it means that LAM compatibility can be block on two layers:
> >> IOMMU and device. IOMMU is not the only HW entity that has to be aware of
> >> tagged pointers.
> > Why does a device need to care about this? What do you imagine a
> > device doing with it?
> > 
> > The userspace should program the device with the tagged address, the
> > device should present the tagged address on the bus, the IOMMU should
> > translate the tagged address the same as the CPU by ignoring the upper
> > bits.
> 
> Is this how *every* access works?  Every single device access to the
> address space goes through the IOMMU?
> 
> I thought devices also cached address translation responses from the
> IOMMU and stashed them in their own device-local TLB.  If the device is
> unaware of the tags, then how does device TLB invalidation work?  Would

This is coming a full circle now :-)

Since the device doesn't understand tagging, SVM and tagging aren't
compatible. If you need SVM, you can only send sanitized pointers to the
device period. In fact our page-request even looks for canonical checks
before doing the page-faulting.

> all device TLB flushes be full flushes of the devices TLB?  If something
> tried to use single-address invalidation, it would need to invalidate
> every possible tag alias because the device wouldn't know that the tags
> *are* tags instead of actual virtual addresses.

Once tagging is extended into the PCI SIG, and devices know to work with
them, so will the IOMMU, then they can all play in the same field. Until
then they are isolated, or let SVM only work with untagged VA's.

