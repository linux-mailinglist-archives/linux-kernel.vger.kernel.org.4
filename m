Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845EC72EDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbjFMV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:29:28 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED57173C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:29:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55b78f40301so24009eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686691766; x=1689283766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5HE/be1fUs4mLPz2SaYKZccHzMwcgmBbh761wXiNnM=;
        b=UvQvJ1HKFaAQUKjPmhDlN7jMvGSXBDIpN8pkmYF/Bwah+h8t3CYvGVpSGid2I0e1od
         EVrSYsLxjZIKskXU0Vvt3brC/t3bA5LGP8JPpEtjL0RMSbnCD3G31q5hwxWjam+kQ7ex
         xxV7ezNLLsVB0tD6+MpVreQkIk6yJG7zTek10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686691766; x=1689283766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5HE/be1fUs4mLPz2SaYKZccHzMwcgmBbh761wXiNnM=;
        b=CKYoytoOA/L47+pBRv3Yv9CMyxbN2YOU8dP2jmbZdd+FRdfGUT8eZJ2PnFHnjzd3Yy
         JD8zJsiFCow3EYfB1QEgUH02VnS1NK+L6dWO00WVP5Dk2Ct2JWN+AyKPt2aj55UBDbFn
         5edDWGtdhlLwRmC3NLd6TQg/mkfHduT4uiSnJjhzXfRM3k23enVu36KCmcOsvx/PzAEe
         nACYgEuRYcm/+iMVgW24c6VWgXVZZurhcZ+yixND6mZU/pqwtcz9xi7FTKVTzK1ERBxm
         G9Cv2H29BQFrCRNYgG4kvNrG4OBPBD9aEcUbFNYIyMa28MOBEVRyElkW0Sbb4SnghLtc
         pS7Q==
X-Gm-Message-State: AC+VfDzGxE2ejnoQN9I3sj62cXghMPYwuOU96cHVSY9u6VI/ZUyD3Q4i
        S14XMeAcxpGL4xbocpXzGs1Uw2VBAvsUd68I8cQPRw==
X-Google-Smtp-Source: ACHHUZ7fbo8Kxz8Uov9OlVFEvorMOAwEZuA89XR8G2tpT+1NdcpRdHiv7waH1TAy4137LEZTgCftvDdUkcR4RpaqMKg=
X-Received: by 2002:a4a:e9e2:0:b0:558:b424:8c31 with SMTP id
 w2-20020a4ae9e2000000b00558b4248c31mr8037821ooc.0.1686691766049; Tue, 13 Jun
 2023 14:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com> <ZIjOlU5EfVNt6NRU@x1n>
In-Reply-To: <ZIjOlU5EfVNt6NRU@x1n>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 13 Jun 2023 14:29:14 -0700
Message-ID: <CABi2SkXE4pUhHucZ_c-_4Ux-VcLKic0+HY_DN2wUEC6DGkDvQQ@mail.gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Liam.Howlett@oracle.com, zhangpeng.00@bytedance.com,
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

Hello Peter,

Thanks for responding.

On Tue, Jun 13, 2023 at 1:16=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Jeff,
>
> On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> > + more ppl to the list.
> >
> > On Mon, Jun 12, 2023 at 6:04=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> w=
rote:
> > >
> > > Hello,
> > >
> > > There seems to be inconsistency in different VMA fixup
> > > implementations, for example:
> > > mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
> > > not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be =
a
> > > problem? the merge/split skipped by mlock_fixup, might get acted on i=
n
> > > the madvice/mprotect case.
> > >
> > > mlock_fixup currently check for
> > > if (newflags =3D=3D oldflags || (oldflags & VM_SPECIAL) ||
> > > is_vm_hugetlb_page(vma) || vma =3D=3D get_gate_vma(current->mm) ||
> > > vma_is_dax(vma) || vma_is_secretmem(vma))
>
> The special handling you mentioned in mlock_fixup mostly makes sense to m=
e.
>
> E.g., I think we can just ignore mlock a hugetlb page if it won't be
> swapped anyway.
>
> Do you encounter any issue with above?
>
> > > Should there be a common function to handle VMA merge/split ?
>
> IMHO vma_merge() and split_vma() are the "common functions".  Copy Lorenz=
o
> as I think he has plan to look into the interface to make it even easier =
to
> use.
>
The mprotect_fixup doesn't have the same check as mlock_fixup. When
userspace calls mlock(), two VMAs might not merge or split because of
vma_is_secretmem check, However, when user space calls mprotect() with
the same address range, it will merge/split.  If mlock() is doing the
right thing to merge/split the VMAs, then mprotect() is not ?

Also skipping merge of VMA might be OK, but skipping split doesn't,
wouldn't that cause inconsistent between vma->vm_flags and what is
provisioned in the page ?

Thanks
-Jeff Xu


> --
> Peter Xu
>
