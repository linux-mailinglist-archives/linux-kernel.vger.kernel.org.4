Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A7667106
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjALLgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjALLf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:35:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB155CE01
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:27:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so629547wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUq8jM21Z0eMtvH0FWYvwnsV1U+elnmCWQU263wQO9o=;
        b=F+iKcjlBwEtjfhmQP2gb9jFv0AJFVCgXhOix0KnT9A9QK1njgYVh8QEjjPiySmRbS+
         WFmMlCgn+uvVKr/zUXow9Ntp0M2xwsIWMqbdTBsmRJEGZ/mFUsPKUzQpOWfEiLFPjQa+
         0GyMOx1uIHZaiTQ3OYs6QRvGJS6hawf+zdkDMtdujI76K7fkGtBRdBx2Z6i705JUJAx9
         nhGyYODemAbvUC2zZkTqtGNsTQt/G8QfhJIe4Pktih8o0zT7TIxP8hIhSQd6MLgj8Ivv
         Gl9X/K4Yui730qJAh9y0OtZc1Hrs21b4fRL19NRSDsa7SJvDdXbmJ/jeUT8AhJdnWygA
         lR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUq8jM21Z0eMtvH0FWYvwnsV1U+elnmCWQU263wQO9o=;
        b=aWz0lWSSNxmBmPW8sbkzPEPed6AWBJZKYpuFnouuDGI3d0lUq52XFp53mb6rvyJWRO
         BqETq4Src9HMIey8nRsO4HEDHhezFrD8dlMZf8SVrEmZSqkuSreCBvQ0UaEF1xeHeZ2Z
         LjBFD2ZgMyMlryRKHfd2HDA9V8/QseG3BSg8KyQyDHvIIvN0Bl+Xs+z5AuAmUnwws7ZG
         rHS1CQi2pZ+rI/ybnuaadnYFhVJf8FhLHMMMt144ieCzJ50yNkrw4TzFPKoH9dThJ6UM
         kkkT0jx0Vy1IgSaYIraMI1tLV1m5fFTAsYGVYjwf8PgQETU3postbrhnXzNzDRWxuRnx
         pLLg==
X-Gm-Message-State: AFqh2krI8MWRptrFPbfYEizU1PMAZYundF/ZR9n8t7FNU7XROSYXPJ5b
        /Q91K9Q7H4AfekCJw9dVeTk=
X-Google-Smtp-Source: AMrXdXtAsorVS7O3LEpSlYBsEkiOY0E2c8FJRCRyYiHfSH4FMSsIhezW5eOChVodhvxVChEUqQTcPw==
X-Received: by 2002:a05:600c:1e05:b0:3da:1d51:ef96 with SMTP id ay5-20020a05600c1e0500b003da1d51ef96mr72329wmb.23.1673522841154;
        Thu, 12 Jan 2023 03:27:21 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003d9a71ee54dsm20721261wmj.36.2023.01.12.03.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 03:27:20 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:27:19 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/5] mm: mlock: use folios and a folio batch internally
Message-ID: <Y7/ul1FuV4O9eKjs@lucifer>
References: <cover.1672043615.git.lstoakes@gmail.com>
 <03ac78b416be5a361b79464acc3da7f93b9c37e8.1672043615.git.lstoakes@gmail.com>
 <e8b737fd-6204-419d-0592-5441ea344704@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b737fd-6204-419d-0592-5441ea344704@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:31:49AM +0100, Vlastimil Babka wrote:
