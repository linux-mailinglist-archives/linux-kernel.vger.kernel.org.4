Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37FF64521E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLGCjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLGCjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:39:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49CF4C27E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/kdGwAgBQ4uP9fRaG6MR+vrDbgpdDPvR+CCUbmbReDIAWfD3JgkTC2dzvuwrUZWM0ZHb4Ni+kxPOEi0hPtEUFaqo6/Zd+O2hd6vHT1pxaKTHhX2syFDGVASnpiYx4rkPCEnNU2OHgs4fvhCNEMdLj7Y5ty4LXK9mw+3yiq68fn13X65m0M2zGDxVfTJgcBFZUO/W43GjwQBCZeJF1mtkHyXs+iLIsIWAy0bN5hf5JHrlAHg0nqOPJnD36WDILsbjxq7EgFlLTnlfbGvn7O3ozOgQPZE+eSH/bjTi9lK/a1GR3MknMzbFmfwLM0LXjA3tI6MJSW8f5aS23RM+jIoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rv6nuKBhBb3t3Td3OTGm8ArPaDmEW81grqsMfreUwk=;
 b=aFBttzBZvDZVsWAcyTwjmqH6Y4DMXj5LR0kRs+bVoA21s6tpbnz43Jsdu1qGZm+Ris2Jw0O9YP/OkCyRFPGN87C3e/ezw8Baw4XTOLAB6nzLb/aI0bfnLvfXIQC7VU4gqEYMrnyQyh6R5BTBD5+7irjbNqm6XMZ4lJzJEAbe/AwLYcanU+KWGZI40oK3x5q4rUTFUDdl6YYIw251e86qIp5tB8wwHxLWMPm/FM6l6FhfTJiOGDuE6cqGQGiRCFikOtFvlepIXp3aqdOLaZzn2489vGq8fKIT2TenQdyShEO8SLkUPw9TWDsTrQ1EaInY9pFCgsuhqLzDY8Fj2Bd37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rv6nuKBhBb3t3Td3OTGm8ArPaDmEW81grqsMfreUwk=;
 b=k+Jo55+cbOH7P0B5L8TBIOXwQu4RL9ylpK65AyoCGWanzEq4TvY9mMW+Ap9ZQZ14egdH9eVr94e7aUbgyZIyBJDSscc71IFUF/JSOr9jBm45EDPRIvH6agdmrixCozZDlpDjnaH3pgS5OzzT0a6t0JRhik7COjSk5X6O/O0azq9qxxzyUDpHhENNqfRLIQP/D1NKSAh5/W4C1PC0tU42+OKq3ieAaq5pdQllhcU7DS84o4Hgu+0WoG0TUXMOpMZCz8GESTvLDE+PXSyU7dJwGFTkLyih1JdACQyERlmrT1purG/hcjwvXaUExwhgYpYhglYofNFiIiWknihgDxf3JQ==
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 02:39:12 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::8f) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 02:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 02:39:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 18:38:56 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 18:38:55 -0800
Message-ID: <3f032921-c373-e942-a857-4328d7993ef0@nvidia.com>
Date:   Tue, 6 Dec 2022 18:38:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        "Jann Horn" <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com> <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com> <Y49xlV8I2/92Flha@x1n>
 <97e3a8f2-df75-306e-2edf-85976c168955@nvidia.com> <Y4+5R+nh0W0RUX9R@x1n>
 <c5d839da-cb7e-e887-11a6-30ccd1c3c845@nvidia.com> <Y4/ZT3ab9TL1j5TL@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y4/ZT3ab9TL1j5TL@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: f47bade3-6d39-45fb-6f55-08dad7fc3942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtofLvuJbCPI+sr3pHRS0OflHWBfCw+yqLsGSa4C+9uzc2DH9aK4kMS28bhggtWEa32mM3SYH1wQq8sqo5yAwV0fgPF0w5u494wHNbNas1KfjCh1CzeEbxGjfOK8rDnVLPJ30FsGr70sqjhAUVq9d9lCMruTdfL3NzDbZtCgeR7bH1aNewCBgcLOFiZxpyNfCilayyRGYNwiH82oPOyc1leuv5Kh7LcL8Hv4ruPSUYVqE8u5oOgPsijXDjyPRJlR4uNqEHAy90GMu3ioNMt5RUtDSmJuombKyDMi5XePk/IP/j4izVMjWg7OdC3htrBwaih/NL1C7YYvY2Iw3r7HZEjYPZNGust8Jsh7260FPaHozR7WWpmvrh77LaDFBJIPKba5WkI+q1xdGu+73H46iqOg1wvMMr+/WbuqMyCeV67Osb0sbZMEsxYBL0f4SgElogZVF5Czy6KlkqTsmn+v5Kg9av8QfXD6z63qLJTrUAyTU0StSiMihDfGerxCQf573SSZEbxVrlfOsvogPrgbvjuE5ck8ed28Aoe2Z4TGENAB4n1lfdjRTlNaygbg6p/exXm7nQ3OMuSxOWCYM9jVE5QmWn0Xdjvf1Ls8W6YuzvIRMkzeoNa9iHeu5y8K3xcvaInP1NIndHbw9AhSf5hld9PNPyYoNH6sGfadZTl2CyRqvT+13UbXJpsAJenu+LBz+th8Qrm64rkaqokL/3AU9XoXVQDR9TAwi2zj0j/c1cA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(186003)(26005)(8936002)(53546011)(478600001)(356005)(7636003)(40480700001)(5660300002)(7416002)(86362001)(82310400005)(336012)(47076005)(6916009)(426003)(36860700001)(54906003)(82740400003)(40460700003)(83380400001)(16526019)(70586007)(2616005)(31696002)(31686004)(70206006)(41300700001)(2906002)(36756003)(8676002)(4326008)(16576012)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 02:39:11.7794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47bade3-6d39-45fb-6f55-08dad7fc3942
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 16:07, Peter Xu wrote:
> I thought I answered this one at [1] above.  If not, I can extend the
> answer.

