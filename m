Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98507703DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbjEOT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbjEOT42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:56:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14F2106CD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9qPLO4mSTNWI4RwYS5777cIOUrAzB4PzOkD3eFwAet4meg6sRHLv7NMAlYVFYRxc5UqfO+x2QYzH+fMbxWa8k2wJPQp/tT+loD1qoOEX8/jrJbu5CrdZueIi6uFGJNnljX0xRYckX31FdupC5DIh/UA9a/QMliVVqmeE8rgSzirjhnTrfXeFSB+Pff5+3v+hIg/TdN3Y53zkr0JWq0Xon2g1/YYUXRdkHj7C/+mCUtsnQ7TKJWiA17Dx2T1AbmNAjv1TpZ602RvTJDxDBHL1YsNq2s8Nr8Z/uysz7/jWzuK2EzQH4BvNYi7oEC/mMuzvth/RR3jS11LIAtc+DsI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydDP7GrY60UCLQYK1KpKZa6HhpwjDGUjOac7XrTZ9ag=;
 b=O7KRI8y9a1uDv1Rt9nWrpngV7Uk1zx+PM63w/NI0i4mAdnFnJi0Ik374SsK6zsaGjLmNV1hkAe6NuWO8vTIUNkCk33osSbjQc5iEYo6sj8LopmI64W72/92ivZ/aJ68I2dOR29OcUDJ8sr3fT918TCuRmHCTvFMuC9cqo3gChvqsDuTJX/OALjLCVbWDTr8xszKKnGKR69+kHUyrzOhWe1lbfUxyPoAZ+csxrdvpS088bZ1l0rVVbBTcCU9KSone3jfO62k9uqlrvH2as0Bz+4mZndEq2/5F7OsQOqwo6QtWLePvFvc2KlP9qYv3LupXbfYLt61hXlvP3sIcVzYzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydDP7GrY60UCLQYK1KpKZa6HhpwjDGUjOac7XrTZ9ag=;
 b=Nmy3hNPj4FTa3v+lgYFCCuVMIW1/b4SIWYq9f+rVGyU7HcUqVtdV8zT6H0LRGHnITigoAI6FTHCJeLRgSGnDT77SHjhtlmwCueBvBoQ9suNWCIC2xIsaZAP1a+Z3aHrRFSkfOBnn/WICIxAJxodFTpgLQ26W78uJ9pGs42xPKofsBVUExVXL5rRfF0Ix+ha4Cf4+DX99+ZAYtNRyyRFuhr7vTMBtnc3gOUONrfmNKmqGxZYdZ7k7kd/452BECQB8iHY6+QvRPpFFQTcV5IXLXqmINe4ggOZi5C4uW6Ap3nMYB/gCFCuYpv7ddBbiS6XR0xdZoMcTXdEx3KNB5khuPA==
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 19:56:22 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::fc) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 19:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 19:56:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 15 May 2023
 12:56:10 -0700
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 15 May
 2023 12:56:09 -0700
