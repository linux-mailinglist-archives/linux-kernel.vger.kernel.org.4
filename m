Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE35E80AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIWR14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:27:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCAF14F29D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0c3p6JybFR8ZgJ9lRoL1j5NQjSvNtiRx825bj38rKqeGQ+uUU3A2dtVk0QxlAHbCrwQU54lj6FBPb+SfhWILUYQqhgpXKo/MTlzwPFXq5tJn1E/hXc9Lx3npZXoY1PFORsUfs0H6ZA14P8Clg83ziitl9HKsxJQNjDkSbBUsqV2MlgXMNkun8jV3ABwirYthF42JOYt96F4xwUGXeHH36QJpWReVCwaY6B0YwpLtMkoVWVCCsUFFA4OgmHJCrVfVoDvVA/N1gVgu9bLwQT2BNfvKr/e/rlVLLvK1ttrRjNgSq3OC7+4d+ezo/UVC+s3lb54xQUcFdhCzKw6dhgpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0WzX4iCvIaXvAIJ94yg+fO9qcGBZ8978LeSk9QgGHY=;
 b=a1MfuUI3cWeqi5xHVYrSfzjxpiGHmw5u98GRqRgWRr2NASF2rV56ekvFi1w7AC7cTOWdolCkLPnCIQRRivA+2nePygSXQFie63asG7R7Qh6Ch+pRpNDShQ5TEPAwDLFOAY7YKt8B6+0txlXrSDiAR0EyoqmYBrX6MXMBQltbhqii+ildqSNSpnSw93wUyAT7jQAl2BJDoyRY2gay5JGI8konh/F2dkB7rX+/s7jep/UVcYbO55J3igs2v3gOcFujwb+I9jSebyzwYNGb8nRnPCyxSugv63a3TZKJG/sQowaGgTczLQokZV7qzF/JN3NpLDqGtPOsfVfvyhZsc6dlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0WzX4iCvIaXvAIJ94yg+fO9qcGBZ8978LeSk9QgGHY=;
 b=nGNAEsyBLOLD8Me/LKZbYaLVv1vO5lmhsyn31iO8HY/aCw4R9aTpAImgj2RCiLo41qcN29CUTbVoEpL4dTKVQ79ookjVuOL/bkRp2XXzpsatgpsMygY6yAKTa/tFR1cLfx7QknI2MKLg7R31C+nDCFSdFnMfpS4IDfek1zRo8aF/KAzv8GvHLttQ0z6e6zFa1AjO6ihCufKbXFDYHRq0hDMLwcXO1+zko9i+X4sV3fcZeGLYZo+uY/DKtoW4XrZVfTzb1B6RG0+CRa2Sn+kk9XyaWcZN6Pw5/J0OVU74H5GaK1SEl58mmn4E+xkIHBLFsawxuiTacPrGNLS5IYV0Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 17:27:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 17:27:46 +0000
Date:   Fri, 23 Sep 2022 14:27:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jann Horn <jannh@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
Subject: Re: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush
 and mremap())
