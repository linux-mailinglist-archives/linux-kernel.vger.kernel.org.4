Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A819A6EC38C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDXCR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXCRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:17:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845FF19B0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:17:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b98415ba97aso4982270276.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682302641; x=1684894641;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0VX+qVpX589en4ibYbxaJtlcS+1y2JMmkJuoXSEze8c=;
        b=R+pGwl7zsqYJxq4psP2Yt3s6BCQ3CZJbTh81Pn2v7fummBwCHwM71kwo2PAyc0/APK
         YHeoYkCJdEjEWvwvjRs8CdCtloPwwEu9AEPaILzyABUklFu1ePu63lA89MZaywQ8JR3n
         /FA5ODedUWzc1tiMgcNY0i32HwWTC5uvkmrbu2uEGdTzPfPZeOdxGlS16fG6mYkydmOj
         TWftwM8lOiSCPJqo5QTwuVEA1TrWAGwQfbkTYQtFynFkk9o+2+p4mAIgd0OXYOL9HRwo
         BQdQ0bwZ7/CPIu9dw5/Qja6quF6Dz7VcuGnFNrfxDBbn85Xf34gSSq73Uu3J/WtRsN8v
         kh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682302641; x=1684894641;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VX+qVpX589en4ibYbxaJtlcS+1y2JMmkJuoXSEze8c=;
        b=b9xbL95kF4YNY+1oSuju4z4gwC7dm9GJdXQdN/luH5V9c1Iw9SAuVFLJFn4UNe4SKE
         /+ynHgOr90o0Zq6O3QoJOnNVDbUirr3NF/EVXvgfn1SbfkbHPq1UjDVPv2z6aS/fCANJ
         YRRqRXsPiR9bUpdfQk/WSrWofRcSm54gYoE33AafmjFbuGtNwKDo4iljBNGXBjdK+B/n
         NL4dCbChB+Vj7+BDt41LDbrJjp6vdUNQfcfDNy3VUpe76ccVW2HiLK+i6xllhL4o+yY8
         3a6kRDVvBy7nYZGNVt0/LpvU78VlbOZpJdMvEkpWml8XvQv9Ll5UiQXM8stq2fb9Fn94
         DJ9Q==
X-Gm-Message-State: AAQBX9fh3pquiFDzfvWndGF23JVIVMnKtY9X/VobnXvL4f+PsTNY1O8q
        dQOyoItYpEf4whlnGE7bxiyo4Q==
X-Google-Smtp-Source: AKy350ZnFkJQzOHeJaKMeyQF5MBYpYAdpIbWqkfSn/0sv31npK+KqOuCFoaJUPKOnnhFNOhG2k10zQ==
X-Received: by 2002:a25:fc5:0:b0:b92:3b1d:f21e with SMTP id 188-20020a250fc5000000b00b923b1df21emr8371307ybp.1.1682302641606;
        Sun, 23 Apr 2023 19:17:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 190-20020a250ac7000000b00b7767ca749esm2605415ybk.59.2023.04.23.19.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 19:17:20 -0700 (PDT)
Date:   Sun, 23 Apr 2023 19:17:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Stevens <stevensd@chromium.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH next] mm/khugepaged: fix conflicting mods to
 collapse_file()
In-Reply-To: <CAD=HUj5NSXX8a5shf-GVYqkMFC-o26vuyo26hMPpPCnuSD683A@mail.gmail.com>
Message-ID: <cf24ea0-92da-cd46-a7cd-87f5449016e8@google.com>
References: <b6c881-c352-bb91-85a8-febeb09dfd71@google.com> <CAD=HUj5NSXX8a5shf-GVYqkMFC-o26vuyo26hMPpPCnuSD683A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-436720276-1682302640=:4090"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-436720276-1682302640=:4090
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 24 Apr 2023, David Stevens wrote:
> On Sun, Apr 23, 2023 at 1:47=E2=80=AFPM Hugh Dickins <hughd@google.com> w=
rote:
> >
> > Inserting Ivan Orlov's syzbot fix commit 2ce0bdfebc74
> > ("mm: khugepaged: fix kernel BUG in hpage_collapse_scan_file()")
> > ahead of Jiaqi Yan's and David Stevens's commits
> > 12904d953364 ("mm/khugepaged: recover from poisoned file-backed memory"=
)
> > cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
> > ac492b9c70ca ("mm/khugepaged: skip shmem with userfaultfd")
> > (all of which restructure collapse_file()) did not work out well.
> >
> > xfstests generic/086 on huge tmpfs (with accelerated khugepaged) freeze=
s
> > (if not on the first attempt, then the 2nd or 3rd) in find_lock_entries=
()
> > while doing drop_caches: the file's xarray seems to have been corrupted=
,
> > with find_get_entry() returning nonsense which makes no progress.
> >
> > Bisection led to ac492b9c70ca; and diff against earlier working linux-n=
ext
> > suggested that it's probably down to an errant xas_store(), which does =
not
> > belong with the later changes (and nor does the positioning of warnings=
).
> > The later changes look as if they fix the syzbot issue independently.
> >
> > Remove most of what's left of 2ce0bdfebc74: just leave one WARN_ON_ONCE
> > (xas_error) after the final xas_store() of the multi-index entry.
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >
> >  mm/khugepaged.c | 23 +----------------------
> >  1 file changed, 1 insertion(+), 22 deletions(-)
> >
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1941,16 +1941,6 @@ static int collapse_file(struct mm_struct *mm, u=
nsigned long addr,
> >                                         result =3D SCAN_FAIL;
> >                                         goto xa_locked;
> >                                 }
> > -                               xas_store(&xas, hpage);
> > -                               if (xas_error(&xas)) {
> > -                                       /* revert shmem_charge performe=
d
> > -                                        * in the previous condition
> > -                                        */
> > -                                       mapping->nrpages--;
> > -                                       shmem_uncharge(mapping->host, 1=
);
> > -                                       result =3D SCAN_STORE_FAILED;
>=20
> With this being removed, SCAN_STORE_FAILED should also be removed from
> the scan_result enum and trace event definitions.

Only if we also remove your use of SCAN_STORE_FAILED in ac492b9c70ca:
what would you want that to say instead?

I don't care myself for any of those "SCAN" result codes, nor whether they
are few or many: I'd rather have __LINE__ numbers for my own debugging.

But if people want to remove SCAN_STORE_FAILED now, sure, send a patch;
my intent was to unbreak the breakage.

Hugh
---1463760895-436720276-1682302640=:4090--