Message-ID: <607b6473-df6a-4645-381b-0a88c7f01bfa@nvidia.com>
Date:   Mon, 15 May 2023 12:56:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 6/6] mm/gup: remove vmas array from internal GUP
 functions
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <23f5b6e75ccf31565355cd37bf1253d20f2e6388.1684097002.git.lstoakes@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <23f5b6e75ccf31565355cd37bf1253d20f2e6388.1684097002.git.lstoakes@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cefd48-97ab-473a-9756-08db557e7538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWE0AJlhKp5bZ+Cd4f1YRAfgyRuqMIiqVoVGQYkH83gqIJH3BJniA5SYzAY85tDyBdYZpowEKNqcSIGL992luooAwvgp/Kkyn150oZhu/zL+aKE9xRaYoqS0PNtp8y6vO+/SG0wafhzOGdFtODULnxnTTZLHa5zwwl/eUKgFgHB/q/Y70BJ9+mhRQ3atUVEJDJRxR97B0zDjx/d0R6dFJzbz/dKSpzNlIffopYeLGonQNTPuPBH6zHINK0CXnQ0mCp5UpLNDCANY2ejMa8xQ7IUx4mPukS8tJsdKk17ZBlA8XTtHJHyJKjBHqFmnBiufO/NgJiAes2TYn7yKstRWshdzGxhAcsAvJhoEdSNBjBezMQKtjZYvFDqA4OArjRJgGk/lmexM8rMYJe3Kgpr12TDJwoISQ1MiO+FkwkK5qWO3s+lSmPTcU7ZrAUADyojMI5GhhWUWg2XxjP4trEJcKnYYrE+zrcDEg93gm9lgseIrEESfR8vHEYNH1DZyAlxrznJE48TlqtOFrnb/aDZJ+CA7Ql3sAzzoaGbDZjdKkxz6V5ChiLLP0XRDTT59RENlbS+g1GLxZxxqKyqGfJNHpNFRTpVhXNU1uVSj3Te1RyjjuxK8vICZjQs4FXAlEbHCtF7hC6eVpAep4AXRqeWBWE4/UTtA10EUVoAh5FovMCCiRYVquQKAM96w8HbUYlK7Iws07QXD4i+ur1OlxSL9DjfAYSw8czXss8fCcH9e2dULzding5kvR4KJpnWzRQzoeort/bJDJnF1pAzOyoRrNOF++TZW1pGcOU37ESZ9Gno=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(8936002)(41300700001)(70206006)(7636003)(40480700001)(70586007)(4326008)(316002)(356005)(82740400003)(16576012)(54906003)(110136005)(478600001)(40460700003)(36756003)(16526019)(186003)(82310400005)(2616005)(53546011)(30864003)(2906002)(26005)(83380400001)(47076005)(31696002)(31686004)(36860700001)(426003)(336012)(86362001)(7416002)(5660300002)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 19:56:22.2534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cefd48-97ab-473a-9756-08db557e7538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/23 14:27, Lorenzo Stoakes wrote:
> Now we have eliminated all callers to GUP APIs which use the vmas
> parameter, eliminate it altogether.
> 
> This eliminates a class of bugs where vmas might have been kept around
> longer than the mmap_lock and thus we need not be concerned about locks
> being dropped during this operation leaving behind dangling pointers.
> 
> This simplifies the GUP API and makes it considerably clearer as to its
> purpose - follow flags are applied and if pinning, an array of pages is
> returned.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   include/linux/hugetlb.h | 10 ++---
>   mm/gup.c                | 83 +++++++++++++++--------------------------
>   mm/hugetlb.c            | 24 +++++-------
>   3 files changed, 45 insertions(+), 72 deletions(-)


