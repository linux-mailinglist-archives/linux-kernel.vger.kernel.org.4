Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A4706C00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjEQPCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjEQPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:01:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6645D847
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:00:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E33C113E;
        Wed, 17 May 2023 08:00:38 -0700 (PDT)
Received: from [10.57.58.217] (unknown [10.57.58.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69203F73F;
        Wed, 17 May 2023 07:59:50 -0700 (PDT)
Message-ID: <993ee407-cd7a-ab14-9d66-2e1009e05d3a@arm.com>
Date:   Wed, 17 May 2023 15:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] arm64: mte: Simplify swap tag restoration logic
Content-Language: en-GB
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com
References: <20230517022115.3033604-1-pcc@google.com>
 <20230517022115.3033604-4-pcc@google.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230517022115.3033604-4-pcc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 03:21, Peter Collingbourne wrote:
> As a result of the previous two patches, there are no circumstances
> in which a swapped-in page is installed in a page table without first
> having arch_swap_restore() called on it. Therefore, we no longer need
> the logic in set_pte_at() that restores the tags, so remove it.
> 
> Because we can now rely on the page being locked, we no longer need to
> handle the case where a page is having its tags restored by multiple tasks
> concurrently, so we can slightly simplify the logic in mte_restore_tags().
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I8ad54476f3b2d0144ccd8ce0c1d7a2963e5ff6f3

This is much neater, thanks for figuring out a better way of
implementing it. The set_pte_at() thing always felt like a hack, but it
was always there for the non-swap case and I obviously never figured out
a better solution.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v3:
> - Rebased onto arm64/for-next/fixes, which already has a fix
>   for the issue previously tagged, therefore removed Fixes:
>   tag
> 
>  arch/arm64/include/asm/mte.h     |  4 ++--
>  arch/arm64/include/asm/pgtable.h | 14 ++----------
>  arch/arm64/kernel/mte.c          | 37 ++++++--------------------------
>  arch/arm64/mm/mteswap.c          |  7 +++---
>  4 files changed, 14 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index c028afb1cd0b..4cedbaa16f41 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -90,7 +90,7 @@ static inline bool try_page_mte_tagging(struct page *page)
>  }
>  
>  void mte_zero_clear_page_tags(void *addr);
> -void mte_sync_tags(pte_t old_pte, pte_t pte);
> +void mte_sync_tags(pte_t pte);
>  void mte_copy_page_tags(void *kto, const void *kfrom);
>  void mte_thread_init_user(void);
>  void mte_thread_switch(struct task_struct *next);
> @@ -122,7 +122,7 @@ static inline bool try_page_mte_tagging(struct page *page)
>  static inline void mte_zero_clear_page_tags(void *addr)
>  {
>  }
> -static inline void mte_sync_tags(pte_t old_pte, pte_t pte)
> +static inline void mte_sync_tags(pte_t pte)
>  {
>  }
>  static inline void mte_copy_page_tags(void *kto, const void *kfrom)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0bd18de9fd97..e8a252e62b12 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -337,18 +337,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	 * don't expose tags (instruction fetches don't check tags).
>  	 */
>  	if (system_supports_mte() && pte_access_permitted(pte, false) &&
> -	    !pte_special(pte)) {
> -		pte_t old_pte = READ_ONCE(*ptep);
> -		/*
> -		 * We only need to synchronise if the new PTE has tags enabled
> -		 * or if swapping in (in which case another mapping may have
> -		 * set tags in the past even if this PTE isn't tagged).
> -		 * (!pte_none() && !pte_present()) is an open coded version of
> -		 * is_swap_pte()
> -		 */
> -		if (pte_tagged(pte) || (!pte_none(old_pte) && !pte_present(old_pte)))
> -			mte_sync_tags(old_pte, pte);
> -	}
> +	    !pte_special(pte) && pte_tagged(pte))
> +		mte_sync_tags(pte);
>  
>  	__check_safe_pte_update(mm, ptep, pte);
>  
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 7e89968bd282..c40728046fed 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -35,41 +35,18 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
>  EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>  #endif
>  
> -static void mte_sync_page_tags(struct page *page, pte_t old_pte,
> -			       bool check_swap, bool pte_is_tagged)
> -{
> -	if (check_swap && is_swap_pte(old_pte)) {
> -		swp_entry_t entry = pte_to_swp_entry(old_pte);
> -
> -		if (!non_swap_entry(entry))
> -			mte_restore_tags(entry, page);
> -	}
> -
> -	if (!pte_is_tagged)
> -		return;
> -
> -	if (try_page_mte_tagging(page)) {
> -		mte_clear_page_tags(page_address(page));
> -		set_page_mte_tagged(page);
> -	}
> -}
> -
> -void mte_sync_tags(pte_t old_pte, pte_t pte)
> +void mte_sync_tags(pte_t pte)
>  {
>  	struct page *page = pte_page(pte);
>  	long i, nr_pages = compound_nr(page);
> -	bool check_swap = nr_pages == 1;
> -	bool pte_is_tagged = pte_tagged(pte);
> -
> -	/* Early out if there's nothing to do */
> -	if (!check_swap && !pte_is_tagged)
> -		return;
>  
>  	/* if PG_mte_tagged is set, tags have already been initialised */
> -	for (i = 0; i < nr_pages; i++, page++)
> -		if (!page_mte_tagged(page))
> -			mte_sync_page_tags(page, old_pte, check_swap,
> -					   pte_is_tagged);
> +	for (i = 0; i < nr_pages; i++, page++) {
> +		if (try_page_mte_tagging(page)) {
> +			mte_clear_page_tags(page_address(page));
> +			set_page_mte_tagged(page);
> +		}
> +	}
>  
>  	/* ensure the tags are visible before the PTE is set */
>  	smp_wmb();
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index cd508ba80ab1..3a78bf1b1364 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -53,10 +53,9 @@ void mte_restore_tags(swp_entry_t entry, struct page *page)
>  	if (!tags)
>  		return;
>  
> -	if (try_page_mte_tagging(page)) {
> -		mte_restore_page_tags(page_address(page), tags);
> -		set_page_mte_tagged(page);
> -	}
> +	WARN_ON_ONCE(!try_page_mte_tagging(page));
> +	mte_restore_page_tags(page_address(page), tags);
> +	set_page_mte_tagged(page);
>  }
>  
>  void mte_invalidate_tags(int type, pgoff_t offset)

