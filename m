Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB686675E38
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjATTmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:42:03 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837817AF3B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:42:02 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d62so8024628ybh.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJXjzCz8fwccFR5pEYGjnOVdmTlZYZXx11UuoskxirY=;
        b=AOsKDcCpwexXxoMD1FR0+kL2bS8FutMlWBrqCWiLakmDhRA7kT7q3xpcn4ezeVvoUr
         6yk4BiycrjHTBNZhL2PNu54LJOH3ypMkWObXh2xmeF9+JwpO+GvneJUWwIdxfXE/8Hq9
         RVns7CQAqTHUEor8ZufiJLhAalW6fTs4b2c0B4SbO7xaXau0sesS0Nz/8fdZmombKFgZ
         F9HpGNszB4+/0x1JyGfL33jtirU4PwG0QDHySrYi3E8LnFTm0aUYGogbNz4I0/eNMx3A
         ZbfsWBHXVyh+cIgdqp/CBAGLnckdnK5X3wAcF6fdU2qOlRBlCzQ50rN0/m3nqZd5R08j
         KB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJXjzCz8fwccFR5pEYGjnOVdmTlZYZXx11UuoskxirY=;
        b=NyeylVaE0/KLVJ88J7mz50Gos6thf86LSqOfepwZIfSE8iaRfuwoPgjHddFpDIkHT4
         10rf88g+aeiPB7FQ79Q7f44no9Llk1oqf/VLaX528WxLBTCUppLPoChDFjZkvSPzjC0I
         ruCiwVkm6qnIa5sQOKrWhzikqAyIUwa/5HPlDnz0lB9qihhWkD+FFVEZSzgqywvQ92TL
         KXJ0300HkBzaiHK7Gja9sjuMqZncGZtb+U6tUfijbbNwBY/HnWbBPWV9YSY+51Fb7aNn
         VwuERvcG2SjKCyM4evs3YcOkVg9BIAFzDsgUjLRwnwhqdjAVBqSXFRSETQWFWslKCaH2
         BIBQ==
X-Gm-Message-State: AFqh2kqACJL3JTJKfv85A41h3TFvcsLYyNubBEL1YgytBjYcsTYMliwO
        NtPCkEn73o9UFm23nqsGkWUuz51dSlU0VDP+rTQMpwaZ
X-Google-Smtp-Source: AMrXdXtV2nvP9ODdtq7+R8htE166Bc+fKuVFvksRO3iv2Nsa96D0DbNrSKBBDDtUh4ye2J5j2w4A9qgn79onlKjX2Wc=
X-Received: by 2002:a25:eb10:0:b0:764:2d1e:4345 with SMTP id
 d16-20020a25eb10000000b007642d1e4345mr1911310ybs.551.1674243721515; Fri, 20
 Jan 2023 11:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20230118232219.27038-1-vishal.moola@gmail.com>
 <20230118232219.27038-6-vishal.moola@gmail.com> <4dd1a4f4-4da6-8079-a8de-bea7d8c18681@intel.com>
In-Reply-To: <4dd1a4f4-4da6-8079-a8de-bea7d8c18681@intel.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Fri, 20 Jan 2023 11:41:50 -0800
Message-ID: <CAOzc2pxe-k_ZbC9tiogR8FYCORA48H3Y51_gTEAfewa5mFfOzg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 5/5] mm/mempolicy: Convert migrate_page_add()
 to migrate_folio_add()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 5:24 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>
>
>
> On 1/19/2023 7:22 AM, Vishal Moola (Oracle) wrote:
> > Replace migrate_page_add() with migrate_folio_add().
> > migrate_folio_add() does the same a migrate_page_add() but takes in a
> > folio instead of a page. This removes a couple of calls to
> > compound_head().
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/mempolicy.c | 34 +++++++++++++++-------------------
> >  1 file changed, 15 insertions(+), 19 deletions(-)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 0a3690ecab7d..253ce368cf16 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -414,7 +414,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
> >       },
> >  };
> >
> > -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> > +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
> >                               unsigned long flags);
> >
> >  struct queue_pages {
> > @@ -476,7 +476,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> >       /* go to folio migration */
> >       if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> >               if (!vma_migratable(walk->vma) ||
> > -                 migrate_page_add(&folio->page, qp->pagelist, flags)) {
> > +                 migrate_folio_add(folio, qp->pagelist, flags)) {
> >                       ret = 1;
> >                       goto unlock;
> >               }
> > @@ -544,7 +544,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
> >                        * temporary off LRU pages in the range.  Still
> >                        * need migrate other LRU pages.
> >                        */
> > -                     if (migrate_page_add(&folio->page, qp->pagelist, flags))
> > +                     if (migrate_folio_add(folio, qp->pagelist, flags))
> >                               has_unmovable = true;
> >               } else
> >                       break;
> > @@ -1022,27 +1022,23 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
> >  }
> >
> >  #ifdef CONFIG_MIGRATION
> > -/*
> > - * page migration, thp tail pages can be passed.
> > - */
> > -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> > +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
> >                               unsigned long flags)
> >  {
> > -     struct page *head = compound_head(page);
> >       /*
> > -      * Avoid migrating a page that is shared with others.
> > +      * Avoid migrating a folio that is shared with others.
> >        */
> > -     if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
> > -             if (!isolate_lru_page(head)) {
> > -                     list_add_tail(&head->lru, pagelist);
> > -                     mod_node_page_state(page_pgdat(head),
> > -                             NR_ISOLATED_ANON + page_is_file_lru(head),
> > -                             thp_nr_pages(head));
> > +     if ((flags & MPOL_MF_MOVE_ALL) || folio_mapcount(folio) == 1) {
> One question to the page_mapcount -> folio_mapcount here.
>
> For a large folio with 0 entire mapcount, if the first sub-page and any
> other sub-page are mapped, page_mapcount(head) == 1 is true while
> folio_mapcount(folio) == 1 is not.

Hmm, you're right. Using page_mapcount(&folio->page) would definitely
maintain the same behavior, but I'm not sure that's what we actually want.

My understanding of the purpose of this check is to avoid migrating
pages shared with other processes. Meaning if a folio (or any pages
within) are mapped to different processes we would want to skip that
folio.

Although looking at it now, I don't think using folio_mapcount()
accomplishes this either in the case that multiple pages in a large
folio are mapped to the same process.

Does anyone have any better ideas for this?
