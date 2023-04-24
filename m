Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D06EC3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjDXChP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDXChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:37:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1987B2688
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:37:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4efef769000so783087e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682303819; x=1684895819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWLQq8LKSwpKlO+DVpyoCqxpg/jxNQlPguCAnZsIh90=;
        b=LB9RyMICWe0JD/uPys9DDbmoSRPAmmJfaXSh7z6aOye7DGHlMyjdUmVG4vqJNbp8pV
         h1r2QDK1jc5KTOZ+HSpzzEmO10TwuVupvw2jitg6mJ0sLVjFQdg+vgRQaC3U3c9YT4qB
         pBqglMev0wVg65GQPdDAQ2wtC4IqsM+3jq/b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682303819; x=1684895819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWLQq8LKSwpKlO+DVpyoCqxpg/jxNQlPguCAnZsIh90=;
        b=g7rmitk+8/h8Pu/D9GhpJYRePsc4CjNoDW/RJcPokryaCfPt7WbCSIWlxxwFIWL0PA
         YxADf8h7HFCcbO98C5Qk2JlhPuCu+k+oKe5Dex7Lgxc4yNrs/j9zB4EE9ZQXuS1sKhJG
         HyT72rDkrPmjX4qKV/w3JqHehHoXq71mEwUyWtqm9Bdr6qZEKU2HWA0SLaDir1ZrPIie
         /uB3pB30EWyh1G71mW8YmdTRItPR9E0thRSdDwipPa4H9LtNMxkrc1rXOcugQJRziLCa
         RgzTM51Y+7axwvtGCBFLd+Jn3y0VZml5IHxqDFKpxa2M/uiPpbiO+pNkBdaEOaM5TIYR
         S+lQ==
X-Gm-Message-State: AAQBX9dG88thL6haGYjAQGF083bsRHBGPxL3MJqQDtgA2Z9SK0avBmPt
        M2+sKUvYFdl3NNBbhsBAOxD++hhtXaMzSYz0+WkUoA==
X-Google-Smtp-Source: AKy350Z0DyOZjTe/duYuceGdGau6TqY/bAIfJE1PcgLymUgU82dWm7YNaENHYqtRKyqMmaiId2KExqWwUmWVVy0Q5qs=
X-Received: by 2002:ac2:5285:0:b0:4e8:c81b:1a11 with SMTP id
 q5-20020ac25285000000b004e8c81b1a11mr2788263lfm.49.1682303819370; Sun, 23 Apr
 2023 19:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <b6c881-c352-bb91-85a8-febeb09dfd71@google.com>
 <CAD=HUj5NSXX8a5shf-GVYqkMFC-o26vuyo26hMPpPCnuSD683A@mail.gmail.com> <cf24ea0-92da-cd46-a7cd-87f5449016e8@google.com>
In-Reply-To: <cf24ea0-92da-cd46-a7cd-87f5449016e8@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 24 Apr 2023 11:36:48 +0900
Message-ID: <CAD=HUj5EzNc28MFs6m2-RpH0Ao1KNNOBUUSL1OjAj7T+cxqpUg@mail.gmail.com>
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

On Mon, Apr 24, 2023 at 11:17=E2=80=AFAM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Mon, 24 Apr 2023, David Stevens wrote:
> > On Sun, Apr 23, 2023 at 1:47=E2=80=AFPM Hugh Dickins <hughd@google.com>=
 wrote:
> > >
> > > Inserting Ivan Orlov's syzbot fix commit 2ce0bdfebc74
> > > ("mm: khugepaged: fix kernel BUG in hpage_collapse_scan_file()")
> > > ahead of Jiaqi Yan's and David Stevens's commits
> > > 12904d953364 ("mm/khugepaged: recover from poisoned file-backed memor=
y")
> > > cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
> > > ac492b9c70ca ("mm/khugepaged: skip shmem with userfaultfd")
> > > (all of which restructure collapse_file()) did not work out well.
> > >
> > > xfstests generic/086 on huge tmpfs (with accelerated khugepaged) free=
zes
> > > (if not on the first attempt, then the 2nd or 3rd) in find_lock_entri=
es()
> > > while doing drop_caches: the file's xarray seems to have been corrupt=
ed,
> > > with find_get_entry() returning nonsense which makes no progress.
> > >
> > > Bisection led to ac492b9c70ca; and diff against earlier working linux=
-next
> > > suggested that it's probably down to an errant xas_store(), which doe=
s not
> > > belong with the later changes (and nor does the positioning of warnin=
gs).
> > > The later changes look as if they fix the syzbot issue independently.
> > >
> > > Remove most of what's left of 2ce0bdfebc74: just leave one WARN_ON_ON=
CE
> > > (xas_error) after the final xas_store() of the multi-index entry.
> > >
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > ---
> > >
> > >  mm/khugepaged.c | 23 +----------------------
> > >  1 file changed, 1 insertion(+), 22 deletions(-)
> > >
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -1941,16 +1941,6 @@ static int collapse_file(struct mm_struct *mm,=
 unsigned long addr,
> > >                                         result =3D SCAN_FAIL;
> > >                                         goto xa_locked;
> > >                                 }
> > > -                               xas_store(&xas, hpage);
> > > -                               if (xas_error(&xas)) {
> > > -                                       /* revert shmem_charge perfor=
med
> > > -                                        * in the previous condition
> > > -                                        */
> > > -                                       mapping->nrpages--;
> > > -                                       shmem_uncharge(mapping->host,=
 1);
> > > -                                       result =3D SCAN_STORE_FAILED;
> >
> > With this being removed, SCAN_STORE_FAILED should also be removed from
> > the scan_result enum and trace event definitions.
>
> Only if we also remove your use of SCAN_STORE_FAILED in ac492b9c70ca:
> what would you want that to say instead?
>
> I don't care myself for any of those "SCAN" result codes, nor whether the=
y
> are few or many: I'd rather have __LINE__ numbers for my own debugging.
>
> But if people want to remove SCAN_STORE_FAILED now, sure, send a patch;
> my intent was to unbreak the breakage.

Oh, I had forgotten that I used the code when I rebased v6 of my
patches. I have no strong opinions one way or the other. Sorry for the
noise.

-David
