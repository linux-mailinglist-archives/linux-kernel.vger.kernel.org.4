Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88E06EC37F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjDXBxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDXBxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:53:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92A1B3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 18:53:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so36905391fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 18:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682301215; x=1684893215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLsSYolj9hPw/7JhcR3JOAVToSRQ1g/qIIEcknYaBqE=;
        b=Hg09+f7rQ78MHcsG08g5ASdNMRP4s3HW95u7TVILtkDxkcl4hR2KiIxSVbWORXO3DY
         yyUf+Ak2UmONTtu05CQVBCfcy/o+XzT82MrdLYyNFTPczaHX1x/pJ8nf0tZm4AUMTgi+
         58aqkWr/ypxIg69SE4b/+z4rdh5yHp0+YwS1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682301215; x=1684893215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLsSYolj9hPw/7JhcR3JOAVToSRQ1g/qIIEcknYaBqE=;
        b=eUHqg9+1tN+Z4x1QoCuc5VCYdFy6Ogv9BBhDZxqRf3ApmY8Wu5Liq2N3rZ/gSYtC4a
         FNkRzUZ/vZPxk3F2gdoXXgWTPWT9gF1wryzz9vhDh8aoA97O0nhkxCzOWXtbf4TZporJ
         bkFL+Ry5l7R7XnjhgmCyDh0ththqbmQTBPVMvA/4z+90O5s1r8lG7MkxHOBLf8LwXAkO
         dCEcf7C7b5WMswV4bPOweV7cjRZkQSEwhH3PGTyrmrNGVK5LxiPIRLmjRcMXdq5bGWfV
         ZWjU7kiUh7Fv+aXefgpi770blpkUP65bwYqQAhEEQnK0Wm/fGR3kXn06OJqFPdSe4VW7
         QMzg==
X-Gm-Message-State: AAQBX9erkKI5Wdl0h1gWYYaxm+Ye1ohjkWY1vvMSpkMJyr/0KoH5D3yO
        4R1mQME37TyLjxIJ58RXd7ozjsuZvRPOVnp3aAsnSA==
X-Google-Smtp-Source: AKy350a8lNxoW8MPan3RZwfNW/pphX9qZ4eq9urlwhpLO4FdCvTPASd7yxhI8qHgNdedit1SZUjOZdrZY4xzxUVt0ug=
X-Received: by 2002:a05:651c:1026:b0:2a1:17f8:e904 with SMTP id
 w6-20020a05651c102600b002a117f8e904mr2226959ljm.4.1682301214861; Sun, 23 Apr
 2023 18:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <b6c881-c352-bb91-85a8-febeb09dfd71@google.com>
In-Reply-To: <b6c881-c352-bb91-85a8-febeb09dfd71@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 24 Apr 2023 10:53:23 +0900
Message-ID: <CAD=HUj5NSXX8a5shf-GVYqkMFC-o26vuyo26hMPpPCnuSD683A@mail.gmail.com>
Subject: Re: [PATCH next] mm/khugepaged: fix conflicting mods to collapse_file()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 1:47=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> Inserting Ivan Orlov's syzbot fix commit 2ce0bdfebc74
> ("mm: khugepaged: fix kernel BUG in hpage_collapse_scan_file()")
> ahead of Jiaqi Yan's and David Stevens's commits
> 12904d953364 ("mm/khugepaged: recover from poisoned file-backed memory")
> cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
> ac492b9c70ca ("mm/khugepaged: skip shmem with userfaultfd")
> (all of which restructure collapse_file()) did not work out well.
>
> xfstests generic/086 on huge tmpfs (with accelerated khugepaged) freezes
> (if not on the first attempt, then the 2nd or 3rd) in find_lock_entries()
> while doing drop_caches: the file's xarray seems to have been corrupted,
> with find_get_entry() returning nonsense which makes no progress.
>
> Bisection led to ac492b9c70ca; and diff against earlier working linux-nex=
t
> suggested that it's probably down to an errant xas_store(), which does no=
t
> belong with the later changes (and nor does the positioning of warnings).
> The later changes look as if they fix the syzbot issue independently.
>
> Remove most of what's left of 2ce0bdfebc74: just leave one WARN_ON_ONCE
> (xas_error) after the final xas_store() of the multi-index entry.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>
>  mm/khugepaged.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
>
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1941,16 +1941,6 @@ static int collapse_file(struct mm_struct *mm, uns=
igned long addr,
>                                         result =3D SCAN_FAIL;
>                                         goto xa_locked;
>                                 }
> -                               xas_store(&xas, hpage);
> -                               if (xas_error(&xas)) {
> -                                       /* revert shmem_charge performed
> -                                        * in the previous condition
> -                                        */
> -                                       mapping->nrpages--;
> -                                       shmem_uncharge(mapping->host, 1);
> -                                       result =3D SCAN_STORE_FAILED;

With this being removed, SCAN_STORE_FAILED should also be removed from
the scan_result enum and trace event definitions.

-David

> -                                       goto xa_locked;
> -                               }
>                                 nr_none++;
>                                 continue;
>                         }
> @@ -2105,13 +2095,6 @@ static int collapse_file(struct mm_struct *mm, uns=
igned long addr,
>                  * Accumulate the pages that are being collapsed.
>                  */
>                 list_add_tail(&page->lru, &pagelist);
> -
> -               /*
> -                * We can't get an ENOMEM here (because the allocation ha=
ppened
> -                * before) but let's check for errors (XArray implementat=
ion
> -                * can be changed in the future)
> -                */
> -               WARN_ON_ONCE(xas_error(&xas));
>                 continue;
>  out_unlock:
>                 unlock_page(page);
> @@ -2134,11 +2117,6 @@ static int collapse_file(struct mm_struct *mm, uns=
igned long addr,
>                 }
>         }
>
> -       /* Here we can't get an ENOMEM (because entries were
> -        * previously allocated) But let's check for errors
> -        * (XArray implementation can be changed in the future)
> -        */
> -       WARN_ON_ONCE(xas_error(&xas));
>  xa_locked:
>         xas_unlock_irq(&xas);
>  xa_unlocked:
> @@ -2259,6 +2237,7 @@ static int collapse_file(struct mm_struct *mm, unsi=
gned long addr,
>         /* Join all the small entries into a single multi-index entry. */
>         xas_set_order(&xas, start, HPAGE_PMD_ORDER);
>         xas_store(&xas, hpage);
> +       WARN_ON_ONCE(xas_error(&xas));
>         xas_unlock_irq(&xas);
>
>         /*
