Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1310666FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjALKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjALKho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:37:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65EC55859
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:31:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 881BC37A70;
        Thu, 12 Jan 2023 10:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673519509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDuPR09Dky6UQGEK8I/znXJ94j8W8+WzXtKjSCowtwg=;
        b=LQIkCKUXynd6jc9SPtAHB2A+Io+pkIU/tiOOvHF83rUX9Xf8Cc93wtwI98EUcqE5YskUNh
        lvDjl+WXKFu3XVEpvRaeZk84rUiJwVJTtlavo5Kc4EidIj4yvmOJPU2hBvvgZjUTmjrNBO
        O3Ekoxg+kGGcqUMwUedJuIOrnLRnyKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673519509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDuPR09Dky6UQGEK8I/znXJ94j8W8+WzXtKjSCowtwg=;
        b=YG1dh487UFcMJUm/4zYAGXs6or6Rn8kMzqTxFtttPEokrg6ut1P9gEWRfLhsn8l/+WI4Wd
        hul9YqRxhb+J96CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6128513585;
        Thu, 12 Jan 2023 10:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id amgwF5Xhv2NsKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 10:31:49 +0000
Message-ID: <e8b737fd-6204-419d-0592-5441ea344704@suse.cz>
Date:   Thu, 12 Jan 2023 11:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/5] mm: mlock: use folios and a folio batch internally
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
 <03ac78b416be5a361b79464acc3da7f93b9c37e8.1672043615.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <03ac78b416be5a361b79464acc3da7f93b9c37e8.1672043615.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 09:44, Lorenzo Stoakes wrote:
> This brings mlock in line with the folio batches declared in mm/swap.c and
> makes the code more consistent across the two.
> 
> The existing mechanism for identifying which operation each folio in the
> batch is undergoing is maintained, i.e. using the lower 2 bits of the
> struct folio address (previously struct page address). This should continue
> to function correctly as folios remain at least system word-aligned.
> 
> All invoctions of mlock() pass either a non-compound page or the head of a
> THP-compound page and no tail pages need updating so this functionality
> works with struct folios being used internally rather than struct pages.
> 
> In this patch the external interface is kept identical to before in order
> to maintain separation between patches in the series, using a rather
> awkward conversion from struct page to struct folio in relevant functions.
> 
> However, this maintenance of the existing interface is intended to be
> temporary - the next patch in the series will update the interfaces to
> accept folios directly.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

with some nits:

> -static struct lruvec *__munlock_page(struct page *page, struct lruvec *lruvec)
> +static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
>  {
> -	int nr_pages = thp_nr_pages(page);
> +	int nr_pages = folio_nr_pages(folio);
>  	bool isolated = false;
>  
> -	if (!TestClearPageLRU(page))
> +	if (!folio_test_clear_lru(folio))
>  		goto munlock;
>  
>  	isolated = true;
> -	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
> +	lruvec = folio_lruvec_relock_irq(folio, lruvec);
>  
> -	if (PageUnevictable(page)) {
> +	if (folio_test_unevictable(folio)) {
>  		/* Then mlock_count is maintained, but might undercount */
> -		if (page->mlock_count)
> -			page->mlock_count--;
> -		if (page->mlock_count)
> +		if (folio->mlock_count)
> +			folio->mlock_count--;
> +		if (folio->mlock_count)
>  			goto out;
>  	}
>  	/* else assume that was the last mlock: reclaim will fix it if not */
>  
>  munlock:
> -	if (TestClearPageMlocked(page)) {
> -		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> -		if (isolated || !PageUnevictable(page))
> +	if (folio_test_clear_mlocked(folio)) {
> +		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);

AFAIK the 1:1 replacement would be __zone_stat_mod_folio(), this is stronger
thus not causing a bug, but unneccessary?

> +		if (isolated || !folio_test_unevictable(folio))
>  			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
>  		else
>  			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
>  	}
>  
> -	/* page_evictable() has to be checked *after* clearing Mlocked */
> -	if (isolated && PageUnevictable(page) && page_evictable(page)) {
> -		del_page_from_lru_list(page, lruvec);
> -		ClearPageUnevictable(page);
> -		add_page_to_lru_list(page, lruvec);
> +	/* folio_evictable() has to be checked *after* clearing Mlocked */
> +	if (isolated && folio_test_unevictable(folio) && folio_evictable(folio)) {
> +		lruvec_del_folio(lruvec, folio);
> +		folio_clear_unevictable(folio);
> +		lruvec_add_folio(lruvec, folio);
>  		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
>  	}
>  out:
>  	if (isolated)
> -		SetPageLRU(page);
> +		folio_set_lru(folio);
>  	return lruvec;
>  }
>  
>  /*
> - * Flags held in the low bits of a struct page pointer on the mlock_pvec.
> + * Flags held in the low bits of a struct folio pointer on the mlock_fbatch.
>   */
>  #define LRU_PAGE 0x1
>  #define NEW_PAGE 0x2

Should it be X_FOLIO now?

> -static inline struct page *mlock_lru(struct page *page)
> +static inline struct folio *mlock_lru(struct folio *folio)
>  {
> -	return (struct page *)((unsigned long)page + LRU_PAGE);
> +	return (struct folio *)((unsigned long)folio + LRU_PAGE);
>  }
>  
> -static inline struct page *mlock_new(struct page *page)
> +static inline struct folio *mlock_new(struct folio *folio)
>  {
> -	return (struct page *)((unsigned long)page + NEW_PAGE);
> +	return (struct folio *)((unsigned long)folio + NEW_PAGE);
>  }
>  
>  /*
> - * mlock_pagevec() is derived from pagevec_lru_move_fn():
> - * perhaps that can make use of such page pointer flags in future,
> - * but for now just keep it for mlock.  We could use three separate
> - * pagevecs instead, but one feels better (munlocking a full pagevec
> - * does not need to drain mlocking pagevecs first).
> + * mlock_folio_batch() is derived from folio_batch_move_lru(): perhaps that can
> + * make use of such page pointer flags in future, but for now just keep it for

		       ^ folio?	

> + * mlock.  We could use three separate folio batches instead, but one feels
> + * better (munlocking a full folio batch does not need to drain mlocking folio
> + * batches first).
>   */
> -static void mlock_pagevec(struct pagevec *pvec)
> +static void mlock_folio_batch(struct folio_batch *fbatch)

