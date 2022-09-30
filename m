Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAE5F0B38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiI3MBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiI3MBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:01:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E04176AFE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpjXFmTp/g+VzY4HgqeJfWn3MT/3O74wqM/TDYxKwmRkx+cmOuaPQqNE7bX+VT1gXfQvEYOu47vav3x4YhpE3Oel08vwMu0mgAp1WYAxo6EXqJ6368RIoAU/LHc+92z12Nbcs/h8cll7rmJeJPPIJ+R+YQY7sgE7U2Q1R0b1qKJ31ZPCEtCeoqoteE8LV4VCbKw2xygP4p0BGJqHf5Txn5s/2RlVL1E45pYfW53ODUmAbB94df0Owg9hD9HOtOJ8GK84DzxD2t3PWBM8VOPWa5C6JDqUQ0E0AT1PepIPKLozb3U2E1+xWzHZF827sV1zt43mn0KbK2O9inlxG4CjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+bDoDBNNHAQ/86TGrBxqSUgF2nV/V1dwGcXrN12Sak=;
 b=exPoBruZTDLlhyToh2oPiEdnu+8MHr8QaGDNARRkokg3tgmBbiXBMkxaDCnvs9N9IiemisedpqYKsI9GDh0CMxkUkuynYZv0cuveYj40nnT2y55txJHpeM7ob3VZOkGo4zsQ897bzmrl0hTTtLuyHJviQKCOzqypWDgZCqmoMKHolLlgKiaYGZtKU29GJmnTOsEsEH4howfmJrmiQzBFxsn9mKS/JMsBr4fjA8pq00G/YYMToUhREjRlGeFu6kPW0ooEqF5IURmOcelADcPmEeOC14/2BXR6qouGj0/n0LpR6dA96UFuisuG1jM+68gvDhtMkjBSkFAZXSOtEEOHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+bDoDBNNHAQ/86TGrBxqSUgF2nV/V1dwGcXrN12Sak=;
 b=p4zogW7RBiFhZF0CM2aTETlnU4rySsxfexQRh0flF1ouhSkhP/h8s3LRij0K/l7TXNJFoQx91WffNXpXCktsW1jRK/KNjAbV8rCdNqKcELLwA4JP6e0RM0ATgf3X6n64/901d5y9P0nFDKlLSIZTYqgPKqtaqnrPnI+xtL5QRjA8bD9pF2SiwnZgzYu3cPstnaKU7pgcd5XwyEBZscqiXOEd5yTkl/x9cH7+tovztEa/h3QMGtHDHij55xcWQyPSxltTjrRThxH9pK3H+Lt2TOBJT6Cz5LXtW4R+ZehcIwPeolQGDDC48m/hOVaY83aV+9aWGplxwsv1o44Y6/qXxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 12:01:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::8557:6d56:cba9:dbba]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::8557:6d56:cba9:dbba%5]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 12:01:04 +0000
Date:   Fri, 30 Sep 2022 09:01:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
Subject: Re: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush
 and mremap())
