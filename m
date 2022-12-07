Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDC6464BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiLGXF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLGXF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:05:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E863AC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE5dvndp/NhyzeZ4HcVACPAjJ+ODLOz1f0CiLGHvaoxBBGNAlWNA/s4FoGIhAFBhvOI1u/L2bboCnrMVdG2bZjdjq2Cb+gOHwiiVhA5zRI31HCws2bTDMCeWT51xkIPewpR/LYK6Zieg96+91sFc7WrQjvsMDCzdnToSDEdLN9MhjJpUGGJjmY/LYN8ZMWm2qbiXN/FHL3BxTns937h39nw3iI+pGWfEUKrT9jI1VItRZCjzjE08s3UvexOp9e6YTlNxpr1s7IZz+tiB3FtGfGhLXEQVNcm/yArdlRvgReRcBG+bYDm5XdOCPCWgkAntFm9ymxOoBJqvz8CGHoYpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxhJ1518yT3EYUkBXE9HaS0Fz/xtcvai8tQw1CsZCQQ=;
 b=jObLg5wXMz+NsbUVdNQYGl8lzkVPbkRgmdbjlDjWpDrnNYNuqLRmEjZfPVXqPRq2XVBWczf22Q2hL1gr4eT3nKzm/AWvT9mmzTlvORzUeD2VWJJMvjCDHcgpJUsa9umBAbaYKyUy3B4E2pqPye6DgWoG3w0omX/OSfbsMjBJCi/ijeWu3tNiEmVb70Rc/t4RPwpmW/FZ8f3ReWB9bYXeY4w6cr+R/ORZdFiskqmxTEgfYMMCG6SQ6GYG/UmDa6F7Vz23+QFsXulM3qcwG6qCDEEdldA5CGpx6nxfWVbqOsihrYJSRfFFNAevJ4dpWTiTkpneIY/yyIaLSjnTctbeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxhJ1518yT3EYUkBXE9HaS0Fz/xtcvai8tQw1CsZCQQ=;
 b=CM7VTZOXp9yCWvphnjnc2Q8sow5EScmZnPc/fOqmbNJklVQP47WNdWkBvDAP/jdcgbZAgtYg+WSR5JZIhk1ePkuCfXyOPeJglTlGM0z1xihHwKofL5qmw/YsgAyex01YT5yrrc55qWh9WMj6OpWfvIPPM9Kk5Dhc9r6rRdtSrx2w+V4I8n+ezeJc8fJ2JqEX0e4aWplAr6JoFypnjSZ5T3qdo+QNbiVDR/9YHCEpWtxe8NRS4+P/5CxubXxsYanQfPNVZlVSkObqQthOr2Dy6A4fP1IhAXKCQC8odKOdO1EfPesP6J7oEq+F9X+sKxYMP/31wp6lOx5DaiVaih289w==
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:05:53 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::5e) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 23:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 23:05:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:05:44 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:05:43 -0800
Message-ID: <86bff55b-d048-1500-cddc-2d53702d7a3b@nvidia.com>
Date:   Wed, 7 Dec 2022 15:05:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 04/10] mm/hugetlb: Move swap entry handling into vma
 lock when faulted
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
 <20221207203034.650899-5-peterx@redhat.com>
 <326789a5-85ba-f13c-389e-fd21d673e3ae@nvidia.com> <Y5EW+RTuGuGhfdNk@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y5EW+RTuGuGhfdNk@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dfa5cc-e15e-40c7-e3ed-08dad8a7972c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPSaJkZF3skJTrazajU2CXrb85bIdYwlcA0SG7mVZ/0jnDy16JEdFVsIer6Ytozo8jUEb3h22df3CIL/y5SroSye53VD40Dwea6M++Ig5oG3Jdi2B+sDzuCkaxIUfWLnJJh4xWL/0KQtLCYtVGY8uu0MfP5Bho0Vk3jEALYn79/TYmO+yyyE7A7rlWQAmhE+n7cITd5N/1twzjnwtZrZLNHn8wdDU7Hl/zXmHFk75DVL246cagWzm+aCMPqSD1tHhDEOKE1zgdExNTTsy2sWwysr0+PvJGPQKQTnWZGldCCVmaJ1tcZr3BYX/VhL5vf6z8UG4xCM1IEbVxi0fuuu7lqRQJihWPhdeCtyI8vZrlq+EPDhiI6/XKZqN0DGbKbEpwgKSGjgBShoi9qh7QWDfCaqP51AjoT9yBDd5Pi8RrI/prrs1zdkiLT4uGwL/FGoyAqY5q1kr1/LTHAKlI1WHVf1fpP7AqQUl5MUR6bOZS6BwGc5ux/u9xcAsadMZkMv8exJ2JXeQf/eQXr9++Btt5DF78GKQ5lYsSWsOIAzDXAj4g/ZDN7ekbdt9ylY7wYeKlDMPfAjixeY1ZFYYjmUcmF6smwMfGMsyJ52adV4upUoUb8nPIdN0AtKnNoWbAKhua2Q8/Ghff4iI07haEX6GIU/RLMNgil4El4qTR8NWVm0/zlXdt+2zs2gJrRZbOlThp1gFoAF3ljM6NHbacTr+QdRRJu9N0Gg2yc05Kb6HXM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(31696002)(82740400003)(426003)(36860700001)(47076005)(7636003)(7416002)(86362001)(40460700003)(83380400001)(356005)(2906002)(186003)(40480700001)(336012)(5660300002)(8936002)(16526019)(53546011)(26005)(8676002)(2616005)(70586007)(6916009)(316002)(54906003)(478600001)(16576012)(82310400005)(70206006)(4326008)(41300700001)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:05:53.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dfa5cc-e15e-40c7-e3ed-08dad8a7972c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 14:43, Peter Xu wrote:
