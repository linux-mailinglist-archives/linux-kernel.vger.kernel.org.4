Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F8564650F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiLGX0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiLGX0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:26:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE7D89331
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:26:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcCargyC3Vrffz5fx/iHycO3EuI6D+C0VCggGQ3cCiuOa0TYnor4v8qOLDz2fsKgePSZrqMw/vu8c2kKj4IPtXtvpPG6pjisOFFHeV2mt7gPXoxgXJfSQWvNyRiBXQuoHsN9lbFOC2dOV8Pl3sQwn3YXD933StNcz6AZCbIlX2Qnd2A2T942Q56+dExdv1J2MWdeOO6Rr9YXDEYZMqE3dXKEThFk/yMHmwY/i003nrMji7O+f8kTSm0Q8bYo7/3BryMtVPzfzWv44asCaiUvGXFKwF3Ox4B7LlHvZe0YgzszhAgdb8603xN6m8tyM1/E73Mc6m2+6XRrkvXxTV2EGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eXF+dmk2x8g823zIR2MJP4K8DoF0lpHCRBsC1lRdYA=;
 b=ZDIo2L5JAyWcPfVjP5W82TXoGPeNMoH9MqaznSBva6nQx7/XvoVaUJL+ehmlRTTL8v80yzc4qon4du0MST9afKOO70uMdjZS27b4a9ae/zO5pQs+rbvUb+HAzkbzzuONwZXgabFh6AvFRHD6zQcn2/wIu+DNM7BNH26An4fMDWQsRhSNYsxjX2xEeZKIb05unCA6tktCmTcrgm0eDcMj9iL1Zu+JexHhcZ9WNQ3QwIjUnz/BFOcIlyN/Sk6jKZQMoYhlQoBXaHllDURS+TpM+NQ798a2DGIdY0qyaF68EOVTEzQRVbAu6RPu+0KROoMS9mfs/gMeyKRl4Apbx+98Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eXF+dmk2x8g823zIR2MJP4K8DoF0lpHCRBsC1lRdYA=;
 b=QiiBDr13U+WK/AqWc0o5deo+rO8tPVmU4ClVpQCJtSPoDhCHDR/ZlrlZm93yhpIGbblubePJGriOwhxd1SnA7gSJBIY3mrAgcBE+8ZLeBxFHUziXk1UPj4tX5jccS9k9pU+JW1B/BHTACNtpcvBzeXw3M7Lv3Xz9/zCl5nY24Sa1r/t4L+d97xdac76Mey1Om8yhnGMAoANJz+H9xw4U3n4q/KCLcRN131MZKBzI1LVwRWfER+aKQEkUEUEXFzVe9oRT5FkMZqJ86dH/qsQ3aUs4b33p1RRmAbTGLE6IA2hkIhZwWinADVc34Srn+nXfWw6qGRXbeA1L1fARL+XzXA==
Received: from BN9PR03CA0788.namprd03.prod.outlook.com (2603:10b6:408:13f::13)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 23:26:23 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::36) by BN9PR03CA0788.outlook.office365.com
 (2603:10b6:408:13f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 23:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 23:26:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:26:00 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:26:00 -0800
Message-ID: <acd70cd1-e930-8cbe-b962-da0715c9d311@nvidia.com>
Date:   Wed, 7 Dec 2022 15:25:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 07/10] mm/hugetlb: Make follow_hugetlb_page() safe to
 pmd unshare
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
 <20221207203034.650899-8-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-8-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e112c3-3a36-4b9d-14fb-08dad8aa7450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luc8ImbE4Sryg4E2oz1/VvzjVkEYvT5mtkxpACe/vvo2g6I4t8Ee0Sz+AhZCPZQ6ggwPm7jW/9DILlNwTYx0z8ATqlXV9GTKuYvM4KM1PyhCI3FFbnPx73DFskkWdyGf0jmc1KvsEtPDqEfN+NnMb/9vkoQtCFQVk3739kx6DZmenAEshuVdFDgnpI7oF5PjUtcjjoF/9jrRpR0KAIhj+u7W5siSxmuJwk+KOs8Qjzxbw3BJzol/lNQ/vCE/sh7gTuvwINwTN9gOvDnJ6sbaj1hfvWw/C2D4zLCW7iBUo7QA+L5TBdN1gJxHRNFXnj+yEDDqwsGqFD/qiRwbgLlcBb8xzr6DNRZ0Qwa2BvmUUyU4R8DeUzRuV9w0wt+B4tVm6MjRfvtKkvCkwdfxqt7OvStBdsKwDS4UVMpDoL7Sv091BCdH/Yjqjx3pz52HMALYwa1b9Ge6kTXqibuFUIgD2fBbNUJGuDl7TI6zk+U04Clrj+Zkx18nvepu2/MetN9YPtPJLxgB9TLqpG08qa+NxBMq/8nNTLRbZjJY+FP22Eux1saGlcL+vuLwLj5hUjYW7iIF3GuXswHvfFwVjAdmUHvSUlYaYNNI4lx2bVzhq02Pu+7+Bq15rfqSyFklAUM1dvYSs2Mx2R7B1rYuUjJBtyG8XRJYvjBTHySgq54gtO8S5NTWP+SHp6oYbQj1dijLOx5gW+InRgV28Trlkd9d5GNPAY2xrlnIaOeu1rAYJxcYSSEjBUuQYsCgfUu4cB2U
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(16526019)(186003)(336012)(31686004)(110136005)(54906003)(316002)(478600001)(7636003)(82740400003)(356005)(36756003)(40480700001)(40460700003)(31696002)(2616005)(86362001)(16576012)(83380400001)(426003)(82310400005)(47076005)(26005)(53546011)(70206006)(7416002)(4326008)(2906002)(36860700001)(8936002)(41300700001)(70586007)(5660300002)(8676002)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:26:23.1760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e112c3-3a36-4b9d-14fb-08dad8aa7450
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
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
> Since follow_hugetlb_page() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3fbbd599d015..f42399522805 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6284,6 +6284,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			break;
>   		}
>   
> +		hugetlb_vma_lock_read(vma);
>   		/*
>   		 * Some archs (sparc64, sh*) have multiple pte_ts to
>   		 * each hugepage.  We have to make sure we get the
> @@ -6308,6 +6309,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
>   			if (pte)
>   				spin_unlock(ptl);
> +			hugetlb_vma_unlock_read(vma);
>   			remainder = 0;
>   			break;
>   		}
> @@ -6329,6 +6331,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   			if (pte)
>   				spin_unlock(ptl);
> +			hugetlb_vma_unlock_read(vma);
> +
>   			if (flags & FOLL_WRITE)
>   				fault_flags |= FAULT_FLAG_WRITE;
>   			else if (unshare)
> @@ -6388,6 +6392,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			remainder -= pages_per_huge_page(h);
>   			i += pages_per_huge_page(h);
>   			spin_unlock(ptl);
> +			hugetlb_vma_unlock_read(vma);
>   			continue;
>   		}
>   
> @@ -6415,6 +6420,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
>   							 flags))) {
>   				spin_unlock(ptl);
> +				hugetlb_vma_unlock_read(vma);
>   				remainder = 0;
>   				err = -ENOMEM;
>   				break;
> @@ -6426,6 +6432,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		i += refs;
>   
>   		spin_unlock(ptl);
> +		hugetlb_vma_unlock_read(vma);
>   	}
>   	*nr_pages = remainder;
>   	/*

