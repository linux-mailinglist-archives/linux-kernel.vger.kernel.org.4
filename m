Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3026464F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLGXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLGXWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:22:07 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3052054451
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:22:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5Lno9wDzeJ9I9HNz3/QN8/1oQ2ubbiTMV5AJGBhjGi9mAa1JrIUoazJ+AYDIlOsI23EFg89Jt50nfRMgPBhwfP6LV3wjyNftAhL0jPXe+qbYzQpR7Q4oMcLjTZvp8//1gSHIaT3WFp64KR9l44fzrFi7DXTala7B3gU9iXDNw0sgkAieNi/4MjAUW2rGrwn18EDOKmt4fKjx9HFcIuaQ5GnpN4HYfrA9RBSWkIT09DZFwrOMbNqMNA0mjIYnyz2qjdQAexeNXqoKsvuSIDKBk5rdt8YiYH6MdRVs9n/QOwwMoXAAKxcGfoE5B9Rf2Ip6D9+33yg60H9yOGZp6V10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C29I3T0jqHheuV4HrYZSI6K9okbVjEM9o2GBycy9BZA=;
 b=OcNWbEDuWlOjdYBpNcisfAuJmFWGacTDIBa+OOzY84sfeB3nsFrtoil8rGEncnrx7sSWGI0rikdo/8P9/n+XRBa7EpS65mZSKDQnnyNPLtgSnNbQjR0Tlu6hq6nj5mIvlGQ0abu3ifsd4Js15ce9DAO/1XIyNwaoeQBDPhGRzOL7RBr0gjelNzI7q/L15/GC9TrI4IRgU2rwms10m/eroixNI98eaP2vso1kQ3Sr5wTUZFDaEcmYDcwaIKTFHieQzA2Dybyie2IGOvwfwP4dEGEwmSb3glaI/odSglxLb7nkBPu2XT8VdIWgMp4SEmBe3VzGy+ECtGVejsewHlJ03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C29I3T0jqHheuV4HrYZSI6K9okbVjEM9o2GBycy9BZA=;
 b=fQ6fLOYyQZP/r9d2/VkCl4GQhlc7kdQke66QexcLWqzwGUS6Lmph//m51lg+ufmudNc4pqp2DPx4UIrCg2x3ow7nxbs65C9LCWG8/MhuKaNSxSGdFXoaQP1/vJJhRyaQvV0BVrG+VuXN4sQr0T9IJCYWfJDeubD3NO8rWYYVtOnR4p3EdEYz1C1vyyOJKJyqCUC98D8bKs7YfhSvHx1MSqhvjNvPLSSYrabOWCinbbH3FrFxPPC/VGPPuiiBjuA8ln1g9NKolMak0rAn3ZjaZEcegahJMgB4AsDrZeCXMoy1wMx2HV5Q71ov2DcWqt8gO/FGk+l3Ui3o+ygWraty/Q==
Received: from CY5PR17CA0047.namprd17.prod.outlook.com (2603:10b6:930:12::22)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:22:05 +0000
Received: from CY4PEPF0000C96F.namprd02.prod.outlook.com
 (2603:10b6:930:12:cafe::e5) by CY5PR17CA0047.outlook.office365.com
 (2603:10b6:930:12::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Wed, 7 Dec 2022 23:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C96F.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 23:22:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:21:57 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:21:56 -0800
Message-ID: <4daab76b-aa00-dbb2-3761-d782b00fab72@nvidia.com>
Date:   Wed, 7 Dec 2022 15:21:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 06/10] mm/hugetlb: Make hugetlb_follow_page_mask() safe
 to pmd unshare
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
 <20221207203034.650899-7-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-7-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96F:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6a7a9d-e774-4c76-ad35-08dad8a9da7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWogc0GJc6tTYR2iesSfhR8pPn3hJmCeEAg+d3iaciUXe5eGk5dAw6AX1OtVMsnzrvA6i726UZfXBXxN85Eyx0wMy3LeXVt/tsxDtQfYjdRLYX8nSa4o/0B1IigsJweU5A0Vz+ztj1mdjaO4gg+x3az3Qcx9WzLZDqlESaP8NqmociR6zL5JboX64vgwbbzf983X73wGYJXwfscCn6oWe/h6y+P+ep6fK2m1DbHApavohycUkyJHff08a8QrMVCNr8S0MB3iRwiHeINKwYNBASbyg7soUEQMQ/xaESp+BwGtnNyNV1jjK68570CQ+j63z67nhZHFJSZ7CKmMwjqG4QIVOAasoVjzhOSlGcuQnuhgu3UaH2OFZSgwNEW3laV4sxXXJFEGrCAy/y1ZEB5U+9gYnNoHDYOMjYuhTDAEBAXgN3zawNlig321tecQ1DJ3Cwu4gatR47f2eI8Br7S5jFWPs4ACMkikfXIcnitVjB1mc+cewXtx3+B+3h6Q7PyTLdamUftnZj0l3AStM6/8Fbzmi0+ukzWc7ZLYzRftQ+nwtz0Z+91+27xpxj1KQuBwvj6J1ASUflDqWCvlCIbNNeHZ4qtu6P1q7fC5ewU1vHPcvwZIYzzwhiB9dCM3byq7N9xzFYr+lUv0S62Dzg+ri23MHY5Sp2OFBVzi8K5Lkl5xvCXZk5WOu6Oe5Nllm+9thrTBhLzlO4HmCIHhnBbWfXUHguR9dKC7HneAeVOdwie7MXBs5OrkjM/s9TTCEhiH
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(478600001)(82740400003)(40460700003)(41300700001)(7416002)(4326008)(8676002)(31696002)(5660300002)(86362001)(40480700001)(8936002)(426003)(70206006)(70586007)(31686004)(36756003)(54906003)(47076005)(7636003)(356005)(186003)(26005)(16526019)(110136005)(336012)(82310400005)(2616005)(83380400001)(316002)(16576012)(36860700001)(53546011)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:22:05.1682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6a7a9d-e774-4c76-ad35-08dad8a9da7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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
> Since hugetlb_follow_page_mask() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 49f73677a418..3fbbd599d015 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6226,9 +6226,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	if (WARN_ON_ONCE(flags & FOLL_PIN))
>   		return NULL;
>   
> +	hugetlb_vma_lock_read(vma);
>   	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
>   	if (!pte)
> -		return NULL;
> +		goto out_unlock;
>   
>   	ptl = huge_pte_lock(h, mm, pte);
>   	entry = huge_ptep_get(pte);
> @@ -6251,6 +6252,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	}
>   out:
>   	spin_unlock(ptl);
> +out_unlock:
> +	hugetlb_vma_unlock_read(vma);
>   	return page;
>   }
>   

