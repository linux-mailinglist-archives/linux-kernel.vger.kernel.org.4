Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CACD602458
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiJRGZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJRGZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:25:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE092F54
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:25:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ms3gC1T7dzpVgf;
        Tue, 18 Oct 2022 14:22:15 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:25:31 +0800
Subject: Re: [PATCH 1/3] hugetlb: fix vma lock handling during split vma and
 range unmapping
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
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
References: <20221005011707.514612-1-mike.kravetz@oracle.com>
 <20221005011707.514612-2-mike.kravetz@oracle.com>
 <5154292a-4c55-28cd-0935-82441e512fc3@huawei.com> <Y04VxvTbJTlxWfwl@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e62238e3-352f-2fef-d09e-1e2469c9fc95@huawei.com>
Date:   Tue, 18 Oct 2022 14:25:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y04VxvTbJTlxWfwl@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 10:56, Mike Kravetz wrote:
> On 10/15/22 09:25, Miaohe Lin wrote:
>> Sorry for late respond. It's a really busy week. :)
>>
>> On 2022/10/5 9:17, Mike Kravetz wrote:
>>> The hugetlb vma lock hangs off the vm_private_data field and is specific
>>> to the vma.  When vm_area_dup() is called as part of vma splitting,  the
>>
>> Oh, I checked vm_area_dup() from callsite of copy_vma and dup_mmap but split_vma
>> is missed... And yes, vma splitting can occur but vma merging won't for hugetlb
>> vma. Thanks for catching this, Mike.
>>
>>> vma lock pointer is copied to the new vma.  This will result in issues
>>> such as double freeing of the structure.  Update the hugetlb open vm_ops
>>> to allocate a new vma lock for the new vma.
>>>
>>> The routine __unmap_hugepage_range_final unconditionally unset
>>> VM_MAYSHARE to prevent subsequent pmd sharing.  hugetlb_vma_lock_free
>>> attempted to anticipate this by checking both VM_MAYSHARE and VM_SHARED.
>>> However, if only VM_MAYSHARE was set we would miss the free.  With the
>>> introduction of the vma lock, a vma can not participate in pmd sharing
>>> if vm_private_data is NULL.  Instead of clearing VM_MAYSHARE in
>>> __unmap_hugepage_range_final, free the vma lock to prevent sharing.  Also,
>>> update the sharing code to make sure vma lock is indeed a condition for
>>> pmd sharing.  hugetlb_vma_lock_free can then key off VM_MAYSHARE and not
>>> miss any vmas.
>>>
>>> Fixes: "hugetlb: add vma based lock for pmd sharing"
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  mm/hugetlb.c | 43 +++++++++++++++++++++++++++----------------
>>>  mm/memory.c  |  4 ----
>>>  2 files changed, 27 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 4443e87e814b..0129d371800c 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4612,7 +4612,14 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
>>>  		kref_get(&resv->refs);
>>>  	}
>>>  
>>> -	hugetlb_vma_lock_alloc(vma);
>>> +	/*
>>> +	 * vma_lock structure for sharable mappings is vma specific.
>>> +	 * Clear old pointer (if copied via vm_area_dup) and create new.
>>> +	 */
>>> +	if (vma->vm_flags & VM_MAYSHARE) {
>>> +		vma->vm_private_data = NULL;
>>> +		hugetlb_vma_lock_alloc(vma);
>>> +	}
>>
>> IMHO this would lead to memoryleak. Think about the below move_vma() flow:
>> move_vma
>>   copy_vma
>>     new_vma = vm_area_dup(vma);
>>     new_vma->vm_ops->open(new_vma); --> new_vma has its own vma lock.
>>   is_vm_hugetlb_page(vma)
>>     clear_vma_resv_huge_pages
>>       hugetlb_dup_vma_private --> vma->vm_private_data is set to NULL
>>       				  without put ref. So vma lock is *leaked*?
> 
> You are right, that could lead to a leak.
> 
> I have an idea about setting vma->vm_private_data to NULL for VM_MAYSHARE
> vmas in routines like hugetlb_dup_vma_private().  We can check
> hugetlb_vma_lock->vma and only set to NULL if,
> 
> 	vma->(hugetlb_vma_lock)vma->vm_private_data->vma != vma

Looks feasible. Thanks for your work, Mike.

Thanks,
Miaohe Lin

> 
> Got sidetracked chasing down another leak today.  Will send a patch
> implementing this idea soon.
> 
> Thanks for looking at this!
> 