Message-ID: <Yzbaf9HW1/reKqR8@nvidia.com>
References: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
 <Yy3skVk/DvwVnPXD@nvidia.com>
 <YzIHzIxknGNba6CC@google.com>
 <YzI2jzvc8D9lYU6G@nvidia.com>
 <YzJCyTD4kBSt3VlU@google.com>
 <YzSOfHUMGjjQiSNZ@nvidia.com>
 <bd235db0-8355-2038-3b71-3b17cde91293@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd235db0-8355-2038-3b71-3b17cde91293@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c61d482-3c77-4f64-75a3-08daa2db736c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/SPZIbZD3X8r8rUDmSickuJxOtUyy4kXiV1j1Yaea/jEtR3tp2nOcSYSwmE3sqpxreu42zh57TeNEaNzATO02pHD3c9EwDAFR4IEEPPst4K0L+yRbwlIm0VAX1iqurlJYrv0PhnxG7+bLQiwjHfoOqHtxM0IiNVBzhDHffqfUNy26Ev7bw8frgJepxsuBD58q7+uVkMtEfLGrhMB5WnW84zT2j4gD9sGtLzrZSXB2mrPTDkbrjOvcQ57KJGqAkT2BMiQjFZlSWAY1mYaYd0GecVUTrpSttxxHz7eWC5TVvICUlcQtgNYa16W5fUmtWyt8GPljPU8ZiIke6pvGOxzJDJkr3mlD8kOSykHDrY+DzeOq/9o3/92h3+zt4PMqks+FgNbKodtFWClNrV9df5d8/XwT1+TdV5VKFukM+esPSMnsS+PABYW00eIa+9v7ZGf7Uj3p5iUO+dR4YmLtzfC9ScpBBDGAMmKL1hDpd/alqo+M69R9TtDw3FiZKzcoA1FNM48i13xXI1iJqjqB1E0RKVvo0ILm5RO0o4SjGTGrUEeOPg2URxBLF8694DxlF4zogx/IBu1PuMlDT7UgoZqbIREwnjBjo7lWda2ZKTHTeshKcHt+xNh2vn3lhKY+EwhK86SEnZ1/QnnbQxh4fOgheTxskxq9CCZgItpBaia2fld9XQpWlTfsZTcr6z7bCR6daO8iZTmHAnxuGPaqDt/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(26005)(2616005)(6486002)(6512007)(6506007)(54906003)(8676002)(38100700002)(37006003)(4326008)(316002)(86362001)(36756003)(186003)(478600001)(6636002)(83380400001)(66476007)(6862004)(66946007)(5660300002)(2906002)(66556008)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDBbRyMnxg2fnI3s/r/z/me+fmBYM/PZhTklzIaU1wrYGE92mhWqJvCYj4x8?=
 =?us-ascii?Q?qZPsJj59X59wMFmTBLYuBSK+WiSVupuIu7xkxHYwWKZeVzlKgd5+Y8grp7hX?=
 =?us-ascii?Q?NKGqKqSCdsUSHjbhdKOfuS+IpR9sl55TG9FrumbUgVfZDkRKuD215su4g/Wu?=
 =?us-ascii?Q?1z/vz+FNz3AeQoi1lxQlDGP8sg7K3S2dgvBQVIDcn4TLwN7L9CUzWAQCakh9?=
 =?us-ascii?Q?cdZgQgtCYP+lwShc3ywuePRtzks8nymbIIql95LYOVDrUqCFH5fQ0FaTW1IB?=
 =?us-ascii?Q?YGbFdGHfh7jExsVrNk7FKNsKylmKznJmFEeEKN7jKdmpks6gXCdo6gMBkab6?=
 =?us-ascii?Q?FTvYqkw+o8Skzxw6j9Je/8HPu7hDMnrRPdtUQkdlIM5H3AMj9Bx5ClB2n+Cw?=
 =?us-ascii?Q?mg+xwz05wbs7e7oJo/4effdsVGFqrVkYcrfmG2D8isUoPpUtHWfjhK7dp4VM?=
 =?us-ascii?Q?yjN2bZxmB1rZumpx09r2vm9TBt5+z6lMfZuiicW8+n/KIOj1GXQdMiucGF/i?=
 =?us-ascii?Q?WmT4gBk4xI1/mG+wQJ5ewoA1SMvL4g765RnH88Fz5egbxU4kRlZhBMqQHJGt?=
 =?us-ascii?Q?7ShWKpk0M5P1p1Wrr1v/HuRr5S3c7GNrRVP8tUeXZjmv/U+I4DVY5qR35+0H?=
 =?us-ascii?Q?vmiHl0ljhb6j7fX5xNT7P7NnG2boBJr5LIqgILOnn95cqLzzrc/UIFnjQndE?=
 =?us-ascii?Q?W5+x7s223l9GuZUKx/R37QpNcS1v0A2rpj21aaWgD/WmFDdoVsSrYWOYhK8U?=
 =?us-ascii?Q?vABBXEE3LRRRm7SbuImQmz2Y1PPruKJtSZeU/mxbINfTWgpThGusTHZLcp8I?=
 =?us-ascii?Q?m0VSwtZ6DWqE12GrwAO/8nTp6hAWhKN+7JOfzBWk0gC/fk17+gbjj2vqiQr+?=
 =?us-ascii?Q?+lGBZ13fpgvOStckTmp+Y131zICWcF8MAIgVGXEgNdGMPIK+8dAoMYhBPn9Z?=
 =?us-ascii?Q?zzlrszSCBnkpE4vSl1ECOwQAnMmq/bPYhn/zUfLUSPB50IxPIxz4JGukUi71?=
 =?us-ascii?Q?sYd/ysUFExxXkDxIoXjq8yFMlCWe0D2k9zg4U1rNBm7Si3ijD3giJzRgE1XG?=
 =?us-ascii?Q?dU0l9DvvWQF2l0I+yc71U9RqPTAhrgJWOKezpDb9inGVuW1L925COYVJewNw?=
 =?us-ascii?Q?iodlYjyu2UlFp2rbWbB/8WCEW5yL0Ko2o/s+rW8CE8jYyfCqHelWeKZJf7D1?=
 =?us-ascii?Q?inRdG6x5kvletEOk/bwBzW4MS5riVXTe8HuWoEJDjS5CwlADWR3vt4CPc9pK?=
 =?us-ascii?Q?diZlrgpjhKDCGpvNsVs+8R2xPH/M+18T1VzjzFdTgrfZ7TeAcRfM6AQpw9dH?=
 =?us-ascii?Q?rUcqnnLe5v5Zs/3lzb/9/ZcoXwTHhsxihfBetW9lbTSlh1O6udAc4ov7Ajbz?=
 =?us-ascii?Q?rfhR/p/11NCq3dKjbLsYhGBFvgtS+NKp5pHrNkTgbCg/+yA+k6Wtg6zby6l+?=
 =?us-ascii?Q?KNu3T7lLwRM/a/aLguNwJAN82gh14PJM+n7zQbmP5B4d1WwhL37/eskPGBeP?=
 =?us-ascii?Q?jAIQAXiHbeX3yb1fgkHM9r7zyGB71cnRoZQu/7ONdLaK0pSLugtGJJyrzWEs?=
 =?us-ascii?Q?VDpzGcloahPkFLOVnhU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c61d482-3c77-4f64-75a3-08daa2db736c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 12:01:04.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRjJUk6A9n/TFrBAaEttCZ7SVSi1pM8w6nfVY0j+ITwv72i4i+l0SRAt/brbGYZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:31:03PM -0700, John Hubbard wrote:

