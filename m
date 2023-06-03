Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A38720D17
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbjFCCFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjFCCFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:05:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA511E50
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:05:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53f832298acso1717472a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 19:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685757900; x=1688349900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqtuoGsQN2xcTwos1nBNdGXenJUhs8GJBYKEpiy7fGg=;
        b=GrJgSzANBX7ZN4uVrXf2m+6y3ykffx1FuqToZeQ27pTJ90PYaATkL1D/nVGvMLpagN
         8/gpZDmf90GEAnlFEJmruZlNuQeegFwY9tWsGrqB3IK+DR6v8O5ro8zdcslPAfMHhmmY
         u2uS0v4mqZ1vUsH+grJb3fZ5QhwGu5qvUk7Wf+f61yE2GoENp/xhbTED7jqmpn22RRt9
         RLK8hqsX83F675XVJ37GpP8xroB5T6uExIWrlt1450LnRqJzgBRlBkdAvLXilyrGRQdZ
         aBglSsDhs5l5dD41SK4uBMNzICnAqIHTRd0UNBMzcV8vOboDGL8nvWCsqV1+qWsRDo+3
         1bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685757900; x=1688349900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqtuoGsQN2xcTwos1nBNdGXenJUhs8GJBYKEpiy7fGg=;
        b=cKS6oUrC07FqWMJxjJqHg0z5eAXPz9cV8fzUXxiRF2IBwnWnxpm50ph5T9jn4YcoxY
         rXvZhNfs+cFKUBsSrp9TASi++2s+LQCOyiW83ZJnz8VI0VLd1Azs2C0SEPW+IEe9a/sU
         OyHDo0PvLipA3KuIPGjHFgxC4O63weOVRWbenB8qO5cxTEhuieCYV43i75rhmNPG3X6t
         D66dXJwGkFyMeSBr3R3l757SJQd2HehH/IBh6jMerXdnoQAQ3c/4rZy1PCZCgAbqHe92
         HVfxn5L62GcSYeNU5E6Soz4nCX8Zp3QW8oNPYTiZtSVKIHKiS7St9fT9maTqL8q/rRAG
         8uwg==
X-Gm-Message-State: AC+VfDxkZc9FrOs7YuhILCBI5rpduy/qJwDWFdIdhz3UbyxBHSS/hIN7
        KRzaR5M4iz8vdsOCPuKxD2e+XnMc2sg0GGvZMds=
X-Google-Smtp-Source: ACHHUZ7grQPCAYkj7+ooHPeYxbrKmpjTrNpNphD8L2S0OEtgUw9sRDBJJ/L0v9s4S9hhx6Kave4RYkiw9fIu79KwL2Y=
X-Received: by 2002:a17:90b:1e0c:b0:259:ea:2747 with SMTP id
 pg12-20020a17090b1e0c00b0025900ea2747mr678971pjb.5.1685757899780; Fri, 02 Jun
 2023 19:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230602230552.350731-1-peterx@redhat.com> <20230602230552.350731-2-peterx@redhat.com>
In-Reply-To: <20230602230552.350731-2-peterx@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 2 Jun 2023 19:04:48 -0700
Message-ID: <CAHbLzkq+Mf3N1FvjMRD8+SiEsry_39ycgCN92GHp5VsshyKE8w@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/mprotect: Retry on pmd_trans_unstable()
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> When hit unstable pmd, we should retry the pmd once more because it means
> we probably raced with a thp insertion.
>
> Skipping it might be a problem as no error will be reported to the caller=
.
> I assume it means the user will expect prot changed (e.g. mprotect or
> userfaultfd wr-protections) applied but it's actually not.

IIRC, mprotect() holds write mmap_lock, so it should not matter. PROT
NUMA holds read mmap_lock, but returning 0 also doesn't matter (of
course retry is fine too). just skip that 2M area. The userfaultfd-wp
is your call :-)

>
> To achieve it, move the pmd_trans_unstable() call out of change_pte_range=
()
> which will make the retry easier, as we can keep the retval of
> change_pte_range() untouched.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/mprotect.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 92d3d3ca390a..e4756899d40c 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -94,15 +94,6 @@ static long change_pte_range(struct mmu_gather *tlb,
>
>         tlb_change_page_size(tlb, PAGE_SIZE);
>
> -       /*
> -        * Can be called with only the mmap_lock for reading by
> -        * prot_numa so we must check the pmd isn't constantly
> -        * changing from under us from pmd_none to pmd_trans_huge
> -        * and/or the other way around.
> -        */
> -       if (pmd_trans_unstable(pmd))
> -               return 0;
> -
>         /*
>          * The pmd points to a regular pte so the pmd can't change
>          * from under us even if the mmap_lock is only hold for
> @@ -411,6 +402,7 @@ static inline long change_pmd_range(struct mmu_gather=
 *tlb,
>                         pages =3D ret;
>                         break;
>                 }
> +again:
>                 /*
>                  * Automatic NUMA balancing walks the tables with mmap_lo=
ck
>                  * held for read. It's possible a parallel update to occu=
r
> @@ -465,6 +457,16 @@ static inline long change_pmd_range(struct mmu_gathe=
r *tlb,
>                         }
>                         /* fall through, the trans huge pmd just split */
>                 }
> +
> +               /*
> +                * Can be called with only the mmap_lock for reading by
> +                * prot_numa or userfaultfd-wp, so we must check the pmd
> +                * isn't constantly changing from under us from pmd_none =
to
> +                * pmd_trans_huge and/or the other way around.
> +                */
> +               if (pmd_trans_unstable(pmd))
> +                       goto again;
> +
>                 pages +=3D change_pte_range(tlb, vma, pmd, addr, next,
>                                           newprot, cp_flags);
>  next:
> --
> 2.40.1
>
>
