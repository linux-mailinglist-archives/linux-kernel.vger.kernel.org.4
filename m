Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2D73777B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFTW3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFTW3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:29:49 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE21737
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:29:47 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5608a4eb782so1135037eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687300186; x=1689892186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=737y4GyRKpqE91gxSPyOenREhA5BzvvW+7hP1UZx97Y=;
        b=UOyd0SqfeJgjhXQSRp176NRZYdP7jXBIUwyWyjy9o2GHZalWpMTMxx/ULyTCXJLjcO
         VxnHQbRksc+9saHehv+vc4iI4O3WP73yzFRSzFTsMi6Y5r7foNdSNvSBerZNxrWF+Vhe
         Vtc8fz4c44M5POvOs+oxJilbwBw+uozTOHVbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687300186; x=1689892186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=737y4GyRKpqE91gxSPyOenREhA5BzvvW+7hP1UZx97Y=;
        b=MZz4dr1gLL3HpZ1foLF8hNDp/gUoZHHi444wXxO3uCGExpOQNYLAWonGPkFmsSJFqW
         5Q9iSMXVFkeplJX6YdTuBClgAGaYsEHzbvGdFTz//36YWipGUaPfYBfx+sTepzhetg4J
         HWcKCUkStpcq4Hnv79BpIkHLWxwuQDdAzownIIwUhFmxC3pfllW9IoW7RWC1DPZ0VSK5
         MTA0dUerVghFWJH4FqZPECRvRF5CYCUpJrBwG4YK2NEO0wq+wFWGVY1Bjw9lpGlovmhI
         Y2rnF+gBXMLdjJE5Cop97uhDJm6MsnRBilOuvG79gEAP1T/wKMRxxFKFkx30Cz24Sm08
         yu2Q==
X-Gm-Message-State: AC+VfDyZDFm9TxK5VnKiEZeHIJlg5jSG/WilQ7pX9+rN/4IS0KZnmha8
        siampCXbUPDLkHUJpxVr85s97WHU2SFDQsloBTxyNw==
X-Google-Smtp-Source: ACHHUZ4o4Qo09sbgerKhKFBt3uDUXaRfWTXfdNBwHm3LbMd5T9IVxxNte6h21MAZepg91DnddrV44fMX/rci9N6oSqg=
X-Received: by 2002:a05:6808:1294:b0:3a0:3249:b29e with SMTP id
 a20-20020a056808129400b003a03249b29emr5459279oiw.44.1687300186491; Tue, 20
 Jun 2023 15:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
 <ZIjOlU5EfVNt6NRU@x1n> <CABi2SkXE4pUhHucZ_c-_4Ux-VcLKic0+HY_DN2wUEC6DGkDvQQ@mail.gmail.com>
 <20230614011814.sz2l6z6wbaubabk2@revolver> <20230614125731.GY52412@kernel.org>
