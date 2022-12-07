Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7B2646270
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLGUew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:34:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E4958A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:34:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU+okhXuyJwZqduRWYT9B03ryt2wgA4jPTDn+WniZapaTIPHLY5Ce2hDz6Pk+R4dPIfkCME903gwVqYGk82r6ovIss/K1bbV4QxZIkyKnIcK9JlTyhPn400WflsamXguCSWnyl4PnLBN++zvOeE1xba2PBcX+lj6EROAyX4cVK+lN0IMehjFRIi+5b3rxlioSyTNuXVxaBWi6PFzfn/Z/VUKeOcUvbQtMwZ6iafZ1Ew9YPvfoy8ggNdDdL4eQxBxVGygxwergAMCypijcFNl/IkHAJa3PzW6CItbqcZiK8pGWcggwjQ21Kn871Jj3PvuDB/F6fXwKNtorxnzz84pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mFmkA8YTZDg9sjQ/y/TnF8x32rehSzGeEyYjFtmKHU=;
 b=f6JzzMFLoABFpNRmF0vvFVF4sepGunfLbhu2INy8wN7xNE0tlAbQXocdbh0/5Ca8wIK1mc5162bcDlILM0q99t7IHYQlB8w4A7XR5d2tkR3V4hNVY/eOfR8ZCR6eLrtNZPnOC4iINkGatPDNZlnG2ytgECqcrJR5C3hR2oNaXHr4W2BUbC4CMQIFNeXxqo+f9KZjZT5/MEKXppUHqSLWnwjIRqAns1J7vco0gDBMZtIzQYOgynKAmI7+WTkumfN+5qERtiF9x/9mXQjKSZokHbXi1P/CpxbbO8/Y1o6NzDVSUu9+bLnjOoakH4gTOwfuNzWZRA2UHI1lvxPyMjn4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mFmkA8YTZDg9sjQ/y/TnF8x32rehSzGeEyYjFtmKHU=;
 b=RLxvTvoBuKT6aYyjmkUc37i9bObVzSj+iudoPKxiWmgUlvKIzWtdDE8CKPTGR92Gkp+njOL2xdL0bAyxVXUvGX0mo43PAXuELnhSlWUS6XVCdBXpe4q3UuRoYnMi4bUFEdD1GTqksbzYu+70fVcD9n0Ev6DvgqVwnXZIFB/5J0sdLtcjxpaSrRtrLrnAuCFTpetzBF/8Oyg3sqjoBMiA4vp2sli3e+/s1ga4v9RokHIZTfa/OO2waJGAUnPtombtTzRKZ7v1yqVH2gB08wFDvp1SIevN65kaf2Nnwh5pj134xsf3mp+VdfbCm0zUi659pp9Vix/8kQGkoOKDo3QQsQ==
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 7 Dec
 2022 20:34:48 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::42) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 20:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 20:34:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 12:34:35 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 12:34:34 -0800
