Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2D5EE401
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiI1SMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiI1SMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:12:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23A7E99B9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkDqnv6PgbA09bYbZX8128S8TmDo73pvZeMma603lZ3/M5e8ftPTkX801Q1t3quZEEiJ9YOPvOeXEQqZMbb+X7uWZO/judBrj8BSc/SuUE8gel0AYDd+C5kvAcQyDvFV41CAAdEy8um5FO75qTBjhRRHLl3KGYxPxiAi5EVTShsoTuodulOTjxqGpvjOV/czFWsCjYQrUzVeCly8+wsyztgpA03rqesXgMJM3bP97EQlbHZu4mw2sfX7dHP2IyqQsq9O9ckp5Wo8YF/k2OV7t9cAX4OxVH4Dv9H4oKEDcQW3hvyJ4iM+rhlvW//18mU8uQHAhNJtadPy3+PSX5BAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6UVk8D2+aBhRkw/CMFmdD4iwl03+DuvZei0WsiI960=;
 b=k/W0J8solZ85Bb5npsM+tHGOwFew82ipMjgSdPwag9IgERBsX+BZy2IPc6ZLo9d98YJ2mJHJ9/MlmaclcSl3O7PVxzKGP90v+UUbge5CtWXafXbc57oTtnAfS48T2R0S1ZoVoQtvhLKkIm1FAFBXjdWUtOG8TKl0AJ0vD7wDdYWLDQRCfhGuedfvOcp9AbGNxdrrRY697gPFb3mKMvfLbaEe9G081Yh6FS6IGsMZbVzonlE/BIYFWkdyeNuU4QyQO3J0qNkuYxhkeNpt4CERBT6EKGoj4/vJVF5vRpUPROpyldI+lm65K3W56JRUtEwRQRtF9MimmiBwBsHciPGg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6UVk8D2+aBhRkw/CMFmdD4iwl03+DuvZei0WsiI960=;
 b=YKeXlMjfn4iPqxojV6CY7Wk1g/QPSeuUPbuoGmS1KwBhy3xS0EjLMtxTAzaY+FRUVQvYOj+c7Ben0gK5gt0qej+VsSlUV8n38F+12kq3s12sJaO0d9ndwJAHniL7NmZDrhCfxERLRwhDX5J+3s0aHqZADESasCWg/wTLdqX1J08Br5kwtwMMJjAeAWlP+bol4hiLqsj3EzJ0MZ9sWGtT6+aKn4LnoAbvbUxDx2UmuHVKIrhtTSXBlrtoz3DmYFFzwz+ZzZQpJe/f6DvlVBqBC5IIKlRNvmTNZ+cOSFA2Yd5DS78/PSHjgbxP28u5eKHyBwk0nPzDirX5yxV9ivazxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 18:12:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c%5]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 18:12:13 +0000
Date:   Wed, 28 Sep 2022 15:12:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
Subject: Re: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush
 and mremap())
Message-ID: <YzSOfHUMGjjQiSNZ@nvidia.com>
References: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
 <Yy3skVk/DvwVnPXD@nvidia.com>
 <YzIHzIxknGNba6CC@google.com>
 <YzI2jzvc8D9lYU6G@nvidia.com>
 <YzJCyTD4kBSt3VlU@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzJCyTD4kBSt3VlU@google.com>