Message-ID: <Yy3skVk/DvwVnPXD@nvidia.com>
References: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR10CA0034.namprd10.prod.outlook.com
 (2603:10b6:208:120::47) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a62c6e-ade1-4454-aab3-08da9d88ee3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hh7ZoRD86N6b+yVe5TZ6kPebKimCNKDPBFWQYbckKIlgO0SnUMzxL9vztZTYYSG6iSJV1wMGs/J21ztvJreUKe8WO6SzjjjnrplyNhEYH3shZJX65DV6FD5ZhSYUxn2IBwiklDPZ72aaSvJ5Wqr4BxV3pXtQfGpFm38q9H8w1xipTiAfR5VKCoT38HLZGcX6+Xnaqd6ZkV31Po7mK/F8uH4uS3/gfNJaXVn3Xd/sFlj/f4XI7e390ddm7QJ0LMA9m9bnQs9ORmCSPvjHpp93MkAOvA4ZorMXr2UwRtGK04UFR0bY6QsLQmuD+Z0VXvRXT9fF7Phi6EN2h+c0o8eKAqk0srO2svuPM2uxyRy8Et9PmZxVh2NAYaKh07U2e7n2J5JkKfUEN0r7T1vxv47eFcehN+wi5VdOUITykAn4pROmbQZfxW/3Y4RCy/YYIIy+kIZwhJc/5rtr4KqVH8NjpZVKDtGhvNCCHT1cInfetBQwfqQevsTJYQ/xoBUeNOVD08B/DJjpfgglbKZzqf3hYW5rcK5jec0TCdAOHdAz1JYaJzNFBWAuTX/GaOvB2swvBC8stV2araryikT/2u/RyAQhbcATn6avWLdhcqwpzySoLxla/P3vvyq6sNuHpCzEkqeyRzN+1pBvSLvcZMg8dqSUGpj1xnv5fUkh+LvtYolugrhD4x0I1kXvkjJTvYt7N9uLESCgnfO6RZOLj21u3Xz270lBJ9/Tw1njwrJeKUP02kLYut8kxV+IObIxqhxXIUvB7RqaN8+BYkm1UNKfz51WZdrbib4dCWCzEAFDvx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(6512007)(26005)(8676002)(36756003)(54906003)(6916009)(4326008)(316002)(41300700001)(66946007)(66556008)(66476007)(5660300002)(8936002)(6506007)(86362001)(186003)(38100700002)(83380400001)(6486002)(2616005)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A5JCPs7f0XQzq2chpbt0XzYuI40b2s4+FZmQRX9hS9vSThxkpXW4sMF38LWB?=
 =?us-ascii?Q?nCOft6JVh+3403Ml0I6F0Vr0Cue7PKs72YluZ2C+zrc8ZbNFiQQLz6Vm75gz?=
 =?us-ascii?Q?+Vu/BQtenRxW7EQ6NuT9PBGOjVv1pUBjfk5oh5ykSwdpYBBrDZlyFHII2ekk?=
 =?us-ascii?Q?7892P4j9Dp0Lo8AT/NiKMEjHSucwnSa6RpfkLln6w36aONth3RmJJlvuurAN?=
 =?us-ascii?Q?6psUy0S7k8XNXtNnP0yAM2FvJ604broi+EeXhvU2GEV6FA0wXV546IaPsQyN?=
 =?us-ascii?Q?KCnb5mA4oihC67TFp1ouGEtpn/y6Fdk/+0gdEfwkh/6XcaY2DQ4banKOVOLA?=
 =?us-ascii?Q?qw2rIszIGK0KoYNxG8BBRIHdwwoj1PgVhTeHrOoMaxr0nAVVH5BvvxnIG8uv?=
 =?us-ascii?Q?G3Xu7faF6jFaHkTEZLzlA4sDIPIIeyxoVkVhNPKBZkJY3L/9+0Cz2OBLwyO1?=
 =?us-ascii?Q?KFRUXfKswZiQotXgZITvUK5sDKvkQtmkmMbgJ/LLkSBT85M4renQExZmo80k?=
 =?us-ascii?Q?TNob+VQoUDKAB+6zjOkfgFL5XpqjanPlXLyPg9Vig75hxqJdDA/VA9FnUT8f?=
 =?us-ascii?Q?yOLt4SldvtIciyr7B/gAT21Xv8IU6VLaUKvEOfsy0+VaIdbR676buS9zVdgt?=
 =?us-ascii?Q?QPP4KwOdXVgsQ2AS8Vq7I+7BtTCWyckttwnWDM/upmHb8VqdNVpawno+UTMo?=
 =?us-ascii?Q?uiFOSmzOubAfQHxCVylA/WIY/v1XPaQBnE1365jbpKS6IxejQx0daJ/hqxtb?=
 =?us-ascii?Q?s+6korz6FCpAXuAulCuLxKIBZJ7ByaCDaqbe+tPps6Ta5mN7/T1a2zy8oP2a?=
 =?us-ascii?Q?wyDhWCzyVWewxyUpYSqZQ52l3kiCpOAUpKsjOB0l4X6mvF5cHDpGA1ziWj1Y?=
 =?us-ascii?Q?DYXsslUYgzs5qm0O9WPECiHaFnhMkMDl9GO6gOKEQmfZCr4csN8G/l/UYzHL?=
 =?us-ascii?Q?zoHFqf9bkNEqLvLwr958OaCzBPJbci3+BVAvR500ZV8n/kLG2gMLxI+NDRd1?=
 =?us-ascii?Q?v1LoL+iKrppks5POfJ29YHu042urjLpuWTEaleR6eOz6ZmYk3K22JHHjQf5/?=
 =?us-ascii?Q?TdbUowiJgib5lSZYcz4N5GCfEYNWDu1tDDEMDuLn1nDMpo/RNbjXw5ihWXx2?=
 =?us-ascii?Q?ny+st4AIdZ/0ns4CO/L8YMhEeuhbhpksDW6JR061z7+KR6KMA7BG0atsq9P2?=
 =?us-ascii?Q?sNxtHX7p3Hs9jH4qvr5jcuhTalMEUZFBJvt4b269KFv3mqzjhkk910yq1mWb?=
 =?us-ascii?Q?U/1JF4v+2x8GrlNmKZixmLAWUtXwiPAvh1n4F7UJuS2HzUEbvjoU+R5ubTFn?=
 =?us-ascii?Q?+qwa/67EBXC049a7S/DmhczpRVWXaMV3c+oMrm7+Gcm+s4knpX4Hd17sNMAX?=
 =?us-ascii?Q?ecEI96zPExr/M2SqIHadeEExH43n6JfmdqGyRoOB0N8vwbyFyUnzv0O3rmIA?=
 =?us-ascii?Q?MAh3h6bZzrXYzwx9ZWfz01RArQycMbBypjFkpk8tjBX7MeinsYFjch17ygEo?=
 =?us-ascii?Q?gX4f5W2ynJIkWKDmsiuH8OiaT8lORveL2wVBLnsg8J5/JqILdYn72uJUYMYk?=
 =?us-ascii?Q?leeBAMbPQfVwyoLHGUD74KIplRwAcPoUaRBydyjG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a62c6e-ade1-4454-aab3-08da9d88ee3d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 17:27:46.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsaiJf3nvntEek/mf31buHs4bmxWVtoBZqJGg1Ns36Fyt7RCwsh37itXhNMe2TMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:38:12PM +0200, Jann Horn wrote:
