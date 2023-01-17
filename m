Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5313670E11
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjAQXwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAQXvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:51:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36F07572E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:01:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s21so3058592edi.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36ojNrGFeLlO1WRePHzVkOKkUUAt+mzyuzgpCW6PfVQ=;
        b=jaENkkvKRPa/iJ4S60jFT8yAwmEyoPQlMWJNJ7EzqWGC+3vb+MJp6NKWHSK8JfZ+rt
         CLjgK6fHyYjB0MJznyvWCSLjfcIYVpoSWp4bhJyCMXHTJ4XsXfk+ptd2OpscHNGfmMhu
         MouGs4GP5Op8L/PuwT2YF9+S9w8YlnjcSehWgqvBMVQFDoUMR2JqqnCfmnrqN4zpZsEO
         YJCdFF3fHlTdk4dlz0/I0mBGONaEezELtG1D/Lg9BtAJC9dt8zQsPPNCg6mn15OdSIAz
         HwYhSUqyzEcxgQdmbPWSajo9Y1yhX6HpGnDZnKxqtXP7MB3wmnWMjdHP2hyVbp9lRJn+
         AOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36ojNrGFeLlO1WRePHzVkOKkUUAt+mzyuzgpCW6PfVQ=;
        b=twoIlYADKCuVeyYyCXS5Y9YFwKvUZbn1p5Y54ZuPHpllLd4Dx474pTkG2BiuXlyc1I
         LTGhpypLm+PAIVDPC98gDqyus7zXdTLGlq5eqwgjrxkFy7Ok2DTNB67SmHINRDf/aAQ4
         Ic90XWv8hyCjDJA6NJjfw5tRLnvS1OQhfH+S2Cr58Msf0k9ChEBLC26In+P1gyf0EHJd
         7aoE8wPjJLn5IINPLZMXTwqH0ggTPIM9+9zZ//Pt4HkeUdKoto8mWNyFwcMvL+4bRo94
         fBSGpmguFLPp6dKqGD+vFzBsk5quAP9ljSy+YNTNzN/TynPU+APtSeMjiaFg6MzJPmEK
         qVbQ==
X-Gm-Message-State: AFqh2kqMulx977ddf+mnT4gPm4Ifn2qu7ragfY5UYl9I2pz3SihREX7u
        aESYOcUiMRFGqdAlBg0g1ElBrk5s/3ik+Yo9zORkmQ==
X-Google-Smtp-Source: AMrXdXsGqLZTAXgdag+HHZacewzf5CT33O5WG5+Gy6NMYX06iOrS3y2ryIkO3mO8fcLcm9Kc17Q8hcS3vt42FRZ1e/I=
X-Received: by 2002:aa7:db98:0:b0:49e:160c:e9b0 with SMTP id
 u24-20020aa7db98000000b0049e160ce9b0mr502864edt.425.1673996468046; Tue, 17
 Jan 2023 15:01:08 -0800 (PST)
MIME-Version: 1.0
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
 <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com> <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
 <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com> <CAHbLzkqjooxnAwqK7vZoJpP2bSUTCUgv3UtWsZgo444jpGSfoA@mail.gmail.com>
 <86d5f618-800d-9672-56c4-9309ef222a39@redhat.com> <CAAa6QmSByYrWkp+8K0NK+pocKT0CVj83RaVUB1VqMPvuPHnpNQ@mail.gmail.com>
 <d50eb6f2-0585-7441-081b-cadaa5901c6e@redhat.com>
In-Reply-To: <d50eb6f2-0585-7441-081b-cadaa5901c6e@redhat.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Tue, 17 Jan 2023 15:00:30 -0800
Message-ID: <CAAa6QmR6KeCCMHGyR9jkwk-KCwb_FTcEfnKeHRJ2U7+3SVz7hg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow anon_vma
To:     David Hildenbrand <david@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 12:50 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>>>>>
> >>>>>> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
> >>>>>> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
> >>>>>> writable or not. Turns out it's communicated via vm_fault->flags. Just
> >>>>>> horrible.
> >

Hey David,

Sorry for the late response here.

> > My first Linux award! :) At least it's not "worst mm security issue of
> > early 2023". I'll take it!
>
> Good that you're not taking my words the wrong way.
>
> MADV_COLLAPSE is a very useful feature (especially also for THP tests
> [1]). I wish I could have looked at some of the patches earlier. But we
> cannot wait forever to get something merged, otherwise we'd never get
> bigger changes upstream.
>
> ... so there is plenty of time left in 2023 to cleanup khugepaged.c :P
>
>
> [1] https://lkml.kernel.org/r/20230104144905.460075-1-david@redhat.com

Yes, thank you for these tests. I have them open in another tab along
with a mental TODO to take a closer look at them, and response
half-written. In-place collapse of anonymous memory *is* something
that I was interested in exploring later (I have a use-case for it;
hugepage-aware malloc() implementations). I'm taking so long on it
(sorry) b/c I need to review your point (2) (all PTE's mapping
exclusively). Hopefully I can get to it shortly.

> [...]
>
>
> >> For example: why even *care* about the complexity of installing a PMD in
> >> collapse_pte_mapped_thp() using set_huge_pmd() just for MADV_COLLAPSE?
> >>
> >> Sure, we avoid a single page fault afterwards, but is this *really*
> >> worth the extra code here? I mean, after we installed the PMD, the page
> >> could just get reclaimed either way, so there is no guarantee that we
> >> have a PMD mapped once we return to user space IIUC.
> >
> > A valid question. The first reason is just semantic symmetry for
> > MADV_COLLAPSE called on anon vs file/shmem memory. It would be nice to
> > say that "on success, the memory range provided will be backed by
> > PMD-mapped hugepages", rather than special-casing file/shmem.
>
> But there will never be such a guarantee, right? We could even see a
> split before just before we return to user space IIRC.

Absolutely. But at least we are *attempting* for symmetry here; though
admittedly, even a successful return code provides no guarantees.
Perhaps this is a weak argument by itself, though.

> >
> > The second reason has a more practical use case. In userfaultfd-based
> > live migration (using  UFFDIO_REGISTER_MODE_MINOR) pages are migrated
> > at 4KiB granularity, and it may take a long (O(many minutes)) for the
> > transfer of all pages to complete. To avoid severe performance
> > degradation on the target guest, the vmm wants to MADV_COLLAPSE
> > hugepage-sized regions as they fill up. Since the guest memory is
> > still uffd-registered, requiring refault post-MADV_COLLAPSE won't
> > work, since the uffd machinery will intercept the fault, and no PMD
> > will be mapped. As such, either uffd needs to be taught to install PMD
> > mappings, or the PMD mapping already must be in-place.
>
> That's an interesting point, thanks. I assume we'd get another minor
> fault and when resolving that, we'll default to a PTE mapping.

Yes-ish; I think it depends on how userspace decides to deal with the
event. At least in my own test cases, IIRC (hazy memory here), we
ended up in some loop of:

done faulting all 512 pages -> MADV_COLLAPSE -> fault -> copy page ->
done faulting all 512 pages -> ...

Thanks,
Zach


> --
> Thanks,
>
> David / dhildenb
>