Message-ID: <7f7682d0-ad8c-30f0-b9ed-9a20041d02ca@nvidia.com>
Date:   Wed, 7 Dec 2022 12:34:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to
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
 <20221207203034.650899-9-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-9-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a3834d-4973-43ad-e347-08dad8927bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rx2nz2rakrRRDYMkgbnxR207i5DklxzhRboc8BE/iLgtNbcRUp62Dko8v39N/34oYlMOief+YnV4GAE+Shhaq+Lqjy2DdZEoGY1XG6MFDVAQwcmDHHUiCXoOQt4fDH8U6yZ5saJ+Cs6MiLDulTcuoLnRtMil0canNfPoHm0TqkZWCf+0wfIT97zexo7bxaI1F1Z0Vk45V56Ae1HspYnmdNP+rBbkP1WqdjKtEDH+Ce2Pjzun/84rX2SQcVqZ9w6Ggdqy7Tbu2QCId8N9At5gAXisTv1itDTFL7Sug/FtZ9BVsCDqeU+RqOqOf+nBx22VIsh9tUIw79I6UcGEGg3rtof3T9zYXzn8bgUfHubM4mejklQrr4OztWh7WzVJNroere6x1V3lh34HjM2lahtkVvjj3CYJPD8vIfHcYhp2DDkKJH1fBskrN7CzC+xfXx0VXPmshLNMotoigLsyifVXjs0TfUZEvggraZiXBCNHxsbTVjPZNKmJk02J3gp9XdSN8RtZ11QpxhNM/Q7nuqWAz68XMTaRqb7VMjf5jewQ7F3e5H9d1O58wjMdntFs4zurZkS16IIWV4oaWXgBglfhy2V2lg20GMQ6hhQFUf53ud6/fRv5LM7OvtG7QZIntSucCzjJEQyGMnYsyJIC+2QV5uE1XtqKrLAQgzD0NX7ACBIMRJORv0rtJKC2eTn98d42iZOTIHTcIBWmLN8YQeikkas2NSQS274mvku+cpt6h6vpvZO/zOQLGwzPBcCzdO+
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(31686004)(83380400001)(47076005)(426003)(336012)(53546011)(16526019)(478600001)(40460700003)(31696002)(40480700001)(36756003)(2906002)(82740400003)(7636003)(36860700001)(356005)(82310400005)(186003)(86362001)(2616005)(54906003)(16576012)(4326008)(8676002)(26005)(110136005)(70586007)(7416002)(5660300002)(70206006)(316002)(41300700001)(8936002)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:34:48.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a3834d-4973-43ad-e347-08dad8927bf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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
> Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   arch/s390/mm/gmap.c      |  2 ++
>   fs/proc/task_mmu.c       |  2 ++
>   include/linux/pagewalk.h | 11 ++++++++++-
>   mm/hmm.c                 | 15 ++++++++++++++-
>   mm/pagewalk.c            |  2 ++
>   5 files changed, 30 insertions(+), 2 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 8947451ae021..292a54c490d4 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2643,7 +2643,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
>   	end = start + HPAGE_SIZE - 1;
>   	__storage_key_init_range(start, end);
>   	set_bit(PG_arch_1, &page->flags);
> +	hugetlb_vma_unlock_read(walk->vma);
>   	cond_resched();
> +	hugetlb_vma_lock_read(walk->vma);
>   	return 0;
>   }
>   
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e35a0398db63..cf3887fb2905 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1613,7 +1613,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>   			frame++;
>   	}
>   
> +	hugetlb_vma_unlock_read(walk->vma);
>   	cond_resched();
> +	hugetlb_vma_lock_read(walk->vma);
>   
>   	return err;
>   }
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 959f52e5867d..27a6df448ee5 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -21,7 +21,16 @@ struct mm_walk;
>    *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
>    *			Any folded depths (where PTRS_PER_P?D is equal to 1)
>    *			are skipped.
> - * @hugetlb_entry:	if set, called for each hugetlb entry
> + * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
> + *			function is called with the vma lock held, in order to
> + *			protect against a concurrent freeing of the pte_t* or
> + *			the ptl. In some cases, the hook function needs to drop
> + *			and retake the vma lock in order to avoid deadlocks
> + *			while calling other functions. In such cases the hook
> + *			function must either refrain from accessing the pte or
> + *			ptl after dropping the vma lock, or else revalidate
> + *			those items after re-acquiring the vma lock and before
> + *			accessing them.
>    * @test_walk:		caller specific callback function to determine whether
>    *			we walk over the current vma or not. Returning 0 means
>    *			"do page table walk over the current vma", returning
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 3850fb625dda..796de6866089 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -493,8 +493,21 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>   	required_fault =
>   		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
>   	if (required_fault) {
> +		int ret;
> +
>   		spin_unlock(ptl);
> -		return hmm_vma_fault(addr, end, required_fault, walk);
> +		hugetlb_vma_unlock_read(vma);
> +		/*
> +		 * Avoid deadlock: drop the vma lock before calling
> +		 * hmm_vma_fault(), which will itself potentially take and
> +		 * drop the vma lock. This is also correct from a
> +		 * protection point of view, because there is no further
> +		 * use here of either pte or ptl after dropping the vma
> +		 * lock.
> +		 */
> +		ret = hmm_vma_fault(addr, end, required_fault, walk);
> +		hugetlb_vma_lock_read(vma);
> +		return ret;
>   	}
>   
>   	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 7f1c9b274906..d98564a7be57 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
>   	const struct mm_walk_ops *ops = walk->ops;
>   	int err = 0;
>   
> +	hugetlb_vma_lock_read(vma);
>   	do {
>   		next = hugetlb_entry_end(h, addr, end);
>   		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
> @@ -314,6 +315,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
>   		if (err)
>   			break;
>   	} while (addr = next, addr != end);
> +	hugetlb_vma_unlock_read(vma);
>   
>   	return err;
>   }

