Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3325F6CB4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjC1DeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjC1Ddy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:33:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEE3AA3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:33:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so44089036edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679974398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oiHpee5kHvwy0kkwyghj/MrpTgzhWpQdX2GfZvSDVQ=;
        b=EHLXr98Ho4n7r+p8iRHxQsHE19FD6K4p+UA77Z6Fu6dypOk1hBNelRP9iWct4iMuTN
         4mSwsFjvLS9868eS3JoEG6UUwaN8L1oqlFrc1y/p40Rp4IaWW+iO0IbE9QjHux1fOk2k
         AB1fePiet+VlsLcFQj8fKMif9OFrFMaanZ05s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679974398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oiHpee5kHvwy0kkwyghj/MrpTgzhWpQdX2GfZvSDVQ=;
        b=inBCnr5cFGWQwhiqh3gSNP4pV37//YZftawnYIkHlwK+bIvQ7njek2hyhtjuokfjJE
         mEmIioyux9/hBUjQhHLlEwYvdCn0zAfVwFyYkJNsEx282YZ7jJTnsZSWuhcWbBnzfV6h
         UTyJ+RbymTMvxiodB9jR6ObqY4K8E0+mmDMMk11B07FV2im7oIQU8tDXjZpvZ2lQJtB6
         wrY1Zkha1PacL1qpEqht9Lb2VMwuszNgvOW3Cap67Clq589DYtDbRoyWfeopUor3eMa0
         YRmCtIGhAULkHQI767qhzbEuIBMDmwcgfnRMG8rXJclUFbZ6SBV5FzYi1HkhDCBYD+Xv
         dgRg==
X-Gm-Message-State: AAQBX9fAkj0AXvgn3X/CVi7hJ1qXDU9x01UhdRJLqY28Y8X+olKuehAC
        OxiTACdG0IMiYi2JpYBm6w1Sq4pNxIQP8K9PtTEvVw==
X-Google-Smtp-Source: AKy350btL0JQPghkkFpjUURQcX1thWJ3NgpqWKLHYa0Yo2bl5EOSUfmPQFcs2XTFQDwVJ/mB6/TYZQ==
X-Received: by 2002:a17:906:74c5:b0:944:a4a3:486a with SMTP id z5-20020a17090674c500b00944a4a3486amr7269488ejl.24.1679974397743;
        Mon, 27 Mar 2023 20:33:17 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm14819661ejk.114.2023.03.27.20.33.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 20:33:17 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id x3so44093167edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:33:17 -0700 (PDT)
X-Received: by 2002:a17:906:a86:b0:933:f6e8:26d9 with SMTP id
 y6-20020a1709060a8600b00933f6e826d9mr7176916ejf.15.1679974396517; Mon, 27 Mar
 2023 20:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <ZCJN0aaVPFouMkxp@localhost>
In-Reply-To: <ZCJN0aaVPFouMkxp@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Mar 2023 20:32:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLimhZ8px+BxTvkonBGHr9oFcjrk4tmE2-_mmd3vBGdg@mail.gmail.com>
Message-ID: <CAHk-=wgLimhZ8px+BxTvkonBGHr9oFcjrk4tmE2-_mmd3vBGdg@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 7:15=E2=80=AFPM Josh Triplett <josh@joshtriplett.or=
g> wrote:
>
> If there are no users of this and we can clean up the semantics, is
> there a strong reason *not* to make `O_DIRECTORY | O_CREATE` actually
> create a directory and atomically return a file descriptor for that
> directory? That seems like genuinely useful behavior that we don't
> currently have a syscall for. I didn't see any suggestion in the thread
> for reasons why we can't or shouldn't do that.

Absolutely not.

For one thing, it is clearly not "genuinely useful behavior". It's just stu=
pid.

Name a *single* real situation where that would be a big improvement?
Point to code, and point to a reason, and point to why it would make a
difference. No made-up hypotheticals.

If you want to open a directory, just do that

    fd =3D open(.., O_DIRECTORY);

and if that directory doesn't exist, and you still want to create it,
then just do

   mkdir(...);

on it. Done. And mkdir() is atomic, so there's no race there with
somebody else doing something else to that path.

And no, there is no race with a subsequent open of that mkdir case,
because you already know the result empty, so what would you do with
the fd you just got? Absolutely nothing. It's useless. Edwin Starr
sang a song all about it.

So there is *zero* real reasons for that "open a directory and create
it atomically". It's a nonsensical operation.

Ok, just to play along - maybe you can make it slightly less
nonsensical by throwing O_PATH into the mix, and now an empty
directory file descriptor at least has *some* use.

But even *if* you can point to such a thing being useful (and I'm
really doubtful), it would *still* be stupid.

Now your code would not only be specific to Linux, it would be
specific to some very new version of Linux, and do something
completely different on older versions.

Because those older versions will do random things, ranging from
"always return an error" to "create a regular file - not a directory -
and then return an error anyway" and finally "create a regular file -
not a directory - and return that resulting fd".

So no. We're not adding a *fourth* set of semantics to something that
is silly and useless to do in the first place, and that has already
had three existing semantics.

The reason it has had three different behaviors over the years is
*literally* that nobody has ever wanted to do it, and so the fact that
it has been broken for years hasn't even mattered.

Don't try to make that situation worse by then making up new pointless
meanings for it and try to come up with excuses why somebody would
want to do that operation.

                Linus