In-Reply-To: <20230614125731.GY52412@kernel.org>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 20 Jun 2023 15:29:34 -0700
Message-ID: <CABi2SkXySaoRxB0dfhhTQz6P5jCL8iWpY_ti=LC7Qi49+2F01w@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 5:58=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Jun 13, 2023 at 09:18:14PM -0400, Liam R. Howlett wrote:
> > * Jeff Xu <jeffxu@chromium.org> [230613 17:29]:
> > > Hello Peter,
> > >
> > > Thanks for responding.
> > >
> > > On Tue, Jun 13, 2023 at 1:16=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > Hi, Jeff,
> > > >
> > > > On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> > > > > + more ppl to the list.
> > > > >
> > > > > On Mon, Jun 12, 2023 at 6:04=E2=80=AFPM Jeff Xu <jeffxu@chromium.=
org> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > There seems to be inconsistency in different VMA fixup
> > > > > > implementations, for example:
> > > > > > mlock_fixup will skip VMA that is hugettlb, etc, but those chec=
ks do
> > > > > > not exist in mprotect_fixup and madvise_update_vma. Wouldn't th=
is be a
> > > > > > problem? the merge/split skipped by mlock_fixup, might get acte=
d on in
> > > > > > the madvice/mprotect case.
> > > > > >
> > > > > > mlock_fixup currently check for
> > > > > > if (newflags =3D=3D oldflags ||
> >
> > newflags =3D=3D oldflags, then we don't need to do anything here, it's
> > already at the desired mlock.  mprotect does this, madvise does this..
> > probably.. it's ugly.
> >
> > > > > > (oldflags & VM_SPECIAL) ||
> >
> > It's special, merging will fail always.  I don't know about splitting,
> > but I guess we don't want to alter the mlock state on special mappings.
> >
> > > > > > is_vm_hugetlb_page(vma) || vma =3D=3D get_gate_vma(current->mm)=
 ||
> > > > > > vma_is_dax(vma) || vma_is_secretmem(vma))
> > > >
> > > > The special handling you mentioned in mlock_fixup mostly makes sens=
e to me.
> > > >
> > > > E.g., I think we can just ignore mlock a hugetlb page if it won't b=
e
> > > > swapped anyway.
> > > >
> > > > Do you encounter any issue with above?
> > > >
> > > > > > Should there be a common function to handle VMA merge/split ?
> > > >
> > > > IMHO vma_merge() and split_vma() are the "common functions".  Copy =
Lorenzo
> > > > as I think he has plan to look into the interface to make it even e=
asier to
> > > > use.
> > > >
> > > The mprotect_fixup doesn't have the same check as mlock_fixup. When
> > > userspace calls mlock(), two VMAs might not merge or split because of
> > > vma_is_secretmem check, However, when user space calls mprotect() wit=
h
> > > the same address range, it will merge/split.  If mlock() is doing the
> > > right thing to merge/split the VMAs, then mprotect() is not ?
> >
> > It looks like secretmem is mlock'ed to begin with so they don't want it
> > to be touched.  So, I think they will be treated differently and I thin=
k
> > it is correct.
>
> Right, they don't :)
>
> secretmem VMAs are always mlocked, they cannot be munlocked and there is =
no
> point trying to mlock them again.
>
> The mprotect for secretmem is Ok though, so e.g. if we (unlikely) have tw=
o
> adjacent secretmem VMAs in a range passed to mprotect, it's fine to merge
> them.
>

I m thinking/brainstorming below, assuming:
Address range 1: 0x5000 to 0x6000 (regular mmap)
Address range 2: 0x6000 to 0x7000 (allocated to secretmem)
Address range 3: 0x7000 to 0x8000 (regular mmap)

User space call: mlock(0x5000,0x3000)
range 1 and 2 won't merge.
range 2 and 3  could merge, when mlock_fixup  checks current vma
(range 3), it is not secretmem, so it will merge with prev vma.

user space call: mprotect(0x5000,0x3000)
range 1 2 3 could merge,  all three can have the same flags.
Note: vma_is_secretmem() isn't checked in mprotect_fixup, same for
vma_is_dax and get_gate_vma, those doesn't have included in
vma->vm_flags

Once 1 and 2 are merged, maybe user space is able to use
munlock(0x5000,0x3000)
to unlock range 1 to 3, this will include 2, right ? (haven't used the
code to prove it)

I'm using secretmem as an example here, having 3 different _fixup
implementations seems to be error prone to me.

Thanks
-Jeff





> > Although, it would have been nice to have the comment above the functio=
n
> > kept up to date on why certain VMAs are filtered out.
> >
> > >
> > > Also skipping merge of VMA might be OK, but skipping split doesn't,
> > > wouldn't that cause inconsistent between vma->vm_flags and what is
> > > provisioned in the page ?
> >
> > I don't quite follow what you mean.  It seems like the mlock_fixup() is
> > skipped when we don't want the flag to be altered on a particular VMA.
> > Where do they get out of sync?
> >
> >
>
> --
> Sincerely yours,
> Mike.
