Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620726463D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiLGWFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLGWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:05:14 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994A85643
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:04:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oK7PGECIp1NC3QhmqkOcyNoIFTjBnJb6HLrlpPR9k4zNa9NaSbcJvDa3lKbX05fDBOynY1HU3OfYViQrihEObJtxrih/uh0ySFCn0t3rIe5brd0mEH9GSBHo7VfdXx5I3lPNCnGrzKuJP0/ZToO/0wpUK8eqk4gp7TDaafKD6jvROsUPok6xmc5L9LNVXTuq38iRwmkBorMQNxRNDnPhtq/fdYfsTxgmJ3Q5Q8tyvq/+OdgnJLEiJ5zL5dfOz0k5lRAMh8JLjeLjc+M1MMcCQDGi6tKPXTjUJ+VuR8bPqsG1M6sHWmRfjmgfwljb5jn1whwWwQ90rvmii3Jhpi7jbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76BijIWg8PfH/E0hl0Kpuq6zucwuiiPffJe8gpaRRqc=;
 b=dFeP0b3E3YIZ+kYhwoB0A75ROjfAJuuc4VpKdeXcdIJ06V0Soc5ISfOe5co9hV/zBtvB9GyEdn45IbgmiU8fODTZ8XDnmMh1t1072oVN6h/p14Bf75Dj2mthkVF/L1WWjGn6ebQq5w9uVPuSSEALqQibCy65z+yhXtmDRZsLvi6fEWaAguruoK/0on2mSRnJxciNAhsEUtNHo69PWwf5wWQjvG896E5FYQlHOGX4JkzpphORVwaX+RxHWnfJnfH5fou8/gMVTgmL2aLnCXOzzABUC1bbO35/y2HyktHg5QDGOqUYX8dgJL7yOjx23mc38vkkp3C6U2q4mPanWLKCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76BijIWg8PfH/E0hl0Kpuq6zucwuiiPffJe8gpaRRqc=;
 b=clt4yfv6obKqx3PR25EUzaBO0USOt5hqzJMzaYTQzAxj/8Y4jszdFKQduzdIrQfM/ukBbz7tpEducxa0HysskN+ykrWK65rfO01mgvXEnWN6aeZG2xP2JMTYRJkgKeGF7SPLXm1970jsESH0tkvTjMXtuCDh+Anpw4dzEuiuzysMb78KDFanzmi47/ayCIwtHeEHfpcNNVqI/HRyz/Sc+1FkSkBKV/DgNtSCTymQ8k16YqaxUL1RuNQZcrWQOtgIN5Rj5bBr+gqlTCn+a3PLlsgS2ssZp4G7n831g9vdDhIM4ryQ8jPcfDjKIrNvVDiaffuns64dEiKNdOcsodtmXg==
Received: from BL0PR02CA0105.namprd02.prod.outlook.com (2603:10b6:208:51::46)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 22:04:13 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::6e) by BL0PR02CA0105.outlook.office365.com
 (2603:10b6:208:51::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 22:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 22:04:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 14:03:59 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 14:03:59 -0800
Message-ID: <9bf6f105-e4c6-f480-0a04-6c605981028e@nvidia.com>
Date:   Wed, 7 Dec 2022 14:03:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 02/10] mm/hugetlb: Don't wait for migration entry
 during follow page
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
 <20221207203034.650899-3-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-3-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: f8055373-9723-444b-9b44-08dad89ef9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrPtBxtoylyvUdjv8lWuHi553rbZf1mi4R70QdppLXI0mL54nNCJVtGoSEckAhmAbwlHBzM867IDSmmb6JO9V4lMf1PW+2B1g+oceq+ymiG7gHy1GWryrXiagM0LDadgkyGJIpbvbiN8seesDcdpgQZG1QrEfCEJV88PVKwjjyZM8brLxwqbml5DrYtvZfdqypfO43JYy5tFIUnerB9UZPqOQW9yNjIbKtKe92iLXeibg0AhVZZ+pxDHAup+XagNzZA229+hlR1HV7CXx2Bn+hWP7MAmpCrn4va0Pf7rc6QlJv1pUznq/BNtO6EiQHnBHnQknNU5v7SnMkdouaOJJ1ZLDrOBgi6lAZGmbf/RBhc5+TPGU8ub/HiyD9yK3nPKvoqj5rAO+QGKJLbWJZ8Q1ivsYiZ952fPaEAKkqzmzSVRmu9rXv3gbE6nRpFXmsmRo01k85wi6mjuSd/h+B8a1Tzf3e7HySRnFjbrqaURBZLMoTgish9oz2073yB2gSlcRCPX+yvwksCiyl/tljb/aWllhUiewNiAvl1Vh+2uC3zFbya4OazSlGzOncLB6ltY5WnNe5mDvy2fJTmw5jwzyxZNwp18hs2ttECmlXQrSmEMqRd9MeRe+XR9shjVhrc9D9csWvbNCWFcud89R84sCjAQJvprEYXoIbB4eLu6z/QrDx1cTPoAxLtYlWx4jsAJsqIt9P4V3Ai/Qm32gRK0U+prsyu96LoN9iZSR7RJyHGlQvZcQFf31VEYudiY/AmG
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(82310400005)(82740400003)(316002)(54906003)(16576012)(7416002)(83380400001)(40480700001)(26005)(110136005)(36860700001)(40460700003)(4001150100001)(53546011)(31696002)(36756003)(86362001)(478600001)(2906002)(70586007)(70206006)(16526019)(186003)(2616005)(31686004)(7636003)(47076005)(41300700001)(4326008)(426003)(336012)(5660300002)(356005)(8936002)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 22:04:13.3518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8055373-9723-444b-9b44-08dad89ef9e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 12:30, Peter Xu wrote:
> That's what the code does with !hugetlb pages, so we should logically do
> the same for hugetlb, so migration entry will also be treated as no page.

This reasoning make good sense to me. I looked again at the follow_page*()
paths and just double-checked that this is accurate, and it is.

> 
> This is probably also the last piece in follow_page code that may sleep,
> the last one should be removed in cf994dd8af27 ("mm/gup: remove
> FOLL_MIGRATION", 2022-11-16).
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 11 -----------
>   1 file changed, 11 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1088f2f41c88..c8a6673fe5b4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6232,7 +6232,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	if (WARN_ON_ONCE(flags & FOLL_PIN))
>   		return NULL;
>   
> -retry:
>   	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
>   	if (!pte)
>   		return NULL;
> @@ -6255,16 +6254,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   			page = NULL;
>   			goto out;
>   		}
> -	} else {
> -		if (is_hugetlb_entry_migration(entry)) {
> -			spin_unlock(ptl);
> -			__migration_entry_wait_huge(pte, ptl);
> -			goto retry;
> -		}
> -		/*
> -		 * hwpoisoned entry is treated as no_page_table in
> -		 * follow_page_mask().
> -		 */
>   	}
>   out:
>   	spin_unlock(ptl);

