Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB641738A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjFUQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFUQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:08:48 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE7170C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:08:34 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-55af44f442dso4053620eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687363714; x=1689955714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYeghwLJr3eeZVSf92WTHbW6kPAlj9yXHnGi0sHDypU=;
        b=MhNcQI5MOADt15GCiHEO7GsmtjxNzjczpjMuNbwOqeInmGYTx6fW/634bGd1LaJ4Ky
         +/gtDS7TMyydtY2P1MxHV16TpQNjYmVehX6TBpq+YMLXZdCQjH195v51+Ga3owK5l6LN
         w9V61439DewhQiQQN42zQ4i//U6Ho6EiHCMNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363714; x=1689955714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYeghwLJr3eeZVSf92WTHbW6kPAlj9yXHnGi0sHDypU=;
        b=dANDm4RkEqzk+2HqPcgjrf3yw1p0kiAuEcjL/B+1gnvE7mkKhZdiM/c1VLCZz7Wqhi
         9j5ydJFZ+UoTdjqoraalCEtexQGFKdwXKOUUNRxz2yzuXXVdBs4Hx9oYh1hZnUeV+TT5
         Ls0VLxRjnw61vAxGfObrXVEVIzE6VJfHJPtTDAlZ1v1l+a6ZV0zsUxqpWZx7Z+jJZDyR
         XfR10BeBmc6MAhsovPXzqmEMDoUnQR5jiR3YbDAtXIi78hbUYinDJ10Y8zU8pKPaOpR2
         1BDI7swVO6CKKSv2dG9F4a6EG96X2hCRSdScsYwmZbDpGeURpok0SLAPNovP0N694K3E
         gbSw==
X-Gm-Message-State: AC+VfDy3ls/UNHgcP/qFx9bOgbmCSIZ0s1m693RwxiIhksCDjEz3Rjy5
        KRyu4/dqUGhIAzN0j27j6YEZ1SpFL4tYGyLkyNlALQ==
X-Google-Smtp-Source: ACHHUZ5XH71fuQLzrmIT7pWr4OuhEegocxiqeU3jL5mRb6BLRR+IGYO6nfkeL5BFTVgsoiY1VOl7o3L7ZuWPsVb7tqI=
X-Received: by 2002:a05:6820:1527:b0:560:b9f0:b9fc with SMTP id
 ay39-20020a056820152700b00560b9f0b9fcmr814279oob.0.1687363713839; Wed, 21 Jun
 2023 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
 <ZIjOlU5EfVNt6NRU@x1n> <CABi2SkXE4pUhHucZ_c-_4Ux-VcLKic0+HY_DN2wUEC6DGkDvQQ@mail.gmail.com>
 <20230614011814.sz2l6z6wbaubabk2@revolver> <20230614125731.GY52412@kernel.org>
 <CABi2SkXySaoRxB0dfhhTQz6P5jCL8iWpY_ti=LC7Qi49+2F01w@mail.gmail.com> <20230621055551.GE52412@kernel.org>
In-Reply-To: <20230621055551.GE52412@kernel.org>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 21 Jun 2023 09:08:22 -0700
Message-ID: <CABi2SkUBMKOHB+pSDn2KqPZx384BXZQLn5YDzhATzQM41SgBJQ@mail.gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, zhangpeng.00@bytedance.com,
        akpm@linux-foundation.org, koct9i@gmail.com, david@redhat.com,
        ak@linux.intel.com, hughd@google.com, emunson@akamai.com,
        rppt@linux.ibm.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:56=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Tue, Jun 20, 2023 at 03:29:34PM -0700, Jeff Xu wrote:
