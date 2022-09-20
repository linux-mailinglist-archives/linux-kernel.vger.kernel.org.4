Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4009D5BED2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiITSvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiITSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:51:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D574CD9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iyh/Plae2R89bp8TMMw6Qju5XS81Bte5mAoZ1oKCBzlJf+EgWPj/qhWYXkoRcpTZj3tGDA7zHKdXvKgZvrhpc7nj0JxIcJbaxuHpsYmbPgnkL32RALI0AH2hVZ27VriTt8T1qslsdMct8FAOztpdrALEt5EAxRw9z+ySWE2/EBR6dtdkSdLwApw+P0G4BoY+lmardvHXIjbF5cymA64J8OMfoFfD08q0fqbv00bn6dvkLx+HWjzq+HMzmhN+mdu8+4PXQqLQ3JZG5CMMadClCsPEwbmg14n0pYfRC7Ijn1F+ixU+e14Tlx+so1U/SqGNWHnKuRLLnRMj21F7iJQUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0McHsKfdD1qD1+/2uYBtLCYVXDh0zqTVVXGmHCFhpY=;
 b=avUPGjK3bhgPM6vsuIxE/QCzk4v+zjBQZpPxILIHJkd1Fump3sGh4Q9Tra0xdNREh+85Zi1KTNCdWUaqJIHveFrigxK111KrinDOh+riDQijAfP3Fw3xV+luZCfsDchfStv8gKyS3d9HSgGZbWL6GTKxu7CoOHPRIe5m1j1Y5YIgkyEnJHRrUU54dmNNMgkQ+d4YJWYxRCX8mqo7fsylTEDJil/lamJnzzNxiFtjisbzgIXbg35jkXdErSG1wl8twogXqed3se9KyGkK9tdagHlwAh5kgwlFl3pbGM4cqLQiYPuNWzcT95Z3JDi8oX0AU5xdxcmhSpoH3lbLt61nPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0McHsKfdD1qD1+/2uYBtLCYVXDh0zqTVVXGmHCFhpY=;
 b=lSxDGkVVx5FV571/N3WDtE/o4w1+R3JEy57DIerAsuyjqsdASwBgyk1B5EyKoEFhYFfzR+rwm7tOK+ymhZAF3UlgdfjG+33Ocp6b99CPz37Zjukd1LY77vVThYUnOELJk/mT0bOchi7Zz2PMnM7uOB7DEJrn22vrvOWnmBmlWbYFFo2TMGgxmB0ttqhv2qSqU0RzURJ04VplaOloH1xB0vxgra09Mm+b9yA9Hcpo13IPwrZ+0YTJeMqrmE/r5GEITQMLZRyoCia/p4YAnJ535GpjNuMPJWs1qHrUeMekDtlNexzwv5BDYKHaZfdAs+lu/m+YEpTy8uw3zD/v5uWfJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 18:50:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 18:50:34 +0000
