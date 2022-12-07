Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFDC64632C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLGVV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:21:27 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7015435B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC7RH9Hr4oJ4TQcf/MXy3OzURebrW80ta8mCSGCT2yRGL5U/V1S7hmO+AEA49yVavDdBOwUhWakkss7F449Cxvl58C0nWPTR/n6xyohuVDeF2h9GbPWHQyperiyChu/mM9lz/PJcd5Lcw92v51TpXlzPWejgibH3wFjeGO98Z3K/g8l7dqtr7CihlDlIQTDtObzGNRC7mh8ZXigVzDEd3A5+Cl4JITXWURXbTU6vo5sRdKD2oAm2ephnC2eELKEqpnzH9nFpHhAX1ZQKPR0i6FaCPqGsGC306y3PSRMx2QzCHBrh3v3f1wuwL1P4f9OcwWXaa1W8XNxeV0y192atDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw6etKoKbhI5UOmQDWSnwQkbKmxcGeVEhUL6Kb78D4s=;
 b=Emem0aYuj1CKrA+tB7IZNNgKlIGNW7QXcb0r7d+2PnYLX8/UPOpWELYlVySIC9qMmfBJB4DXhhjccYd5bZUYzaFXbJMW2GAycwFQIKCyLJkLxt/TSI1cg+3sotWbUuqED3ymNqpLsDbCQ4dlZiiawSGP4vwtrG3NjVn0EQFOEf+vZxnyPrmd9BSesnI2u6eOBC5fvHdI86P3LPPQJ7xza/S9MGI8ctafAuE6l0uVAYNeMX1T44esfRGaC1MbvpTHFP4I9cFj62jbbgzReShNwTys9ELfXh5LgAb5x2SaRoXUtB2YT8jpu0LOR1QXrKcquxhOunD0+kx6YVaQUD9isQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw6etKoKbhI5UOmQDWSnwQkbKmxcGeVEhUL6Kb78D4s=;
 b=s7ZOIrGTMgoN6ncTOreAnuDMwNfc8L7Jau+wXcE2Qyb/wdn+6Gls6VO6K79agkg+h5e/qzqeQz85P2syx9LaqTjgjdRBaZ6hsCSxROso6HskGr1D2x5Rnzym/TGd66mxeHoStBqYHv5BUFUattt62mAlHPvRZ8667gKsW30c7AN9GH3oppOpR0MFzbrDBLLz1+VibTqayghe42N/ATRveflCHPEupAHusr2wV+p7MhxMrJStZHRLmrxzI3PXWYL5YrElwJaaeh3DvXCMRIoMR0fU99piWucPTYgfEh7aZEQITW+CLbdzQSP1SlATtft1gr3Z0e7GROZUvZyMKAwLaQ==
