Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F16F202D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjD1Vkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjD1Vkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:40:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419426B9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:40:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f0dd117dcso40591466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682718031; x=1685310031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUzKFSvu7gqE2LOQ2ASIII1DpQpe5hDaoMDHqLiR2FU=;
        b=A0GGoiXYbYrTtmCNgZfBQ01fJqFC85hd8Uh+WZ9oX8tMsPx9wn9tAbHSF19ElNTYc6
         E/hAmWo767JX0IoERMZqylIO/qpg7ItxkxLL1+mII/jE498vmu6vosL7tC3dnHjIFkbz
         nws4fAIcQDfUN1+NmWCMqx6PGnYhlh5lAoyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682718031; x=1685310031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUzKFSvu7gqE2LOQ2ASIII1DpQpe5hDaoMDHqLiR2FU=;
        b=XBEcU0yWq0ARnUwVv7H2S7chiQWi6bAkYELUMyHNraaRFx02RoE1CAGuHlc5eN/gvl
         m9UBNaKS85E8zWrWP8nATk7am8fQktAOqzTn+Q6Fs7hbfBmIBX/RtKiZjqOYYoWPtCUr
         nYtZOJpADyiyY9frTrnLVLhDCnqHrod4xeUFTU8COpZyAz7aN7Kjf8i1i9z1yrUnmGS1
         JYt/XwzJuJRaFCOENQxU0k4d3aWKG7+9GOK5IX4NMwWdv8fuM8h8+mCEUONyej/OG4L3
         3krEMYCLQBdeI8omnXHbGSParvAYyadI4yEk2dTD3qAGpmE7iwnevnZViQML0RKtVSM6
         24HQ==
X-Gm-Message-State: AC+VfDyyAAGOsJe06z+AzqZh/3WPpXsqY40p6SaDRCcJFj5DX8QDXF8I
        8gr+0jpta3nYCro3y6d1QB+j3jfGUjoWulEsh78BDg==
X-Google-Smtp-Source: ACHHUZ6KXWm2YaQuMLdSI68Pb7Faq07BGxCMYH6tD0tGmuiOxzbV6lC97pXXaeszeSf+TXzYK5Yr7g==
X-Received: by 2002:a17:907:7291:b0:957:48c8:b081 with SMTP id dt17-20020a170907729100b0095748c8b081mr6747402ejc.24.1682718031425;
        Fri, 28 Apr 2023 14:40:31 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id h6-20020aa7c606000000b005068ea7f54dsm9643611edq.96.2023.04.28.14.40.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 14:40:30 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so294085a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:40:29 -0700 (PDT)
X-Received: by 2002:aa7:c1d3:0:b0:4fb:5089:6e01 with SMTP id
 d19-20020aa7c1d3000000b004fb50896e01mr253085edp.6.1682718029414; Fri, 28 Apr
 2023 14:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <Y/NmzouehvMWTPVZ@gmail.com> <ZErTyKxjGQvF6EqP@gmail.com>
In-Reply-To: <ZErTyKxjGQvF6EqP@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 14:40:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDTLgf8LhigR4XKnjgkuhsoS-pXZckXU79J-EXiOj7Vw@mail.gmail.com>
Message-ID: <CAHk-=wiDTLgf8LhigR4XKnjgkuhsoS-pXZckXU79J-EXiOj7Vw@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v6.4
To:     Ingo Molnar <mingo@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Thu, Apr 27, 2023 at 12:58=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>  - Add non-atomic __xchg() variant, use it in a couple of places

Guys, this is insane, and completely unacceptable.

I pulled this, but I'm going to unpull it, because the code is
actively wrong and ugly.

It not only randomly decides to re-use a name that has existing users
that now need to be fixed up.

It then *also* decides to start "preferring" this absolutely
disgusting new name over a much more legible one in the i915 driver,
which had this same functionality except it used a prettier name:

   fetch_and_zero()

But what then takes the cake for me is that this horribly ugly feature
then didn't even get that right, and only randomly converted *some* of
the users, with most of them remaining:

  git grep fetch_and_zero drivers/gpu/drm/i915/ | wc
     58     187    5534
  git grep -w __xchg drivers/gpu/drm/i915/ | wc
     22     109    1899

and it looks like the only "logic" to this is that the converted ones
were in the "gt/" subdirectory. What a random choice, but happily it
caused a trivial conflict, and as a result I noticed how bad things
were.

Anyway, I really find this all offensively ugly and pointless. I'm not
going to pull some "fixed" version of this. This needs to go away and
never come back.

What was so magically great about the name "__xchg" that it needed to
be taken over by this function? And why was that legibly named version
of it replaced so randomly?

The *whole* point of two underscores is to say "don't use this - it's
an internal implementation". That's the historical meaning, and it's
the meaning we have in the kernel too. Two underscores means "this is
special and doesn't do everything required" (it might need locking
around it, for example).

So then making a new interface with two underscores and thinking "we
should now make random drivers use this" is fundamentally bogus.

Look, just grep for "__xchg" in the main tree (ie the one *without*
this change). It all makes sense. It's all clearly an internal helper
- as marked by that double underscore - and it's not used by any
driver or filesystem code.

Exactly like K&R and God intended.

                  Linus
