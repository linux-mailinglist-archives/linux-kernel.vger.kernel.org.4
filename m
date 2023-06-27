Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86485740021
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjF0PzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjF0PzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7AA19A4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687881269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blfaz25JTx0Gq1i5rQOIktQT2cQ83yiOEY0rptX8I8M=;
        b=cq0ytByFsBVljszirNtFNbWecwqTsnoUAcZcjUpjm0bcwNTs7Q25Sy0I2m++qWL+P0I8JJ
        OdmqPaiL3919H9aDdXy532ByT3bAVSuxJ0NQWn5SZaijyY/QAp5/o0TfPZcDOhLAg879z2
        Aj2AuVKiDat4e9vTYWW0YPlPKW+3cp0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-dDdpTgWhP9CRKuf0g56FFw-1; Tue, 27 Jun 2023 11:54:28 -0400
X-MC-Unique: dDdpTgWhP9CRKuf0g56FFw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-401e1fc831fso2736541cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687881267; x=1690473267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blfaz25JTx0Gq1i5rQOIktQT2cQ83yiOEY0rptX8I8M=;
        b=K2yZvwDszJ322CiiceMiumvdzMs11ewmPrR7muJWo4u+T+08tqIlOTkD5EwM8/jHrV
         Cxpyxc7ApZ2/AeDekL4DyeLWuH1awDJnC/XQh9zcX7/WCNtNI2CQBSsEvTwc0xkV8iL6
         NIaBjmzobnqRfq/vsAEoBSNm85hfpxcSII48pLtSsDq0a+2Qj3PogINB4DBOfWqz7H6w
         6/hjyXWaut8y2dCPnj5gYbdMydH8/u+P6vh07QcXfgoQgu5p98lD6HnM8pynXtvoT+aj
         b1M0CdCJ92j5mLdehh/cbRUC988E38wwx1YPh4EgTWZV/DdKjEkkeNkgapKeodRfv7TH
         EVBw==
X-Gm-Message-State: AC+VfDw+fkzJaO3ycxDyXmOfVZuv6L5jWEoKxDPDUoLeu77LeQTn1Yrw
        w7w6m+RuFvwjct0fsA0x+DoXyDTDSMfUoWCBdDnEwKB80I92KYVUIXFZhWisikCDJ8nNQf7TTqm
        mfdH7/748ZbEVU6HheilEDZkF
X-Received: by 2002:ac8:5a86:0:b0:400:adc0:8306 with SMTP id c6-20020ac85a86000000b00400adc08306mr5934159qtc.4.1687881267445;
        Tue, 27 Jun 2023 08:54:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6el5jb9Izv6sojg638+Y+Ior7huYvpR+V+d70FMxnJoZyY0xlHgXUXCJu9qNQlG8K5lr0aQA==
X-Received: by 2002:ac8:5a86:0:b0:400:adc0:8306 with SMTP id c6-20020ac85a86000000b00400adc08306mr5934118qtc.4.1687881267160;
        Tue, 27 Jun 2023 08:54:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id cg13-20020a05622a408d00b003f4ed0ca698sm4677898qtb.49.2023.06.27.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:54:26 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:54:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 8/8] mm: handle userfaults under VMA lock
Message-ID: <ZJsGMDqcYopSW8QL@x1n>
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-9-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627042321.1763765-9-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:23:21PM -0700, Suren Baghdasaryan wrote:
> Enable handle_userfault to operate under VMA lock by releasing VMA lock
> instead of mmap_lock and retrying.

This mostly good to me (besides the new DROP flag.. of course), thanks.
Still some nitpicks below.

> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/userfaultfd.c | 42 ++++++++++++++++++++++--------------------
>  mm/memory.c      |  9 ---------
>  2 files changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 4e800bb7d2ab..b88632c404b6 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -277,17 +277,17 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
>   * hugepmd ranges.
>   */
>  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> -					 struct vm_area_struct *vma,
> -					 unsigned long address,
> -					 unsigned long flags,
> -					 unsigned long reason)
> +					      struct vm_fault *vmf,
> +					      unsigned long reason)
>  {
> +	struct vm_area_struct *vma = vmf->vma;
>  	pte_t *ptep, pte;
>  	bool ret = true;
>  
> -	mmap_assert_locked(ctx->mm);
> +	if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
> +		mmap_assert_locked(ctx->mm);

Maybe we can have a helper asserting proper vma protector locks (mmap for
!VMA_LOCK and vma read lock for VMA_LOCK)?  It basically tells the context
the vma is still safe to access.

>  
> -	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
> +	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
>  	if (!ptep)
>  		goto out;
>  
> @@ -308,10 +308,8 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  }
>  #else
>  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> -					 struct vm_area_struct *vma,
> -					 unsigned long address,
> -					 unsigned long flags,
> -					 unsigned long reason)
> +					      struct vm_fault *vmf,
> +					      unsigned long reason)
>  {
>  	return false;	/* should never get here */
>  }
> @@ -325,11 +323,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>   * threads.
>   */
>  static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> -					 unsigned long address,
> -					 unsigned long flags,
> +					 struct vm_fault *vmf,
>  					 unsigned long reason)
>  {
>  	struct mm_struct *mm = ctx->mm;
> +	unsigned long address = vmf->address;
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	pud_t *pud;
> @@ -337,7 +335,8 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
>  	pte_t *pte;
>  	bool ret = true;
>  
> -	mmap_assert_locked(mm);
> +	if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
> +		mmap_assert_locked(mm);

(the assert helper can also be used here)

>  
>  	pgd = pgd_offset(mm, address);
>  	if (!pgd_present(*pgd))
> @@ -445,7 +444,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	 * Coredumping runs without mmap_lock so we can only check that
>  	 * the mmap_lock is held, if PF_DUMPCORE was not set.
>  	 */
> -	mmap_assert_locked(mm);
> +	if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
> +		mmap_assert_locked(mm);
>  
>  	ctx = vma->vm_userfaultfd_ctx.ctx;
>  	if (!ctx)
> @@ -561,15 +561,17 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>  
>  	if (!is_vm_hugetlb_page(vma))
> -		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
> -						  reason);
> +		must_wait = userfaultfd_must_wait(ctx, vmf, reason);
>  	else
> -		must_wait = userfaultfd_huge_must_wait(ctx, vma,
> -						       vmf->address,
> -						       vmf->flags, reason);
> +		must_wait = userfaultfd_huge_must_wait(ctx, vmf, reason);
>  	if (is_vm_hugetlb_page(vma))
>  		hugetlb_vma_unlock_read(vma);
> -	mmap_read_unlock(mm);
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +		/* WARNING: VMA can't be used after this */
> +		vma_end_read(vma);
> +	} else
> +		mmap_read_unlock(mm);

I also think maybe we should have a helper mm_release_fault_lock() just
release different locks for with/without VMA_LOCK.  It can also be used in
the other patch of folio_lock_or_retry().

> +	vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
>  
>  	if (likely(must_wait && !READ_ONCE(ctx->released))) {
>  		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> diff --git a/mm/memory.c b/mm/memory.c
> index bdf46fdc58d6..923c1576bd14 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5316,15 +5316,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	if (!vma_start_read(vma))
>  		goto inval;
>  
> -	/*
> -	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
> -	 * it for now and fall back to page fault handling under mmap_lock.
> -	 */
> -	if (userfaultfd_armed(vma)) {
> -		vma_end_read(vma);
> -		goto inval;
> -	}
> -
>  	/* Check since vm_start/vm_end might change before we lock the VMA */
>  	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
>  		vma_end_read(vma);
> -- 
> 2.41.0.178.g377b9f9a00-goog
> 

-- 
Peter Xu