Date:   Tue, 20 Sep 2022 15:50:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YyoLedkOx59KUjSw@nvidia.com>
References: <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <Yym8zsuXbYaW3alU@nvidia.com>
 <15741fdf-68b6-bd32-b0c2-63fde3bb0db2@intel.com>
 <Yynp77km4SaHpe/3@nvidia.com>
 <20220920113742.277ac497@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920113742.277ac497@jacob-builder>
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f0c2d7-b793-40d2-7f45-08da9b39003a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1fLBVKSmNmaetZhZ+tMq/1eaPdfvjqIgFPoCPS0i4FiLCclGHMSJA6cPKJN4N+PPtgDpLBuQRGKdKxL2SviWqgMkY1O/252zhkNZdOhJ0zaySlklWTaGc7BMC6DFDqWoH/fPa4lzUplWY5hGZ2RnyXLTL5PBfFbNOsS0asZfUANpdO6Ji8GFb3Iqv4gJ7U9wDHSQKvqxudQnhZxbxcGN06A8FQt4Rz6fJvPpBxJnGYuwcst/JBgarciXoAk2SwhGLx5us7ODFQH4u4mvBFU1kbCBGoj8zEDfnNSr4KtijyaHgPpx2LCwz12KL1xuyd477PZsAHXuU7yVL/YZBbktAgUtEZk8nh9RqBaJ9n6XRdYUWDAe/BhCZzrBTl7ytwsxZkuRmvlcSVwM3kKg5YbJ5GD+2ANOMFigY3CHzTXcBEb8ZpyNvnBEnoC1BRGl3tudS6FYOTOA0+NAZFCnSSnBukzcydBr+u7h2x38+KdJOwV6Wbgv/UcN+NqJj2UhXMr3b0qQim74sCXro0PYYex9YsNhiT5Y6KCvAhvx55hMkq/2158Vq0jLXHLhQtvTCWklqeu1UZLN9IIF4mZmwAfYJ5VTIPX19cFU8n2WybgKzPpKLBLrGUqqW1CQHfo8uxEz9djOxB7yPYA2/Pu5RPw6mp1DX8LuY2ZCqpdSr3/G7afI2vwhhhDfOMocyAmVvGIbUaf//MK7YwiVshDoxizxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(41300700001)(5660300002)(7416002)(8936002)(8676002)(53546011)(66946007)(66476007)(2906002)(66556008)(36756003)(316002)(38100700002)(6916009)(4326008)(83380400001)(6512007)(6506007)(54906003)(26005)(6486002)(186003)(86362001)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BLMiscFb/l38q5v9rKWVgTOKvNL6flEX4q6z7amB6e6fqKhhgVWa35FzpJo?=
 =?us-ascii?Q?h1zvVFDl55H5GvjnTZmb5dIvuPe17SSLmiklxQm0b2N/3SKKlLGb/uC+aEM3?=
 =?us-ascii?Q?yVdP/bz3ZL726HSycc0HCEKG5e5cyFRT5smlOINXzYxv8UASh3Be3ddZsYim?=
 =?us-ascii?Q?wWVLk7CrI16swlbqeGhjWCuweW1OChAhm9vdT6Sf1L5l1kGZHlFc9YNj9N4C?=
 =?us-ascii?Q?07mdQZynJ6gXpsxFv9HJhNopFPsJcmlgHaIsg+VK5bQG97UkobgHIMKHgiQ1?=
 =?us-ascii?Q?wYMs6RH5eLCC1mD5pmuVWLWgaphM32gsTCqL25KUg/MSTWGhKqWQAGy5BaDu?=
 =?us-ascii?Q?w1PqmuFc5ZWWe96KLZJHvToM6nyNBKRL8CmsulxMHeKP7bg5xkLn8q++Y35X?=
 =?us-ascii?Q?NtC3wx/lMG8vJ045NcwWipvbWL9LjURRK1NaNZvlSKiLHz6zrQruIuSYANc9?=
 =?us-ascii?Q?Gwz9mfyfe+r9yj5wx8kVG348wWZEShp3s47IXXSe4bNNbvEfQQ7+/jQYCypG?=
 =?us-ascii?Q?HiQsAmj0O1M3PHFY3bAdVhzsfyErgEEI4WIEs4xBsJ06DX68tnbCiMq3M7PD?=
 =?us-ascii?Q?08T9mUpucmBhNZ3UW9ZOCVwk5IgO9E3iVUNGJzD/MkYxoY/PqW0ribDJj3Re?=
 =?us-ascii?Q?Pzza62TyfnTlxryPHwwrdOr4AC1v1lRruv/8B18WDAo+mGjbAJ5ZsHOg8aif?=
 =?us-ascii?Q?tSRWeLXRZLjxRSbR96L9+5WrEUfS/PLtRjCSH0bVc8hTIZEjNto9MX3AMh2f?=
 =?us-ascii?Q?Fnq38KhBni+Tz28cFaCxVl+q8R2kl9lf8M8XcjqyWH178s0TXqofTvqwV5F+?=
 =?us-ascii?Q?uggo0cQaDd0B5SBQMswDdMFKC5KuKDtOjhv/S8d/WIYzEgOX0YmfDem0k027?=
 =?us-ascii?Q?RyayvQAUwZityYuTMNcKLTKidc7At0122ZRDGKA9h1Ld1WCitymhHRVQch0p?=
 =?us-ascii?Q?Y7efhXVq0wIvH+S+FsfxgsJ0spZsgQDrFNHGZ9cULYOblLlm0+BvB+aGUP2s?=
 =?us-ascii?Q?HqdnwfsBBOWTdEsm/O1Z5S8uVOWmbnnNWlxJ48hTaKuX+E7644K2vhmXBJYo?=
 =?us-ascii?Q?DhPFmx79ZOZxmts3e7aSs2B3nvucyI/y+XYtJZxN+LG2qs0sVofu1TzTp9Ll?=
 =?us-ascii?Q?E2V83n+t8awxiqkeH4+bCoZMgkIAe9+DO/pjk5/f/VzQzy2VQ5hLkdW5aPxm?=
 =?us-ascii?Q?J4JGPSNCjGAB3PBF+IlVAxP0gF9h+jq/I6UfXKhxHWoN5y7oXJnYRdfgWIPP?=
 =?us-ascii?Q?ScrVN910qVH2WRyrf1RDNsvsro87KsXMrBf0t6kkOCuen7mqL/vdjmiNlHJ5?=
 =?us-ascii?Q?DGhgEdhZQQY+XCs4eNpYamHD0MCfq7JPq74mNFZZAhUt6cms/LRrLjxllX2o?=
 =?us-ascii?Q?SkPEd4VA2hcgnO+wSMcAWBbUJzQpsZXUuim713ZtE+FUYRjqxZSc+o2+KXv+?=
 =?us-ascii?Q?tlYUgY6RCfwklKmB5dm8GP4SQy/hu3FYIDznIeULHyQvB8Vh5LXPnRTJFfp6?=
 =?us-ascii?Q?3YVbk4wvIDvvyU0zu2R0SdJxvPVVNOYJSbSwWhEDjNIA2j826FrfnRGTysLz?=
 =?us-ascii?Q?p0mLr5IDUxtAunWHRa9lJSFyAGaB8vGyd/VCoEcM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f0c2d7-b793-40d2-7f45-08da9b39003a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 18:50:34.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIo0mfQPvyD4wymubR5M1KAqpYtOBghsJRJE/sjAeQP8mNvMroKIB3XRDzh7zolw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 11:41:04AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 20 Sep 2022 13:27:27 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, Sep 20, 2022 at 09:06:32AM -0700, Dave Hansen wrote:
