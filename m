Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D976E8064
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjDSRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjDSRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:30:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1774F4EE3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:30:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz19so272785ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681925408; x=1684517408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwrZY0pgCdzEc7aFEGuhclWzcw83alOrnGULAtMEf8k=;
        b=WGyvoSa4PiiAL6SnZPfK97mFYuzHCsMkjUabO80rr7uE12CeVQVuqbarRk/9PcMee8
         zVkKT++wRDnI/eYzeAAhx4Dyn7cnTfGm/SQJKKEym4zBFHKihTC7iswHm/l6OWYaYg1x
         vxxRAsdE8mArXUOAytdYBin/OC5oA+mhRCqlkxQrRyaKSqRdbj/ORqm8pE9FPJ6cTgpE
         O45PNVhv72BF93MTYhwDPaKFgriVMH3y7Wr9KrWppDUuwaHcYMrslZFeH652/+sazl5m
         vpgZIY7QEi3fwxwcZsl6u9x0Pucz1sBn8lhMgLAJyRC08oDwkjee4RP2JmOR2vYaqwcU
         xjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681925408; x=1684517408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwrZY0pgCdzEc7aFEGuhclWzcw83alOrnGULAtMEf8k=;
        b=E0RpW33ww0lvjb5xGdI/B2CHPXIRP6mVbbyapKcE+MHI/SaX863+zUWcM8SvQFMj6J
         MQ7oJPstMQGYtjQnHfd2OVlYUCPSoIf0cisTM+L2QmfaithhuPllqyU0Is0ser02IGUk
         3beGe4g27mTqG8Ie2VT6k/TdEMQnvHhH3dZZMQ1Ox3UZKUxQBVV8sNP1rN4LNhDNNUsU
         ZaPDJbXrXqB/askrNtMgDhNXp5cM0g6F97aW83iFceQE54exBpLVKW7XcsGhT9h8iF1q
         M+XSZpYmbPDcyoe2oku/iryk9wHdPlxGL8mxuoU+JtBWxFF2xP4uh8x+6URfZKeQ+Mij
         KkHA==
X-Gm-Message-State: AAQBX9fCT2CYndhUZa53fYzU0M/zOMBKQAWAnlKTYxPnbFMZ0Utlodm4
        Bb0ocB6pPp8pKsh+T+27+cLmVisI+RffziTHpo11+g==
X-Google-Smtp-Source: AKy350bWQHHd6Tx3nuTtYCGYg3TYinENAeNOxLAWyW6t6uMKf07bzLM4g41t9XFsZsLVN8UvY/1YXzsaQBKxpXXVKE8=
X-Received: by 2002:a17:907:7d9e:b0:94f:8f46:b286 with SMTP id
 oz30-20020a1709077d9e00b0094f8f46b286mr4500836ejc.15.1681925408411; Wed, 19
 Apr 2023 10:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <e6cd1f1e-e54c-87ae-ed23-cc1eca26837c@quicinc.com>
 <20230418172942.740769-1-fvdl@google.com> <4b8b370b-fc8e-0c5f-910d-552ccebf0e08@quicinc.com>
In-Reply-To: <4b8b370b-fc8e-0c5f-910d-552ccebf0e08@quicinc.com>
From:   Frank van der Linden <fvdl@google.com>
Date:   Wed, 19 Apr 2023 10:29:57 -0700
Message-ID: <CAPTztWYkB45M=8z97VvM2H1M6GbQkZZFjFW0izYQKCUZsCjmiA@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, we can add a separate thread. I can send a more formal version
of my quick diff (one that has actually been tested more thoroughly)
to kick it off.

Basically, using madvise() would work, but then I realized you'd have
to first explicitly map all regions and touch them to get them in your
page table, after which you then call MADV_PAGEOUT to get rid of them
again. Which is just .. silly :)

- Frank