> > On Wed, Jun 14, 2023 at 5:58=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Tue, Jun 13, 2023 at 09:18:14PM -0400, Liam R. Howlett wrote:
> > > > * Jeff Xu <jeffxu@chromium.org> [230613 17:29]:
> > > > > Hello Peter,
> > > > >
> > > > > Thanks for responding.
> > > > >
> > > > > On Tue, Jun 13, 2023 at 1:16=E2=80=AFPM Peter Xu <peterx@redhat.c=
om> wrote:
> > > > > >
> > > > > > Hi, Jeff,
> > > > > >
> > > > > > On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> > > > > > > + more ppl to the list.
> > > > > > >
> > > > > > > On Mon, Jun 12, 2023 at 6:04=E2=80=AFPM Jeff Xu <jeffxu@chrom=
ium.org> wrote:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > There seems to be inconsistency in different VMA fixup
> > > > > > > > implementations, for example:
> > > > > > > > mlock_fixup will skip VMA that is hugettlb, etc, but those =
checks do
> > > > > > > > not exist in mprotect_fixup and madvise_update_vma. Wouldn'=
t this be a
> > > > > > > > problem? the merge/split skipped by mlock_fixup, might get =
acted on in
> > > > > > > > the madvice/mprotect case.
> > > > > > > >
> > > > > > > > mlock_fixup currently check for
> > > > > > > > if (newflags =3D=3D oldflags ||
> > > >
> > > > newflags =3D=3D oldflags, then we don't need to do anything here, i=
t's
> > > > already at the desired mlock.  mprotect does this, madvise does thi=
s..
> > > > probably.. it's ugly.
> > > >
> > > > > > > > (oldflags & VM_SPECIAL) ||
> > > >
> > > > It's special, merging will fail always.  I don't know about splitti=
ng,
> > > > but I guess we don't want to alter the mlock state on special mappi=
ngs.
> > > >
> > > > > > > > is_vm_hugetlb_page(vma) || vma =3D=3D get_gate_vma(current-=
>mm) ||
> > > > > > > > vma_is_dax(vma) || vma_is_secretmem(vma))
> > > > > >
> > > > > > The special handling you mentioned in mlock_fixup mostly makes =
sense to me.
> > > > > >
> > > > > > E.g., I think we can just ignore mlock a hugetlb page if it won=
't be
> > > > > > swapped anyway.
> > > > > >
> > > > > > Do you encounter any issue with above?
> > > > > >
> > > > > > > > Should there be a common function to handle VMA merge/split=
 ?
> > > > > >
> > > > > > IMHO vma_merge() and split_vma() are the "common functions".  C=
opy Lorenzo
> > > > > > as I think he has plan to look into the interface to make it ev=
en easier to
> > > > > > use.
> > > > > >
> > > > > The mprotect_fixup doesn't have the same check as mlock_fixup. Wh=
en
> > > > > userspace calls mlock(), two VMAs might not merge or split becaus=
e of
> > > > > vma_is_secretmem check, However, when user space calls mprotect()=
 with
> > > > > the same address range, it will merge/split.  If mlock() is doing=
 the
> > > > > right thing to merge/split the VMAs, then mprotect() is not ?
> > > >
> > > > It looks like secretmem is mlock'ed to begin with so they don't wan=
t it
> > > > to be touched.  So, I think they will be treated differently and I =
think
> > > > it is correct.
> > >
> > > Right, they don't :)
> > >
> > > secretmem VMAs are always mlocked, they cannot be munlocked and there=
 is no
> > > point trying to mlock them again.
> > >
> > > The mprotect for secretmem is Ok though, so e.g. if we (unlikely) hav=
e two
> > > adjacent secretmem VMAs in a range passed to mprotect, it's fine to m=
erge
> > > them.
> > >
> >
> > I m thinking/brainstorming below, assuming:
> > Address range 1: 0x5000 to 0x6000 (regular mmap)
> > Address range 2: 0x6000 to 0x7000 (allocated to secretmem)
> > Address range 3: 0x7000 to 0x8000 (regular mmap)
> >
> > User space call: mlock(0x5000,0x3000)
> > range 1 and 2 won't merge.
> > range 2 and 3  could merge, when mlock_fixup  checks current vma
> > (range 3), it is not secretmem, so it will merge with prev vma.
>
> But 2 and 3 have different vm_file, they won't merge.
>
> > user space call: mprotect(0x5000,0x3000)
> > range 1 2 3 could merge,  all three can have the same flags.
> > Note: vma_is_secretmem() isn't checked in mprotect_fixup, same for
> > vma_is_dax and get_gate_vma, those doesn't have included in
> > vma->vm_flags
> >
> > Once 1 and 2 are merged, maybe user space is able to use
> > munlock(0x5000,0x3000)
> > to unlock range 1 to 3, this will include 2, right ? (haven't used the
> > code to prove it)
>
> But 1 and 2 won't merge because their vm_file's are different.
>
Is that possible to be staged the same ?

> > I'm using secretmem as an example here, having 3 different _fixup
> > implementations seems to be error prone to me.
>
> The actual decision whether to merge VMAs is taken in vma_merge rather th=
an
> by the _fixup functions. So while the checks around vma_merge might be
> different in these functions, it does not mean it's possible to wrongly
> merge VMA unless there is a bug in vma_merge. So in the end it boils down
> to a single core implementation, don't you agree?
>
I agree that vma_merge should also check, but it doesn't seem to be
the case ? I looked for secretmem, get_gate_vma(current->mm),
vma_is_dax()

Ideally,  the skip/go decisions should be inside vma_merge/vma_split()
function, not in the _fixup(),  I think.

> > Thanks
> > -Jeff
>
> --
> Sincerely yours,
> Mike.
