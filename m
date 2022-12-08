Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE506465BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLHAQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:16:29 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B337E409
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWI/U/44rx21heKqyTREj59KtyywNljOZoFTX/Ylnr3brQwS6vr92mwn9WZ2OV4O4cAWAPe2K9CmEwgu3MmoIgA2HRBWai4OgynlLKRG7cHk9l5qsBy6qTzvsN01b3UjEF3YRP6cLhAQb1XPl9pLubMFbHYV4meLNUIMB1oi7QVupMdyD5KJ3th/QY+IRsqo70AiNjYAMyP3Lu2FgXybdDBwLr5lQ9qovg0QCMHN1hf8YhL6XSdy+yqBi3W+Ng5EBHEF3EfjvGsPF0FCwBiLgr9yIyfwBE6ruDdLflajVNRoMKyMApUZQHX6qbIC6/zT9DzwJK6+PcupWqmpl4keYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9R15tEqq7GuIftIPGyHzEyAG8GGLcDRrgDiu8VxNbs=;
 b=WHJmoEewFwxd7dTxQ4/mhQjhCqZUp3XsYCJQJHAwBYrHdqmxzTckKi1cKedohZTpVqdXmF+ZOwrICtP163/G5NAfE1xvMrVtgqYhZg32kVV+wO3hOeqjiQMCR7plS82Eko0lA205zxI2FBVwK/njl3N4bymrcWwT0OGsyYhDdjlUsFtn4Bv9sxkk9KHYyIMBkInZmCJJ56BBEjkUCuSzfpTZQbJ76UMdnRMqB1knbQE/Krrztezqey8JdIIv3ng0ZPX/hEs0rMm1V/HPaLaN90xd0bpPbMKgwlQEkiXIsmXrdAXMnSXKAW8Os6CpUJ3ZHoAw2orju2osLuhjgiZpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9R15tEqq7GuIftIPGyHzEyAG8GGLcDRrgDiu8VxNbs=;
 b=lzAortxjvtJJQI2sCwjhtiKJhuNnHfzCyFblTdixr3Us1BJTjvHaf1abl2VZqG2o6SWHCrqI87A/MDCp+4+WkqyY/yjfqOiQIKeH3bjPEgzpDYCwNb5yTfzkFwTA5r6pVFjNwHRXu33OYf3lQiytEcMeGhFuKNQn4JeOd0oCShJ114Wi+wjEpfyj2/xIRNZz9w+lRp3CnomsVrcxg5Dl+YDfWiuTFtCkwTdrWN39VEksnG9MPX41jSrWdVZ/jGSGs0hEzw9tXTcgdr2qzq4AO64ASMRMevxRb3XeSCT2Om+6Tzl/Zz3yoVqO8PcbKnBeWmP+xOAq965eReJtXIWmJA==
Received: from MN2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:208:120::21)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:16:25 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::c1) by MN2PR10CA0008.outlook.office365.com
 (2603:10b6:208:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 00:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Thu, 8 Dec 2022 00:16:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 16:16:13 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 16:16:12 -0800
Message-ID: <6a970de6-e3da-f57d-14fd-55f65ddcb27d@nvidia.com>
Date:   Wed, 7 Dec 2022 16:16:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203158.651092-1-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: eb71f8d4-94c0-4263-3106-08dad8b171fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8+dpUHb3PqisF6kjhvzMZP/Do/1GNmyZ7CbBElEmIOpwRyPy//pTGFA0V5/9D9Y13XoWQszIKvgQ0OhXSCgD6MwEzwKoETwUjfPlczw3duoq7IEaCf+qSPX9ltbrmST7uLGt5E2FeYrMJmlLXPzVSJZusraMHwub4nST/Kxk5NIjBJXczuZi0LTW3rcm5WvAt1grAMPYY8n2XgTGtRsJvDSCwh65j1zd2DiCAe7AXVwbWti50AZszt0aIVMv8sZaRNCR8jbrbAjd4sKsG52N07lmgcaGroJFmL6HTXAhzRc485fwe635rw0GngNBJ/23IpVKUSbpBsQ+6l5wMwlvFHaE1ReJYmM94PtOZWGjM35gSCU6P/fb2fkHsT7p9+hitERmOlA//aja0wfkXjvW1nxEOIkBTu+YD8QAWRw24noZj4w1Wzs9lv3284PehZjMWS3iWA6y771gdAl4ihyU7fPLn1Sg2WXOqBur5blk1cNNj4y+B7vwk3sTvRXQWR4A5qgL7ilI/sZ/MYMR7i0RE00gYGCKMSg9+1t4xoMW3AAQg4MUgp8AoQB0z3G8SG7VGg4MNM1SFfs5e+49dGkg4uchXq3kr+IMQnS/mlx3YNT5E8lnluX0bglkA0PVgalqlzBgvEAsbs+lCaE2o7CbUSAVeUYYuH3rv4kKfeid75tkZJWoErAlIeqUZ/M0oDvP0YDHGMKryVImm0F6B/D8mwu1smGhmbqSG4ioBNnRnf6SdXCS0bgysSqqGuUTASW
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(478600001)(53546011)(186003)(26005)(82740400003)(31696002)(7636003)(356005)(40480700001)(336012)(82310400005)(2616005)(36860700001)(16526019)(47076005)(36756003)(86362001)(83380400001)(426003)(70586007)(4326008)(7416002)(8936002)(70206006)(8676002)(41300700001)(5660300002)(16576012)(110136005)(31686004)(54906003)(316002)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:16:25.7257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb71f8d4-94c0-4263-3106-08dad8b171fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 12:31, Peter Xu wrote:
> Taking vma lock here is not needed for now because all potential hugetlb
> walkers here should have i_mmap_rwsem held.  Document the fact.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/page_vma_mapped.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e97b2e23bd28..2e59a0419d22 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -168,8 +168,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   		/* The only possible mapping was handled on last iteration */
>   		if (pvmw->pte)
>   			return not_found(pvmw);
> -
> -		/* when pud is not present, pte will be NULL */
> +		/*
> +		 * NOTE: we don't need explicit lock here to walk the
> +		 * hugetlb pgtable because either (1) potential callers of
> +		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
> +		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
> +		 * When one day this rule breaks, one will get a warning
> +		 * in hugetlb_walk(), and then we'll figure out what to do.
> +		 */

Confused. Is this documentation actually intended to refer to hugetlb_walk()
itself, or just this call site? If the former, then let's move it over
to be right before hugetlb_walk().

>   		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>   		if (!pvmw->pte)
>   			return false;

thanks,
-- 
John Hubbard
NVIDIA
