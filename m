Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884935E8C9F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiIXMhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiIXMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:36:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D89F1D70
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:36:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZT1l1V82zlWlj;
        Sat, 24 Sep 2022 20:32:43 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 20:36:53 +0800
Subject: Re: [PATCH v2 4/9] hugetlb: create remove_inode_single_folio to
 remove single file folio
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
 <20220914221810.95771-5-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a621e742-99de-bab1-9116-f2784f21ccd3@huawei.com>
Date:   Sat, 24 Sep 2022 20:36:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220914221810.95771-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/15 6:18, Mike Kravetz wrote:
> Create the new routine remove_inode_single_folio that will remove a
> single folio from a file.  This is refactored code from
> remove_inode_hugepages.  It checks for the uncommon case in which the
> folio is still mapped and unmaps.
> 
> No functional change.  This refactoring will be put to use and expanded
> upon in a subsequent patches.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM with one nit below.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  fs/hugetlbfs/inode.c | 105 ++++++++++++++++++++++++++-----------------
>  1 file changed, 63 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index edd69cc43ca5..7112a9a9f54d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -411,6 +411,60 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  	}
>  }
>  
> +/*
> + * Called with hugetlb fault mutex held.
> + * Returns true if page was actually removed, false otherwise.
> + */
> +static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
> +					struct address_space *mapping,
> +					struct folio *folio, pgoff_t index,
> +					bool truncate_op)
> +{
> +	bool ret = false;
> +
> +	/*
> +	 * If folio is mapped, it was faulted in after being
> +	 * unmapped in caller.  Unmap (again) while holding
> +	 * the fault mutex.  The mutex will prevent faults
> +	 * until we finish removing the folio.
> +	 */
> +	if (unlikely(folio_mapped(folio))) {
> +		i_mmap_lock_write(mapping);
> +		hugetlb_vmdelete_list(&mapping->i_mmap,
> +			index * pages_per_huge_page(h),
> +			(index + 1) * pages_per_huge_page(h),
> +			ZAP_FLAG_DROP_MARKER);
> +		i_mmap_unlock_write(mapping);
> +	}
> +
> +	folio_lock(folio);
> +	/*
> +	 * After locking page, make sure mapping is the same.
> +	 * We could have raced with page fault populate and
> +	 * backout code.

Is this needed? remove_inode_single_folio() is called with hugetlb fault mutex held so it can't
race with page fault code?

Thanks,
Miaohe Lin


