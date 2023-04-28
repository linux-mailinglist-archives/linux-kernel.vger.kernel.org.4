Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0959F6F200A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbjD1VTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbjD1VTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:19:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF2C211C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:19:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94eff00bcdaso50144666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682716747; x=1685308747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61ueAZnI+VUsri6o/4rA392h46Og1UAC3oGSqW4xW/E=;
        b=GqN4m+5oDpAvN0PtaOsqULNsTSUSenPjy/O2JJIWrG1stZeQNQLkuJbbnUkn6/ef6I
         fEQ+TmDjjQCjzlCG0CSfMC8MPnUfzacTyvSvop4gjuciyB+S3hpEXPGGC6n1hQjbcW+J
         xMTIp/zt/bGRAk76AZSamtjwgm1xlqCNi+7AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682716747; x=1685308747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61ueAZnI+VUsri6o/4rA392h46Og1UAC3oGSqW4xW/E=;
        b=g25wUTAEDwrYoX37A41CSwthTkK0SBaekxdClrOt2kKIYCsX4Rv3a9ONL76pJTUGAm
         WfRSMPK8jSgil2dst8nsQVHhF+cfHRFDaBHN4HE1uDrHWZ2sATpiDE+NPLwRl+cS0QLW
         QKe5DJzkSSqDC4rf5sVKkAR3ohPXvnogN4YeIheoIZ/MlZKug8VwXDFHqr43PL+yNJmA
         8RCHgb4lbKsAMDlp3c1Ma5QlFwyKPLfQAClduu3nQnznHRE7E5g+cM0yIQas7gnPKww7
         Riqspb4yXwTVeW9qVmS0xsv1wF96lCbg+7a5d2lVxCOtUP5f141a0xMj/PHpl9/l3w3c
         4gtQ==
X-Gm-Message-State: AC+VfDz+yUIdH7OmnoBDc1mXcrQHRrcIBPySt3Fdz3dnpguruD9E0q6t
        hLQdHIbLS0AwnvdZ9dOfACi8bP0evEElRJdN6JiC3g==
X-Google-Smtp-Source: ACHHUZ7RlIlZK5CcOtXddq3XhPXvH5ZzT2VYVDup9uTh9yQXIrCSiSCgVKTKdsdDkOuSlQ1bSI+W7w==
X-Received: by 2002:a17:907:6d8c:b0:953:9899:d9c1 with SMTP id sb12-20020a1709076d8c00b009539899d9c1mr6329591ejc.1.1682716747344;
        Fri, 28 Apr 2023 14:19:07 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064bca00b0095334355a34sm11734926ejv.96.2023.04.28.14.19.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 14:19:06 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so279913a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:19:06 -0700 (PDT)
X-Received: by 2002:a05:6402:114c:b0:508:4808:b62b with SMTP id
 g12-20020a056402114c00b005084808b62bmr180566edw.22.1682716745923; Fri, 28 Apr
 2023 14:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
 <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
 <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
 <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
 <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com> <CAKwvOd=mgAMuMODXTapt8JRqEFLS1j-hfssZE0YjJNjPhH=H5A@mail.gmail.com>
In-Reply-To: <CAKwvOd=mgAMuMODXTapt8JRqEFLS1j-hfssZE0YjJNjPhH=H5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 14:18:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwMaS5=J7UgEPuoP_=01O9Ti62JVF-c=a6v3g2YAwzKQ@mail.gmail.com>
Message-ID: <CAHk-=wjwMaS5=J7UgEPuoP_=01O9Ti62JVF-c=a6v3g2YAwzKQ@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 2:03=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> >
> >    void *bar(void) {
> > #if CONFIG_XYZ
> >     if (somecondition) return NULL;
> > #endif
> >     return foo(); }
> >
> > and the caller really *should* check for NULL - it's just that the
> > compiler never saw that case.
>
> I think having a return value be conditionally _Nonnull is "garbage
> in; garbage out."

No, no, you misunderstand.

"foo()" is the one that is unconditionally _Nonnull. It never returns NULL.

But *bar()* is not. There's no _Nonnull about 'bar()'. Never was, never wil=
l be.

We are *not* looking to statically mark everything that never returns
NULL as _Nonnull. Only some core helper functions.

If "bar()" is a complicated function that can under some circumstances
return NULL, then it's clearly not _Nonnull.

It does not matter one whit that maybe in some simplified config,
bar() might never return NULL. That simply does *not* make it
_Nonnull.

But my point is that for a *compiler*, this is not actually easy at all.

Because a compiler might inline 'bar()' entirely (it's a trivial
function that only calls 'foo()', after all, so it *should* be
inlined.

But now that 'bar()' has been inlined into some other call-site, that
*other* call site will have a test for "is the result NULL?"

And that other call site *should* have that test. Because it didn't
call "foo()", it called "bar()".

But with the inlining, the compiler will likely see just the call to
foo(), and I suspect your patch would make it then complain about how
the result is tested for NULL.

So it would need to have that special logic of "only warn if the test
is at the same level".

> Thinking more about this, I really think _Nonnull should behave like a
> qualifier (const, restrict, volatile). So the above example would be:
>
> void * _Nonnull ptr =3D foo();
> if (!ptr) // warning: tautology

That would solve the problem, yes. But I suspect it would be very
inconvenient for users.

In particular, it would have made it totally pointless for the issue
at hand: finding *existing* users of  __filemap_get_folio() (that used
to return NULL for errors), and finding the cases where the NULL check
still exists now that it's no longer the right thign to do.

So I think it would largely defeat the use-case. It would only warn
for cases that have already been annotated.

So to be useful, I think it would have to be a "does automagically the
right thing" kind of feature.

                 Linus
