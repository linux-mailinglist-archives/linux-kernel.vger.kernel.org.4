Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7226671AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjALMHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjALMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:06:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C40559F1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:01:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z5so16791461wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WT7VEidhNV2omGBYhLrUDOURbROFBE8pJSOw9tEWNg=;
        b=mnYTsyv1rGsyTK2QOVe9k5ieQnSkp7eYAEN7ZnH2LkI3aFDlY2tpzMT1HZQIb8UP3K
         6TwHK977eVdxBtMtu5rw93XY5t9zqLD6r7ZESxBKFfs2prjCoMkE2LgCCQrSlAuvTN0T
         iVOVvA1s5itKF/U0Dp4VP6sHooqEKWyP3majEjmPeLN2W/n0CDBRaCZxRjat+OVfmpuK
         irsPdsEmoDUyhqgvOOm8vxGaHPb/vBCPPO2IWEg0bqz4tv6vqsLnXvo1g1KZU9ZoJMz9
         Sv87Lkg+rK8f1vV9hEOODp8aj0A5d3dC69qOiCjjHG8FAhjdA0hyeFO+cFqVtZ0E1FYz
         FJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WT7VEidhNV2omGBYhLrUDOURbROFBE8pJSOw9tEWNg=;
        b=6syG7hS86p6dlM5dIKMX2VcNLide4o5yEG42vFjrvrD574ZCYQELa7hNe1mzZOBTh5
         v4dlV4omh+7JXLYh5nuQr0sPebKmVuYS2gKQcY7qXQ0TAA03Ai72sMQYhwTqnvSa+BZQ
         TzQ3+mlnVPzfmEyIBnK7FiRzJlQspSQeKweM1GLEPd+XA8QF5IhGKTAuEaNo62r4tEs2
         WcZ2Clw0Qt5+Q/eajWDQAln8JKUDp72zyjjReZItkZR9nb7RnzbXfeLxrtGhO2X1GQjH
         09032l6IKMeBOtR5gZ9Yov24p51sFdzBe3slJzPSuJwQqsdJCMOP3xSGwWtAZmtRDIFq
         93vw==
X-Gm-Message-State: AFqh2kpqUh3QPOj4sitY1FKfGtff8tQ1+Z+8KilYapdp/DFV4fhBX7hP
        uu8VKYSuK0uu3LuXwD71VMM=
X-Google-Smtp-Source: AMrXdXt3goV8FsMG6U3iFuBWXTkhiCO0BCOS7Hw4Vtb/2tQiGYhprzWZdUm9TbwUt/CEU1C5LoLSpw==
X-Received: by 2002:a5d:5747:0:b0:2bd:beac:ef7b with SMTP id q7-20020a5d5747000000b002bdbeacef7bmr5982944wrw.52.1673524907228;
        Thu, 12 Jan 2023 04:01:47 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm16508537wrj.94.2023.01.12.04.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:01:46 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:01:45 +0000
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
Subject: Re: [PATCH v3 4/5] mm: mlock: update the interface to use folios
Message-ID: <Y7/2qWIubRTDPGAu@lucifer>
References: <cover.1672043615.git.lstoakes@gmail.com>
 <c6555463e07cfe6e68c229ed9b8051f98a884388.1672043615.git.lstoakes@gmail.com>
 <50cc1bfc-6cee-dc98-7ed9-cc3f0c863c02@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50cc1bfc-6cee-dc98-7ed9-cc3f0c863c02@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:55:13AM +0100, Vlastimil Babka wrote:
> On 12/26/22 09:44, Lorenzo Stoakes wrote:
> > This patch updates the mlock interface to accept folios rather than pages,
> > bringing the interface in line with the internal implementation.
> >
> > munlock_vma_page() still requires a page_folio() conversion, however this
> > is consistent with the existent mlock_vma_page() implementation and a
> > product of rmap still dealing in pages rather than folios.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> With some suggestion:
>
> > ---
> >  mm/internal.h | 26 ++++++++++++++++----------
> >  mm/mlock.c    | 32 +++++++++++++++-----------------
> >  mm/swap.c     |  2 +-
> >  3 files changed, 32 insertions(+), 28 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 1d6f4e168510..8a6e83315369 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -515,10 +515,9 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> >   * should be called with vma's mmap_lock held for read or write,
> >   * under page table lock for the pte/pmd being added or removed.
> >   *
> > - * mlock is usually called at the end of page_add_*_rmap(),
> > - * munlock at the end of page_remove_rmap(); but new anon
> > - * pages are managed by lru_cache_add_inactive_or_unevictable()
> > - * calling mlock_new_page().
> > + * mlock is usually called at the end of page_add_*_rmap(), munlock at
> > + * the end of page_remove_rmap(); but new anon folios are managed by
> > + * folio_add_lru_vma() calling mlock_new_folio().
> >   *
> >   * @compound is used to include pmd mappings of THPs, but filter out
> >   * pte mappings of THPs, which cannot be consistently counted: a pte
> > @@ -547,15 +546,22 @@ static inline void mlock_vma_page(struct page *page,
> >  	mlock_vma_folio(page_folio(page), vma, compound);
> >  }
> >
> > -void munlock_page(struct page *page);
> > -static inline void munlock_vma_page(struct page *page,
> > +void munlock_folio(struct folio *folio);
> > +
> > +static inline void munlock_vma_folio(struct folio *folio,
> >  			struct vm_area_struct *vma, bool compound)
> >  {
> >  	if (unlikely(vma->vm_flags & VM_LOCKED) &&
> > -	    (compound || !PageTransCompound(page)))
> > -		munlock_page(page);
> > +	    (compound || !folio_test_large(folio)))
> > +		munlock_folio(folio);
> > +}
> > +
> > +static inline void munlock_vma_page(struct page *page,
> > +			struct vm_area_struct *vma, bool compound)
> > +{
> > +	munlock_vma_folio(page_folio(page), vma, compound);
> >  }
> > -void mlock_new_page(struct page *page);
> > +void mlock_new_folio(struct folio *folio);
> >  bool need_mlock_page_drain(int cpu);
> >  void mlock_page_drain_local(void);
> >  void mlock_page_drain_remote(int cpu);
>
> I think these drain related functions could use a rename as well?
> Maybe replace "page" with "fbatch" or "folio_batch"? Even the old name isn't
> great, should have been "pagevec".

Agreed, though I feel it's more readable if we just drop this bit altogether,
which is also more consistent with the core batch drain functions like
e.g. lru_add_drain().

In this case we'd go to need_mlock_drain(), mlock_drain_local() and
mlock_drain_remote().

> But maybe it would fit patch 2/5 rather than 4/5 as it's logically internal
> even if in a .h file.
>
>

Even though it is an internal interface across the board I feel like it makes
the patch series a little easier to read keeping this separate, so I think it
makes sense to keep it here so we can have a separation between
internal-to-mlock changes vs. internal-to-mm ones :)