> > > On 9/20/22 06:14, Jason Gunthorpe wrote:  
> > > > For this I would rather have a function that queries the format of the
> > > > page table under the mm_struct and we have enum values like
> > > > INTEL_NORMAL and INTEL_LAM as possible values.
> > > > 
> > > > The iommu driver will block incompatible page table formats, and when
> > > > it starts up it should assert something that blocks changing the
> > > > format.  
> > > 
> > > That doesn't sound too bad.  Except, please don't call it a "page table
> > > format".  The format of the page tables does not change with LAM.  It's
> > > entirely how the CPU interprets addresses that changes.  
> > 
> > Sure it does. The rules for how the page table is walked change. The
> > actual bits stored in memory might not be different, but that doesn't
> > mean the format didn't change. If it didn't change we wouldn't have an
> > incompatibility with the IOMMU HW walker.
> 
> There are many CPU-IOMMU compatibility checks before we do for SVA,e.g. we
> check paging mode in sva_bind. We are delegating these checks in
> arch/platform code. So why can't we let arch code decide how to convey
> mm-IOMMU SVA compatibility? let it be a flag ( as in this patch) or some
> callback.

In general I'm not so keen on arch unique code for general ideas like
this (ARM probably has the same issue), but sure it could work.

> Perhaps a more descriptive name
> s/arch_can_alloc_pasid(mm)/arch_can_support_sva(mm)/ is all we disagreeing
> :)

Except that still isn't what it is doing. "sva" can mean lots of
things. You need to assert that the page table format is one of the
formats that the iommu understands and configure the iommu to match
it. It is a very simple question about what ruleset and memory layout
govern the page table memory used by the CPU.

And I think every CPU should be able to define a couple of their
configurations in some enum, most of the PTE handling code is all
hardwired, so I don't think we really support that many combinations
anyhow?

Jason