Received: from DM6PR04CA0008.namprd04.prod.outlook.com (2603:10b6:5:334::13)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 21:21:24 +0000
Received: from DS1PEPF0000E659.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::83) by DM6PR04CA0008.outlook.office365.com
 (2603:10b6:5:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 21:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E659.mail.protection.outlook.com (10.167.18.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 21:21:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 13:21:13 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 13:21:12 -0800
Message-ID: <e1f40f3f-162e-7d3c-00f1-8c71e3b5dc31@nvidia.com>
Date:   Wed, 7 Dec 2022 13:21:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 01/10] mm/hugetlb: Let vma_offset_start() to return
 start
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
 <20221207203034.650899-2-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-2-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E659:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d393121-a19d-4f8d-8a73-08dad898fe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m654IGVLoL01aBdMWINN9oYkCZGZ+AG1Bd6SJ0yyDC0tlJ5yA6m8262+mLtakTmJlY11UsRBMrae08dvUp7mqxMZuhlg5TIgwU/5MU2rOLrZIyCzZUYPIM63r0xVIVZMtpfjAV+CeZBi/LloXplkSQDUwfMDKsqrCi7YOkrccSTYdGLjKmRKufvOLpcIBpuLUdvVHCG5sWZk+dNe/yFSvwYomfsuvJok8Ff21VMK/OJn+3isUXLLpFLp+IQHCZknMAi2lQ10A2lfDXtjy9ugJ65Y6vNAEnmaPJOVZ+itb5+TVN/j/UfUmGvNL/QzEkH6/+CuxTw0rc+uAnuf3qZGJoX6fe/QLhL0Uj+e9B729pg8NvJrjOGOng+zMQ4rWT8TsXT0xOeDkxi45W9VR4Vfac9f7RUAjkyWQmn0VIMTWpX4cfXPgyoDYAPiAK2Js0ts2/4+0KZCfVGqfvCfDmTymTAqMUvGMJLPsq2gsGXB+X6M9gSpN/H6a3hw09C7YkZX7T+RSF4Z6sNInAGKVwVp0PZcRP5Us0ruYWVQko0ghdtQjssWvlGKFuGoHgiPdyaAWNFZ4k+XIvPTZRH9YbfNuAFyOL/C85fD7DRN/UcD0Jno4YsPsiorxyuuGVrQzwsjJONWDn57sv/EtHRg/quCbH2gO3pXb19qIDxTqp+nQxDqoFJjX/p05Do+LIXq9k/EkMc7eZV1iWYuwe1iZD79OJFzjQGfBPTUBDDZQ5SG3CSQJ1YINYR7Pf16IWovdxjR
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(31696002)(70206006)(16526019)(40460700003)(40480700001)(41300700001)(186003)(86362001)(36756003)(70586007)(336012)(8676002)(4326008)(316002)(2616005)(426003)(8936002)(47076005)(7416002)(16576012)(5660300002)(53546011)(54906003)(478600001)(26005)(110136005)(7636003)(356005)(82310400005)(82740400003)(2906002)(36860700001)(83380400001)(31686004)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 21:21:24.1970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d393121-a19d-4f8d-8a73-08dad898fe8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E659.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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
> Even though vma_offset_start() is named like that, it's not returning "the
> start address of the range" but rather the offset we should use to offset
> the vma->vm_start address.
> 
> Make it return the real value of the start vaddr, and it also helps for all
> the callers because whenever the retval is used, it'll be ultimately added
> into the vma->vm_start anyway, so it's better.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/hugetlbfs/inode.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

This is a nice refinement.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 790d2727141a..fdb16246f46e 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -412,10 +412,12 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
>    */
>   static unsigned long vma_offset_start(struct vm_area_struct *vma, pgoff_t start)
>   {
> +	unsigned long offset = 0;
> +
>   	if (vma->vm_pgoff < start)
> -		return (start - vma->vm_pgoff) << PAGE_SHIFT;
> -	else
> -		return 0;
> +		offset = (start - vma->vm_pgoff) << PAGE_SHIFT;
> +
> +	return vma->vm_start + offset;
>   }
>   
>   static unsigned long vma_offset_end(struct vm_area_struct *vma, pgoff_t end)
> @@ -457,7 +459,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>   		v_start = vma_offset_start(vma, start);
>   		v_end = vma_offset_end(vma, end);
>   
> -		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> +		if (!hugetlb_vma_maps_page(vma, v_start, page))
>   			continue;
>   
>   		if (!hugetlb_vma_trylock_write(vma)) {
> @@ -473,8 +475,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>   			break;
>   		}
>   
> -		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> -				NULL, ZAP_FLAG_DROP_MARKER);
> +		unmap_hugepage_range(vma, v_start, v_end, NULL,
> +				     ZAP_FLAG_DROP_MARKER);
>   		hugetlb_vma_unlock_write(vma);
>   	}
>   
> @@ -507,10 +509,9 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>   		 */
>   		v_start = vma_offset_start(vma, start);
>   		v_end = vma_offset_end(vma, end);
> -		if (hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> -			unmap_hugepage_range(vma, vma->vm_start + v_start,
> -						v_end, NULL,
> -						ZAP_FLAG_DROP_MARKER);
> +		if (hugetlb_vma_maps_page(vma, v_start, page))
> +			unmap_hugepage_range(vma, v_start, v_end, NULL,
> +					     ZAP_FLAG_DROP_MARKER);
>   
>   		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
>   		hugetlb_vma_unlock_write(vma);
> @@ -540,8 +541,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>   		v_start = vma_offset_start(vma, start);
>   		v_end = vma_offset_end(vma, end);
>   
> -		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> -				     NULL, zap_flags);
> +		unmap_hugepage_range(vma, v_start, v_end, NULL, zap_flags);
>   
>   		/*
>   		 * Note that vma lock only exists for shared/non-private