[1] explains it, but it doesn't mention why it's safe to drop and reacquire.

...
> 
> If we touch it, it's a potential bug as you mentioned.  But we didn't.
> 
> Hope it explains.

I think it's OK after all, because hmm_vma_fault() does revalidate after
it takes the vma lock, so that closes the loop that I was fretting over.

I was just also worried that I'd missed some other place, but it looks
like that's not the case.

So, good.

How about this incremental diff on top, as an attempt to clarify what's
going on? Or is this too much wordage? Sometimes I write too many words:


diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 1f7c2011f6cb..27a6df448ee5 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -21,13 +21,16 @@ struct mm_walk;
   *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
   *			Any folded depths (where PTRS_PER_P?D is equal to 1)
   *			are skipped.
- * @hugetlb_entry:	if set, called for each hugetlb entry.	Note that
- *			currently the hook function is protected by hugetlb
- *			vma lock to make sure pte_t* and the spinlock is valid
- *			to access.  If the hook function needs to yield the
- *			thread or retake the vma lock for some reason, it
- *			needs to properly release the vma lock manually,
- *			and retake it before the function returns.
+ * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
+ *			function is called with the vma lock held, in order to
+ *			protect against a concurrent freeing of the pte_t* or
+ *			the ptl. In some cases, the hook function needs to drop
+ *			and retake the vma lock in order to avoid deadlocks
+ *			while calling other functions. In such cases the hook
+ *			function must either refrain from accessing the pte or
+ *			ptl after dropping the vma lock, or else revalidate
+ *			those items after re-acquiring the vma lock and before
+ *			accessing them.
   * @test_walk:		caller specific callback function to determine whether
   *			we walk over the current vma or not. Returning 0 means
   *			"do page table walk over the current vma", returning
diff --git a/mm/hmm.c b/mm/hmm.c
index dcd624f28bcf..b428f2011cfd 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -497,7 +497,13 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
  
  		spin_unlock(ptl);
  		hugetlb_vma_unlock_read(vma);
-		/* hmm_vma_fault() can retake the vma lock */
+		/*
+		 * Avoid deadlock: drop the vma lock before calling
+		 * hmm_vma_fault(), which will itself potentially take and drop
+		 * the vma lock. This is also correct from a protection point of
+		 * view, because there is no further use here of either pte or
+		 * ptl after dropping the vma lock.
+		 */
  		ret = hmm_vma_fault(addr, end, required_fault, walk);
  		hugetlb_vma_lock_read(vma);
  		return ret;

>> I guess it's on me to think of something cleaner, so if I do I'll pipe
>> up. :)
> 
> That'll be very much appricated.
> 
> It's really that I don't know how to make this better, or I can rework the
> series as long as it hasn't land upstream.
> 

It's always 10x easier to notice an imperfection, than it is to improve on
it. :)

thanks,
-- 
John Hubbard
NVIDIA
