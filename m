Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53786647ABE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLIAYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLIAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:24:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD87286B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFEWKEGqkB2rpwrJMA9x/Hcmpu8hKJkAUC0dL4UoNos0QU9iBB3Ac6UwWsDKddsRSvYJnv91pByAVupB3Ci+sz4E0LCfxGGH2SAqQAq6wGiEXSbQiXJLBTCmjVU2ZydkmqO/SVtpPubc+E6vSGRtAAPKsfqcmcJpd2z8MOiVt2TsjZs6lNEhmHUf3UtXtLFDO7vNZJjS3TdCc6Xf0JZohWbBfyxg1jx1y/9GIHBzr5bhrM5eukEemH5qaVvW29r6bDyUnrTkPizgoyvnb2E/TGVx1/w1jqbXWgL7d695wXOG/FsAr88gVbZyHUqYjKixBZM+kzsqkswXebedgqNDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZFEAuPh05ngl5scTcV5iq5EXE+dvYiN8qVaho49trg=;
 b=UVNflGtRGzgPGv/P5/JobleI4M8j+D81picsDOZmk5c3WCa8fHOiEPjElrbtaDod+k8W+jyPK1oGtvPiuR+uh3EQao8LPNn29ncmt8Kzlpx4jtOPtJcllyjTRMSd7Va3wR4J5F/l0fiOrmvFAmzgBWgO1lBhQQNiK6kghbKLZ8qi7D7FtMMm9dAkEe3xsXrIZdgYSzvzkk5TtD9swAhxlw0xUsBWy00BXX4Dr9YoM2ypyHkhvBGwn+PaoVZ44FHrdhmXJFfr/0nsMUv5zWIWoaJEBGsWAr3umLkW0SwxXJAnnf8T+/IBxZ6FABAVriHdg+hgnuTgwMKSH+pMfxT11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZFEAuPh05ngl5scTcV5iq5EXE+dvYiN8qVaho49trg=;
 b=FJpcDZZqeHPd3FTleZvXpFhuybu1+Lz4Y3X1FS728KacCdVtjxsPVYoqOUFJuA50o6B2VrNkqKCUx7dd62qzLkOLdILQ7tZF7H2r8J7itggQf4GbTNQaQzDQKCI5S6F0OfzXmhscBEnvuiKvgjIWsum+aeR+FEYwKQEGHK0p/44+ddZOXv7g+G6Ye92yzYV+w2aA0GCvGPF1nQEVbiaKVcy2C5nRsParFiJo4yKBQ/Z9Z99obrj9qlxviFlGxuQ8rw4gbfkWvgp1W+7wKxFz306xkcBmiyrXmNol+6iB25aQ/QYOSOpxDLE8i3M/YAsWJsuSc9yhXN8zGO1Sqw+iUQ==
