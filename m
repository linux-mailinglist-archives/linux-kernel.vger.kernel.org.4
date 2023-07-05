Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B440748011
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjGEIrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjGEIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:47:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE73184;
        Wed,  5 Jul 2023 01:47:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f13c41c957so1559916e87.1;
        Wed, 05 Jul 2023 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688546856; x=1691138856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zr2sUZ7SOfrksXjNzs8Fb6GlNxPeyG5uVqIbAzN64E=;
        b=DUiGlPTWW39RXZnUrevBhgioI7w+Gss5yLudrBT0GwQlL7jPaHLl2kC4pvHtC6rUoY
         SDMzeL8G/9lKNJUrkxv/qHPoBaaVXKsKA4rnB+si3ZBSHEK1Ub9LiSnpie8OOgdnnh4i
         P6HnWwOZYV/fIjHYA77uNEQJ0D1I+/IQ5nrssNoH5J0mLveYMpL46P3pIWVCjuefiG2/
         AF8wYT93ozmZqhbtmplrBbXVZ808CAmtn+r6jaarzItzCFzZgyKptwRRi1biboJRWbU7
         Z1aU01DFidFy3K7vpMimd3N/FS7jzPLXRRv2qyYFmBrZnJKDdHGvln27ywR97w2N1RLh
         AlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688546856; x=1691138856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zr2sUZ7SOfrksXjNzs8Fb6GlNxPeyG5uVqIbAzN64E=;
        b=ALQO5SoODpasOElZcf+vacPRIJBtKw5wIRVpbH+wAuiOLWRU46YIAf7jE+pRLzMp5U
         Wpc8r29jLCX36upYakANPweapv6bJsTPxu4arGR8zsT0N1NhHw1tPpD5Z4b4jrZqxJvr
         s4eZ0yIb0QDx7d53qCMv62vc3m33oww4M3ZEa7CcAqeKDbdaIfbPaWCtNDufZh1nFum/
         XIPkNjLlagR6bI8HebQQF1PCxMipGOtpqLQM73Qb24H/NDbyEuWE2s/3nLi8Y7vTbr5H
         WGDE/ihdv78Ched/A0yHKhrH2DkrWXe8H+/7A7nLXu28Fyhkmy7rRl3O5MFWJ9O+nnhN
         zorw==
X-Gm-Message-State: ABy/qLaPYKvMUfsLbexwuITkccfrpfGfz/3S+gBrQ5T6XiP4a79oOZUt
        f/G37ZjlYozjvHX+7Utt2xc=
X-Google-Smtp-Source: APBJJlGwwUpsTPGSmjBgIwWwA6p5GXaeRLhpcLgAInEFyvPhfC9EmH5zFCxspQau0McHQpgcVqi4tw==
X-Received: by 2002:ac2:538a:0:b0:4f6:86ba:283b with SMTP id g10-20020ac2538a000000b004f686ba283bmr9200910lfh.4.1688546855897;
        Wed, 05 Jul 2023 01:47:35 -0700 (PDT)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id m17-20020ac24ad1000000b004fbaf131b1csm1963816lfp.130.2023.07.05.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:47:35 -0700 (PDT)
Date:   Wed, 5 Jul 2023 11:47:32 +0300
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v7 2/8] KVM: Introduce __kvm_follow_pfn function
Message-ID: <20230705114732.000005c6.zhi.wang.linux@gmail.com>
In-Reply-To: <20230704075054.3344915-3-stevensd@google.com>
References: <20230704075054.3344915-1-stevensd@google.com>
        <20230704075054.3344915-3-stevensd@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Jul 2023 16:50:47 +0900
David Stevens <stevensd@chromium.org> wrote:

> From: David Stevens <stevensd@chromium.org>
> 
> Introduce __kvm_follow_pfn, which will replace __gfn_to_pfn_memslot.
> __kvm_follow_pfn refactors the old API's arguments into a struct and,
> where possible, combines the boolean arguments into a single flags
> argument.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  include/linux/kvm_host.h |  16 ++++
>  virt/kvm/kvm_main.c      | 171 ++++++++++++++++++++++-----------------
>  virt/kvm/kvm_mm.h        |   3 +-
>  virt/kvm/pfncache.c      |   8 +-
>  4 files changed, 122 insertions(+), 76 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9d3ac7720da9..ef2763c2b12e 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -97,6 +97,7 @@
>  #define KVM_PFN_ERR_HWPOISON	(KVM_PFN_ERR_MASK + 1)
>  #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
>  #define KVM_PFN_ERR_SIGPENDING	(KVM_PFN_ERR_MASK + 3)
> +#define KVM_PFN_ERR_NEEDS_IO	(KVM_PFN_ERR_MASK + 4)
>  
>  /*
>   * error pfns indicate that the gfn is in slot but faild to
> @@ -1156,6 +1157,21 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot, gfn_t gfn,
>  void kvm_release_page_clean(struct page *page);
>  void kvm_release_page_dirty(struct page *page);
>  
> +struct kvm_follow_pfn {
> +	const struct kvm_memory_slot *slot;
> +	gfn_t gfn;
> +	unsigned int flags;
> +	bool atomic;
> +	/* Allow a read fault to create a writeable mapping. */
> +	bool allow_write_mapping;
> +
> +	/* Outputs of __kvm_follow_pfn */
> +	hva_t hva;
> +	bool writable;
> +};
> +
> +kvm_pfn_t __kvm_follow_pfn(struct kvm_follow_pfn *foll);
> +
>  kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn);
>  kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
>  		      bool *writable);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 371bd783ff2b..b13f22861d2f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2486,24 +2486,22 @@ static inline int check_user_page_hwpoison(unsigned long addr)
>   * true indicates success, otherwise false is returned.  It's also the
>   * only part that runs if we can in atomic context.
>   */
> -static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
> -			    bool *writable, kvm_pfn_t *pfn)
> +static bool hva_to_pfn_fast(struct kvm_follow_pfn *foll, kvm_pfn_t *pfn)
>  {
>  	struct page *page[1];
> +	bool write_fault = foll->flags & FOLL_WRITE;
>  
>  	/*
>  	 * Fast pin a writable pfn only if it is a write fault request
>  	 * or the caller allows to map a writable pfn for a read fault
>  	 * request.
>  	 */
> -	if (!(write_fault || writable))
> +	if (!(write_fault || foll->allow_write_mapping))
>  		return false;
>  
> -	if (get_user_page_fast_only(addr, FOLL_WRITE, page)) {
> +	if (get_user_page_fast_only(foll->hva, FOLL_WRITE, page)) {
>  		*pfn = page_to_pfn(page[0]);
> -
> -		if (writable)
> -			*writable = true;
> +		foll->writable = foll->allow_write_mapping;
>  		return true;
>  	}
>  
> @@ -2514,35 +2512,26 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
>   * The slow path to get the pfn of the specified host virtual address,
>   * 1 indicates success, -errno is returned if error is detected.
>   */
> -static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
> -			   bool interruptible, bool *writable, kvm_pfn_t *pfn)
> +static int hva_to_pfn_slow(struct kvm_follow_pfn *foll, kvm_pfn_t *pfn)
>  {
> -	unsigned int flags = FOLL_HWPOISON;
> +	unsigned int flags = FOLL_HWPOISON | FOLL_GET | foll->flags;
>  	struct page *page;
>  	int npages;
>  
>  	might_sleep();
>  
> -	if (writable)
> -		*writable = write_fault;
> -
> -	if (write_fault)
> -		flags |= FOLL_WRITE;
> -	if (async)
> -		flags |= FOLL_NOWAIT;
> -	if (interruptible)
> -		flags |= FOLL_INTERRUPTIBLE;
> -
> -	npages = get_user_pages_unlocked(addr, 1, &page, flags);
> +	npages = get_user_pages_unlocked(foll->hva, 1, &page, flags);
>  	if (npages != 1)
>  		return npages;
>  
> +	foll->writable = (foll->flags & FOLL_WRITE) && foll->allow_write_mapping;
> +
>  	/* map read fault as writable if possible */
> -	if (unlikely(!write_fault) && writable) {
> +	if (unlikely(!foll->writable) && foll->allow_write_mapping) {
>  		struct page *wpage;
>  
> -		if (get_user_page_fast_only(addr, FOLL_WRITE, &wpage)) {
> -			*writable = true;
> +		if (get_user_page_fast_only(foll->hva, FOLL_WRITE, &wpage)) {
> +			foll->writable = true;
>  			put_page(page);
>  			page = wpage;
>  		}
> @@ -2572,23 +2561,23 @@ static int kvm_try_get_pfn(kvm_pfn_t pfn)
>  	return get_page_unless_zero(page);
>  }
>  
> -static int hva_to_pfn_remapped(struct vm_area_struct *vma,
> -			       unsigned long addr, bool write_fault,
> -			       bool *writable, kvm_pfn_t *p_pfn)
> +static int hva_to_pfn_remapped(struct vm_area_struct *vma, struct kvm_follow_pfn *foll,
> +			       kvm_pfn_t *p_pfn)
>  {
>  	kvm_pfn_t pfn;
>  	pte_t *ptep;
>  	spinlock_t *ptl;
> +	bool write_fault = foll->flags & FOLL_WRITE;
>  	int r;
>  
> -	r = follow_pte(vma->vm_mm, addr, &ptep, &ptl);
> +	r = follow_pte(vma->vm_mm, foll->hva, &ptep, &ptl);
>  	if (r) {
>  		/*
>  		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
>  		 * not call the fault handler, so do it here.
>  		 */
>  		bool unlocked = false;
> -		r = fixup_user_fault(current->mm, addr,
> +		r = fixup_user_fault(current->mm, foll->hva,
>  				     (write_fault ? FAULT_FLAG_WRITE : 0),
>  				     &unlocked);
>  		if (unlocked)
> @@ -2596,7 +2585,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>  		if (r)
>  			return r;
>  
> -		r = follow_pte(vma->vm_mm, addr, &ptep, &ptl);
> +		r = follow_pte(vma->vm_mm, foll->hva, &ptep, &ptl);
>  		if (r)
>  			return r;
>  	}
> @@ -2606,8 +2595,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>  		goto out;
>  	}
>  
> -	if (writable)
> -		*writable = pte_write(*ptep);
> +	foll->writable = pte_write(*ptep) && foll->allow_write_mapping;
>  	pfn = pte_pfn(*ptep);
>  
>  	/*
> @@ -2652,24 +2640,22 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>   * 2): @write_fault = false && @writable, @writable will tell the caller
>   *     whether the mapping is writable.
>   */
> -kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
> -		     bool *async, bool write_fault, bool *writable)
> +kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *foll)
>  {
>  	struct vm_area_struct *vma;
>  	kvm_pfn_t pfn;
>  	int npages, r;
>  
>  	/* we can do it either atomically or asynchronously, not both */
> -	BUG_ON(atomic && async);
> +	BUG_ON(foll->atomic && (foll->flags & FOLL_NOWAIT));
>  
> -	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
> +	if (hva_to_pfn_fast(foll, &pfn))
>  		return pfn;
>  
> -	if (atomic)
> +	if (foll->atomic)
>  		return KVM_PFN_ERR_FAULT;
>  
> -	npages = hva_to_pfn_slow(addr, async, write_fault, interruptible,
> -				 writable, &pfn);
> +	npages = hva_to_pfn_slow(foll, &pfn);
>  	if (npages == 1)
>  		return pfn;
>  	if (npages == -EINTR)
> @@ -2677,83 +2663,122 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
>  
>  	mmap_read_lock(current->mm);
>  	if (npages == -EHWPOISON ||
> -	      (!async && check_user_page_hwpoison(addr))) {
> +	      (!(foll->flags & FOLL_NOWAIT) && check_user_page_hwpoison(foll->hva))) {
>  		pfn = KVM_PFN_ERR_HWPOISON;
>  		goto exit;
>  	}
>  
>  retry:
> -	vma = vma_lookup(current->mm, addr);
> +	vma = vma_lookup(current->mm, foll->hva);
>  
>  	if (vma == NULL)
>  		pfn = KVM_PFN_ERR_FAULT;
>  	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
> -		r = hva_to_pfn_remapped(vma, addr, write_fault, writable, &pfn);
> +		r = hva_to_pfn_remapped(vma, foll, &pfn);
>  		if (r == -EAGAIN)
>  			goto retry;
>  		if (r < 0)
>  			pfn = KVM_PFN_ERR_FAULT;
>  	} else {
> -		if (async && vma_is_valid(vma, write_fault))
> -			*async = true;
> -		pfn = KVM_PFN_ERR_FAULT;
> +		if ((foll->flags & FOLL_NOWAIT) &&
> +		    vma_is_valid(vma, foll->flags & FOLL_WRITE))
> +			pfn = KVM_PFN_ERR_NEEDS_IO;
> +		else
> +			pfn = KVM_PFN_ERR_FAULT;
>  	}
>  exit:
>  	mmap_read_unlock(current->mm);
>  	return pfn;
>  }
>  
> -kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
> -			       bool atomic, bool interruptible, bool *async,
> -			       bool write_fault, bool *writable, hva_t *hva)
> +kvm_pfn_t __kvm_follow_pfn(struct kvm_follow_pfn *foll)
>  {
> -	unsigned long addr = __gfn_to_hva_many(slot, gfn, NULL, write_fault);
> -
> -	if (hva)
> -		*hva = addr;
> +	foll->hva = __gfn_to_hva_many(foll->slot, foll->gfn, NULL,
> +				      foll->flags & FOLL_WRITE);
>  
> -	if (addr == KVM_HVA_ERR_RO_BAD) {
> -		if (writable)
> -			*writable = false;
> +	if (foll->hva == KVM_HVA_ERR_RO_BAD)
>  		return KVM_PFN_ERR_RO_FAULT;
> -	}
>  

Can you explain why updating foll->writable = false (previously *writeable
= false) is omitted here?

In the caller where the struct kvm_follow_pfn is initialized, e.g.
__gfn_to_pfn_memslot()/gfn_to_pfn_prot(), .writable is not initialized.
IIUC, they expect __kvm_follow_pfn() to update it and return .writable to
upper caller.

As the one of the output, it would be better to initalize it either in the
caller or update it in __kvm_follow_pfn(). Or
__gfn_to_pfn_memslot()/gfn_to_pfn_prot() will return random data in the
stack to the caller via bool *writable. It doesn't sound nice.

BTW: It seems both "writable" and "writeable" are used in this patch. I am
wondering maybe we can correct them.

> -	if (kvm_is_error_hva(addr)) {
> -		if (writable)
> -			*writable = false;
> +	if (kvm_is_error_hva(foll->hva))
>  		return KVM_PFN_NOSLOT;
> -	}
>  
> -	/* Do not map writable pfn in the readonly memslot. */
> -	if (writable && memslot_is_readonly(slot)) {
> -		*writable = false;
> -		writable = NULL;
> -	}
> +	if (memslot_is_readonly(foll->slot))
> +		foll->allow_write_mapping = false;
> +
> +	return hva_to_pfn(foll);
> +}
> +EXPORT_SYMBOL_GPL(__kvm_follow_pfn);
>  
> -	return hva_to_pfn(addr, atomic, interruptible, async, write_fault,
> -			  writable);
> +kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
> +			       bool atomic, bool interruptible, bool *async,
> +			       bool write_fault, bool *writable, hva_t *hva)
> +{
> +	kvm_pfn_t pfn;
> +	struct kvm_follow_pfn foll = {
> +		.slot = slot,
> +		.gfn = gfn,
> +		.flags = 0,
> +		.atomic = atomic,
> +		.allow_write_mapping = !!writable,
> +	};
> +
> +	if (write_fault)
> +		foll.flags |= FOLL_WRITE;
> +	if (async)
> +		foll.flags |= FOLL_NOWAIT;
> +	if (interruptible)
> +		foll.flags |= FOLL_INTERRUPTIBLE;
> +
> +	pfn = __kvm_follow_pfn(&foll);
> +	if (pfn == KVM_PFN_ERR_NEEDS_IO) {
> +		*async = true;
> +		pfn = KVM_PFN_ERR_FAULT;
> +	}
> +	if (hva)
> +		*hva = foll.hva;
> +	if (writable)
> +		*writable = foll.writable;
> +	return pfn;
>  }
>  EXPORT_SYMBOL_GPL(__gfn_to_pfn_memslot);
>  
>  kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
>  		      bool *writable)
>  {
> -	return __gfn_to_pfn_memslot(gfn_to_memslot(kvm, gfn), gfn, false, false,
> -				    NULL, write_fault, writable, NULL);
> +	kvm_pfn_t pfn;
> +	struct kvm_follow_pfn foll = {
> +		.slot = gfn_to_memslot(kvm, gfn),
> +		.gfn = gfn,
> +		.flags = write_fault ? FOLL_WRITE : 0,
> +		.allow_write_mapping = !!writable,
> +	};
> +	pfn = __kvm_follow_pfn(&foll);
> +	if (writable)
> +		*writable = foll.writable;
> +	return pfn;
>  }
>  EXPORT_SYMBOL_GPL(gfn_to_pfn_prot);
>  
>  kvm_pfn_t gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
>  {
> -	return __gfn_to_pfn_memslot(slot, gfn, false, false, NULL, true,
> -				    NULL, NULL);
> +	struct kvm_follow_pfn foll = {
> +		.slot = slot,
> +		.gfn = gfn,
> +		.flags = FOLL_WRITE,
> +	};
> +	return __kvm_follow_pfn(&foll);
>  }
>  EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot);
>  
>  kvm_pfn_t gfn_to_pfn_memslot_atomic(const struct kvm_memory_slot *slot, gfn_t gfn)
>  {
> -	return __gfn_to_pfn_memslot(slot, gfn, true, false, NULL, true,
> -				    NULL, NULL);
> +	struct kvm_follow_pfn foll = {
> +		.slot = slot,
> +		.gfn = gfn,
> +		.flags = FOLL_WRITE,
> +		.atomic = true,
> +	};
> +	return __kvm_follow_pfn(&foll);
>  }
>  EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot_atomic);
>  
> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> index 180f1a09e6ba..ed896aee5396 100644
> --- a/virt/kvm/kvm_mm.h
> +++ b/virt/kvm/kvm_mm.h
> @@ -20,8 +20,7 @@
>  #define KVM_MMU_UNLOCK(kvm)		spin_unlock(&(kvm)->mmu_lock)
>  #endif /* KVM_HAVE_MMU_RWLOCK */
>  
> -kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
> -		     bool *async, bool write_fault, bool *writable);
> +kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *foll);
>  
>  #ifdef CONFIG_HAVE_KVM_PFNCACHE
>  void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 2d6aba677830..e3fefa753a51 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -144,6 +144,12 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
>  	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
>  	void *new_khva = NULL;
>  	unsigned long mmu_seq;
> +	struct kvm_follow_pfn foll = {
> +		.slot = gpc->memslot,
> +		.gfn = gpa_to_gfn(gpc->gpa),
> +		.flags = FOLL_WRITE,
> +		.hva = gpc->uhva,
> +	};
>  
>  	lockdep_assert_held(&gpc->refresh_lock);
>  
> @@ -183,7 +189,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
>  		}
>  
>  		/* We always request a writeable mapping */
> -		new_pfn = hva_to_pfn(gpc->uhva, false, false, NULL, true, NULL);
> +		new_pfn = hva_to_pfn(&foll);
>  		if (is_error_noslot_pfn(new_pfn))
>  			goto out_error;
>  

