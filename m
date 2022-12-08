Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC93646606
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLHAil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLHAig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:38:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55168DBEB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:38:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWUStRG6APVhPecnatbUoCJq2MVrm0HBL56254y3yaAWHAb5fewAi4cHL9R9RQAT1xAufv8Wsjv7PH/1z8QpcDd7d3begdLR8je3a87u67o/ytUXmZ0+fLO3lJNPqCnbeo/kpB15ok1gS+nWAofUKvqyvdk0jPkIS5/j0HvVcKjeOEwII81yx5vuR0r7QWienu/r9KPA2Zr3AtN3j3Y8InCEfJ+EpAI1z0rFTsQjtucv/M/GbcpOoxu10fSM7OSTNy55pFIip8D6h9iIENyADsc918wD9VizWcP1K4PO8A/aADv9r2+7CUNlFwzQxPIdj+CPYgag7Ta3yjwG51wy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV7Dscwwy++nvejv+A11TNQTnWrBspFkhTtpNT/Sn8g=;
 b=b6g1q2ODnVyHW26qmuZfcALMJwnwP+scz7E+m1g+/rBnx1UtIqLFpenCNcrQyuuez2cm1dAZdus05aiwvq4coOR7BYWky1cWsh+YstlpbbpwObBhji0K+ribmz7MQPbL3t+ZSHL0dSRgkkM+tSpYzecRgS37A7RVqS6cVOmJrsGFv4mvBdoFAtzF7dyFx1Q1b8RfG08gNzBOO57sLN60Y+yzu0Hjm+qs8hCQhITbX/L8slAwjWWeafIjqAVTqeNAvJgBz3MEBLRG4mF0qoAJH0QmyG4nBrpXA3rXNBD3obXPpZWpDG7/7iST9YpzFk6djDrJ/Auj65kCjk59o8OwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV7Dscwwy++nvejv+A11TNQTnWrBspFkhTtpNT/Sn8g=;
 b=WV069v0cMirORnDo4SNJMDI/1AnZEhOkQuhq6dotI38EWNupLwAmrK8XFOuUltKbup2sHOnFOtMP6WJYzH6uEhj0joUbkXeYXA9yrf6l0KZYw+4aS4vPKqqtbkXmlPSSbADWeEbSj6lknz92PHEpI3xFDvh+ScAd3hcBclgh3aHv3McirdNwBDKgsygxNFQbCT9BIB44pKcDWMjPm3LtpiSBE3CA8r5Nqnfxw5FMM4IeX2+lDn1uBjKWgM7qh+xcgDqrOvtYQrwRHFKzsPD7PPMrBST5jkbIH7stiwdxKg2CimWBGn0y0t1jT0o2ZwJrm85sHw1gyHYMTJNi9RkmRw==
Received: from MW3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:303:2b::24)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Thu, 8 Dec
 2022 00:38:32 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::21) by MW3PR05CA0019.outlook.office365.com
 (2603:10b6:303:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 8 Dec 2022 00:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 00:38:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 16:38:23 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 16:38:23 -0800
Message-ID: <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
Date:   Wed, 7 Dec 2022 16:38:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <willy@infradead.org>,
        <tsahu@linux.ibm.com>, <david@redhat.com>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: cb35c5af-c518-4bec-3072-08dad8b488a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5I/FGsZB7brhfPKYgkVIzYCEwMNuO4wMa8U90iBxUrJHutxf1YSHTnM/cJbFg7d6CAwrrmVsL+yG6vXlr5MooREsaWTV6Tr0d0BGE7BEDyMezPNhnaQamK4zD/hEGUuRUVWxHdTQDUd6hzZ371hgVP4X4wve/9RcE0+RNlysbzwVFDsMRTZAzftrmuLCDZ3QSHKXyczA7pnpmoGZ/MKcMquco10KscsBFzihF46VR3vP7Il8TcoXQ6h9u0O0nlaHJE0VuYpquEEb8eNiB697dUbohRLXcBVURiR8dQWfO+2XzrbcoUzEMbNBCGAiTLhtvj/48BlEvjGkvwF9AG/abiVcFm5kJgfNQ3FVlLIRQeBnfHqW7akpeH2Cn/7NFmoF1gABRuolwHRpsvvrbdFkUrSCZk/yRKnnI1Z9R8XH8zN9onumSqxPw9BGE/4md4TLygAvC0CmHXSKUytqoVIXK6NCIW4j3OPbvYrnfvb4S94Fe4wAme5GfXu/KQQojguWZWTLOJOPUiIGqBLwwUXd5ALm+AVVNqQbOEUzvUXjJQ9v5uCps3Cy1McIPDsa4CIVR4pbUBYEgZgZbclksZCw7Qlr2kt+xMcyE4n10gqobys9SDJ+z3xFsD3K4MFM8B2MmHsKU9QO9ad20SY5veoXeyxpthRhWaSfWv531kpCUN7m1sJjTJUHtQ9/WUn5tm3HfRyxb892ONvYRzcGRNTq8dUujwBF19dHpptzPJpH/mMuFZSvFg62X6iZaddlD6K
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(7636003)(2906002)(4326008)(16576012)(53546011)(478600001)(316002)(356005)(110136005)(54906003)(36756003)(40460700003)(70586007)(31696002)(8676002)(70206006)(40480700001)(86362001)(31686004)(186003)(83380400001)(26005)(47076005)(426003)(336012)(36860700001)(82740400003)(5660300002)(2616005)(41300700001)(8936002)(16526019)(82310400005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:38:32.3452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb35c5af-c518-4bec-3072-08dad8b488a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 14:37, Sidhartha Kumar wrote:
> Document hugetlb's use of a zero compound order so support for zero
> orders is not removed from folio_set_compound_order().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> ---
> This can be folded into f2b67a51d0ef6871d4fb0c3e8199f278112bd108
> mm: add folio dtor and order setter functions
> 
>   include/linux/mm.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 443d496949a8..cd8508d728f1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -999,9 +999,16 @@ static inline void set_compound_order(struct page *page, unsigned int order)
>   #endif
>   }
>   
> +/*
> + * folio_set_compound_order is generally passed a non-zero order to
> + * initialize a large folio.  However, hugetlb code abuses this by
> + * passing in zero when 'dissolving' a large folio.
> + */

Wouldn't it be better to instead just create a new function for that
case, such as:

     dissolve_large_folio()

?

>   static inline void folio_set_compound_order(struct folio *folio,
>   		unsigned int order)
>   {
> +	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +
>   	folio->_folio_order = order;
>   #ifdef CONFIG_64BIT
>   	folio->_folio_nr_pages = order ? 1U << order : 0;

thanks,
-- 
John Hubbard
NVIDIA