> > Ah, right OK. This is specifically because the iommu is sharing the
> > *exact* page table of the CPU so the trick KVM/etc uses where 'start'
> > makes the shadow PTE non-present and then delays the fault until end
> > completes cannot work here.
> 
> ohhh, is this trick something I should read more about, if I'm about to
> jump in here?

All the invalidate_start implementations have a parallel page table
structure that they copy from the main page table into, eg using
hmm_range_fault() or whatever kvm does. Thus we can create a situation
where a sPTE is non-present while a PTE is present.

The iommu/etc point the HW at exactly the same page table as the mm,
so we cannot create a situation where a sPTE is non-present while the
PTE is present.

Thus, IMHO, the only correct answer is to flush the shadow TLB at
exactly the same moments we flush the CPU TLB because the two TLBs are
processing exactly the same data structure. If there is logic that the
TLB flush can be delayed to optimize it then that logic applies
equally to both TLBs.

> > So, then we can see where the end_only thing came from, commit
> > 0f10851ea475 ("mm/mmu_notifier: avoid double notification when it is
> > useless") and that long winded message explains why some of the cases
> 
> I seem to recall that there was a performance drop involving GPUs, due
> to the double notification. Just to fill in a little bit of history as
> to why Jerome was trying to deduplicate the notifier callbacks.

Sure, the double notification is clearly undesired, but the right way
to fix that was to remove the call to invalidate_range() from
mn_hlist_invalidate_end() which means adding any missing calls to
invalidate_range() near the CPU TLB

However, as Sean suggested, GPU drivers should not use
invalidate_range() because they are not directly sharing the CPU page
table in the first place. They should use start/end. Maybe the docs
need clarification on this point as well.

> After an initial pass through this, with perhaps 80% understanding
> of the story, I'm reading that as:
> 
>     Audit all the sites (which you initially did quickly, above)
>     that 0f10851ea475 touched, and any other related ones, and
>     change things so that invalidate_range() and primary TLB
>     flushing happen at the same point(s).
> 
> Yes? Anything else?

I would structure it as

1) Make a patch fixing the documentation around all of the 
   mmu_notifier_invalidate_range_only_end() to explain where the
   invalidate_range() call is (eg where the CPU TLB flush is) or why
   the CPU TLB flush is not actually needed. 0f10851ea475 is a good
   guide where to touch

   Remove all the confusing documentation about write protect and
   'promotion'. The new logic is we call invalidate_range when we
   flush the CPU TLB and we might do that outside the start/end
   block.

2) Make patch(es) converting all the places calling
   mmu_notifier_invalidate_range_end() to only_end() by identify where
   the CPU TLB flush is and ensuring the invalidate_range is present
   at the CPU TLB flush point.

   eg all the range_end() calls on the fork() path are switched to
   only_end() and an invalidate_range() put outside the
   start/end/block in dup_mmap() near the TLB flush. This is even more
   optimal because we batch flushing the entire shadown TLB in one
   shot, instead of trying to invalidate every VMA range.

3) Fix the TLB flusher to not send -1 -1 in the corner Jann noticed in
   the first mail

Jason
