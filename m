Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC86462DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLGUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLGUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:51:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2E84DE9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:50:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ7kVpu68FVoHuDLsAFSiP+aHtpJ2kk2mPfyLpzu4E/cxXX50s30eC9tVcNcl352FRNiGCG+7LRWQ1UKfkOIFveE6WoNloj518o5abefphtjNLqB2FHH9ZvPK8iHBfTgwHffk8WMPhEkUZGEDdLxKDHnnzi0oPfkCfZQY+4cfr3qjpdCRRIA03x1a6PW2eEPwj935Q3OpoKhsOkDbs2RYFmVsI1tvfsZSK47o6qqiox0v7ezMYZsoMHdpUr53Is/tpVOBlmoUR31rhiV2pH39cYagjLnlfHIQZpaShl9pDsrio5goOoGLtkvtdFic3sfBK5+dZhpzZvIVOGpb5y2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK1qYl5gsIco52pPWjVN7KeueFX4EWIjuTXGllw/Q9w=;
 b=DW6Y3FtfiXdXpzOhP3oVIoAxz9C21N+g9wZXjJad5kWXJxOP9Nb5EFVGtdpRYgYdMkm52qgBQJlVsj3O5TuzktmRGYlRpEIPQ/MHKGaBXLCsWgPfwFmqeZ0he8Pa5dl1wMrbdb0s3Np36jBgvA6x9JQTSQQFKM4SScnBTD46fvr1GtX3zoxIxHuZ6Mds9r/4NdlZbh9vpb6yzgSJbP15WQKCk2kJq3ELmRz8t1igPLcSpkUOxPu6smrbPwx3Wu3c/t6sKoffHw/KEVKybwSlOl2AU/GpUE5MTciR300sGQPeBMK0nCSKEV9xAWHI3Of68rmEBlS5bkJ+ALVgDcwmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK1qYl5gsIco52pPWjVN7KeueFX4EWIjuTXGllw/Q9w=;
 b=BFn0Z7XmP+bC9iqY8vensQBrhBQAkC54TCAux5bntCclY/Anq6+lmHd2Z0zdsFImEkO/6HA0zXVMeh1W/xsIDfBlD8WOeS/v8EsQJJVal8sIh3Gc6rN7U8Al05Z5VWgHZMNUlQ+ua5BJdFGNQTDEPvAgBo3ZGb9m5uNdWMca7V6+Y8H8WGDffATqkRK5ggxYpp7adzMkA9utMPkNuU4A3IPaEkp+uiYycnZ0sxh7TWW0zDu/kmDdezqw+YNLTO1orEfEl11ooMmYo4UO6v5RKACbFAcxSwbcMO9wCp2XQwehTU8WqQ9ull6HQrjbj9KHWLkozfwcgoX4EGkyYR/FMQ==
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 20:50:03 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::d2) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 20:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 20:50:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 12:49:54 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 12:49:54 -0800
Message-ID: <fea54b2f-2d17-394e-93f6-5d8ce69fd156@nvidia.com>
Date:   Wed, 7 Dec 2022 12:49:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 03/10] mm/hugetlb: Document huge_pte_offset usage
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-4-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-4-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bbdf5e-54f2-4686-8cf9-08dad8949d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tApkI+iTomiMT12gJZaGUXJk/pyrVtgBEEW2HLO/iGPb9YVSCnTgJ49q9ZMwNn6OijEp9RNbRZf/lcaQ7JVosTADPBhMV+AEuiLcZ5P9bgeTKHW0hr7PZFStT3Pc0X63fKOJw4fvdxTzhumqqS8pFtzCiZ1xUMVfMacdhcNm14lkzrLalLo3FQUfrtdleW2+1sNTW0TGw3NsdLFNrPfffAX1Y+XjxZM4xrbzR1rlbQKKcIQnQ9TAuZdSESbhb+SvxH0rOr9eHg2/YgPWa2vjZxrAXmI5uJBBM2Aga/083CjJBRGy24TOOo0YDEwnfpc9knNAn+5o8hqaMlsnW6h8VNuV9Yyiy3f2RbjHux9WuPxOFeJtoZCRJRuoiRmidSXklilBeglgVTqLJxS+3BsVadfQDqxI4haa/PcHL2Gtw1K7iHY4kTgeDAHx6c6k+B29zV/woFzUu2XXYhCwj/KZDSUQD6reqGgFv3dPd/11e2+/0uUHvW+1u9C0s25IZ+2ParpFRf+aq6lCACJAt4e5N8oatmkGyG+OZ7GHIQtKEqbwtDNTa4ZAAwUbqpwdycAkZXG3v6xLIpTC6j398fZXcd+Z26ToyOBJTWCXRCoM4uZ6HByYE1WUn801xuNbwzNmv23QzvwHs/aam6JnrI83MwlcLlefYNqz7e8z/RRGgxVFbBNHHwgmc6FDY3WxLtmL/XwA6x3AgpGcLQzgJnY6U9R9RqMAvJuI0j7pzGBTx9Cf1jp1zM579d0CB6ye8QRTywE7Cvg8fsX3+hS8a+tl9bHquEgewMhH1GIPFqKRsJg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(8936002)(2616005)(83380400001)(86362001)(31696002)(41300700001)(426003)(2906002)(47076005)(336012)(16526019)(186003)(7416002)(5660300002)(4326008)(8676002)(7636003)(36860700001)(40460700003)(54906003)(478600001)(40480700001)(82740400003)(356005)(110136005)(70206006)(70586007)(82310400005)(316002)(36756003)(16576012)(26005)(53546011)(31686004)(14583001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:50:03.2483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbdf5e-54f2-4686-8cf9-08dad8949d69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 12:30, Peter Xu wrote:
> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> hugetlb address.
> 
> Normally, it's always safe to walk a generic pgtable as long as we're with
> the mmap lock held for either read or write, because that guarantees the
> pgtable pages will always be valid during the process.
> 
> But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
> pgtable freed by pmd unsharing, it means that even with mmap lock held for
> current mm, the PMD pgtable page can still go away from under us if pmd
> unsharing is possible during the walk.
> 
> So we have two ways to make it safe even for a shared mapping:
> 
>    (1) If we're with the hugetlb vma lock held for either read/write, it's
>        okay because pmd unshare cannot happen at all.
> 
>    (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
>        okay because even if pmd unshare can happen, the pgtable page cannot
>        be freed from under us.
> 
> Document it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)

Looks good, with a couple of minor wording tweaks below that you might
consider folding in, but either way,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 551834cd5299..81efd9b9baa2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
>   
>   pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>   			unsigned long addr, unsigned long sz);
> +/*
> + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
> + * Returns the pte_t* if found, or NULL if the address is not mapped.
> + *
> + * Since this function will walk all the pgtable pages (including not only
> + * high-level pgtable page, but also PUD entry that can be unshared
> + * concurrently for VM_SHARED), the caller of this function should be
> + * responsible of its thread safety.  One can follow this rule:

      "responsible for"

> + *
> + *  (1) For private mappings: pmd unsharing is not possible, so it'll
> + *      always be safe if we're with the mmap sem for either read or write.

mmap sem is sooo two years ago! :)

> + *      This is normally always the case, IOW we don't need to do anything

"normally always" hurts my sense of logic. And "IOW" is for typing very quickly
in chats or email, not for long term documentation that is written rarely
and read many times.

> + *      special.

So putting all that together, maybe:

  *  (1) For private mappings: pmd unsharing is not possible, so holding the
  *      mmap_lock for either read or write is sufficient. Most callers already
  *      hold the mmap_lock, so normally, no special action is required.


thanks,
-- 
John Hubbard
NVIDIA

> + *
> + *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
> + *      pgtable page can go away from under us!  It can be done by a pmd
> + *      unshare with a follow up munmap() on the other process), then we
> + *      need either:
> + *
> + *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
> + *           won't happen upon the range (it also makes sure the pte_t we
> + *           read is the right and stable one), or,
> + *
> + *     (2.2) hugetlb mapping i_mmap_rwsem lock held read or write, to make
> + *           sure even if unshare happened the racy unmap() will wait until
> + *           i_mmap_rwsem is released.
> + *
> + * Option (2.1) is the safest, which guarantees pte stability from pmd
> + * sharing pov, until the vma lock released.  Option (2.2) doesn't protect
> + * a concurrent pmd unshare, but it makes sure the pgtable page is safe to
> + * access.
> + */
>   pte_t *huge_pte_offset(struct mm_struct *mm,
>   		       unsigned long addr, unsigned long sz);
>   unsigned long hugetlb_mask_last_page(struct hstate *h);

