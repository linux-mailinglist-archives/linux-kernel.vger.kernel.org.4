Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCB6EF992
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbjDZRoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjDZRoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:44:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A738E35A3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:44:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2470271d9f9so5207985a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682531045; x=1685123045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkGjo2+2375PCfjVY7hF/s90ur+eiDatH//mQnrGyYw=;
        b=f2sJj/rm0k1KK5yK8qzFmFUzb279bZdN0nIYZG6OD6iG4UNN2VQwb+cfdm4lkj7bJG
         XrRNVL9LYBWnA4ryeN1Zmk9j2n2cfykj+5MWvInqPF6YO/BHB49vuqmcFl0v/HTKVLV3
         f22BOrCkICsU95Eiv9+MWfLfLu9rhyjznyceZUABoMNIRrlLP88VLhP577fQ6hmVsjCG
         FXgcZNp/UHwbv2wRb3x3p0qUG0SGANQXmMxtp1331J/cPRqiaQ62Pdq0I/bZT4WWFqt5
         04jENzwN3OJBWkSTuB/bg3tXx0mobU6VLJ69w+oN5/xkysNjcnkioRNcKi3axedIlGSr
         v38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682531045; x=1685123045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkGjo2+2375PCfjVY7hF/s90ur+eiDatH//mQnrGyYw=;
        b=e2ku345suksgHLwY8+jEFt9ADc/MpMXUSWCjRJki2oj2lM97ZvNRCkkOTr6EFh0Thq
         2truXYGaukNas/oIp5C//QLKUJIsiBU1zIvEFG5oVlC3A+xMR+UhgJ0AvU1kiA5mAgmd
         xClldYKwjIJkDJnuCSo99vw54JpMBarq7VIkq8+cvToB8bDwUcfVo5t6XEhkkBGIzNeb
         ZJ4Vx2sUDFbN0uP9JuVk6+lDYCOF9RQ/ESLnFNuLf+u05pxmdwAupmjtrJrnO65uQMMJ
         3p9w9vW8zytHvBgU8gsxXB3uqNnQ8Luz28iTM6M/FENeSAhfMiNn2xJtXpZjiatOtmIb
         bBYg==
X-Gm-Message-State: AAQBX9etqMExV6L/P5jNm2rkzMLP40bWHTyHiH+l+KTspHKTi5wotF6T
        msL5EVAQH9ZV//qDJlcE+dyb2muVxp62MRzAX5+UZw==
X-Google-Smtp-Source: AKy350a3QijOLOYirVJQ+LPQGzUuYKBvcHvFq+4/6XCgjnCKVtQVpBuWtiW0KPRC0FCky+dux08Zt0QjvknG4kh0Lvo=
X-Received: by 2002:a17:90b:4a8b:b0:24b:b36f:8219 with SMTP id
 lp11-20020a17090b4a8b00b0024bb36f8219mr11315844pjb.13.1682531044886; Wed, 26
 Apr 2023 10:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com> <CAKwvOdmk5emVfUCMna8WoE46Ts6RCn=2O4DTT3Aw-YN9nSFHvw@mail.gmail.com>
In-Reply-To: <CAKwvOdmk5emVfUCMna8WoE46Ts6RCn=2O4DTT3Aw-YN9nSFHvw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Apr 2023 10:43:53 -0700
Message-ID: <CAKwvOdknyYkyrubWkgR75mqCGgGWjzN8XaRraN3XP8Mfu0Yy2A@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:36=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Apr 26, 2023 at 10:34=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Apr 26, 2023 at 10:03=E2=80=AFAM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Mon, Apr 24, 2023 at 9:18=E2=80=AFPM Theodore Ts'o <tytso@mit.edu>=
 wrote:
> > > >
> > > > Please note that after merging the mm and ext4 trees you will need =
to
> > > > apply the patch found here[1].
> > > >
> > > > [1] https://lore.kernel.org/r/20230419120923.3152939-1-willy@infrad=
ead.org
> > > >
> > > > This is due to a patch in the mm tree, "mm: return an ERR_PTR from
> > > > __filemap_get_folio" changing that function to returning an ERR_PTR
> > > > instead of returning NULL on an error.
> > >
> > > Side note, itr would be wonderful if we could mark the places that
> > > return an error pointer as returning "nonnull", and catch things like
> > > this automatically at build time where people compare an error pointe=
r
> > > to NULL.
> >
> > That's what clang's _Nonnull attribute does (with -Wnullability-extensi=
on).
> > https://godbolt.org/z/6jo1zbMd9
>
> Ah sorry, I _thought_ that's how _Nonnull worked on return types. Let
> me dig some more and see how that's supposed to work...

I guess this is how I'd have expected _Nonnull to work on return types.
https://godbolt.org/z/Yb7PdWv8q
I'll check with the team to see if there's interest in expanding this
check. Would be nice to have a GNU C __attribute__ syntax for this as
well, for eventual portability.
--=20
Thanks,
~Nick Desaulniers
