Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB26439AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiLEXxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLEXxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:53:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1761D0F3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCXsLtWss+dWDT9VY3Wu4HdRncw5FjDgO3fLvAWBWdSWrCqI3+CQb3uBm04OYCw4UanqmMykwxDRf9UrTtLu0qfWY0xSZuB4m6ZPLa4x9LoDQJWf/Q39pjSFNK3xDEzeo1tG3dfScdkg+2Od2gZpQS4IoJ0ZoGDiHVfmNMIlD5sCjgBkIaK57x70JDPtctgAwdTLfRXDzXq7Jaeb+5rblXNYjFu2Q432bRHW/v42dmMDwlhc8XDGI/XlO6K4VOpwx6d/eu56NjZKl5SfjqlvylT6F8iwEzirp3Hg1y4bo9yB/58RbS1nFUL3gb4LOai1S4sSgc8fLZs42eZdTnULaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYGn77Z7H/fjhCHMz2EHimCpDaklzJKDqrATGAjjpXY=;
 b=W+uxJyE4k40LS36IAc4Pvt0gVD7lpypvlew8i6NqBxVOA5UFxoBa6yTLyfGdwfcWhlRnGh1Fv7r2PDOctAEhjowYbdv6kimA860CSR3T7i8fRioa83re6rXdTBj0FRKJ+VYzUFRnVMP8Rxw71B5ck9/e8Jk3Np5YJFKbnIN42n1z8bIEg/pnAQ/AZqNVApD3yLa8KAs0GGX/pERXQun/JNkmm4ZcuRK+3+IK5+HZ2xSIz0HUdAqhCoXyI9dPMwOMKVgonjpCl/DlxUDgqqQ0L4OD0gGG/E/VqCICMCSXCYkNZysXHiS6mx3G5Zx8UbMP5GJJMMGAUph2Xr3ExeL1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYGn77Z7H/fjhCHMz2EHimCpDaklzJKDqrATGAjjpXY=;
 b=n4OdrX/4zByGe+EPG4kTzdyf/j0vAWDCYJhdVOcryjqBkJgS0KmxNjE9Dt4nbFLMR7uSTLwroaSHu6Jv7mMyLH/DFiNXKyf27EmFOVRwYDZo49AxGx9v/LIC2A8gKFbfMJsP6GYaP4YdjCzSX5LJHS6F9G7UxUWl/xXqbbLLoCP/NdpMnAnd9P1uXrB4Vg393XbimfhFTRasP5UPJUmubobCSkYvFLtcXvrvb3oieue9MUbp/3pEdXFSSWsJf1E6of1dohYfujI69lMX+c4AuZolgMOpGT+G/J8YinLLNlvvd2oxfk2uBVI93PzagiVi0OkeZZeNIXDiM9zkB8t//A==
Received: from BN9PR03CA0169.namprd03.prod.outlook.com (2603:10b6:408:f4::24)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 23:53:04 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b4) by BN9PR03CA0169.outlook.office365.com
 (2603:10b6:408:f4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 23:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 23:53:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 5 Dec 2022
 15:52:53 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 5 Dec 2022
 15:52:52 -0800
Message-ID: <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com>
Date:   Mon, 5 Dec 2022 15:52:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Rik van Riel" <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "David Hildenbrand" <david@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com> <Y45/5ezH6uwn7Cfy@monkey>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y45/5ezH6uwn7Cfy@monkey>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1ae6c2-ad2c-4edb-b42f-08dad71bd9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWwA3ub5KjpM5KIverDjUqeRpNMgz/9FKmOXKOIcE0GV7pIKQvjwa1mT5AnaSD5U8qxFkuToRjRuVKTNRSWZjULZ5SWxuI4IIIZaZQtxKsIAI8LAoCu4+lb2cb367AS1ODl3ZRYpajog3ejaYtSkV7BwjcMayKM/gs9vl5mlNQuEbHJkTNbSTgLJG1lVB5W6kHGNWesTZxF3pKSbkCgfUvLTjiulH0kEHrTqkLdb1ajxTIcGqhSzLQHfgnXPGXmmyIrfPlCmcQcNZ8Dl0afgWQYf7m7HKWeOSdNU/2nj4KPSMPW3BtG4to/nD1YhUvSG5y7YgmcWNaVkbTt3q8zBiATLFdSCihMo2SNCQVX17wzdIc8odqUcbmyRiV1AFMmoKzubk53dK7KRuIg7WK6Z1KSgTDnfbST5QGgJabV1McAWxcLtAwYmzkXmnB0VXAqbSsaQuMtt8oiCoQ+aL7HRq94RbKo62nc7z/3c/yrM4DLC37u3bQWGoqCJ3sD/W6IqfEpo2kAPwVsos/0oaS/Sz5IuudCEtAwVpq12VelzMuVWWnkNomCI/ZZuh/g/z27ARHnR1Q3hJjLdFzejw6amRpadrRT9/uZVj71cxImirSg2G1OxqLfOcMBPRQYsSJp95XexvvobdQs4btWzBkrMEAlfbHE37ds5VLjUkgkBK6lx5HyakJDIj0Cubjru1JdeVHN4kjMMKMNI602POqQsNK4zSIfPjnjbIKx+GlnDM3I=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(82310400005)(16576012)(426003)(336012)(83380400001)(316002)(53546011)(26005)(16526019)(186003)(110136005)(54906003)(86362001)(31696002)(2906002)(47076005)(70206006)(70586007)(36860700001)(4326008)(31686004)(40460700003)(478600001)(2616005)(8676002)(41300700001)(82740400003)(7416002)(356005)(8936002)(7636003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 23:53:04.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ae6c2-ad2c-4edb-b42f-08dad71bd9d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 15:33, Mike Kravetz wrote:
> On 11/29/22 14:35, Peter Xu wrote:
>> Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
>> to make sure the pgtable page will not be freed concurrently.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>   mm/pagewalk.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>> index 7f1c9b274906..d98564a7be57 100644
>> --- a/mm/pagewalk.c
>> +++ b/mm/pagewalk.c
>> @@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
>>   	const struct mm_walk_ops *ops = walk->ops;
>>   	int err = 0;
>>   
>> +	hugetlb_vma_lock_read(vma);
>>   	do {
>>   		next = hugetlb_entry_end(h, addr, end);
>>   		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
> 
> For each found pte, we will be calling mm_walk_ops->hugetlb_entry() with
> the vma_lock held.  I looked into the various hugetlb_entry routines, and
> I am not sure about hmm_vma_walk_hugetlb_entry.  It seems like it could
> possibly call hmm_vma_fault -> handle_mm_fault -> hugetlb_fault.  If this
> can happen, then we may have an issue as hugetlb_fault will also need to
> acquire the vma_lock in read mode.
> 
> I do not know the hmm code well enough to know if this may be an actual
> issue?

Oh, this sounds like a serious concern. If we add a new lock, and hold it
during callbacks that also need to take it, that's not going to work out,
right?

And yes, hmm_range_fault() and related things do a good job of revealing
this kind of deadlock. :)

thanks,
-- 
John Hubbard
NVIDIA
