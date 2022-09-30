Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65665F02C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiI3Cb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiI3CbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:31:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842010961F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzEuKX2Pw0y59jkdaWQcd1VAGYK1xfg9QajtQHRxdeoaFk0o9dbXG5bMc+SKR7gDTCTm5uCV2nwVO6h6/0V1TEROikKsR0mqqzlT0qMartu0wLosjfp+0q6fNp3uGgy33vNgnKBfdBtgxVF2W0MdvuISQHHo3DvBoOIr9tw+DF9DU1f+sa4LvSWZhLK5kCPPFJABTGsj85ZZp6Cha21hgeTIGG/oSvQpQdhFNIFXr6En0Lxb6nKEvbD+UOn5/YFy3I1EDI0Xf465Qa/Eh+R4+5x0URIwP9DFvYmw26bg1rdlNDyNKxFCbdC1K1mlD3f9LnksbRNHkHx1Bs38I4lqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBr5Q8GiPDI9nyZkXZ4mIVIqwFXTeYVostD3DyIw7NE=;
 b=d+ESEwwF8uhj/UYb34weZB9hizPECLVgybqD5sp9qV/EzOrMoEyuuhASO12SfiRnvfYeompMrWLADeJoy5vtPeidZozY6yLp02SK9JR+Wj/Fq3abIXUGayMsWSASxGvZFdNT2D3mFm2k/365kIT/QghkPfY5jPMI1/QEHI1FUJ/0/wIiLnfae9wqH84fIRepi0aJEo0+K59/QEC/HzX4ud98ednSEsgBCGTx4yTOmCOWtrX+ErbIJm2hGhi3HobU2dsmUzau2+JYN3cDf5YekeY7Mc/sZLfrpUVqePqWf6JhYus+eNKmByAqF2SGcK2Y05bHb5ZutSclExf/J2WspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBr5Q8GiPDI9nyZkXZ4mIVIqwFXTeYVostD3DyIw7NE=;
 b=aL61V9HRzMpQrDDG+DqyGy6+v+EjkpLfVH3rK5ypYSqH5qe/nl1wRNzLZHOfRqZacCyg936anHopvR5OEHb7ZhjeJVii6b1m+iZ6u/yRj+K+qFy5ST8j28N1xasuOhFyaM4xtSHvqhqIAixj2d4o9Rz2G0kbfc6PQ6MKtvPDe29XB8u5C5Y5ZolBMG5OhQYXV6ZExzWn0AoCQ3/yHyh7PT9E5iu6tKTYNe5U+bABdNgTwVDO0tcr6NxRO7CQFkhsHxzRth0H+eDvU2ZYOAwMmF9xY6PaGoAPVjM5SLfn32DGFAK0pHeuy4L7wGmBZKs2RFKBnScFX5Hsvb1Obdh1hQ==
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 02:31:21 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::73) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.22 via Frontend
 Transport; Fri, 30 Sep 2022 02:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 02:31:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 29 Sep
 2022 19:31:05 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 19:31:04 -0700
