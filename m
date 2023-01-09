Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50E4662973
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjAIPLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjAIPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:10:08 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6660FF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:10:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g16so9790345plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GRinWJsxJl/skcgIMCLJe5rdFGGVY8TCvHbbHWDrFaU=;
        b=QeLKpZ5GXsbi3ey1hQkO0j5oa1aRM+E6KDBcnQlgx5y/Uxz93Mao+8U2wx4AYDgSA1
         HdNJLgCOuYSwYwSDF+nWFab87G2LmyPJxTcRGn+jIQRJTsI2MZm8E1dMFNdfTrEGH0DK
         OJ5G1y6+/UJYRURfM7EG6kpu6GhAhXu/ny6h72/90UqZNqO1OpIx7VSIIREppRw9+6p+
         DOaIoZ3Q6OQA639Md+UniEw3GsL9sLn/aH/7K5xxlkAqnpH2qi4iGzWKHSnpENmcAg8K
         gzQm0N02W5aMHCke80P91XeVi4lKYFnNQbPFoiu5bSmdarTNf3sVA27Oojbw3QQMYvrB
         b9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRinWJsxJl/skcgIMCLJe5rdFGGVY8TCvHbbHWDrFaU=;
        b=LtXQv1QlCI3f+WpizuoYZAuE0RPXzTDIg7hUKATHcKZTwOdXwIehtfLwjr/6ADwzzI
         eDZoOVJDksoyYDnYSwbQ//1FYISN+9zT4wswr3MKA+TTWV8FSXyx89CFyfR7ACebeitk
         LiI1293UHPvC5DJOC4hBdVSL0x55oWAth7nlVY3NVLgqA0E4oyiM2LZ8jZKuix5S8WIv
         1nr5r2PIPhGwN6HcNPNnmZhouzg0c/FDJL54To52WXFmF5uDjSVocw9R0+Iu9gOcJBP+
         5HTuf4yqTPOFJTNn/v6Cl/XtE9ns4vr5HsTG6FfqUVQAsKQt/ihIGo4O3E2zxsx3WIKV
         ePsQ==
X-Gm-Message-State: AFqh2krfPHn+RlIrDToCNzWfksP/wx+Z+Iy6Gx9TyYd7tWIprxu0l2ob
        fXkfYjadGG6TXePu1hE1fmxMurSxmk4=
X-Google-Smtp-Source: AMrXdXt5y68ucDeNhPFby1rRZBSpJlgjG0ajzCX8wt3nc6tkFKvP/UF1Yxix64c3vAuiTOZQMA/PMA==
X-Received: by 2002:a05:6a20:6daf:b0:b5:d872:1679 with SMTP id gl47-20020a056a206daf00b000b5d8721679mr3309615pzb.59.1673277005217;
        Mon, 09 Jan 2023 07:10:05 -0800 (PST)
Received: from vernon-pc ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id j22-20020a63cf16000000b0047899d0d62csm5300126pgg.52.2023.01.09.07.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:10:04 -0800 (PST)
Date:   Mon, 9 Jan 2023 23:10:00 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 06/44] mm/mmap: convert brk to use vma iterator
Message-ID: <Y7wsE3wiD2FBJoaz@vernon-pc>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
 <20230105191517.3099082-7-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105191517.3099082-7-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liam,

