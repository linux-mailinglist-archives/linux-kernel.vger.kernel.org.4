Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4420674358C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjF3HM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjF3HMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:12:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6FE61
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:12:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2546304e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688109161; x=1690701161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xT0h1VwJXuRJVl6b4ZcUHqCtxF2ZZq6HpEiCot5j2I=;
        b=hczRlo9GF1y8OYQx4hiNe3TCqWYA1xB9FDBv1rUBx3KymykGTZGCNdaZ93kQdIORmd
         Tic2z0GgJrmum/Q56ZUsu/zSe4hdDqfNl+4DJ3vApHdd20hXW+3HSzY1jWgPpGndVELI
         c/6JJoMQ+AAy2wjVuXJf95y1+unsB1BUC2xqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688109161; x=1690701161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xT0h1VwJXuRJVl6b4ZcUHqCtxF2ZZq6HpEiCot5j2I=;
        b=O9e2Z7HE+rWfaEDsjFHLikYZ0dnEzXztNNVI/L9BVOwRh4pdy0KrH3Q/DwfgRkbHoy
         37+XcD3gomT4JIj9VobZrUN6Fo1MGDVU7dEbJh3vtt2lzc4jUKNtjftxsmEGRtt6D/ty
         v/7DDRRFKYMOhSOfiDlQrCTCoXl8za3+UgyHiuWeRfb98Y6jJMpZIMf4P/QZ2CQp1M7j
         COT3rIpsYi6ppwPJx4+E0TnY6r+ijBvVUMRKYB8lIQujuDIgLFCfvlaLjdcwoInXfwO2
         b7IN9VkeIxqNxiO8aEmOFo/CfwZR8837Fn3hI21hZBnp4/g76xZ8CWh4mUT6b9a84gIw
         Lasg==
X-Gm-Message-State: ABy/qLZP1MLkTzlIrQO/EcIEtCkLheuQR5d4mq0BjqekchtfPsaakx/F
        V5b5++UiL+teg94BvaRSEoUKd/nCwEmTme1gAiirb6a5
X-Google-Smtp-Source: APBJJlG5De1H44zJxpFbAwI0dG1C2a+n94TM/iwIcbIXbN132yAznikqDpgNrbwip+HJcI7z3cvPwg==
X-Received: by 2002:ac2:4bca:0:b0:4f9:ec5e:d624 with SMTP id o10-20020ac24bca000000b004f9ec5ed624mr1453929lfq.38.1688109160706;
        Fri, 30 Jun 2023 00:12:40 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004f13cd61ebbsm2426699lff.175.2023.06.30.00.12.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 00:12:40 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b69f216c73so23441351fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:12:40 -0700 (PDT)
X-Received: by 2002:a2e:b6d0:0:b0:2b5:8a3f:4f5 with SMTP id
 m16-20020a2eb6d0000000b002b58a3f04f5mr1288895ljo.50.1688109159752; Fri, 30
 Jun 2023 00:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-pokal-puzzeln-5199c679b051@brauner> <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
 <20230630-testphasen-orangen-0e54486a267d@brauner>
In-Reply-To: <20230630-testphasen-orangen-0e54486a267d@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 00:12:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
Message-ID: <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
Subject: Re: [GIT PULL] pid: use flex array
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 23:51, Christian Brauner <brauner@kernel.org> wrote:
>
> I have no preference for either syntax. Both work. But this is probably
> more an objection to this being mixed in with the flex array change in
> the first place.

Yes. I looked at it, and tried to figure out if it was related
somehow, and decided that no, it can't possibly be, and must be just
an unrelated change.

> I did react to that in the original review here:
> https://lore.kernel.org/all/20230518-zuneigen-brombeeren-0a57cd32b1a7@brauner
> but then I grepped for it and saw it done in a few other places already

Yeah, we do end up growing new uses of 'use 0 as a pointer' almost as
quickly as we get rid of them.

We got rid of a couple just recently in commit dadeeffbe525 ("fbdev:
hitfb: Use NULL for pointers"), but yes, a quick

    git grep '\*)0\>'

shows many more.

And some of them are even ok. I don't think it's always wrong,
particularly if you then abstract it out.

So doing something like that

   #define PCI_IOBASE ((void __iomem *)0)

makes perfect sense. It's literally abstracting out something real (in
this case yes, it looks like a NULL pointer, but it's actually a
pointer with a strict type that just happens to have the value zero.

So that "NULL pointer with a type" concept makes sense, but it really
should be abstracted out, not be in the middle of some random code.

And that's *particularly* true when we already have the exact
abstraction for the situation that the code then uses (ie in this case
that "struct_size_t()" thing). Writing it out - in an ugly form -
using the disgusting traditional "constant integer zero can be cast to
any pointer" thing - just makes me go "Eugghhh!".

I mean, if this ugly part was just a small detail in a l;arger patch,
I probably would just have let it slide. It works. It is what it is.

But when three quarters of the patch was stuff I found questionable, I
just couldn't stomach it.

I'm looking at some of the grep hits, and I'm going "ok, that's a C++
programmer". I think there's a very real reason why so many of them
are in bpf code and in the bpf tests.

C++ made a *huge* fundamental design mistake early on wrt NULL, and a
generation of C++ programmers were poisoned by it and you had people
who swore until they were blue that 0 and NULL had to be the same
thing.

They were horribly and utterly wrong. But sometimes when it takes you
three decades to admit that you were wrong all that time, it's just
too painful to admit.

There are literally people who still can't admit to their mistake, and
refuse to use NULL, and use either 0 or 'nullptr'.

                  Linus