> Hi!
> 
> I looked through some of the code related to IOMMUv2 (the thing where
> the IOMMU walks the normal userspace page tables and TLB shootdowns
> are replicated to the IOMMU through
> mmu_notifier_ops::invalidate_range).
> 
> I think there's a bug in the interaction between tlb_finish_mmu() and
> mmu_notifier_ops::invalidate_range: In the mm_tlb_flush_nested() case,
> __tlb_reset_range() sets tlb->start and tlb->end *both* to ~0.
> Afterwards, tlb_finish_mmu() calls
> tlb_flush_mmu()->tlb_flush_mmu_tlbonly()->mmu_notifier_invalidate_range(),
> which will pass those tlb->start and tlb->end values to
> mmu_notifier_ops::invalidate_range callbacks. But those callbacks
> don't know about this special case and then basically only flush
> virtual address ~0, making the flush useless. 

Yeah, that looks wrong to me, and it extends more than just the iommu
drivers kvm_arch_mmu_notifier_invalidate_range() also does not handle
this coding.

Most likely tlb_flush_mmu_tlbonly() need to change it back to 0 to ~0?
I wonder why it uses such an odd coding in the first place?

Actually, maybe having mm_tlb_flush_nested() call __tlb_reset_range()
to generate a 'flush all' request is just a bad idea, as we already
had another bug in 7a30df49f63ad92 related to reset_range doing the
wrong thing for a flush all action.

> (However, pretty much every place that calls tlb_finish_mmu() first
> calls mmu_notifier_invalidate_range_end() even though the
> appropriate thing would probably be
> mmu_notifier_invalidate_range_only_end(); and I think those two
> things probably cancel each other out?)

That does sound like double flushing to me, though as you note below,
the invalidate_range() triggered by range_end() after the TLB
flush/page freeing is functionally incorrect, so we cannot rely on it.

> Also, from what I can tell, the mremap() code, in move_page_tables(),
> only invokes mmu_notifier_ops::invalidate_range via the
> mmu_notifier_invalidate_range_end() at the very end, long after TLB
> flushes must have happened - sort of like the bug we had years ago
> where mremap() was flushing the normal TLBs too late
> (https://bugs.chromium.org/p/project-zero/issues/detail?id=1695).

Based on the description of eb66ae03082960 I would say that yes the
invalidate_range op is missing here for the same reasons the CPU flush
was missing.

AFAIK if we are flushing the CPU tlb then we really must also flush
the CPU tlb that KVM controls, and that is primarily what
invalidate_range() is used for.

Which makes me wonder if the invalidate_range() hidden inside
invalidate_end() is a bad idea in general - when is this need and
would be correct? Isn't it better to put the invalidates near the TLB
invalidates and leave start/end as purely a bracketing API, which by
definition, cannot have an end that is 'too late'?

Jason
