Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D266A478F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjB0RIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB0RI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:08:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700ECCDF9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:08:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id da10so28732887edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG2dCG5VjzwJXlSLZ64Dbgc8VngmhFVRh2OluQvog4s=;
        b=YGTBfrQFZkvkmE0fqI4ZuNrqfRLMOv1cg6pBWgKiFyztuGZkGGabgGss0CW0s7pa65
         iwG4pPftXbHk9bYUQuDdlu6qMuXpTsTW9jtvDvJTYBEiW9bET+bEvGRH2pdNMy0v1YRv
         m33lJiRluAMnuDx9J3qAtPCPlXSr1ypMzyIJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG2dCG5VjzwJXlSLZ64Dbgc8VngmhFVRh2OluQvog4s=;
        b=Sf3F5sYTacHysjlMnsxVtGT1eUpWRirRCe85OWQcUHIhDjXERYTXVngPHumffYPit8
         1s2ACkfPjFN7hSqJ4tEHBEhmKHa9OjPtFrCeFUSfroG5xskvxDIITOpyDqdGL0H1cRRQ
         6arycEIOaHDSefLajqVR+LBv7leT+cJSon6jxLOXmiWeIufi4BWfpjrwViaZ9OPOYDVr
         0cUkGf45V7G32dChWGEImE0Do0PPpGz7t3qSFY+8meC2Dbeu3sC5eHTIm4iSY+y4QTTG
         LEHzZrXEVSmN0H2RQEjDUuIqeneLZGPcA04c5tuNUspGwTLbpA+OlQfEp1TEY5IHYgJb
         nyWA==
X-Gm-Message-State: AO0yUKXFQFWnbTT7zVTP9xFsF9vfN/rOVlp3zGZCHuGpLwCQLj9qYuXA
        /ysuTiLnuCPH/TFFPoRBhaoGYQVV8pJM2iIWyXw=
X-Google-Smtp-Source: AK7set+IAcD4G3JWFT5dKIuosvnVunfu8t9VQAyCD7K1IGWPknRtecZJwEzrP/acLSVKmN8GWIHSjw==
X-Received: by 2002:a17:907:c706:b0:87f:5d0a:c610 with SMTP id ty6-20020a170907c70600b0087f5d0ac610mr37976050ejc.32.1677517704601;
        Mon, 27 Feb 2023 09:08:24 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id gg4-20020a170906e28400b008b1779ba3c1sm3439509ejb.115.2023.02.27.09.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 09:08:23 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id i34so28645702eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:08:23 -0800 (PST)
X-Received: by 2002:a17:906:1707:b0:8f1:4c6a:e72 with SMTP id
 c7-20020a170906170700b008f14c6a0e72mr6291052eje.0.1677517703498; Mon, 27 Feb
 2023 09:08:23 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
 <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com> <CAK7LNAR40OOCJhz2oNF4FXWeyF=MOQPwfojHCU=XZ0jHcuSP5g@mail.gmail.com>
In-Reply-To: <CAK7LNAR40OOCJhz2oNF4FXWeyF=MOQPwfojHCU=XZ0jHcuSP5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 09:08:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5AixGsLeT0qH2oZHKq0FLUTbyTw4qY921L=PwYgoGVw@mail.gmail.com>
Message-ID: <CAHk-=wh5AixGsLeT0qH2oZHKq0FLUTbyTw4qY921L=PwYgoGVw@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.3-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 2:10=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> If tar's --exclude-vcs-ignores option had worked correctly,
> I would not have written such a gitignore parser by myself.

But that thing is *WRONG*.

Seriously. It's fundamentally wrong.

The thing is, you don't even seem to understand how gitignores work.

A gitignore pattern doesn't actually mean "this path does not exist in the =
VCS".

It means "git will ignore this path for unknown files".

And that's a *big* difference.

That "for unknown files" means that *known* files can still match the patte=
rn.

And that is actually a perfectly valid pattern, and is very much by
design. You can say "ignore unknown *.o files", but still actually add
one explicitly to a git repository, if there is some special case.
There's nothing wrong with it.

But the way you have done things, it now is actively wrong.

We are *not* adding complexity for no good reason, particularly when
said complexity is fundamentally *broken*.

Yes, we export the kernel as a tar-file. But that's for people who
just don't want to deal with the full deal, and even that is partly
for legacy reasons that aren't necessarily all that true any more.

I suspect that by now, there are probably _more_ people used to git
than there are people who are still used to the "tar-files and
patches" workflow.

So here's the simple rule: if the packaging people can't be bothered
to use "gti archive" to make their packages, then they had better just
do a "make clean" first (or, better yet, do "git clean -dqfx" to
really clean up, because "make clean" isn't 100% reliable either).

We don't add more broken infrastructure to deal with broken workflows.
Just do the right thing.

Or if package managers want to do their own thing, then they can damn
well do it in their own broken systems, not adding a completely broken
script to the kernel.

                Linus
