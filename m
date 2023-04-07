Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2A6DB494
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjDGTza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjDGTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:55:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E161B752
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:55:11 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y35so24954636pgl.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680897310; x=1683489310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRLvMBwRYgN9rZY0Zb0vSfDSDaMTw9OUufeYYmz/skw=;
        b=f6eYkrEter++NUKtxdaDLcQojieZL0r8jOl193HqrIPectcDZHEEPA9f34LkHDW4dP
         P53I9XvbApz+JAM6RyIEZmBddB+MR4UL6Y+75sl3sjuV+Mh0p8sSp8FRJVoy4bnn2QA9
         jPEYwxlaF9ooPwy+8HJoYrjt0LocOcCedEiJq/KY46LD17Q4GoG7cnevh+D8wxdzbVfY
         PLASeXnpdF6KyXWVwt+pMpLbMYosAlhCx24xg7zs8lPP9a5qQPE/uUll9ajaFEJOM6Ae
         yRHxhmMbIBvMqx2e04olr1L5CCWAQsjyzCyXRGaRC4G30bBEAXw3y46p3M3q6+GY1Rnx
         VquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897310; x=1683489310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRLvMBwRYgN9rZY0Zb0vSfDSDaMTw9OUufeYYmz/skw=;
        b=uOSaQrh0g/3hOb4Lv1P+eKTHkTgzdhPQ9Rg2VivaG35EDgDETz3TrIZ+UQfL9rQT7P
         WftEmeRUHT8vnrzvBcuh32I7TifauF7DmmNLABbAhtdVG7Wk/9iETDMsvHWjIpNGkq7N
         UP0o5BJMFOvFuRGnucG1Z0TaUiAjiP17sEBUvS5cum+cMmoakwfe53Qz8QsKYj0kHIxN
         RI0n6vWJ0JiI8IwAfJr4n+o/UxRgaATh5st2AwrHqfchlPAEBm1oHtfRp7kQpUy0Z9AB
         DSoXmC0L5K8QQnN0P11N1h5aNnOuRr36u7Xydt2OIJMP+Y0VuaPGiPHam8XPhyU5Xzdz
         ApKQ==
X-Gm-Message-State: AAQBX9fwHxYgMjiWR7L9lsHJn8U9hz0zb6hLfy1dokVXX42vsc+GdyqW
        5THHxcpJ+4qySqOI6kNKWdXmnbNZ/y3Edo0i+6pA+w==
X-Google-Smtp-Source: AKy350Zdn9kJpAE9Iql9IWBE7I7HcL96ooTIkSJ6p3oPGATAQjzlKAHto1RtQSOBZZ2ouYHs2x095vPSxO+sue+Ce+I=
X-Received: by 2002:a65:6201:0:b0:4fc:2058:fa29 with SMTP id
 d1-20020a656201000000b004fc2058fa29mr685882pgv.1.1680897309863; Fri, 07 Apr
 2023 12:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230401170117.1580840-1-masahiroy@kernel.org> <20230403144758.GA3460665@dev-arch.thelio-3990X>
In-Reply-To: <20230403144758.GA3460665@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 12:54:58 -0700
Message-ID: <CAKwvOd=3LoK7_qSijzk6Ww265LMDOk2-gQ-k9r0RwvENLi9JBA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: clang: do not use CROSS_COMPILE for target triple
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fangrui Song <maskray@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 7:48=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Sun, Apr 02, 2023 at 02:01:17AM +0900, Masahiro Yamada wrote:
> > The target triple is overridden by the user-supplied CROSS_COMPILE,
> > but I do not see a good reason to support it. Users can use a new
> > architecture without adding CLANG_TARGET_FLAGS_*, but that would be
> > a rare case.
> >
> > Use the hard-coded and deterministic target triple all the time.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I know of one bug where the value of '--target' matters:
>
> https://github.com/ClangBuiltLinux/linux/issues/1244
>
> This was fixed in LLVM 12.0.0. We are not testing this in our CI though,
> so we would not get bit by this (we could bump the minimum supported
> version of LLVM to 12.0.0 for this, we have talked recently about doing
> it for other reasons).
>
> I guess I cannot really think of a good reason not to do this aside from
> that; the target triple should only affect code generation, rather than
> tool selection (i.e., this does not take away the ability to use a
> custom set of binutils with clang).
>
> However, Nick is currently OOO and I would like his opinion voiced
> before we commit to this. Consider this a tentative:

Yeah, nothing I could think of; at this point CROSS_COMPILE is only
necessary for LLVM_IAS=3D0 builds and s390 (since LLD lacks s390
support) IIUC.

A user is more likely to adjust the --target for the host, which they
can do via USERCFLAGS or USERLDFLAGS, but not for the target.  I don't
think the gnu vs musl for the target triple makes a difference; we
might even be able to omit that part of the triple but I haven't
grepped through LLVM sources to see if that would result in
differences for codegen.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Acked-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >
> >  scripts/Makefile.clang | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 70b354fa1cb4..9076cc939e87 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -13,15 +13,11 @@ CLANG_TARGET_FLAGS_x86            :=3D x86_64-linux=
-gnu
> >  CLANG_TARGET_FLAGS_um                :=3D $(CLANG_TARGET_FLAGS_$(SUBAR=
CH))
> >  CLANG_TARGET_FLAGS           :=3D $(CLANG_TARGET_FLAGS_$(SRCARCH))
> >
> > -ifeq ($(CROSS_COMPILE),)
> >  ifeq ($(CLANG_TARGET_FLAGS),)
> > -$(error Specify CROSS_COMPILE or add '--target=3D' option to scripts/M=
akefile.clang)
> > +$(error add '--target=3D' option to scripts/Makefile.clang)
> >  else
> >  CLANG_FLAGS  +=3D --target=3D$(CLANG_TARGET_FLAGS)
> > -endif # CLANG_TARGET_FLAGS
> > -else
> > -CLANG_FLAGS  +=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> > -endif # CROSS_COMPILE
> > +endif
> >
> >  ifeq ($(LLVM_IAS),0)
> >  CLANG_FLAGS  +=3D -fno-integrated-as
> > --
> > 2.37.2
> >



--=20
Thanks,
~Nick Desaulniers
