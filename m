Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E26EF9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjDZSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjDZSWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:22:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F82383D7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:22:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24756a12ba0so5177988a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682533373; x=1685125373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9FxLmLHlRkoCNQhHTbkQ+E9KgQDXrVxF5ObRxT+GjA=;
        b=0cuenyEOY+RxD11vLq+OuM5ygj2A0QsYdEzL0nszm6O8oPserU7qoGjHKznhAdYDo7
         A+SfOI7KOjZGK7iOjkFRZypBOZkUOtoavZc4MjisWmFj0Zb8kVdAPJHaMOZ7QLYRGWs/
         u0slXqc/9Q/QXaH0B0SeooQ6j3SMI7pYNt8owWl8vO2WU4uxua3KN5EOdKAF0YeIz0OS
         syb1Cw4o18rVqdrPXUeI5u0V9i27pdsspf/z74vp7/E9TdHg5STxcuSeOQMH+kC0Wtmw
         imIC69F0wFQODMIYrmktc5yLe/ZQAwsRHPAC+3fPu4vnhpefJdVi/QpVr/ZBdzczDwpp
         pnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533373; x=1685125373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9FxLmLHlRkoCNQhHTbkQ+E9KgQDXrVxF5ObRxT+GjA=;
        b=OAYwLAVAjbwUyLHX3YbMpEF3azw5JuORERIfCh456AXsSzXRnANXLqP/giVa4uJ3xO
         8DbnUYmAbdiEcVvGDyUiBJafk/HqK5/Dims1m0TrY///kOAxnVxXNIu/KkuWUkc9T+c8
         lvv7CiYBug23oVZz/mU2kYRZ65fgvuBYdnmRU38WpdlbjXjDZIMZsogk0qfW7R8VJI4V
         PMhWN22f9eDeHF/hPPzpQTfqM79vfcBvE+AKKUZAvM3je5TOOOpqbFlTNbK9CVfQR18A
         eUy/CpmBm61N6f/qKD80disC4O0VHjZpB/mRljyTArqRppY044JVoyjW4B5Iy188i1+N
         GSCA==
X-Gm-Message-State: AAQBX9f7y/9T0keVZuiNQhii4oib5yDx14gpLWGW6jGJV58BWQIiRWCK
        FiPMwv3i/T78CzIN4adaFb3xVkTkGMWBMdmZ9MaC5g==
X-Google-Smtp-Source: AKy350YvKZyPFjklYrN45irnyd7dsdQe4L6I+xc0halUSTL62o6SdnJnoTDV0M4kqH0WtN4z0G9BxhqwGHcGjACQHTg=
X-Received: by 2002:a17:90a:9708:b0:22c:59c3:8694 with SMTP id
 x8-20020a17090a970800b0022c59c38694mr21920176pjo.44.1682533372604; Wed, 26
 Apr 2023 11:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com> <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Apr 2023 11:22:41 -0700
Message-ID: <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
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

On Wed, Apr 26, 2023 at 11:11=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 26, 2023 at 10:34=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > That's what clang's _Nonnull attribute does (with -Wnullability-extensi=
on).
>
> No, that's a warning about using it, not a warning about testing for
> NULL when it's there.
>
> I actually tested _Nonnull.  It seems to work for arguments. But it
> does not work for return values.

Ah, it does do something in the callee, not the caller:
https://godbolt.org/z/9dsPKGMWq

But I see your point; it would be nice to flag that the comparison
against NULL seems suspicious.

>
> Of course, maybe there's some other magic needed, but it does seem to
> be sadly not working for us.
>
> > But it's not toolchain portable, at the moment.  Would require changes
> > to clang to use the GNU C __attribute__ syntax, too (which I'm not
> > against adding support for).
>
> No need for using the __attribute__ syntax at all, that would _not_ be
> a show-stopper.

Ack.

>
> While it's true that it's the common syntax, and we sometimes use it
> explicitly because of that, it's by no means the only syntax, and we
> actually tend to try to have more legible wrappers around it.
>
> So, for example, we prefer using '__weak' instead of writing
> '__attribute__((__weak__))'.
>
> And no, it very much doesn't have to use __attibute__ at all. We
> already have things like
>
>     #define __diag(s)          _Pragma(__diag_str(GCC diagnostic s))
>
> so we already use other syntaxes.
>
> End result: if it actually worked, I'd happily do something like
>
>    #define __return_nonnull _Nonnull
>
> in <linux/compiler-clang.h>, with then <linux/compiler-gcc.h> then just h=
aving
>
>      #define __return_nonnull
>
> along with a big comment about how __attribute__((nonnull)) is
> horrible garbage that should never every be used.
>
>              Linus



--=20
Thanks,
~Nick Desaulniers
