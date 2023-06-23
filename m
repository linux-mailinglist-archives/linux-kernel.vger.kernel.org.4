Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279CC73BEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjFWTeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFWTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:34:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9192705
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:34:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51be5db4e35so1037036a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687548857; x=1690140857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1ZT5uDPau+Z6seT0VZfhVr+ahIhi7iWdRJoe/etFv4=;
        b=FsegaqWNkcFZNgjC6QvgsHELtV1MFOcfAZBNSE/k42Mv+ZFsm7smXygU1dZxO4Zu4L
         s1HBXGrF5XJDoo3vj8v/FxV8L4migIYEk27t++3VZPANQRe558yMx0EQ9UwqY38TdFnz
         Zdfc7VOth7L/AxAAMFyazdYdjukyQ3LNlOpqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687548857; x=1690140857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1ZT5uDPau+Z6seT0VZfhVr+ahIhi7iWdRJoe/etFv4=;
        b=DSX2OvVCkcXHDyDQWEvcRlR1agUif90tdFEQaHDGuYr3zEL63vMuSvLIzcb6USUKPn
         Cml/1b5dtK4xHmildPt24ZrWw7yy9Qt/VoHOlZQ7EmuTEK8x4U1UIHcAL+LRNJBTEFKZ
         o7hpjCUHB45UItYpT7iLmzeYdvBWXfqXVqNoGKmanHG40vItj4o6YGcdWL9hZMd9ZhqW
         RthGwfKsSoX4udLo+YCuWJ2vWA1ckJ4cEHZt5uYG9/HgaqaVJBVX/+hr8r5NWN5viwMa
         WUKmmZAuc+vjkXQiNnsGWQHXYs/MANmdpe50ldgJZuafsbhOxR6tKXlIYx3JwVY0pwG2
         QeMQ==
X-Gm-Message-State: AC+VfDzF5FjVlg0sRjG1fWpzRiaQ0/pGgMi6AduxeiWuHMicYtqburK4
        y/wdwIiAbAkoUM3NgaoQt9v23TpUwdthYuE+zAe0XA==
X-Google-Smtp-Source: ACHHUZ5F7yp7MoYj7ZVStBDMOjWhhFnvtE/tnMTRdBym3Qk0EUPemlUzpfsf59C6ak1XfEXgkGGGVw==
X-Received: by 2002:a17:907:320a:b0:965:d18b:f03a with SMTP id xg10-20020a170907320a00b00965d18bf03amr19858261ejb.58.1687548856730;
        Fri, 23 Jun 2023 12:34:16 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id n26-20020a1709065e1a00b0096f71ace804sm6286292eju.99.2023.06.23.12.34.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 12:34:15 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51bea30ccbcso1045709a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:34:15 -0700 (PDT)
X-Received: by 2002:aa7:d5c6:0:b0:51b:e803:83d4 with SMTP id
 d6-20020aa7d5c6000000b0051be80383d4mr4768055eds.21.1687548855130; Fri, 23 Jun
 2023 12:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com> <CAKwvOd=dUWWSzQEWdguhe3SjYTw7a76skx370DbU2Y+5o=M8BA@mail.gmail.com>
In-Reply-To: <CAKwvOd=dUWWSzQEWdguhe3SjYTw7a76skx370DbU2Y+5o=M8BA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 12:33:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsK5H=ejAfFaABzK5PCb3=wqarq+L5frcTjRJkON9S+Q@mail.gmail.com>
Message-ID: <CAHk-=wgsK5H=ejAfFaABzK5PCb3=wqarq+L5frcTjRJkON9S+Q@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 12:16, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> >
> > -       movabsq $137438953440, %rcx             # imm = 0x1FFFFFFFE0
> > -       andq    %rax, %rcx
> > -       movabsq $68719476704, %rdx              # imm = 0xFFFFFFFE0
> > -       cmpq    %rdx, %rcx
> > +       shrq    $5, %rax
> > +       cmpl    $2147483647, %eax               # imm = 0x7FFFFFFF
> >
> > in several places.
>
> Sorry, are those equivalent?  Before looks to me like:
>
> if (0xFFFFFFFE0 - (0x1FFFFFFFE0 & rax))
>
> and after
>
> if (0x7FFFFFFF - (rax >> 5))

I cut off some of the other changes, with the old (confused) code also doing

-       shrq    $5, %rax

later.

And yes, as far as I can tell, the comparisons are 100% equivalent.
Look at what happens when you shift that big mask down by 5..

> > My guess is that clang keeps an enum as an enum as long as possible -
> > including past some (really) simple simplification phases of the
> > optimizer.
>
> I don't think so.
> https://godbolt.org/z/M8746c49z
> That's LLVM IR as soon as it leaves the front end.

Hmm. I have

     clang version 15.0.7 (Fedora 15.0.7-2.fc37)

and you can probably check the code generation of the current kernel
with and without that patch.

It might depend on exact config file - I'll send you mine in a
separate email to not pollute the mailing list.

                Linus