Message-ID: <bd235db0-8355-2038-3b71-3b17cde91293@nvidia.com>
Date:   Thu, 29 Sep 2022 19:31:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush and
 mremap())
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>
CC:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        <jean-philippe.brucker@arm.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>
References: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
 <Yy3skVk/DvwVnPXD@nvidia.com> <YzIHzIxknGNba6CC@google.com>
 <YzI2jzvc8D9lYU6G@nvidia.com> <YzJCyTD4kBSt3VlU@google.com>
 <YzSOfHUMGjjQiSNZ@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YzSOfHUMGjjQiSNZ@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcba1b3-e74e-4d00-d5e1-08daa28bdcc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQe/xqjXnTw2k5mKYaqYpTK+WwqJ5QfGEW6dHp1qW8uEE0V7PPBkWgkffG0YNCRh4rezF0O9AtbiV9Xd4N+IZf6pozIwrSfOO07aErhm0xjmGlyIOnwIUK/MCj2s10oQ5zZoEn8NbHOWHsWOoFDSZFcK09C0X0ipL+WmPhsrbw0tzc0xGv8zOiKELBXFQJ/TAZ1G4YVn3C6LWzt1btI9c6006bct1Eus+Ow8GnTe2PhywCADI3iQxsaWr0ftRfGW5LcuLs0YkIHpIb83uKJ0Dc2cKs6xTVqmJ0u0bRqn+CvBYq5+ZecQuqTtFWfxtc72oJQuaYqx25r3WfWpytKXejSJKS3n4EndFm5R/s4frAfTM4BjkaqWYOrIGDjejzu+o5NjXdm8EOtdn8L6T9AJFRzb/dfE2lTWSfqDNblbjo1d8ZMablETBlPkEZVWxGDwRRIO8OQoenhQjZY02sR18DE/657twIy27CDlllSKGw5YWwrQxmL4EVQ2U7sfBV4JjNYpQiOADsNQ9kmhD8311gICF0Iu6qY+lm9/8bNgUqwVoEUbIFWoN9gFJvAKFOsHMTISc09ErRON4UwEJgR1ZAQdAJQAV9VjoIKiXTtdxDoyTuDa9AZviPs8ScP2LKeLAvrk71TN+9skBS83Hh+++eo6y0pEvGanWnb4/BRx0/+AG1Y73wHPN346kFjAkj0rSuhtGsQPmJpoX+Pv/XcsoyEWh7YVORrPgL1TjO051iFUREDGBm9T4YnpMQY7mGa6n4kNGEN88gfay5iTIJRrKEuyTsb9uCKV7petCXifG1GGfmgXu/Eh6+0I6P5nMItJ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(336012)(186003)(16526019)(426003)(478600001)(47076005)(2616005)(5660300002)(82310400005)(86362001)(31696002)(53546011)(7636003)(26005)(356005)(82740400003)(40480700001)(2906002)(83380400001)(40460700003)(36756003)(36860700001)(70586007)(316002)(16576012)(31686004)(41300700001)(8676002)(70206006)(4326008)(110136005)(8936002)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 02:31:21.3152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcba1b3-e74e-4d00-d5e1-08daa28bdcc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 11:12, Jason Gunthorpe wrote:
