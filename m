Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C035F826C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 04:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJHC3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 22:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJHC3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:29:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A41789B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:29:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mkptb2y32zVhvG;
        Sat,  8 Oct 2022 10:25:27 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 10:29:46 +0800
Subject: Re: [PATCH v2 8/9] hugetlb: use new vma_lock for pmd sharing
 synchronization
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
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
 <20220914221810.95771-9-mike.kravetz@oracle.com>
 <01f10195-7088-4462-6def-909549c75ef4@huawei.com> <YzeDLCFMN6XZNfoF@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <162f73d7-5bcb-e0f9-bdaf-7a5d4df10fba@huawei.com>
Date:   Sat, 8 Oct 2022 10:29:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YzeDLCFMN6XZNfoF@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/1 8:00, Mike Kravetz wrote:
> On 09/29/22 14:08, Miaohe Lin wrote:
>> On 2022/9/15 6:18, Mike Kravetz wrote:
>>> @@ -434,6 +434,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>>>  					struct folio *folio, pgoff_t index)
>>>  {
>>>  	struct rb_root_cached *root = &mapping->i_mmap;
>>> +	struct hugetlb_vma_lock *vma_lock;
>>>  	struct page *page = &folio->page;
>>>  	struct vm_area_struct *vma;
>>>  	unsigned long v_start;
>>> @@ -444,7 +445,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>>>  	end = (index + 1) * pages_per_huge_page(h);
>>>  
>>>  	i_mmap_lock_write(mapping);
>>> -
>>> +retry:
>>> +	vma_lock = NULL;
>>>  	vma_interval_tree_foreach(vma, root, start, end - 1) {
>>>  		v_start = vma_offset_start(vma, start);
>>>  		v_end = vma_offset_end(vma, end);
>>> @@ -452,11 +454,63 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>>>  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
>>>  			continue;
>>>  
>>> +		if (!hugetlb_vma_trylock_write(vma)) {
>>> +			vma_lock = vma->vm_private_data;
>>> +			/*
>>> +			 * If we can not get vma lock, we need to drop
>>> +			 * immap_sema and take locks in order.  First,
>>> +			 * take a ref on the vma_lock structure so that
>>> +			 * we can be guaranteed it will not go away when
>>> +			 * dropping immap_sema.
>>> +			 */
>>> +			kref_get(&vma_lock->refs);
>>> +			break;
>>> +		}
>>> +
>>>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>>>  				NULL, ZAP_FLAG_DROP_MARKER);
>>> +		hugetlb_vma_unlock_write(vma);
>>>  	}
>>>  
>>>  	i_mmap_unlock_write(mapping);
>>> +
>>> +	if (vma_lock) {
>>> +		/*
>>> +		 * Wait on vma_lock.  We know it is still valid as we have
>>> +		 * a reference.  We must 'open code' vma locking as we do
>>> +		 * not know if vma_lock is still attached to vma.
>>> +		 */
>>> +		down_write(&vma_lock->rw_sema);
>>> +		i_mmap_lock_write(mapping);
>>> +
>>> +		vma = vma_lock->vma;
>>> +		if (!vma) {
>>
>> Thanks Mike. This method looks much simpler. But IIUC, this code can race with exit_mmap:
>>
>> CPU 1					CPU 2
>> hugetlb_unmap_file_folio		exit_mmap
>>   kref_get(&vma_lock->refs);
>>   down_write(&vma_lock->rw_sema);
>> 					  free_pgtables // i_mmap_lock_write is held inside it.
>>   i_mmap_lock_write(mapping);
>>   vma = vma_lock->vma;
>> 					  remove_vma
>> 					    hugetlb_vm_op_close
>> 					      hugetlb_vma_lock_free
>> 					        vma_lock->vma = NULL;
>> 					    vm_area_free(vma);
>>   vma is used-after-free??
>>
>> The root casue is free_pgtables is protected with i_mmap_lock_write while remove_vma is not.
>> Or am I miss something again? ;)
> 
> Thank you Miaohe!  Sorry for the delay in responding.
> 
> Yes, I agree this is a possible race.  My first thought is that we may be
> able to address this by simply taking the vma_lock when we clear the
> vma_lock->vma field.  Something like this,
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4cb44a4629b8..bf0c220ebc32 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6918,7 +6918,9 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>  		 * certainly will no longer be attached to vma so clear
>  		 * pointer.
>  		 */
> +		down_write(&vma_lock->rw_sema);
>  		vma_lock->vma = NULL;
> +		up_write(&vma_lock->rw_sema);
>  		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
>  		vma->vm_private_data = NULL;
>  	}

AFAICT, this should work. And we won't hold the vma_lock->rw_sema when delete vma, there
should not be a possible deadlock.

> 
> I still need to do a bit more work to verify.
> 
> Andrew, if you are concerned I do not think this is a show stopper.  The
> race should be extremely rare, and a fix should be coming quickly.

Agree, this should be really rare.

> 
> <snip>
>>> +	mapping = vma->vm_file->f_mapping;
>>> +	idx = vma_hugecache_offset(h, vma, haddr);
>>>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>>>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>>>  
>>> +	/*
>>> +	 * Acquire vma lock before calling huge_pte_alloc and hold
>>> +	 * until finished with ptep.  This prevents huge_pmd_unshare from
>>> +	 * being called elsewhere and making the ptep no longer valid.
>>> +	 *
>>> +	 * ptep could have already be assigned via huge_pte_offset.  That
>>> +	 * is OK, as huge_pte_alloc will return the same value unless
>>> +	 * something has changed.
>>> +	 */
>>> +	hugetlb_vma_lock_read(vma);
>>
>> [1] says vma_lock for each vma mapping the file provides the same type of synchronization
>> around i_size as provided by the fault mutex. But what if vma->vm_private_data is NULL,
>> i.e. hugetlb_vma_lock_alloc fails to alloc vma_lock? There won't be such synchronization
>> in this case.
>>
>> [1] https://lore.kernel.org/lkml/Yxiv0SkMkZ0JWGGp@monkey/#t
>>
> 
> Right.
> 
> Of course, this (checking i_size) only applies to shared/file mappings.
> The only time hugetlb_vma_lock_alloc should fail in such cases is when
> we can not allocate the small vma_lock structure.  Since the vma_lock
> is primarily for huge pmd sharing synchronization, my thought was that
> allocation errors would just prevent sharing.  But, as you point out
> it could also impact these checks.
> 
> It would be easy to check for the lock allocation failure at mmap time
> and fail the mmap.  It would be a little more tricky at fork time.
> 
> This also is something that is highly unlikely to occur.  And, if we
> can't allocate a vma_lock I suspect we will not be up and running long
> enough for this to be an issue. :) Let me think about the best way to handle.

Agree. This should be really rare too. Thanks for your work.

Thanks,
Miaohe Lin

> 
>>
>> Other parts of the patch look good to me. Thanks for your work.
>>
> 
> Thanks again,
> 