Received: from CY5PR15CA0203.namprd15.prod.outlook.com (2603:10b6:930:82::25)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 00:24:31 +0000
Received: from CY4PEPF0000C972.namprd02.prod.outlook.com
 (2603:10b6:930:82:cafe::ed) by CY5PR15CA0203.outlook.office365.com
 (2603:10b6:930:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 9 Dec 2022 00:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C972.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Fri, 9 Dec 2022 00:24:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 16:24:21 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 16:24:20 -0800
Message-ID: <7f3096c5-c3cc-4ead-7c5e-8bade6c930da@nvidia.com>
Date:   Thu, 8 Dec 2022 16:24:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
 <6a970de6-e3da-f57d-14fd-55f65ddcb27d@nvidia.com> <Y5JRhU+9QqoUuSdR@x1n>
 <61751d01-2ba4-efc0-9cb8-eeeb3d70908d@nvidia.com> <Y5JjTPTxCWSklCan@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y5JjTPTxCWSklCan@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C972:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 444a6dda-211c-444e-1698-08dad97bbddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgpKBHpAbAst2olrxHupnpbboxaDCu7TApf22tOyuWTt4i7g8IwNJT4EBKLlmFgm8L2KLKf8KaQKr/pmZKa+l4XppT/9zwpW0huKxB041IFgPtZUU2migM6aMaq0Yx6vNSD2uSLW+015eWq8W7HAJXA2YeksfSe1Cr7/FI1k/5mkQf5pdcEVX1VCLuIwF0wOwijG48DeGJDRQ3L1LvK6/x3aRWLD96BRfvhjSfMPLqbgkXmNHsW3NGunO64ESE7TFfijgCSDHVq9YJgKpPiTEKhgdb053QciY6U9jmvzz2bUdJpHCFk+vDs52AmVUIpEfG5EfWcpN/xz9U7fsRkl3E6fAyjcw54hmS3hpKuOTu72mGfGcYngiTyUC4WA97PPx9VRSqWIbWJcH49bEyNW4FTMdFNnP5PtvZFtOvL5hftsP3E/vo4GaMf7Nr53AB20u7nWp/vOYHbxy7FkCvZmpk181bIyNkTbluKXBz1/yzs0Al/yaakXy1xP8G60HuaOfPQy1LfInLAEmez0P+Rq8XLtWRd1AQ6dE3+UkgGzWija5A8orJEI+UAO89mEq6SDJGIN6108Z/G9BUlRBfwjgtCcpI6nk7DWm0sgZpT5Reatz1nhqaIoxU2vkUhuFTG2ERWPuYmFG2T1B31KJVTDQQ31yIzRnnd4ehj+YfjuIWJ0m6c4d2h3YxaUzZxZamQgqrEJDy3dJQDPS4IgR3NsLcDME5NBve1zH5sNEWqLsWE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(31686004)(2906002)(7416002)(8936002)(5660300002)(86362001)(16526019)(7636003)(47076005)(83380400001)(70586007)(186003)(36756003)(82740400003)(41300700001)(336012)(82310400005)(2616005)(426003)(36860700001)(26005)(316002)(54906003)(16576012)(70206006)(6916009)(356005)(4326008)(8676002)(478600001)(31696002)(40460700003)(40480700001)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 00:24:31.4306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 444a6dda-211c-444e-1698-08dad97bbddc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C972.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 14:21, Peter Xu wrote:
> 
> Firstly, this patch (to be squashed into previous) is trying to document
> page_vma_mapped_walk() on why it's not needed to further take any lock to
> call hugetlb_walk().
> 
> To call hugetlb_walk() we need either of the locks listed below (in either
> read or write mode), according to the rules we setup for it in patch 3:
> 
>    (1) hugetlb vma lock
>    (2) i_mmap_rwsem lock
> 
> page_vma_mapped_walk() is called in below sites across the kernel:
> 
> __replace_page[179]            if (!page_vma_mapped_walk(&pvmw))
> __damon_pa_mkold[24]           while (page_vma_mapped_walk(&pvmw)) {
> __damon_pa_young[97]           while (page_vma_mapped_walk(&pvmw)) {
> write_protect_page[1065]       if (!page_vma_mapped_walk(&pvmw))
> remove_migration_pte[179]      while (page_vma_mapped_walk(&pvmw)) {
> page_idle_clear_pte_refs_one[56] while (page_vma_mapped_walk(&pvmw)) {
> page_mapped_in_vma[318]        if (!page_vma_mapped_walk(&pvmw))
> folio_referenced_one[813]      while (page_vma_mapped_walk(&pvmw)) {
> page_vma_mkclean_one[958]      while (page_vma_mapped_walk(pvmw)) {
> try_to_unmap_one[1506]         while (page_vma_mapped_walk(&pvmw)) {
> try_to_migrate_one[1881]       while (page_vma_mapped_walk(&pvmw)) {
> page_make_device_exclusive_one[2205] while (page_vma_mapped_walk(&pvmw)) {
> 
> If we group them, we can see that most of them are during a rmap walk
> (i.e., comes from a higher rmap_walk() stack), they are:
> 
> __damon_pa_mkold[24]           while (page_vma_mapped_walk(&pvmw)) {
> __damon_pa_young[97]           while (page_vma_mapped_walk(&pvmw)) {
> remove_migration_pte[179]      while (page_vma_mapped_walk(&pvmw)) {
> page_idle_clear_pte_refs_one[56] while (page_vma_mapped_walk(&pvmw)) {
> page_mapped_in_vma[318]        if (!page_vma_mapped_walk(&pvmw))
> folio_referenced_one[813]      while (page_vma_mapped_walk(&pvmw)) {
> page_vma_mkclean_one[958]      while (page_vma_mapped_walk(pvmw)) {
> try_to_unmap_one[1506]         while (page_vma_mapped_walk(&pvmw)) {
> try_to_migrate_one[1881]       while (page_vma_mapped_walk(&pvmw)) {
> page_make_device_exclusive_one[2205] while (page_vma_mapped_walk(&pvmw)) {
> 
> Let's call it case (A).
> 
> We have another two special cases that are not during a rmap walk, they
> are:
> 
> write_protect_page[1065]       if (!page_vma_mapped_walk(&pvmw))
> __replace_page[179]            if (!page_vma_mapped_walk(&pvmw))
> 
> Let's call it case (B).
> 
> Case (A) is always safe because it always take the i_mmap_rwsem lock in
> read mode.  It's done in rmap_walk_file() where:
> 
> 	if (!locked) {
> 		if (i_mmap_trylock_read(mapping))
> 			goto lookup;
> 
> 		if (rwc->try_lock) {
> 			rwc->contended = true;
> 			return;
> 		}
> 
> 		i_mmap_lock_read(mapping);
> 	}
> 
> If locked==true it means the caller already holds the lock, so no need to
> take it.  It justifies that all callers from rmap_walk() upon a hugetlb vma
> is safe to call hugetlb_walk() already according to the rule of hugetlb_walk().
> 
> Case (B) contains two cases either in KSM path or uprobe path, and none of
> the paths (afaict) can get a hugetlb vma involved.  IOW, the whole path of
> 
> 	if (unlikely(is_vm_hugetlb_page(vma))) {
> 
> In page_vma_mapped_walk() just should never trigger.
> 
> To summarize above into a shorter paragraph, it'll become the comment.
> 
> Hope it explains.  Thanks.
> 

It does! And now for the comment, I'll think you'll find that this suffices:

		/*
		 * All callers that get here will already hold the i_mmap_rwsem.
		 * Therefore, no additional locks need to be taken before
		 * calling hugetlb_walk().
		 */

...which, considering all the data above, is probably the mother of
all summaries. :)  But really, it's all that people need to know here, and
it's readily understandable without wondering what KSM has to do with this,
for example.


thanks,
-- 
John Hubbard
NVIDIA
