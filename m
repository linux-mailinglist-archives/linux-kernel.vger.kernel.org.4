Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD31748A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjGERYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjGERYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:24:08 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C02188
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:24:04 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57916e0badcso61367427b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577844; x=1691169844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHjvoo64g8hqR4hb9CfrVJyaF2fuw5Igy5Tcp1DXgn0=;
        b=UxvRl93OuANxiyXqhyXqCmP3i8b5MiWAFlpa+NkGqyp7Idba76W8Zi+pYaDuYc8QQF
         tpXpBKOQWeP4Jj2xp63wGWrjOd4zyUlRPhTbHr2unVBgGIU/ruEwEiVucvDbTdW6MrvD
         KjtcaaJSZWTFmn9jrVitGbjRJwCfra5ctoo1050hawVosrwe51cJAqB5NuG6QQob/d5P
         bnD/AS6wPoTYkovC1lf3GjAXyZ5Xi+kc0m1epLh3aUHr6BJMy+xZs79S5v2Q0hMgLSP5
         dNx/+zAc0HrJG9uD1lfdHtoyZquD1XibsyHsndmcWiqPSC8JvH2WG4E6M7jWRR9Tcj7X
         CgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577844; x=1691169844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHjvoo64g8hqR4hb9CfrVJyaF2fuw5Igy5Tcp1DXgn0=;
        b=DURK/YHpNbVvftWEZ6GTlMyT/zePHMPMFBgZNAIdRhewKnB9iqEPYOVyJr6k965lB2
         vZbyMXdxutqTfyGnY+8uWpsL+zMf8bwkG9LwRSyWmr2/NFp7F04QjqboPhWPz9wqAmls
         D8N+ABxPRv4E5zNSnqeNvTl3gpp7FqlZNADsexaLhBwyb57lBmu+jYzx43OhMXOaSTvE
         kdL7NPxsWxZXPqTzl+vUa5cgOl3OOaphTKJdD41zJbfgiOmHXcDjq71jtTEoS/FOk8dD
         dabhb17kdmO8Yw3kueeMTNWxq2fSsCScu++zidpMrBwuPBgfJihB7ZOYgrJVixXWXNa4
         91cA==
X-Gm-Message-State: ABy/qLaz7OdDMuBP1zhz3c4Fpgj4aaKBY/9vcw+knM0/o64GQKtqiTy9
        m3U4K4z2mefI/bTUG/siyNHt2ks5+DM8sKJsJVfijg==
X-Google-Smtp-Source: APBJJlEXr+7nJr1kglpTbDNE3cb0nSLMWuqSOLSYsZv8wiWSxoU7q9OpLPF0oSmE8g15pgbllX4DkKQIua5s0UK9uiQ=
X-Received: by 2002:a25:69cd:0:b0:c4e:c503:d5f6 with SMTP id
 e196-20020a2569cd000000b00c4ec503d5f6mr9299399ybc.64.1688577843719; Wed, 05
 Jul 2023 10:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-2-surenb@google.com>
 <10c8fe17-fa9b-bf34-cb88-c758e07c9d72@redhat.com>
In-Reply-To: <10c8fe17-fa9b-bf34-cb88-c758e07c9d72@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 10:23:52 -0700
Message-ID: <CAJuCfpFBh647trAjgPfr0Wcd=7V2gbHUnBe8mR4Pgdmrzh6Hxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fork: lock VMAs of the parent process when forking
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Wed, Jul 5, 2023 at 10:14=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > When forking a child process, parent write-protects an anonymous page
> > and COW-shares it with the child being forked using copy_present_pte().
> > Parent's TLB is flushed right before we drop the parent's mmap_lock in
> > dup_mmap(). If we get a write-fault before that TLB flush in the parent=
,
> > and we end up replacing that anonymous page in the parent process in
> > do_wp_page() (because, COW-shared with the child), this might lead to
> > some stale writable TLB entries targeting the wrong (old) page.
> > Similar issue happened in the past with userfaultfd (see flush_tlb_page=
()
> > call inside do_wp_page()).
> > Lock VMAs of the parent process when forking a child, which prevents
> > concurrent page faults during fork operation and avoids this issue.
> > This fix can potentially regress some fork-heavy workloads. Kernel buil=
d
> > time did not show noticeable regression on a 56-core machine while a
> > stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> > shows ~5% regression. If such fork time regression is unacceptable,
> > disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> > optimizations are possible if this regression proves to be problematic.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51=
b@kernel.org/
> > Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34=
c@applied-asynchrony.com/
> > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling fi=
rst")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   kernel/fork.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index b85814e614a5..403bc2b72301 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struct mm_str=
uct *mm,
> >               retval =3D -EINTR;
> >               goto fail_uprobe_end;
> >       }
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /* Disallow any page faults before calling flush_cache_dup_mm */
> > +     for_each_vma(old_vmi, mpnt)
> > +             vma_start_write(mpnt);
> > +     vma_iter_init(&old_vmi, oldmm, 0);
> > +#endif
> >       flush_cache_dup_mm(oldmm);
> >       uprobe_dup_mmap(oldmm, mm);
> >       /*
>
> The old version was most probably fine as well, but this certainly looks
> even safer.
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>