> Note that here migration_entry_wait_huge() will release it.
> 
> Sorry it's definitely not as straightforward, but this is also something I
> didn't come up with a better solution, because we need the vma lock to
> protect the spinlock, which is used in deep code path of the migration
> code.
> 
> That's also why I added a rich comment above, and there's "The vma lock
> will be released there" which is just for that.
> 

Yes, OK,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

...and here is some fancy documentation polishing (incremental on top of this
specific patch) if you would like to fold it in, optional but it makes me
happier:


diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 49f73677a418..e3bbd4869f68 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5809,6 +5809,10 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
  }
  #endif
  
+/*
+ * There are a few special cases in which this function returns while still
+ * holding locks. Those are noted inline.
+ */
  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  			unsigned long address, unsigned int flags)
  {
@@ -5851,8 +5855,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  	/* PTE markers should be handled the same way as none pte */
  	if (huge_pte_none_mostly(entry))
  		/*
-		 * hugetlb_no_page will drop vma lock and hugetlb fault
-		 * mutex internally, which make us return immediately.
+		 * hugetlb_no_page() will release both the vma lock and the
+		 * hugetlb fault mutex, so just return directly from that:
  		 */
  		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
  				      entry, flags);
@@ -5869,10 +5873,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  	if (!pte_present(entry)) {
  		if (unlikely(is_hugetlb_entry_migration(entry))) {
  			/*
-			 * Release fault lock first because the vma lock is
-			 * needed to guard the huge_pte_lockptr() later in
-			 * migration_entry_wait_huge().  The vma lock will
-			 * be released there.
+			 * Release the hugetlb fault lock now, but retain the
+			 * vma lock, because it is needed to guard the
+			 * huge_pte_lockptr() later in
+			 * migration_entry_wait_huge(). The vma lock will be
+			 * released there.
  			 */
  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
  			migration_entry_wait_huge(vma, ptep);
diff --git a/mm/migrate.c b/mm/migrate.c
index d14f1f3ab073..a31df628b938 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -333,16 +333,18 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
  }
  
  #ifdef CONFIG_HUGETLB_PAGE
+
+/*
+ * The vma read lock must be held upon entry. Holding that lock prevents either
+ * the pte or the ptl from being freed.
+ *
+ * This function will release the vma lock before returning.
+ */
  void __migration_entry_wait_huge(struct vm_area_struct *vma,
  				 pte_t *ptep, spinlock_t *ptl)
  {
  	pte_t pte;
  
-	/*
-	 * The vma read lock must be taken, which will be released before
-	 * the function returns.  It makes sure the pgtable page (along
-	 * with its spin lock) not be freed in parallel.
-	 */
  	hugetlb_vma_assert_locked(vma);
  
  	spin_lock(ptl);


thanks,
-- 
John Hubbard
NVIDIA
