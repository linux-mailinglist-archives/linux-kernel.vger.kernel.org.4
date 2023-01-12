Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FF66706D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjALLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjALLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:02:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B6656898
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:55:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA2003E9EA;
        Thu, 12 Jan 2023 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673520913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whGPt03J1CPs9FsWnT2ZYn3HZP04QDqHTeMEVO3NILs=;
        b=elaAoNGP/NY3U6WtYJASzz3uWdUPQNheEtZHsQWvxAeQg/OTkMuKGHKKT+B5CpiYuvDKbO
        BiF6WeOqiocxp0d8vm4FHUruSgGXzeWvhlI9olQvq4FbuyxHYr51JP3sTpJEGYhdbvfYrV
        jPeS0DDDK/RqSMDM5kqCz2JUZN0+G0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673520913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whGPt03J1CPs9FsWnT2ZYn3HZP04QDqHTeMEVO3NILs=;
        b=7kRp2d48Vr+kTB/rqAxN1ePRyxQIhfyzNf+G9q1BB2+wxoDUJqxyC7SUKgdWkfJWt6OEVk
        KLmYf9UShMsqMKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8663713776;
        Thu, 12 Jan 2023 10:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id trjaHxHnv2NFLgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 10:55:13 +0000
Message-ID: <50cc1bfc-6cee-dc98-7ed9-cc3f0c863c02@suse.cz>
Date:   Thu, 12 Jan 2023 11:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/5] mm: mlock: update the interface to use folios
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1672043615.git.lstoakes@gmail.com>
 <c6555463e07cfe6e68c229ed9b8051f98a884388.1672043615.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c6555463e07cfe6e68c229ed9b8051f98a884388.1672043615.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 09:44, Lorenzo Stoakes wrote:
> This patch updates the mlock interface to accept folios rather than pages,
> bringing the interface in line with the internal implementation.
> 
> munlock_vma_page() still requires a page_folio() conversion, however this
> is consistent with the existent mlock_vma_page() implementation and a
> product of rmap still dealing in pages rather than folios.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

With some suggestion:

> ---
>  mm/internal.h | 26 ++++++++++++++++----------
>  mm/mlock.c    | 32 +++++++++++++++-----------------
>  mm/swap.c     |  2 +-
>  3 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 1d6f4e168510..8a6e83315369 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -515,10 +515,9 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>   * should be called with vma's mmap_lock held for read or write,
>   * under page table lock for the pte/pmd being added or removed.
>   *
> - * mlock is usually called at the end of page_add_*_rmap(),
> - * munlock at the end of page_remove_rmap(); but new anon
> - * pages are managed by lru_cache_add_inactive_or_unevictable()
> - * calling mlock_new_page().
> + * mlock is usually called at the end of page_add_*_rmap(), munlock at
> + * the end of page_remove_rmap(); but new anon folios are managed by
> + * folio_add_lru_vma() calling mlock_new_folio().
>   *
>   * @compound is used to include pmd mappings of THPs, but filter out
>   * pte mappings of THPs, which cannot be consistently counted: a pte
> @@ -547,15 +546,22 @@ static inline void mlock_vma_page(struct page *page,
>  	mlock_vma_folio(page_folio(page), vma, compound);
>  }
>  
> -void munlock_page(struct page *page);
> -static inline void munlock_vma_page(struct page *page,
> +void munlock_folio(struct folio *folio);
> +
> +static inline void munlock_vma_folio(struct folio *folio,
>  			struct vm_area_struct *vma, bool compound)
>  {
>  	if (unlikely(vma->vm_flags & VM_LOCKED) &&
> -	    (compound || !PageTransCompound(page)))
> -		munlock_page(page);
> +	    (compound || !folio_test_large(folio)))
> +		munlock_folio(folio);
> +}
> +
> +static inline void munlock_vma_page(struct page *page,
> +			struct vm_area_struct *vma, bool compound)
> +{
> +	munlock_vma_folio(page_folio(page), vma, compound);
>  }
> -void mlock_new_page(struct page *page);
> +void mlock_new_folio(struct folio *folio);
>  bool need_mlock_page_drain(int cpu);
>  void mlock_page_drain_local(void);
>  void mlock_page_drain_remote(int cpu);

I think these drain related functions could use a rename as well?
Maybe replace "page" with "fbatch" or "folio_batch"? Even the old name isn't
great, should have been "pagevec".
But maybe it would fit patch 2/5 rather than 4/5 as it's logically internal
even if in a .h file.