On Wed, Apr 19, 2023 at 7:39=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Hi Frank,
>
> Lets start a separate thread to add the support for mapped pages. I
> think one question that can come while review is: "what is the overhead
> an application has in collecting the memory regions and issuing the
> MADV_PAGEOUT, that made to add this support?". Let me try to get details
> for this from my side too.
>
> BTW, thanks for this POC code!!
>
> Thanks,
> Charan
>
> On 4/18/2023 10:59 PM, Frank van der Linden wrote:
> > Below is a quick patch to allow FADVISE_DONTNEED for shmem to reclaim
> > mapped pages too. This would fit our usecase, and matches MADV_PAGEOUT
> > more closely.
> >
> > The patch series as posted skips mapped pages even if you remove
> > the folio_mapped() check, because page_referenced() in
> > shrink_page_list() will find page tables with the page mapped,
> > and ignore_references is not set when called from reclaim_pages().
> >
> > You can make this work in a similar fashion to MADV_PAGEOUT by
> > first unmapping a page, but only if the mapping belongs to
> > the caller. You just have to change the check for "is there
> > only one mapping and am I the owner". To do that, change a few
> > lines in try_to_unmap to allow for checking the mm the mapping
> > belongs to, and pass in current->mm (NULL still unmaps all mappings).
> >
> > I lightly tested this in a somewhat older codebase, so the diff
> > below isn't fully tested. But if there are no objections to
> > this approach, we could add it on top of your patchset after
> > better testing.
> >
> > - Frank
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index b87d01660412..4403cc2ccc4c 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -368,6 +368,8 @@ int folio_referenced(struct folio *, int is_locked,
> >
> >  void try_to_migrate(struct folio *folio, enum ttu_flags flags);
> >  void try_to_unmap(struct folio *, enum ttu_flags flags);
> > +void try_to_unmap_mm(struct mm_struct *mm, struct folio *folio,
> > +                     enum ttu_flags flags);
> >
> >  int make_device_exclusive_range(struct mm_struct *mm, unsigned long st=
art,
> >                               unsigned long end, struct page **pages,
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 8632e02661ac..4d30e8f5afe2 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1443,6 +1443,11 @@ void page_remove_rmap(struct page *page, struct =
vm_area_struct *vma,
> >       munlock_vma_folio(folio, vma, compound);
> >  }
> >
> > +struct unmap_arg {
> > +     enum ttu_flags flags;
> > +     struct mm_struct *mm;
> > +};
> > +
> >  /*
> >   * @arg: enum ttu_flags will be passed to this argument
> >   */
> > @@ -1455,7 +1460,11 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >       struct page *subpage;
> >       bool anon_exclusive, ret =3D true;
> >       struct mmu_notifier_range range;
> > -     enum ttu_flags flags =3D (enum ttu_flags)(long)arg;
> > +     struct unmap_arg *uap =3D (struct unmap_arg *)arg;
> > +     enum ttu_flags flags =3D uap->flags;
> > +
> > +     if (uap->mm && uap->mm !=3D mm)
> > +             return true;
> >
> >       /*
> >        * When racing against e.g. zap_pte_range() on another cpu,
> > @@ -1776,6 +1785,7 @@ static int folio_not_mapped(struct folio *folio)
> >
> >  /**
> >   * try_to_unmap - Try to remove all page table mappings to a folio.
> > + * @mm: mm to unmap from (NULL to unmap from all)
> >   * @folio: The folio to unmap.
> >   * @flags: action and flags
> >   *
> > @@ -1785,11 +1795,16 @@ static int folio_not_mapped(struct folio *folio=
)
> >   *
> >   * Context: Caller must hold the folio lock.
> >   */
> > -void try_to_unmap(struct folio *folio, enum ttu_flags flags)
> > +void try_to_unmap_mm(struct mm_struct *mm, struct folio *folio,
> > +             enum ttu_flags flags)
> >  {
> > +     struct unmap_arg ua =3D {
> > +             .flags =3D flags,
> > +             .mm =3D mm,
> > +     };
> >       struct rmap_walk_control rwc =3D {
> >               .rmap_one =3D try_to_unmap_one,
> > -             .arg =3D (void *)flags,
> > +             .arg =3D (void *)&ua,
> >               .done =3D folio_not_mapped,
> >               .anon_lock =3D folio_lock_anon_vma_read,
> >       };
> > @@ -1800,6 +1815,11 @@ void try_to_unmap(struct folio *folio, enum ttu_=
flags flags)
> >               rmap_walk(folio, &rwc);
> >  }
> >
> > +void try_to_unmap(struct folio *folio, enum ttu_flags flags)
> > +{
> > +     try_to_unmap_mm(NULL, folio, flags);
> > +}
> > +
> >  /*
> >   * @arg: enum ttu_flags will be passed to this argument.
> >   *
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 1af85259b6fc..b24af2fb3378 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2362,8 +2362,24 @@ static void shmem_isolate_pages_range(struct add=
ress_space *mapping, loff_t star
> >
> >               if (!folio_try_get(folio))
> >                       continue;
> > -             if (folio_test_unevictable(folio) || folio_mapped(folio) =
||
> > -                             folio_isolate_lru(folio)) {
> > +
> > +             if (folio_test_unevictable(folio)) {
> > +                     folio_put(folio);
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * If the folio is mapped once, try to unmap it from the
> > +              * caller's page table. If it's still mapped afterwards,
> > +              * it belongs to someone else, and we're not going to
> > +              * change someone else's mapping.
> > +              */
> > +             if (folio_mapcount(folio) =3D=3D 1 && folio_trylock(folio=
)) {
> > +                     try_to_unmap_mm(current->mm, folio, TTU_BATCH_FLU=
SH);
> > +                     folio_unlock(folio);
> > +             }
> > +
> > +             if (folio_mapped(folio) || folio_isolate_lru(folio)) {
> >                       folio_put(folio);
> >                       continue;
> >               }
> > @@ -2383,6 +2399,8 @@ static void shmem_isolate_pages_range(struct addr=
ess_space *mapping, loff_t star
> >               }
> >       }
> >       rcu_read_unlock();
> > +
> > +     try_to_unmap_flush();
> >  }
> >
> >  static int shmem_fadvise_dontneed(struct address_space *mapping, loff_=
t start,
