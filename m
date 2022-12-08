Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62BB64787A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLHWDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLHWCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:02:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7379C27
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:01:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMfJijiyFI7zvYcp9k+oXICzJ1MH9Ld3mkEqhzZ9VcSWp8b23ZATn7pNEdA9eu1iiR7kl3Pjk0C5IQeuo/niZTDOeUL3PaAE0qjQSh16FiiUYd/GUrMyP6bSEdTprG5CjGvPBrYafH4anGTEK72Tq0TluJ+8iIZirwOcK53VfiKSUvC1pEedMHN5uw94rI098j/kPb1eu6RxSoLpTNWZj9Ny63faAyxJh21HrhClhbGt9+xKJY+1UJIc12x2T1hbsDBDRO95zlMWeJe6kdtsHHXI4I8ncTghIDnLf14sIOZ44F+AZ8q4NUSx5G6SZLGMAjeIjPiw4+KXo6WPV8P7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv6rBuCUHWtWGaSGfackNETsiX+wHtjMl/4knqFEBdo=;
 b=d3Zv4DBRNAP2F6x9IQ+L4XDr7Zp/pD2GVoSSdaBmYZV+Fz7ZvzBA49Oi7edAScGaOoseNMi2fVC9bca30egAuJr0xlPbIFVa1XExbzlkyo/mw6P4gj2NuGojWxri+rBk73nX7jnM8mJMkwR2+GmQvE5BMwkthY2M2grlJVZqX9H1+2KjS+8DL6LTiM/z/d7CBdpJ5Ag9vdByH3OMQoM/cjv7Q7LscH64IR2wnudHl5vIzbxZP4tTtOmGHDr2EbUhlD9HDnd8w89bI6LdbsNnS1gZb/dKK4S3sbc7UmHZAMZBkSKZf+TwtS1YhQ8m1YI4C/GCaZ07oZkFS0iRIJ8qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv6rBuCUHWtWGaSGfackNETsiX+wHtjMl/4knqFEBdo=;
 b=O1mYzep2kZL38SnaFr2S/bgFZJkfJw8OmNGDr9lH7c65UUwnQPuft6YrJRTH1+NVSyGCpnXzt4ymi3BPz/skgzZPaO8miuMb0/YDmJbmdopI28oG+4Ai/Y6NCghrQsCMfFH5j3UQuc+r6/R0GQRCT9GYjuIZ4pPf051sbg0oMRNToG1Zc9TZuPMa6pD+pXLGXU40MYy0SVeEVrLmOWcNNUS1LhcZbU54v3kPH6v/xiL+sJ35hPXL+PNlHowkiq8hzq+taGNNNXsr9oegp87TbfFwywBBX61suJaQotvoBs+TVJscNj3ExdW0bLM/KSZVGyUf8aOHkR5vKGtHM7Xaaw==
Received: from DM6PR14CA0071.namprd14.prod.outlook.com (2603:10b6:5:18f::48)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 22:01:19 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::f) by DM6PR14CA0071.outlook.office365.com
 (2603:10b6:5:18f::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 22:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 22:01:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 14:01:07 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 14:01:07 -0800
Message-ID: <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
Date:   Thu, 8 Dec 2022 14:01:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <tsahu@linux.ibm.com>, <david@redhat.com>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b86ca6-de2c-49ee-2474-08dad967bc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiJOdkrv/L2jQteBxos+yzxVAREO5NJekVFb4dp7LFEVRAQ6XKImOgUD02QyXoQaJjmZpsA4lhjolOaz3rA7Bs9nzUOXxo2aiesdZDe9ufoRkRLipnRXJ44BHMd4AjGw/hzhsZFbf/Oo+jVRf+5+M05V2dKrygEi3njs6VVRA03435kZEkgYMz39etPvhaAEMYI7kHj7l4IEQM/8MaPz+iGrp+Z9qJW7yeJ+RKD2rEs8mSWKaSHiC5Nq2ios3hAeb/+rRg4jtae5bwYB7xdgx0KtVHB4Jn+z0JWUY32iyp3oWMSb0WVKhVjTLcO56XTJ6AvnLq5yddJjNRvhaBfzB/6PaP9cv2si2m929CSrEtxK1R8UVPn5qkd816XCN+sBYOzAPmAuafm9/94utlHue4dQzxoZVkCmA4CLwxx+j8cDOXETBNvtwi0azny3xSWk3aMoGpi632WN4d4kgTg132q10mkxbZqC+A5A0x8QuwcA4mUBPXXR0ZMZR6tyeF3JQkJZqQ/A1nCMs7O9wsjbawdj/Rz+jFGXk0SteyPdOyXjSng3Aujf3czgDoebs3S5LV716icmBcNoIPMfzN8fV/r26J/bHNS0Ue0pdg2bU1Ncmlwt5yIyMKMdfn6aJD8w6exC/leofyodullCsLUafyN5bnucvSxNhAsPRZxhSx0xgUh7KZnzhpiJU/tFpd7Mb/GK+tBP6WgCexDj6vKm/xCt0LiEk11U82X2JMCocus=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(5660300002)(70586007)(8676002)(41300700001)(316002)(2906002)(8936002)(16576012)(4326008)(70206006)(110136005)(31686004)(36756003)(40480700001)(82310400005)(7636003)(40460700003)(86362001)(356005)(31696002)(83380400001)(426003)(186003)(478600001)(53546011)(47076005)(26005)(2616005)(336012)(82740400003)(16526019)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 22:01:19.3140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b86ca6-de2c-49ee-2474-08dad967bc8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 13:58, Sidhartha Kumar wrote:
> Thanks John, Mike, Matthew, and Muchun for the feedback.
> 
> To summarize this discussion and outline the next version of this patch, the changes I'll make include:
> 
> 1) change the name of folio_set_compound_order() to folio_set_order()
> 2) change the placement of this function from mm.h to mm/internal.h
> 3) folio_set_order() will set both _folio_order and _folio_nr_pages and handle the zero order case correctly.
> 4) remove the comment about hugetlb's specific use for zero orders
> 5) improve the style of folio_set_order() by removing ifdefs from inside the function to doing
> 
> #ifdef CONFIG_64BIT
>   static inline void folio_set_order(struct folio *folio,
>                   unsigned int order)
>   {
>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

Sounds good, except for this part: why is a function named
folio_set_order() BUG-ing on a non-large folio? The naming
is still wrong, perhaps?

> 
>       folio->_folio_order = order;
>           folio->_folio_nr_pages = order ? 1U << order : 0;
> }
> #else
> static inline void folio_set_order(struct folio *folio,
>                   unsigned int order)
>   {
>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> 
>       folio->_folio_order = order;
> }
> #endif
> 
> Please let me know if I missing something.
> Thanks,
> Sidhartha Kumar
>> Thanks,
> 

thanks,
-- 
John Hubbard
NVIDIA