On Thu, Jan 05, 2023 at 07:15:54PM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Use the vma iterator API for the brk() system call.  This will provide
> type safety at compile time.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9318f2ac8a6e..4a6f42ab3560 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -239,10 +239,10 @@ static int check_brk_limits(unsigned long addr, unsigned long len)
>
>  	return mlock_future_check(current->mm, current->mm->def_flags, len);
>  }
> -static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
> +static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  			 unsigned long newbrk, unsigned long oldbrk,
>  			 struct list_head *uf);
> -static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvma,
> +static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
>  		unsigned long addr, unsigned long request, unsigned long flags);
>  SYSCALL_DEFINE1(brk, unsigned long, brk)
>  {
> @@ -253,7 +253,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  	bool populate;
>  	bool downgraded = false;
>  	LIST_HEAD(uf);
> -	MA_STATE(mas, &mm->mm_mt, 0, 0);
> +	struct vma_iterator vmi;
>
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
> @@ -301,8 +301,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  		int ret;
>
>  		/* Search one past newbrk */
> -		mas_set(&mas, newbrk);
> -		brkvma = mas_find(&mas, oldbrk);
> +		vma_iter_init(&vmi, mm, newbrk);
> +		brkvma = vma_find(&vmi, oldbrk);
>  		if (!brkvma || brkvma->vm_start >= oldbrk)
>  			goto out; /* mapping intersects with an existing non-brk vma. */
>  		/*
> @@ -311,7 +311,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  		 * before calling do_brk_munmap().
>  		 */
>  		mm->brk = brk;
> -		ret = do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
> +		ret = do_brk_munmap(&vmi, brkvma, newbrk, oldbrk, &uf);
>  		if (ret == 1)  {
>  			downgraded = true;
>  			goto success;
> @@ -329,14 +329,14 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  	 * Only check if the next VMA is within the stack_guard_gap of the
>  	 * expansion area
>  	 */
> -	mas_set(&mas, oldbrk);
> -	next = mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
> +	vma_iter_init(&vmi, mm, oldbrk);
> +	next = vma_find(&vmi, newbrk + PAGE_SIZE + stack_guard_gap);
>  	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
>  		goto out;
>
> -	brkvma = mas_prev(&mas, mm->start_brk);
> +	brkvma = vma_prev_limit(&vmi, mm->start_brk);
>  	/* Ok, looks good - let it rip. */
> -	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
> +	if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
>  		goto out;
>
>  	mm->brk = brk;
> @@ -2963,7 +2963,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>
>  /*
>   * brk_munmap() - Unmap a parital vma.
> - * @mas: The maple tree state.
> + * @vmi: The vma iterator
>   * @vma: The vma to be modified
>   * @newbrk: the start of the address to unmap
>   * @oldbrk: The end of the address to unmap
> @@ -2973,7 +2973,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>   * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lock if
>   * possible.
>   */
> -static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
> +static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  			 unsigned long newbrk, unsigned long oldbrk,
>  			 struct list_head *uf)
>  {
> @@ -2981,14 +2981,14 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  	int ret;
>
>  	arch_unmap(mm, newbrk, oldbrk);
> -	ret = do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
> +	ret = do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true);
>  	validate_mm_mt(mm);
>  	return ret;
>  }
>
>  /*
>   * do_brk_flags() - Increase the brk vma if the flags match.
> - * @mas: The maple tree state.
> + * @vmi: The vma iterator
>   * @addr: The start address
>   * @len: The length of the increase
>   * @vma: The vma,
> @@ -2998,7 +2998,7 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>   * do not match then create a new anonymous VMA.  Eventually we may be able to
>   * do some brk-specific accounting here.
>   */
> -static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
> +static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long addr, unsigned long len, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -3025,8 +3025,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
>  	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
>  	    can_vma_merge_after(vma, flags, NULL, NULL,
>  				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> -		mas_set_range(mas, vma->vm_start, addr + len - 1);

Why was mas_set_range() removed here, but below [1] it’s left?

> -		if (mas_preallocate(mas, vma, GFP_KERNEL))
> +		if (vma_iter_prealloc(vmi, vma))
>  			goto unacct_fail;
>
>  		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> @@ -3036,7 +3035,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
>  		}
>  		vma->vm_end = addr + len;
>  		vma->vm_flags |= VM_SOFTDIRTY;
> -		mas_store_prealloc(mas, vma);
> +		vma_iter_store(vmi, vma);
>
>  		if (vma->anon_vma) {
>  			anon_vma_interval_tree_post_update_vma(vma);
> @@ -3057,8 +3056,8 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
>  	vma->vm_pgoff = addr >> PAGE_SHIFT;
>  	vma->vm_flags = flags;
>  	vma->vm_page_prot = vm_get_page_prot(flags);
> -	mas_set_range(mas, vma->vm_start, addr + len - 1);
> -	if (mas_store_gfp(mas, vma, GFP_KERNEL))
> +	mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);

[1]. the mas_set_range() here has been reserved.

> +	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
>  		goto mas_store_fail;
>
>  	mm->map_count++;
> @@ -3087,7 +3086,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>  	int ret;
>  	bool populate;
>  	LIST_HEAD(uf);
> -	MA_STATE(mas, &mm->mm_mt, addr, addr);
> +	VMA_ITERATOR(vmi, mm, addr);
>
>  	len = PAGE_ALIGN(request);
>  	if (len < request)
> @@ -3106,12 +3105,12 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>  	if (ret)
>  		goto limits_failed;
>
> -	ret = do_mas_munmap(&mas, mm, addr, len, &uf, 0);
> +	ret = do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
>  	if (ret)
>  		goto munmap_failed;
>
> -	vma = mas_prev(&mas, 0);
> -	ret = do_brk_flags(&mas, vma, addr, len, flags);
> +	vma = vma_prev(&vmi);
> +	ret = do_brk_flags(&vmi, vma, addr, len, flags);
>  	populate = ((mm->def_flags & VM_LOCKED) != 0);
>  	mmap_write_unlock(mm);
>  	userfaultfd_unmap_complete(mm, &uf);
> --
> 2.35.1
>