X-ClientProxiedBy: MN2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:208:178::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL1PR12MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: b4715394-a244-4a48-8cb8-08daa17cf7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEK9RpUvqcoUW60ynLoF+FbsGD97HmLcIxXSAQZX9jKbU6Vb+Vce7guGlfjxLtITjEGajR9zeXaOFRN3/Hta8IVab8ofnoI/4c8aOILtOZcTXPyJGiKvSnyj5IHkN5ZboGuYSEQCByQ5b9he3NaY4xb8GKJ7pgz3GbnuO4Ji4f2vebhH18N1qWL+fw/64q6Oy6rYpNEAF7jU2kuz42rh4K0iJckxDihXcCoalfhZPADFYXb4VqNaIdGBM8jUboG69JXpBJS5dZHdbulYFrvJgzIWTngF1Fgs5mL8TAoapSiiD7jkwHz68Ko4TkIhXFdEKLtI1lh8k3AvxE1bJwTLKeSIq9h/9f2CeDkqhh9hU9iKJAzMYNA0tG0e9/L5V9Rrq+PqcHgDji8OQajUiVizEhk8xx+D8ulxmSgLRpsC0yvtjjBDFqQDYG7p/s4ORA7Bjd5HHqTtslgXstplHwbce0WjfGaKgUfOtWLNgsTTi34QNAr1+vKZiebF3Oy2CIkIDek9vT9ez/KBdLTihB3x1xaSYjkXzC3O6eqYeVfctfB2qVIDI6lwGcN3IvbLmFPHifUUpBZfvvLytEh7wpSSWmK3ZnW8ds3Vl0A2mi0zl8nQ9XxdHbCtFoY0KPpnlB9e/2VmfsVEWaeoCpOQF/A4epEs7+53gGXqDOe0Vqs9yBn63HR1zqOkZLJItaS3gJZVS5OTKRs+uTtLe+GArf7kSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199015)(2616005)(83380400001)(38100700002)(5660300002)(6512007)(2906002)(41300700001)(8936002)(186003)(66946007)(478600001)(6486002)(26005)(6506007)(66476007)(4326008)(8676002)(66556008)(316002)(54906003)(110136005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvT+QM1YDgfX7zDxbWfjeEgYhxZQMaGJuyVfOq7j2R2Ga8m3x9SdMAxYUMjR?=
 =?us-ascii?Q?m+Lwz/6NIiePzfAyqJ5EXGvI31RYXpatP71dLSP9qSUCxGNLzZpXhQK1svQO?=
 =?us-ascii?Q?QYzNsBhLNeslTyxbjIlGdUh2wRxaWiI9kfOLXiJ6N5OAJUHiiDYLgJRd/dSb?=
 =?us-ascii?Q?aN/e5rhvkFuMauHpzDvs1nt99FCsVGciSSSmD5wqHXVgEk8tVKbXyzjTSDL2?=
 =?us-ascii?Q?PR3tO7Ik83IHxSJwPs01vRyOX2g1/SXZEWuVYD73PV3O8V/rqvZsCbGg+MuD?=
 =?us-ascii?Q?DRGhJSfcQlcW7MlfP9yQKEkbZtjbblKW8H9y8y7dyyOe3ZyNYY/kydlPCfSj?=
 =?us-ascii?Q?aQzIAAdCe4Wrh62tUL/zmo+plDg0HpyysEW6vYHFbhRech/U0cEe3/taywmL?=
 =?us-ascii?Q?CyzI2ifouy+BFwAusGLlb04lirMOd12GusNMCdVmun0mcXUOAaL+KDzbrS1h?=
 =?us-ascii?Q?un1G1otAqEQ0hqQknqhQk8Su/PhRB0F9xZ8oaohscMZjfY/tOVsku9tZFCrb?=
 =?us-ascii?Q?o6r5ZAVfqPH6StBbZ2r+RSlxXIa/zhSpdYfWvlHca0bJ6syI/nacV1wQBE/L?=
 =?us-ascii?Q?+QJdx6zYfufhaHlzp5iE5TNgGmfYxun78kA9hMkaaXCe27+oLy7zFdOmgA3T?=
 =?us-ascii?Q?2SXlG3kFtO+tfCC7+H/IDNVYC/1AXRpr0iUeGp+8S8sycUNZT8fDHXrUrxuV?=
 =?us-ascii?Q?XrTmzC7NPLaltWYPAPxTUvk0oiUojzsD+UiFqa3BWfkWXLK6XbEND4tPzPT9?=
 =?us-ascii?Q?dtUjT1DHakkrog+fZeYnMhm8xLXXjBxRsQfTOWmo5AyUnwDOlDssqiTRTWqh?=
 =?us-ascii?Q?3qBBNpPhIRsSG/uKeDLwSiYzuxGTbQoVdsZmYXztSDttSqum6CUT3ku6fu7I?=
 =?us-ascii?Q?wkiTwlrDXdaLF2KMXWJhYs+pCUid6Yf+mJ969YIM+UKS5mt85rCX7OLuyARk?=
 =?us-ascii?Q?b2a1N98UvKvRjLKrdZ9OENxGT5jUeTARIlVgqty7hyIAIW5LNl3ClFnwYcva?=
 =?us-ascii?Q?qzWuL/JoIom6zorGLrGjaMcTN9y6eHS5TnriBtG5haRUVuKiep0/bIw1n5qA?=
 =?us-ascii?Q?BQyZcMk3IIOjG2F9NewivqVrl0Ab3V7IdcNYVOAV/wWTNNBuCwKlmu+q3210?=
 =?us-ascii?Q?wBVtwjaDC5OkMxZhVSif0jw/U3O3iYh6l9bQDoXEZ1vJX8RCReolw58DMwd4?=
 =?us-ascii?Q?LDv1dmfsUM675mZmmazV8ZPIwc+mHkg5kDKP6h9DWGstbuZBSg4MyhzkMIHS?=
 =?us-ascii?Q?qs4rSs7KURNCqf+1tHt9LXFSHFgzWNGTS8nJ1XmfTv+bW0L9AfWBOE0aQnY4?=
 =?us-ascii?Q?zi0O8ClWjiv0D0YwKekN/MrFPLJqfptL5Qj63MNf7JySe2xCbtl/TGOPgjmP?=
 =?us-ascii?Q?WE1vFfQbD1HWFdvlRAVWD5WfGXb2dQBbyByU8K3OZZlu3+wLoqDbBl2G9/Te?=
 =?us-ascii?Q?8eKVcrA5u6CoDKiK9LA+o+6p+Uq9ZftudmCkzsokccMQ4xjO6vqZsNcU5DgA?=
 =?us-ascii?Q?V8vSlCVamqbLixjhK/4zs/MQZtqKyQfVw9JhxVxDFCus+mA6Z+wAxfhedxlp?=
 =?us-ascii?Q?/ZUV34rR7rvseMnBFug=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4715394-a244-4a48-8cb8-08daa17cf7ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 18:12:13.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNuTDdWAThA7vrHSvw9Rd4u9Xj/vJBmu92kMiAuKLll/wxDIyNtmkuJ3KhVyKUR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:24:41AM +0000, Sean Christopherson wrote:
> On Mon, Sep 26, 2022, Jason Gunthorpe wrote:
> > On Mon, Sep 26, 2022 at 08:13:00PM +0000, Sean Christopherson wrote:
> > 
> > > > AFAIK if we are flushing the CPU tlb then we really must also flush
> > > > the CPU tlb that KVM controls, and that is primarily what
> > > > invalidate_range() is used for.
> > > 
> > > As above, for its actual secondary MMU, KVM invalidates and flushes at
> > > invalidate_range_start(), and then prevents vCPUs from creating new entries for
> > > the range until invalidate_range_start_end().
> > 
> > Was it always like this? Why did we add this invalidate_range thing if
> > nothing really needed it?
> 
> No, the invalidate_range() hook was added by commit 1897bdc4d331 ("mmu_notifier:
> add mmu_notifier_invalidate_range()") for IOMMUs. 

Ah, right OK. This is specifically because the iommu is sharing the
*exact* page table of the CPU so the trick KVM/etc uses where 'start'
makes the shadow PTE non-present and then delays the fault until end
completes cannot work here.

>     The page-fault handler in the AMD IOMMUv2 driver doesn't handle the fault
>     if an invalidate_range_start/end pair is active, it just reports back
>     SUCCESS to the device and let it refault the page.  

Yah, this algorithm just doesn't really work, IMHO.. So it makes sense
we have invalidate_range as Joerg originally created it. Though the
GPU is still busted IMHO, there is no guarantee of forward progress
after some number of iterations, it is just much more likely if the
non-present is as narrow as possible.

So, then we can see where the end_only thing came from, commit
0f10851ea475 ("mm/mmu_notifier: avoid double notification when it is
useless") and that long winded message explains why some of the cases
must be ordered in the same place as the CPU flush, but doesn't
explain very much why it is OK to push it after beyond saying "ksm is
OK"

Looking at some of the places where 0f10851ea475 removed the notifies
they seem pretty pointless.

- fs/dax.c
  This never needed notify in the first place, it is populating a
  non-present PTE because it just faulted.

- __split_huge_zero_page_pmd()
  Sure, maybe, but who cares? The real fix here was changing
  __split_huge_pmd() to use only_end() because all paths already
  call invalidate_range

- copy_hugetlb_page_range()
  Sure, there is no CPU tlb flush.

  The CPU tlb flush on this path is in flush_tlb_mm() called by
  dup_mmap().

  The right thing to do is to ensure flush_tlb_mm() calls
  invalidate_range and skip it here. But the reasoning is not some
  "we are downgrading protections blah blah", the logic is that the
  CPU TLB flush can be delayed/consolidated so we can delay the
  shadow TLB flush too.

  (And why does copy_hugetlb_page_range use MMU_NOTIFY_CLEAR but 
   copy_p4d_range is bounded by MMU_NOTIFY_PROTECTION_PAGE ??)

- hugetlb_change_protection()
  Again I feel like the sensible thing here is to trigger the shadow
  flush in flush_hugetlb_tlb_range() always and use end_only

.. and so on ..

So, IMHO, we need to rewrite what 0f10851ea475 was trying to do in
order to fix the bug Jann noticed :\  That is bigger than I can knock
off while I write this email though ..

> > That means iommu is really the only place using it as a proper
> > synchronous shadow TLB flush.
> 
> More or less. There's also an "OpenCAPI coherent accelerator
> support" driver, drivers/misc/ocxl, that appears use
> invalidate_range() the same way the IOMMU does.  No idea how
> relevant that is these days.

Yeah, OpenCAPI is the same stuff as the IOMMU. Just PPC got away with
building all their IOMMU layer in its own arch specific subsystem :|

> I much prefer KVM's (and the old IOMMU's) approach of re-faulting in hardware until
> the entire sequence completes.   It _might_ be less performant, but I find it so
> much easier to reason about.  I actually had typed out a "can we just kill off
> mmu_notifier_invalidate_range() and force users to refault hardware" question
> before seeing the above changelog.

The key thing this requires is the ability to put the hardware into
fault mode (non-present), for the range under invalidation. If you
can't do that, then you can't use it.

> I don't know.  I found the series that introduced the behavior[*], but there are
> no numbers provided and I haven't been able to dredge up why this was even looked
> into in the first place.  From the cover letter:

It looks like a 'by inspection' project..

> If I had a vote to cast, I would vote to always do invalidate_range() at the same
> time the primary TLBs are flushed.  That seems completely logical and much harder
> to screw up.  I might be a little biased though since KVM doesn't benefit from the
> current shenanigans :-)

Me too.

Jason
