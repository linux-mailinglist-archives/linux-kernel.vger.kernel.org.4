Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442274F13A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjGKOJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjGKOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:09:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 017BABC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:08:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 067EF1FB;
        Tue, 11 Jul 2023 07:09:41 -0700 (PDT)
Received: from [10.1.37.54] (C02Z41KALVDN.cambridge.arm.com [10.1.37.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1924A3F740;
        Tue, 11 Jul 2023 07:08:57 -0700 (PDT)
Message-ID: <50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com>
Date:   Tue, 11 Jul 2023 15:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 18/49] mlock: Convert mlock to vma iterator
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
 <20230120162650.984577-19-Liam.Howlett@oracle.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230120162650.984577-19-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 16:26, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the vma iterator so that the iterator can be invalidated or updated
> to avoid each caller doing so.

Hi,

I've bisected 2 mm selftest regressions back to this patch, so hoping someone can help debug and fix? The failures are reproducible on x86_64 and arm64.


mlock-random-test:

$ ./run_kselftest.sh -t mm:mlock-random-test
TAP version 13
1..1
# selftests: mm: mlock-random-test
mlock() failure at |0xaaaaaaab52d0(131072)| mlock:|0xaaaaaaacc65d(26551)|
not ok 1 selftests: mm: mlock-random-test # exit=255

This mallocs a buffer then loops 100 times, trying to mlock random parts of it. After this patch, the test fails after a variable number of iterations; mlock() returns ENOMEM. If I explicitly munlock at the end of each loop, it works.


mlock2-tests:

$ ./run_kselftest.sh -t mm:mlock2-tests
TAP version 13
1..1
# selftests: mm: mlock2-tests
munlock(): Cannot allocate memory
munlock(): Cannot allocate memory
not ok 1 selftests: mm: mlock2-tests # exit=2

Here, a 3 page buffer is mlock2()ed, then the middle page is munlocked. Finally the whole 3 page range is munlocked, and after this patch it fails with ENOMEM. If I modify the test to split the final munlock into 2, one for the first page and one for the last, the test passes.


Immediately prior to this patch (2286a6914c77 "mm: change mprotect_fixup to vma iterator"), both tests pass.

From a quick scan of the man page, I don't think it explicitly says that its ok to call mlock/munlock on already locked/unlocked pages, but it's certainly a change of behavior and the tests notice, so I'm guessing this wasn't intentional?

I'm not familiar with this code so it's not obvious to me exactly what the problem is, but I'm hoping someone can help debug?

Thanks,
Ryan



> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mlock.c | 57 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index b680f11879c3..0d09b9070071 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -401,8 +401,9 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>   *
>   * For vmas that pass the filters, merge/split as appropriate.
>   */
> -static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
> -	unsigned long start, unsigned long end, vm_flags_t newflags)
> +static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +	       struct vm_area_struct **prev, unsigned long start,
> +	       unsigned long end, vm_flags_t newflags)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	pgoff_t pgoff;
> @@ -417,22 +418,22 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		goto out;
>  
>  	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
> -			  vma->vm_file, pgoff, vma_policy(vma),
> -			  vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	*prev = vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
> +			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> +			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  	if (*prev) {
>  		vma = *prev;
>  		goto success;
>  	}
>  
>  	if (start != vma->vm_start) {
> -		ret = split_vma(mm, vma, start, 1);
> +		ret = vmi_split_vma(vmi, mm, vma, start, 1);
>  		if (ret)
>  			goto out;
>  	}
>  
>  	if (end != vma->vm_end) {
> -		ret = split_vma(mm, vma, end, 0);
> +		ret = vmi_split_vma(vmi, mm, vma, end, 0);
>  		if (ret)
>  			goto out;
>  	}
> @@ -471,7 +472,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  	unsigned long nstart, end, tmp;
>  	struct vm_area_struct *vma, *prev;
>  	int error;
> -	MA_STATE(mas, &current->mm->mm_mt, start, start);
> +	VMA_ITERATOR(vmi, current->mm, start);
>  
>  	VM_BUG_ON(offset_in_page(start));
>  	VM_BUG_ON(len != PAGE_ALIGN(len));
> @@ -480,39 +481,37 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  		return -EINVAL;
>  	if (end == start)
>  		return 0;
> -	vma = mas_walk(&mas);
> +	vma = vma_iter_load(&vmi);
>  	if (!vma)
>  		return -ENOMEM;
>  
> +	prev = vma_prev(&vmi);
>  	if (start > vma->vm_start)
>  		prev = vma;
> -	else
> -		prev = mas_prev(&mas, 0);
>  
> -	for (nstart = start ; ; ) {
> -		vm_flags_t newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
> +	nstart = start;
> +	tmp = vma->vm_start;
> +	for_each_vma_range(vmi, vma, end) {
> +		vm_flags_t newflags;
>  
> -		newflags |= flags;
> +		if (vma->vm_start != tmp)
> +			return -ENOMEM;
>  
> +		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
> +		newflags |= flags;
>  		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
>  		tmp = vma->vm_end;
>  		if (tmp > end)
>  			tmp = end;
> -		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
> +		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
>  		if (error)
>  			break;
>  		nstart = tmp;
> -		if (nstart < prev->vm_end)
> -			nstart = prev->vm_end;
> -		if (nstart >= end)
> -			break;
> -
> -		vma = find_vma(prev->vm_mm, prev->vm_end);
> -		if (!vma || vma->vm_start != nstart) {
> -			error = -ENOMEM;
> -			break;
> -		}
>  	}
> +
> +	if (vma_iter_end(&vmi) < end)
> +		return -ENOMEM;
> +
>  	return error;
>  }
>  
> @@ -658,7 +657,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
>   */
>  static int apply_mlockall_flags(int flags)
>  {
> -	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
> +	VMA_ITERATOR(vmi, current->mm, 0);
>  	struct vm_area_struct *vma, *prev = NULL;
>  	vm_flags_t to_add = 0;
>  
> @@ -679,15 +678,15 @@ static int apply_mlockall_flags(int flags)
>  			to_add |= VM_LOCKONFAULT;
>  	}
>  
> -	mas_for_each(&mas, vma, ULONG_MAX) {
> +	for_each_vma(vmi, vma) {
>  		vm_flags_t newflags;
>  
>  		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
>  		newflags |= to_add;
>  
>  		/* Ignore errors */
> -		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
> -		mas_pause(&mas);
> +		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
> +			    newflags);
>  		cond_resched();
>  	}
>  out:

