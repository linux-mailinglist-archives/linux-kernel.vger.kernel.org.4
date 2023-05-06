Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7676F93EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEFUJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 16:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 16:09:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5901059D4
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 13:09:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f910ea993so472894366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683403766; x=1685995766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwRLCx9kSJiq/oBRkJ5x/MOv84iMNB8Ap5t+0Owv3hs=;
        b=M8/McN8qnWEdt7fNUEDKypfGRsll7Ebk+X+RfEiyJ1lH4qnYomB7O/oaKjtG2oViCm
         pNidoS9UX7Y7grbbG85A72puofXuJwqKzJzJkcs5iUSxucqk+KZWGN9/PfVA9JglgIvd
         sMM4jefIeEG8d1VVQLoZOsHAEa7eSAfxnK0uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683403766; x=1685995766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwRLCx9kSJiq/oBRkJ5x/MOv84iMNB8Ap5t+0Owv3hs=;
        b=loUW4xP+sWbs4CL5LlzZMOn0G8CwiPxL9dfBzpFUi1myw3DfmPq8q7V+fBgbuaOlS1
         7ATm5CqvAhVzFB5eh57V+LAGLvdtoakK/vw1gWWjcg5SC5pNxPCSE/R+DKq5FUPQ5fTO
         qWEpbi3XzQwn0EAgy8iTAjtNFfvZnplurwfg0Xs5r8Yye/IGKEGy0k6yw7CP5A1vJork
         x0S9zkAlEf7hW4tJcV6hHxPQ26rYmEST2Qz8XgCBH0w1ADTiln1LdQrB9X9PU7JNcrVS
         oVt43u7+YhKphixMj0SJbBocra0YDvhFtGQKXegZIrqkWhik+bTyhrAVTf00wyFz7s+L
         CDdQ==
X-Gm-Message-State: AC+VfDymzFwHZMgYPasRaUt23ELNa1sfBQrcoTdUnyVlzeqt9rjljBaJ
        iU0DMgOd2A+AVK2QBEcbxgKvZbXVFf1eHVa8+HZpvw==
X-Google-Smtp-Source: ACHHUZ6ZXoNCeEnSpDC/yhpH26BePrXCLv9bbuwFbmy9DMMfHBxl9p8EVAPSw03NkvZPPgUUGtJv3w==
X-Received: by 2002:a17:906:9750:b0:961:979d:a598 with SMTP id o16-20020a170906975000b00961979da598mr5932346ejy.23.1683403766367;
        Sat, 06 May 2023 13:09:26 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id gv23-20020a170906f11700b00965fdb90801sm1799518ejb.153.2023.05.06.13.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 13:09:24 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-965d2749e2eso361781166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 13:09:24 -0700 (PDT)
X-Received: by 2002:a17:907:7ea7:b0:965:57d0:9ca5 with SMTP id
 qb39-20020a1709077ea700b0096557d09ca5mr4814315ejc.51.1683403764379; Sat, 06
 May 2023 13:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 13:09:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
Message-ID: <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
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

On Sat, May 6, 2023 at 12:34=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I'm about a quarter in, haven't even gotten to the meat yet, and
> I've already found a bug.

Ok, so despite this I'm going a bit further, just to familiarize
myself with this even if I can't pull it.

And this is horrendous: pte_wrprotect() doing

    if (pte_dirty(pte))
        pte =3D pte_mksaveddirty(pte);

which actually has two fundamental problems:

 (a) it shouldn't be a conditional thing at all, it should just be bit
operations

 (b) "pte_dirty()" isn't even the right thing to use, since it
includes the SW dirty bit.

so what this *should* do is likely to just do

   pte.val |=3D (pte.val >> _PAGE_BIT_DIRTY) & 1) << _PAGE_BIT_SOFT_DIRTY;
   pte.val &=3D ~_PAGE_DIRTY;

which the compiler should be able to turn into a nice unconditional
series. Smaller than any conditional.

(You could simplify the above by just using fixed bit numbers - the
above is written with two shifts just to work with "any bit pair", but
obviously it could be written to be simpler and more straightforward
by just shifting the bit right into place)

I think the compilers may be able to do that all the simplification
for you even with a

    if (pte.val & _PAGE_DIRTY)
        pte.val |=3D _PAGE_SOFT_DIRTY;
    pte.val &=3D ~_PAGE_DIRTY;

but that is only true when there are *not* things like those
cpu_feature_enabled() tests in between those operations.

So I strongly suspect that all those

     if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))

around this area are only making things worse. You're replacing a
couple of simple bit operations with jump-arounds (and then doing the
bit operations anyway in one side). And you are limited the compiler
from doing obvious simplifications in the process.

Conditionals are really bad, even when they can be turned into static jumps=
.

As static jumps they just cause odd code flow, and lack of testing.
And compiler barriers.

All these bit operations are actually cheaper - and would get more
test coverage - if they are just done unconditionally with a couple of
shift-and-mask operations.

Now, my reaction here is

 - the whole shadow stack notion of "dirty but not writable is a magic
marker" is *DISGUSTING*. It's wrong.

   Whatever Intel designer that came up with that - instead of just
picking another bit for the *HARDWARE* to check - should be ashamed.

   Now we have to pick a software bit instead, and play games for
this. BAD BAD BAD.

   I'm assuming this is something where Microsoft went "we already
don't have that, and we want all the sw bits for sw, so do this". But
from a design standpoint it's just nasty.

 - But if we have to play those games, just *play* them. Do it all
unconditionally, and make the x86-64 rules be that "dirty but not
writable" is something we should never have.

   Having two different rules, and conditionals for them, is both more
complex for maintainers, *and* for compilers.

So just make that _PAGE_BIT_SOFT_DIRTY be unconditional, and let's
just live with it. But make the bit operations efficient.

Maybe I'm missing something, and the people who have been working on
this have a really good reason for this mess. But it really looks
horrible to me.

So maybe you can explain in small words why I'm wrong, but right now
my feeling is that not only did I find an arm bug in the series
(trivially fixed with a one-liner, but worrying, and triggered by the
series being done in a particularly fragile way).

But I also think there are some x86 things that are just not done the
way they should have been done.

But again: maybe I don't understand some of the problems.

                   Linus