Very nice to see this historical baggage get removed!

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6d041aa9f0fe..b2b698f9a2ec 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -133,9 +133,8 @@ int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
>   struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   				unsigned long address, unsigned int flags);
>   long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
> -			 struct page **, struct vm_area_struct **,
> -			 unsigned long *, unsigned long *, long, unsigned int,
> -			 int *);
> +			 struct page **, unsigned long *, unsigned long *,
> +			 long, unsigned int, int *);
>   void unmap_hugepage_range(struct vm_area_struct *,
>   			  unsigned long, unsigned long, struct page *,
>   			  zap_flags_t);
> @@ -306,9 +305,8 @@ static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   
>   static inline long follow_hugetlb_page(struct mm_struct *mm,
>   			struct vm_area_struct *vma, struct page **pages,
> -			struct vm_area_struct **vmas, unsigned long *position,
> -			unsigned long *nr_pages, long i, unsigned int flags,
> -			int *nonblocking)
> +			unsigned long *position, unsigned long *nr_pages,
> +			long i, unsigned int flags, int *nonblocking)
>   {
>   	BUG();
>   	return 0;
> diff --git a/mm/gup.c b/mm/gup.c
> index 36701b5f0123..dbe96d266670 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1067,8 +1067,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>    * @pages:	array that receives pointers to the pages pinned.
>    *		Should be at least nr_pages long. Or NULL, if caller
>    *		only intends to ensure the pages are faulted in.
> - * @vmas:	array of pointers to vmas corresponding to each page.
> - *		Or NULL if the caller does not require them.
>    * @locked:     whether we're still with the mmap_lock held
>    *
>    * Returns either number of pages pinned (which may be less than the
> @@ -1082,8 +1080,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>    *
>    * The caller is responsible for releasing returned @pages, via put_page().
>    *
> - * @vmas are valid only as long as mmap_lock is held.
> - *
>    * Must be called with mmap_lock held.  It may be released.  See below.
>    *
>    * __get_user_pages walks a process's page tables and takes a reference to
> @@ -1119,7 +1115,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   static long __get_user_pages(struct mm_struct *mm,
>   		unsigned long start, unsigned long nr_pages,
>   		unsigned int gup_flags, struct page **pages,
> -		struct vm_area_struct **vmas, int *locked)
> +		int *locked)
>   {
>   	long ret = 0, i = 0;
>   	struct vm_area_struct *vma = NULL;
> @@ -1159,9 +1155,9 @@ static long __get_user_pages(struct mm_struct *mm,
>   				goto out;
>   
>   			if (is_vm_hugetlb_page(vma)) {
> -				i = follow_hugetlb_page(mm, vma, pages, vmas,
> -						&start, &nr_pages, i,
> -						gup_flags, locked);
> +				i = follow_hugetlb_page(mm, vma, pages,
> +							&start, &nr_pages, i,
> +							gup_flags, locked);
>   				if (!*locked) {
>   					/*
>   					 * We've got a VM_FAULT_RETRY
> @@ -1226,10 +1222,6 @@ static long __get_user_pages(struct mm_struct *mm,
>   			ctx.page_mask = 0;
>   		}
>   next_page:
> -		if (vmas) {
> -			vmas[i] = vma;
> -			ctx.page_mask = 0;
> -		}
>   		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
>   		if (page_increm > nr_pages)
>   			page_increm = nr_pages;
> @@ -1384,7 +1376,6 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   						unsigned long start,
>   						unsigned long nr_pages,
>   						struct page **pages,
> -						struct vm_area_struct **vmas,
>   						int *locked,
>   						unsigned int flags)
>   {
> @@ -1422,7 +1413,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   	pages_done = 0;
>   	for (;;) {
>   		ret = __get_user_pages(mm, start, nr_pages, flags, pages,
> -				       vmas, locked);
> +				       locked);
>   		if (!(flags & FOLL_UNLOCKABLE)) {
>   			/* VM_FAULT_RETRY couldn't trigger, bypass */
>   			pages_done = ret;
> @@ -1486,7 +1477,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   
>   		*locked = 1;
>   		ret = __get_user_pages(mm, start, 1, flags | FOLL_TRIED,
> -				       pages, NULL, locked);
> +				       pages, locked);
>   		if (!*locked) {
>   			/* Continue to retry until we succeeded */
>   			BUG_ON(ret != 0);
> @@ -1584,7 +1575,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
>   	 * not result in a stack expansion that recurses back here.
>   	 */
>   	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
> -				NULL, NULL, locked ? locked : &local_locked);
> +			       NULL, locked ? locked : &local_locked);
>   	lru_add_drain();
>   	return ret;
>   }
> @@ -1642,7 +1633,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
>   		return -EINVAL;
>   
>   	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
> -				NULL, NULL, locked);
> +			       NULL, locked);
>   	lru_add_drain();
>   	return ret;
>   }
> @@ -1710,8 +1701,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>   #else /* CONFIG_MMU */
>   static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
>   		unsigned long nr_pages, struct page **pages,
> -		struct vm_area_struct **vmas, int *locked,
> -		unsigned int foll_flags)
> +		int *locked, unsigned int foll_flags)
>   {
>   	struct vm_area_struct *vma;
>   	bool must_unlock = false;
> @@ -1755,8 +1745,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
>   			if (pages[i])
>   				get_page(pages[i]);
>   		}
> -		if (vmas)
> -			vmas[i] = vma;
> +
>   		start = (start + PAGE_SIZE) & PAGE_MASK;
>   	}
>   
> @@ -1937,8 +1926,7 @@ struct page *get_dump_page(unsigned long addr)
>   	int locked = 0;
>   	int ret;
>   
> -	ret = __get_user_pages_locked(current->mm, addr, 1, &page, NULL,
> -				      &locked,
> +	ret = __get_user_pages_locked(current->mm, addr, 1, &page, &locked,
>   				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>   	return (ret == 1) ? page : NULL;
>   }
> @@ -2111,7 +2099,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   				  unsigned long start,
>   				  unsigned long nr_pages,
>   				  struct page **pages,
> -				  struct vm_area_struct **vmas,
>   				  int *locked,
>   				  unsigned int gup_flags)
>   {
> @@ -2119,13 +2106,13 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   	long rc, nr_pinned_pages;
>   
>   	if (!(gup_flags & FOLL_LONGTERM))
> -		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> +		return __get_user_pages_locked(mm, start, nr_pages, pages,
>   					       locked, gup_flags);
>   
>   	flags = memalloc_pin_save();
>   	do {
>   		nr_pinned_pages = __get_user_pages_locked(mm, start, nr_pages,
> -							  pages, vmas, locked,
> +							  pages, locked,
>   							  gup_flags);
>   		if (nr_pinned_pages <= 0) {
>   			rc = nr_pinned_pages;
> @@ -2143,9 +2130,8 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>    * Check that the given flags are valid for the exported gup/pup interface, and
>    * update them with the required flags that the caller must have set.
>    */
> -static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
> -			      int *locked, unsigned int *gup_flags_p,
> -			      unsigned int to_set)
> +static bool is_valid_gup_args(struct page **pages, int *locked,
> +			      unsigned int *gup_flags_p, unsigned int to_set)
>   {
>   	unsigned int gup_flags = *gup_flags_p;
>   
> @@ -2187,13 +2173,6 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
>   			 (gup_flags & FOLL_PCI_P2PDMA)))
>   		return false;
>   
> -	/*
> -	 * Can't use VMAs with locked, as locked allows GUP to unlock
> -	 * which invalidates the vmas array
> -	 */
> -	if (WARN_ON_ONCE(vmas && (gup_flags & FOLL_UNLOCKABLE)))
> -		return false;
> -
>   	*gup_flags_p = gup_flags;
>   	return true;
>   }
> @@ -2262,11 +2241,11 @@ long get_user_pages_remote(struct mm_struct *mm,
>   {
>   	int local_locked = 1;
>   
> -	if (!is_valid_gup_args(pages, NULL, locked, &gup_flags,
> +	if (!is_valid_gup_args(pages, locked, &gup_flags,
>   			       FOLL_TOUCH | FOLL_REMOTE))
>   		return -EINVAL;
>   
> -	return __get_user_pages_locked(mm, start, nr_pages, pages, NULL,
> +	return __get_user_pages_locked(mm, start, nr_pages, pages,
>   				       locked ? locked : &local_locked,
>   				       gup_flags);
>   }
> @@ -2301,11 +2280,11 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>   {
>   	int locked = 1;
>   
> -	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_TOUCH))
> +	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_TOUCH))
>   		return -EINVAL;
>   
>   	return __get_user_pages_locked(current->mm, start, nr_pages, pages,
> -				       NULL, &locked, gup_flags);
> +				       &locked, gup_flags);
>   }
>   EXPORT_SYMBOL(get_user_pages);
>   
> @@ -2329,12 +2308,12 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>   {
>   	int locked = 0;
>   
> -	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
> +	if (!is_valid_gup_args(pages, NULL, &gup_flags,
>   			       FOLL_TOUCH | FOLL_UNLOCKABLE))
>   		return -EINVAL;
>   
>   	return __get_user_pages_locked(current->mm, start, nr_pages, pages,
> -				       NULL, &locked, gup_flags);
> +				       &locked, gup_flags);
>   }
>   EXPORT_SYMBOL(get_user_pages_unlocked);
>   
> @@ -3124,7 +3103,7 @@ static int internal_get_user_pages_fast(unsigned long start,
>   	start += nr_pinned << PAGE_SHIFT;
>   	pages += nr_pinned;
>   	ret = __gup_longterm_locked(current->mm, start, nr_pages - nr_pinned,
> -				    pages, NULL, &locked,
> +				    pages, &locked,
>   				    gup_flags | FOLL_TOUCH | FOLL_UNLOCKABLE);
>   	if (ret < 0) {
>   		/*
> @@ -3166,7 +3145,7 @@ int get_user_pages_fast_only(unsigned long start, int nr_pages,
>   	 * FOLL_FAST_ONLY is required in order to match the API description of
>   	 * this routine: no fall back to regular ("slow") GUP.
>   	 */
> -	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
> +	if (!is_valid_gup_args(pages, NULL, &gup_flags,
>   			       FOLL_GET | FOLL_FAST_ONLY))
>   		return -EINVAL;
>   
> @@ -3199,7 +3178,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>   	 * FOLL_GET, because gup fast is always a "pin with a +1 page refcount"
>   	 * request.
>   	 */
> -	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_GET))
> +	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_GET))
>   		return -EINVAL;
>   	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>   }
> @@ -3224,7 +3203,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>   int pin_user_pages_fast(unsigned long start, int nr_pages,
>   			unsigned int gup_flags, struct page **pages)
>   {
> -	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_PIN))
> +	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_PIN))
>   		return -EINVAL;
>   	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>   }
> @@ -3257,10 +3236,10 @@ long pin_user_pages_remote(struct mm_struct *mm,
>   {
>   	int local_locked = 1;
>   
> -	if (!is_valid_gup_args(pages, NULL, locked, &gup_flags,
> +	if (!is_valid_gup_args(pages, locked, &gup_flags,
>   			       FOLL_PIN | FOLL_TOUCH | FOLL_REMOTE))
>   		return 0;
> -	return __gup_longterm_locked(mm, start, nr_pages, pages, NULL,
> +	return __gup_longterm_locked(mm, start, nr_pages, pages,
>   				     locked ? locked : &local_locked,
>   				     gup_flags);
>   }
> @@ -3286,10 +3265,10 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>   {
>   	int locked = 1;
>   
> -	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_PIN))
> +	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_PIN))
>   		return 0;
>   	return __gup_longterm_locked(current->mm, start, nr_pages,
> -				     pages, NULL, &locked, gup_flags);
> +				     pages, &locked, gup_flags);
>   }
>   EXPORT_SYMBOL(pin_user_pages);
>   
> @@ -3303,11 +3282,11 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>   {
>   	int locked = 0;
>   
> -	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
> +	if (!is_valid_gup_args(pages, NULL, &gup_flags,
>   			       FOLL_PIN | FOLL_TOUCH | FOLL_UNLOCKABLE))
>   		return 0;
>   
> -	return __gup_longterm_locked(current->mm, start, nr_pages, pages, NULL,
> +	return __gup_longterm_locked(current->mm, start, nr_pages, pages,
>   				     &locked, gup_flags);
>   }
>   EXPORT_SYMBOL(pin_user_pages_unlocked);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f154019e6b84..ea24718db4af 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6425,17 +6425,14 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   }
>   #endif /* CONFIG_USERFAULTFD */
>   
> -static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
> -				 int refs, struct page **pages,
> -				 struct vm_area_struct **vmas)
> +static void record_subpages(struct page *page, struct vm_area_struct *vma,
> +			    int refs, struct page **pages)
>   {
>   	int nr;
>   
>   	for (nr = 0; nr < refs; nr++) {
>   		if (likely(pages))
>   			pages[nr] = nth_page(page, nr);
> -		if (vmas)
> -			vmas[nr] = vma;
>   	}
>   }
>   
> @@ -6508,9 +6505,9 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   }
>   
>   long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> -			 struct page **pages, struct vm_area_struct **vmas,
> -			 unsigned long *position, unsigned long *nr_pages,
> -			 long i, unsigned int flags, int *locked)
> +			 struct page **pages, unsigned long *position,
> +			 unsigned long *nr_pages, long i, unsigned int flags,
> +			 int *locked)
>   {
>   	unsigned long pfn_offset;
>   	unsigned long vaddr = *position;
> @@ -6638,7 +6635,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		 * If subpage information not requested, update counters
>   		 * and skip the same_page loop below.
>   		 */
> -		if (!pages && !vmas && !pfn_offset &&
> +		if (!pages && !pfn_offset &&
>   		    (vaddr + huge_page_size(h) < vma->vm_end) &&
>   		    (remainder >= pages_per_huge_page(h))) {
>   			vaddr += huge_page_size(h);
> @@ -6653,11 +6650,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
>   		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
>   
> -		if (pages || vmas)
> -			record_subpages_vmas(nth_page(page, pfn_offset),
> -					     vma, refs,
> -					     likely(pages) ? pages + i : NULL,
> -					     vmas ? vmas + i : NULL);
> +		if (pages)
> +			record_subpages(nth_page(page, pfn_offset),
> +					vma, refs,
> +					likely(pages) ? pages + i : NULL);
>   
>   		if (pages) {
>   			/*