> On 12/26/22 09:44, Lorenzo Stoakes wrote:
> > This brings mlock in line with the folio batches declared in mm/swap.c and
> > makes the code more consistent across the two.
> >
> > The existing mechanism for identifying which operation each folio in the
> > batch is undergoing is maintained, i.e. using the lower 2 bits of the
> > struct folio address (previously struct page address). This should continue
> > to function correctly as folios remain at least system word-aligned.
> >
> > All invoctions of mlock() pass either a non-compound page or the head of a
> > THP-compound page and no tail pages need updating so this functionality
> > works with struct folios being used internally rather than struct pages.
> >
> > In this patch the external interface is kept identical to before in order
> > to maintain separation between patches in the series, using a rather
> > awkward conversion from struct page to struct folio in relevant functions.
> >
> > However, this maintenance of the existing interface is intended to be
> > temporary - the next patch in the series will update the interfaces to
> > accept folios directly.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> with some nits:
>
> > -static struct lruvec *__munlock_page(struct page *page, struct lruvec *lruvec)
> > +static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
> >  {
> > -	int nr_pages = thp_nr_pages(page);
> > +	int nr_pages = folio_nr_pages(folio);
> >  	bool isolated = false;
> >
> > -	if (!TestClearPageLRU(page))
> > +	if (!folio_test_clear_lru(folio))
> >  		goto munlock;
> >
> >  	isolated = true;
> > -	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
> > +	lruvec = folio_lruvec_relock_irq(folio, lruvec);
> >
> > -	if (PageUnevictable(page)) {
> > +	if (folio_test_unevictable(folio)) {
> >  		/* Then mlock_count is maintained, but might undercount */
> > -		if (page->mlock_count)
> > -			page->mlock_count--;
> > -		if (page->mlock_count)
> > +		if (folio->mlock_count)
> > +			folio->mlock_count--;
> > +		if (folio->mlock_count)
> >  			goto out;
> >  	}
> >  	/* else assume that was the last mlock: reclaim will fix it if not */
> >
> >  munlock:
> > -	if (TestClearPageMlocked(page)) {
> > -		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> > -		if (isolated || !PageUnevictable(page))
> > +	if (folio_test_clear_mlocked(folio)) {
> > +		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
>
> AFAIK the 1:1 replacement would be __zone_stat_mod_folio(), this is stronger
> thus not causing a bug, but unneccessary?

I used this rather than __zone_stat_mod_folio() as this is what mlock_folio()
does and I wanted to maintain consistency with that function.

However, given we were previously user the weaker page version of this function,
I agree that we should do the same with the folio, will change!

>
> > +		if (isolated || !folio_test_unevictable(folio))
> >  			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
> >  		else
> >  			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
> >  	}
> >
> > -	/* page_evictable() has to be checked *after* clearing Mlocked */
> > -	if (isolated && PageUnevictable(page) && page_evictable(page)) {
> > -		del_page_from_lru_list(page, lruvec);
> > -		ClearPageUnevictable(page);
> > -		add_page_to_lru_list(page, lruvec);
> > +	/* folio_evictable() has to be checked *after* clearing Mlocked */
> > +	if (isolated && folio_test_unevictable(folio) && folio_evictable(folio)) {
> > +		lruvec_del_folio(lruvec, folio);
> > +		folio_clear_unevictable(folio);
> > +		lruvec_add_folio(lruvec, folio);
> >  		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
> >  	}
> >  out:
> >  	if (isolated)
> > -		SetPageLRU(page);
> > +		folio_set_lru(folio);
> >  	return lruvec;
> >  }
> >
> >  /*
> > - * Flags held in the low bits of a struct page pointer on the mlock_pvec.
> > + * Flags held in the low bits of a struct folio pointer on the mlock_fbatch.
> >   */
> >  #define LRU_PAGE 0x1
> >  #define NEW_PAGE 0x2
>
> Should it be X_FOLIO now?
>
> > -static inline struct page *mlock_lru(struct page *page)
> > +static inline struct folio *mlock_lru(struct folio *folio)
> >  {
> > -	return (struct page *)((unsigned long)page + LRU_PAGE);
> > +	return (struct folio *)((unsigned long)folio + LRU_PAGE);
> >  }
> >
> > -static inline struct page *mlock_new(struct page *page)
> > +static inline struct folio *mlock_new(struct folio *folio)
> >  {
> > -	return (struct page *)((unsigned long)page + NEW_PAGE);
> > +	return (struct folio *)((unsigned long)folio + NEW_PAGE);
> >  }
> >
> >  /*
> > - * mlock_pagevec() is derived from pagevec_lru_move_fn():
> > - * perhaps that can make use of such page pointer flags in future,
> > - * but for now just keep it for mlock.  We could use three separate
> > - * pagevecs instead, but one feels better (munlocking a full pagevec
> > - * does not need to drain mlocking pagevecs first).
> > + * mlock_folio_batch() is derived from folio_batch_move_lru(): perhaps that can
> > + * make use of such page pointer flags in future, but for now just keep it for
>
> 		       ^ folio?
>
> > + * mlock.  We could use three separate folio batches instead, but one feels
> > + * better (munlocking a full folio batch does not need to drain mlocking folio
> > + * batches first).
> >   */
> > -static void mlock_pagevec(struct pagevec *pvec)
> > +static void mlock_folio_batch(struct folio_batch *fbatch)
>

Ack on all remaining comments also, will spin a v4, thanks for the review!
