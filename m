Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69288646575
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLGXyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLGXyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:54:50 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E178326E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlXdJUIB1sW4CMl4gqYswUfoG/UEQjIkKVsn16UFIZYsA4vSPgIqF18BdO8pSm9s18lYIMYTbmh5CCQQu9Ho88NYCAQAxKnOriJ/3mdnaC448N5Ymcz64BddUvpPHJsp9af/4qsulALdXzjXxmPoVv3sXMQRGzv4y4JFDkeMCYkJ6bmLqlBDED3TvLZr7DBGRrgggjgDKP5s2s/S+U1iGeKgJVDuTEH1SdU5U9tdyO598PHuPTLl8heYXxdUFVpUJGcYXLQYi+L6f1dQtMijDdHv7ZzNxO0B7mI9TCUfsOcW0nFgdYUEIF6VKuUYvXnaGi1afZJqI0BQiW/w016Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxkQmJ0CAS0iEAKGQYrg+3mFQEkYh4jhySxs5FrYOFw=;
 b=mlFhOuktThOBsvuv6eOSF23t8jsWQSSyNCAxGKRC6xZCCIWkWVH18SN5m1wRyJUJ+LXAbhrd2k2VB3SMtDX5iKAfwLvoFPvpMzd4vr1JGd/WKcgjDmbInTLnXxBk4kzH9EAVDyi8xfTUJjantGv9n7G17DK8YMfh1gQC9CqaokWbnMAarptjsPAPthFBlT6ntaFBO1LBFlA60kQ4yMrHZ6pE2gxFpAe3g1J1aRzYpD+CWSRQ1+hOCIzhPaApVH2DriJxgQwZjReqfE8CejWGPDq/d5ZmqfNNzlGnEOsN4MTl5uM9Bh3r1iCOjvJlWlXLh3RvpiiObQTB1tDfwp/atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxkQmJ0CAS0iEAKGQYrg+3mFQEkYh4jhySxs5FrYOFw=;
 b=nVuR/arPhVSmmRQO3dfkKMEHhKVlyhD3EjTD8PUseyNkeV4I5CvDCNzjJnyhtsbGElutmtPL/7YaDd1pMUOGOlSqxndHcJUTgYgQcROyFr1UiIGpFUqQczPkl/6+8TPZxKdHnTaupAN+DbxexIQ9PxCVperHdaj/jDbk37CON5oFk629PVs0V8maI1Bvjhwa+zGvHAqkaNk3/X2d37OICvNQXqa3PEOMt0LMi+mCcCTCvtKTYSarqsbnkc2shOYJP3RHf81tgk/4tY6Oxw8ngceCoosfGaM3Mdc/tiCWdpsJcE6OTO99mNvx7bgcVheDzNo5NApMCQDL7/McvLHcdQ==
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:54:47 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::92) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 23:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 23:54:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:54:35 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:54:34 -0800
Message-ID: <3b793737-2575-84c5-962e-6acfa529c8a0@nvidia.com>
Date:   Wed, 7 Dec 2022 15:54:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 05/10] mm/hugetlb: Make userfaultfd_huge_must_wait()
 safe to pmd unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "James Houghton" <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "David Hildenbrand" <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-6-peterx@redhat.com>
 <b3308387-464a-52ae-114b-34ab94e3b5c6@nvidia.com> <Y5ElX/Flm7lrHmCx@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y5ElX/Flm7lrHmCx@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f51bda-23e4-45bf-17df-08dad8ae6bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ubuqusPIfBYS/shnbXjukmPr44kcMbqly29hMNWC5YG99tfHcTbS6zTmRhsomq8CVo/8OVqvIz3fk/LYQrDod6wVL6WopYwWIV2IWD7ysTuJDPhMIglt8e4kCJ8vbFn6ujDCNBSjc+6lOik23V9B0jXdbW7MCAO13xnlMSPlmBfShwCoZtDashbeV6YtszzoPXiWMUVWjyjSAEt0baLPpjCMa2iKBHPkQhnJTpZnCZhAzxKJukC2d23SzKdFXe53S7jQqqc9O9CL/PBe5Nv00ssu2gWFh4Z2edKf+hLyjC63PWe0vJwF5E6zSQYOmdii1VUrET1JSESXXBQiuEL25tIdXMAudDEQYHLriaqdo6wxhN+x2rudsGJmC5v8siRwgkIwGbdnlt0BX3RPbpDIdm+q+9ILyT2qDcISMEFoMnWDod6BUNMh6HVvnn6Yhq6i0Vqqjd+Ib0Jixd7ezacTBg759nmLm9NjpjqRAdaV1luXJPSVYY6lRzCwz1jgjZj9jRY1tCJAizrrDpTmnLjc53kocIhKJT4IXlrk7+DEycaXHPBZfzEI5sv0Hn2I9qSoSclnV0nxo3sIZ9mMnbKmr/CAnM2olo+jsk2r02OUqZYW5Gtq49+ZHJqimo0uD0v3bysGC47RIRLsomaqYw9XO4nebqcEa1XcuCNKsXiYlIFytpR1PdVGttTO8h5ZR8PMxKDrE+Qy9ptu0LpOD/EXkPXBcXWZRRCe/Lp1DUUGhAgiRQIz7tQ1MgftpFi04fY
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(8936002)(336012)(5660300002)(4744005)(31686004)(31696002)(426003)(86362001)(47076005)(7416002)(478600001)(36860700001)(40460700003)(40480700001)(16576012)(83380400001)(4326008)(82310400005)(186003)(41300700001)(16526019)(82740400003)(70586007)(70206006)(2906002)(26005)(2616005)(7636003)(356005)(8676002)(53546011)(6916009)(316002)(54906003)(36756003)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:54:46.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f51bda-23e4-45bf-17df-08dad8ae6bc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 15:44, Peter Xu wrote:
> The part that matters in the comment is "need to be before setting current
> state".
> 
> 	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
> 	if (is_vm_hugetlb_page(vma))
> 		hugetlb_vma_lock_read(vma);
> 	set_current_state(blocking_state);
> 
> down_read() can sleep and also modify the task state, we cannot take the
> lock after that point because otherwise the task state will be messed up.
> 

OK, how about:

	/*
	 * Take the vma lock now, in order to safely call
	 * userfaultfd_huge_must_wait() a little bit later. Because acquiring
	 * the (sleepable) vma lock potentially modifies the current task state,
	 * that must be before explicitly calling set_current_state().
	 */

Other than that, the patch looks good, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