> On Tue, Sep 27, 2022 at 12:24:41AM +0000, Sean Christopherson wrote:
>> On Mon, Sep 26, 2022, Jason Gunthorpe wrote:
>>> On Mon, Sep 26, 2022 at 08:13:00PM +0000, Sean Christopherson wrote:
>>>
>>>>> AFAIK if we are flushing the CPU tlb then we really must also flush
>>>>> the CPU tlb that KVM controls, and that is primarily what
>>>>> invalidate_range() is used for.
>>>>
>>>> As above, for its actual secondary MMU, KVM invalidates and flushes at
>>>> invalidate_range_start(), and then prevents vCPUs from creating new entries for
>>>> the range until invalidate_range_start_end().
>>>
>>> Was it always like this? Why did we add this invalidate_range thing if
>>> nothing really needed it?
>>
>> No, the invalidate_range() hook was added by commit 1897bdc4d331 ("mmu_notifier:
>> add mmu_notifier_invalidate_range()") for IOMMUs.
> 
> Ah, right OK. This is specifically because the iommu is sharing the
> *exact* page table of the CPU so the trick KVM/etc uses where 'start'
> makes the shadow PTE non-present and then delays the fault until end
> completes cannot work here.

ohhh, is this trick something I should read more about, if I'm about to
jump in here?

> 
>>      The page-fault handler in the AMD IOMMUv2 driver doesn't handle the fault
>>      if an invalidate_range_start/end pair is active, it just reports back
>>      SUCCESS to the device and let it refault the page.
> 
> Yah, this algorithm just doesn't really work, IMHO.. So it makes sense
> we have invalidate_range as Joerg originally created it. Though the
> GPU is still busted IMHO, there is no guarantee of forward progress
> after some number of iterations, it is just much more likely if the
> non-present is as narrow as possible.
> 
> So, then we can see where the end_only thing came from, commit
> 0f10851ea475 ("mm/mmu_notifier: avoid double notification when it is
> useless") and that long winded message explains why some of the cases

I seem to recall that there was a performance drop involving GPUs, due
to the double notification. Just to fill in a little bit of history as
to why Jerome was trying to deduplicate the notifier callbacks.

> must be ordered in the same place as the CPU flush, but doesn't
> explain very much why it is OK to push it after beyond saying "ksm is
> OK"
> 
> Looking at some of the places where 0f10851ea475 removed the notifies
> they seem pretty pointless.
> 
> - fs/dax.c
>    This never needed notify in the first place, it is populating a
>    non-present PTE because it just faulted.
> 
> - __split_huge_zero_page_pmd()
>    Sure, maybe, but who cares? The real fix here was changing
>    __split_huge_pmd() to use only_end() because all paths already
>    call invalidate_range
> 
> - copy_hugetlb_page_range()
>    Sure, there is no CPU tlb flush.
> 
>    The CPU tlb flush on this path is in flush_tlb_mm() called by
>    dup_mmap().
> 
>    The right thing to do is to ensure flush_tlb_mm() calls
>    invalidate_range and skip it here. But the reasoning is not some
>    "we are downgrading protections blah blah", the logic is that the
>    CPU TLB flush can be delayed/consolidated so we can delay the
>    shadow TLB flush too.
> 
>    (And why does copy_hugetlb_page_range use MMU_NOTIFY_CLEAR but
>     copy_p4d_range is bounded by MMU_NOTIFY_PROTECTION_PAGE ??)
> 
> - hugetlb_change_protection()
>    Again I feel like the sensible thing here is to trigger the shadow
>    flush in flush_hugetlb_tlb_range() always and use end_only
> 
> .. and so on ..
> 
> So, IMHO, we need to rewrite what 0f10851ea475 was trying to do in
> order to fix the bug Jann noticed :\  That is bigger than I can knock
> off while I write this email though ..

After an initial pass through this, with perhaps 80% understanding
of the story, I'm reading that as:

     Audit all the sites (which you initially did quickly, above)
     that 0f10851ea475 touched, and any other related ones, and
     change things so that invalidate_range() and primary TLB
     flushing happen at the same point(s).

Yes? Anything else?

thanks,
-- 
John Hubbard
NVIDIA

> 
>>> That means iommu is really the only place using it as a proper
>>> synchronous shadow TLB flush.
>>
>> More or less. There's also an "OpenCAPI coherent accelerator
>> support" driver, drivers/misc/ocxl, that appears use
>> invalidate_range() the same way the IOMMU does.  No idea how
>> relevant that is these days.
> 
> Yeah, OpenCAPI is the same stuff as the IOMMU. Just PPC got away with
> building all their IOMMU layer in its own arch specific subsystem :|
> 
>> I much prefer KVM's (and the old IOMMU's) approach of re-faulting in hardware until
>> the entire sequence completes.   It _might_ be less performant, but I find it so
>> much easier to reason about.  I actually had typed out a "can we just kill off
>> mmu_notifier_invalidate_range() and force users to refault hardware" question
>> before seeing the above changelog.
> 
> The key thing this requires is the ability to put the hardware into
> fault mode (non-present), for the range under invalidation. If you
> can't do that, then you can't use it.
> 
>> I don't know.  I found the series that introduced the behavior[*], but there are
>> no numbers provided and I haven't been able to dredge up why this was even looked
>> into in the first place.  From the cover letter:
> 
> It looks like a 'by inspection' project..
> 
>> If I had a vote to cast, I would vote to always do invalidate_range() at the same
>> time the primary TLBs are flushed.  That seems completely logical and much harder
>> to screw up.  I might be a little biased though since KVM doesn't benefit from the
>> current shenanigans :-)
> 
> Me too.
> 
> Jason
> 


