Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54BF648956
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLIT7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLIT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:59:21 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824972C13A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:59:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO4jvB5z1tJEZHTU8FVHOQ8gkChcMPnRIvUW98BdWVjtEiPo4tw93A2spdobA38X0Q/9G4Skj9p9b18jcvbY5zya2THo1kiKklg5P8ndA2S2sfEq0xDFe0JXa4g9+ekUzDjBLqA2kut1Y9gjqn2QIM6YQkkevlinnhFDRMRzuXpS7U/ZRjn6XC3hB0GDv1EcShYg5e6lPwoeJ7lyyryoPGCdWYKoDE77Vu+0l3WtiGLg3a16Imjy7hMGJSaOOlF+SOGhBAbphYQibhWgy2woxQovxBvzYD/dhW3izXBwx4ycGH3CvzwGuYSixBvOKVocPw2gMuEjWaAz39/8Gzq1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szIG0ohxEP7WPxXr/6DSx/A+d5kHOvwmDX7PR2I/daQ=;
 b=D/Dvp1h1VBpkbYyeExus0QhwzHUJRcaajphjiDorhZcNC0iuIn9pKJDcWBynimI2bgJdFd8W8uo9wjyg8wkDPvaLG27QN6pIyh0y/yHDh6Q2xJ62RL5JQNCPZHYhwlpWR5of4pLA+NylLemXd5Y2itVwIENbKFKOXpjB/d+di9+8ed/USGYZyGA9O2f+e27SvmHVbyUT1S1Qg9cs9FGkg6y7e3LLMK9/UXWkP3y1GECO4VzBZTI4b3Xo/OhmWAtuoS5wbSD13rhwmJ0KJ4/gQma5mdGOeot1UZqxj+gn0zHKeLOaN/6v942hjBvbF8vxeOTyt0fPjTthvFkBY4vm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szIG0ohxEP7WPxXr/6DSx/A+d5kHOvwmDX7PR2I/daQ=;
 b=HPS/F5deQ2qExfNwl9xfDWe5IyxJeqRK+ZT/crW1kioD8ui0v8PsnPJX/9WhILPzia/t75yDAn3yqoLtaliYttVkVCvgKOL11LSeLXpWO4EafHC8Xi0i+ytG7JtsYCZJ3gv8BzOQ9UaxJHtfm5NSWfJN9lU3fiOxj5cxMc5ivnnnMdzP8+3F3cr6BvG8t+pIsTpIcBeC4PJuRo8K8JTVkAgFL2FWxwJqVJ8Hc36Z1pYuINDXvshOR76RXkSAgqiS2GjgF92fevsvgUjaMSW4SWiS88uPr/m1XdpFKDIHQ+HXAVmGqloEgQ/gFm+7RUFKI5dBF9E5oEEVvwPDsx/MgA==
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 19:59:02 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::3e) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 19:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 19:59:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 11:58:51 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 11:58:50 -0800
Message-ID: <bbe8baf3-45b5-e843-2dcd-e7f0de035066@nvidia.com>
Date:   Fri, 9 Dec 2022 11:58:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 8/9] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221209170100.973970-1-peterx@redhat.com>
 <20221209170100.973970-9-peterx@redhat.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221209170100.973970-9-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d873df-c034-4643-3ed8-08dada1fd1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9QnOKlYF+RIJRgkbOeHbA0TmRB4/PN8A2BuT2MRCN2EP6FRB4OS80wqbcinS6XenRrpqrhS3d1KVzRMqxcxSQLPloH7KWitbSFpQiel+1Wh2SFzbMIZ7vicKcXYgGleNsoQUgrD7NJrRE1HEoJtD/hPhZCUvKP77jNvsvS6tpANS00Zc9KA7/u8yypx9jmCd1KEXEcC7kfe8q+4oBEEnPq5sKK9HEogF1LaMdSIeIszJ6jvpbXXE2JdyC6kjST+MeGNFtYYc/x/i9jjZkVngPXpWZ1BpVqSp0CW6vJZeNnXesmvU8LTOSu8kWwpz0v4f22R2g+/lVxKjNqAFpHg6HeFlMRV/j1IfBt8isIx7jWSKRkAi4bNgq3/rx8oJV2De02cYC/hzOD3qAKuBurUivS3edkAHGcNAfTtfhtdSLuCXtTnvGtBQ6tmjes1BXRFb9XVXkEQ/Q7rrxeAX8uxSmdkW50UQMefOl3xkgqcPIVCiVxL3lpegw13i/kY8iW6PjPJIQume/Hs+MDXwqtcF21ywtVxRx7fAud5NByotCPcvsuhAhe0CQR08qO16fw+OJhGtUBr+oLotgst+8I7iJ3FP9MJtTD17wLADwu/0Yt1fef5zMkcX5HtzXDBOen9IIOjeEL2zHVu2XlcLM+Z7eVLCG3Btwl9gKhWPwl+R+jRUEBSmVIGna8rrLLsM7T1+vpZpGS7F/rCdCwp/eJf3fHVy21B6bg0Yhan0nxsjWro17Bc2M6Gm3nCIs2APdp0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(86362001)(31686004)(36756003)(356005)(4326008)(31696002)(40460700003)(8936002)(2906002)(7416002)(8676002)(7636003)(54906003)(83380400001)(5660300002)(70206006)(36860700001)(110136005)(82740400003)(336012)(2616005)(16576012)(70586007)(316002)(47076005)(478600001)(186003)(40480700001)(82310400005)(41300700001)(426003)(16526019)(26005)(53546011)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 19:59:02.1473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d873df-c034-4643-3ed8-08dada1fd1b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 09:00, Peter Xu wrote:
> Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/pagewalk.h | 11 ++++++++++-
>   mm/hmm.c                 | 15 ++++++++++++++-
>   mm/pagewalk.c            |  2 ++
>   3 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
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

