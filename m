Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024E2649400
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiLKLsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKLr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:47:58 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF3E002
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:47:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b9so9654152ljr.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOuPxWYpFP09QQXPfRxhnJ/8wDMydFyrgaAcKSHPSrA=;
        b=n/JD7w3xfDrZ+55g6bXLtgigY98gi4rX/mB6VUaC/UIjM3NFDDePEYkDHcpSJfxEn8
         wRHiS/P1PEPJHq2aXdz62uSX1995X13pu/V2KUD0gvy9Kb9R9+bpa9Oik0eREuQsiSCD
         JP+aq192CPrqIwFQ2Qs34ptQqdGkt5NHEhiV24vbWK46WWszfAT1A8SExueiKej3MDiH
         uoiqzLMUiWd6S1VpxYBCMJ/9Wrbh2s+RL6eui0799WQ9J7Vd4kR4T+fd1YSMs3s8Fe7Y
         p5hOwbXQHCExLwZy9psdhVwRwiHjmp4GaV8C6ROlQnc9J38HYdFvHkH8qWcDAkkY+/CE
         IOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOuPxWYpFP09QQXPfRxhnJ/8wDMydFyrgaAcKSHPSrA=;
        b=5eKq6Gk9WdnQppnp3OKita2Ql7ysA51jzJC6wvi9t4xMD16Q7VlOwuWbUVo5gKucyK
         /o4PMl62OLxd/DgvPv/A/Xla7zUJGKak1UDOaYXeWEPp7eiYEvc/22cz0+0ylqsjN7dY
         RbVShdwKuNY4S+6+FybVISAULDzmAtWowka6fzyHSpBoJwAsoTHEuVa7AdlqzeO7TrbN
         oVUHYE6ZhdmV/qT9Uh0v0iqhjrn5B01I700oS/twKAfCQT6Ek7V6j2VR6dZbCEbxsDtC
         pTuSaz7vfxMBkhArd5yzfLJ/1Qd3KTbVT2NSnMiKT4Qu2FnB9yE9D366XJfORrjd1flV
         yJ9A==
X-Gm-Message-State: ANoB5pluR1BdQqJAIdIz3PbBCTFX8SBPuThKb6c7itJBLfMBZyRNMPyJ
        aWcHDcSTCZrrupEOREc/IPWmLY3hz5o1bWNMwAo=
X-Google-Smtp-Source: AA0mqf7wXjpazljqZ9v0DJ/NKU49RGa0aWZcce2hL2IwPTKUpn7Z5/3E+Tdkxc8A3CFSne7Ef7sb4tA+mauHypAGJQQ=
X-Received: by 2002:a2e:83c5:0:b0:277:aed:be6b with SMTP id
 s5-20020a2e83c5000000b002770aedbe6bmr27163729ljh.322.1670759275526; Sun, 11
 Dec 2022 03:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20221208180209.50845-1-ryncsn@gmail.com> <20221208180209.50845-5-ryncsn@gmail.com>
 <87iliiqidl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87iliiqidl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Sun, 11 Dec 2022 19:47:43 +0800
Message-ID: <CAMgjq7DxsxV+4DHbJ_1-VNRXjYicoWdCKsQVYKzkstt9ZXjXSg@mail.gmail.com>
Subject: Re: [PATCH 4/5] swap: remove the swap lock in swap_cache_get_folio
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8811=E6=
=97=A5=E5=91=A8=E6=97=A5 19:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > There is only one caller not keep holding a reference or lock the
> > swap device while calling this function. Just move the lock out
> > of this function, it only used to prevent swapoff, and this helper
> > function is very short so there is no performance regression
> > issue. Help saves a few cycles.
>
> > Subject: Re: [PATCH 4/5] swap: remove the swap lock in swap_cache_get_f=
olio
>
> I don't think you remove `swap lock` in swap_cache_get_folio().  Just
> avoid to inc/dec the reference count.

Yes, that's more accurate, it's kind of like 'locked the swap device
from being swapped off', so I used some inaccurate word. I'll correct
this in V2.

>
> And I think it's better to add '()' after swap_cache_get_folio to make
> it clear it's a function.

Good suggestion.

>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/shmem.c      | 8 +++++++-
> >  mm/swap_state.c | 8 ++------
> >  2 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index c1d8b8a1aa3b..0183b6678270 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1725,6 +1725,7 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >       struct address_space *mapping =3D inode->i_mapping;
> >       struct shmem_inode_info *info =3D SHMEM_I(inode);
> >       struct mm_struct *charge_mm =3D vma ? vma->vm_mm : NULL;
> > +     struct swap_info_struct *si;
> >       struct folio *folio =3D NULL;
> >       swp_entry_t swap;
> >       int error;
> > @@ -1737,7 +1738,12 @@ static int shmem_swapin_folio(struct inode *inod=
e, pgoff_t index,
> >               return -EIO;
> >
> >       /* Look it up and read it in.. */
> > -     folio =3D swap_cache_get_folio(swap, NULL, 0);
> > +     si =3D get_swap_device(swap);
> > +     if (si) {
> > +             folio =3D swap_cache_get_folio(swap, NULL, 0);
> > +             put_swap_device(si);
>
> I'd rather to call put_swap_device() at the end of function.  That is,
> whenever we get a swap entry without proper lock/reference to prevent
> swapoff, we should call get_swap_device() to check its validity and
> prevent the swap device from swapoff.

Yes, that's the right way to do it, my code is buggy here, sorry for
being so careless, I'll fix it.

>
> Best Regards,
> Huang, Ying
>
> > +     }
> > +
> >       if (!folio) {
> >               /* Or update major stats only when swapin succeeds?? */
> >               if (fault_type) {
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 19089417abd1..eba388f67741 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -324,19 +324,15 @@ static inline bool swap_use_vma_readahead(void)
> >   * unlocked and with its refcount incremented - we rely on the kernel
> >   * lock getting page table operations atomic even if we drop the folio
> >   * lock before returning.
> > + *
> > + * Caller must lock the swap device or hold a reference to keep it val=
id.
> >   */
> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >               struct vm_area_struct *vma, unsigned long addr)
> >  {
> >       struct folio *folio;
> > -     struct swap_info_struct *si;
> >
> > -     si =3D get_swap_device(entry);
> > -     if (!si)
> > -             return NULL;
> >       folio =3D filemap_get_folio(swap_address_space(entry), swp_offset=
(entry));
> > -     put_swap_device(si);
> > -
> >       if (folio) {
> >               bool vma_ra =3D swap_use_vma_readahead();
> >               bool readahead;
