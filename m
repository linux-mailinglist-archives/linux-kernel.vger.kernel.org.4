Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1B74003A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjF0QAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjF0QAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:00:32 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2592D63
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:00:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bfee679b7efso4636378276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687881630; x=1690473630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KkJfMIW232ztzAZaUdoyK+3frIKBC3oUzLc/0KyY7g=;
        b=TSmneStqHeW3vCGRSk9XN9K/xAOpUNp9Vt2idzhSed8Jk+sSOVzUMYMfK5RbQI1ezV
         xCcyNw+2DbcLe4wWwb+sZrHHbbktJgcRITbuZtz6oydu/tUcvwox4YrknRwXpzAlmJOP
         orSU/BHf8zwqMob8Lmjh+Rk+lPb7uV7/TsKfBFQo78u+j2lducnvRLXzqme6BAOSma7C
         wm+yNe+rT3S/dvG2NXgwRWysJw6pZHxyQcFfsx8v6zz6MvXxzLTh6RSn3eg7C+0+NnyJ
         KA9VLZ5YOphRWjJmhl7NlekRjYrHPsGQNPRy+HRTD3mtoTXAsOZc7Mn6GtWgZTBQ0Ohc
         Dgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687881630; x=1690473630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KkJfMIW232ztzAZaUdoyK+3frIKBC3oUzLc/0KyY7g=;
        b=DJ8X11jSDZ02ILqpNSBHwNXZK63TOiN9Ul8sMUCRYomO1oMBFR083d9seCjgdYYzML
         cc6J/t0R4Lsdb7Z5xxYm+mdk7c/AP4mR5sbJHslrwU/7hOodU+OUQ7k3eLxQh19lkbCu
         HOH6dRzgaiEWy2Ez09MTaLYLcHY0EX1536tu4bTfardtRcp1Q1d0cUkp2EDMl5bPkNvj
         przB4bgeR/+nT1CaqFy/oh4ajhfPmwJEEHindDtptyzr0eogOwT+WFvIGPOU28sbe7sn
         4MYDJxTPpGKvVruehARK7Vf8wuREr3diVE8YYFzsaiJldG2hARdyTFjYf3+95qQ9wnr4
         pzVQ==
X-Gm-Message-State: AC+VfDwBsjY2NR8t40ONFdFCPs9HUTaDKHfngVY4pPX+7TXCmPz8adbm
        T5MHQSehRaFNWsqe4AfDoSr91T6LRwlDHKVyOO6BxA==
X-Google-Smtp-Source: ACHHUZ4+7sbj81UsRHmAbl9QlYt7ZZmVqNsMLkZDz17Ve/pdy6A0enKOXhe8I1iDZXgOZeytbthoVeE93RHK/qCLMik=
X-Received: by 2002:a25:ca0b:0:b0:ba1:ce0d:a076 with SMTP id
 a11-20020a25ca0b000000b00ba1ce0da076mr30559075ybg.43.1687881630048; Tue, 27
 Jun 2023 09:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-6-surenb@google.com>
 <ZJsBEk4OHlp39vEK@x1n>
In-Reply-To: <ZJsBEk4OHlp39vEK@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 09:00:18 -0700
Message-ID: <CAJuCfpEdBtLo0iaAyKh0Ok_DqEGLkRaVGNxpteki7tkr7+kdJg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] mm: make folio_lock_fault indicate the state of
 mmap_lock upon return
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Tue, Jun 27, 2023 at 8:32=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 26, 2023 at 09:23:18PM -0700, Suren Baghdasaryan wrote:
> > folio_lock_fault might drop mmap_lock before returning and to extend it
> > to work with per-VMA locks, the callers will need to know whether the
> > lock was dropped or is still held. Introduce new fault_flag to indicate
> > whether the lock got dropped and store it inside vm_fault flags.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm_types.h | 1 +
> >  mm/filemap.c             | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 79765e3dd8f3..6f0dbef7aa1f 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1169,6 +1169,7 @@ enum fault_flag {
> >       FAULT_FLAG_UNSHARE =3D            1 << 10,
> >       FAULT_FLAG_ORIG_PTE_VALID =3D     1 << 11,
> >       FAULT_FLAG_VMA_LOCK =3D           1 << 12,
> > +     FAULT_FLAG_LOCK_DROPPED =3D       1 << 13,
> >  };
> >
> >  typedef unsigned int __bitwise zap_flags_t;
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 87b335a93530..8ad06d69895b 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1723,6 +1723,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio=
, struct vm_fault *vmf)
> >                       return VM_FAULT_RETRY;
> >
> >               mmap_read_unlock(mm);
> > +             vmf->flags |=3D FAULT_FLAG_LOCK_DROPPED;
> >               if (vmf->flags & FAULT_FLAG_KILLABLE)
> >                       folio_wait_locked_killable(folio);
> >               else
> > @@ -1735,6 +1736,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio=
, struct vm_fault *vmf)
> >               ret =3D __folio_lock_killable(folio);
> >               if (ret) {
> >                       mmap_read_unlock(mm);
> > +                     vmf->flags |=3D FAULT_FLAG_LOCK_DROPPED;
> >                       return VM_FAULT_RETRY;
> >               }
> >       } else {
>
> IIRC we've discussed about this bits in previous version, and the consens=
us
> was that we don't need yet another flag?  Just to recap: I think relying =
on
> RETRY|COMPLETE would be enough for vma lock, as NOWAIT is only used by gu=
p
> while not affecting vma lockings, no?

Sorry for missing that point. I focused on making VMA locks being
dropped for RETRY|COMPLETE and forgot to check after that change if
RETRY|COMPLETE is enough indication to conclude that VMA lock is
dropped. Looking at that now, I'm not sure that would be always true
for file-backed page faults (including shmem_fault()), but we do not
handle them under VMA locks for now anyway, so this indeed seems like
a safe assumption. When Matthew implements file-backed support he
needs to be careful to ensure this rule still holds. With your
suggestions to drop the VMA lock at the place where we return RETRY
this seems to indeed eliminate the need for FAULT_FLAG_LOCK_DROPPED
and simplifies things. I'll try that approach and see if anything
blows up.

>
> As mentioned in the other reply, even COMPLETE won't appear for vma lock
> path yet afaict, so mostly only RETRY matters here and it can 100% imply =
a
> lock release happened.  It's just that it's very easy to still cover
> COMPLETE altogether in this case, being prepared for any possible shared
> support on vma locks, IMHO.

Yes and I do introduce one place where we use COMPLETE with VMA locks,
so will cover it the same way as for RETRY.
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>
